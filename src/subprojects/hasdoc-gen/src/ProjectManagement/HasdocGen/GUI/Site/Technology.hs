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

module ProjectManagement.HasdocGen.GUI.Site.Technology
(
createTechPage
)
where

import Data.Bits
import Graphics.UI.WX
import Graphics.UI.WX.Controls
import Graphics.UI.WXCore.WxcTypes
import Graphics.UI.WXCore
import Graphics.UI.WX.Window

import ProjectManagement.HasdocGen.Text.Site.Technology.Help
import ProjectManagement.HasdocGen.Text.Site.Technology.Content
import ProjectManagement.HasdocGen.File.Settings

import Data.AppSettings
import qualified Data.Text as T
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data TechPage = TechPage

mkMessage "TechPage" getAppLangPath "en"


makeTranslator :: (RenderMessage TechPage TechPageMessage) => IO (TechPageMessage -> String)
makeTranslator = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    return (\message -> T.unpack $ renderMsg TechPage (settLangIntToString $ getSetting' conf languageSett) message)
    


createTechPage :: Wizard () -> IO (WizardPageSimple (), [(StaticText (), TextCtrl ())])
createTechPage mainwizard = 
    do 
        translate <- makeTranslator
        techPage <- wizardPageSimple mainwizard [text := (translate MsgTechnologyTitle), style := wxEVT_WIZARD_HELP, identity := 1061]
        sw <- scrolledWindow techPage [ scrollRate := sz 10 10, style := wxVSCROLL, identity := 1062]
        
        titleText <- staticText sw [ text := (translate MsgTechnologyTitle), fontSize := 16, fontWeight := WeightBold, identity := 1063]
        
        
        labelText1 <- staticText sw [ text := task1, fontShape := ShapeItalic, identity := 1064]
        desc1 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint1, identity := 151] 
        
        labelText2 <- staticText sw [ text := task2, fontShape := ShapeItalic, identity := 1065]
        desc2 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint2, identity := 152]  
        
        labelText3 <- staticText sw [ text := task3, fontShape := ShapeItalic, identity := 1066]
        desc3 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint3, identity := 153] 
        
        labelText4 <- staticText sw [ text := task4, fontShape := ShapeItalic, identity := 1067]
        desc4 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint4, identity := 154]  
        
        labelText5 <- staticText sw [ text := task5, fontShape := ShapeItalic, identity := 1068]
        desc5 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint5, identity := 155]  
        
        labelText6 <- staticText sw [ text := task6, fontShape := ShapeItalic, identity := 1069]
        desc6 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint6, identity := 156] 
        
        labelText7 <- staticText sw [ text := task7, fontShape := ShapeItalic, identity := 1070]
        desc7 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint7, identity := 157]  
        
        labelText8 <- staticText sw [ text := task8, fontShape := ShapeItalic, identity := 1071]
        desc8 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint8, identity := 158]  
        
        labelText9 <- staticText sw [ text := task9, fontShape := ShapeItalic, identity := 1072]
        desc9 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint9, identity := 159] 
        
        labelText10 <- staticText sw [ text := task10, fontShape := ShapeItalic, identity := 1073]
        desc10 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint10, identity := 160] 
        
        labelText11 <- staticText sw [ text := task11, fontShape := ShapeItalic, identity := 1074]
        desc11 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint11, identity := 161] 
        
        labelText12 <- staticText sw [ text := task12, fontShape := ShapeItalic, identity := 1075]
        desc12 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint12, identity := 162]  
        
        labelText13 <- staticText sw [ text := task13, fontShape := ShapeItalic, identity := 1076]
        desc13 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint13, identity := 163]  
        
        labelText14 <- staticText sw [ text := task14, fontShape := ShapeItalic, identity := 1077]
        desc14 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint14, identity := 164]  
        
        labelText15 <- staticText sw [ text := task15, fontShape := ShapeItalic, identity := 1078]
        desc15 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint15, identity := 165] 
        
        labelText16 <- staticText sw [ text := task16, fontShape := ShapeItalic, identity := 1079]
        desc16 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint16, identity := 166]  
        
        labelText17 <- staticText sw [ text := task17, fontShape := ShapeItalic, identity := 1080]
        desc17 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint17, identity := 167]  
        
        labelText18 <- staticText sw [ text := task18, fontShape := ShapeItalic, identity := 1081]
        desc18 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint18, identity := 168]  
        
        labelText19 <- staticText sw [ text := task19, fontShape := ShapeItalic, identity := 1082]
        desc19 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint19, identity := 169] 
        
        labelText20 <- staticText sw [ text := task20, fontShape := ShapeItalic, identity := 1083]
        desc20 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint20, identity := 170] 
        
        labelText21 <- staticText sw [ text := task21, fontShape := ShapeItalic, identity := 1084]
        desc21 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint21, identity := 171] 
        
        labelText22 <- staticText sw [ text := task22, fontShape := ShapeItalic, identity := 1085]
        desc22 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint22, identity := 172] 
        
        labelText23 <- staticText sw [ text := task23, fontShape := ShapeItalic, identity := 1086]
        desc23 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint23, identity := 173] 
        
        labelText24 <- staticText sw [ text := task24, fontShape := ShapeItalic, identity := 1087]
        desc24 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint24, identity := 174] 
        
        labelText25 <- staticText sw [ text := task25, fontShape := ShapeItalic, identity := 1088]
        desc25 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint25, identity := 175] 
        
        
        let widgetsPairs = [(labelText1, desc1), (labelText2, desc2), (labelText3, desc3), (labelText4, desc4), (labelText5, desc5), (labelText6, desc6), (labelText7, desc7), (labelText8, desc8), (labelText9, desc9), (labelText10, desc10), (labelText11, desc11), (labelText12, desc12), (labelText13, desc13), (labelText14, desc14), (labelText15, desc15), (labelText16, desc16), (labelText17, desc17), (labelText18, desc18), (labelText19, desc19), (labelText20, desc20), (labelText21, desc21), (labelText22, desc22), (labelText23, desc23), (labelText24, desc24), (labelText25, desc25)] 
        
        set sw [layout := margin 10 $ column 5 [ floatTop $ marginTop $ margin 20 $ widget titleText, floatCenter $ marginBottom $ margin 20 (grid 3 5 [[fill $ minsize (sz 200 100) $ widget labelText1, fill $ minsize (sz 200 100) $ widget desc1], [fill $ minsize (sz 200 100) $ widget labelText2, fill $ minsize (sz 200 100) $ widget desc2], [fill $ minsize (sz 200 100) $ widget labelText3, fill $ minsize (sz 200 100) $ widget desc3], [fill $ minsize (sz 200 100) $ widget labelText4, fill $ minsize (sz 200 100) $ widget desc4], [fill $ minsize (sz 200 100) $ widget labelText5, fill $ minsize (sz 200 100) $ widget desc5], [fill $ minsize (sz 200 100) $ widget labelText6, fill $ minsize (sz 200 100) $ widget desc6], [fill $ minsize (sz 200 100) $ widget labelText7, fill $ minsize (sz 200 100) $ widget desc7], [fill $ minsize (sz 200 100) $ widget labelText8, fill $ minsize (sz 200 100) $ widget desc8], [fill $ minsize (sz 200 100) $ widget labelText9, fill $ minsize (sz 200 100) $ widget desc9], [fill $ minsize (sz 200 100) $ widget labelText10, fill $ minsize (sz 200 100) $ widget desc10], [fill $ minsize (sz 200 100) $ widget labelText11, fill $ minsize (sz 200 100) $ widget desc11], [fill $ minsize (sz 200 100) $ widget labelText12, fill $ minsize (sz 200 100) $ widget desc12], [fill $ minsize (sz 200 100) $ widget labelText13, fill $ minsize (sz 200 100) $ widget desc13], [fill $ minsize (sz 200 100) $ widget labelText14, fill $ minsize (sz 200 100) $ widget desc14], [fill $ minsize (sz 200 100) $ widget labelText15, fill $ minsize (sz 200 100) $ widget desc15], [fill $ minsize (sz 200 100) $ widget labelText16, fill $ minsize (sz 200 100) $ widget desc16], [fill $ minsize (sz 200 100) $ widget labelText17, fill $ minsize (sz 200 100) $ widget desc17], [fill $ minsize (sz 200 100) $ widget labelText18, fill $ minsize (sz 200 100) $ widget desc18], [fill $ minsize (sz 200 100) $ widget labelText19, fill $ minsize (sz 200 100) $ widget desc19], [fill $ minsize (sz 200 100) $ widget labelText20, fill $ minsize (sz 200 100) $ widget desc20], [fill $ minsize (sz 200 100) $ widget labelText21, fill $ minsize (sz 200 100) $ widget desc21], [fill $ minsize (sz 200 100) $ widget labelText22, fill $ minsize (sz 200 100) $ widget desc22], [fill $ minsize (sz 200 100) $ widget labelText23, fill $ minsize (sz 200 100) $ widget desc23], [fill $ minsize (sz 200 100) $ widget labelText24, fill $ minsize (sz 200 100) $ widget desc24], [fill $ minsize (sz 200 100) $ widget labelText25, fill $ minsize (sz 200 100) $ widget desc25]])]]
        
        set techPage [layout := fill $ widget sw]
        return $ (,) techPage widgetsPairs
