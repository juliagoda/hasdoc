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
writeHtml
)
where
    
    

import ProjectManagement.HasdocGen.File.Settings    
    
import Text.Pandoc.Builder
import Text.Pandoc.Options
import Text.Pandoc.Writers.HTML
import qualified Text.Pandoc.Readers.HTML as R
import Text.Pandoc.Class
import Text.Pandoc

--import Text.Blaze.Html

import qualified Data.Text.IO as T


-- mappend from Monoid - joining of pandoc parts
-- http://hackage.haskell.org/package/pandoc-types-1.19/docs/Text-Pandoc-Builder.html#v:-60--62-
myDoc :: Pandoc -> Pandoc -> Pandoc -> Pandoc -> Pandoc -> Pandoc
myDoc defFiltered reqFiltered archFiltered techFiltered testFiltered = setTitle "Project" $ defFiltered <> reqFiltered <> archFiltered <> techFiltered <> testFiltered
             
             
defDoc :: Maybe [(String, String)] -> Pandoc
defDoc Nothing = setAuthors [""] $ doc $ para linebreak
--defDoc Just [] = str ""
defDoc (Just x) = doc $ para linebreak <> para (strong "Definitions") <>
  docLoop (Just x)
  
  
reqDoc :: Maybe [(String, String)] -> Pandoc
reqDoc Nothing = setAuthors [""] $ doc $ para linebreak
--reqDoc Just [] = str ""
reqDoc (Just x) = doc $ para linebreak <> para (strong "Requirements") <>
  docLoop (Just x)
  
  
archDoc :: Maybe [(String, String)] -> Pandoc
archDoc Nothing = setAuthors [""] $ doc $ para linebreak
--archDoc Just [] = str ""
archDoc (Just x) = doc $ para linebreak <> para (strong "Architecture") <>
  docLoop (Just x)
  
  
techDoc :: Maybe [(String, String)] -> Pandoc
techDoc Nothing = setAuthors [""] $ doc $ para linebreak
--techDoc Just [] = str ""
techDoc (Just x) = doc $ para linebreak <> para (strong "Technology") <>
  docLoop (Just x)
  
  
testDoc :: Maybe [(String, String)] -> Pandoc
testDoc Nothing = setAuthors [""] $ doc $ para linebreak
--testDoc Just [] = str ""
testDoc (Just x) = doc $ para linebreak <> para (strong "Tests") <>
  docLoop (Just x)
  
  
docLoop :: Maybe [(String, String)] -> Blocks  
docLoop (Just ((x,y):xs)) = 
    para (emph (text x)) <>
    para (text y) <> 
    docLoop (Just xs)
    
docLoop (Just []) = para linebreak
docLoop Nothing = para linebreak
                  

 
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


-- helper :: PandocMonad m => m TI.Text
-- helper = 
--     do 
--         
--         writeHtml5String options myDoc
        
        
loadWriterPandocOpts :: IO WriterOptions                
loadWriterPandocOpts = 
    do 
       -- t <- readFile "ccc.html"
       -- let gg = Just t
        template <- runIOorExplode $ getDefaultTemplate "html" 
        readTemp <- readTemplate 
        let gg = Just template
        return $ def { writerTOCDepth = 4, writerTableOfContents = True, writerTemplate = gg, writerVariables = [("css", getAppCssPath ++ "/" ++ ((convIntToCss . readTemp) templateName)), ("header-includes", "<style>p { background-color: magenta; }</style>")] } 
        
        
loadReaderPandocOpts :: IO ReaderOptions                
loadReaderPandocOpts = return $ def { readerStripComments = True, readerStandalone = True } 
    

convIntToCss :: Int -> String
convIntToCss 0 = "default.css"
convIntToCss 1 = "blue.css"
convIntToCss 2 = "green.css"
convIntToCss 3 = "orange.css"
convIntToCss _ = "default.css"
