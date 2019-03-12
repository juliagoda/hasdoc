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


module Application.Hasdoc.GUI.Menu.About.Doc
(
openDocWindow
) 
where

import Graphics.UI.WX
import Graphics.UI.WX.Window
import Graphics.UI.WXCore

import System.IO.Unsafe

import Application.Hasdoc.Settings.General


import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data DocWindow = DocWindow

mkMessage "DocWindow" (unsafePerformIO $ chooseTransPath) "en"



openDocWindow :: Frame () -> IO ()
openDocWindow mainWindow = 
    do 
        translate <- makeTranslator DocWindow
        docWindow <- dialog mainWindow [text := (translate MsgDocMenu), visible := True, clientSize  := sz 640 480, picture := (getAppIconsPath ++ "/doc-window.png")] 
        return ()
