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
    
import System.IO.Unsafe
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data DefPageContent = DefPageContent

mkMessage "DefPageContent" (unsafePerformIO $ chooseTransPath) "en"




task1 :: String
task1 = (unsafePerformIO $ makeTranslator DefPageContent) MsgDefQuestion1

task2 :: String
task2 = (unsafePerformIO $ makeTranslator DefPageContent) MsgDefQuestion2

task3 :: String
task3 = (unsafePerformIO $ makeTranslator DefPageContent) MsgDefQuestion3

task4 :: String
task4 = (unsafePerformIO $ makeTranslator DefPageContent) MsgDefQuestion4

task5 :: String
task5 = (unsafePerformIO $ makeTranslator DefPageContent) MsgDefQuestion5

task6 :: String
task6 = (unsafePerformIO $ makeTranslator DefPageContent) MsgDefQuestion6

task7 :: String
task7 = (unsafePerformIO $ makeTranslator DefPageContent) MsgDefQuestion7

task8 :: String
task8 = (unsafePerformIO $ makeTranslator DefPageContent) MsgDefQuestion8

task9 :: String
task9 = (unsafePerformIO $ makeTranslator DefPageContent) MsgDefQuestion9

task10 :: String
task10 = (unsafePerformIO $ makeTranslator DefPageContent) MsgDefQuestion10
