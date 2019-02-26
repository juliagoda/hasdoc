module Application.Hasdoc.GUI.Menu.About
(
showBrowserStatus
) where


import Graphics.UI.WX

showBrowserStatus :: Frame () -> Bool -> IO ()
showBrowserStatus mainWindow True = return ()
showBrowserStatus mainWindow False = errorDialog mainWindow "Błąd" "Niemożliwe było połączenie ze stroną internetową. Sprawdź połączenie z siecią oraz wybór zainstalowanej domyślnej przeglądarki systemowej."
    
