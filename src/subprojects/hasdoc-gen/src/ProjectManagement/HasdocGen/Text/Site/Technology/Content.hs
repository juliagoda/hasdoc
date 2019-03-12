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


module ProjectManagement.HasdocGen.Text.Site.Technology.Content
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
task24,
task25
)
where
    
    
import ProjectManagement.HasdocGen.File.Settings
    
import System.IO.Unsafe
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data TechPageContent = TechPageContent

mkMessage "TechPageContent" (unsafePerformIO $ chooseTransPath) "en"



task1 :: String
task1 = (unsafePerformIO $ makeTranslator TechPageContent) MsgTechQuestion1

task2 :: String
task2 = (unsafePerformIO $ makeTranslator TechPageContent) MsgTechQuestion2

task3 :: String
task3 = (unsafePerformIO $ makeTranslator TechPageContent) MsgTechQuestion3

task4 :: String
task4 = (unsafePerformIO $ makeTranslator TechPageContent) MsgTechQuestion4

task5 :: String
task5 = (unsafePerformIO $ makeTranslator TechPageContent) MsgTechQuestion5

task6 :: String
task6 = (unsafePerformIO $ makeTranslator TechPageContent) MsgTechQuestion6

task7 :: String
task7 = (unsafePerformIO $ makeTranslator TechPageContent) MsgTechQuestion7

task8 :: String
task8 = (unsafePerformIO $ makeTranslator TechPageContent) MsgTechQuestion8

task9 :: String
task9 = (unsafePerformIO $ makeTranslator TechPageContent) MsgTechQuestion9

task10 :: String
task10 = (unsafePerformIO $ makeTranslator TechPageContent) MsgTechQuestion10

task11 :: String
task11 = (unsafePerformIO $ makeTranslator TechPageContent) MsgTechQuestion11

task12 :: String
task12 = (unsafePerformIO $ makeTranslator TechPageContent) MsgTechQuestion12

task13 :: String
task13 = (unsafePerformIO $ makeTranslator TechPageContent) MsgTechQuestion13

task14 :: String
task14 = (unsafePerformIO $ makeTranslator TechPageContent) MsgTechQuestion14

task15 :: String
task15 = (unsafePerformIO $ makeTranslator TechPageContent) MsgTechQuestion15

task16 :: String
task16 = (unsafePerformIO $ makeTranslator TechPageContent) MsgTechQuestion16

task17 :: String
task17 = (unsafePerformIO $ makeTranslator TechPageContent) MsgTechQuestion17

task18 :: String
task18 = (unsafePerformIO $ makeTranslator TechPageContent) MsgTechQuestion18

task19 :: String
task19 = (unsafePerformIO $ makeTranslator TechPageContent) MsgTechQuestion19

task20 :: String
task20 = (unsafePerformIO $ makeTranslator TechPageContent) MsgTechQuestion20

task21 :: String
task21 = (unsafePerformIO $ makeTranslator TechPageContent) MsgTechQuestion21

task22 :: String
task22 = (unsafePerformIO $ makeTranslator TechPageContent) MsgTechQuestion22

task23 :: String
task23 = (unsafePerformIO $ makeTranslator TechPageContent) MsgTechQuestion23

task24 :: String
task24 = (unsafePerformIO $ makeTranslator TechPageContent) MsgTechQuestion24

task25 :: String
task25 = (unsafePerformIO $ makeTranslator TechPageContent) MsgTechQuestion25
