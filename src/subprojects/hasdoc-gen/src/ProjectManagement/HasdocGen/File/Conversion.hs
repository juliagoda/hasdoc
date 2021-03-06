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



module ProjectManagement.HasdocGen.File.Conversion
(
writeZimWikiFile,
writeFilePandocOptsT,
writeFilePandocOptsB,
loadWriterOtherOpts,
myDoc,
defDoc,
reqDoc,
archDoc,
techDoc,
testDoc,
convIntToCss,
settLangIntToStringShort,
writeChosenFormats
)
where
    
import ProjectManagement.HasdocGen.File.Settings 
import qualified Graphics.UI.WX as WX

import Data.Text (Text, unpack)
import qualified Data.ByteString.Lazy as B
import qualified Data.Text.IO as T
import System.IO.Unsafe
import Control.Exception
import Data.AppSettings

import System.Directory
import Text.Pandoc.Builder
import Text.Pandoc.Options
import Text.Pandoc.Writers.HTML
import Text.Pandoc.Class
import Text.Pandoc

import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data ConversionPandoc = ConversionPandoc

mkMessage "ConversionPandoc" (unsafePerformIO $ chooseTransPath) "en"
             

-- mappend from Monoid - joining of pandoc parts
-- http://hackage.haskell.org/package/pandoc-types-1.19/docs/Text-Pandoc-Builder.html#v:-60--62-
myDoc :: String -> Pandoc -> Pandoc -> Pandoc -> Pandoc -> Pandoc -> Pandoc
myDoc projectTitle defFiltered reqFiltered archFiltered techFiltered testFiltered = setTitle (text projectTitle) $ defFiltered <> reqFiltered <> archFiltered <> techFiltered <> testFiltered


loadWriterOtherOpts :: String -> IO WriterOptions                
loadWriterOtherOpts defTemp = 
    do 
        template <- runIOorExplode $ getDefaultTemplate defTemp
        let gg = Just template 
        return $ def { writerTOCDepth = 4, writerTableOfContents = False, writerTemplate = gg}



defDoc :: Maybe [(Int, String, String)] -> WriterOptions -> String -> Pandoc
defDoc Nothing wrOptions lang = setAuthors [""] $ doc $ para linebreak
--defDoc Just [] = str ""
defDoc (Just x) wrOptions lang = doc $ para linebreak <> divWith ("definitions", ["pages"], [("lang", lang)]) ((headerWith ("defPage", ["pages-headers"], [("lang", lang)]) 2 $ text $ (unsafePerformIO $ makeTranslator ConversionPandoc) $ MsgDefinitionTitle) <>
  docLoop (Just x) wrOptions lang)
  

reqDoc :: Maybe [(Int, String, String)] -> WriterOptions -> String -> Pandoc
reqDoc Nothing wrOptions lang = setAuthors [""] $ doc $ para linebreak
--reqDoc Just [] = str ""
reqDoc (Just x) wrOptions lang = doc $ para linebreak <> divWith ("requirements", ["pages"], [("lang", lang)]) ((headerWith ("reqPage", ["pages-headers"], [("lang", lang)]) 2 $ text $ (unsafePerformIO $ makeTranslator ConversionPandoc) $ MsgReqTitle) <>
  docLoop (Just x) wrOptions lang)
  
  
archDoc :: Maybe [(Int, String, String)] -> WriterOptions -> String -> Pandoc
archDoc Nothing wrOptions lang = setAuthors [""] $ doc $ para linebreak
--archDoc Just [] = str ""
archDoc (Just x) wrOptions lang = doc $ para linebreak <> divWith ("architecture", ["pages"], [("lang", lang)]) ((headerWith ("archPage", ["pages-headers"], [("lang", lang)]) 2 $ text $ (unsafePerformIO $ makeTranslator ConversionPandoc) $ MsgArchTitle) <>
  docLoop (Just x) wrOptions lang)
  
  
techDoc :: Maybe [(Int, String, String)] -> WriterOptions -> String -> Pandoc
techDoc Nothing wrOptions lang = setAuthors [""] $ doc $ para linebreak
--techDoc Just [] = str ""
techDoc (Just x) wrOptions lang = doc $ para linebreak <> divWith ("technology", ["pages"], [("lang", lang)]) ((headerWith ("techPage", ["pages-headers"], [("lang", lang)]) 2 $ text $ (unsafePerformIO $ makeTranslator ConversionPandoc) $ MsgTechnologyTitle) <>
  docLoop (Just x) wrOptions lang)
  
  
