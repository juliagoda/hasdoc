module ProjectManagement.HasdocGen.GUI.Site.Requirements
(
createReqPage
)
where

import Data.Bits
import Graphics.UI.WX
import Graphics.UI.WX.Controls
import Graphics.UI.WXCore.WxcTypes
import Graphics.UI.WXCore
import Graphics.UI.WX.Window

import ProjectManagement.HasdocGen.Text.Site.Requirements.Help
import ProjectManagement.HasdocGen.Text.Site.Requirements.Content


createReqPage :: Wizard () -> IO (WizardPageSimple (), [(StaticText (), TextCtrl ())])
createReqPage mainwizard = 
    do
        reqPage <- wizardPageSimple mainwizard [text := "Wymagania", style := wxEVT_WIZARD_HELP ]
        --p <- panel archPage []
        sw <- scrolledWindow reqPage [ scrollRate := sz 10 10, style := wxVSCROLL ]
        
        titleText <- staticText sw [ text := "Wymagania", fontSize := 16, fontWeight := WeightBold ]
        
        labelText1 <- staticText sw [ text := task1, fontShape := ShapeItalic ]
        desc1 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint1, identity := 51] 
        
        labelText2 <- staticText sw [ text := task2, fontShape := ShapeItalic ]
        desc2 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint2, identity := 52]
        
        labelText3 <- staticText sw [ text := task3, fontShape := ShapeItalic ]
        desc3 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint3, identity := 53] 
        
        labelText4 <- staticText sw [ text := task4, fontShape := ShapeItalic ]
        desc4 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint4, identity := 54]
        
        labelText5 <- staticText sw [ text := task5, fontShape := ShapeItalic ]
        desc5 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint5, identity := 55]
        
        labelText6 <- staticText sw [ text := task6, fontShape := ShapeItalic ]
        desc6 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint6, identity := 56]
        
        labelText7 <- staticText sw [ text := task7, fontShape := ShapeItalic ]
        desc7 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint7, identity := 57] 
        
        labelText8 <- staticText sw [ text := task8, fontShape := ShapeItalic ]
        desc8 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint8, identity := 58]
        
        labelText9 <- staticText sw [ text := task9, fontShape := ShapeItalic ]
        desc9 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint9, identity := 59] 
        
        labelText10 <- staticText sw [ text := task10, fontShape := ShapeItalic ]
        desc10 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint10, identity := 60]
        
        labelText11 <- staticText sw [ text := task11, fontShape := ShapeItalic ]
        desc11 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint11, identity := 61]
        
        labelText12 <- staticText sw [ text := task12, fontShape := ShapeItalic ]
        desc12 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint12, identity := 62] 
        
        labelText13 <- staticText sw [ text := task13, fontShape := ShapeItalic ]
        desc13 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint13, identity := 63] 
        
        labelText14 <- staticText sw [ text := task14, fontShape := ShapeItalic ]
        desc14 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint14, identity := 64] 
        
        labelText15 <- staticText sw [ text := task15, fontShape := ShapeItalic ]
        desc15 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint15, identity := 65] 
        
        labelText16 <- staticText sw [ text := task16, fontShape := ShapeItalic ]
        desc16 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint16, identity := 66]
        
        labelText17 <- staticText sw [ text := task17, fontShape := ShapeItalic ]
        desc17 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint17, identity := 67]
        
        labelText18 <- staticText sw [ text := task18, fontShape := ShapeItalic ]
        desc18 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint18, identity := 68]
        
        
        let widgetsPairs = [(labelText1, desc1), (labelText2, desc2), (labelText3, desc3), (labelText4, desc4), (labelText5, desc5), (labelText6, desc6), (labelText7, desc7), (labelText8, desc8), (labelText9, desc9), (labelText10, desc10), (labelText11, desc11), (labelText12, desc12), (labelText13, desc13), (labelText14, desc14), (labelText15, desc15), (labelText16, desc16), (labelText17, desc17), (labelText18, desc18)]
        
        
        set sw [layout := fill $ minsize (sz 500 600) $ margin 10 $ column 5 [ floatTop $ marginTop $ margin 20 $ widget titleText, minsize (sz 450 600) $ floatCenter $ marginBottom $ margin 20 (grid 3 5 [[widget labelText1, fill $ minsize (sz 400 100) $ widget desc1], [widget labelText2, fill $ minsize (sz 400 100) $ widget desc2], [widget labelText3, fill $ minsize (sz 400 100) $ widget desc3], [widget labelText4, fill $ minsize (sz 400 100) $ widget desc4], [widget labelText5, fill $ minsize (sz 400 100) $ widget desc5], [widget labelText6, fill $ minsize (sz 400 100) $ widget desc6], [widget labelText7, fill $ minsize (sz 400 100) $ widget desc7], [widget labelText8, fill $ minsize (sz 400 100) $ widget desc8], [widget labelText9, fill $ minsize (sz 400 100) $ widget desc9], [widget labelText10, fill $ minsize (sz 400 100) $ widget desc10], [widget labelText11, fill $ minsize (sz 400 100) $ widget desc11], [widget labelText12, fill $ minsize (sz 400 100) $ widget desc12], [widget labelText13, fill $ minsize (sz 400 100) $ widget desc13], [widget labelText14, fill $ minsize (sz 400 100) $ widget desc14], [widget labelText15, fill $ minsize (sz 400 100) $ widget desc15], [widget labelText16, fill $ minsize (sz 400 100) $ widget desc16], [widget labelText17, fill $ minsize (sz 400 100) $ widget desc17], [widget labelText18, fill $ minsize (sz 400 100) $ widget desc18]])]]
        
        set reqPage [layout := fill $ widget sw]
        return $ (,) reqPage widgetsPairs
        
        
