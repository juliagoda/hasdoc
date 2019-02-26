module Application.Hasdoc.GUI.Menu.About.Tips
(
openTipsWindow
) where

import Graphics.UI.WX
import Graphics.UI.WX.Window
import Graphics.UI.WXCore

import Application.Hasdoc.Settings.General



openTipsWindow :: Frame () -> IO ()
openTipsWindow mainWindow = 
    do 
        tipsWindow <- dialog mainWindow [text := "Wskazówki", visible := True, clientSize  := sz 640 480, picture := (getAppIconsPath ++ "/tips-window.png")] 
        return ()
