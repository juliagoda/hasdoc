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


module ProjectManagement.HasdocGen.Text.Site.Technology.Help
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
hint24,
hint25
)
where
    
    
import ProjectManagement.HasdocGen.File.Settings

import Data.AppSettings
import qualified Data.Text as T
import System.IO.Unsafe
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data TechPageHelp = TechPageHelp

mkMessage "TechPageHelp" getAppLangPath "en"




makeTranslator :: (RenderMessage TechPageHelp TechPageHelpMessage) => IO (TechPageHelpMessage -> String)
makeTranslator = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    return (\message -> T.unpack $ renderMsg TechPageHelp (settLangIntToString $ getSetting' conf languageSett) message)



hint1 :: String
hint1 = (unsafePerformIO makeTranslator) MsgTechHint1

hint2 :: String
hint2 = (unsafePerformIO makeTranslator) MsgTechHint2

hint3 :: String
hint3 = (unsafePerformIO makeTranslator) MsgTechHint3

hint4 :: String
hint4 = (unsafePerformIO makeTranslator) MsgTechHint4

hint5 :: String
hint5 = (unsafePerformIO makeTranslator) MsgTechHint5

hint6 :: String
hint6 = (unsafePerformIO makeTranslator) MsgTechHint6

hint7 :: String
hint7 = (unsafePerformIO makeTranslator) MsgTechHint7

hint8 :: String
hint8 = (unsafePerformIO makeTranslator) MsgTechHint8 

hint9 :: String
hint9 = (unsafePerformIO makeTranslator) MsgTechHint9

hint10 :: String
hint10 = (unsafePerformIO makeTranslator) MsgTechHint10

hint11 :: String
hint11 = (unsafePerformIO makeTranslator) MsgTechHint11

hint12 :: String
hint12 = (unsafePerformIO makeTranslator) MsgTechHint12

hint13 :: String
hint13 = (unsafePerformIO makeTranslator) MsgTechHint13

hint14 :: String
hint14 = (unsafePerformIO makeTranslator) MsgTechHint14

hint15 :: String
hint15 = (unsafePerformIO makeTranslator) MsgTechHint15

hint16 :: String
hint16 = (unsafePerformIO makeTranslator) MsgTechHint16

hint17 :: String
hint17 = (unsafePerformIO makeTranslator) MsgTechHint17

hint18 :: String
hint18 = (unsafePerformIO makeTranslator) MsgTechHint18

hint19 :: String
hint19 = (unsafePerformIO makeTranslator) MsgTechHint19

hint20 :: String
hint20 = (unsafePerformIO makeTranslator) MsgTechHint20

hint21 :: String
hint21 = (unsafePerformIO makeTranslator) MsgTechHint21

hint22 :: String
hint22 = (unsafePerformIO makeTranslator) MsgTechHint22

hint23 :: String
hint23 = (unsafePerformIO makeTranslator) MsgTechHint23

hint24 :: String
hint24 = (unsafePerformIO makeTranslator) MsgTechHint24

hint25 :: String
hint25 = (unsafePerformIO makeTranslator) MsgTechHint25
