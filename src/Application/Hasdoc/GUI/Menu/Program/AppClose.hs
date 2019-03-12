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
import System.IO.Unsafe

import Application.Hasdoc.Settings.General 


import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data AppCloseWindow = AppCloseWindow

mkMessage "AppCloseWindow" (unsafePerformIO $ chooseTransPath) "en"



closeMainWindow :: Frame () -> IO ()
closeMainWindow mainWindow =
    do
        translate <- makeTranslator AppCloseWindow
        answer <- confirmDialog mainWindow (translate MsgConfirmClose) (translate MsgConfirmCloseQuestion) True
        if answer
           then do 
               home <- getHomeDirectory
               existsTempDir <- doesDirectoryExist (home ++ "/.hasdoc-gen/temp")
               if existsTempDir then removePathForcibly (home ++ "/.hasdoc-gen/temp") else return () 
               close mainWindow
           else return ()
