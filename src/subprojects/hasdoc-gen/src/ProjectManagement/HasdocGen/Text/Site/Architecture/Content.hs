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


module ProjectManagement.HasdocGen.Text.Site.Architecture.Content
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
task18,
task19,
task20,
task21,
task22,
task23,
task24
)
where
    

import ProjectManagement.HasdocGen.File.Settings
    
import Data.AppSettings
import qualified Data.Text as T
import System.IO.Unsafe
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data ArchPageContent = ArchPageContent

mkMessage "ArchPageContent" getAppLangPath "en"




makeTranslator :: (RenderMessage ArchPageContent ArchPageContentMessage) => IO (ArchPageContentMessage -> String)
makeTranslator = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    return (\message -> T.unpack $ renderMsg ArchPageContent (settLangIntToString $ getSetting' conf languageSett) message)




task1 :: String
task1 = (unsafePerformIO makeTranslator) MsgArchQuestion1

task2 :: String
task2 = (unsafePerformIO makeTranslator) MsgArchQuestion2

task3 :: String
task3 = (unsafePerformIO makeTranslator) MsgArchQuestion3

task4 :: String
task4 = (unsafePerformIO makeTranslator) MsgArchQuestion4

task5 :: String
task5 = (unsafePerformIO makeTranslator) MsgArchQuestion5

task6 :: String
task6 = (unsafePerformIO makeTranslator) MsgArchQuestion6

task7 :: String
task7 = (unsafePerformIO makeTranslator) MsgArchQuestion7

task8 :: String
task8 = (unsafePerformIO makeTranslator) MsgArchQuestion8

task9 :: String
task9 = (unsafePerformIO makeTranslator) MsgArchQuestion9

task10 :: String
task10 = (unsafePerformIO makeTranslator) MsgArchQuestion10

task11 :: String
task11 = (unsafePerformIO makeTranslator) MsgArchQuestion11

task12 :: String
task12 = (unsafePerformIO makeTranslator) MsgArchQuestion12

task13 :: String
task13 = (unsafePerformIO makeTranslator) MsgArchQuestion13

task14 :: String
task14 = (unsafePerformIO makeTranslator) MsgArchQuestion14

task15 :: String
task15 = (unsafePerformIO makeTranslator) MsgArchQuestion15

task16 :: String
task16 = (unsafePerformIO makeTranslator) MsgArchQuestion16

task17 :: String
task17 = (unsafePerformIO makeTranslator) MsgArchQuestion17

task18 :: String
task18 = (unsafePerformIO makeTranslator) MsgArchQuestion18

task19 :: String
task19 = (unsafePerformIO makeTranslator) MsgArchQuestion19

task20 :: String
task20 = (unsafePerformIO makeTranslator) MsgArchQuestion20

task21 :: String
task21 = (unsafePerformIO makeTranslator) MsgArchQuestion21

task22 :: String
task22 = (unsafePerformIO makeTranslator) MsgArchQuestion22

task23 :: String
task23 = (unsafePerformIO makeTranslator) MsgArchQuestion23

task24 :: String
task24 = (unsafePerformIO makeTranslator) MsgArchQuestion24

