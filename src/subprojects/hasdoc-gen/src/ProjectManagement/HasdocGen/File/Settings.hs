{-# LANGUAGE MultiParamTypeClasses
            ,FlexibleInstances
            ,FlexibleContexts
            ,TypeSynonymInstances
            ,UndecidableInstances
            ,ScopedTypeVariables
            ,TemplateHaskell
            ,OverloadedStrings #-}

            
module ProjectManagement.HasdocGen.File.Settings
(
getDataDirPath,
getAppIconsPath,
getAppCssPath,
getAppLangPath,
readTemplate,
previewAppSett,
languageSett,
templateName,
docbookFormat,
zimWikiFormat,
teiFormat,
docxFormat,
dokuWikiFormat,
epubv3Format,
haddockFormat,
latexFormat,
jsonFormat,
phpMarkdownFormat,    
mediaWikiFormat,
openOfficeFormat,
openDocFormat,
powerPointFormat,
jupyterFormat,
githubMarkdownFormat
)
where
    
    
import Graphics.UI.WX

import qualified Data.Map.Lazy as Map
import qualified Data.Text as T
import Data.Maybe
import Data.AppSettings
import Control.Exception
import System.IO.Unsafe
import System.Directory
import qualified Paths_hasdoc_gen as Paths

import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())


getDataDirPath :: FilePath
getDataDirPath = unsafePerformIO $ Paths.getDataDir


getAppIconsPath :: FilePath
getAppIconsPath = (unsafePerformIO $ Paths.getDataDir) ++ "/data/icons"
  
 
getAppCssPath :: FilePath
getAppCssPath = (unsafePerformIO $ Paths.getDataDir) ++ "/data/templates"


getAppLangPath :: FilePath
getAppLangPath = (unsafePerformIO $ Paths.getDataDir) ++ "/data/translations"

    
ifHasgenFileExists :: IO Bool
ifHasgenFileExists = getPathForLocation (AutoFromAppName "hasdoc-gen") >>= doesFileExist



-- taken from http://hackage.haskell.org/package/app-settings-0.2.0.12/docs/src/Data.AppSettings.html#getSettingsFolder
getPathForLocation :: FileLocation -> IO FilePath
getPathForLocation location = case location of
    AutoFromAppName appName -> getConfigFileName appName
    Path path -> return path

    
getConfigFileName :: String -> IO String
getConfigFileName appName = (++"config.ini") <$> getSettingsFolder appName


getSettingsFolder :: String -> IO FilePath
getSettingsFolder appName = do
    home <- getHomeDirectory
    let result = home ++ "/." ++ appName ++ "/"
    --createDirectoryIfMissing False result
    return result
    
-- END OF SECTION



languageSett :: Setting Int
languageSett = Setting "language" 0

previewAppSett :: Setting String
previewAppSett = Setting "previewApp" "embedded"

printerSett :: Setting Int
printerSett = Setting "printer" 0

resolutionSett :: Setting Int
resolutionSett = Setting "resolutionPrint" 100

scopeSett :: Setting String
scopeSett = Setting "scopePrint" ""

formatSett :: Setting Int
formatSett = Setting "formatPrint" 4

orientationSett :: Setting Int
orientationSett = Setting "orientationPrint" 0

marginSett :: Setting String
marginSett = Setting "marginsPrint" "5-5-5-5"

colourPrintSett :: Setting Int
colourPrintSett = Setting "colourOptionPrint" 0

bilaterallySett :: Setting Int
bilaterallySett = Setting "bilaterallyOptionPrint" 0

zimWikiFormat :: Setting Bool
zimWikiFormat = Setting "zimWikiOutput" False

teiFormat :: Setting Bool
teiFormat = Setting "teiOutput" False

docbookFormat :: Setting Bool
docbookFormat = Setting "docbookOutput" False

docxFormat :: Setting Bool
docxFormat = Setting "docxOutput" False

dokuWikiFormat :: Setting Bool
dokuWikiFormat = Setting "dokuWikiOutput" False

epubv3Format :: Setting Bool
epubv3Format = Setting "epubv3Output" False

haddockFormat :: Setting Bool
haddockFormat = Setting "haddockOutput" False

latexFormat :: Setting Bool
latexFormat = Setting "latexOutput" False

jsonFormat :: Setting Bool
jsonFormat = Setting "jsonOutput" False

phpMarkdownFormat :: Setting Bool
phpMarkdownFormat = Setting "phpMarkdownOutput" False

mediaWikiFormat :: Setting Bool
mediaWikiFormat = Setting "mediaWikiOutput" False

openOfficeFormat :: Setting Bool
openOfficeFormat = Setting "openOfficeOutput" False

openDocFormat :: Setting Bool
openDocFormat = Setting "openDocFormat" False

powerPointFormat :: Setting Bool
powerPointFormat = Setting "powerPointOutput" False

jupyterFormat :: Setting Bool
jupyterFormat = Setting "jupyterOutput" False

githubMarkdownFormat :: Setting Bool
githubMarkdownFormat = Setting "githubMarkdownOutput" False

templateName :: Setting Int
templateName = Setting "templateCss" 0



    
    
readTemplate :: (Show a, Read a) => IO (Setting a -> a)
readTemplate = ifHasgenFileExists >>= patternTemplate
    
    
patternTemplate :: (Show a, Read a) => Bool -> IO (Setting a -> a)
patternTemplate True = 
    do
        readResult <- readSettings (AutoFromAppName "hasdoc-gen")
        let conf = fst readResult
        return $ (\sett -> getSetting' conf sett)
patternTemplate False = return $ (\sett -> removeSett sett)
    
    
removeSett :: (Show a, Read a) => Setting a -> a
removeSett (Setting _ x) = x
