
IntroductionTitle: Wprowadzenie
TestsTitle: Testy
TechnologyTitle: Technologia
ReqTitle: Wymagania
DefinitionTitle: Definicje
ArchTitle: Architektura
FinishTitle: Koniec


IntroductionDesc: Wizard składa się z kilku stron: Definicji i Wstępu, Wymagań, Architektury, Technologii, Testów, Zakończenia. Na każdej ze stron znajduje się seria pomocniczych pytań i rubryk oczekujących wprowadzenia treści. Nie trzeba ich wszystkich wypełniać, jeśli nie ma takiej potrzeby. Warto jest jednak chociaż w kilku słowach przedstawić, dlaczego są zbędne. W razie pytań lub wątpliwości można najechać myszką na dowolną rubrykę, by uzyskać podpowiedź do zrozumienia pytania. Anulowanie lub zakończenie okna nie wiąże się z utratą wprowadzonych danych. Dodatkowo stan ten można zapisać w Menu, a potem wczytać przy następnym uruchomieniu.


DefQuestion1: Określ problem, który budowany system ma rozwiązywać
DefQuestion2: Czy potrafisz opisać podstawowe kroki, jakie program ma wykonać, by rozwiązać problem? Przedstaw heurystykę w wersji uproszczonej
DefQuestion3: Czy tworzenie twojego programu wymaga specjalnych pozwoleń czy uprawnień?
DefQuestion4: Z jakich dziedzin nauki będzie wymagana wiedza, by przygotować funkcjonalności? Jakie działy będą brane pod uwagę?
DefQuestion5: Kto będzie klientem docelowym?
DefQuestion6: Do jakich sprzętów fizycznych ograniczać się ma program na tyle, aby miało to sens?
DefQuestion7: Czy program ma się różnić w zależności od klientów docelowych? Krajów świata? Kontynentów? W jaki sposób?
DefQuestion8: Czy bierzesz pod uwagę kompatybilność wsteczną? Dlaczego?
DefQuestion9: Czy program lub jego część stoi w opozycji do prawa w państwie, w którym mieszkasz? Dlaczego?
DefQuestion10: Jakie zagrożenia związane z działaniem i użytkowaniem programu mogłyby wystąpić w przyszłości? Opisz wstępnie

DefHint1: chodzi o przedstawienie misji produktu, w jakim celu powstaje. Opis powinien zawierać sam problem bez sposobu rozwiązania
DefHint2: Na przykład można to wykonać w formie opowiadania. Wyobraź sobie, że program istnieje i zawiera najważniejsze funkcjonalności
DefHint3: Czy mogą na przykład zaistnieć sytuacje w przyszłości, gdy ktoś pozwie o naruszanie praw autorskich?
DefHint4: Przykładami dziedzin nauki są na przykład: nauki biologiczne, sztuki muzyczne, nauki fizyczne. Jednak warto podać dodatkowo ich działy, ponieważ niemalże z całą pewnością znajomość całej dziedziny jest zbędna.
DefHint5: Kto będzie głównie używał programu?
DefHint6: Dla jakich urządzeń program będzie wspierany?
DefHint7: Czy domyślny styl programu i treść może być utrudnieniem dla osób z innych krajów?
DefHint8: Czy dane przechowywane w np. bazie danych czy chmurze będą wczytywane przez każdą dotychczasową wersję programu?
DefHint9: Czy jakiekolwiek odwołanie, treść, grafika, kod w programie się znajdujące mogą spowodować problemy prawne?
DefHint10: Czy mogą pojawić się jakieś konkretne rodzaje zagrożeń dla działania programu, ochrony danych osobowych, praw autorskich, etc.? Czy istnieje zagrożenie niepowołanego dostępu? Włamania cybernetycznego? Podmiany danych?