testDoc :: Maybe [(Int, String, String)] -> WriterOptions -> String -> Pandoc
testDoc Nothing wrOptions lang = setAuthors [""] $ doc $ para linebreak
--testDoc Just [] = str ""
testDoc (Just x) wrOptions lang = doc $ para linebreak <> divWith ("tests", ["pages"], [("lang", lang)]) ((headerWith ("testPage", ["pages-headers"], [("lang", lang)]) 2 $ text $ (unsafePerformIO $ makeTranslator ConversionPandoc) $ MsgTestsTitle) <>
  docLoop (Just x) wrOptions lang)
  
    
  
docLoop :: Maybe [(Int, String, String)] -> WriterOptions -> String -> Blocks  
docLoop (Just ((x,y,z):xs)) wrOptions lang = 
    para (spanWith ("question" ++ (show x), ["questions"], [("lang", lang)]) (text y) <>
    linebreak <>
    spanWith ((show x), ["answers"], [("lang", lang)]) (text z)) <>
    docLoop (Just xs) wrOptions lang
    
docLoop (Just []) wrOptions lang = para linebreak
docLoop Nothing wrOptions lang = para linebreak





writeChosenFormats :: Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> WX.TextCtrl () -> FilePath -> IO ()
writeChosenFormats defFiltered reqFiltered archFiltered techFiltered testFiltered projectEntry chosenDir = 
    do
        projectTitle <- WX.get projectEntry WX.text
        readTemp <- readTemplate
        let lang = ((settLangIntToStringShort . readTemp) languageSett)
        createDirectory (chosenDir ++ "/" ++ projectTitle)
                
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




writeZimWikiFile :: Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> String -> String -> FilePath -> IO ()
writeZimWikiFile defFiltered reqFiltered archFiltered techFiltered testFiltered projectTitle lang chosenDir =     
    do
        readTemp <- readTemplate 
        case readTemp zimWikiFormat of
             True -> do
                 let wrOptions = (def { writerTOCDepth = 4, writerTableOfContents = False})
                 rawZimWiki <- runIOorExplode $ writeZimWiki wrOptions $ myDoc projectTitle (defDoc defFiltered wrOptions lang) (reqDoc reqFiltered wrOptions lang) (archDoc archFiltered wrOptions lang) (techDoc techFiltered wrOptions lang) (testDoc testFiltered wrOptions lang)
                 T.writeFile (chosenDir ++ "/" ++ projectTitle ++ "/project.zim") rawZimWiki
             False -> return ()
             
   
            
writeFilePandocOptsT :: (WriterOptions -> Pandoc -> PandocIO Text) -> WriterOptions -> Pandoc -> Pandoc -> Pandoc -> Pandoc -> Pandoc -> String -> Setting Bool -> String -> FilePath -> IO ()
writeFilePandocOptsT func loadWriterOpts defFiltered reqFiltered archFiltered techFiltered testFiltered format sett projectTitle chosenDir =     
    do
        readTemp <- readTemplate 
        case readTemp sett of
             True -> do
                 rawFile <- runIOorExplode $ func loadWriterOpts $ myDoc projectTitle defFiltered reqFiltered archFiltered techFiltered testFiltered 
                 T.writeFile (chosenDir ++ "/" ++ projectTitle ++ "/project." ++ format) rawFile
             False -> return ()
             
             
             
writeFilePandocOptsB :: (WriterOptions -> Pandoc -> PandocIO B.ByteString) -> WriterOptions -> Pandoc -> Pandoc -> Pandoc -> Pandoc -> Pandoc -> String -> Setting Bool -> String -> FilePath -> IO ()
writeFilePandocOptsB func loadWriterOpts defFiltered reqFiltered archFiltered techFiltered testFiltered format sett projectTitle chosenDir =     
    do
        readTemp <- readTemplate 
        case readTemp sett of
             True -> do
                 rawFile <- runIOorExplode $ func loadWriterOpts $ myDoc projectTitle defFiltered reqFiltered archFiltered techFiltered testFiltered
                 B.writeFile (chosenDir ++ "/" ++ projectTitle ++ "/project." ++ format) rawFile
             False -> return ()
             
             
             
convIntToCss :: Int -> String
convIntToCss 0 = "default.css"
convIntToCss 1 = "blue.css"
convIntToCss 2 = "green.css"
convIntToCss 3 = "orange.css"
convIntToCss _ = "default.css"


settLangIntToStringShort :: Int -> String
settLangIntToStringShort 0 = "pl"
settLangIntToStringShort 1 = "en"
settLangIntToStringShort _ = "en"

