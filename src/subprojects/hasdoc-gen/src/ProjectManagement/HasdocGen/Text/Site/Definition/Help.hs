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


module ProjectManagement.HasdocGen.Text.Site.Definition.Help
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
hint10
)
where
    
import ProjectManagement.HasdocGen.File.Settings

import System.IO.Unsafe
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data DefPageHelp = DefPageHelp

mkMessage "DefPageHelp" (unsafePerformIO $ chooseTransPath) "en"



hint1 :: String
hint1 = (unsafePerformIO $ makeTranslator DefPageHelp) MsgDefHint1

hint2 :: String
hint2 = (unsafePerformIO $ makeTranslator DefPageHelp) MsgDefHint2

hint3 :: String
hint3 = (unsafePerformIO $ makeTranslator DefPageHelp) MsgDefHint3

hint4 :: String
hint4 = (unsafePerformIO $ makeTranslator DefPageHelp) MsgDefHint4

hint5 :: String
hint5 = (unsafePerformIO $ makeTranslator DefPageHelp) MsgDefHint5

hint6 :: String
hint6 = (unsafePerformIO $ makeTranslator DefPageHelp) MsgDefHint6

hint7 :: String
hint7 = (unsafePerformIO $ makeTranslator DefPageHelp) MsgDefHint7

hint8 :: String
hint8 = (unsafePerformIO $ makeTranslator DefPageHelp) MsgDefHint8

hint9 :: String
hint9 = (unsafePerformIO $ makeTranslator DefPageHelp) MsgDefHint9

hint10 :: String
hint10 = (unsafePerformIO $ makeTranslator DefPageHelp) MsgDefHint10 
