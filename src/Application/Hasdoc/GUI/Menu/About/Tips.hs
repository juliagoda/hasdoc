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

            
module Application.Hasdoc.GUI.Menu.About.Tips
(
openTipsWindow
) 
where

import Graphics.UI.WX
import Graphics.UI.WX.Window
import Graphics.UI.WXCore

import System.IO.Unsafe

import Application.Hasdoc.Settings.General
import Text.Shakespeare.I18N (mkMessage, renderMessage, RenderMessage())

data TipsWindow = TipsWindow

mkMessage "TipsWindow" (unsafePerformIO $ chooseTransPath) "en"



openTipsWindow :: Frame () -> IO ()
openTipsWindow mainWindow = 
    do 
        translate <- makeTranslator TipsWindow
        tipsWindow <- dialog mainWindow [text := (translate MsgToolsMenu), visible := True, clientSize  := sz 640 480, picture := (getAppIconsPath ++ "/tips-window.png")] 
        sw <- scrolledWindow tipsWindow [ scrollRate := sz 10 10, style := wxVSCROLL]
        
        tip1 <- staticText sw [ text := (translate MsgTip1), fontSize := 12, fontFamily := FontModern ]
        tip2 <- staticText sw [ text := (translate MsgTip2), fontSize := 12, fontFamily := FontModern ]
        tip3 <- staticText sw [ text := (translate MsgTip3), fontSize := 12, fontFamily := FontModern ]
        tip4 <- staticText sw [ text := (translate MsgTip4), fontSize := 12, fontFamily := FontModern ]
        tip5 <- staticText sw [ text := (translate MsgTip5), fontSize := 12, fontFamily := FontModern ]
        tip6 <- staticText sw [ text := (translate MsgTip6), fontSize := 12, fontFamily := FontModern ]
        
        set sw [ layout := margin 10 $ column 5 [fill $ minsize (sz 600 250) $ floatTop $ marginTop $ margin 5 $ widget tip1, fill $ minsize (sz 600 100) $ floatTop $ marginTop $ margin 5 $ widget tip2, fill $ minsize (sz 600 100) $ floatTop $ marginTop $ margin 5 $ widget tip3, fill $ minsize (sz 600 200) $ floatTop $ marginTop $ margin 5 $ widget tip4, fill $ minsize (sz 600 100) $ floatTop $ marginTop $ margin 5 $ widget tip5, fill $ minsize (sz 600 330) $ floatTop $ marginTop $ margin 5 $ widget tip6] ]
        
        set tipsWindow [layout := fill $ widget sw]
        return ()