ReqQuestion1: Opisz wszystkie wejścia systemu - źródła danych, dokładność, zakres wartości i częstotliwości
ReqQuestion2: Opisz wszystkie wyjścia systemu - miejsca docelowe danych, dokładność, zakres wartości, częstotliwość i format
ReqQuestion3: Opisz wszystkie formaty wyjściowe stron WWW, raportów, itd
ReqQuestion4: Opisz wszystkie zewnętrzne interfejsy sprzętowe i programowe
ReqQuestion5: Opisz wszystkie zewnętrzne interfejsy komunikacyjne, w tym sposób nawiązywania komunikacji, metody kontroli błędów i protokoły komunikacyjne
ReqQuestion6: Opisz wszystkie funkcje, które oczekuje użytkownik
ReqQuestion7: Wymień wszystkie krytyczne wymagania, bez których aplikacja nie ma sensu
ReqQuestion8: Czy każda z funkcjonalności posiada jakąś wartość rynkową? Czy ich istnienie zwiększa wartość produktu? Dlaczego? Przy każdej z nich możesz podać choć jeden powód.
ReqQuestion9: Opisz dane wykorzystywane przez każdą funkcję i jej dane wynikowe
ReqQuestion10: Czy program będzie umożliwiał ingerencję użytkownika? Jeśli tak, to jaki będzie czas reakcji dla każdej takiej pojedynczej operacji?
ReqQuestion11: Jaki czas jest akceptowalny dla programu w przypadku takich operacji jak przetwarzanie danych, szybkość ich transmisji, etc?
ReqQuestion12: Opisz poziom bezpieczeństwa i metody przed przyszłymi ewentualnymi zagrożeniami
ReqQuestion13: Jaka minimalna pamięć komputera i miejsce na dysku są nieodzowne do stworzenia i działania programu?
ReqQuestion14: Czy potrafisz przedstawić definicję nieudanego, aktualnego projektu?
ReqQuestion15: Czy wymagania zostały napisane w języku zrozumiałym dla użytkownika końcowego i wszystkich pracujących nad projektem? Czy zostało to potwierdzone?
ReqQuestion16: Czy jesteś w stanie przewidzieć zmiany w wymaganiach, jakie mogą się pojawić? Jakie zmiany mogą ulec zmianie? Jak bardzo jest to prawdopodobne, że użytkownik poprosi o modyfikacje?
ReqQuestion17: Czy wymagania są ze sobą sprzeczne? Jeśli tak, to które? Dlaczego?
ReqQuestion18: Czy wymagania wydają się rozsądne i możliwe w implementacji? Dlaczego?

ReqHint1: Skąd i czy pobierane będą dane do programu? Z jakim formatem danych trzeba będzie pracować? Jak często te dane będą wczytywane? Jakie typy wartości znajdą się wewnątrz?
ReqHint2: Dokąd będą zapisywane dane wygenerowane z programu? W jakim formacie będą zapisywane? Jak często? Jakie typy danych będą się tam znajdować? W jakich zakresach od do?
ReqHint3: Czy prócz plików multimedialnych program będzie miał własną stronę internetową? Będzie odczytywał i generował inne pliki? Jakie formaty dodatkowe będą brane pod uwagę?
ReqHint4: Z jakim sprzętem i oprogramowaniem będzie komunikował się program?
ReqHint5: pod warunkiem, że będzie następowało połączenie z internetem
ReqHint6: Czy zostały dostrzeżone i uwzględnione wszystkie wymienione wymagania przez użytkownika/zleceniodawcy?
ReqHint7: np. tworzenie klasy samochodu, w której nie znajdzie się informacja na temat kół czy silnika sprawia, że obiekt przestaje być samochodem z definicji
ReqHint8: Czy każda z uwzględnionych funkcjonalności sprawia, że wartość aplikacji wzrasta w jakimś stopniu? 
ReqHint9: Jakie zadanie ma każda z funkcji i co ma zwracać?
ReqHint10: Czy między programem, a użytkownikiem będzie zachodziła jakakolwiek interakcja bezpośrednia? W postaci gestów, głosu, wiersza poleceń, ruchu i kliknięcia myszki? Jak długo w każdym z przypadków program będzie oczekiwał reakcji ze strony użytkownika?
ReqHint11: innym przykładem może być czas odpowiedzi zwrotnej przez serwer, bazy danych
ReqHint12: jakiekolwiek zagrożenia, które mogą mieć wpływ na działanie programu, kradzież danych, usuwanie danych, niepowołany monitoring pracy programu.
ReqHint13: Jak dużo pamięci trzeba zarezerwować, aby programu dało się używać w stopniu podstawowym?
ReqHint14: Jak wyglądałoby działanie programu w sposób odwrotny do zamierzonego?
ReqHint15: Czy wykaz zawiera zwroty i słowa niezrozumiałe? Czy zawiera za dużo branżowego żargonu i specjalistycznych słów, których nie rozumieją użytkownicy/zleceniodawcy?
ReqHint16: Czy jesteś w stanie przewidzieć zmiany w wymaganiach, jakie mogą się pojawić? Jakie zmiany mogą ulec zmianie? Jak bardzo jest to prawdopodobne, że użytkownik poprosi o modyfikacje?
ReqHint17: Cele osobnych wymagań mogą mieć odwrotne skutki, które będą miały przeróżny wpływ na wynik końcowy.
ReqHint18: Czy np. nie przekracza budżetu i kompetencji pracowników?


