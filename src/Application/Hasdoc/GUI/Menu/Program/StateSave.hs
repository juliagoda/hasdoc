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


module Application.Hasdoc.GUI.Menu.Program.StateSave
(
saveFileDialog
) 
where

import Application.Hasdoc.Settings.General 

import Graphics.UI.WX
import qualified Data.Text as T
import qualified Data.HashMap.Strict as H
import Data.Ini
import System.Directory
import System.FilePath (takeExtension)
import Data.Char (isAlphaNum)

import Data.AppSettings


import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data StateSaveWindow = StateSaveWindow

mkMessage "StateSaveWindow" getAppLangPath "en"



makeTranslator :: (RenderMessage StateSaveWindow StateSaveWindowMessage) => IO (StateSaveWindowMessage -> String)
makeTranslator = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    return (\message -> T.unpack $ renderMsg StateSaveWindow (settLangIntToString $ getSetting' conf languageSett) message)


saveFileDialog :: Frame () -> [(String, [String])] -> IO ()
saveFileDialog mainWindow regex = 
    do 
        translate <- makeTranslator
        home <- getHomeDirectory
        tempHdocExists <- doesFileExist (home ++ "/.hasdoc-gen/temp/temp.hdoc")
        
        case tempHdocExists of
             False -> infoDialog mainWindow (translate MsgWarningLabel) (translate MsgNoChangesWarning) 
             True -> do
                 dirPath <- dirOpenDialog mainWindow True (translate MsgSaveLocation) ""
                 fileName <- textDialog mainWindow (translate MsgNameSaveQuestion) (translate MsgNameSave) ""
                 loadedParser <- readIniFile (home ++ "/.hasdoc-gen/temp/temp.hdoc")
                 case all (\x -> isAlphaNum x) fileName of
                      False -> infoDialog mainWindow (translate MsgWarningLabel) (translate MsgNoAllowedChars)
                      True -> case loadedParser of
                                   Left a -> infoDialog mainWindow (translate MsgStateNone) (translate MsgWizardChangesWarning)
                                   Right b -> case keys (T.pack "Answers") b of
                                                   Left c -> infoDialog mainWindow (translate MsgStateNone) (translate MsgWizardChangesWarning)
                                                   Right [] -> infoDialog mainWindow (translate MsgStateNone) (translate MsgWizardChangesWarning)
                                                   Right d -> do
                                                       pathChosen <- (fileSaveDialog mainWindow True True (translate MsgSave) regex (getPathDir dirPath) (fileName ++ ".hdoc"))
                                                       case pathChosen of
                                                            Nothing -> return ()
                                                            Just a -> case takeExtension a of 
                                                                           ".hdoc" -> copyFile (home ++ "/.hasdoc-gen/temp/temp.hdoc") a >> infoDialog mainWindow (translate MsgStateSave) (translate MsgChosenPathSaveResult)
                                                                           _ -> infoDialog mainWindow (translate MsgWarningLabel) (translate MsgNoAllowedExt)

                                                            
                                                                                                        
getPathDir :: Maybe FilePath -> String
getPathDir Nothing = ""
getPathDir (Just x) = x
