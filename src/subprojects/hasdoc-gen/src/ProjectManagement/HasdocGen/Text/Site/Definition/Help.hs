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


module ProjectManagement.HasdocGen.Text.Site.Definition.Help
(
hint1,
hint2,
hint3,
hint4,
hint5,
hint6,
hint7,
hint8,
hint9,
hint10
)
where
    
import ProjectManagement.HasdocGen.File.Settings

import Data.AppSettings
import qualified Data.Text as T
import System.IO.Unsafe
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data DefPageHelp = DefPageHelp

mkMessage "DefPageHelp" getAppLangPath "en"




makeTranslator :: (RenderMessage DefPageHelp DefPageHelpMessage) => IO (DefPageHelpMessage -> String)
makeTranslator = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    return (\message -> T.unpack $ renderMsg DefPageHelp (settLangIntToString $ getSetting' conf languageSett) message)



hint1 :: String
hint1 = (unsafePerformIO makeTranslator) MsgDefHint1

hint2 :: String
hint2 = (unsafePerformIO makeTranslator) MsgDefHint2

hint3 :: String
hint3 = (unsafePerformIO makeTranslator) MsgDefHint3

hint4 :: String
hint4 = (unsafePerformIO makeTranslator) MsgDefHint4

hint5 :: String
hint5 = (unsafePerformIO makeTranslator) MsgDefHint5

hint6 :: String
hint6 = (unsafePerformIO makeTranslator) MsgDefHint6

hint7 :: String
hint7 = (unsafePerformIO makeTranslator) MsgDefHint7

hint8 :: String
hint8 = (unsafePerformIO makeTranslator) MsgDefHint8

hint9 :: String
hint9 = (unsafePerformIO makeTranslator) MsgDefHint9

hint10 :: String
hint10 = (unsafePerformIO makeTranslator) MsgDefHint10 
