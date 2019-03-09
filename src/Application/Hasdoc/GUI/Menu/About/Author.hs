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


module Application.Hasdoc.GUI.Menu.About.Author
(
openAuthorsWindow
) 
where

import Graphics.UI.WX
import Graphics.UI.WX.Window
import Graphics.UI.WXCore

import Data.AppSettings
import qualified Data.Text as T
import System.IO.Unsafe
import Application.Hasdoc.Settings.General 


import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data AuthorsWindow = AuthorsWindow

mkMessage "AuthorsWindow" (unsafePerformIO $ chooseTransPath) "en"



makeTranslator :: (RenderMessage AuthorsWindow AuthorsWindowMessage) => IO (AuthorsWindowMessage -> String)
makeTranslator = do
    readResult <- readSettings (AutoFromAppName "hasdoc")
    let conf = fst readResult
    return (\message -> T.unpack $ renderMsg AuthorsWindow (settLangIntToString $ getSetting' conf languageSett) message)



openAuthorsWindow :: Frame () -> IO ()
openAuthorsWindow mainWindow = 
    do 
        translate <- makeTranslator
        authorWindow <- dialog mainWindow [text := (translate MsgAuthorMenu), visible := True, clientSize  := sz 640 480, picture := (getAppIconsPath ++ "/authors-window.png")] 
        p <- panel authorWindow []
        titleText <- staticText p [ text := (translate MsgAuthorsList), fontSize := 16, fontWeight := WeightBold ]
        authorsText <- staticText p [ text := (translate MsgAuthorsDesc), fontSize := 12, fontShape := ShapeItalic ]
        set authorWindow [ layout := fill $ minsize (sz 640 480) $ margin 10 $ container p $
                 column 5 [floatTop $ marginTop $ margin 20 $ widget titleText, minsize (sz 500 300) $ floatCenter $ marginBottom $ margin 20 $ widget authorsText] ]
