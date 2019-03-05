{-# LANGUAGE MultiParamTypeClasses
            ,FlexibleInstances
            ,FlexibleContexts
            ,TypeSynonymInstances
            ,UndecidableInstances
            ,ScopedTypeVariables
            ,TemplateHaskell
            ,OverloadedStrings #-}

            
module ProjectManagement.HasdocGen.File.HTML
(
writeChosenFormats,
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

--import Text.Blaze.Html
import qualified Data.Text.IO as T
import qualified Data.Text as TT 


-- the function stays here, because HTML is always generated and as first
writeChosenFormats :: Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> WX.TextCtrl () -> FilePath -> IO ()
writeChosenFormats defFiltered reqFiltered archFiltered techFiltered testFiltered projectEntry chosenDir = 
    do
        projectTitle <- WX.get projectEntry WX.text
        readTemp <- readTemplate
        let lang = ((settLangIntToString . readTemp) languageSett)
        createDirectory (chosenDir ++ "/" ++ projectTitle)
        
        writeHtml defFiltered reqFiltered archFiltered techFiltered testFiltered projectTitle lang chosenDir
        
        
        options <- loadWriterOtherOpts "docbook"
        writeFilePandocOptsT writeDocbook5 options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "dbk" docbookFormat projectTitle chosenDir
        
        writeZimWikiFile defFiltered reqFiltered archFiltered techFiltered testFiltered projectTitle lang chosenDir
        
        options <- loadWriterOtherOpts "tei"
        writeFilePandocOptsT writeTEI options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "tei" teiFormat projectTitle chosenDir
        
        options <- loadWriterOtherOpts "dokuwiki"
        writeFilePandocOptsT writeDokuWiki options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "dokuwiki" dokuWikiFormat projectTitle chosenDir
        
        options <- loadWriterOtherOpts "haddock"
        writeFilePandocOptsT writeHaddock options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "haddock" haddockFormat projectTitle chosenDir
        
        options <- loadWriterOtherOpts "latex"
        writeFilePandocOptsT writeLaTeX options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "tex" latexFormat projectTitle chosenDir
        
        options <- loadWriterOtherOpts "json"
        writeFilePandocOptsT writePlain options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "json" jsonFormat projectTitle chosenDir
        
        options <- loadWriterOtherOpts "markdown_phpextra"
        writeFilePandocOptsT writeMarkdown options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "php" phpMarkdownFormat projectTitle chosenDir
        
        options <- loadWriterOtherOpts "mediawiki"
        writeFilePandocOptsT writeMediaWiki options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "mediawiki" mediaWikiFormat projectTitle chosenDir
        
        options <- loadWriterOtherOpts "opendocument"
        writeFilePandocOptsT writeOpenDocument options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "sxw" openDocFormat projectTitle chosenDir
        
        options <- loadWriterOtherOpts "ipynb"
        writeFilePandocOptsT writeIpynb options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "ipynb" jupyterFormat projectTitle chosenDir
        
        options <- loadWriterOtherOpts "docx"
        writeFilePandocOptsB writeDocx options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "docx" docxFormat projectTitle chosenDir
        
        options <- loadWriterOtherOpts "epub"
        writeFilePandocOptsB writeEPUB3 options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "epub" epubv3Format projectTitle chosenDir
        
        options <- loadWriterOtherOpts "odt"
        writeFilePandocOptsB writeODT options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "odt" openOfficeFormat projectTitle chosenDir
        
        options <- loadWriterOtherOpts "pptx"
        writeFilePandocOptsB writePowerpoint options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "pptx" powerPointFormat projectTitle chosenDir
        
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
        options <- loadWriterPandocOpts
        rawPdf <- runIOorExplode $ makePDF "wkhtmltopdf" [] writeHtml5String options $ myDoc projectTitle (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang)
        case rawPdf of
             Left a -> putStrLn $ "Nastąpił błąd podczas tworzenia pliku Pdf"
             Right b -> B.writeFile (chosenDir ++ "/" ++ projectTitle ++ "/project.pdf") b
        
        
readHtmlFile :: FilePath -> IO ()
readHtmlFile filepath = 
    do
        htmld <- T.readFile filepath
        let tagsMap = iterateTags (parseTags htmld) []
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
             
-- writeGithubMarkdownFile :: Maybe [(String, String)] -> Maybe [(String, String)] -> Maybe [(String, String)] -> Maybe [(String, String)] -> Maybe [(String, String)] -> IO ()
-- writeGithubMarkdownFile defFiltered reqFiltered archFiltered techFiltered testFiltered =     
--     do
--         readTemp <- readTemplate 
--         case readTemp jupyterFormat of
--              True -> do
--                  options <- loadWriterOtherOpts "gfm"
--                  rawOdt <- runIOorExplode $ writeIpynb options $ myDoc (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) 
--                  T.writeFile "test.gfm" rawOdt
--              False -> return ()
             


