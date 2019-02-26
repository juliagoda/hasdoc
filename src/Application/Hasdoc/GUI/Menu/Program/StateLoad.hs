module Application.Hasdoc.GUI.Menu.Program.StateLoad
(
openFileDialog
) where


import Graphics.UI.WX

-- IO (Maybe FilePath)
openFileDialog :: Frame () -> FilePath -> String -> [(String, [String])] -> IO ()
openFileDialog mainWindow title path regex = fileOpenDialog mainWindow True True title regex path "" >>= print
