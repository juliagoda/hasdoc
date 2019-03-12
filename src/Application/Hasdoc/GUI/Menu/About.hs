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


module Application.Hasdoc.GUI.Menu.About
(
showBrowserStatus
) 
where


import Graphics.UI.WX
import System.IO.Unsafe
import Application.Hasdoc.Settings.General 

import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data AboutMenu = AboutMenu

mkMessage "AboutMenu" (unsafePerformIO $ chooseTransPath) "en"



showBrowserStatus :: Frame () -> Bool -> IO ()
showBrowserStatus mainWindow True = return ()
showBrowserStatus mainWindow False = 
    do 
        translate <- makeTranslator AboutMenu
        errorDialog mainWindow (translate MsgErrorBrowser) (translate MsgErrorBrowserDesc)
