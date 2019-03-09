module Main where
import Graphics.UI.WX
import Graphics.UI.WX.Controls
import ProjectManagement.HasdocGen.GUI.MainWizard


main :: IO ()
main = start mainwizard

mainwizard :: IO ()
mainwizard = 
    do 
        window <- frame [text := "Wizard", resizeable := True, visible := True, clientSize  := sz 640 480] 
        openWizard window
        return ()
