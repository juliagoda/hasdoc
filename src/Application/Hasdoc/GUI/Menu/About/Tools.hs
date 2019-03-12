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

            
module Application.Hasdoc.GUI.Menu.About.Tools
(
openToolsWindow
) 
where

import Graphics.UI.WX
import Graphics.UI.WX.Window
import Graphics.UI.WXCore

import System.IO.Unsafe
import Application.Hasdoc.Settings.General 

import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data ToolsWindow = ToolsWindow

mkMessage "ToolsWindow" (unsafePerformIO $ chooseTransPath) "en"




openToolsWindow :: Frame () -> IO ()
openToolsWindow mainWindow = 
    do 
        translate <- makeTranslator ToolsWindow
        toolsWindow <- dialog mainWindow [text := (translate MsgToolsMenu), visible := True, clientSize  := sz 640 480, picture := (getAppIconsPath ++ "/tools-window.png")] 
        p <- panel toolsWindow []
        titleText <- staticText p [ text := (translate MsgToolsMenu), fontSize := 16, fontWeight := WeightBold ]
        authorsText <- staticText p [ text := (translate MsgToolsDesc), fontSize := 12, fontShape := ShapeItalic ]
        set toolsWindow [ layout := fill $ minsize (sz 640 480) $ margin 10 $ container p $
                 column 5 [floatTop $ marginTop $ margin 20 $ widget titleText, minsize (sz 500 300) $ floatCenter $ marginBottom $ margin 20 $ widget authorsText] ]
