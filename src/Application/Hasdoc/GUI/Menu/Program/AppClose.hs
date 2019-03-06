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


module Application.Hasdoc.GUI.Menu.Program.AppClose
(
closeMainWindow
) 
where
    

import Graphics.UI.WX
import System.Directory
import Data.AppSettings
import qualified Data.Text as T
import Application.Hasdoc.Settings.General 

import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data AppCloseWindow = AppCloseWindow

mkMessage "AppCloseWindow" getAppLangPath "en"



makeTranslator :: (RenderMessage AppCloseWindow AppCloseWindowMessage) => IO (AppCloseWindowMessage -> String)
makeTranslator = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    return (\message -> T.unpack $ renderMsg AppCloseWindow (settLangIntToString $ getSetting' conf languageSett) message)



closeMainWindow :: Frame () -> IO ()
closeMainWindow mainWindow =
    do
        translate <- makeTranslator
        answer <- confirmDialog mainWindow (translate MsgConfirmClose) (translate MsgConfirmCloseQuestion) True
        if answer
           then do 
               home <- getHomeDirectory
               existsTempDir <- doesDirectoryExist (home ++ "/.hasdoc-gen/temp")
               if existsTempDir then removePathForcibly (home ++ "/.hasdoc-gen/temp") else return () 
               close mainWindow
           else return ()
