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


module ProjectManagement.HasdocGen.GUI.Site.Introduction
(
createIntroPage
)
where
    
import Data.Bits
import Graphics.UI.WX
import Graphics.UI.WX.Controls
import Graphics.UI.WXCore.WxcTypes
import Graphics.UI.WXCore.WxcDefs
import Graphics.UI.WXCore
import Graphics.UI.WX.Window

import Data.AppSettings
import qualified Data.Text as T
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

import ProjectManagement.HasdocGen.File.Settings

data IntroPage = IntroPage

mkMessage "IntroPage" getAppLangPath "en"



makeTranslator :: (RenderMessage IntroPage IntroPageMessage) => IO (IntroPageMessage -> String)
makeTranslator = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    return (\message -> T.unpack $ renderMsg IntroPage (settLangIntToString $ getSetting' conf languageSett) message)



createIntroPage :: Wizard () -> IO (WizardPageSimple ())
createIntroPage mainwizard = 
    do
        translate <- makeTranslator
        firstPage <- wizardPageSimple mainwizard [text := (translate MsgIntroductionTitle), style := wxHELP, identity := 996 ]
        sw <- scrolledWindow firstPage [ scrollRate := sz 10 10, style := wxVSCROLL, identity := 997 ]
        st1 <- staticText sw [text := (translate MsgIntroductionTitle), fontSize := 16, fontWeight := WeightBold, identity := 998 ]
        st2 <- staticText sw [text := (translate MsgIntroductionDesc), identity := 999]
        set sw [ layout := margin 10 $ column 5 [floatTop $ marginTop $ margin 20 $ widget st1, minsize (sz 400 300) $ floatCenter $ marginBottom $ margin 20 $ widget st2] ]
        set firstPage [layout := fill $ widget sw]
        return firstPage
        
