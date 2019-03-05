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
convIntToCss,
settLangIntToString
)
where
    
import ProjectManagement.HasdocGen.File.Settings 

import Data.Text (Text, unpack)
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
defDoc (Just x) wrOptions lang = doc $ para linebreak <> divWith ("definitions", ["pages"], [("lang", lang)]) (para (strong "Definitions") <>
  docLoop (Just x) wrOptions lang)
  
  
reqDoc :: Maybe [(Int, String, String)] -> WriterOptions -> String -> Pandoc
reqDoc Nothing wrOptions lang = setAuthors [""] $ doc $ para linebreak
--reqDoc Just [] = str ""
reqDoc (Just x) wrOptions lang = doc $ para linebreak <> divWith ("requirements", ["pages"], [("lang", lang)]) (para (strong "Requirements") <>
  docLoop (Just x) wrOptions lang)
  
  
archDoc :: Maybe [(Int, String, String)] -> WriterOptions -> String -> Pandoc
archDoc Nothing wrOptions lang = setAuthors [""] $ doc $ para linebreak
--archDoc Just [] = str ""
archDoc (Just x) wrOptions lang = doc $ para linebreak <> divWith ("architecture", ["pages"], [("lang", lang)]) (para (strong "Architecture") <>
  docLoop (Just x) wrOptions lang)
  
  
techDoc :: Maybe [(Int, String, String)] -> WriterOptions -> String -> Pandoc
techDoc Nothing wrOptions lang = setAuthors [""] $ doc $ para linebreak
--techDoc Just [] = str ""
techDoc (Just x) wrOptions lang = doc $ para linebreak <> divWith ("technology", ["pages"], [("lang", lang)]) (para (strong "Technology") <>
  docLoop (Just x) wrOptions lang)
  
  
testDoc :: Maybe [(Int, String, String)] -> WriterOptions -> String -> Pandoc
testDoc Nothing wrOptions lang = setAuthors [""] $ doc $ para linebreak
--testDoc Just [] = str ""
testDoc (Just x) wrOptions lang = doc $ para linebreak <> divWith ("tests", ["pages"], [("lang", lang)]) (para (strong "Tests") <>
  docLoop (Just x) wrOptions lang)
  
    
  
docLoop :: Maybe [(Int, String, String)] -> WriterOptions -> String -> Blocks  
docLoop (Just ((x,y,z):xs)) wrOptions lang = 
    para (spanWith ("question" ++ (show x), ["questions"], [("lang", lang)]) (text y) <>
    linebreak <>
    spanWith ((show x), ["answers"], [("lang", lang)]) (text z)) <>
    docLoop (Just xs) wrOptions lang
    
docLoop (Just []) wrOptions lang = para linebreak
docLoop Nothing wrOptions lang = para linebreak




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


settLangIntToString :: Int -> String
settLangIntToString 0 = "pl"
settLangIntToString 1 = "en"
settLangIntToString _ = "en"

