module ProjectManagement.HasdocGen.File.Print
(
createPreview,
printFile
)
where
    
import Graphics.UI.WXCore.Print
import Graphics.UI.WX


createPreview :: Frame () -> [(String, String)] -> IO ()
createPreview mainwindow defWidgets = 
    do
        pageSetup <- pageSetupDialog mainwindow 25
        printPreview pageSetup "Test" pageFun $ printFun defWidgets 
        
        
printFile :: Frame () -> [(String, String)] -> IO ()
printFile mainwindow defWidgets = 
    do
        pageSetup <- pageSetupDialog mainwindow 25
        printDialog pageSetup "Test" pageFun $ printFun defWidgets
            

printFun :: [(String, String)] -> PrintFunction
printFun defWidgets _pageInfo _printInfo printSize dc nr = 
    do 
        set dc [brush := brushTransparent]
        drawText dc ("Page " ++ show nr) (pt 0 0) [fontFamily := FontRoman, fontSize := 14]
        let area_ = rectFromSize printSize
        let mid   = rectCentralPoint area_
        drawRect dc area_ [color := grey]  -- draw a border around the printable area
        circle dc mid 4  [color := red]   -- draw a center bullet
        
        
-- Return the page range 
pageFun :: PageFunction
pageFun _pageInfo _printInfo _printSize = (2,5) 
