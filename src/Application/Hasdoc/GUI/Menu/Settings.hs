{-# LANGUAGE MultiParamTypeClasses
            ,FlexibleInstances
            ,FlexibleContexts
            ,TypeSynonymInstances
            ,UndecidableInstances
            ,ScopedTypeVariables
            ,TemplateHaskell
            ,OverloadedStrings
            ,DeriveGeneric
            ,AllowAmbiguousTypes
            ,MonoLocalBinds #-}

module Application.Hasdoc.GUI.Menu.Settings
(
openSettingsWindow
) 
where
    
import Application.Hasdoc.Settings.General    
    
import Graphics.UI.WX
import Graphics.UI.WX.Window
import Graphics.UI.WXCore

import System.Directory
import Control.Monad
import System.Environment.Executable
import qualified Data.Map.Lazy as Map
import Data.Maybe
import Data.AppSettings
import System.IO.Unsafe
import System.FilePath

import qualified Data.Text as T



import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data SettingsApp = SettingsApp

mkMessage "SettingsApp" getAppLangPath "en"



makeTranslator :: (RenderMessage SettingsApp SettingsAppMessage) => IO (SettingsAppMessage -> String)
makeTranslator = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    return (\message -> T.unpack $ renderMsg SettingsApp (settLangIntToString $ getSetting' conf languageSett) message)


openSettingsWindow :: Frame () -> IO ()
openSettingsWindow mainWindow = 
    do 
        translate <- makeTranslator
        settWindow <- frameTool [text := translate MsgSettWindow, resizeable := True, visible := True, clientSize  := sz 640 480, picture := (getAppIconsPath ++ "/settings-window.png")]  mainWindow  
        createTabsWidget settWindow
        
        
createTabsWidget :: Frame () -> IO ()
createTabsWidget settWindow = 
    do
        translate <- makeTranslator
        
        p <- panel settWindow []
        notebook' <- notebook p []
        
        -- radio box page
        p1   <- panel  notebook' []
        
        let rlabels = ["polski", "english"]
        langDesc <- staticText p1 [ text := translate MsgLangLabel ]
        
        r1 <- singleListBox p1 [items := ["polski","english"]] --on select ::= do something after selecting]
        
        
        p3   <- panel notebook' []        
        
        execPath <- getExecutablePath
        extExecPath <- textEntry p3 []
        c1   <- checkBox p3 []
        c2   <- checkBox p3 []
        
        let openWidget = openAfterFocus c2 extExecPath $ fileOpenDialog settWindow True True (translate MsgLoadLabel) [((translate MsgExeFiles), ["*"])] execPath "" -- Higher order functions, Curried functions
        set extExecPath [ on focus := openWidget, enabled := False, clientSize  := sz 200 20 ] 
        peviewDesc <- staticText p3 [ text := (translate MsgViewerLabel) ]
        set c1 [text :=(translate MsgNoViewer), on command ::= changeAppTextEntry patternM extExecPath c2 False True, checked := True ]
        set c2 [text := (translate MsgExternalViewer), on command ::= changeAppTextEntry patternE extExecPath c1 True True, checked := False ]       

        
        p4   <- panel  notebook' [enabled := False]
        
        printDesc <- staticText p4 [ text := (translate MsgPrintDesc) ]

        let printersList = []
        printersBox  <- comboBox p4 
                  [items      := printersList
                  ,identity   := 17]
                  
        intSpinBox <- spinCtrl p4 1 500 [ tooltip := (translate MsgScaleHint) ]
                  
        let formatsList = ["A0", "A1", "A2", "A3", "A4", "A5", "A6", "B4", "B5", "B6"]          
        formatBox  <- comboBox p4 
                  [items      := formatsList
                  ,identity   := 18]
                  
        scopeEntry <- textEntry p4 []
                  
        let orientationsList = [(translate MsgOrientVChoice), (translate MsgOrientHChoice)]          
        orientationBox  <- comboBox p4 
                  [items      := orientationsList
                  ,identity   := 19]
                     
        marginsEntry <- textEntry p4 []
                  
        let coloursList = [(translate MsgColourChoice),(translate MsgGreyChoice)]          
        coloursBox  <- comboBox p4 
                  [items      := coloursList
                  ,identity   := 20]
                  
        let bilaterallyList = [(translate MsgBiOff),"Simplex", "Long Edge", "Short Edge"]          
        bilaterallyBox  <- comboBox p4 
                  [items      := bilaterallyList
                  ,identity   := 21]
                  
        let listComboBoxes = [printersBox, formatBox, orientationBox, coloursBox, bilaterallyBox]
        
        
        p5   <- panel notebook' []
        
        formatsDesc <- staticText p5 [ text := (translate MsgExtFilesLabel) ]
        formatBox1   <- checkBox p5 [text := "ZimWiki", identity := 1]
        formatBox2   <- checkBox p5 [text := "TEI", identity := 2]
        formatBox3   <- checkBox p5 [text := "DocBook 5", identity := 3]
        formatBox4   <- checkBox p5 [text := "Word docx", identity := 4]
        formatBox5   <- checkBox p5 [text := "DokuWiki", identity := 5]
        formatBox6   <- checkBox p5 [text := "EPUB v3", identity := 6]
        formatBox7   <- checkBox p5 [text := "Haddock", identity := 7]
        formatBox8   <- checkBox p5 [text := "LaTeX", identity := 8]
        formatBox9   <- checkBox p5 [text := "PHP Markdown Extra", identity := 9]
        formatBox10   <- checkBox p5 [text := "MediaWiki", identity := 10]
        formatBox11   <- checkBox p5 [text := "OpenOffice text document", identity := 11]
        formatBox12   <- checkBox p5 [text := "OpenDocument", identity := 12]
        formatBox13   <- checkBox p5 [text := "PowerPoint slide show", identity := 13]
        formatBox14   <- checkBox p5 [text := "Jupyter notebook", identity := 14]
        
        let formatsBoxes = [formatBox1, formatBox2,formatBox3, formatBox4, formatBox5, formatBox6, formatBox7, formatBox8, formatBox9, formatBox10, formatBox11, formatBox12, formatBox13, formatBox14]
        
        
        p6   <- panel  notebook' []
        
        let rlabels = ["default", "blue", "green", "orange"]
        templateDesc <- staticText p6 [ text := (translate MsgTemplatesLabel) ]
        templatesRadioBox   <- radioBox p6 Vertical rlabels   [text := (translate MsgTemplatesList) ]
        

        let tab1 = tab (translate MsgLangTab) (container p1 (margin 10 $ column 10 [ floatTop $ widget langDesc, floatTopLeft $ (column 5 [fill (widget r1)])]))
        
        let tab3 = tab (translate MsgPreviewTab) (container p3 (margin 10 $ column 10 [ floatTop $ widget peviewDesc, floatTopLeft $ (grid 3 5 [[widget c1, label ""], [widget c2, widget extExecPath]])]))
            
        let tab4 = tab (translate MsgPrintingTab) (container p4 (margin 10 $ column 10 [ floatTop $ widget printDesc, floatTopLeft $ (grid 3 5 [[label (translate MsgPrintLabel), widget printersBox], [label (translate MsgFormatLabel), widget formatBox], [label (translate MsgOrientLabel), widget orientationBox], [label (translate MsgColourLabel), widget coloursBox], [label (translate MsgBiPrintLabel), widget bilaterallyBox], [label (translate MsgResLabel), widget intSpinBox], [label (translate MsgMargingsLabel), widget marginsEntry], [label (translate MsgScopeLabel), widget scopeEntry]])]))
            
        let tab5 = tab (translate MsgExtOfFilesTab) (container p5 (margin 10 $ column 10 [ floatTop $ widget formatsDesc, floatCenter $ (grid 3 5 [[widget formatBox1, widget formatBox2, widget formatBox3, widget formatBox4], [widget formatBox5, widget formatBox6, widget formatBox7, widget formatBox8], [widget formatBox9, widget formatBox10, widget formatBox11, widget formatBox12], [widget formatBox13, widget formatBox14]])]))
            
        let tab6 = tab (translate MsgTemplatesSetTab) (container p6 (margin 10 $ column 10 [ floatTop $ widget templateDesc, floatTopLeft $ (column 5 [hstretch (widget templatesRadioBox)])]))
            
        let nbtab = tabs notebook' [tab1, tab3, tab4, tab5, tab6]
            
        setDefaults templatesRadioBox r1 c1 c2 extExecPath intSpinBox printersBox formatBox orientationBox coloursBox bilaterallyBox marginsEntry scopeEntry formatsBoxes         
        
        loadChanges templatesRadioBox r1 c1 c2 extExecPath intSpinBox printersBox formatBox orientationBox coloursBox bilaterallyBox marginsEntry scopeEntry formatsBoxes
        
        
        saveBtn <- button p [ text := (translate MsgSaveBtn), enabled := True, on command := saveChanges settWindow (holdInfoAboutLang r1) (holdInfoAboutTexts marginsEntry scopeEntry extExecPath c1 c2) (holdInfoAboutPrint listComboBoxes) (holdInfoAboutFormats formatsBoxes) (holdInfoAboutPrintRes intSpinBox) (holdInfoAboutTemplates templatesRadioBox) ]
        resetBtn <- button p [ text := (translate MsgResetBtn), enabled := True, on command := confirmReset settWindow templatesRadioBox r1 c1 c2 extExecPath intSpinBox printersBox formatBox orientationBox coloursBox bilaterallyBox marginsEntry scopeEntry formatsBoxes  ]
        cancelBtn <- button p [ text := (translate MsgCancelBtn), on command := close settWindow ]
        
        -- =================================================
        
        set settWindow [layout :=
              container p $
                column 3
                   [ nbtab, row 3 [floatLeft $ widget cancelBtn, floatLeft $ widget resetBtn, floatRight $ widget saveBtn]]]
        return ()

        
        
-- pattern matching
openAfterFocus :: CheckBox () -> TextCtrl () -> IO (Maybe FilePath) -> Bool -> IO ()
openAfterFocus chBox entryLine path True = updateLine chBox entryLine path
openAfterFocus chBox entryLine path False = return ()
        
        
updateLine :: CheckBox () -> TextCtrl () -> IO (Maybe FilePath) -> IO ()
updateLine chBox entryLine path = path >>= getTextforLine chBox entryLine
        

getTextforLine :: CheckBox () -> TextCtrl () -> Maybe FilePath -> IO ()
getTextforLine chBox entryLine filePath = case filePath of
                              Nothing -> set entryLine [ text := "" ] >> focusOn chBox
                              Just x -> set entryLine [ text := x ] >> focusOn chBox
                     
              
-- higher-orderism
changeAppTextEntry :: (TextCtrl () -> CheckBox () -> Bool -> Bool -> IO ()) -> TextCtrl () -> CheckBox () -> Bool -> Bool -> CheckBox () -> IO ()
changeAppTextEntry patternFunc textEntry chbox failBool1 failBool2 currChBox =
    do
        ifAnotherChecked <- get chbox checked
        ifCurrChecked <- get currChBox checked
        patternFunc textEntry chbox ifAnotherChecked ifCurrChecked

        
-- pattern matching             
patternM :: TextCtrl () -> CheckBox () -> Bool -> Bool -> IO ()
patternM textEntry chbox True True = set chbox [ checked := False ] >> set textEntry [ text := "", enabled := False ]
patternM textEntry chbox True False = set textEntry [ enabled := True ]
patternM textEntry chbox False True = set textEntry [ text := "", enabled := False ]
patternM textEntry chbox False False = return ()
             
        

patternE :: TextCtrl () -> CheckBox () -> Bool -> Bool -> IO ()
patternE textEntry chbox True True = set chbox [ checked := False ] >> set textEntry [ enabled := True ]
patternE textEntry chbox False True = set textEntry [ enabled := True ]
patternE textEntry chbox True False = set textEntry [ text := "", enabled := False ]
patternE textEntry chbox False False = return ()


getText :: (Selection w, Items w String) => w -> IO String
getText w
      = do i <- get w selection
           get w (item i)
 
 
detectAppName :: Bool -> Bool -> String -> String
detectAppName True False "Brak" = "Off"
detectAppName True False "Off" = "Off"
detectAppName False True [] = "Off"
detectAppName False True app = app
detectAppName _ _ _ = "Off"


-- filter use
-- filterChosenFormats :: [CheckBox ()] -> IO [CheckBox ()]
-- filterChosenFormats = filterM (\x -> get x checked)


holdInfoAboutTexts :: TextCtrl () -> TextCtrl () -> TextCtrl () -> CheckBox () -> CheckBox () -> IO (Map.Map String String)
holdInfoAboutTexts printMarginCtrl printScopeCtrl appEntry builtinBox chosenBox = 
    do
        previewBoxDefault <- get builtinBox checked
        previewBoxChosen <- get chosenBox checked
        marginText <- get printMarginCtrl text
        scopeText <- get printScopeCtrl text
        appEntry <- get appEntry text
        return $ Map.fromList $ [("print-margins", marginText), ("print-scope", scopeText), ("preview-app", detectAppName previewBoxDefault previewBoxChosen appEntry)]
        

holdInfoAboutPrint :: [ComboBox ()] -> IO (Map.Map String Int)
holdInfoAboutPrint printBoxes = return $ Map.fromList $ (map (\x -> (convIdToText $ unsafePerformIO $ get x identity, unsafePerformIO $ get x selection)) printBoxes)
        
        
holdInfoAboutPrintRes :: SpinCtrl () -> IO (Map.Map String Int)
holdInfoAboutPrintRes printScaleSpin = 
    do
        scaleInt <- get printScaleSpin selection
        return $ Map.fromList [("print-resolution", scaleInt)]
        
        
holdInfoAboutFormats :: [CheckBox ()] -> IO (Map.Map String Bool)
holdInfoAboutFormats formatBoxes = return $ Map.fromList $ map (\x -> (convIdToText $ unsafePerformIO $ get x identity, unsafePerformIO $ get x checked)) formatBoxes


holdInfoAboutLang :: SingleListBox () -> IO (Map.Map String Int)
holdInfoAboutLang langListBox = 
    do 
        langText <- get langListBox selection
        return $ Map.fromList [("lang-lang", langText)]


holdInfoAboutTemplates :: RadioBox () -> IO (Map.Map String Int)
holdInfoAboutTemplates cssRadioBox = 
    do 
        cssText <- get cssRadioBox selection
        return $ Map.fromList [("template-template", cssText)]

    
saveChanges :: Frame () -> IO (Map.Map String Int) -> IO (Map.Map String String) -> IO (Map.Map String Int) -> IO (Map.Map String Bool) -> IO (Map.Map String Int) -> IO (Map.Map String Int) -> IO ()
saveChanges mainWindow langList textList printList formatList spinBoxScale templateList = 
    do
        langL <- langList
        textL <- textList
        printL <- printList
        templateL <- templateList 
        formatsList <- formatList
        scaleInt <- spinBoxScale
        let unionLists = langL `Map.union` scaleInt `Map.union` printL `Map.union` templateL
        writeNewValues mainWindow unionLists formatsList textL "hasdoc"
        writeNewValues mainWindow unionLists formatsList textL "hasdoc-gen"
        
        
loadChanges :: RadioBox () -> SingleListBox () -> CheckBox () -> CheckBox () -> TextCtrl () -> SpinCtrl () -> ComboBox () -> ComboBox () -> ComboBox () -> ComboBox () -> ComboBox () -> TextCtrl () -> TextCtrl () -> [CheckBox ()] -> IO ()
loadChanges = readNewValues
        
        
setDefaults ::  RadioBox () -> SingleListBox () -> CheckBox () -> CheckBox () -> TextCtrl () -> SpinCtrl () -> ComboBox () -> ComboBox () -> ComboBox () -> ComboBox () -> ComboBox () -> TextCtrl () -> TextCtrl () -> [CheckBox ()] -> IO ()
setDefaults cssRadioBox langListBox builtinBox chosenBox pdfEntry printScaleSpin printersBox formatBox orientationBox coloursBox bilaterallyBox printMarginCtrl printScopeCtrl formatsBoxes = 
    set cssRadioBox [ selection := 0 ] >>
    set langListBox [ selection := 0 ] >>
    set builtinBox [ checked := True ] >>
    set chosenBox [ checked := False ] >>
    set pdfEntry [ text := "", enabled := False ] >>
    set printScaleSpin [ selection := 100 ] >>
    set printersBox [ selection := 0 ] >>
    set formatBox [ selection := 4 ] >>
    set orientationBox [ selection := 0 ] >>
    set coloursBox [ selection := 0 ] >>
    set bilaterallyBox [ selection := 0 ] >>
    set printMarginCtrl [ text := "5-5-5-5" ] >>
    set printScopeCtrl [ text := "" ] >>
    mapM_ (\x -> set x [ checked := False] ) formatsBoxes
    
    
    
confirmReset :: Frame () -> RadioBox () -> SingleListBox () -> CheckBox () -> CheckBox () -> TextCtrl () -> SpinCtrl () -> ComboBox () -> ComboBox () -> ComboBox () -> ComboBox () -> ComboBox () -> TextCtrl () -> TextCtrl () -> [CheckBox ()] -> IO () 
confirmReset mainWindow cssRadioBox langListBox builtinBox chosenBox pdfEntry printScaleSpin printersBox formatBox orientationBox coloursBox bilaterallyBox printMarginCtrl printScopeCtrl formatsBoxes = 
    do 
        translate <- makeTranslator
        answer <- confirmDialog mainWindow (translate MsgConfirmClose) (translate MsgConfirmResetQuestion) True 
        if answer 
           then do 
               setDefaults cssRadioBox langListBox builtinBox chosenBox pdfEntry printScaleSpin printersBox formatBox orientationBox coloursBox bilaterallyBox printMarginCtrl printScopeCtrl formatsBoxes 
           else 
               return ()
       
        

convIdToText :: Int -> String  
convIdToText 1 = "fileformat-zimwiki"  
convIdToText 2 = "fileformat-tei"  
convIdToText 3 = "fileformat-docbook5"  
convIdToText 4 = "fileformat-docx"  
convIdToText 5 = "fileformat-dokuwiki"  
convIdToText 6 = "fileformat-epubv3" 
convIdToText 7 = "fileformat-haddock" 
convIdToText 8 = "fileformat-latex" 
convIdToText 9 = "fileformat-php" 
convIdToText 10 = "fileformat-mediawiki" 
convIdToText 11 = "fileformat-openoffice" 
convIdToText 12 = "fileformat-opendocument" 
convIdToText 13 = "fileformat-powerpoint" 
convIdToText 14 = "fileformat-jupyter" 
convIdToText 17 = "print-printer" 
convIdToText 18 = "print-format" 
convIdToText 19 = "print-orientation" 
convIdToText 20 = "print-colour" 
convIdToText 21 = "print-bilaterally" 
convIdToText x = "" 
                      
