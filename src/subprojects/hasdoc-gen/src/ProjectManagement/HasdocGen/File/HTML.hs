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
thd
)
where
    
    

import ProjectManagement.HasdocGen.File.Settings    
import ProjectManagement.HasdocGen.File.Conversion
    
import qualified Graphics.UI.WX as WX

import Text.Pandoc.Builder
import Text.Pandoc.Options
import Text.Pandoc.Writers.HTML
import qualified Text.Pandoc.Readers.HTML as R
import Text.Pandoc.Class
import Text.Pandoc

import System.Directory

--import Text.Blaze.Html
import qualified Data.Text.IO as T


-- the function stays here, because HTML is always generated and as first
writeChosenFormats :: Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> WX.TextCtrl () -> IO ()
writeChosenFormats defFiltered reqFiltered archFiltered techFiltered testFiltered projectEntry = 
    do
        projectTitle <- WX.get projectEntry WX.text
        readTemp <- readTemplate
        let lang = ((settLangIntToString . readTemp) languageSett)
        createDirectory projectTitle
        writeHtml defFiltered reqFiltered archFiltered techFiltered testFiltered projectTitle lang
        
        options <- loadWriterOtherOpts "docbook"
        writeFilePandocOptsT writeDocbook5 options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "dbk" docbookFormat projectTitle
        
        writeZimWikiFile defFiltered reqFiltered archFiltered techFiltered testFiltered projectTitle lang
        
        options <- loadWriterOtherOpts "tei"
        writeFilePandocOptsT writeTEI options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "tei" teiFormat projectTitle
        
        options <- loadWriterOtherOpts "dokuwiki"
        writeFilePandocOptsT writeDokuWiki options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "dokuwiki" dokuWikiFormat projectTitle
        
        options <- loadWriterOtherOpts "haddock"
        writeFilePandocOptsT writeHaddock options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "haddock" haddockFormat projectTitle
        
        options <- loadWriterOtherOpts "latex"
        writeFilePandocOptsT writeLaTeX options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "tex" latexFormat projectTitle
        
        options <- loadWriterOtherOpts "json"
        writeFilePandocOptsT writePlain options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "json" jsonFormat projectTitle
        
        options <- loadWriterOtherOpts "markdown_phpextra"
        writeFilePandocOptsT writeMarkdown options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "php" phpMarkdownFormat projectTitle
        
        options <- loadWriterOtherOpts "mediawiki"
        writeFilePandocOptsT writeMediaWiki options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "mediawiki" mediaWikiFormat projectTitle
        
        options <- loadWriterOtherOpts "opendocument"
        writeFilePandocOptsT writeOpenDocument options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "sxw" openDocFormat projectTitle
        
        options <- loadWriterOtherOpts "ipynb"
        writeFilePandocOptsT writeIpynb options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "ipynb" jupyterFormat projectTitle
        
        options <- loadWriterOtherOpts "docx"
        writeFilePandocOptsB writeDocx options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "docx" docxFormat projectTitle
        
        options <- loadWriterOtherOpts "epub"
        writeFilePandocOptsB writeEPUB3 options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "epub" epubv3Format projectTitle
        
        options <- loadWriterOtherOpts "odt"
        writeFilePandocOptsB writeODT options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "odt" openOfficeFormat projectTitle
        
        options <- loadWriterOtherOpts "pptx"
        writeFilePandocOptsB writePowerpoint options (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang) "pptx" powerPointFormat projectTitle
        
        

 
writeHtml :: Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> String -> String -> IO ()
writeHtml defFiltered reqFiltered archFiltered techFiltered testFiltered projectTitle lang = 
    do
        options <- loadWriterPandocOpts
        rawHtml <- runIOorExplode $ writeHtml5String options $ myDoc projectTitle (defDoc defFiltered options lang) (reqDoc reqFiltered options lang) (archDoc archFiltered options lang) (techDoc techFiltered options lang) (testDoc testFiltered options lang)
        T.writeFile (projectTitle ++ "/project.html") rawHtml

        
readHtml :: IO Pandoc
readHtml = 
    do
        htmld <- T.readFile "project.html"
        options <- loadReaderPandocOpts
        runIOorExplode $ R.readHtml options htmld
        
        
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
             


