module ProjectManagement.HasdocGen.GUI.MainWizard
(
openWizard
) 
where

import Data.Bits
import Data.Char
import Data.Maybe
import qualified Data.Map.Lazy as Map
import System.IO.Unsafe
import qualified Data.Text as T
import qualified Data.HashMap.Strict as H
import Data.Ini
import System.Directory

import Graphics.UI.WX
import Graphics.UI.WX.Controls
import Graphics.UI.WXCore
import Graphics.UI.WXCore.WxcTypes

import ProjectManagement.HasdocGen.GUI.Site.Introduction
import ProjectManagement.HasdocGen.GUI.Site.Tests
import ProjectManagement.HasdocGen.GUI.Site.Technology
import ProjectManagement.HasdocGen.GUI.Site.Requirements
import ProjectManagement.HasdocGen.GUI.Site.Architecture
import ProjectManagement.HasdocGen.GUI.Site.Definition
import ProjectManagement.HasdocGen.GUI.Site.End

import ProjectManagement.HasdocGen.File.Settings 


        
openWizard :: Frame () -> IO ()
openWizard mainWindow = 
    do        
        mainwizard <- wizard mainWindow [text := "Wizard", resizeable := True, visible := True, wizardPageSize := sz 500 700, clipChildren := False, tabTraversal := True, on wizardEvent ::= saveTempChanges]-- picture := (getAppIconsPath ++ "/wizard.png")]
        
        introPage <- createIntroPage mainwizard
        defPage <- createDefPage mainwizard
        let defWidgets = snd defPage 
        reqPage <- createReqPage mainwizard
        let reqWidgets = snd reqPage
        archPage <- createArchPage mainwizard
        let archWidgets = snd archPage
        techPage <- createTechPage mainwizard
        let techWidgets = snd techPage
        testPage <- createTestsPage mainwizard
        let testWidgets = snd testPage
        endPage <- createEndPage mainWindow mainwizard defWidgets reqWidgets archWidgets techWidgets testWidgets
        
        chain [introPage, fst defPage, fst reqPage, fst archPage, fst techPage, fst testPage, endPage]
        loadAbortedChanges mainwizard
        
        runWizard mainwizard introPage
        
        return ()
        

-- saves progress
saveTempChanges :: Window a -> EventWizard -> IO ()
saveTempChanges wind ev = 
    case ev of
         WizardCancel veto -> do 
             saveAll wind
             propagateEvent
         WizardFinished -> do
             saveAll wind
             propagateEvent
         _ -> return ()
         
         
saveAll :: Window a -> IO ()
saveAll wizardParent = 
    do 
        listOfChildren <- get wizardParent children
        let results1 = map (\x -> unsafePerformIO $ get x children) listOfChildren -- access directly to wizard pages
        let results2 = (map.map) (\x -> unsafePerformIO $ get x children) results1 -- access directly to scrolled windows
        let results = filter (not . null . snd) $ concat $ concat $ (map . map . map) (\x -> if (unsafePerformIO $ get x identity) < 215 && not (all isSpace (unsafePerformIO $ get x text)) then (,) (show $ unsafePerformIO $ get x identity) (unsafePerformIO $ get x text) else (,) "" "") results2 -- access directly to all widgets in scrolled windows
        let hhash = H.fromList [(T.pack "Answers", [(T.pack x, T.pack y) | (x,y) <- results] )]
        home <- getHomeDirectory
        createDirectoryIfMissing True (home ++ "/.hasdoc-gen/temp")
        writeIniFile (home ++ "/.hasdoc-gen/temp/temp.hdoc") (Ini {iniGlobals=mempty, iniSections=hhash})
        
        
loadAbortedChanges :: Window a -> IO ()
loadAbortedChanges wizardParent = 
    do
        home <- getHomeDirectory
        tempHdocExists <- doesFileExist (home ++ "/.hasdoc-gen/temp/temp.hdoc")
        case tempHdocExists of
             False -> return ()
             True -> do
                 loadedParser <- readIniFile (home ++ "/.hasdoc-gen/temp/temp.hdoc")
                 case loadedParser of
                      Left a -> putStrLn $ a
                      Right b -> case keys (T.pack "Answers") b of
                                      Left c -> putStrLn $ c
                                      Right d -> case hashValues (T.pack "Answers") b of
                                                      Left e -> putStrLn $ e
                                                      Right f -> do
                                                          let mapList = Map.fromList $ zip d f
                                                          listOfChildren <- get wizardParent children
                                                          let results1 = map (\x -> unsafePerformIO $ get x children) listOfChildren
                                                          let results2 = (map . map) (\x -> unsafePerformIO $ get x children) results1
                                                          sequence_ $ concat $ concat $ (map . map . map) (\x -> set x [text := T.unpack (fromMaybe (T.pack $ unsafePerformIO (get x text)) (Map.lookup (T.pack $ show $ unsafePerformIO $ get x identity) mapList))]) results2
             
       
             
-- based on http://hackage.haskell.org/package/ini-0.4.1/docs/src/Data.Ini.html#keys             
hashValues :: T.Text -- ^ Section name
     -> Ini -> Either String [T.Text]
hashValues name i =
  case H.lookup name (iniSections i) of
    Nothing -> Left ("Couldn't find section: " ++ T.unpack name)
    Just section -> Right (map snd section)
        
