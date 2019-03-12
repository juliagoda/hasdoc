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

import System.IO.Unsafe
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data ArchPageHelp = ArchPageHelp

mkMessage "ArchPageHelp" (unsafePerformIO $ chooseTransPath) "en"



hint1 :: String
hint1 = (unsafePerformIO $ makeTranslator ArchPageHelp ) MsgArchHint1

hint2 :: String
hint2 = (unsafePerformIO $ makeTranslator ArchPageHelp) MsgArchHint2

hint3 :: String
hint3 = (unsafePerformIO $ makeTranslator ArchPageHelp) MsgArchHint3

hint4 :: String
hint4 = (unsafePerformIO $ makeTranslator ArchPageHelp) MsgArchHint4

hint5 :: String
hint5 = (unsafePerformIO $ makeTranslator ArchPageHelp) MsgArchHint5

hint6 :: String
hint6 = (unsafePerformIO $ makeTranslator ArchPageHelp) MsgArchHint6

hint7 :: String
hint7 = (unsafePerformIO $ makeTranslator ArchPageHelp) MsgArchHint7

hint8 :: String
hint8 = (unsafePerformIO $ makeTranslator ArchPageHelp) MsgArchHint8

hint9 :: String
hint9 = (unsafePerformIO $ makeTranslator ArchPageHelp) MsgArchHint9

hint10 :: String
hint10 = (unsafePerformIO $ makeTranslator ArchPageHelp) MsgArchHint10

hint11 :: String
hint11 = (unsafePerformIO $ makeTranslator ArchPageHelp) MsgArchHint11

hint12 :: String
hint12 = (unsafePerformIO $ makeTranslator ArchPageHelp) MsgArchHint12

hint13 :: String
hint13 = (unsafePerformIO $ makeTranslator ArchPageHelp) MsgArchHint13

hint14 :: String
hint14 = (unsafePerformIO $ makeTranslator ArchPageHelp) MsgArchHint14

hint15 :: String
hint15 = (unsafePerformIO $ makeTranslator ArchPageHelp) MsgArchHint15

hint16 :: String
hint16 = (unsafePerformIO $ makeTranslator ArchPageHelp) MsgArchHint16

hint17 :: String
hint17 = (unsafePerformIO $ makeTranslator ArchPageHelp) MsgArchHint17

hint18 :: String
hint18 = (unsafePerformIO $ makeTranslator ArchPageHelp) MsgArchHint18

hint19 :: String
hint19 = (unsafePerformIO $ makeTranslator ArchPageHelp) MsgArchHint19

hint20 :: String
hint20 = (unsafePerformIO $ makeTranslator ArchPageHelp) MsgArchHint20

hint21 :: String
hint21 = (unsafePerformIO $ makeTranslator ArchPageHelp) MsgArchHint21

hint22 :: String
hint22 = (unsafePerformIO $ makeTranslator ArchPageHelp) MsgArchHint22

hint23 :: String
hint23 = (unsafePerformIO $ makeTranslator ArchPageHelp) MsgArchHint23

hint24 :: String
hint24 = (unsafePerformIO $ makeTranslator ArchPageHelp) MsgArchHint24
