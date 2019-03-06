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


module ProjectManagement.HasdocGen.Text.Site.Architecture.Help
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
hint18,
hint19,
hint20,
hint21,
hint22,
hint23,
hint24
)
where


import ProjectManagement.HasdocGen.File.Settings

import Data.AppSettings
import qualified Data.Text as T
import System.IO.Unsafe
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data ArchPageHelp = ArchPageHelp

mkMessage "ArchPageHelp" getAppLangPath "en"




makeTranslator :: (RenderMessage ArchPageHelp ArchPageHelpMessage) => IO (ArchPageHelpMessage -> String)
makeTranslator = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    return (\message -> T.unpack $ renderMsg ArchPageHelp (settLangIntToString $ getSetting' conf languageSett) message)



hint1 :: String
hint1 = (unsafePerformIO makeTranslator) MsgArchHint1

hint2 :: String
hint2 = (unsafePerformIO makeTranslator) MsgArchHint2

hint3 :: String
hint3 = (unsafePerformIO makeTranslator) MsgArchHint3

hint4 :: String
hint4 = (unsafePerformIO makeTranslator) MsgArchHint4

hint5 :: String
hint5 = (unsafePerformIO makeTranslator) MsgArchHint5

hint6 :: String
hint6 = (unsafePerformIO makeTranslator) MsgArchHint6

hint7 :: String
hint7 = (unsafePerformIO makeTranslator) MsgArchHint7

hint8 :: String
hint8 = (unsafePerformIO makeTranslator) MsgArchHint8

hint9 :: String
hint9 = (unsafePerformIO makeTranslator) MsgArchHint9

hint10 :: String
hint10 = (unsafePerformIO makeTranslator) MsgArchHint10

hint11 :: String
hint11 = (unsafePerformIO makeTranslator) MsgArchHint11

hint12 :: String
hint12 = (unsafePerformIO makeTranslator) MsgArchHint12

hint13 :: String
hint13 = (unsafePerformIO makeTranslator) MsgArchHint13

hint14 :: String
hint14 = (unsafePerformIO makeTranslator) MsgArchHint14

hint15 :: String
hint15 = (unsafePerformIO makeTranslator) MsgArchHint15

hint16 :: String
hint16 = (unsafePerformIO makeTranslator) MsgArchHint16

hint17 :: String
hint17 = (unsafePerformIO makeTranslator) MsgArchHint17

hint18 :: String
hint18 = (unsafePerformIO makeTranslator) MsgArchHint18

hint19 :: String
hint19 = (unsafePerformIO makeTranslator) MsgArchHint19

hint20 :: String
hint20 = (unsafePerformIO makeTranslator) MsgArchHint20

hint21 :: String
hint21 = (unsafePerformIO makeTranslator) MsgArchHint21

hint22 :: String
hint22 = (unsafePerformIO makeTranslator) MsgArchHint22

hint23 :: String
hint23 = (unsafePerformIO makeTranslator) MsgArchHint23

hint24 :: String
hint24 = (unsafePerformIO makeTranslator) MsgArchHint24
