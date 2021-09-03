
[void] [System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
[System.Reflection.Assembly]::LoadFrom('C:\GetNumberWeek\assembly\MahApps.Metro.dll') | out-null
 
 # Hide PowerShell Console
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
$consolePtr = [Console.Window]::GetConsoleWindow()
[Console.Window]::ShowWindow($consolePtr, 0)				
 				
function LoadXml ($global:filename)
{
    $XamlLoader=(New-Object System.Xml.XmlDocument)
    $XamlLoader.Load($filename)
    return $XamlLoader
}

# Load MainWindow
$XamlMainWindow=LoadXml(".\GetNumberWeek.xaml")
$Reader=(New-Object System.Xml.XmlNodeReader $XamlMainWindow)
$Form=[Windows.Markup.XamlReader]::Load($Reader)

$Global:Current_Folder =(get-location).path 

########################################################################################################################################################################################################	
#*******************************************************************************************************************************************************************************************************
# 																		INITIALISATION DES LABELS
#*******************************************************************************************************************************************************************************************************
########################################################################################################################################################################################################

#Déclaration des variables
$Retour_Saisie = $Form.findname("Retour")
$OK = $Form.findname("Button_OK")
$Quitter = $Form.findname("Button_Quitter")
$NumberWeek = get-date -UFormat %V
$year = get-date -Format yyyy
$GetNumberWeek = "Bonjour, `nNous en sommes à la semaine $NumberWeek pour l'année $year. `nBonne journée"

#Affichage Numéro de semaine
$Retour_Saisie.content = $GetNumberWeek	

#Action sur le bouton quitter
$Quitter.Add_Click({						
    exit
    })	

$Form.ShowDialog() | Out-Null

