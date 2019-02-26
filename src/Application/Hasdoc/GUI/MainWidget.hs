{-# LANGUAGE MultiParamTypeClasses
            ,FlexibleInstances
            ,FlexibleContexts
            ,TypeSynonymInstances
            ,UndecidableInstances
            ,ScopedTypeVariables
            ,TemplateHaskell
            ,OverloadedStrings
            ,DeriveGeneric
            ,AllowAmbiguousTypes #-}
            

module Application.Hasdoc.GUI.MainWidget
(
createMainWidget
) 
where


import Graphics.UI.WX

import ProjectManagement.HasdocGen.GUI.MainWizard
import Application.Hasdoc.Settings.General

import qualified Data.Text as T
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())
import Data.AppSettings

import qualified Paths_hasdoc as Paths


data MainWidget = MainWidget


mkMessage "MainWidget" getAppLangPath "en"



makeTranslator :: (RenderMessage MainWidget MainWidgetMessage) => IO (MainWidgetMessage -> String)
makeTranslator = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    return (\message -> T.unpack $ renderMsg MainWidget (settLangIntToString $ getSetting' conf languageSett) message)
   

createMainWidget :: Frame () -> IO ()
createMainWidget mainWindow = 
    do
        panel' <- panel mainWindow []
        wizardLayout <- createWizardLayout mainWindow panel'
        quizLayout <- createQuizLayout panel'
        
        set mainWindow [ layout := fill $ minsize (sz 640 480) $ margin 20 $ container panel' $ floatCenter $
                 column 1 [ wizardLayout, quizLayout ] ]

      
createWizardLayout :: Frame () -> Panel () -> IO Layout
createWizardLayout mainWindow panel' = 
    do
        wizardPanel <- panel panel' []
        translate <- makeTranslator
        wizardBtn <- button wizardPanel [text := translate MsgRunWiz, on command := openWizard mainWindow ]
        return $ margin 2 $ container wizardPanel $ floatCenter $
                 row 5 [ hfill $ minsize (sz 200 50) $ label $ translate MsgLabelRunWiz,
                         hfill $ minsize (sz 60 50)  $ widget wizardBtn ]
                         
  
createQuizLayout :: Panel () -> IO Layout
createQuizLayout panel' = 
    do
        quizPanel <- panel panel' []
        translate <- makeTranslator
        quizBtn <- button quizPanel [text := translate MsgRunQuiz]
        return $ margin 2 $ container quizPanel $ floatCenter $
                 row 5 [ hfill $ minsize (sz 200 50) $ label $ translate MsgLabelQuizWiz,
                         hfill $ minsize (sz 60 50)  $ widget quizBtn ]