ArchQuestion1: Przedstaw organizację projektu. Jakie elementy i gdzie będą się znajdować?
ArchQuestion2: Przedstaw i opisz podstawowe klasy/moduły projektu. Czy program będzie tak duży, że będzie zawierał podsystemy? Jak one będą rozmieszczone?
ArchQuestion3: Jeżeli już została podjęta decyzja o wykorzystywanych technikach, rodzaju kontenerów na dane, to wyjaśnij, dlaczego dokonano takiego wyboru?
ArchQuestion4: Jakie klasy/moduły powinny mieć do siebie dostęp? Powinien być pełny dostęp, czy raczej częściowy? Dlaczego?
ArchQuestion5: Dokonałeś wcześniej wyboru sposobu przechowywania danych? Jeśli tak, to dlaczego dokonano konkretnego wyboru?
ArchQuestion6: Czy istnieją jakieś reguły biznesowe w firmie, które muszą zostać uwzględnione w projekcie? Jakie?
ArchQuestion7: Opisz interfejs użytkownika, o ile istnieje i nie był opisywany w wymaganiach.
ArchQuestion8: Jak będzie wyglądało zarządzanie zasobami - bazą danych, plikami, grafiką, etc.?
ArchQuestion9: Czy uwzględnienie minimalnych parametrów dla tworzonego projektu prócz pamięci ma sens? Jeśli tak, to jakie to są parametry?
ArchQuestion10: Czy istnieje zagrożenie zwiększenia liczby użytkowników, zasobów, etc? Jeśli tak, to jak te problemy będą rozwiązywane?
ArchQuestion11: Czy program będzie wymieniał dane z innym oprogramowaniem? W jaki sposób będzie to realizowane?
ArchQuestion12: W jakim języku będzie wprowadzana treść programu? W języku ojczystym czy obcym? Czy program będzie wspierał wiele języków? Dlaczego?
ArchQuestion13: Na jakim poziomie wykrywane będą błędy wejścia-wyjścia: pola, rekordu, pliku, strumieni, itd?
ArchQuestion14: Czy program będzie podejmował próby naprawienia występowanych błędów? Czy będzie jedynie zgłaszał problem użytkownikowi i zamykał program?
ArchQuestion15: Czy program będzie sprawdzał poprawność wprowadzanych danych? W jakich miejscach?
ArchQuestion16: Czy wymagania wydają się rozsądne i możliwe w implementacji? Dlaczego?
ArchQuestion17: W jaki sposób program będzie propagował błędy użytkownikowi?
ArchQuestion18: Kiedy i czy kod będzie zgłaszać obsługę wyjątków? Czy j jak będą one przechwytywane, rejestrowane, dokumentowane?
ArchQuestion19: Obsługa błędów będzie odbywać się w miejscu wykrycia, w osobnej specjalnie przeznaczonej do tego klasie/module lub w jeszcze w inny sposób?
ArchQuestion20: Skorzystasz z gotowej biblioteki do obsługi błędów, czy zbudujesz własny? Dlaczego?
ArchQuestion21: Które miejsca w kodzie będą wymagały większej uwagi podczas konstrukcji niż inne z powodu występowania błędów, a w których miejscach wystarczą proste rozwiązania?
ArchQuestion22: Jakie elementy do produkcji aplikacji będą kupowane, pobierane, a które będą tworzone? Czy istnieją plany wykorzystywania całości lub części istniejącego już oprogramowania? Dlaczego?
ArchQuestion23: W których miejscach w przyszłości można spodziewać się dalszej rozbudowy lub zmian? W jaki sposób będzie implementowana możliwość rozwoju? Jak będzie to ułatwiane?
ArchQuestion24: Jest to program tworzony indywidualnie czy w zespole/zespołach? Jak będą rozdzielane zadania, łączone rozwiązania i jakie zespoły będą potrzebne do stworzenia aplikacji?

