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


module ProjectManagement.HasdocGen.Text.Site.Tests.Content
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
task10,
task11,
task12,
task13,
task14
)
where
    
import ProjectManagement.HasdocGen.File.Settings
    
import Data.AppSettings
import qualified Data.Text as T
import System.IO.Unsafe
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data TestPageContent = TestPageContent

mkMessage "TestPageContent" getAppLangPath "en"




makeTranslator :: (RenderMessage TestPageContent TestPageContentMessage) => IO (TestPageContentMessage -> String)
makeTranslator = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    return (\message -> T.unpack $ renderMsg TestPageContent (settLangIntToString $ getSetting' conf languageSett) message)



task1 :: String
task1 = (unsafePerformIO makeTranslator) MsgTestQuestion1

task2 :: String
task2 = (unsafePerformIO makeTranslator) MsgTestQuestion2

task3 :: String
task3 = (unsafePerformIO makeTranslator) MsgTestQuestion3

task4 :: String
task4 = (unsafePerformIO makeTranslator) MsgTestQuestion4

task5 :: String
task5 = (unsafePerformIO makeTranslator) MsgTestQuestion5

task6 :: String
task6 = (unsafePerformIO makeTranslator) MsgTestQuestion6

task7 :: String
task7 = (unsafePerformIO makeTranslator) MsgTestQuestion7

task8 :: String
task8 = (unsafePerformIO makeTranslator) MsgTestQuestion8

task9 :: String
task9 = (unsafePerformIO makeTranslator) MsgTestQuestion9

task10 :: String
task10 = (unsafePerformIO makeTranslator) MsgTestQuestion10

task11 :: String
task11 = (unsafePerformIO makeTranslator) MsgTestQuestion11

task12 :: String
task12 = (unsafePerformIO makeTranslator) MsgTestQuestion12

task13 :: String
task13 = (unsafePerformIO makeTranslator) MsgTestQuestion13

task14 :: String
task14 = (unsafePerformIO makeTranslator) MsgTestQuestion14
