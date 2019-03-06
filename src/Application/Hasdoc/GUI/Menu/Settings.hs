{-# LANGUAGE MultiParamTypeClasses
            ,FlexibleInstances
            ,FlexibleContexts
            ,TypeSynonymInstances
            ,UndecidableInstances #-}

module Application.Hasdoc.GUI.Menu.Settings
(
openSettingsWindow
) 
where
    
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

import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

import Application.Hasdoc.Settings.General



-- data SettingsApp = SettingsApp
-- 
-- mkMessage "SettingsApp" getAppLangPath "en"
-- 
-- 
-- 
-- makeTranslator :: (RenderMessage SettingsApp SettingsAppMessage) => IO (SettingsAppMessage -> String)
-- makeTranslator = do
--     readResult <- readSettings (AutoFromAppName "hasdoc")
--     let conf = fst readResult
--     return (\message -> T.unpack $ renderMsg SettingsApp (settLangIntToString $ getSetting' conf languageSett) message)




openSettingsWindow :: Frame () -> IO ()
openSettingsWindow mainWindow = 
    do 
        --translate <- makeTranslator
        settWindow <- frameTool [text := "Ustawienia", resizeable := True, visible := True, clientSize  := sz 640 480, picture := (getAppIconsPath ++ "/settings-window.png")]  mainWindow  
        --settWindow <- dialog mainWindow [text := "Ustawienia", visible := True, clientSize  := sz 640 480] 
        createTabsWidget settWindow
        
        
createTabsWidget :: Frame () -> IO ()
createTabsWidget settWindow = 
    do
        --translate <- makeTranslator
        
        p <- panel settWindow []
        notebook' <- notebook p []
        
        -- radio box page
        p1   <- panel  notebook' []
        
        let rlabels = ["polski", "english"]
        langDesc <- staticText p1 [ text := "Wybierz jeden z poniższych języków. Po wyborze i dokonaniu zapisu wymagany jest restart programu." ]
        
        r1 <- singleListBox p1 [items := ["polski","english"]] --on select ::= rob cos po zaznaczeniu]
        
        
        p3   <- panel notebook' []        
        
        execPath <- getExecutablePath
        extExecPath <- textEntry p3 []
        c1   <- checkBox p3 []
        c2   <- checkBox p3 []
        
        let openWidget = openAfterFocus c2 extExecPath $ fileOpenDialog settWindow True True "wczytaj zapisaną wcześniej sesję" [("Pliki wykonywalne", ["*"])] execPath "" -- Higher order functions, Curried functions
        set extExecPath [ on focus := openWidget, enabled := False, clientSize  := sz 200 20 ] 
        peviewDesc <- staticText p3 [ text := "Wybierz program zewnętrzny do przeglądania generowanego pliku pdf oraz do przeglądania dokumentacji w tym formacie. Jeśli nie chcesz obejrzeć pliku po jego wygenerowaniu, wybierz pierwszą opcję." ]
        set c1 [text := "Brak", on command := changeAppTextEntry patternM extExecPath c2 True True c1, checked := True ]
        set c2 [text := "Program zewnętrzny", on command := changeAppTextEntry patternE extExecPath c1 True True c2, checked := False ]       

        
        p4   <- panel  notebook' [enabled := False]
        
        printDesc <- staticText p4 [ text := "Wybierz ustawienia dla okna drukowania. Można ten etap pominąć i nanieść zmiany w oknie generowanym przed etapem drukowania." ]

        let printersList = []
        printersBox  <- comboBox p4 
                  [items      := printersList
                  ,identity   := 17]
                  
        intSpinBox <- spinCtrl p4 1 500 [ tooltip := "Inaczej skala w procentach" ]
                  
        let formatsList = ["A0", "A1", "A2", "A3", "A4", "A5", "A6", "B4", "B5", "B6"]          
        formatBox  <- comboBox p4 
                  [items      := formatsList
                  ,identity   := 18]
                  
        scopeEntry <- textEntry p4 []
                  
        let orientationsList = ["Pionowa", "Pozioma"]          
        orientationBox  <- comboBox p4 
                  [items      := orientationsList
                  ,identity   := 19]
                     
        marginsEntry <- textEntry p4 []
                  
        let coloursList = ["Kolor","Skala szarości"]          
        coloursBox  <- comboBox p4 
                  [items      := coloursList
                  ,identity   := 20]
                  
        let bilaterallyList = ["Wyłącz","Simplex", "Long Edge", "Short Edge"]          
        bilaterallyBox  <- comboBox p4 
                  [items      := bilaterallyList
                  ,identity   := 21]
                  
        let listComboBoxes = [printersBox, formatBox, orientationBox, coloursBox, bilaterallyBox]
        
        
        p5   <- panel notebook' []
        
        formatsDesc <- staticText p5 [ text := "Wybierz wyjściowe formaty danych poniżej. Zostaną one stworzone w wybranej ścieżce oraz katalogu o nazwie projektu. Pliki html oraz pdf są tworzone zawsze." ]
        formatBox1   <- checkBox p5 [text := "ZimWiki", identity := 1]
        formatBox2   <- checkBox p5 [text := "TEI", identity := 2]
        formatBox3   <- checkBox p5 [text := "DocBook 5", identity := 3]
        formatBox4   <- checkBox p5 [text := "Word docx", identity := 4]
        formatBox5   <- checkBox p5 [text := "DokuWiki", identity := 5]
        formatBox6   <- checkBox p5 [text := "EPUB v3", identity := 6]
        formatBox7   <- checkBox p5 [text := "Haddock", identity := 7]
        formatBox8   <- checkBox p5 [text := "LaTeX", identity := 8]
        formatBox9   <- checkBox p5 [text := "JSON", identity := 9]
        formatBox10   <- checkBox p5 [text := "PHP Markdown Extra", identity := 10]
        formatBox11   <- checkBox p5 [text := "MediaWiki", identity := 11]
        formatBox12   <- checkBox p5 [text := "OpenOffice text document", identity := 12]
        formatBox13   <- checkBox p5 [text := "OpenDocument", identity := 13]
        formatBox14   <- checkBox p5 [text := "PowerPoint slide show", identity := 14]
        formatBox15   <- checkBox p5 [text := "Jupyter notebook", identity := 15]
        formatBox16   <- checkBox p5 [text := "GitHub-Flavored Markdown", identity := 16]
        
        let formatsBoxes = [formatBox1, formatBox2,formatBox3, formatBox4, formatBox5, formatBox6, formatBox7, formatBox8, formatBox9, formatBox10, formatBox11, formatBox12, formatBox13, formatBox14, formatBox15, formatBox16]
        
        
        p6   <- panel  notebook' []
        
        let rlabels = ["default", "blue", "green", "orange"]
        templateDesc <- staticText p6 [ text := "Wybierz jeden z poniższych plików css dla wyjściowego pliku html, na podstawie którego powstanie plik pdf. Pierwsza opcja oznacza wydruk bez kolorów." ]
        templatesRadioBox   <- radioBox p6 Vertical rlabels   [text := "Lista szablonów"]
        

        let tab1 = tab "Język" (container p1 (margin 10 $ column 10 [ floatTop $ widget langDesc, floatTopLeft $ (column 5 [fill (widget r1)])]))
        
        let tab3 = tab "Podgląd pliku" (container p3 (margin 10 $ column 10 [ floatTop $ widget peviewDesc, floatTopLeft $ (grid 3 5 [[widget c1, label ""], [widget c2, widget extExecPath]])]))
            
        let tab4 = tab "Drukowanie" (container p4 (margin 10 $ column 10 [ floatTop $ widget printDesc, floatTopLeft $ (grid 3 5 [[label "Domyślna drukarka", widget printersBox], [label "Domyślny format", widget formatBox], [label "Domyślna orientacja", widget orientationBox], [label "Domyślne uwzględnienie kolorów", widget coloursBox], [label "Tryb drukowania obustronnego", widget bilaterallyBox], [label "Domyślna rozdzielczość w %, np. 50, 100, 200 (Puste pole oznacza domyślną wartość 100 %)", widget intSpinBox], [label "Domyślne marginesy w mm, górnyMargines-prawyMargines-dolnyMargines-lewyMargines np. 25-25-25-25 (Puste pole oznacza użycie domyślnych ustawień)", widget marginsEntry], [label "Domyślny zakres drukowanych stron w formacie XX-XX lub XX, gdzie XX to dowolna liczba całkowita, np. 1-15, 23 (puste pole oznacza wszystkie strony)", widget scopeEntry]])]))
            
        let tab5 = tab "Formaty plików" (container p5 (margin 10 $ column 10 [ floatTop $ widget formatsDesc, floatCenter $ (grid 3 5 [[widget formatBox1, widget formatBox2, widget formatBox3, widget formatBox4], [widget formatBox5, widget formatBox6, widget formatBox7, widget formatBox8], [widget formatBox9, widget formatBox10, widget formatBox11, widget formatBox12], [widget formatBox13, widget formatBox14, widget formatBox15, widget formatBox16]])]))
            
        let tab6 = tab "Szablony" (container p6 (margin 10 $ column 10 [ floatTop $ widget templateDesc, floatTopLeft $ (column 5 [hstretch (widget templatesRadioBox)])]))
            
        let nbtab = tabs notebook' [tab1, tab3, tab4, tab5, tab6]
            
        setDefaults templatesRadioBox r1 c1 intSpinBox printersBox formatBox orientationBox coloursBox bilaterallyBox marginsEntry scopeEntry formatsBoxes         
        
        loadChanges templatesRadioBox r1 c1 c2 extExecPath intSpinBox printersBox formatBox orientationBox coloursBox bilaterallyBox marginsEntry scopeEntry formatsBoxes
        
        
        saveBtn <- button p [ text := "Zapisz", enabled := True, on command := saveChanges (holdInfoAboutLang r1) (holdInfoAboutTexts marginsEntry scopeEntry extExecPath c1 c2) (holdInfoAboutPrint listComboBoxes) (holdInfoAboutFormats formatsBoxes) (holdInfoAboutPrintRes intSpinBox) (holdInfoAboutTemplates templatesRadioBox) ]
        resetBtn <- button p [ text := "Resetuj", enabled := True, on command := setDefaults templatesRadioBox r1 c1 intSpinBox printersBox formatBox orientationBox coloursBox bilaterallyBox marginsEntry scopeEntry formatsBoxes  ]
        cancelBtn <- button p [ text := "Anuluj", on command := close settWindow ]
        
        -- =================================================
        
        set settWindow [layout :=
              container p $
                column 3
                   [ nbtab, row 3 [floatLeft $ widget cancelBtn, floatLeft $ widget resetBtn, floatRight $ widget saveBtn]]]
        return ()
        
        --set notebook' [on click := onMouse notebook']
        
        
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
             
        
-- Bool -> Bool
-- c1 -> c2
-- Domyślny podgląd wbudowany -> zewnętrzny
-- Inny -> Aktualny
-- chbox == Domyślny
patternE :: TextCtrl () -> CheckBox () -> Bool -> Bool -> IO ()
patternE textEntry chbox True True = set chbox [ checked := False ] >> set textEntry [ enabled := True ]
patternE textEntry chbox True False = set textEntry [ text := "", enabled := False ]
patternE textEntry chbox False True = set textEntry [ enabled := True ]
patternE textEntry chbox False False = return ()


getText :: (Selection w, Items w String) => w -> IO String
getText w
      = do i <- get w selection
           get w (item i)
 
 
-- detectAppName defaultChecked choosenChecked choosenAppName 
detectAppName :: Bool -> Bool -> String -> String
detectAppName True False "embedded" = "embedded"
detectAppName False True [] = "embedded"
detectAppName False True app = app
detectAppName _ _ _ = "embedded"


-- filter use
filterChosenFormats :: [CheckBox ()] -> IO [CheckBox ()]
filterChosenFormats = filterM (\x -> get x checked)


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


-- holdInfoAboutApp :: CheckBox () -> CheckBox () -> TextCtrl () -> IO (Map.Map String String)
-- holdInfoAboutApp builtinBox chosenBox appEntry = 
--     do
--         previewBoxDefault <- get builtinBox checked
--         previewBoxChosen <- get chosenBox checked
--         appEntry <- get appEntry text
--         return $ Map.fromList [("preview-app", detectAppName previewBoxDefault previewBoxChosen appEntry)]


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

    
saveChanges :: IO (Map.Map String Int) -> IO (Map.Map String String) -> IO (Map.Map String Int) -> IO (Map.Map String Bool) -> IO (Map.Map String Int) -> IO (Map.Map String Int) -> IO ()
saveChanges langList textList printList formatList spinBoxScale templateList = 
    do
        langL <- langList
        textL <- textList
        printL <- printList
        templateL <- templateList 
        formatsList <- formatList
        scaleInt <- spinBoxScale
        let unionLists = langL `Map.union` scaleInt `Map.union` printL `Map.union` templateL
        writeNewValues unionLists formatsList textL "hasdoc"
        writeNewValues unionLists formatsList textL "hasdoc-gen"
        
        
        
-- items :: Attr w [a] --- All the items as a list
-- item :: Int -> Attr w a --- An item by zero-based index.
loadChanges :: RadioBox () -> SingleListBox () -> CheckBox () -> CheckBox () -> TextCtrl () -> SpinCtrl () -> ComboBox () -> ComboBox () -> ComboBox () -> ComboBox () -> ComboBox () -> TextCtrl () -> TextCtrl () -> [CheckBox ()] -> IO ()
loadChanges = readNewValues
        
        
setDefaults ::  RadioBox () -> SingleListBox () -> CheckBox () -> SpinCtrl () -> ComboBox () -> ComboBox () -> ComboBox () -> ComboBox () -> ComboBox () -> TextCtrl () -> TextCtrl () -> [CheckBox ()] -> IO ()
setDefaults cssRadioBox langListBox builtinBox printScaleSpin printersBox formatBox orientationBox coloursBox bilaterallyBox printMarginCtrl printScopeCtrl formatsBoxes = 
    set cssRadioBox [selection := 0] >>
    set langListBox [selection := 0] >>
    set builtinBox [checked := True ] >>
    set printScaleSpin [selection := 100] >>
    set printersBox [selection := 0] >>
    set formatBox [selection := 4] >>
    set orientationBox [selection := 0] >>
    set coloursBox [selection := 0] >>
    set bilaterallyBox [selection := 0] >>
    set printMarginCtrl [text := "5-5-5-5"] >>
    set printScopeCtrl [text := ""] >>
    mapM_ (\x -> set x [checked := False]) formatsBoxes
        

convIdToText :: Int -> String  
convIdToText 1 = "fileformat-zimwiki"  
convIdToText 2 = "fileformat-tei"  
convIdToText 3 = "fileformat-docbook5"  
convIdToText 4 = "fileformat-docx"  
convIdToText 5 = "fileformat-dokuwiki"  
convIdToText 6 = "fileformat-epubv3" 
convIdToText 7 = "fileformat-haddock" 
convIdToText 8 = "fileformat-latex" 
convIdToText 9 = "fileformat-json" 
convIdToText 10 = "fileformat-php" 
convIdToText 11 = "fileformat-mediawiki" 
convIdToText 12 = "fileformat-openoffice" 
convIdToText 13 = "fileformat-opendocument" 
convIdToText 14 = "fileformat-powerpoint" 
convIdToText 15 = "fileformat-jupyter" 
convIdToText 16 = "fileformat-github" 
convIdToText 17 = "print-printer" 
convIdToText 18 = "print-format" 
convIdToText 19 = "print-orientation" 
convIdToText 20 = "print-colour" 
convIdToText 21 = "print-bilaterally" 
convIdToText x = "" 
                      
        -- internationalization
-- https://wiki.wxwidgets.org/Internationalization
