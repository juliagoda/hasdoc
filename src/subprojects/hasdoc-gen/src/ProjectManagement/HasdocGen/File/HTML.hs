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
    
import Text.Pandoc.Builder
import Text.Pandoc.Options
import Text.Pandoc.Writers.HTML
import qualified Text.Pandoc.Readers.HTML as R
import Text.Pandoc.Class
import Text.Pandoc

--import Text.Blaze.Html
import qualified Data.Text.IO as T


-- the function stays here, because HTML is always generated and as first
writeChosenFormats :: Maybe [(String, String)] -> Maybe [(String, String)] -> Maybe [(String, String)] -> Maybe [(String, String)] -> Maybe [(String, String)] -> IO ()
writeChosenFormats defFiltered reqFiltered archFiltered techFiltered testFiltered = 
    do
        writeHtml defFiltered reqFiltered archFiltered techFiltered testFiltered
        
        options <- loadWriterOtherOpts "docbook"
        writeFilePandocOptsT writeDocbook5 options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "dbk" docbookFormat
        
        writeZimWikiFile defFiltered reqFiltered archFiltered techFiltered testFiltered
        
        options <- loadWriterOtherOpts "tei"
        writeFilePandocOptsT writeTEI options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "tei" teiFormat
        
        options <- loadWriterOtherOpts "dokuwiki"
        writeFilePandocOptsT writeDokuWiki options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "dokuwiki" dokuWikiFormat
        
        options <- loadWriterOtherOpts "haddock"
        writeFilePandocOptsT writeHaddock options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "haddock" haddockFormat
        
        options <- loadWriterOtherOpts "latex"
        writeFilePandocOptsT writeLaTeX options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "tex" latexFormat
        
        options <- loadWriterOtherOpts "json"
        writeFilePandocOptsT writePlain options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "json" jsonFormat
        
        options <- loadWriterOtherOpts "markdown_phpextra"
        writeFilePandocOptsT writeMarkdown options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "php" phpMarkdownFormat
        
        options <- loadWriterOtherOpts "mediawiki"
        writeFilePandocOptsT writeMediaWiki options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "mediawiki" mediaWikiFormat
        
        options <- loadWriterOtherOpts "opendocument"
        writeFilePandocOptsT writeOpenDocument options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "sxw" openDocFormat
        
        options <- loadWriterOtherOpts "ipynb"
        writeFilePandocOptsT writeIpynb options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "ipynb" jupyterFormat
        
        options <- loadWriterOtherOpts "docx"
        writeFilePandocOptsB writeDocx options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "docx" docxFormat
        
        options <- loadWriterOtherOpts "epub"
        writeFilePandocOptsB writeEPUB3 options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "epub" epubv3Format
        
        options <- loadWriterOtherOpts "odt"
        writeFilePandocOptsB writeODT options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "odt" openOfficeFormat
        
        options <- loadWriterOtherOpts "pptx"
        writeFilePandocOptsB writePowerpoint options (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered) "pptx" powerPointFormat
        
        

 
writeHtml :: Maybe [(String, String)] -> Maybe [(String, String)] -> Maybe [(String, String)] -> Maybe [(String, String)] -> Maybe [(String, String)] -> IO ()
writeHtml defFiltered reqFiltered archFiltered techFiltered testFiltered = 
    do
        options <- loadWriterPandocOpts
        rawHtml <- runIOorExplode $ writeHtml5String options $ myDoc (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered)
        T.writeFile "test.html" rawHtml

        
readHtml :: IO Pandoc
readHtml = 
    do
        htmld <- T.readFile "test.html"
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
             


