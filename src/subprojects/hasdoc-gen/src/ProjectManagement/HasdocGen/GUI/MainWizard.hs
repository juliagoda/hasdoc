module ProjectManagement.HasdocGen.GUI.MainWizard
(
openWizard
) 
where

import Data.Bits
import qualified Data.Map.Lazy as Map
import System.IO.Unsafe

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

--import Application.Hasdoc.Settings.General

-- frame  ::             [Prop (Frame ())] -> IO (Frame ())
-- f    <- frame    [text := "Hello!"]

-- button :: Window a -> [Prop (Button ())] -> IO (Button ())
-- quit <- button f [text := "Quit", on command := close f]

-- set    :: w -> [Prop w] -> IO ()
-- set f [layout := widget quit]

-- wizard :: Window a -> [Prop (Wizard ())] -> IO (Wizard ())

-- wizardPageSimple :: Wizard a -> [Prop (WizardPageSimple ())] -> IO (WizardPageSimple ()) -> Create an empty simple wizard page.

-- runWizard :: Wizard a -> WizardPage b -> IO Bool -> Run the wizard.

-- windowDestroyEventGetWindow :: WindowDestroyEvent a -> IO (Window ()) -> usage: (windowDestroyEventGetWindow obj).

-- type WindowDestroyEvent a = CommandEvent (CWindowDestroyEvent a)

-- windowDestroy :: Window a -> IO Bool (to ten)

-- windowDestroyChildren :: Window a -> IO Bool


-- myEventId :: Int
-- myEventId = WXCore.wxID_HIGHEST+100
    -- the custom event ID, avoid clash with Graphics.UI.WXCore.Types.varTopId

-- | the custom event is registered as a menu event
-- createMyEvent :: IO (WXCore.CommandEvent ())
-- createMyEvent =
   -- WXCore.commandEventCreate WXCore.wxEVT_COMMAND_MENU_SELECTED myEventId

-- registerMyEvent :: WXCore.EvtHandler a -> IO () -> IO ()
-- registerMyEvent win io =settings-window
   -- WXCore.evtHandlerOnMenuCommand win myEventId io
   
-- runWizard mainwiz firstPage

-- (Attr w a) := a infixr 0	
-- Assign a value to an attribute.
-- 
-- (Attr w a) :~ (a -> a) infixr 0	
-- Apply an update function to an attribute.
-- 
-- (Attr w a) ::= (w -> a) infixr 0	
-- Assign a value to an attribute with the widget as argument.
-- 
-- (Attr w a) ::~ (w -> a -> a) infixr 0	
-- Apply an update function to an attribute with the widget as an argument.




-- window w funkcji mainwizard zostanie podmieniony na główne okno z poziomu aplikacji głównej
   
-- wizardEvent :: Event (Wizard a) (EventWizard -> IO ())
-- data Event w a -> An event for a widget w that expects an event handler of type a.
-- on :: Event w a -> Attr w a -> Transform an event to an attribute.
-- propagateEvent :: IO () -> Pass the event on the next wxWidgets event handler, either on this window or its parent. Always call this method when you do not process the event. (This function just call skipCurrentEvent).
-- data EventWizard 
-- WizardCancel Veto
-- WizardFinished


-- wizEvents :: [(Int, WizardEvent a -> IO EventWizard)]
-- wizEvents
--     = [(wxEVT_WIZARD_PAGE_CHANGED     ,withDir (withPage WizardPageChanged))
--       ,(wxEVT_WIZARD_PAGE_CHANGING    ,withVeto $ withDir (withPage WizardPageChanging))
--      ,(wxEVT_WIZARD_BEFORE_PAGE_CHANGED, withVeto WizardBeforePageChanged) -- missing from ClassesMZ
--       ,(wxEVT_WIZARD_PAGE_SHOWN       ,withPage WizardPageShown)
--       ,(wxEVT_WIZARD_CANCEL           ,withVeto (withPage WizardCancel))
--       ,(wxEVT_WIZARD_HELP             ,withPage  WizardHelp)
--       ,(wxEVT_WIZARD_FINISHED         ,withPage WizardFinished)]
--     where -- page getter is missing from ClassesMZ, omitting page for the time being

-- windowOnClose :: Window a -> IO () -> IO ()
-- windowOnDestroy :: Window a -> IO () -> IO ()
-- windowOnDelete :: Window a -> IO () -> IO ()


-- calendarEvent :: Event (CalendarCtrl a) (EventCalendar -> IO ())
-- calendarEvent
--   = newEvent "wizardClosing" calendarCtrlGetOnCalEvent calendarCtrlOnCalEvent

        
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
        runWizard mainwizard introPage
                
        return ()
        

-- saves progress
saveTempChanges :: Window a -> EventWizard -> IO ()
saveTempChanges wind ev = 
    case ev of
         WizardCancel veto -> do 
             listOfChildren <- get wind children
             let results1 = map (\x -> unsafePerformIO $ get x children) listOfChildren -- access directly to wizard pages
             let results2 = (map.map) (\x -> unsafePerformIO $ get x children) results1 -- access directly to scrolled windows
             let results = Map.fromList $ concat $ concat $ (map . map . map) (\x -> (,) (unsafePerformIO $ get x identity) (unsafePerformIO $ get x text)) results2 -- access directly to all widgets in scrolled windows
             --res <- Map.lookup 1 results
             case Map.lookup 1 results of 
                  Nothing -> warningDialog wind "warning" "Not found"
                  Just x -> warningDialog wind "warning" x
             propagateEvent
         WizardFinished -> do
             warningDialog wind "warning" "you need a break"
             propagateEvent
         _ -> return ()
         

--holdWizardInputs :: (
--ifContentHold :: (place of content) -> Bool -- check if action from menu "load state" was triggered and if there is some text to put in
         
-- loadSavedState :: Bool -> (Contents) -> IO () -- ifContentHold is True, then get access to all child textctrl widgets of wizard and put values in          
