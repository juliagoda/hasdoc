module ProjectManagement.HasdocGen.GUI.Site.End
(
createEndPage
)
where

import Data.Bits
import Graphics.UI.WX
import Graphics.UI.WX.Controls
import Graphics.UI.WXCore.WxcTypes
import Graphics.UI.WXCore
import Graphics.UI.WXCore.Frame
import Graphics.UI.WX.Window
import System.IO.Unsafe

import Control.Monad
import Control.Monad.Plus

import ProjectManagement.HasdocGen.File.Print
import ProjectManagement.HasdocGen.File.HTML



createEndPage :: Frame () -> Wizard () -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> IO (WizardPageSimple ())
createEndPage mainwindow mainwizard defWidgets reqWidgets archWidgets techWidgets testWidgets = 
    do
        endPage <- wizardPageSimple mainwizard [text := "Koniec", style := wxHELP ]
        
        sw <- scrolledWindow endPage [ scrollRate := sz 10 10, style := wxVSCROLL ]
        
        st1 <- staticText sw [text := "Koniec", fontSize := 16, fontWeight := WeightBold ]
        st2 <- staticText sw [text := "Możesz sprawdzić poprawność wprowadzonych danych, naciskając na przycisk \"Sprawdź dane\" lub możesz od razu przejść do generowania plików i opcji drukowania, naciskając w przycisk \"Generuj plik\"."]
        
        generate <- button sw [text := "Generuj plik", tooltip := "Uruchamia kolejno sekwencję : testowanie wprowadzonych dotychczasowych danych, generowanie pliku, podgląd, drukowanie", on command := runGenerationSeq mainwindow defWidgets reqWidgets archWidgets techWidgets testWidgets ]
        check <- button sw [text := "Sprawdź dane", tooltip := "Uruchamia same testy wprowadzonych danych z całego wizarda. Opcjonalne rubryki mogą zostać puste.", on command := checkAllEntries mainwindow defWidgets reqWidgets archWidgets techWidgets testWidgets ]
        
        set sw [ layout := fill $ minsize (sz 500 700) $ margin 10 $ column 5 [floatTop $ marginTop $ margin 20 $ widget st1, minsize (sz 400 300) $ floatCenter $ marginBottom $ margin 20 $ widget st2, floatCenter $ marginTop $ margin 20 $ minsize (sz 200 100) $ row 5 [widget check, widget generate]]]
        
        set endPage [layout := fill $ widget sw]
        
        return endPage

        
        
runGenerationSeq :: Frame () -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> IO ()
runGenerationSeq mainwindow defWidgets reqWidgets archWidgets techWidgets testWidgets = 
    do
        checkAllEntries mainwindow defWidgets reqWidgets archWidgets techWidgets testWidgets
        writeHtml (mapAndFilter defWidgets) (mapAndFilter reqWidgets) (mapAndFilter archWidgets) (mapAndFilter techWidgets) (mapAndFilter testWidgets)
--         createPreview mainwindow defFiltered
--         printFile mainwindow defFiltered
        

mapAndFilter :: [(StaticText (), TextCtrl ())] -> Maybe [(String, String)]          
mapAndFilter listWidgets = mapToStrings listWidgets >>= filterEmptyLines        
        

checkAllEntries :: Frame () -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> IO ()
checkAllEntries mainWindow defWidgets reqWidgets archWidgets techWidgets testWidgets = checkIfAllEmpty mainWindow (mapAndFilter defWidgets) (mapAndFilter reqWidgets) (mapAndFilter archWidgets) (mapAndFilter techWidgets) (mapAndFilter testWidgets)


checkIfAllEmpty :: Frame () -> Maybe [(String, String)] -> Maybe [(String, String)] -> Maybe [(String, String)] -> Maybe [(String, String)] -> Maybe [(String, String)] -> IO ()
checkIfAllEmpty mainWindow defWidgets reqWidgets archWidgets techWidgets testWidgets = case defWidgets `mplus` reqWidgets `mplus` archWidgets `mplus` techWidgets `mplus` testWidgets of
                                                                                 Nothing -> warningDialog mainWindow "ostrzeżenie" "żadne pole nie zostało wypełnione"
                                                                                 Just [x] -> warningDialog mainWindow "ostrzeżenie" "coś tam jest"


mapToStrings :: [(StaticText (), TextCtrl ())] -> Maybe [(String, String)]
mapToStrings tabWidgets = Just $ [(unsafePerformIO $ get a text, unsafePerformIO $ get b text) | (a, b) <- tabWidgets] 
--mapM (\(x,y) -> return $ (unsafePerformIO $ get (fst x) text, unsafePerformIO $ get (snd y) text)) tabWidgets


--filterEmptyLines :: [(StaticText (), TextCtrl ())] -> IO [(StaticText (), TextCtrl ())]
--filterEmptyLines answers = filterM (\x -> liftM (not . null) $ get (snd x) text) answers


filterEmptyLines :: [(String, String)] -> Maybe [(String, String)]
filterEmptyLines answers = case filter (not . null . snd) answers of
                                [] -> Nothing
                                x -> Just x 
