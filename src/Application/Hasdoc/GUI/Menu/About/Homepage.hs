module Application.Hasdoc.GUI.Menu.About.Homepage
(
openHomepage
) 
where


import Graphics.UI.WX
import Web.Browser (openBrowser)
import Application.Hasdoc.GUI.Menu.About


openHomepage :: Frame () -> IO ()
openHomepage mainWindow = openBrowser "https://github.com/juliagoda/hasdoc" >>= showBrowserStatus mainWindow
    
