module Application.Hasdoc.GUI.Menu.Program.StateSave
(
saveFileDialog
) 
where


import Graphics.UI.WX
import qualified Data.Text as T
import qualified Data.HashMap.Strict as H
import Data.Ini


saveFileDialog :: Frame () -> [(String, [String])] -> IO ()
saveFileDialog mainWindow regex = 
    do 
        dirPath <- dirOpenDialog mainWindow True "Wybierz lokalizację dla zapisania postępu" ""
        fileName <- textDialog mainWindow "Pod jaką nazwą chcesz zapisać postęp?" "Podaj nazwę pliku" ""
         
        endPath <- fileSaveDialog mainWindow True True "Zapis" regex (getPathDir dirPath) (fileName ++ ".hdoc")
        let ff = H.fromList [(T.pack "Section1", [( T.pack "1", T.pack "kamień"), (T.pack "2", T.pack "papier"), (T.pack "3", T.pack "nożyce")]), (T.pack "Section2", [(T.pack "1", T.pack "do ręki"), ( T.pack "2", T.pack "do głowy")])]
        writeIniFile (getPathDir endPath) (Ini {iniGlobals=[(T.pack "A", T.pack "1"),(T.pack "B", T.pack "2")], iniSections=ff}) 
        return ()
        
        
getPathDir :: Maybe FilePath -> String
getPathDir Nothing = ""
getPathDir (Just x) = x
