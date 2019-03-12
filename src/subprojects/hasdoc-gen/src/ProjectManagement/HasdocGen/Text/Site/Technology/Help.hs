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

import System.IO.Unsafe
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data TechPageHelp = TechPageHelp

mkMessage "TechPageHelp" (unsafePerformIO $ chooseTransPath) "en"



hint1 :: String
hint1 = (unsafePerformIO $ makeTranslator TechPageHelp) MsgTechHint1

hint2 :: String
hint2 = (unsafePerformIO $ makeTranslator TechPageHelp) MsgTechHint2

hint3 :: String
hint3 = (unsafePerformIO $ makeTranslator TechPageHelp) MsgTechHint3

hint4 :: String
hint4 = (unsafePerformIO $ makeTranslator TechPageHelp) MsgTechHint4

hint5 :: String
hint5 = (unsafePerformIO $ makeTranslator TechPageHelp) MsgTechHint5

hint6 :: String
hint6 = (unsafePerformIO $ makeTranslator TechPageHelp) MsgTechHint6

hint7 :: String
hint7 = (unsafePerformIO $ makeTranslator TechPageHelp) MsgTechHint7

hint8 :: String
hint8 = (unsafePerformIO $ makeTranslator TechPageHelp) MsgTechHint8 

hint9 :: String
hint9 = (unsafePerformIO $ makeTranslator TechPageHelp) MsgTechHint9

hint10 :: String
hint10 = (unsafePerformIO $ makeTranslator TechPageHelp) MsgTechHint10

hint11 :: String
hint11 = (unsafePerformIO $ makeTranslator TechPageHelp) MsgTechHint11

hint12 :: String
hint12 = (unsafePerformIO $ makeTranslator TechPageHelp) MsgTechHint12

hint13 :: String
hint13 = (unsafePerformIO $ makeTranslator TechPageHelp) MsgTechHint13

hint14 :: String
hint14 = (unsafePerformIO $ makeTranslator TechPageHelp) MsgTechHint14

hint15 :: String
hint15 = (unsafePerformIO $ makeTranslator TechPageHelp) MsgTechHint15

hint16 :: String
hint16 = (unsafePerformIO $ makeTranslator TechPageHelp) MsgTechHint16

hint17 :: String
hint17 = (unsafePerformIO $ makeTranslator TechPageHelp) MsgTechHint17

hint18 :: String
hint18 = (unsafePerformIO $ makeTranslator TechPageHelp) MsgTechHint18

hint19 :: String
hint19 = (unsafePerformIO $ makeTranslator TechPageHelp) MsgTechHint19

hint20 :: String
hint20 = (unsafePerformIO $ makeTranslator TechPageHelp) MsgTechHint20

hint21 :: String
hint21 = (unsafePerformIO $ makeTranslator TechPageHelp) MsgTechHint21

hint22 :: String
hint22 = (unsafePerformIO $ makeTranslator TechPageHelp) MsgTechHint22

hint23 :: String
hint23 = (unsafePerformIO $ makeTranslator TechPageHelp) MsgTechHint23

hint24 :: String
hint24 = (unsafePerformIO $ makeTranslator TechPageHelp) MsgTechHint24

hint25 :: String
hint25 = (unsafePerformIO $ makeTranslator TechPageHelp) MsgTechHint25
