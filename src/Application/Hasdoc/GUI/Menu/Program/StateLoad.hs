module Application.Hasdoc.GUI.Menu.Program.StateLoad
(
openFileDialog
) 
where


import Graphics.UI.WX
import System.Directory
import Data.Ini

import ProjectManagement.HasdocGen.File.HTML


-- IO (Maybe FilePath)
openFileDialog :: Frame () -> FilePath -> String -> [(String, [String])] -> Bool -> IO ()
openFileDialog mainWindow title path regex imported = 
    do 
        fileState <- fileOpenDialog mainWindow True True title regex path ""
        case fileState of
             Nothing -> return ()
             Just x -> do
                 case imported of
                      True -> do importFromFile mainWindow x
                      False -> do loadState mainWindow x
                          

loadState :: Frame () -> FilePath -> IO ()
loadState mainWindow filepath = 
    do
        home <- getHomeDirectory
        createDirectoryIfMissing True (home ++ "/.hasdoc-gen/temp")
        copyFile filepath (home ++ "/.hasdoc-gen/temp/temp.hdoc") >> infoDialog mainWindow "Odczyt stanu" "Stan został pomyślnie wczytany z wybranego pliku"
        return ()


importFromFile :: Frame () -> FilePath -> IO ()
importFromFile mainWindow filepath = readHtmlFile filepath
        
    
