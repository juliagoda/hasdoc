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
            
            
module Application.Hasdoc.GUI.Menu
(
createMainMenu
) 
where
  

import Graphics.UI.WX

import Application.Hasdoc.GUI.Menu.Program.AppClose
import Application.Hasdoc.GUI.Menu.Program.StateLoad
import Application.Hasdoc.GUI.Menu.Settings
import Application.Hasdoc.GUI.Menu.About.Tools
import Application.Hasdoc.GUI.Menu.About.Tips
import Application.Hasdoc.GUI.Menu.About.Issues
import Application.Hasdoc.GUI.Menu.About.Homepage
import Application.Hasdoc.GUI.Menu.About.Author
import Application.Hasdoc.GUI.Menu.About.Doc

import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())
import Application.Hasdoc.Settings.General
import Data.AppSettings
import qualified Data.Text as T
import System.FilePath


data MenuWidget = MenuWidget

mkMessage "MenuWidget" getAppLangPath "en"



makeTranslator :: (RenderMessage MenuWidget MenuWidgetMessage) => IO (MenuWidgetMessage -> String)
makeTranslator = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    return (\message -> T.unpack $ renderMsg MenuWidget (settLangIntToString $ getSetting' conf languageSett) message)
    
    

createMainMenu :: Frame () -> IO ()
createMainMenu mainWindow = 
    do 
        programPane <- getProgramPane mainWindow
        settingsPane <- getSettingsPane mainWindow
        aboutPane <- getAboutPane mainWindow
        set mainWindow [menuBar := [programPane, settingsPane, aboutPane]]
        
        
getProgramPane :: Frame () -> IO (Menu ())
getProgramPane mainWindow =
    do 
        translate <- makeTranslator
        programPane <- menuPane [ text := translate MsgProgramMenu ]
        saveItem  <- menuItem programPane [ text := translate MsgSaveStateMenu, help := translate MsgSaveStateMenuHelp] --image := (getAppIconsPath ++ "/save-menu.png") ]
        loadItem  <- menuItem programPane [ text := translate MsgLoadStateMenu, help := translate MsgLoadStateMenuHelp, on command := openFileDialog mainWindow (translate MsgLoadStateMenuHelp) "" [(translate MsgLoadFilesExt, ["*.pdf"])]] --image := (getAppIconsPath ++ "/load-menu.png") ]
        importItem <- menuItem programPane [ text := translate MsgImportFromFileMenu, help := translate MsgImportFromFileMenuHelp ] -- image := (getAppIconsPath ++ "/import-menu.png") ]
        menuLine programPane
        quitItem <- menuItem programPane [ text := translate MsgQuitMenu, help := translate MsgQuitMenuHelp ] -- image := (getAppIconsPath ++ "/exit-menu.png") ]
        set quitItem  [on command := closeMainWindow mainWindow]
        tbar   <- toolBar mainWindow []
        toolMenu tbar saveItem  "Open"  (getAppIconsPath ++ "/doc-window.png")  []
        toolMenu tbar loadItem "About" (getAppIconsPath ++ "/authors-window.png") []
        return programPane
        
        
getSettingsPane :: Frame () -> IO (Menu ())
getSettingsPane mainWindow =
    do 
        translate <- makeTranslator
        optionsPane <- menuPane [ text := translate MsgOptionsMenu ]
        settItem  <- menuItem optionsPane [ text := translate MsgSettingsMenu, help := translate MsgSettingsMenuHelp ] --image := (getAppIconsPath ++ "/settings-menu.png") ]
        set settItem [on command := openSettingsWindow mainWindow]
        return optionsPane
          
        
getAboutPane :: Frame () -> IO (Menu ())
getAboutPane mainWindow =
    do 
        translate <- makeTranslator
        aboutPane <- menuPane [ text := translate MsgAboutMenu ]
        authorItem  <- menuItem aboutPane [ text := translate MsgAuthorMenu, help := translate MsgAuthorMenuHelp, on command := openAuthorsWindow mainWindow ] --image := (getAppIconsPath ++ "/authors-menu.png") ]
        websiteItem  <- menuItem aboutPane [ text := translate MsgHomepageMenu, help := translate MsgHomepageMenuHelp, on command := openHomepage mainWindow ] --image := (getAppIconsPath ++ "/homepage-menu.png") ]
        issueItem <- menuItem aboutPane [ text := translate MsgIssuesMenu, help := translate MsgIssuesMenuHelp, on command := openIssuesPage mainWindow ] --image := (getAppIconsPath ++ "/issue-menu.png") ]
        toolsItem <- menuItem aboutPane [ text := translate MsgToolsMenu, help := translate MsgToolsMenuHelp, on command := openToolsWindow mainWindow ] --image := (getAppIconsPath ++ "/tools-menu.png") ]
        tipsItem <- menuItem aboutPane [ text := translate MsgTipsMenu, help := translate MsgTipsMenuHelp, on command := openTipsWindow mainWindow ] --image := (getAppIconsPath ++ "/tips-menu.png") ]
        docItem <- menuItem aboutPane [ text := translate MsgDocMenu, help := translate MsgDocMenuHelp, on command := openDocWindow mainWindow ] --image := (getAppIconsPath ++ "/doc-menu.png") ]
        return aboutPane
