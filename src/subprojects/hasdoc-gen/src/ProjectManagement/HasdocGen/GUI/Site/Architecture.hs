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

            
module ProjectManagement.HasdocGen.GUI.Site.Architecture
(
createArchPage
)
where

import Data.Bits
import Graphics.UI.WX
import Graphics.UI.WX.Controls
import Graphics.UI.WXCore.WxcTypes
import Graphics.UI.WXCore
import Graphics.UI.WX.Window

import ProjectManagement.HasdocGen.Text.Site.Architecture.Help
import ProjectManagement.HasdocGen.Text.Site.Architecture.Content
import ProjectManagement.HasdocGen.File.Settings

import System.IO.Unsafe
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data ArchPage = ArchPage

mkMessage "ArchPage" (unsafePerformIO $ chooseTransPath) "en"



createArchPage :: Wizard () -> IO (WizardPageSimple (), [(StaticText (), TextCtrl ())])
createArchPage mainwizard = 
    do
        translate <- makeTranslator ArchPage
        archPage <- wizardPageSimple mainwizard [text := (translate MsgArchTitle), style := wxEVT_WIZARD_HELP, identity := 1034]
        sw <- scrolledWindow archPage [ scrollRate := sz 10 10, style := wxVSCROLL, identity := 1035]
        
        
        titleText <- staticText sw [ text := (translate MsgArchTitle), fontSize := 16, fontWeight := WeightBold, identity := 1036]
        
        labelText1 <- staticText sw [ text := task1, fontShape := ShapeItalic, identity := 1037]
        desc1 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint1, identity := 101] 
        
        labelText2 <- staticText sw [ text := task2, fontShape := ShapeItalic, identity := 1038]
        desc2 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint2, identity := 102] 
        
        labelText3 <- staticText sw [ text := task3, fontShape := ShapeItalic, identity := 1039]
        desc3 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint3, identity := 103]  
        
        labelText4 <- staticText sw [ text := task4, fontShape := ShapeItalic, identity := 1040]
        desc4 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint4, identity := 104]  
        
        labelText5 <- staticText sw [ text := task5, fontShape := ShapeItalic, identity := 1041]
        desc5 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint5, identity := 105]  
        
        labelText6 <- staticText sw [ text := task6, fontShape := ShapeItalic, identity := 1042]
        desc6 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint6, identity := 106]  
        
        labelText7 <- staticText sw [ text := task7, fontShape := ShapeItalic, identity := 1043]
        desc7 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint7, identity := 107] 
        
        labelText8 <- staticText sw [ text := task8, fontShape := ShapeItalic, identity := 1044]
        desc8 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint8, identity := 108]  
        
        labelText9 <- staticText sw [ text := task9, fontShape := ShapeItalic, identity := 1045]
        desc9 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint9, identity := 109]  
        
        labelText10 <- staticText sw [ text := task10, fontShape := ShapeItalic, identity := 1046]
        desc10 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint10, identity := 110] 
        
        labelText11 <- staticText sw [ text := task11, fontShape := ShapeItalic, identity := 1047]
        desc11 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint11, identity := 111]  
        
        labelText12 <- staticText sw [ text := task12, fontShape := ShapeItalic, identity := 1048]
        desc12 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint12, identity := 112] 
        
        labelText13 <- staticText sw [ text := task13, fontShape := ShapeItalic, identity := 1049]
        desc13 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint13, identity := 113] 
        
        labelText14 <- staticText sw [ text := task14, fontShape := ShapeItalic, identity := 1050]
        desc14 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint14, identity := 114] 
        
        labelText15 <- staticText sw [ text := task15, fontShape := ShapeItalic, identity := 1051]
        desc15 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint15, identity := 115]  
        
        labelText16 <- staticText sw [ text := task16, fontShape := ShapeItalic, identity := 1052]
        desc16 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint16, identity := 116]  
        
        labelText17 <- staticText sw [ text := task17, fontShape := ShapeItalic, identity := 1053]
        desc17 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint17, identity := 117]  
        
        labelText18 <- staticText sw [ text := task18, fontShape := ShapeItalic, identity := 1054]
        desc18 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint18, identity := 118] 
        
        labelText19 <- staticText sw [ text := task19, fontShape := ShapeItalic, identity := 1055]
        desc19 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint19, identity := 119]  
        
        labelText20 <- staticText sw [ text := task20, fontShape := ShapeItalic, identity := 1056]
        desc20 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint20, identity := 120] 
        
        labelText21 <- staticText sw [ text := task21, fontShape := ShapeItalic, identity := 1057]
        desc21 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint21, identity := 121] 
        
        labelText22 <- staticText sw [ text := task22, fontShape := ShapeItalic, identity := 1058]
        desc22 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint22, identity := 122] 
        
        labelText23 <- staticText sw [ text := task23, fontShape := ShapeItalic, identity := 1059]
        desc23 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint23, identity := 123] 
        
        labelText24 <- staticText sw [ text := task24, fontShape := ShapeItalic, identity := 1060]
        desc24 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint24, identity := 124] 
        
        
        let widgetsPairs = [(labelText1, desc1), (labelText2, desc2), (labelText3, desc3), (labelText4, desc4), (labelText5, desc5), (labelText6, desc6), (labelText7, desc7), (labelText8, desc8), (labelText9, desc9), (labelText10, desc10), (labelText11, desc11), (labelText12, desc12), (labelText13, desc13), (labelText14, desc14), (labelText15, desc15), (labelText16, desc16), (labelText17, desc17), (labelText18, desc18), (labelText19, desc19), (labelText20, desc20), (labelText21, desc21), (labelText22, desc22), (labelText23, desc23), (labelText24, desc24)] 
        
        
        set sw [layout := margin 10 $ column 5 [ floatTop $ marginTop $ margin 20 $ widget titleText, floatCenter $ marginBottom $ margin 20 (grid 3 5 [[fill $ minsize (sz 200 100) $ widget labelText1, fill $ minsize (sz 200 100) $ widget desc1], [fill $ minsize (sz 200 100) $ widget labelText2, fill $ minsize (sz 200 100) $ widget desc2], [fill $ minsize (sz 200 100) $ widget labelText3, fill $ minsize (sz 200 100) $ widget desc3], [fill $ minsize (sz 200 100) $ widget labelText4, fill $ minsize (sz 200 100) $ widget desc4], [fill $ minsize (sz 200 100) $ widget labelText5, fill $ minsize (sz 200 100) $ widget desc5], [fill $ minsize (sz 200 100) $ widget labelText6, fill $ minsize (sz 200 100) $ widget desc6], [fill $ minsize (sz 200 100) $ widget labelText7, fill $ minsize (sz 200 100) $ widget desc7], [fill $ minsize (sz 200 100) $ widget labelText8, fill $ minsize (sz 200 100) $ widget desc8], [fill $ minsize (sz 200 100) $ widget labelText9, fill $ minsize (sz 200 100) $ widget desc9], [fill $ minsize (sz 200 100) $ widget labelText10, fill $ minsize (sz 200 100) $ widget desc10], [fill $ minsize (sz 200 100) $ widget labelText11, fill $ minsize (sz 200 100) $ widget desc11], [fill $ minsize (sz 200 100) $ widget labelText12, fill $ minsize (sz 200 100) $ widget desc12], [fill $ minsize (sz 200 100) $ widget labelText13, fill $ minsize (sz 200 100) $ widget desc13], [fill $ minsize (sz 200 100) $ widget labelText14, fill $ minsize (sz 200 100) $ widget desc14], [fill $ minsize (sz 200 100) $ widget labelText15, fill $ minsize (sz 200 100) $ widget desc15], [fill $ minsize (sz 200 100) $ widget labelText16, fill $ minsize (sz 200 100) $ widget desc16], [fill $ minsize (sz 200 100) $ widget labelText17, fill $ minsize (sz 200 100) $ widget desc17], [fill $ minsize (sz 200 100) $ widget labelText18, fill $ minsize (sz 200 100) $ widget desc18], [fill $ minsize (sz 200 100) $ widget labelText19, fill $ minsize (sz 200 100) $ widget desc19], [fill $ minsize (sz 200 100) $ widget labelText20, fill $ minsize (sz 200 100) $ widget desc20], [fill $ minsize (sz 200 100) $ widget labelText21, fill $ minsize (sz 200 100) $ widget desc21], [fill $ minsize (sz 200 100) $ widget labelText22, fill $ minsize (sz 200 100) $ widget desc22], [fill $ minsize (sz 200 100) $ widget labelText23, fill $ minsize (sz 200 100) $ widget desc23], [fill $ minsize (sz 200 100) $ widget labelText24, fill $ minsize (sz 200 100) $ widget desc24]])]]
        
        set archPage [layout := fill $ widget sw]
        
        return $ (,) archPage widgetsPairs
        
