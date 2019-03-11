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
import Control.Concurrent

import ProjectManagement.HasdocGen.File.Default
import ProjectManagement.HasdocGen.File.Conversion
import ProjectManagement.HasdocGen.File.View
import ProjectManagement.HasdocGen.File.Settings

import Data.AppSettings
import System.IO.Unsafe
import qualified Data.Text as T
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data EndPage = EndPage

mkMessage "EndPage" (unsafePerformIO $ chooseTransPath) "en"



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
        check <- button sw [text := (translate MsgCheckAction), tooltip := (translate MsgCheckHint), on command := checkAllEntries mainwindow defWidgets reqWidgets archWidgets techWidgets testWidgets titleEntry >> return (), identity := 1113]
        
        set sw [ layout := margin 10 $ column 5 [floatTop $ marginTop $ margin 20 $ widget st1, minsize (sz 400 300) $ floatCenter $ marginBottom $ margin 20 $ widget st2, floatCenter $ marginTop $ margin 20 $ minsize (sz 200 100) $ row 5 [widget titleLabel, widget titleEntry], floatCenter $ marginTop $ margin 20 $ minsize (sz 200 100) $ row 5 [widget check, widget generate]]]
        
        set endPage [layout := fill $ widget sw]
        
        return endPage

        
        
runGenerationSeq :: Frame () -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> TextCtrl () -> IO ()
runGenerationSeq mainwindow defWidgets reqWidgets archWidgets techWidgets testWidgets titleEntry = 
    do
        translate <- makeTranslator
        entriesNotEmpty <- checkAllEntries mainwindow defWidgets reqWidgets archWidgets techWidgets testWidgets titleEntry
        if entriesNotEmpty 
           then do 
               projectTitle <- get titleEntry text
               chosenPath <- dirOpenDialog mainwindow True (translate MsgChoosePathProject) ""
               case chosenPath of
                    Nothing -> return ()
                    Just a -> writeDefaultFormats (mapAndFilter defWidgets) (mapAndFilter reqWidgets) (mapAndFilter archWidgets) (mapAndFilter techWidgets) (mapAndFilter testWidgets) titleEntry a >> forkIO (writeChosenFormats (mapAndFilter defWidgets) (mapAndFilter reqWidgets) (mapAndFilter archWidgets) (mapAndFilter techWidgets) (mapAndFilter testWidgets) titleEntry a) >> runPdfPreview (a ++ "/" ++ projectTitle ++ "/project.pdf")
           else do
               return ()
        
                

mapAndFilter :: [(StaticText (), TextCtrl ())] -> Maybe [(Int, String, String)]          
mapAndFilter listWidgets = mapToStrings listWidgets >>= filterEmptyLines        
        

checkAllEntries :: Frame () -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> [(StaticText (), TextCtrl ())] -> TextCtrl () -> IO Bool
checkAllEntries mainWindow defWidgets reqWidgets archWidgets techWidgets testWidgets titleEntry = checkIfAllEmpty mainWindow (mapAndFilter defWidgets) (mapAndFilter reqWidgets) (mapAndFilter archWidgets) (mapAndFilter techWidgets) (mapAndFilter testWidgets) titleEntry


checkIfAllEmpty :: Frame () -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> Maybe [(Int, String, String)] -> TextCtrl () -> IO Bool
checkIfAllEmpty mainWindow defWidgets reqWidgets archWidgets techWidgets testWidgets textEntry = 
    do
        translate <- makeTranslator
        titleText <- get textEntry text
        case null (dropWhile isSpace titleText) of
             True -> (warningDialog mainWindow (translate MsgWarningProject) (translate MsgWaningProjectName)) >> return False
             False -> (putStrLn $ (translate MsgProjectNameConsole) ++ titleText) >> return True
        case defWidgets `mplus` reqWidgets `mplus` archWidgets `mplus` techWidgets `mplus` testWidgets of
                                                                                 Nothing -> warningDialog mainWindow (translate MsgWarningProject) (translate MsgWarningProjectEmpty) >> return False
                                                                                 Just [] -> warningDialog mainWindow (translate MsgWarningProject) (translate MsgWarningProjectEmpty) >> return False
                                                                                 Just [x] -> return True
                                                                                 Just ((x,y,z):xs) -> return True


mapToStrings :: [(StaticText (), TextCtrl ())] -> Maybe [(Int, String, String)]
mapToStrings tabWidgets = Just $ [(unsafePerformIO $ get b identity, unsafePerformIO $ get a text, unsafePerformIO $ get b text) | (a, b) <- tabWidgets] 


filterEmptyLines :: [(Int, String, String)] -> Maybe [(Int, String, String)]
filterEmptyLines answers = case filter (not . null . thd) answers of
                                [] -> Nothing
                                x -> Just x 
