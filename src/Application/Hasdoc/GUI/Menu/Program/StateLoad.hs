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


module Application.Hasdoc.GUI.Menu.Program.StateLoad
(
openFileDialog
) 
where


import Graphics.UI.WX
import System.Directory
import Data.Ini
import qualified Data.Text as T
import System.IO
import System.IO.Unsafe

import ProjectManagement.HasdocGen.File.Default
import Application.Hasdoc.Settings.General 

import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())



data StateLoadWindow = StateLoadWindow

mkMessage "StateLoadWindow" (unsafePerformIO $ chooseTransPath) "en"

    
    
-- IO (Maybe FilePath)
openFileDialog :: Frame () -> FilePath -> String -> [(String, [String])] -> Bool -> IO ()
openFileDialog mainWindow title path regex imported = 
    do 
        translate <- makeTranslator StateLoadWindow
        fileState <- fileOpenDialog mainWindow True True title regex path ""
        case fileState of
             Nothing -> return ()
             Just x -> do
                 sz <- withFile x ReadMode hFileSize 
                 if (sz < 11) then infoDialog mainWindow (translate MsgWarningLabel) (translate MsgNoSufficientData) 
                              else case imported of 
                                        True -> do importFromFile mainWindow x
                                        False -> do loadState mainWindow x
                 
                          

loadState :: Frame () -> FilePath -> IO ()
loadState mainWindow filepath = 
    do
        translate <- makeTranslator StateLoadWindow
        home <- getHomeDirectory
        loadedParser <- readIniFile filepath
        case loadedParser of
             Left a -> infoDialog mainWindow (translate MsgStateNone) (translate MsgNoChangesInFile)
             Right b -> case keys (T.pack "Answers") b of
                             Left c -> infoDialog mainWindow (translate MsgStateNone) (translate MsgNoChangesInFile)
                             Right [] -> infoDialog mainWindow (translate MsgStateNone) (translate MsgNoChangesInFile)
                             Right d -> createDirectoryIfMissing True (home ++ "/.hasdoc-gen/temp") >> 
                                 copyFile filepath (home ++ "/.hasdoc-gen/temp/temp.hdoc") >> infoDialog mainWindow (translate MsgLoadState) (translate MsgLoadStateResult) >> return ()


importFromFile :: Frame () -> FilePath -> IO ()
importFromFile mainWindow filepath = readHtmlFile mainWindow filepath
        
