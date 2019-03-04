module Application.Hasdoc.GUI.Menu.Program.StateLoad
(
openFileDialog
) where


import Graphics.UI.WX

import Data.Ini

-- IO (Maybe FilePath)
openFileDialog :: Frame () -> FilePath -> String -> [(String, [String])] -> IO ()
openFileDialog mainWindow title path regex = 
    do 
        fileState <- fileOpenDialog mainWindow True True title regex path ""
        case fileState of
             Nothing -> return ()
             Just x -> do
                 readIniFile x
                 return ()
