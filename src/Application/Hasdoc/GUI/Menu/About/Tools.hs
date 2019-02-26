module Application.Hasdoc.GUI.Menu.About.Tools
(
openToolsWindow
) where

import Graphics.UI.WX
import Graphics.UI.WX.Window
import Graphics.UI.WXCore

import Application.Hasdoc.Settings.General



openToolsWindow :: Frame () -> IO ()
openToolsWindow mainWindow = 
    do 
        toolsWindow <- dialog mainWindow [text := "Narzędzia", visible := True, clientSize  := sz 640 480, picture := (getAppIconsPath ++ "/tools-window.png")] 
        p <- panel toolsWindow []
        titleText <- staticText p [ text := "Narzędzia", fontSize := 16, fontWeight := WeightBold ]
        authorsText <- staticText p [ text := "Poniżej znajduje się lista bibliotek, języków programowania i narzędzi pomocniczych, które były używane podczas tworzenia aplikacji.\n\n Języki programowania: Haskell\n\n Moduły: Pandoc, wxHaskell, AppSettings\n\n IDE: Visual Studio Code\n\n Notatniki: Kate\n\n Pozostałe: GIMP, IconsFLOW (iconsflow.com)", fontSize := 12, fontShape := ShapeItalic ]
        set toolsWindow [ layout := fill $ minsize (sz 640 480) $ margin 10 $ container p $
                 column 5 [floatTop $ marginTop $ margin 20 $ widget titleText, minsize (sz 500 300) $ floatCenter $ marginBottom $ margin 20 $ widget authorsText] ]
