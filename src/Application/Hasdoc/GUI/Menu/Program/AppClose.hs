module Application.Hasdoc.GUI.Menu.Program.AppClose
(
closeMainWindow
) 
where
    

import Graphics.UI.WX
import System.Directory


closeMainWindow :: Frame () -> IO ()
closeMainWindow mainWindow =
    do
        answer <- confirmDialog mainWindow "Potwierdzenie" "Czy na pewno chcesz zamknąć aplikację?" True
        if answer
           then do 
               home <- getHomeDirectory
               existsTempDir <- doesDirectoryExist (home ++ "/.hasdoc-gen/temp")
               if existsTempDir then removePathForcibly (home ++ "/.hasdoc-gen/temp") else return () 
               close mainWindow
           else return ()
