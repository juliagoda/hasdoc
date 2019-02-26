module Main where
import Graphics.UI.WX
import Graphics.UI.WX.Controls
--import Text.Pandoc.App (convertWithOpts, defaultOpts, options, parseOptions)
--import Text.Pandoc.Error (handleError)

main :: IO ()
main = start mainwizard

mainwizard :: IO ()
mainwizard = 
    do 
        window <- frame [text := "Hasdoc wizard", resizeable := True, visible := True, clientSize  := sz 640 480] 
        mainwiz <- wizard window [text := "Wizard", resizeable := True, visible := True, wizardPageSize := sz 500 700 ]
        firstPage <- wizardPageSimple mainwiz [text := "Wprowadzenie" ]
        secondPage <- wizardPageSimple mainwiz [text := "I strona" ]
        thirdPage <- wizardPageSimple mainwiz [text := "II strona" ]
        chain [firstPage, secondPage, thirdPage]
        runWizard mainwiz firstPage
        return ()
