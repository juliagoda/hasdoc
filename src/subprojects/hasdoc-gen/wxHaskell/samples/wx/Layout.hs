{-----------------------------------------------------------------------------------------
Layout demo.
-----------------------------------------------------------------------------------------}
module Main where

import Graphics.UI.WX

main :: IO ()
main
  = start gui

gui :: IO ()
gui
  = do f      <- frame  [text := "Layout test"]
       p      <- panel  f []                       -- panel for color and tab management.
       ok     <- button p [text := "Ok", on command := close f]
       can    <- button p [text := "Cancel", on command := infoDialog f "Info" "Pressed 'Cancel'"]
       xinput <- textEntry p [text := "100", alignment := AlignRight]
       yinput <- textEntry p [text := "100", alignment := AlignRight]

       set f [defaultButton := ok
             ,layout := container p $
                        margin 10 $
                        column 5 [boxed "coordinates" (grid 5 5 [[label "x:", hfill $ widget xinput]
                                                                ,[label "y:", hfill $ widget yinput]])
                                 ,floatBottomRight $ row 5 [widget ok,widget can]]
             ]
       return ()