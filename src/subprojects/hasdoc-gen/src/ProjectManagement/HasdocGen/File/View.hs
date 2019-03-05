module ProjectManagement.HasdocGen.File.View
(
runPdfPreview
)
where


import System.Process
import System.Directory
import System.Exit
import ProjectManagement.HasdocGen.File.Settings 



runPdfPreview :: FilePath -> IO ()
runPdfPreview pdfPath = 
    do
        readTemp <- readTemplate
        case readTemp previewAppSett of
             "embedded" -> return ()
             x -> do
                 exec <- findExecutable x
                 case exec of
                       Nothing -> putStrLn $ "Podana ścieżka nie dotyczy programu wykonywalnego"
                       Just a -> do
                           processApp <- runProcess (readTemp previewAppSett) [pdfPath] Nothing Nothing Nothing Nothing Nothing
                           exitCode <- getProcessExitCode processApp
                           case exitCode of
                                Nothing -> return ()
                                Just ExitSuccess -> putStrLn $ "Aplikacja została poprawnie zamknięta"
                                Just (ExitFailure x) -> putStrLn $ "Wystąpił błąd podczas zamykania aplikacji nr: " ++ (show x)
             "" -> return ()
             _ -> return ()
