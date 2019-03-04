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


createDefPage :: Wizard () -> IO (WizardPageSimple (), [(StaticText (), TextCtrl ())])
createDefPage mainwizard = 
    do
        defPage <- wizardPageSimple mainwizard [text := "Definicje", style := wxEVT_WIZARD_HELP, identity := 1000]
        --p <- panel archPage []
        sw <- scrolledWindow defPage [ text := "dd", scrollRate := sz 10 10, style := wxVSCROLL, identity := 1001]
        
        
        titleText <- staticText sw [ text := "Definicje", fontSize := 16, fontWeight := WeightBold, identity := 1002 ]
        
        labelText1 <- staticText sw [ text := task1, fontShape := ShapeItalic, identity := 1003 ]
        desc1 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint1, identity := 1 ] 
        
        labelText2 <- staticText sw [ text := task2, fontShape := ShapeItalic, identity := 1004 ]
        desc2 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint2, identity := 2 ] 
        
        labelText3 <- staticText sw [ text := task3, fontShape := ShapeItalic, identity := 1005 ]
        desc3 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint3, identity := 3 ] 
        
        labelText4 <- staticText sw [ text := task4, fontShape := ShapeItalic, identity := 1006 ]
        desc4 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint4, identity := 4 ] 
        
        labelText5 <- staticText sw [ text := task5, fontShape := ShapeItalic, identity := 1007 ]
        desc5 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint5, identity := 5 ] 
        
        labelText6 <- staticText sw [ text := task6, fontShape := ShapeItalic, identity := 1008 ]
        desc6 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint6, identity := 6 ] 
        
        labelText7 <- staticText sw [ text := task7, fontShape := ShapeItalic, identity := 1009 ]
        desc7 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint7, identity := 7 ] 
        
        labelText8 <- staticText sw [ text := task8, fontShape := ShapeItalic, identity := 1010 ]
        desc8 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint8, identity := 8 ] 
        
        labelText9 <- staticText sw [ text := task9, fontShape := ShapeItalic, identity := 1011 ]
        desc9 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint9, identity := 9 ] 
        
        labelText10 <- staticText sw [ text := task10, fontShape := ShapeItalic, identity := 1012 ]
        desc10 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint10, identity := 10 ] 
                
        let widgetsPairs = [(labelText1, desc1), (labelText2, desc2), (labelText3, desc3), (labelText4, desc4), (labelText5, desc5), (labelText6, desc6), (labelText7, desc7), (labelText8, desc8), (labelText9, desc9), (labelText10, desc10)]        
        
        set sw [layout := fill $ minsize (sz 500 600) $ margin 10 $ column 5 [ floatTop $ marginTop $ margin 20 $ widget titleText, minsize (sz 450 600) $ floatCenter $ marginBottom $ margin 20 (grid 3 5 [[widget labelText1, fill $ minsize (sz 400 100) $ widget desc1], [widget labelText2, fill $ minsize (sz 400 100) $ widget desc2], [widget labelText3, fill $ minsize (sz 400 100) $ widget desc3], [widget labelText4, fill $ minsize (sz 400 100) $ widget desc4], [widget labelText5, fill $ minsize (sz 400 100) $ widget desc5], [widget labelText6, fill $ minsize (sz 400 100) $ widget desc6], [widget labelText7, fill $ minsize (sz 400 100) $ widget desc7], [widget labelText8, fill $ minsize (sz 400 100) $ widget desc8], [widget labelText9, fill $ minsize (sz 400 100) $ widget desc9], [widget labelText10, fill $ minsize (sz 400 100) $ widget desc10]])]]
        
        set defPage [layout := fill $ widget sw]
        return $ (,) defPage widgetsPairs
