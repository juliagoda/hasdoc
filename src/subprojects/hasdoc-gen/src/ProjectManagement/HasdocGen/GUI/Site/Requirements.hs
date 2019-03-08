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
import ProjectManagement.HasdocGen.File.Settings

import Data.AppSettings
import qualified Data.Text as T
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data ReqPage = ReqPage

mkMessage "ReqPage" getAppLangPath "en"




makeTranslator :: (RenderMessage ReqPage ReqPageMessage) => IO (ReqPageMessage -> String)
makeTranslator = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    return (\message -> T.unpack $ renderMsg ReqPage (settLangIntToString $ getSetting' conf languageSett) message)


createReqPage :: Wizard () -> IO (WizardPageSimple (), [(StaticText (), TextCtrl ())])
createReqPage mainwizard = 
    do
        translate <- makeTranslator
        reqPage <- wizardPageSimple mainwizard [text := (translate MsgReqTitle), style := wxEVT_WIZARD_HELP, identity := 1013 ]
        sw <- scrolledWindow reqPage [ scrollRate := sz 10 10, style := wxVSCROLL, identity := 1014 ]
        
        titleText <- staticText sw [ text := (translate MsgReqTitle), fontSize := 16, fontWeight := WeightBold, identity := 1015 ]
        
        labelText1 <- staticText sw [ text := task1, fontShape := ShapeItalic, identity := 1016 ]
        desc1 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint1, identity := 51] 
        
        labelText2 <- staticText sw [ text := task2, fontShape := ShapeItalic, identity := 1017 ]
        desc2 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint2, identity := 52]
        
        labelText3 <- staticText sw [ text := task3, fontShape := ShapeItalic, identity := 1018 ]
        desc3 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint3, identity := 53] 
        
        labelText4 <- staticText sw [ text := task4, fontShape := ShapeItalic, identity := 1019 ]
        desc4 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint4, identity := 54]
        
        labelText5 <- staticText sw [ text := task5, fontShape := ShapeItalic, identity := 1020 ]
        desc5 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint5, identity := 55]
        
        labelText6 <- staticText sw [ text := task6, fontShape := ShapeItalic, identity := 1021 ]
        desc6 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint6, identity := 56]
        
        labelText7 <- staticText sw [ text := task7, fontShape := ShapeItalic, identity := 1022 ]
        desc7 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint7, identity := 57] 
        
        labelText8 <- staticText sw [ text := task8, fontShape := ShapeItalic, identity := 1023 ]
        desc8 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint8, identity := 58]
        
        labelText9 <- staticText sw [ text := task9, fontShape := ShapeItalic, identity := 1024 ]
        desc9 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint9, identity := 59] 
        
        labelText10 <- staticText sw [ text := task10, fontShape := ShapeItalic, identity := 1025 ]
        desc10 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint10, identity := 60]
        
        labelText11 <- staticText sw [ text := task11, fontShape := ShapeItalic, identity := 1026 ]
        desc11 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint11, identity := 61]
        
        labelText12 <- staticText sw [ text := task12, fontShape := ShapeItalic, identity := 1027 ]
        desc12 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint12, identity := 62] 
        
        labelText13 <- staticText sw [ text := task13, fontShape := ShapeItalic, identity := 1028 ]
        desc13 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint13, identity := 63] 
        
        labelText14 <- staticText sw [ text := task14, fontShape := ShapeItalic, identity := 1029 ]
        desc14 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint14, identity := 64] 
        
        labelText15 <- staticText sw [ text := task15, fontShape := ShapeItalic, identity := 1030 ]
        desc15 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint15, identity := 65] 
        
        labelText16 <- staticText sw [ text := task16, fontShape := ShapeItalic, identity := 1031 ]
        desc16 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint16, identity := 66]
        
        labelText17 <- staticText sw [ text := task17, fontShape := ShapeItalic, identity := 1032 ]
        desc17 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint17, identity := 67]
        
        labelText18 <- staticText sw [ text := task18, fontShape := ShapeItalic, identity := 1033 ]
        desc18 <- textCtrl sw [enabled := True, wrap := WrapLine, tooltip := hint18, identity := 68]
        
        
        let widgetsPairs = [(labelText1, desc1), (labelText2, desc2), (labelText3, desc3), (labelText4, desc4), (labelText5, desc5), (labelText6, desc6), (labelText7, desc7), (labelText8, desc8), (labelText9, desc9), (labelText10, desc10), (labelText11, desc11), (labelText12, desc12), (labelText13, desc13), (labelText14, desc14), (labelText15, desc15), (labelText16, desc16), (labelText17, desc17), (labelText18, desc18)]
        
        
        set sw [layout := margin 10 $ column 5 [ floatTop $ marginTop $ margin 20 $ widget titleText, floatCenter $ marginBottom $ margin 20 (grid 3 5 [[fill $ minsize (sz 200 100) $ widget labelText1, fill $ minsize (sz 200 100) $ widget desc1], [fill $ minsize (sz 200 100) $ widget labelText2, fill $ minsize (sz 200 100) $ widget desc2], [fill $ minsize (sz 200 100) $ widget labelText3, fill $ minsize (sz 200 100) $ widget desc3], [fill $ minsize (sz 200 100) $ widget labelText4, fill $ minsize (sz 200 100) $ widget desc4], [fill $ minsize (sz 200 100) $ widget labelText5, fill $ minsize (sz 200 100) $ widget desc5], [fill $ minsize (sz 200 100) $ widget labelText6, fill $ minsize (sz 200 100) $ widget desc6], [fill $ minsize (sz 200 100) $ widget labelText7, fill $ minsize (sz 200 100) $ widget desc7], [fill $ minsize (sz 200 100) $ widget labelText8, fill $ minsize (sz 200 100) $ widget desc8], [fill $ minsize (sz 200 100) $ widget labelText9, fill $ minsize (sz 200 100) $ widget desc9], [fill $ minsize (sz 200 100) $ widget labelText10, fill $ minsize (sz 200 100) $ widget desc10], [fill $ minsize (sz 200 100) $ widget labelText11, fill $ minsize (sz 200 100) $ widget desc11], [fill $ minsize (sz 200 100) $ widget labelText12, fill $ minsize (sz 200 100) $ widget desc12], [fill $ minsize (sz 200 100) $ widget labelText13, fill $ minsize (sz 200 100) $ widget desc13], [fill $ minsize (sz 200 100) $ widget labelText14, fill $ minsize (sz 200 100) $ widget desc14], [fill $ minsize (sz 200 100) $ widget labelText15, fill $ minsize (sz 200 100) $ widget desc15], [fill $ minsize (sz 200 100) $ widget labelText16, fill $ minsize (sz 200 100) $ widget desc16], [fill $ minsize (sz 200 100) $ widget labelText17, fill $ minsize (sz 200 100) $ widget desc17], [fill $ minsize (sz 200 100) $ widget labelText18, fill $ minsize (sz 200 100) $ widget desc18]])]]
        
        set reqPage [layout := fill $ widget sw]
        return $ (,) reqPage widgetsPairs
        
        
