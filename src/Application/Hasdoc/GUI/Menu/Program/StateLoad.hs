module Application.Hasdoc.GUI.Menu.Program.StateLoad
(
openFileDialog
) 
where


import Graphics.UI.WX
import System.Directory
import Data.Ini


-- IO (Maybe FilePath)
openFileDialog :: Frame () -> FilePath -> String -> [(String, [String])] -> IO ()
openFileDialog mainWindow title path regex = 
    do 
        fileState <- fileOpenDialog mainWindow True True title regex path ""
        case fileState of
             Nothing -> return ()
             Just x -> do
                 home <- getHomeDirectory
                 createDirectoryIfMissing True (home ++ "/.hasdoc-gen/temp")
                 copyFile x (home ++ "/.hasdoc-gen/temp/temp.hdoc") >> infoDialog mainWindow "Odczyt stanu" "Stan został pomyślnie wczytany z wybranego pliku"
                 return ()
