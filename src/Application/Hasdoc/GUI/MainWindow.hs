module Application.Hasdoc.GUI.MainWindow
(
mainwindow
) 
where


import Graphics.UI.WX

import Application.Hasdoc.GUI.Menu
import Application.Hasdoc.GUI.MainWidget
import Application.Hasdoc.Settings.General

import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())



mainwindow :: IO ()
mainwindow = 
    do 
        window <- frame [text := "Hasdoc", resizeable := True, visible := True, clientSize  := sz 640 480, picture := (getAppIconsPath ++ "/hasdoc.png")]   
        createMainMenu window
        createMainWidget window
        
        status <- statusField [text := ""] 
        set window [statusBar := [status]]
