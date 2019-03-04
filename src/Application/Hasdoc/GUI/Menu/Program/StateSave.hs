module Application.Hasdoc.GUI.Menu.Program.StateSave
(
saveFileDialog
) 
where


import Graphics.UI.WX
import qualified Data.Text as T
import qualified Data.HashMap.Strict as H
import Data.Ini
import System.Directory


saveFileDialog :: Frame () -> [(String, [String])] -> IO ()
saveFileDialog mainWindow regex = 
    do 
        dirPath <- dirOpenDialog mainWindow True "Wybierz lokalizację dla zapisania postępu" ""
        fileName <- textDialog mainWindow "Pod jaką nazwą chcesz zapisać postęp?" "Podaj nazwę pliku" ""
        home <- getHomeDirectory
        loadedParser <- readIniFile (home ++ "/.hasdoc-gen/temp/temp.hdoc")
        case loadedParser of
             Left a -> infoDialog mainWindow "Brak stanu" "Zmiany w wizardzie nie były wprowadzane"
             Right b -> case keys (T.pack "Answers") b of
                             Left c -> infoDialog mainWindow "Brak stanu" "Zmiany w wizardzie nie były wprowadzane"
                             Right [] -> infoDialog mainWindow "Brak stanu" "Zmiany w wizardzie nie były wprowadzane"
                             Right d -> do 
                                 pathChosen <- (fileSaveDialog mainWindow True True "Zapis" regex (getPathDir dirPath) (fileName ++ ".hdoc")) 
                                 case pathChosen of
                                      Nothing -> return ()
                                      Just a -> copyFile (home ++ "/.hasdoc-gen/temp/temp.hdoc") a >> infoDialog mainWindow "Zapis stanu" "Stan został pomyślnie zapisany w wybranej ścieżce"
                                                          
        return ()
        
        
getPathDir :: Maybe FilePath -> String
getPathDir Nothing = ""
getPathDir (Just x) = x



