module Application.Hasdoc.GUI.Menu.Program.StateSave
(
saveFileDialog
) 
where


import Graphics.UI.WX


saveFileDialog :: Frame () -> [(String, [String])] -> IO ()
saveFileDialog mainWindow regex = 
    do 
        dirPath <- dirOpenDialog mainWindow True "Wybierz lokalizację dla zapisania postępu" ""
        fileName <- textDialog mainWindow "Pod jaką nazwą chcesz zapisać postęp?" "Podaj nazwę pliku" ""
        endPath <- fileSaveDialog mainWindow True True "Zapis" regex (getPathDir dirPath) (fileName ++ ".hdoc")
        writeFile (getPathDir endPath) "content"
        return ()
        
        
getPathDir :: Maybe FilePath -> String
getPathDir Nothing = ""
getPathDir (Just x) = x