ArchHint1: W jakich ścieżkach będą się znajdować pliki dokumentacyjne, źródłowe, grafika, pliki konfiguracyjne, etc.? Jak będzie mniej więcej wyglądało rozbicie klas/modułów w katalogach?
ArchHint2: Za co będą odpowiadać poszczególne klasy/moduły? Jaka będzie ich główna rola?
ArchHint3: Dlaczego np. dokonano wyboru pomiędzy listą, tablicą, kolejką, map czy hash? Czy wiadomo jakie techniki programowania charakterystyczne dla języka/paradygmatu programowania zostaną zastosowane? Dlaczego?
ArchHint4: Które z tworzonych struktur kodu będą zawierały odniesienia do wszystkich metod/zmiennych/etc.? Do niektórych? Do żadnych?
ArchHint5: Czy istnieje potrzeba przechowywania któryś z danych poza aplikacją? W systemie? Na serwerze?
ArchHint6: Czy istnieją jakieś zasady na terenie firmy, które muszą być przestrzegane także podczas tworzenia aplikacji?
ArchHint7: Jakiego rodzaju będzie to interfejs? Graficzny? Tekstowy? Z wierszem poleceń? Głosowy? Gestowy? Łączony? Jak on będzie wyglądał, działał?
ArchHint8: W jakich miejscach aplikacji będzie używana grafika, pliki konfiguracyjne, etc? Jak będą załadowywane dane do aplikacji? Jak będą one modyfikowane? Jak będą one zapisywane?
ArchHint9: Czy aplikacja będzie ściśle powiązana z obsługą i przeróbką plików multimedialnych, gier trójwymiarowych, etc? Jeśli tak, to jakie śa minimalne wymaganie systemowe do działania programu?
ArchHint10: np. gwałtowny wzrost użytkowników na stronie internetowej, duża ilość osób zarejestrowanych w bazie danych, etc?
ArchHint11: np. niektóre programy potrafią wymieniać między sobą pliki konfiguracyjne, zapisy stanów gier, bezpośrednio przekazywać wartości poprzez pomost itd.
ArchHint12: Czy warto uwzględniać internacjonalizację dla aplikacji?
ArchHint13: Kiedy będą wykrywane błędy? Na jakim etapie? Czy będą szczegółowo monitorowane?
ArchHint14: Można więc scharakteryzować wykrywanie błędów w sposób detekcyjny lub naprawczy, a nawet połączony
ArchHint15: Chodzi o miejsca, które opierają się na bezpośredniej interakcji z użytkownikami - klikaniu myszką, przycisku klawiatury, itd
ArchHint16: Czy szacowany czas wdrożenia funkcjonalności nie zajmie za dużo czasu? Czy budżet firmy, dostęp do sprzętu nie będzie zbyt ograniczony dla każdego z wymagań? Czy jakiekolwiek materiały związane z wdrożeniem funkcjonalności są łatwo dostępne i zrozumiałe dla zespołu?
ArchHint17: Jak będzie reagował program w razie wystąpienia błędów? Jakie będzie wykonywał kroki?
ArchHint18: Czy przewidujesz występowanie nieoczekiwanych sytuacji? Zamierzasz korzystać z kodu działącego na zasadzie "try ... catch"?
ArchHint19: Obsługa błędów będzie odbywać się w miejscu wykrycia, w osobnej specjalnie przeznaczonej do tego klasie/module lub w jeszcze w inny sposób?
ArchHint20: Skorzystasz z gotowej biblioteki do obsługi błędów, czy zbudujesz własny? Dlaczego?
ArchHint21: Które miejsca w kodzie będą wymagały większej uwagi podczas konstrukcji niż inne z powodu występowania błędów, a w których miejscach wystarczą proste rozwiązania? 
ArchHint22: Czy istnieją jakieś płatne biblioteki, edytory, innego typu oprogramowanie które przydadzą się w projekcie? Czy istnieje gdzieś podobny program, na którym można by było się wzorować?
ArchHint23: Jakie miejsca programu mogą w przyszłości zostać wzbogacone o większą ilość komponentów? Czy dodawanie ich będzie wymagało skomplikowanych kroków?
ArchHint24: w zależności czy tworzy ją osoba prywatna czy firma


