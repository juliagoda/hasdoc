module Application.Hasdoc.GUI.MainWindow
(
mainwindow
) 
where


import Graphics.UI.WX

import Application.Hasdoc.GUI.Menu
import Application.Hasdoc.GUI.MainWidget
import Application.Hasdoc.Settings.General

import System.Directory

import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())



mainwindow :: IO ()
mainwindow = 
    do 
        window <- frame [text := "Hasdoc", resizeable := True, visible := True, clientSize  := sz 640 480, picture := (getAppIconsPath ++ "/hasdoc.png"), on closing := removeTempDir ]   
        tbar   <- toolBar window []
        createMainMenu window tbar
        createMainWidget window
        
        status <- statusField [text := ""] 
        set window [statusBar := [status]]


removeTempDir :: IO ()
removeTempDir = do
    home <- getHomeDirectory
    existsTempDir <- doesDirectoryExist (home ++ "/.hasdoc-gen/temp")
    if existsTempDir then removePathForcibly (home ++ "/.hasdoc-gen/temp") else return ()
    propagateEvent
