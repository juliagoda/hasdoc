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


module ProjectManagement.HasdocGen.GUI.Site.Tests
(
createTestsPage
)
where

import Data.Bits
import Graphics.UI.WX
import Graphics.UI.WX.Controls
import Graphics.UI.WXCore.WxcTypes
import Graphics.UI.WXCore
import Graphics.UI.WXCore.Frame
import Graphics.UI.WX.Window

import ProjectManagement.HasdocGen.File.Print
import ProjectManagement.HasdocGen.Text.Site.Tests.Content
import ProjectManagement.HasdocGen.Text.Site.Tests.Help
import ProjectManagement.HasdocGen.File.Settings

import Data.AppSettings
import qualified Data.Text as T
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data TestsPage = TestsPage

mkMessage "TestsPage" getAppLangPath "en"


makeTranslator :: (RenderMessage TestsPage TestsPageMessage) => IO (TestsPageMessage -> String)
makeTranslator = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    return (\message -> T.unpack $ renderMsg TestsPage (settLangIntToString $ getSetting' conf languageSett) message)


    
    
createTestsPage :: Wizard () -> IO (WizardPageSimple (), [(StaticText (), TextCtrl ())])
createTestsPage mainwizard = 
    do        
        translate <- makeTranslator
        testPage <- wizardPageSimple mainwizard [text := (translate MsgTestsTitle), style := wxEVT_WIZARD_HELP, identity := 1089]
        sw <- scrolledWindow testPage [ scrollRate := sz 10 10, style := wxVSCROLL, identity := 1090]
        
        
        titleText <- staticText sw [ text := (translate MsgTestsTitle), fontSize := 16, fontWeight := WeightBold, identity := 1091]
   
        labelText1 <- staticText sw [ text := task1, fontShape := ShapeItalic, identity := 1092]
        desc1 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint1, identity := 201] 
        
        labelText2 <- staticText sw [ text := task2, fontShape := ShapeItalic, identity := 1093]
        desc2 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint2, identity := 202]
        
        labelText3 <- staticText sw [ text := task3, fontShape := ShapeItalic, identity := 1094]
        desc3 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint3, identity := 203]
        
        labelText4 <- staticText sw [ text := task4, fontShape := ShapeItalic, identity := 1095]
        desc4 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint4, identity := 204] 
        
        labelText5 <- staticText sw [ text := task5, fontShape := ShapeItalic, identity := 1096]
        desc5 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint5, identity := 205] 
        
        labelText6 <- staticText sw [ text := task6, fontShape := ShapeItalic, identity := 1097]
        desc6 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint6, identity := 206] 
        
        labelText7 <- staticText sw [ text := task7, fontShape := ShapeItalic, identity := 1098]
        desc7 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint7, identity := 207] 
        
        labelText8 <- staticText sw [ text := task8, fontShape := ShapeItalic, identity := 1099]
        desc8 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint8, identity := 208] 
        
        labelText9 <- staticText sw [ text := task9, fontShape := ShapeItalic, identity := 1100]
        desc9 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint9, identity := 209]
        
        labelText10 <- staticText sw [ text := task10, fontShape := ShapeItalic, identity := 1101]
        desc10 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint10, identity := 210]
        
        labelText11 <- staticText sw [ text := task11, fontShape := ShapeItalic, identity := 1102]
        desc11 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint11, identity := 211] 
        
        labelText12 <- staticText sw [ text := task12, fontShape := ShapeItalic, identity := 1103]
        desc12 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint12, identity := 212] 
        
        labelText13 <- staticText sw [ text := task13, fontShape := ShapeItalic, identity := 1104]
        desc13 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint13, identity := 213]
        
        labelText14 <- staticText sw [ text := task14, fontShape := ShapeItalic, identity := 1105]
        desc14 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint14, identity := 214] 

        let widgetsPairs = [(labelText1, desc1), (labelText2, desc2), (labelText3, desc3), (labelText4, desc4), (labelText5, desc5)]
        
        
        set sw [layout := margin 10 $ column 5 [ floatTop $ marginTop $ margin 20 $ widget titleText, floatCenter $ marginBottom $ margin 20 (grid 3 5 [[fill $ minsize (sz 200 100) $ widget labelText1, fill $ minsize (sz 200 100) $ widget desc1], [fill $ minsize (sz 200 100) $ widget labelText2, fill $ minsize (sz 200 100) $ widget desc2], [fill $ minsize (sz 200 100) $ widget labelText3, fill $ minsize (sz 200 100) $ widget desc3], [fill $ minsize (sz 200 100) $ widget labelText4, fill $ minsize (sz 200 100) $ widget desc4], [fill $ minsize (sz 200 100) $ widget labelText5, fill $ minsize (sz 200 100) $ widget desc5], [fill $ minsize (sz 200 100) $ widget labelText6, fill $ minsize (sz 200 100) $ widget desc6], [fill $ minsize (sz 200 100) $ widget labelText7, fill $ minsize (sz 200 100) $ widget desc7], [fill $ minsize (sz 200 100) $ widget labelText8, fill $ minsize (sz 200 100) $ widget desc8], [fill $ minsize (sz 200 100) $ widget labelText9, fill $ minsize (sz 200 100) $ widget desc9], [fill $ minsize (sz 200 100) $ widget labelText10, fill $ minsize (sz 200 100) $ widget desc10], [fill $ minsize (sz 200 100) $ widget labelText11, fill $ minsize (sz 200 100) $ widget desc11], [fill $ minsize (sz 200 100) $ widget labelText12, fill $ minsize (sz 200 100) $ widget desc12], [fill $ minsize (sz 200 100) $ widget labelText13, fill $ minsize (sz 200 100) $ widget desc13], [fill $ minsize (sz 200 100) $ widget labelText14, fill $ minsize (sz 200 100) $ widget desc14]])]]
        
        set testPage [layout := fill $ widget sw]
        
        return $ (,) testPage widgetsPairs
