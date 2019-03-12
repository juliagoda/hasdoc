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

import System.IO.Unsafe
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

import qualified Paths_hasdoc as Paths


data MainWidget = MainWidget

mkMessage "MainWidget" (unsafePerformIO $ chooseTransPath) "en"

   

createMainWidget :: Frame () -> IO ()
createMainWidget mainWindow = 
    do
        panel' <- panel mainWindow []
        wizardLayout <- createWizardLayout mainWindow panel'
        
        set mainWindow [ layout := fill $ minsize (sz 640 480) $ margin 20 $ container panel' $ floatCenter $
                 column 1 [ wizardLayout ] ]

      
createWizardLayout :: Frame () -> Panel () -> IO Layout
createWizardLayout mainWindow panel' = 
    do
        wizardPanel <- panel panel' []
        translate <- makeTranslator MainWidget
        wizardBtn <- button wizardPanel [text := translate MsgRunWiz, on command := openWizard mainWindow ]
        return $ margin 2 $ container wizardPanel $ floatCenter $
                 row 5 [ hfill $ minsize (sz 200 50) $ label $ translate MsgLabelRunWiz,
                         hfill $ minsize (sz 60 50)  $ widget wizardBtn ]
                         
