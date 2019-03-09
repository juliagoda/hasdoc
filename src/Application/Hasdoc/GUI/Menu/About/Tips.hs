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

            
module Application.Hasdoc.GUI.Menu.About.Tips
(
openTipsWindow
) 
where

import Graphics.UI.WX
import Graphics.UI.WX.Window
import Graphics.UI.WXCore

import Data.AppSettings
import qualified Data.Text as T
import System.IO.Unsafe

import Application.Hasdoc.Settings.General
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data TipsWindow = TipsWindow

mkMessage "TipsWindow" (unsafePerformIO $ chooseTransPath) "en"



makeTranslator :: (RenderMessage TipsWindow TipsWindowMessage) => IO (TipsWindowMessage -> String)
makeTranslator = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    return (\message -> T.unpack $ renderMsg TipsWindow (settLangIntToString $ getSetting' conf languageSett) message)


openTipsWindow :: Frame () -> IO ()
openTipsWindow mainWindow = 
    do 
        translate <- makeTranslator
        tipsWindow <- dialog mainWindow [text := (translate MsgToolsMenu), visible := True, clientSize  := sz 640 480, picture := (getAppIconsPath ++ "/tips-window.png")] 
        return ()
