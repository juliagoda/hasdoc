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
import Data.AppSettings
import qualified Data.Text as T
import System.IO

import ProjectManagement.HasdocGen.File.HTML
import Application.Hasdoc.Settings.General 

import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data StateLoadWindow = StateLoadWindow

mkMessage "StateLoadWindow" getAppLangPath "en"





makeTranslator :: (RenderMessage StateLoadWindow StateLoadWindowMessage) => IO (StateLoadWindowMessage -> String)
makeTranslator = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    return (\message -> T.unpack $ renderMsg StateLoadWindow (settLangIntToString $ getSetting' conf languageSett) message)  
    
    
-- IO (Maybe FilePath)
openFileDialog :: Frame () -> FilePath -> String -> [(String, [String])] -> Bool -> IO ()
openFileDialog mainWindow title path regex imported = 
    do 
        translate <- makeTranslator
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
        translate <- makeTranslator
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
        
    
