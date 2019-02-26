module ProjectManagement.HasdocGen.GUI.Site.Introduction
(
createIntroPage
)
where
    
import Data.Bits
import Graphics.UI.WX
import Graphics.UI.WX.Controls
import Graphics.UI.WXCore.WxcTypes
import Graphics.UI.WXCore.WxcDefs
import Graphics.UI.WXCore
import Graphics.UI.WX.Window


-- wxButton *btn1 = new wxButton(panel, ID_INFO, wxT("Info"));
--   Connect(ID_INFO, wxEVT_COMMAND_BUTTON_CLICKED, wxCommandEventHandler(Messages::ShowMessage1));

-- void Messages::ShowMessage1(wxCommandEvent& event) 
-- {
--   wxMessageDialog *dial = new wxMessageDialog(NULL, 
--       wxT("Download completed"), wxT("Info"), wxOK);
--   dial->ShowModal();
-- }

-----------------------------------------------------


createIntroPage :: Wizard () -> IO (WizardPageSimple ())
createIntroPage mainwizard = 
    do                
        firstPage <- wizardPageSimple mainwizard [text := "Wprowadzenie", style := wxHELP ]
        sw <- scrolledWindow firstPage [ scrollRate := sz 10 10, style := wxVSCROLL .|. wxHSCROLL ]
        st1 <- staticText sw [text := "Wprowadzenie", fontSize := 16, fontWeight := WeightBold ]
        st2 <- staticText sw [text := "Wizard składa się z kilku stron: Definicji i Wstępu, Wymagań, Architektury, Technologii, Testów, Zakończenia. Na każdej ze stron znajduje się seria pomocniczych pytań i rubryk oczekujących wprowadzenia treści. Nie trzeba ich wszystkich wypełniać, jeśli nie ma takiej potrzeby. Warto jest jednak chociaż w kilku słowach przedstawić, dlaczego są zbędne. W razie pytań lub wątpliwości można najechać myszką na dowolną rubrykę, by uzyskać podpowiedź do zrozumienia pytania. Anulowanie lub zakończenie okna nie wiąże się z utratą wprowadzonych danych. Dodatkowo stan ten można zapisać w Menu, a potem wczytać przy następnym uruchomieniu."]
        set sw [ layout := fill $ minsize (sz 500 700) $ margin 10 $ column 5 [floatTop $ marginTop $ margin 20 $ widget st1, minsize (sz 400 300) $ floatCenter $ marginBottom $ margin 20 $ widget st2] ]
        set firstPage [layout := fill $ widget sw]
        return firstPage
        
