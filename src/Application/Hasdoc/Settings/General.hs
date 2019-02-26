{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
            
           
module Application.Hasdoc.Settings.General
(
writeNewValues,
readNewValues,
settLangIntToString,
renderMsg,
languageSett,
getDataDirPath,
getAppIconsPath,
getAppCssPath,
getAppLangPath
) 
where


import Graphics.UI.WX

import qualified Data.Map.Lazy as Map
import qualified Data.Text as T
import Data.Maybe
import Data.AppSettings
import Control.Exception
import System.IO.Unsafe
import qualified Paths_hasdoc as Paths

import ProjectManagement.HasdocGen.File.HTML
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())



settToLocale :: String -> T.Text
settToLocale "polski" = "pl"
settToLocale "english" = "en"


renderMsg :: (RenderMessage a b) => a -> String -> b -> T.Text
renderMsg master txt message =
  renderMessage master [(settToLocale txt)] message
  
  
getDataDirPath :: FilePath
getDataDirPath = unsafePerformIO $ Paths.getDataDir


getAppIconsPath :: FilePath
getAppIconsPath = (unsafePerformIO $ Paths.getDataDir) ++ "/data/icons"
  
 
getAppCssPath :: FilePath
getAppCssPath = (unsafePerformIO $ Paths.getDataDir) ++ "/data/templates"


getAppLangPath :: FilePath
getAppLangPath = (unsafePerformIO $ Paths.getDataDir) ++ "/data/translations"


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


formatsMap :: Map.Map Int (Setting Bool)
formatsMap = Map.fromList [(1, zimWikiFormat), (2, teiFormat), (3, docbookFormat), (4, docxFormat), (5, dokuWikiFormat), (6, epubv3Format), (7, haddockFormat), (8, latexFormat), (9, jsonFormat), (10, phpMarkdownFormat), (11, mediaWikiFormat), (12, openOfficeFormat), (13, openDocFormat), (14, powerPointFormat), (15, jupyterFormat), (16, githubMarkdownFormat)]



-- convIdToSett :: forall a. (Show a, Read a) => Int -> Setting a
-- convIdToSett 1 = zimWikiFormat  
-- convIdToSett 2 = teiFormat  
-- convIdToSett 3 = docbookFormat  
-- convIdToSett 4 = docxFormat  
-- convIdToSett 5 = dokuWikiFormat  
-- convIdToSett 6 = epubv3Format
-- convIdToSett 7 = haddockFormat 
-- convIdToSett 8 = latexFormat 
-- convIdToSett 9 = jsonFormat 
-- convIdToSett 10 = phpMarkdownFormat 
-- convIdToSett 11 = mediaWikiFormat
-- convIdToSett 12 = openOfficeFormat 
-- convIdToSett 13 = openDocFormat
-- convIdToSett 14 = powerPointFormat 
-- convIdToSett 15 = jupyterFormat
-- convIdToSett 16 = githubMarkdownFormat 
-- convIdToSett 17 = printerSett 
-- convIdToSett 18 = formatSett 
-- convIdToSett 19 = orientationSett
-- convIdToSett 20 = colourPrintSett
-- convIdToSett 21 = bilaterallySett 



defaultConfig :: DefaultConfig
defaultConfig = getDefaultConfig $ do
    setting languageSett
    setting previewAppSett
    setting printerSett
    setting resolutionSett
    setting scopeSett
    setting formatSett
    setting orientationSett
    setting marginSett
    setting colourPrintSett
    setting bilaterallySett
    setting zimWikiFormat
    setting teiFormat
    setting docbookFormat
    setting docxFormat
    setting dokuWikiFormat
    setting epubv3Format
    setting haddockFormat
    setting latexFormat
    setting jsonFormat
    setting phpMarkdownFormat
    setting mediaWikiFormat
    setting openOfficeFormat
    setting openDocFormat
    setting powerPointFormat
    setting jupyterFormat
    setting githubMarkdownFormat
    setting templateName
    
    
-- poprzenosić w miejsca argumentów widgety, bo wcześniejsze ich wydobycie zamiast po kliknięciu "zapisz" nie daje szans na zapisanie zmian. Wartości zawsze pozostają domyślne, stare
writeNewValues :: Map.Map String Int -> Map.Map String Bool -> Map.Map String String -> String -> IO ()
writeNewValues resultsSets formatsRes resultsTexts appName = do
    readResult <- readSettings (AutoFromAppName appName)
    let conf = fst readResult
    --let gettSett = GetSetting $ getSetting conf languageSett
    let newConf = setSetting conf languageSett $ getOption resultsSets "lang-lang"
    let newConf2 = setSetting newConf previewAppSett $ getOption resultsTexts "preview-app"
    let newConf3 = setSetting newConf2 printerSett $ getOption resultsSets "print-printer"
    let newConf4 = setSetting newConf3 resolutionSett $ getOption resultsSets "print-resolution"
    let newConf5 = setSetting newConf4 scopeSett $ getOption resultsTexts "print-scope"
    let newConf6 = setSetting newConf5 formatSett $ getOption resultsSets "print-format"
    let newConf7 = setSetting newConf6 orientationSett $ getOption resultsSets "print-orientation"
    let newConf8 = setSetting newConf7 marginSett $ getOption resultsTexts "print-margins"
    let newConf9 = setSetting newConf8 colourPrintSett $ getOption resultsSets "print-colour"
    let newConf10 = setSetting newConf9 bilaterallySett $ getOption resultsSets "print-bilaterally"
    let newConf11 = setSetting newConf10 zimWikiFormat $ getOption formatsRes "fileformat-zimwiki"
    let newConf12 = setSetting newConf11 teiFormat $ getOption formatsRes "fileformat-tei"
    let newConf13 = setSetting newConf12 docbookFormat $ getOption formatsRes "fileformat-docbook5"
    let newConf14 = setSetting newConf13 docxFormat $ getOption formatsRes "fileformat-docx"
    let newConf15 = setSetting newConf14 dokuWikiFormat $ getOption formatsRes "fileformat-dokuwiki"
    let newConf16 = setSetting newConf15 epubv3Format $ getOption formatsRes "fileformat-epubv3"
    let newConf17 = setSetting newConf16 haddockFormat $ getOption formatsRes "fileformat-haddock"
    let newConf18 = setSetting newConf17 latexFormat $ getOption formatsRes "fileformat-latex"
    let newConf19 = setSetting newConf18 jsonFormat $ getOption formatsRes "fileformat-json"
    let newConf20 = setSetting newConf19 phpMarkdownFormat $ getOption formatsRes "fileformat-php"
    let newConf21 = setSetting newConf20 mediaWikiFormat $ getOption formatsRes "fileformat-mediawiki"
    let newConf22 = setSetting newConf21 openOfficeFormat $ getOption formatsRes "fileformat-openoffice"
    let newConf23 = setSetting newConf22 openDocFormat $ getOption formatsRes "fileformat-opendocument"
    let newConf24 = setSetting newConf23 powerPointFormat $ getOption formatsRes "fileformat-powerpoint"
    let newConf25 = setSetting newConf24 jupyterFormat $ getOption formatsRes "fileformat-jupyter"
    let newConf26 = setSetting newConf25 githubMarkdownFormat $ getOption formatsRes "fileformat-github"
    let newConf27 = setSetting newConf26 templateName $ getOption resultsSets "template-template"
    saveSettings defaultConfig (AutoFromAppName appName) newConf27
    
    
    
