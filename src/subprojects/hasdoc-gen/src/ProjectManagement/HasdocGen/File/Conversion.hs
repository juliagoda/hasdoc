{-# LANGUAGE MultiParamTypeClasses
            ,FlexibleInstances
            ,FlexibleContexts
            ,TypeSynonymInstances
            ,UndecidableInstances
            ,ScopedTypeVariables
            ,TemplateHaskell
            ,OverloadedStrings #-}



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
convIntToCss
)
where
    
import ProjectManagement.HasdocGen.File.Settings 

import Data.Text (Text)
import qualified Data.ByteString.Lazy as B
import qualified Data.Text.IO as T

import Data.AppSettings

import Text.Pandoc.Builder
import Text.Pandoc.Options
import Text.Pandoc.Writers.HTML
import Text.Pandoc.Class
import Text.Pandoc



-- mappend from Monoid - joining of pandoc parts
-- http://hackage.haskell.org/package/pandoc-types-1.19/docs/Text-Pandoc-Builder.html#v:-60--62-
myDoc :: Pandoc -> Pandoc -> Pandoc -> Pandoc -> Pandoc -> Pandoc
myDoc defFiltered reqFiltered archFiltered techFiltered testFiltered = setTitle "Project" $ defFiltered <> reqFiltered <> archFiltered <> techFiltered <> testFiltered


loadWriterOtherOpts :: String -> IO WriterOptions                
loadWriterOtherOpts defTemp = 
    do 
        template <- runIOorExplode $ getDefaultTemplate defTemp
        let gg = Just template 
        return $ def { writerTOCDepth = 4, writerTableOfContents = False, writerTemplate = gg}



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




writeZimWikiFile :: Maybe [(String, String)] -> Maybe [(String, String)] -> Maybe [(String, String)] -> Maybe [(String, String)] -> Maybe [(String, String)] -> IO ()
writeZimWikiFile defFiltered reqFiltered archFiltered techFiltered testFiltered =     
    do
        readTemp <- readTemplate 
        case readTemp zimWikiFormat of
             True -> do
                 rawZimWiki <- runIOorExplode $ writeZimWiki (def { writerTOCDepth = 4, writerTableOfContents = False}) $ myDoc (defDoc defFiltered) (reqDoc reqFiltered) (archDoc archFiltered) (techDoc techFiltered) (testDoc testFiltered)
                 T.writeFile "project.zim" rawZimWiki
             False -> return ()
             
   
            
writeFilePandocOptsT :: (WriterOptions -> Pandoc -> PandocIO Text) -> WriterOptions -> Pandoc -> Pandoc -> Pandoc -> Pandoc -> Pandoc -> String -> Setting Bool -> IO ()
writeFilePandocOptsT func loadWriterOpts defFiltered reqFiltered archFiltered techFiltered testFiltered format sett =     
    do
        readTemp <- readTemplate 
        case readTemp sett of
             True -> do
                 rawFile <- runIOorExplode $ func loadWriterOpts $ myDoc defFiltered reqFiltered archFiltered techFiltered testFiltered 
                 T.writeFile ("project." ++ format) rawFile
             False -> return ()
             
             
             
writeFilePandocOptsB :: (WriterOptions -> Pandoc -> PandocIO B.ByteString) -> WriterOptions -> Pandoc -> Pandoc -> Pandoc -> Pandoc -> Pandoc -> String -> Setting Bool -> IO ()
writeFilePandocOptsB func loadWriterOpts defFiltered reqFiltered archFiltered techFiltered testFiltered format sett =     
    do
        readTemp <- readTemplate 
        case readTemp sett of
             True -> do
                 rawFile <- runIOorExplode $ func loadWriterOpts $ myDoc defFiltered reqFiltered archFiltered techFiltered testFiltered
                 B.writeFile ("project." ++ format) rawFile
             False -> return ()
             
             
             
convIntToCss :: Int -> String
convIntToCss 0 = "default.css"
convIntToCss 1 = "blue.css"
convIntToCss 2 = "green.css"
convIntToCss 3 = "orange.css"
convIntToCss _ = "default.css"
