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

module ProjectManagement.HasdocGen.File.View
(
runPdfPreview
)
where


import System.Process
import System.Directory
import System.Exit
import ProjectManagement.HasdocGen.File.Settings 
    
import Data.AppSettings
import qualified Data.Text as T
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data ViewFile = ViewFile

mkMessage "ViewFile" getAppLangPath "en"




makeTranslator :: (RenderMessage ViewFile ViewFileMessage) => IO (ViewFileMessage -> String)
makeTranslator = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    return (\message -> T.unpack $ renderMsg ViewFile (settLangIntToString $ getSetting' conf languageSett) message)


runPdfPreview :: FilePath -> IO ()
runPdfPreview pdfPath = 
    do
        translate <- makeTranslator
        readTemp <- readTemplate
        case readTemp previewAppSett of
             "Brak" -> return ()
             "Off" -> return ()
             x -> do
                 exec <- findExecutable x
                 case exec of
                       Nothing -> putStrLn $ (translate MsgPathExeError)
                       Just a -> do
                           processApp <- runProcess (readTemp previewAppSett) [pdfPath] Nothing Nothing Nothing Nothing Nothing
                           exitCode <- getProcessExitCode processApp
                           case exitCode of
                                Nothing -> return ()
                                Just ExitSuccess -> putStrLn $ (translate MsgClosedAppSuccess)
                                Just (ExitFailure x) -> putStrLn $ (translate MsgClosedAppError) ++ (show x)
             "" -> return ()
             _ -> return ()
