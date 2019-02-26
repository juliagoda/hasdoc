module Application.Hasdoc.GUI.Menu.Program.AppClose
(
closeMainWindow
) where
    

import Graphics.UI.WX

closeMainWindow :: Frame () -> IO ()
closeMainWindow mainWindow =
    do
        answer <- confirmDialog mainWindow "Potwierdzenie" "Czy na pewno chcesz zamknąć aplikację?" True
        if answer
           then do close mainWindow
           else return ()
