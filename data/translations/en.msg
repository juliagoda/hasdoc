RunWiz: Run wizard
RunQuiz: Run Quiz
LabelRunWiz: Place for overthinking and describing new project with the possibility of writing to system and printing
LabelQuizWiz: Try, whenever you fluctuate between sequential and iterative approach

ProgramMenu: Program
SaveStateMenu: Save state  S
SaveStateMenuHelp: saves informations from the current session
LoadStateMenu: Load State  L
LoadStateMenuHelp: loads saved state informations
LoadFilesExt: hasdoc files
LoadImportedFilesExt: html files
ImportFromFileMenu: Import from file  I 
ImportFromFileMenuHelp: imports informations into wizard from saved html file
QuitMenu: Quit  Q
QuitMenuHelp: closes application
OptionsMenu: Options
SettingsMenu: Settings  T
SettingsMenuHelp: creates new window with settings
AboutMenu: About Hasdoc
AuthorMenu: About authors
AuthorMenuHelp: contains informations about authors
HomepageMenu: Homepage  W
HomepageMenuHelp: opens website with default browser
IssuesMenu: Issues  B
IssuesMenuHelp: opens website about issues and ideas of application with default browser
ToolsMenu: Tools
ToolsMenuHelp: contains list of used programming languages, editors, libraries
TipsMenu: Tips
TipsMenuHelp: contains list of other ideas for creating new project
DocMenu: Documentation  D
DocMenuHelp: FAQ


Tip1: Customer requirements for program functionality may change during code creation.  It is worth keeping this in mind and prepare a method/technique that would allow for easy application of changes.  However, you cannot accept sudden changes to most of the code. Some people think that changes should not exceed 25% of the whole project. In case of cooperation with a difficult or undecided client, it is easier to write the code in short cycles (e.g. weekly, monthly, etc.).

Tip2: If you don't have ideas about tests, imagine that you are the user who launched your application for the first time. What mistakes could he make before he became fully acquainted with the rules of the program?

Tip3: If you have no idea about the application, look around. Surely there is any problem in your environment, which could be solved by the application.

Tip4: It is commonly said that heuristics is only suitable for small projects. However, looking at it even if it is not written in detail, you can already think about the steps in creating a project and look for suitable tools that meet the priority requirements. If necessary, the existing modules can be expanded with new features to meet the requirements of the program.

Tip5: The most important, first stage of code creation is to create a skeleton, which must be solid and tested. However, it does not have to return temporarily correct values or even anything. 

Tip6: After writing a full heuristics, it is worth looking at the whole "story" and then listing all the programming languages taken into account in the first stage. Then it is worth noting the advantages and disadvantages of each of the languages. On this basis you can make an initial choice. While reading about the required functionalities, it is worth looking for libraries and tools for each language, which are helpful in achieving the goal. If there is still a problem in the choice of language and additional technologies, it is worth answering the question: "Will the program use elements of the paradigm of a given language? Of course, as long as they differ in paradigms". Maybe it is better to choose a multiparadigmatic language? Which of the pre-selected technologies contains the best solution for each of the missing functionalities separately? Maybe the one with one particular paradigm is sufficient? Does the choice of tools and libraries and language include support for the target system architecture and platform?




SettWindow: Settings
LangLabel: Select one of the following languages. After selecting and saving, you will need to restart the program.
LoadLabel: load a previously saved session
ExeFiles: Executable files

ViewerLabel: Select an external program to view the generated pdf file and to view the documentation in this format. If you do not want to view the file after it has been generated, select the first option.

NoViewer: None
ExternalViewer: External program
PrintDesc: Select the settings for the print window. You can skip this step and make changes to the window generated before the printing step.
ScaleHint: In other words - Percentage scale
OrientVChoice: Vertical
OrientHChoice: Horizontal
ColourChoice: Colour
GreyChoice: Greyscale
BiOff: Off
ExtFilesLabel: Select the output data formats below. They will be created in the selected path and directory with the name of the project. html and pdf files are always created.
TemplatesLabel: Select one of the following css files for the output html file from which the pdf file will be created. The first option means printing without colours.
TemplatesList: List of templates
PrintLabel: Default printer
FormatLabel: Default format
OrientLabel: Default orientation
ColourLabel: Default color inclusion
BiPrintLabel: Double-sided printing mode
ResLabel: Default resolution in %, e.g. 50, 100, 200 (Empty field means default value 100 %)
MargingsLabel: Default margins in mm, topMargin-rightMargin-bottomMargin-leftMargin e.g. 25-25-25-25 (Empty field means using default settings)
ScopeLabel: Default range of printed pages in XX-XX or XX format, where XX is any integer, e.g. 1-15, 23 (blank field means all pages)
LangTab: Languages
PreviewTab: File preview
PrintingTab: Printing
ExtOfFilesTab: File formats
TemplatesSetTab: Templates
SaveBtn: Save
ResetBtn: Reset
ConfirmResetQuestion: Are you sure you want to reset your settings?
CancelBtn: Cancel

SaveLocation: Select a location to save progress
NameSaveQuestion: Under what name do you want to save the progress?
NameSave: Enter a file name
StateNone: No state
WizardChangesWarning: No changes have been made to the wizard
Save: Save
StateSave: Save of state
WarningLabel: warning
NoChangesWarning: No changes have been introduced or loaded
NoAllowedChars: The name of the record may only consist of letters and numbers
NoAllowedExt: The file must have the .hdoc extension
ChosenPathSaveResult: The state has been successfully saved in the selected path

LoadState: Load of state
NoSufficientData: the file does not contain sufficient data
NoChangesInFile: the file does not contain valid data or sufficient data
LoadStateResult: The state was successfully loaded from the selected file

SaveSettFail: Write error
SaveSettFailMessage: An error has occurred while saving the settings: 
ReadSettFail: Reading error
ReadSettFailMessage: An error has occurred while reading the settings: 
SaveSettSuccess: Save settings
SaveSettSuccessMessage: The settings for main window have been saved
SaveSettWizardSuccessMessage: The settings for wizard have been saved

ConfirmClose: Confirmation
ConfirmCloseQuestion: Are you sure you want to close the application?


ErrorBrowser: Error
ErrorBrowserDesc: It was not possible to connect to the website. Check the connection to the network and the choice of the installed default system browser.

ToolsDesc: Below is a list of libraries, programming languages and help tools that were used during application development. Programming languages - Haskell. Modules - Pandoc, wxHaskell, AppSettings. IDE - Visual Studio Code. Notepads - Kate. Other - GIMP, IconsFLOW (iconsflow.com)

AuthorsList: Authors
AuthorsDesc: Jagoda "juliagoda" Górska - Programming passionate for 5 years. Previous projects included such programming languages as: Bash, C, C++, Haskell, Python, PHP. In the process of learning other languages, foreign languages and ways of learning and working methods. The application below is a response to the thesis, which concerned the analysis of the possibility of using purely functional languages in business. Github - https://github.com/juliagoda
