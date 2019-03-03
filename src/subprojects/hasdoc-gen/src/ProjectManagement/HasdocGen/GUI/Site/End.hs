module ProjectManagement.HasdocGen.GUI.Site.End
(
createEndPage
)
where

import Data.Bits
import Data.Char
import Graphics.UI.WX
import Graphics.UI.WX.Controls
import Graphics.UI.WXCore.WxcTypes
import Graphics.UI.WXCore
import Graphics.UI.WXCore.Frame
import Graphics.UI.WX.Window
import System.IO.Unsafe

import Control.Monad
import Control.Monad.Plus
import Control.Concurrent

import ProjectManagement.HasdocGen.File.Print
import ProjectManagement.HasdocGen.File.HTML



createEndPage :: Frame () -> Wizard () -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> IO (WizardPageSimple ())
createEndPage mainwindow mainwizard defWidgets reqWidgets archWidgets techWidgets testWidgets = 
    do
        endPage <- wizardPageSimple mainwizard [text := "Koniec", style := wxHELP ]
        
        sw <- scrolledWindow endPage [ scrollRate := sz 10 10, style := wxVSCROLL ]
        
        st1 <- staticText sw [text := "Koniec", fontSize := 16, fontWeight := WeightBold ]
        st2 <- staticText sw [text := "Możesz sprawdzić poprawność wprowadzonych danych, naciskając na przycisk \"Sprawdź dane\" lub możesz od razu przejść do generowania plików i opcji drukowania, naciskając w przycisk \"Generuj plik\"."]
        
        titleLabel <- staticText sw [text := "Podaj tytuł dla swojego projektu: "]
        titleEntry <- textEntry sw []
        
        generate <- button sw [text := "Generuj plik", tooltip := "Uruchamia kolejno sekwencję : testowanie wprowadzonych dotychczasowych danych, generowanie pliku, podgląd, drukowanie", on command := runGenerationSeq mainwindow defWidgets reqWidgets archWidgets techWidgets testWidgets titleEntry ]
        check <- button sw [text := "Sprawdź dane", tooltip := "Uruchamia same testy wprowadzonych danych z całego wizarda. Opcjonalne rubryki mogą zostać puste.", on command := checkAllEntries mainwindow defWidgets reqWidgets archWidgets techWidgets testWidgets titleEntry ]
        
        set sw [ layout := fill $ minsize (sz 500 700) $ margin 10 $ column 5 [floatTop $ marginTop $ margin 20 $ widget st1, minsize (sz 400 300) $ floatCenter $ marginBottom $ margin 20 $ widget st2, floatCenter $ marginTop $ margin 20 $ minsize (sz 200 100) $ row 5 [widget titleLabel, widget titleEntry], floatCenter $ marginTop $ margin 20 $ minsize (sz 200 100) $ row 5 [widget check, widget generate]]]
        
        set endPage [layout := fill $ widget sw]
        
        return endPage

        
        
runGenerationSeq :: Frame () -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> TextCtrl () -> IO ()
runGenerationSeq mainwindow defWidgets reqWidgets archWidgets techWidgets testWidgets titleEntry = 
    do
        checkAllEntries mainwindow defWidgets reqWidgets archWidgets techWidgets testWidgets titleEntry
        forkIO $ writeChosenFormats (mapAndFilter defWidgets) (mapAndFilter reqWidgets) (mapAndFilter archWidgets) (mapAndFilter techWidgets) (mapAndFilter testWidgets) titleEntry
        --createPreview mainwindow (mapAndFilter defWidgets)
        return ()
--         printFile mainwindow defFiltered
        

mapAndFilter :: [(StaticText (), TextCtrl ())] -> Maybe [(Int, String, String)]          
mapAndFilter listWidgets = mapToStrings listWidgets >>= filterEmptyLines        
        

checkAllEntries :: Frame () -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> TextCtrl () -> IO ()
checkAllEntries mainWindow defWidgets reqWidgets archWidgets techWidgets testWidgets titleEntry = checkIfAllEmpty mainWindow (mapAndFilter defWidgets) (mapAndFilter reqWidgets) (mapAndFilter archWidgets) (mapAndFilter techWidgets) (mapAndFilter testWidgets) titleEntry


checkIfAllEmpty :: Frame () -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> TextCtrl () -> IO ()
checkIfAllEmpty mainWindow defWidgets reqWidgets archWidgets techWidgets testWidgets textEntry = 
    do
        titleText <- get textEntry text
        if null (dropWhile isSpace titleText) then warningDialog mainWindow "ostrzeżenie" "Tytuł projektu nie został podany" else putStrLn $ "Tytuł projektu to " ++ titleText
        case defWidgets `mplus` reqWidgets `mplus` archWidgets `mplus` techWidgets `mplus` testWidgets of
                                                                                 Nothing -> warningDialog mainWindow "ostrzeżenie" "żadne pole nie zostało wypełnione"
                                                                                 Just [] -> warningDialog mainWindow "ostrzeżenie" "żadne pole nie zostało wypełnione"
                                                                                 Just [x] -> return ()
                                                                                 Just ((x,y,z):xs) -> return ()


mapToStrings :: [(StaticText (), TextCtrl ())] -> Maybe [(Int, String, String)]
mapToStrings tabWidgets = Just $ [(unsafePerformIO $ get b identity, unsafePerformIO $ get a text, unsafePerformIO $ get b text) | (a, b) <- tabWidgets] 
--mapM (\(x,y) -> return $ (unsafePerformIO $ get (fst x) text, unsafePerformIO $ get (snd y) text)) tabWidgets


--filterEmptyLines :: [(StaticText (), TextCtrl ())] -> IO [(StaticText (), TextCtrl ())]
--filterEmptyLines answers = filterM (\x -> liftM (not . null) $ get (snd x) text) answers


filterEmptyLines :: [(Int, String, String)] -> Maybe [(Int, String, String)]
filterEmptyLines answers = case filter (not . null . thd) answers of
                                [] -> Nothing
                                x -> Just x 
