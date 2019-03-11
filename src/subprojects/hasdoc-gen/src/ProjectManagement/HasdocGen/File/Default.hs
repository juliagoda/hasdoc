{-# LANGUAGE MultiParamTypeClasses
            ,FlexibleInstances
            ,FlexibleContexts
            ,TypeSynonymInstances
            ,UndecidableInstances
            ,ScopedTypeVariables
            ,TemplateHaskell
            ,OverloadedStrings
            ,DeriveGeneric
            ,AllowAmbiguousTypes
            ,MonoLocalBinds #-}

            
module ProjectManagement.HasdocGen.File.Default
(
writeDefaultFormats,
thd,
readHtmlFile
)
where
    

import ProjectManagement.HasdocGen.File.Settings    
import ProjectManagement.HasdocGen.File.Conversion
    
import qualified Graphics.UI.WX as WX

import Text.Pandoc.Builder
import Text.Pandoc.Options
import Text.Pandoc.Writers.HTML
import qualified Text.Pandoc.Readers.HTML as R
import qualified Data.ByteString.Lazy as B
import qualified Data.HashMap.Strict as H
import Text.Pandoc.Class
import Text.Pandoc
import Text.Pandoc.PDF

import System.Directory
import Text.HTML.TagSoup
import Text.StringLike
import Text.Read (readMaybe)
import Data.Ini
import System.IO.Unsafe

import qualified Data.Text.IO as T
import qualified Data.Text as TT 
    
import Data.AppSettings
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data HTMLfile = HTMLfile

mkMessage "HTMLfile" (unsafePerformIO $ chooseTransPath) "en"



makeTranslator :: (RenderMessage HTMLfile HTMLfileMessage) => IO (HTMLfileMessage -> String)
makeTranslator = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    return (\message -> TT.unpack $ renderMsg HTMLfile (settLangIntToString $ getSetting' conf languageSett) message)

    
writeDefaultFormats :: Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> WX.TextCtrl () -> FilePath -> IO ()
writeDefaultFormats defFiltered reqFiltered archFiltered techFiltered testFiltered projectEntry chosenDir = 
    do
        projectTitle <- WX.get projectEntry WX.text
        readTemp <- readTemplate
        let lang = ((settLangIntToStringShort . readTemp) languageSett)
        createDirectory (chosenDir ++ "/" ++ projectTitle)
        
        writeHtml defFiltered reqFiltered archFiltered techFiltered testFiltered projectTitle lang chosenDir
        
        writePDFile defFiltered reqFiltered archFiltered techFiltered testFiltered projectTitle lang chosenDir

   
        
writeHtml :: Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> String -> String -> FilePath -> IO ()
writeHtml defFiltered reqFiltered archFiltered techFiltered testFiltered projectTitle lang chosenDir = 
    do
        options <- loadWriterPandocOpts
        rawHtml <- runIOorExplode $ writeHtml5String options $ myDoc projectTitle (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang)
        T.writeFile (chosenDir ++ "/" ++ projectTitle ++ "/project.html") rawHtml
        
        
-- as first whhtmltopdf is needed - find and install it on your system
-- without installed wkhtmltopdf appears error: hasdoc: wkhtmltopdf: createProcess: runInteractiveProcess: exec: invalid argument (Bad file descriptor) - but it doesn't crash application
writePDFile :: Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> String -> String -> FilePath -> IO ()
writePDFile defFiltered reqFiltered archFiltered techFiltered testFiltered projectTitle lang chosenDir = 
    do
        translate <- makeTranslator
        options <- loadWriterPandocOpts
        rawPdf <- runIOorExplode $ makePDF "wkhtmltopdf" [] writeHtml5String options $ myDoc projectTitle (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang)
        case rawPdf of
             Left a -> putStrLn $ (translate MsgCreatedPdfError)
             Right b -> B.writeFile (chosenDir ++ "/" ++ projectTitle ++ "/project.pdf") b
        
        
readHtmlFile :: WX.Frame () -> FilePath -> IO ()
readHtmlFile mainWindow filepath = 
    do
        translate <- makeTranslator
        htmld <- T.readFile filepath
        let tagsMap = iterateTags (parseTags htmld) []
        if null tagsMap 
           then WX.infoDialog mainWindow (translate MsgWarningProject) (translate MsgNoHTMLParsedTags) 
           else do 
               let hhash = H.fromList [(TT.pack "Answers", tagsMap)] 
               home <- getHomeDirectory
               createDirectoryIfMissing True (home ++ "/.hasdoc-gen/temp")
               writeIniFile (home ++ "/.hasdoc-gen/temp/temp.hdoc") (Ini {iniGlobals=mempty, iniSections=hhash})
        
        
         
 
iterateTags :: [Tag TT.Text] -> [(TT.Text, TT.Text)] -> [(TT.Text, TT.Text)]
iterateTags (x:y:z:xs) outputL = case isTagOpen x && isTagText y of
                              True -> if TT.null (getTagOpenId x) then iterateTags (y:z:xs) outputL else iterateTags (xs) (((,) (getTagOpenId x) (fromTagText y)) : outputL)
                              False -> iterateTags (y:z:xs) outputL
                              
iterateTags (x:y:z) outputL = case isTagOpen x && isTagText y of
                                   True -> if TT.null (getTagOpenId x) then iterateTags [] outputL else iterateTags [] (((,) (getTagOpenId x) (fromTagText y)) : outputL)
                                   False -> iterateTags [] outputL
iterateTags [] outputL = outputL


getTagOpenId :: Tag TT.Text -> TT.Text
getTagOpenId (TagOpen "span" atts) = case ifIdentIsInt (readMaybe (TT.unpack (fromAttrib "id" (TagOpen "span" atts))) :: Maybe Int) of
                                        True -> fromAttrib "id" (TagOpen "span" atts)
                                        False -> ""
getTagOpenId (TagOpen _ _) = ""
getTagOpenId _ = ""


-- https://alvinalexander.com/source-code/haskell/safe-string-to-int-conversion-in-haskell-example        
ifIdentIsInt :: Maybe Int -> Bool
ifIdentIsInt Nothing = False
ifIdentIsInt (Just a) = if a < 215 then True else False
        
        
loadWriterPandocOpts :: IO WriterOptions                
loadWriterPandocOpts = 
    do 
        template <- runIOorExplode $ getDefaultTemplate "html" 
        readTemp <- readTemplate 
        let gg = Just template
        return $ def { writerTOCDepth = 4, writerTableOfContents = True, writerTemplate = gg, writerVariables = [("css", getAppCssPath ++ "/" ++ ((convIntToCss . readTemp) templateName))]} --("header-includes", "<style>p { background-color: magenta; }</style>")] } 
                
        
loadReaderPandocOpts :: IO ReaderOptions                
loadReaderPandocOpts = return $ def { readerStripComments = True, readerStandalone = True } 

  
thd :: (a, b, c) -> c
thd (_,_,z) = z
             