TechQuestion1: Jakie języki programowania wybierasz do konstrukcji programu? W jakich wersjach? Dlaczego?
TechQuestion2: Jakie inne języki programowania brano pod uwagę? Dlaczego nie zostały ostatecznie zaakceptowane?
TechQuestion3: Czy wybrane języki/język programowania są w stanie bez dużego problemu spełnić wszystkie warunki w wymaganiach?
TechQuestion4: Czy program będzie korzystał z jakichkolwiek cech paradygmatu programowania języka wybranego? Jakie to są cechy?
TechQuestion5: Z pomocą jakiego edytora będzie projektowany program? Będzie to IDE czy notatnik? Inny sposób? Dlaczego?
TechQuestion6: Jakiej technologii użyjesz do przechowywania i odczytywania danych? Jaką nosi nazwę? Dlaczego dokonano takiego wyboru?
TechQuestion7: Ile stanowisk komputerowych może być potrzebnych do stworzenia produktu?
TechQuestion8: Ile osób/zespołów będzie potrzebnych do ukończenia programu?
TechQuestion9: Jaka i czy będzie wykorzystane narzędzie kontrola wersji?
TechQuestion10: Jaki kompilator zostanie użyty podczas prac?
TechQuestion11: Na jakim/jakich systemie operacyjnym będzie tworzony kod? Dlaczego?
TechQuestion12: Czy będzie wdrożone narzędzie do refaktoryzacji kodu? Jakie?
TechQuestion13: Jaki debugger będzie wykorzystywany? Dlaczego?
TechQuestion14: Jakie sprzęty fizyczne zostaną wykorzystane. Czy wielkość ich parametrów ma znaczenie? Jeśli tak, to jak one się przedstawiają?
TechQuestion15: Czy dla aplikacji projektowana będzie grafika? Jeśli tak, to w jakich programach?
TechQuestion16: Czy będzie pod uwagę brana wirtualizacja systemów? Jeśli tak, to jak się nazywa się aplikacja? Dlaczego dokonano takiego wyboru? Jakie systemy będą wirtualizowane?
TechQuestion17: Czy i jaki program będzie wykorzystywany do tworzenia dokumentacji programu? Uzasadnij wybór
TechQuestion18: Czy istnieją inne programy, które zostaną użyte? Jakie to są programy?
TechQuestion19: Jakie biblioteki zostaną wykorzystane w projekcie? Dlaczego?
TechQuestion20: Czy wybór każdej z technologii jest aktualny? Czy istnieje duże zagrożenie, że niedługo ktoreś z nich zostanie przestarzałe i nierozwijane?
TechQuestion21: Czy dokumentacja wybranego języka programowania, bibliotek i programów pomocniczych jest zrozumiała dla programistów?
TechQuestion22: Czy tworzenie kodu w stylu charakterystycznym dla wybranego języka będzie problemem dla programistów?
TechQuestion23: Czy i jakie wzorce projektowe bedą stosowane podczas tworzenia kodu? Dlaczego takie?
TechQuestion24: Czy i z jakiej metodyki pracy będą korzystać programiści podczas pracy nad projektem? Uzasadnij wybór?
TechQuestion25: Jak będzie wyglądała konfiguracja systemu i uwzględnionych wcześniej programów pod pracę nad projektem?

