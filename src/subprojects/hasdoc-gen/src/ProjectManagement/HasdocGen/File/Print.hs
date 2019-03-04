module ProjectManagement.HasdocGen.File.Print
(
createPreview,
printFile
)
where
    
    
import ProjectManagement.HasdocGen.File.HTML
    
    
import Graphics.UI.WXCore.Print
import Graphics.UI.WX


-- createPreview :: Frame () -> Maybe [(String, String)] -> IO ()
-- createPreview mainwindow defWidgets = 
--     do
--         pageSetup <- pageSetupDialog mainwindow 25
--         printPreview pageSetup "Test" pageFun $ printFun defWidgets 
--         
--         

   
   
createPreview :: Frame () -> Maybe [(Int, String, String)] -> IO ()
createPreview mainwindow defWidgets = 
    do
        pageSetup <- pageSetupDialog mainwindow 5
        pageSetupShowModal pageSetup
        printPreview pageSetup "Test" pageFun (printFun defWidgets)
        
        
printFile :: Frame () -> Maybe [(Int, String, String)] -> IO ()
printFile mainwindow defWidgets = 
    do
        pageSetup <- pageSetupDialog mainwindow 5
        printDialog pageSetup "Test" pageFun (printFun defWidgets)
            

printFun :: Maybe [(Int, String, String)] -> PrintFunction
printFun defWidgets _pageInfo _printInfo printSize dc nr = 
    do 
        set dc [brush := brushTransparent]
        drawText dc ("Page " ++ show nr) (pt 0 0) [fontFamily := FontRoman, fontSize := 14]
        case defWidgets of 
             Nothing -> drawText dc "" (pt 0 0) [fontFamily := FontRoman, fontSize := 14]
             Just [(x,y,z)] -> drawText dc (y ++ " test \n\n test \n\n test " ++ z) (pt 0 0) [fontFamily := FontRoman, fontSize := 14]
             Just ((x,y,z):xs) -> drawText dc (y ++ " test \n\n test \n\n test " ++ z) (pt 0 0) [fontFamily := FontRoman, fontSize := 14]
             Just _ -> drawText dc "" (pt 0 0) [fontFamily := FontRoman, fontSize := 14]


-- Return the page range 
pageFun :: PageFunction
pageFun _pageInfo _printInfo _printSize = (1,2) 
