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


module ProjectManagement.HasdocGen.Text.Site.Requirements.Content
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
task14,
task15,
task16,
task17,
task18
)
where
    
    
import ProjectManagement.HasdocGen.File.Settings
    
import Data.AppSettings
import qualified Data.Text as T
import System.IO.Unsafe
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data ReqPageContent = ReqPageContent

mkMessage "ReqPageContent" (unsafePerformIO $ chooseTransPath) "en"




makeTranslator :: (RenderMessage ReqPageContent ReqPageContentMessage) => IO (ReqPageContentMessage -> String)
makeTranslator = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    return (\message -> T.unpack $ renderMsg ReqPageContent (settLangIntToString $ getSetting' conf languageSett) message)



task1 :: String
task1 = (unsafePerformIO makeTranslator) MsgReqQuestion1

task2 :: String
task2 = (unsafePerformIO makeTranslator) MsgReqQuestion2

task3 :: String
task3 = (unsafePerformIO makeTranslator) MsgReqQuestion3

task4 :: String
task4 = (unsafePerformIO makeTranslator) MsgReqQuestion4

task5 :: String
task5 = (unsafePerformIO makeTranslator) MsgReqQuestion5

task6 :: String
task6 = (unsafePerformIO makeTranslator) MsgReqQuestion6

task7 :: String
task7 = (unsafePerformIO makeTranslator) MsgReqQuestion7

task8 :: String
task8 = (unsafePerformIO makeTranslator) MsgReqQuestion8 

task9 :: String
task9 = (unsafePerformIO makeTranslator) MsgReqQuestion9

task10 :: String
task10 = (unsafePerformIO makeTranslator) MsgReqQuestion10

task11 :: String
task11 = (unsafePerformIO makeTranslator) MsgReqQuestion11

task12 :: String
task12 = (unsafePerformIO makeTranslator) MsgReqQuestion12

task13 :: String
task13 = (unsafePerformIO makeTranslator) MsgReqQuestion13

task14 :: String
task14 = (unsafePerformIO makeTranslator) MsgReqQuestion14

task15 :: String
task15 = (unsafePerformIO makeTranslator) MsgReqQuestion15

task16 :: String
task16 = (unsafePerformIO makeTranslator) MsgReqQuestion16

task17 :: String
task17 = (unsafePerformIO makeTranslator) MsgReqQuestion17

task18 :: String
task18 = (unsafePerformIO makeTranslator) MsgReqQuestion18
