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

import Text.Blaze.Html

import qualified Data.Text.IO as T



myDoc :: Pandoc -> Pandoc -> Pandoc -> Pandoc -> Pandoc -> Pandoc
myDoc defFiltered reqFiltered archFiltered techFiltered testFiltered = defFiltered <> reqFiltered <> archFiltered <> techFiltered <> testFiltered
             
             
defDoc :: Maybe [(String, String)] -> Pandoc
defDoc Nothing = str ""
defDoc Just [x:xs] =
  setTitle "My title" $ doc $
  para "This is the first paragraph" <>
  para ("And " <> emph "another" <> ".") <>
  bulletList [ para "item one" <> para "continuation"
             , plain ("item two and a " <>
               link "/url" "go to url" "link")
             ]
             

reqDoc :: Maybe [(String, String)] -> Pandoc
reqDoc Nothing =
  setTitle "My title" $ doc $
  para "This is the first paragraph" <>
  para ("And " <> emph "another" <> ".") <>
  bulletList [ para "item one" <> para "continuation"
             , plain ("item two and a " <>
               link "/url" "go to url" "link")
             ]
             
             
archDoc :: Maybe [(String, String)] -> Pandoc
archDoc Nothing =
  setTitle "My title" $ doc $
  para "This is the first paragraph" <>
  para ("And " <> emph "another" <> ".") <>
  bulletList [ para "item one" <> para "continuation"
             , plain ("item two and a " <>
               link "/url" "go to url" "link")
             ]
             
             
techDoc :: Maybe [(String, String)] -> Pandoc
techDoc Nothing =
  setTitle "My title" $ doc $
  para "This is the first paragraph" <>
  para ("And " <> emph "another" <> ".") <>
  bulletList [ para "item one" <> para "continuation"
             , plain ("item two and a " <>
               link "/url" "go to url" "link")
             ]
             
             
testDoc :: Maybe [(String, String)] -> Pandoc
testDoc Nothing =
  setTitle "My title" $ doc $
  para "This is the first paragraph" <>
  para ("And " <> emph "another" <> ".") <>
  bulletList [ para "item one" <> para "continuation"
             , plain ("item two and a " <>
               link "/url" "go to url" "link")
             ]
 
 
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
