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

            
module ProjectManagement.HasdocGen.GUI.Site.Definition
(
createDefPage
)
where

import Data.Bits
import Graphics.UI.WX
import Graphics.UI.WX.Controls
import Graphics.UI.WXCore.WxcTypes
import Graphics.UI.WXCore
import Graphics.UI.WX.Window

import ProjectManagement.HasdocGen.Text.Site.Definition.Help
import ProjectManagement.HasdocGen.Text.Site.Definition.Content
import ProjectManagement.HasdocGen.File.Settings

import System.IO.Unsafe
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data DefPage = DefPage

mkMessage "DefPage" (unsafePerformIO $ chooseTransPath) "en"


    
createDefPage :: Wizard () -> IO (WizardPageSimple (), [(StaticText (), TextCtrl ())])
createDefPage mainwizard = 
    do
        translate <- makeTranslator DefPage
        defPage <- wizardPageSimple mainwizard [text := (translate MsgDefinitionTitle), style := wxEVT_WIZARD_HELP, identity := 1000]
        sw <- scrolledWindow defPage [ scrollRate := sz 10 10, style := wxVSCROLL, identity := 1001]
    
        
        titleText <- staticText sw [ text := (translate MsgDefinitionTitle), fontSize := 16, fontWeight := WeightBold, identity := 1002 ]
        
        labelText1 <- staticText sw [ text := task1, clientSize := sz 100 100, fontShape := ShapeItalic, identity := 1003 ]
        desc1 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint1, identity := 1 ] 
        
        labelText2 <- staticText sw [ text := task2, clientSize := sz 100 100, fontShape := ShapeItalic, identity := 1004 ]
        desc2 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint2, identity := 2 ] 
        
        labelText3 <- staticText sw [ text := task3, clientSize := sz 100 100, fontShape := ShapeItalic, identity := 1005 ]
        desc3 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint3, identity := 3 ] 
        
        labelText4 <- staticText sw [ text := task4, clientSize := sz 100 100, fontShape := ShapeItalic, identity := 1006 ]
        desc4 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint4, identity := 4 ] 
        
        labelText5 <- staticText sw [ text := task5, clientSize := sz 100 100, clientSize := sz 200 100, fontShape := ShapeItalic, identity := 1007 ]
        desc5 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint5, identity := 5 ] 
        
        labelText6 <- staticText sw [ text := task6, clientSize := sz 100 100, fontShape := ShapeItalic, identity := 1008 ]
        desc6 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint6, identity := 6 ] 
        
        labelText7 <- staticText sw [ text := task7, clientSize := sz 100 100, fontShape := ShapeItalic, identity := 1009 ]
        desc7 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint7, identity := 7 ] 
        
        labelText8 <- staticText sw [ text := task8, clientSize := sz 100 100, fontShape := ShapeItalic, identity := 1010 ]
        desc8 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint8, identity := 8 ] 
        
        labelText9 <- staticText sw [ text := task9, clientSize := sz 100 100, fontShape := ShapeItalic, identity := 1011 ]
        desc9 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint9, identity := 9 ] 
        
        labelText10 <- staticText sw [ text := task10, clientSize := sz 100 100, fontShape := ShapeItalic, identity := 1012 ]
        desc10 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint10, identity := 10 ] 
                
                
        let widgetsPairs = [(labelText1, desc1), (labelText2, desc2), (labelText3, desc3), (labelText4, desc4), (labelText5, desc5), (labelText6, desc6), (labelText7, desc7), (labelText8, desc8), (labelText9, desc9), (labelText10, desc10)]        
        
        set sw [layout := margin 10 $ column 5 [ floatTop $ marginTop $ margin 20 $ widget titleText, floatCenter $ marginBottom $ margin 20 (grid 3 5 [[fill $ minsize (sz 200 100) $ widget labelText1, fill $ minsize (sz 200 100) $ widget desc1], [fill $ minsize (sz 200 100) $ widget labelText2, fill $ minsize (sz 200 100) $ widget desc2], [fill $ minsize (sz 200 100) $ widget labelText3, fill $ minsize (sz 200 100) $ widget desc3], [fill $ minsize (sz 200 100) $ widget labelText4, fill $ minsize (sz 200 100) $ widget desc4], [fill $ minsize (sz 200 100) $ widget labelText5, fill $ minsize (sz 200 100) $ widget desc5], [fill $ minsize (sz 200 100) $ widget labelText6, fill $ minsize (sz 200 100) $ widget desc6], [fill $ minsize (sz 200 100) $ widget labelText7, fill $ minsize (sz 200 100) $ widget desc7], [fill $ minsize (sz 200 100) $ widget labelText8, fill $ minsize (sz 200 100) $ widget desc8], [fill $ minsize (sz 200 100) $ widget labelText9, fill $ minsize (sz 200 100) $ widget desc9], [fill $ minsize (sz 200 100) $ widget labelText10, fill $ minsize (sz 200 100) $ widget desc10]])]]
        
        set defPage [layout := fill $ widget sw]
        return $ (,) defPage widgetsPairs
