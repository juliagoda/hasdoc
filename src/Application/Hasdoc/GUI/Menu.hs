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
import Graphics.UI.WXCore

import Application.Hasdoc.GUI.Menu.Program.AppClose
import Application.Hasdoc.GUI.Menu.Program.StateLoad
import Application.Hasdoc.GUI.Menu.Program.StateSave
import Application.Hasdoc.GUI.Menu.Settings
import Application.Hasdoc.GUI.Menu.About.Tools
import Application.Hasdoc.GUI.Menu.About.Tips
import Application.Hasdoc.GUI.Menu.About.Issues
import Application.Hasdoc.GUI.Menu.About.Homepage
import Application.Hasdoc.GUI.Menu.About.Author
import Application.Hasdoc.GUI.Menu.About.Doc

import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())
import Application.Hasdoc.Settings.General
import System.FilePath
import System.IO.Unsafe


data MenuWidget = MenuWidget

mkMessage "MenuWidget" (unsafePerformIO $ chooseTransPath) "en"

    
    
createMainMenu :: Frame () -> ToolBar () -> IO ()
createMainMenu mainWindow tbar = 
    do 
        translate <- makeTranslator MenuWidget
        programPane <- getProgramPane mainWindow tbar
        settingsPane <- getSettingsPane mainWindow tbar
        aboutPane <- getAboutPane mainWindow tbar
        set mainWindow [menuBar := [programPane, settingsPane, aboutPane], 
            on (charKey 's') := saveFileDialog mainWindow [(translate MsgLoadFilesExt, ["*.hdoc"])],
            on (charKey 'l') := openFileDialog mainWindow (translate MsgLoadStateMenuHelp) "" [(translate MsgLoadFilesExt, ["*.hdoc"])] False,
            on (charKey 'i') := openFileDialog mainWindow (translate MsgLoadStateMenuHelp) "" [(translate MsgLoadFilesExt, ["*.html"])] True,
            on (charKey 'q') := closeMainWindow mainWindow,
            on (charKey 't') := openSettingsWindow mainWindow,
            on (charKey 'w') := openHomepage mainWindow,
            on (charKey 'b') := openIssuesPage mainWindow,
            on (charKey 'd') := openDocWindow mainWindow ]
        
        
getProgramPane :: Frame () -> ToolBar () -> IO (Menu ())
getProgramPane mainWindow tbar =
    do 
        translate <- makeTranslator MenuWidget
        programPane <- menuPane [ text := translate MsgProgramMenu ]
        saveItem  <- menuItem programPane [ text := translate MsgSaveStateMenu, help := translate MsgSaveStateMenuHelp, on command := saveFileDialog mainWindow [(translate MsgLoadFilesExt, ["*.hdoc"])]] 
        loadItem  <- menuItem programPane [ text := translate MsgLoadStateMenu, help := translate MsgLoadStateMenuHelp, on command := openFileDialog mainWindow (translate MsgLoadStateMenuHelp) "" [(translate MsgLoadFilesExt, ["*.hdoc"])] False ] 
        importItem <- menuItem programPane [ text := translate MsgImportFromFileMenu, help := translate MsgImportFromFileMenuHelp, on command := openFileDialog mainWindow (translate MsgLoadStateMenuHelp) "" [(translate MsgLoadFilesExt, ["*.html"])] True ] 
        menuLine programPane
        quitItem <- menuItem programPane [ text := translate MsgQuitMenu, help := translate MsgQuitMenuHelp ]
        set quitItem  [on command := closeMainWindow mainWindow]
        toolMenu tbar saveItem (translate MsgSaveStateMenu) (getAppIconsPath ++ "/save-window.png")  []
        toolMenu tbar importItem (translate MsgImportFromFileMenu) (getAppIconsPath ++ "/load-window.png") []
        toolMenu tbar loadItem (translate MsgLoadStateMenu) (getAppIconsPath ++ "/load-window.png") []
        return programPane
        
        
getSettingsPane :: Frame () -> ToolBar () -> IO (Menu ())
getSettingsPane mainWindow tbar =
    do 
        translate <- makeTranslator MenuWidget
        optionsPane <- menuPane [ text := translate MsgOptionsMenu ]
        settItem  <- menuItem optionsPane [ text := translate MsgSettingsMenu, help := translate MsgSettingsMenuHelp ]
        set settItem [on command := openSettingsWindow mainWindow]
        toolMenu tbar settItem (translate MsgSettingsMenu) (getAppIconsPath ++ "/settings-window.png")  []
        return optionsPane
          
        
getAboutPane :: Frame () -> ToolBar () -> IO (Menu ())
getAboutPane mainWindow tbar =
    do 
        translate <- makeTranslator MenuWidget
        aboutPane <- menuPane [ text := translate MsgAboutMenu ]
        authorItem  <- menuItem aboutPane [ text := translate MsgAuthorMenu, help := translate MsgAuthorMenuHelp, on command := openAuthorsWindow mainWindow ] 
        websiteItem  <- menuItem aboutPane [ text := translate MsgHomepageMenu, help := translate MsgHomepageMenuHelp, on command := openHomepage mainWindow ] 
        issueItem <- menuItem aboutPane [ text := translate MsgIssuesMenu, help := translate MsgIssuesMenuHelp, on command := openIssuesPage mainWindow ] 
        toolsItem <- menuItem aboutPane [ text := translate MsgToolsMenu, help := translate MsgToolsMenuHelp, on command := openToolsWindow mainWindow ] 
        tipsItem <- menuItem aboutPane [ text := translate MsgTipsMenu, help := translate MsgTipsMenuHelp, on command := openTipsWindow mainWindow ] 
        docItem <- menuItem aboutPane [ text := translate MsgDocMenu, help := translate MsgDocMenuHelp, on command := openDocWindow mainWindow ]
        toolMenu tbar docItem (translate MsgDocMenu) (getAppIconsPath ++ "/doc-window.png")  []
        toolMenu tbar issueItem (translate MsgIssuesMenu) (getAppIconsPath ++ "/issue-window.png")  []
        return aboutPane
