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


module ProjectManagement.HasdocGen.Text.Site.Tests.Help
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
hint14
)
where
    
    
import ProjectManagement.HasdocGen.File.Settings

import Data.AppSettings
import qualified Data.Text as T
import System.IO.Unsafe
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data TestPageHelp = TestPageHelp

mkMessage "TestPageHelp" (unsafePerformIO $ chooseTransPath) "en"




makeTranslator :: (RenderMessage TestPageHelp TestPageHelpMessage) => IO (TestPageHelpMessage -> String)
makeTranslator = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    return (\message -> T.unpack $ renderMsg TestPageHelp (settLangIntToString $ getSetting' conf languageSett) message)



hint1 :: String
hint1 = (unsafePerformIO makeTranslator) MsgTestHint1

hint2 :: String
hint2 = (unsafePerformIO makeTranslator) MsgTestHint2

hint3 :: String
hint3 = (unsafePerformIO makeTranslator) MsgTestHint3

hint4 :: String
hint4 = (unsafePerformIO makeTranslator) MsgTestHint4

hint5 :: String
hint5 = (unsafePerformIO makeTranslator) MsgTestHint5

hint6 :: String
hint6 = (unsafePerformIO makeTranslator) MsgTestHint6

hint7 :: String
hint7 = (unsafePerformIO makeTranslator) MsgTestHint7

hint8 :: String
hint8 = (unsafePerformIO makeTranslator) MsgTestHint8

hint9 :: String
hint9 = (unsafePerformIO makeTranslator) MsgTestHint9

hint10 :: String
hint10 = (unsafePerformIO makeTranslator) MsgTestHint10

hint11 :: String
hint11 = (unsafePerformIO makeTranslator) MsgTestHint11

hint12 :: String
hint12 = (unsafePerformIO makeTranslator) MsgTestHint12

hint13 :: String
hint13 = (unsafePerformIO makeTranslator) MsgTestHint13

hint14 :: String
hint14 = (unsafePerformIO makeTranslator) MsgTestHint14