TechHint1: Jakie języki programowania wybierasz do konstrukcji programu? W jakich wersjach? Dlaczego?
TechHint2: Czy istnieją jakieś konkretne powody?
TechHint3: Czy jakakolwiek biblioteka, dokumentacja, moduł istniejący dla danego języka ułatwi osiągnięcie celów?
TechHint4: Jeśli jest to język multiparadygmatyczny (hybrydowy), to z jakich cech będzie korzystał program?
TechHint5: Z pomocą jakiego edytora będzie projektowany program? Będzie to IDE czy notatnik? Inny sposób? Dlaczego?
TechHint6: program zewnętrzny
TechHint7: Ile stanowisk komputerowych może być potrzebnych do stworzenia produktu?
TechHint8: Ile osób/zespołów będzie potrzebnych do ukończenia programu?
TechHint9: Git? Mercurial? Bazaar? BitKeeper? Perforce? Inny? Z nakładką graficzną czy z pomocą konsoli?
TechHint10: Jaki kompilator zostanie użyty podczas prac?
TechHint11: Na jakim/jakich systemie operacyjnym będzie tworzony kod? Dlaczego?
TechHint12: Czy będzie wdrożone narzędzie do refaktoryzacji kodu? Jakie?
TechHint13: Jaki debugger będzie wykorzystywany? Dlaczego?
TechHint14: parametry mogą mieć szczególne znaczenie, gdy program dotyczy grafiki, modelowania trójwymiarowego, materiałów filmowych, etc
TechHint15: Z pomocą programu graficznego systemowego? Aplikacji internetowej? Innych?
TechHint16: Czy będzie pod uwagę brana wirtualizacja systemów? Jeśli tak, to jak się nazywa się aplikacja? Dlaczego dokonano takiego wyboru? Jakie systemy będą wirtualizowane?
TechHint17: Dokumentacja użytkowania programu dla użytkowników końcowych, dokumentacja techniczna dla osób z branży
TechHint18: Inne rodzaje aplikacji, które nie były wcześniej wymieniane oraz ich nazwy, np. muzyczne, astronomiczne etc.
TechHint19: biblioteki stworzone z myślą wybranych językach programowania
TechHint20: Czy wybór każdej z technologii jest aktualny? Czy istnieje duże zagrożenie, że niedługo ktoreś z nich zostanie przestarzałe i nierozwijane?
TechHint21: jeśli dokumentacja zawiera duże braki, to czy zespół posiada wystarczającą wiedzę, by sprostać oczekiwaniom?
TechHint22: ze względu na przyzwyczajenia zdarza się, że programiści starają się wprowadzać sposoby rozwiązywania problemów, charakterystycznych dla innego języka programowania. Konwencje pisania kodu mogą się znacznie różnić między językami.
TechHint23: przykładami takich wzorców są: Mediator, Fasada, Kompozyt, Adapter, Singleton, Prototyp i wiele innych
TechHint24: do grupy metodyki Agile zaliczają się takie metody jak Scrum, Kanban, XP, Lean, DSDM, FBB, Crystal ...
TechHint25: Jakie konfiguracje sieciowe, systemowe czy w programach pomocnicznych są niezbędne do pracy nad projektem?


