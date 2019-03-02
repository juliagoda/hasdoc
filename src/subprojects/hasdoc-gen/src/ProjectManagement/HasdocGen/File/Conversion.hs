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



defDoc :: Maybe [(String, String)] -> WriterOptions -> Pandoc
defDoc Nothing wrOptions = setAuthors [""] $ doc $ para linebreak
--defDoc Just [] = str ""
defDoc (Just x) wrOptions = doc $ para linebreak <> divWith ("definitions", ["pages"], [("","")]) (para (strong "Definitions") <>
  docLoop (Just x) wrOptions)
  
  
reqDoc :: Maybe [(String, String)] -> WriterOptions -> Pandoc
reqDoc Nothing wrOptions = setAuthors [""] $ doc $ para linebreak
--reqDoc Just [] = str ""
reqDoc (Just x) wrOptions = doc $ para linebreak <> divWith ("requirements", ["pages"], [("","")]) (para (strong "Requirements") <>
  docLoop (Just x) wrOptions)
  
  
archDoc :: Maybe [(String, String)] -> WriterOptions -> Pandoc
archDoc Nothing wrOptions = setAuthors [""] $ doc $ para linebreak
--archDoc Just [] = str ""
archDoc (Just x) wrOptions = doc $ para linebreak <> divWith ("architecture", ["pages"], [("","")]) (para (strong "Architecture") <>
  docLoop (Just x) wrOptions)
  
  
techDoc :: Maybe [(String, String)] -> WriterOptions -> Pandoc
techDoc Nothing wrOptions = setAuthors [""] $ doc $ para linebreak
--techDoc Just [] = str ""
techDoc (Just x) wrOptions = doc $ para linebreak <> divWith ("technology", ["pages"], [("","")]) (para (strong "Technology") <>
  docLoop (Just x) wrOptions)
  
  
testDoc :: Maybe [(String, String)] -> WriterOptions -> Pandoc
testDoc Nothing wrOptions = setAuthors [""] $ doc $ para linebreak
--testDoc Just [] = str ""
testDoc (Just x) wrOptions = doc $ para linebreak <> divWith ("tests", ["pages"], [("","")]) (para (strong "Tests") <>
  docLoop (Just x) wrOptions)
  
  
--   let nodes = inlinesToNodes opts ils
--       op = tagWithAttributes opts True False "span" attr
--   in  if isEnabled Ext_raw_html opts
--          then ((node (HTML_INLINE op) [] : nodes ++
--                 [node (HTML_INLINE (T.pack "</span>")) []]) ++)
  
  
docLoop :: Maybe [(String, String)] -> WriterOptions -> Blocks  
docLoop (Just ((x,y):xs)) wrOptions = 
    para (spanWith ("", ["questions"], [("title","hint")]) (text x) <>
    linebreak <>
    spanWith ("", ["answers"], [("title","hint")]) (text y)) <>
    docLoop (Just xs) wrOptions
    
docLoop (Just []) wrOptions = para linebreak
docLoop Nothing wrOptions = para linebreak




writeZimWikiFile :: Maybe [(String, String)] -> Maybe [(String, String)] -> Maybe [(String, String)] -> Maybe [(String, String)] -> Maybe [(String, String)] -> String -> IO ()
writeZimWikiFile defFiltered reqFiltered archFiltered techFiltered testFiltered projectTitle =     
    do
        readTemp <- readTemplate 
        case readTemp zimWikiFormat of
             True -> do
                 let wrOptions = (def { writerTOCDepth = 4, writerTableOfContents = False})
                 rawZimWiki <- runIOorExplode $ writeZimWiki wrOptions $ myDoc projectTitle (defDoc defFiltered wrOptions) (reqDoc reqFiltered wrOptions) (archDoc archFiltered wrOptions) (techDoc techFiltered wrOptions) (testDoc testFiltered wrOptions)
                 T.writeFile (projectTitle ++ "/project.zim") rawZimWiki
             False -> return ()
             
   
            
writeFilePandocOptsT :: (WriterOptions -> Pandoc -> PandocIO Text) -> WriterOptions -> Pandoc -> Pandoc -> Pandoc -> Pandoc -> Pandoc -> String -> Setting Bool -> String -> IO ()
writeFilePandocOptsT func loadWriterOpts defFiltered reqFiltered archFiltered techFiltered testFiltered format sett projectTitle =     
    do
        readTemp <- readTemplate 
        case readTemp sett of
             True -> do
                 rawFile <- runIOorExplode $ func loadWriterOpts $ myDoc projectTitle defFiltered reqFiltered archFiltered techFiltered testFiltered 
                 T.writeFile (projectTitle ++ "/project." ++ format) rawFile
             False -> return ()
             
             
             
writeFilePandocOptsB :: (WriterOptions -> Pandoc -> PandocIO B.ByteString) -> WriterOptions -> Pandoc -> Pandoc -> Pandoc -> Pandoc -> Pandoc -> String -> Setting Bool -> String -> IO ()
writeFilePandocOptsB func loadWriterOpts defFiltered reqFiltered archFiltered techFiltered testFiltered format sett projectTitle =     
    do
        readTemp <- readTemplate 
        case readTemp sett of
             True -> do
                 rawFile <- runIOorExplode $ func loadWriterOpts $ myDoc projectTitle defFiltered reqFiltered archFiltered techFiltered testFiltered
                 B.writeFile (projectTitle ++ "/project." ++ format) rawFile
             False -> return ()
             
             
             
convIntToCss :: Int -> String
convIntToCss 0 = "default.css"
convIntToCss 1 = "blue.css"
convIntToCss 2 = "green.css"
convIntToCss 3 = "orange.css"
convIntToCss _ = "default.css"
