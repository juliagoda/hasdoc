module Application.Hasdoc.GUI.Menu.About.Doc
(
openDocWindow
) where

import Graphics.UI.WX
import Graphics.UI.WX.Window
import Graphics.UI.WXCore

import Application.Hasdoc.Settings.General



openDocWindow :: Frame () -> IO ()
openDocWindow mainWindow = 
    do 
        docWindow <- dialog mainWindow [text := "Dokumentacja", visible := True, clientSize  := sz 640 480, picture := (getAppIconsPath ++ "/doc-window.png")] 
        return ()
