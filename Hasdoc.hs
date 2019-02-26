module Main where
import Graphics.UI.WX
import Application.Hasdoc.GUI.MainWindow (mainwindow)
--import Text.Pandoc.App (convertWithOpts, defaultOpts, options, parseOptions)
--import Text.Pandoc.Error (handleError)

main :: IO ()
main = start mainwindow
