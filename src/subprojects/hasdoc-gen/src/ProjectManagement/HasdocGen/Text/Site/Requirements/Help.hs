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


module ProjectManagement.HasdocGen.Text.Site.Requirements.Help
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
hint18
)
where
    
    
import ProjectManagement.HasdocGen.File.Settings

import System.IO.Unsafe
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data ReqPageHelp = ReqPageHelp

mkMessage "ReqPageHelp" (unsafePerformIO $ chooseTransPath) "en"



hint1 :: String
hint1 = (unsafePerformIO $ makeTranslator ReqPageHelp) MsgReqHint1

hint2 :: String
hint2 = (unsafePerformIO $ makeTranslator ReqPageHelp) MsgReqHint2

hint3 :: String
hint3 = (unsafePerformIO $ makeTranslator ReqPageHelp) MsgReqHint3

hint4 :: String
hint4 = (unsafePerformIO $ makeTranslator ReqPageHelp) MsgReqHint4

hint5 :: String
hint5 = (unsafePerformIO $ makeTranslator ReqPageHelp) MsgReqHint5

hint6 :: String
hint6 = (unsafePerformIO $ makeTranslator ReqPageHelp) MsgReqHint6

hint7 :: String
hint7 = (unsafePerformIO $ makeTranslator ReqPageHelp) MsgReqHint7

hint8 :: String
hint8 = (unsafePerformIO $ makeTranslator ReqPageHelp) MsgReqHint8 

hint9 :: String
hint9 = (unsafePerformIO $ makeTranslator ReqPageHelp) MsgReqHint9

hint10 :: String
hint10 = (unsafePerformIO $ makeTranslator ReqPageHelp) MsgReqHint10

hint11 :: String
hint11 = (unsafePerformIO $ makeTranslator ReqPageHelp) MsgReqHint11

hint12 :: String
hint12 = (unsafePerformIO $ makeTranslator ReqPageHelp) MsgReqHint12

hint13 :: String
hint13 = (unsafePerformIO $ makeTranslator ReqPageHelp) MsgReqHint13

hint14 :: String
hint14 = (unsafePerformIO $ makeTranslator ReqPageHelp) MsgReqHint14

hint15 :: String
hint15 = (unsafePerformIO $ makeTranslator ReqPageHelp) MsgReqHint15

hint16 :: String
hint16 = (unsafePerformIO $ makeTranslator ReqPageHelp) MsgReqHint16

hint17 :: String
hint17 = (unsafePerformIO $ makeTranslator ReqPageHelp) MsgReqHint17

hint18 :: String
hint18 = (unsafePerformIO $ makeTranslator ReqPageHelp) MsgReqHint18