-- readNewValues :: [CheckBox ()] -> IO ()
-- readNewValues formatsCheckboxes = do
--     readResult <- readSettings (AutoFromAppName "hasdoc")
--     let conf = fst readResult
--     let gettSett = snd readResult
--     loadChangesFormats formatsCheckboxes checked gettSett
    
    
readNewValues :: RadioBox () -> SingleListBox () -> CheckBox () -> CheckBox () -> TextCtrl () -> SpinCtrl () -> ComboBox () -> ComboBox () -> ComboBox () -> ComboBox () -> ComboBox () -> TextCtrl () -> TextCtrl () -> [CheckBox ()] -> IO ()
readNewValues cssRadioBox langListBox builtinBox chosenBox appEntry printScaleSpin printersBox formatBox orientationBox coloursBox bilaterallyBox printMarginCtrl printScopeCtrl formatsBoxes = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    set cssRadioBox [selection := getSetting' conf templateName]
    set langListBox [selection := getSetting' conf languageSett]
    set printScaleSpin [selection := getSetting' conf resolutionSett]
    set printersBox [selection := getSetting' conf printerSett]
    set formatBox [selection := getSetting' conf formatSett]
    set orientationBox [selection := getSetting' conf orientationSett]
    set coloursBox [selection := getSetting' conf colourPrintSett]
    set bilaterallyBox [selection := getSetting' conf bilaterallySett]
    set printMarginCtrl [text := getSetting' conf marginSett]
    set printScopeCtrl [text := getSetting' conf scopeSett]
    readPreviewApp builtinBox chosenBox appEntry $ getSetting' conf previewAppSett
    mapM_ (mapCheckboxes conf) formatsBoxes
    
    
mapCheckboxes :: Conf -> CheckBox () -> IO ()
mapCheckboxes conf checkbox = 
    do
        ident <- get checkbox identity
        set checkbox [checked := getSetting' conf $ fromJust $ Map.lookup ident formatsMap]
    
    
readPreviewApp :: CheckBox () -> CheckBox () -> TextCtrl () -> String -> IO ()
readPreviewApp builtinBox chosenBox textEntry "embedded" = set builtinBox [checked := True]
readPreviewApp builtinBox chosenBox textEntry x = set chosenBox [checked := True] >> set textEntry [text := x]


 
-- loadChangesSets :: (Selection w, Items w String, Read b, Show b) => [w] -> Attr w b -> GetSetting -> IO ()
-- loadChangesSets [x:xs] attr getSett = 
--     do
--         ident <- get x identity 
--         set x [attr := getSett $ convIdToSett ident]
--         loadChangesSets xs attr getSett
--         
-- loadChangesSets x attr getSett = 
--     do
--         ident <- get x identity 
--         set x [attr := getSett $ convIdToSett ident]
--         
-- loadChangesSets [] _ _ = return ()
-- 
-- 
-- 
-- loadChangesFormats ::[CheckBox ()] -> Attr w Bool -> GetSetting -> IO ()
-- loadChangesFormats [x:xs] attr getSett = 
--     do
--         ident <- get x identity 
--         set x [checked := getSett $ convIdToSett ident]
--         loadChangesFormats xs attr getSett
--         
-- loadChangesFormats x attr getSett = 
--     do
--         ident <- get x identity 
--         set x [checked := getSett $ convIdToSett ident]
--         
-- loadChangesFormats [] _ _ = return ()
 
 
-- makeTranslator :: (RenderMessage a b) => IO (b -> String)
-- makeTranslator = do
--     readResult <- readSettings (AutoFromAppName "hasdoc")
--     let conf = fst readResult
--     return (\message -> T.unpack $ renderMsg App (settLangIntToString $ getSetting' conf languageSett) message)
    
    
-- template    
getOption :: (Show a, Read a) => Map.Map String a -> String -> a
getOption results key = fromJust $ Map.lookup key results


settLangIntToString :: Int -> String
settLangIntToString 0 = "polski"
settLangIntToString 1 = "english"
settLangIntToString _ = "english"

-- setSetting conf (Setting key _) v
