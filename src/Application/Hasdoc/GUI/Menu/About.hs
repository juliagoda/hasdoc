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
import Data.AppSettings
import qualified Data.Text as T
import System.IO.Unsafe
import Application.Hasdoc.Settings.General 

import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data AboutMenu = AboutMenu

mkMessage "AboutMenu" (unsafePerformIO $ chooseTransPath) "en"



makeTranslator :: (RenderMessage AboutMenu AboutMenuMessage) => IO (AboutMenuMessage -> String)
makeTranslator = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    return (\message -> T.unpack $ renderMsg AboutMenu (settLangIntToString $ getSetting' conf languageSett) message)



showBrowserStatus :: Frame () -> Bool -> IO ()
showBrowserStatus mainWindow True = return ()
showBrowserStatus mainWindow False = 
    do 
        translate <- makeTranslator
        errorDialog mainWindow (translate MsgErrorBrowser) (translate MsgErrorBrowserDesc)
    