TestQuestion1: Czy programiści będą przygotowywać testy przed rozpoczęciem pracy z właściwym kodem? Dlaczego?
TestQuestion2: Czy programiści będą samodzielnie pisać testy jednostkowe? Dlaczego?
TestQuestion3: Czy analiza działania kodu będzie wyprzedzała dołączanie kodu do repozytorium?
TestQuestion4: Czy będą wykonywane testy integracyjne przed dołączaniem kodu do repozytorium?
TestQuestion5: Czy programiści będą wzajemnie przeglądać swój kod?
TestQuestion6: Jakie będą testy dla każdego punktu specyfikacji wymagań?
TestQuestion7: Czy będzie uwzględnione ułatwienie ręcznego sprawdzania wyników pracy programu?
TestQuestion8: Jakie testy będą przeprowadzane dla minimalnej konfiguracji programu?
TestQuestion9: Jakie testy będą przeprowadzane dla maksymalnej konfiguracji programu?
TestQuestion10: Czy program będzie testowany pod kątem zgodności ze starszymi urządzeniami, systemami operacyjnymi i interfejsami? Wiadomo dla jakich konkretnie?
TestQuestion11: Czy testy będą uwzględniać typowe wartości?
TestQuestion12: Czy podczas projektowania testów będą uwzględniane testy typu "corner cases"?
TestQuestion13: Czy będą sprawdzane i definiowane wartości graniczne: największe, najmniejsze i przesunięte o jeden?
TestQuestion14: Czy choć część testów będzie wzorowanych na starszych dla typowych sytuacji z przeszłości, czy wszystkie będą tworzone od nowa?

TestHint1: znając już listę wymagań i organizację kodu źródłowego
TestHint2: Czy programiści będą samodzielnie pisać testy jednostkowe? Dlaczego?
TestHint3: Czy przed przysłaniem zmian w nowej funkcjonalności, programiści będą w jakikolwiek sposób sprawdzać ich poprawność?
TestHint4: Czy przed przysłaniem zmian, programiści będą w jakikolwiek sposób sprawdzać poprawność interakcji z innymi strukturami programu?
TestHint5: Czy programiści będą wzajemnie przeglądać swój kod?
TestHint6: Można wylistować poszczególne testy dla każdej metody/zmiennej/klasy
TestHint7: Czy będzie uwzględnione ułatwienie ręcznego sprawdzania wyników pracy programu?
TestHint8: minimalna ilość zmian
TestHint9: maksymalna ilość zmian
TestHint10: Czy program będzie testowany pod kątem zgodności ze starszymi urządzeniami, systemami operacyjnymi i interfejsami? Wiadomo dla jakich konkretnie?
TestHint11: Takimi typowymi wartościami są np. liczby całkowite, wartości boolowskie, tekstowe, itd
TestHint12: Czy podczas testów będą sztucznie wprowadzane różne argumenty w celu analizy?
TestHint13: w postaci argumentów metod
TestHint14: pomysł na konkretny test będzie wzorowany na podstawie innej aplikacji, czy nie?


FinishDesc: Możesz sprawdzić poprawność wprowadzonych danych, naciskając na przycisk "Sprawdź dane" lub możesz od razu przejść do generowania plików i wyświetlenia pliku pdf, naciskając w przycisk "Generuj plik".
ProjectName: Podaj tytuł dla swojego projektu: 
GenerationAction: Generuj plik
GenerationHint: Uruchamia kolejno sekwencję : testowanie wprowadzonych dotychczasowych danych, generowanie pliku, podgląd
CheckAction: Sprawdź dane
CheckHint: Uruchamia same testy wprowadzonych danych z całego wizarda.
ChoosePathProject: Wybierz folder dla wygenerowania plików
WarningProject: ostrzeżenie
WaningProjectName: Tytuł projektu nie został podany
SuccessCheckProject: sukces
SuccessCheckProjectMsg: Warunki wprowadzanych danych zostały spełnione
SuccessGenProjectMsg: Zakończono generowanie plików
ProjectNameConsole: Tytuł projektu to 
WarningProjectEmpty: żadne pole nie zostało wypełnione
NoHTMLParsedTags: Plik html nie zawiera poprawnej struktury dla aktualnej aplikacji


PathExeError: Podana ścieżka nie dotyczy programu wykonywalnego
ClosedAppSuccess: Aplikacja została poprawnie zamknięta
ClosedAppError: Wystąpił błąd podczas zamykania aplikacji nr


CreatedPdfError: Nastąpił błąd podczas tworzenia pliku Pdf
PdfviewerNone: Brak


LoadState: Odczyt stanu
LoadStateResult: Stan został pomyślnie wczytany z wybranego pliku
