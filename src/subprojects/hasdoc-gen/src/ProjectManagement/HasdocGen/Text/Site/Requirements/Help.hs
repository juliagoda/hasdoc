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


module ProjectManagement.HasdocGen.Text.Site.Requirements.Help
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
hint10,
hint11,
hint12,
hint13,
hint14,
hint15,
hint16,
hint17,
hint18
)
where
    
    
import ProjectManagement.HasdocGen.File.Settings

import Data.AppSettings
import qualified Data.Text as T
import System.IO.Unsafe
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data ReqPageHelp = ReqPageHelp

mkMessage "ReqPageHelp" getAppLangPath "en"




makeTranslator :: (RenderMessage ReqPageHelp ReqPageHelpMessage) => IO (ReqPageHelpMessage -> String)
makeTranslator = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    return (\message -> T.unpack $ renderMsg ReqPageHelp (settLangIntToString $ getSetting' conf languageSett) message)



hint1 :: String
hint1 = (unsafePerformIO makeTranslator) MsgReqHint1

hint2 :: String
hint2 = (unsafePerformIO makeTranslator) MsgReqHint2

hint3 :: String
hint3 = (unsafePerformIO makeTranslator) MsgReqHint3

hint4 :: String
hint4 = (unsafePerformIO makeTranslator) MsgReqHint4

hint5 :: String
hint5 = (unsafePerformIO makeTranslator) MsgReqHint5

hint6 :: String
hint6 = (unsafePerformIO makeTranslator) MsgReqHint6

hint7 :: String
hint7 = (unsafePerformIO makeTranslator) MsgReqHint7

hint8 :: String
hint8 = (unsafePerformIO makeTranslator) MsgReqHint8 

hint9 :: String
hint9 = (unsafePerformIO makeTranslator) MsgReqHint9

hint10 :: String
hint10 = (unsafePerformIO makeTranslator) MsgReqHint10

hint11 :: String
hint11 = (unsafePerformIO makeTranslator) MsgReqHint11

hint12 :: String
hint12 = (unsafePerformIO makeTranslator) MsgReqHint12

hint13 :: String
hint13 = (unsafePerformIO makeTranslator) MsgReqHint13

hint14 :: String
hint14 = (unsafePerformIO makeTranslator) MsgReqHint14

hint15 :: String
hint15 = (unsafePerformIO makeTranslator) MsgReqHint15

hint16 :: String
hint16 = (unsafePerformIO makeTranslator) MsgReqHint16

hint17 :: String
hint17 = (unsafePerformIO makeTranslator) MsgReqHint17

hint18 :: String
hint18 = (unsafePerformIO makeTranslator) MsgReqHint18
