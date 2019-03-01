module Application.Hasdoc.GUI.Menu.About.Issues
(
openIssuesPage
) 
where


import Graphics.UI.WX
import Web.Browser (openBrowser)
import Application.Hasdoc.GUI.Menu.About


openIssuesPage :: Frame() -> IO ()
openIssuesPage mainWindow = openBrowser "https://github.com/juliagoda/hasdoc/issues" >>= showBrowserStatus mainWindow
