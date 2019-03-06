{-# LANGUAGE MultiParamTypeClasses
            ,FlexibleInstances
            ,FlexibleContexts
            ,TypeSynonymInstances
            ,UndecidableInstances
            ,ScopedTypeVariables
            ,TemplateHaskell
            ,OverloadedStrings
            ,DeriveGeneric
            ,AllowAmbiguousTypes
            ,MonoLocalBinds #-}

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
import ProjectManagement.HasdocGen.File.View
import ProjectManagement.HasdocGen.File.Settings

import Data.AppSettings
import qualified Data.Text as T
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data EndPage = EndPage

mkMessage "EndPage" getAppLangPath "en"



makeTranslator :: (RenderMessage EndPage EndPageMessage) => IO (EndPageMessage -> String)
makeTranslator = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    return (\message -> T.unpack $ renderMsg EndPage (settLangIntToString $ getSetting' conf languageSett) message)



createEndPage :: Frame () -> Wizard () -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> IO (WizardPageSimple ())
createEndPage mainwindow mainwizard defWidgets reqWidgets archWidgets techWidgets testWidgets = 
    do
        translate <- makeTranslator
        endPage <- wizardPageSimple mainwizard [text := (translate MsgFinishTitle), style := wxHELP, identity := 1106]
        
        sw <- scrolledWindow endPage [ scrollRate := sz 10 10, style := wxVSCROLL, identity := 1107]
        
        st1 <- staticText sw [text := (translate MsgFinishTitle), fontSize := 16, fontWeight := WeightBold, identity := 1108]
        st2 <- staticText sw [text := (translate MsgFinishDesc), identity := 1109]
        
        titleLabel <- staticText sw [text := (translate MsgProjectName), identity := 1110]
        titleEntry <- textEntry sw [identity := 1111]
        
        generate <- button sw [text := (translate MsgGenerationAction), tooltip := (translate MsgGenerationHint), on command := runGenerationSeq mainwindow defWidgets reqWidgets archWidgets techWidgets testWidgets titleEntry, identity := 1112]
        check <- button sw [text := (translate MsgCheckAction), tooltip := (translate MsgCheckHint), on command := checkAllEntries mainwindow defWidgets reqWidgets archWidgets techWidgets testWidgets titleEntry, identity := 1113]
        
        set sw [ layout := fill $ minsize (sz 500 700) $ margin 10 $ column 5 [floatTop $ marginTop $ margin 20 $ widget st1, minsize (sz 400 300) $ floatCenter $ marginBottom $ margin 20 $ widget st2, floatCenter $ marginTop $ margin 20 $ minsize (sz 200 100) $ row 5 [widget titleLabel, widget titleEntry], floatCenter $ marginTop $ margin 20 $ minsize (sz 200 100) $ row 5 [widget check, widget generate]]]
        
        set endPage [layout := fill $ widget sw]
        
        return endPage

        
        
runGenerationSeq :: Frame () -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> TextCtrl () -> IO ()
runGenerationSeq mainwindow defWidgets reqWidgets archWidgets techWidgets testWidgets titleEntry = 
    do
        translate <- makeTranslator
        projectTitle <- get titleEntry text
        chosenPath <- dirOpenDialog mainwindow True (translate MsgChoosePathProject) ""
        case chosenPath of
             Nothing -> return ()
             Just a -> checkAllEntries mainwindow defWidgets reqWidgets archWidgets techWidgets testWidgets titleEntry >> 
                       writeChosenFormats (mapAndFilter defWidgets) (mapAndFilter reqWidgets) (mapAndFilter archWidgets) (mapAndFilter techWidgets) (mapAndFilter testWidgets) titleEntry a >>
                       runPdfPreview (a ++ "/" ++ projectTitle ++ "/project.pdf")
        return ()
--         printFile mainwindow defFiltered
        

mapAndFilter :: [(StaticText (), TextCtrl ())] -> Maybe [(Int, String, String)]          
mapAndFilter listWidgets = mapToStrings listWidgets >>= filterEmptyLines        
        

checkAllEntries :: Frame () -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> TextCtrl () -> IO ()
checkAllEntries mainWindow defWidgets reqWidgets archWidgets techWidgets testWidgets titleEntry = checkIfAllEmpty mainWindow (mapAndFilter defWidgets) (mapAndFilter reqWidgets) (mapAndFilter archWidgets) (mapAndFilter techWidgets) (mapAndFilter testWidgets) titleEntry


checkIfAllEmpty :: Frame () -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> TextCtrl () -> IO ()
checkIfAllEmpty mainWindow defWidgets reqWidgets archWidgets techWidgets testWidgets textEntry = 
    do
        translate <- makeTranslator
        titleText <- get textEntry text
        if null (dropWhile isSpace titleText) then warningDialog mainWindow (translate MsgWarningProject) (translate MsgWaningProjectName) else putStrLn $ (translate MsgProjectNameConsole) ++ titleText
        case defWidgets `mplus` reqWidgets `mplus` archWidgets `mplus` techWidgets `mplus` testWidgets of
                                                                                 Nothing -> warningDialog mainWindow (translate MsgWarningProject) (translate MsgWarningProjectEmpty)
                                                                                 Just [] -> warningDialog mainWindow (translate MsgWarningProject) (translate MsgWarningProjectEmpty)
                                                                                 Just [x] -> return ()
                                                                                 Just ((x,y,z):xs) -> return ()


mapToStrings :: [(StaticText (), TextCtrl ())] -> Maybe [(Int, String, String)]
mapToStrings tabWidgets = Just $ [(unsafePerformIO $ get b identity, unsafePerformIO $ get a text, unsafePerformIO $ get b text) | (a, b) <- tabWidgets] 


filterEmptyLines :: [(Int, String, String)] -> Maybe [(Int, String, String)]
filterEmptyLines answers = case filter (not . null . thd) answers of
                                [] -> Nothing
                                x -> Just x 
