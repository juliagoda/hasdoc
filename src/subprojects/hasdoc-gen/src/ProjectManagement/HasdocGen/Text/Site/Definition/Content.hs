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


module ProjectManagement.HasdocGen.Text.Site.Definition.Content
(
task1,
task2,
task3,
task4,
task5,
task6,
task7,
task8,
task9,
task10
)
where
    
import ProjectManagement.HasdocGen.File.Settings
    
import Data.AppSettings
import qualified Data.Text as T
import System.IO.Unsafe
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data DefPageContent = DefPageContent

mkMessage "DefPageContent" getAppLangPath "en"




makeTranslator :: (RenderMessage DefPageContent DefPageContentMessage) => IO (DefPageContentMessage -> String)
makeTranslator = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    return (\message -> T.unpack $ renderMsg DefPageContent (settLangIntToString $ getSetting' conf languageSett) message)




task1 :: String
task1 = (unsafePerformIO makeTranslator) MsgDefQuestion1

task2 :: String
task2 = (unsafePerformIO makeTranslator) MsgDefQuestion2

task3 :: String
task3 = (unsafePerformIO makeTranslator) MsgDefQuestion3

task4 :: String
task4 = (unsafePerformIO makeTranslator) MsgDefQuestion4

task5 :: String
task5 = (unsafePerformIO makeTranslator) MsgDefQuestion5

task6 :: String
task6 = (unsafePerformIO makeTranslator) MsgDefQuestion6

task7 :: String
task7 = (unsafePerformIO makeTranslator) MsgDefQuestion7

task8 :: String
task8 = (unsafePerformIO makeTranslator) MsgDefQuestion8

task9 :: String
task9 = (unsafePerformIO makeTranslator) MsgDefQuestion9

task10 :: String
task10 = (unsafePerformIO makeTranslator) MsgDefQuestion10
