module Application.Hasdoc.GUI.Menu.About.Author
(
openAuthorsWindow
) 
where

import Graphics.UI.WX
import Graphics.UI.WX.Window
import Graphics.UI.WXCore

import Application.Hasdoc.Settings.General



openAuthorsWindow :: Frame () -> IO ()
openAuthorsWindow mainWindow = 
    do 
        authorWindow <- dialog mainWindow [text := "O autorze", visible := True, clientSize  := sz 640 480, picture := (getAppIconsPath ++ "/authors-window.png")] 
        p <- panel authorWindow []
        titleText <- staticText p [ text := "Autorzy", fontSize := 16, fontWeight := WeightBold ]
        authorsText <- staticText p [ text := "Jagoda \"juliagoda\" Górska - studentka ostatniego roku w Wyższej Szkole Ekonomii i Informatyki w Krakowie. Pasjonatka programowania od 5 lat. W dotychczasowych projektach znajdowały się takie języki programowania jak: Bash, C, C++, Haskell, Python, PHP. W trakcie nauki innych języków, języków obcych oraz sposobów nauki i metod pracy. Poniższa aplikacja jest odpowiedzią na pracę dyplomową, która dotyczy analizy możliwości zastosowania języków czysto funkcyjnych w biznesie.\n\n Github: https://github.com/juliagoda", fontSize := 12, fontShape := ShapeItalic ]
        set authorWindow [ layout := fill $ minsize (sz 640 480) $ margin 10 $ container p $
                 column 5 [floatTop $ marginTop $ margin 20 $ widget titleText, minsize (sz 500 300) $ floatCenter $ marginBottom $ margin 20 $ widget authorsText] ]
