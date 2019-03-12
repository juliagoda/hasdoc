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
    
import System.IO.Unsafe
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data ArchPageContent = ArchPageContent

mkMessage "ArchPageContent" (unsafePerformIO $ chooseTransPath) "en"




task1 :: String
task1 = (unsafePerformIO $ makeTranslator ArchPageContent) MsgArchQuestion1

task2 :: String
task2 = (unsafePerformIO $ makeTranslator ArchPageContent) MsgArchQuestion2

task3 :: String
task3 = (unsafePerformIO $ makeTranslator ArchPageContent) MsgArchQuestion3

task4 :: String
task4 = (unsafePerformIO $ makeTranslator ArchPageContent) MsgArchQuestion4

task5 :: String
task5 = (unsafePerformIO $ makeTranslator ArchPageContent) MsgArchQuestion5

task6 :: String
task6 = (unsafePerformIO $ makeTranslator ArchPageContent) MsgArchQuestion6

task7 :: String
task7 = (unsafePerformIO $ makeTranslator ArchPageContent) MsgArchQuestion7

task8 :: String
task8 = (unsafePerformIO $ makeTranslator ArchPageContent) MsgArchQuestion8

task9 :: String
task9 = (unsafePerformIO $ makeTranslator ArchPageContent) MsgArchQuestion9

task10 :: String
task10 = (unsafePerformIO $ makeTranslator ArchPageContent) MsgArchQuestion10

task11 :: String
task11 = (unsafePerformIO $ makeTranslator ArchPageContent) MsgArchQuestion11

task12 :: String
task12 = (unsafePerformIO $ makeTranslator ArchPageContent) MsgArchQuestion12

task13 :: String
task13 = (unsafePerformIO $ makeTranslator ArchPageContent) MsgArchQuestion13

task14 :: String
task14 = (unsafePerformIO $ makeTranslator ArchPageContent) MsgArchQuestion14

task15 :: String
task15 = (unsafePerformIO $ makeTranslator ArchPageContent) MsgArchQuestion15

task16 :: String
task16 = (unsafePerformIO $ makeTranslator ArchPageContent) MsgArchQuestion16

task17 :: String
task17 = (unsafePerformIO $ makeTranslator ArchPageContent) MsgArchQuestion17

task18 :: String
task18 = (unsafePerformIO $ makeTranslator ArchPageContent) MsgArchQuestion18

task19 :: String
task19 = (unsafePerformIO $ makeTranslator ArchPageContent) MsgArchQuestion19

task20 :: String
task20 = (unsafePerformIO $ makeTranslator ArchPageContent) MsgArchQuestion20

task21 :: String
task21 = (unsafePerformIO $ makeTranslator ArchPageContent) MsgArchQuestion21

task22 :: String
task22 = (unsafePerformIO $ makeTranslator ArchPageContent) MsgArchQuestion22

task23 :: String
task23 = (unsafePerformIO $ makeTranslator ArchPageContent) MsgArchQuestion23

task24 :: String
task24 = (unsafePerformIO $ makeTranslator ArchPageContent) MsgArchQuestion24

