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
writeChosenFormats
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
writeChosenFormats :: Maybe [(String, String)] -> Maybe [(String, String)] -> Maybe [(String, String)] -> Maybe [(String, String)] -> Maybe [(String, String)] -> WX.TextCtrl () -> IO ()
writeChosenFormats defFiltered reqFiltered archFiltered techFiltered testFiltered projectEntry = 
    do
        projectTitle <- WX.get projectEntry WX.text
        createDirectory projectTitle
        writeHtml defFiltered reqFiltered archFiltered techFiltered testFiltered projectTitle
        
        options <- loadWriterOtherOpts "docbook"
        writeFilePandocOptsT writeDocbook5 options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "dbk" docbookFormat projectTitle
        
        writeZimWikiFile defFiltered reqFiltered archFiltered techFiltered testFiltered projectTitle
        
        options <- loadWriterOtherOpts "tei"
        writeFilePandocOptsT writeTEI options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "tei" teiFormat projectTitle
        
        options <- loadWriterOtherOpts "dokuwiki"
        writeFilePandocOptsT writeDokuWiki options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "dokuwiki" dokuWikiFormat projectTitle
        
        options <- loadWriterOtherOpts "haddock"
        writeFilePandocOptsT writeHaddock options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "haddock" haddockFormat projectTitle
        
        options <- loadWriterOtherOpts "latex"
        writeFilePandocOptsT writeLaTeX options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "tex" latexFormat projectTitle
        
        options <- loadWriterOtherOpts "json"
        writeFilePandocOptsT writePlain options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "json" jsonFormat projectTitle
        
        options <- loadWriterOtherOpts "markdown_phpextra"
        writeFilePandocOptsT writeMarkdown options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "php" phpMarkdownFormat projectTitle
        
        options <- loadWriterOtherOpts "mediawiki"
        writeFilePandocOptsT writeMediaWiki options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "mediawiki" mediaWikiFormat projectTitle
        
        options <- loadWriterOtherOpts "opendocument"
        writeFilePandocOptsT writeOpenDocument options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "sxw" openDocFormat projectTitle
        
        options <- loadWriterOtherOpts "ipynb"
        writeFilePandocOptsT writeIpynb options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "ipynb" jupyterFormat projectTitle
        
        options <- loadWriterOtherOpts "docx"
        writeFilePandocOptsB writeDocx options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "docx" docxFormat projectTitle
        
        options <- loadWriterOtherOpts "epub"
        writeFilePandocOptsB writeEPUB3 options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "epub" epubv3Format projectTitle
        
        options <- loadWriterOtherOpts "odt"
        writeFilePandocOptsB writeODT options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "odt" openOfficeFormat projectTitle
        
        options <- loadWriterOtherOpts "pptx"
        writeFilePandocOptsB writePowerpoint options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "pptx" powerPointFormat projectTitle
        
        

 
writeHtml :: Maybe [(String, String)] -> Maybe [(String, String)] -> Maybe [(String, String)] -> Maybe [(String, String)] -> Maybe [(String, String)] -> String -> IO ()
writeHtml defFiltered reqFiltered archFiltered techFiltered testFiltered projectTitle = 
    do
        options <- loadWriterPandocOpts
        rawHtml <- runIOorExplode $ writeHtml5String options $ myDoc projectTitle (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered)
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
             


