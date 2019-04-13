; *** Inno Setup version 4.1.8+ Portuguese (Standard) messages ***
; Author: RAC2004, Based on: NARS
; Last update: 26 Fev 2004
;
; To download user-contributed translations of this file, go to:
;   http://www.jrsoftware.org/is3rdparty.php
;
; Note: When translating this text, do not add periods (.) to the end of
; messages that didn't have them already, because on those messages Inno
; Setup adds the periods automatically (appending a period would result in
; two periods being displayed).

[LangOptions]
LanguageName=Portuguese (Standard)
LanguageID=$0816
; If the language you are translating to requires special font faces or
; sizes, uncomment any of the following entries and change them accordingly.
;DialogFontName=MS Shell Dlg
;DialogFontSize=8
;WelcomeFontName=Verdana
;WelcomeFontSize=12
;TitleFontName=Arial
;TitleFontSize=29
;CopyrightFontName=Arial
;CopyrightFontSize=8

[Messages]

; *** Application titles
SetupAppTitle=Instalação
SetupWindowTitle=%1 - Instalação
UninstallAppTitle=Desinstalação
UninstallAppFullTitle=%1 - Desinstalação

; *** Misc. common
InformationTitle=Informação
ConfirmTitle=Confirmação
ErrorTitle=Erro

; *** SetupLdr messages
SetupLdrStartupMessage=Irá ser instalado o %1. Deseja continuar?
LdrCannotCreateTemp=Não foi possível criar um ficheiro temporário. Instalação cancelada
LdrCannotExecTemp=Não foi possível executar um ficheiro na directoria temporária. Instalação cancelada

; *** Startup error messages
LastErrorMessage=%1.%n%nErro %2: %3
SetupFileMissing=O ficheiro %1 não foi encontrado na pasta de instalação. Corrija o problema ou obtenha uma nova cópia do programa.
SetupFileCorrupt=Os ficheiros de instalação estão corrompidos. Obtenha uma nova cópia do programa.
SetupFileCorruptOrWrongVer=Os ficheiros de instalação estão corrompidos, ou são incompatíveis com esta versão do Assistente de Instalação. Corrija o problema ou obtenha uma nova cópia do programa.
NotOnThisPlatform=Este programa não pode ser executado no %1.
OnlyOnThisPlatform=Este programa deve ser executado no %1.
WinVersionTooLowError=Este programa necessita do %1 versão %2 ou mais recente.
WinVersionTooHighError=Este programa não pode ser instalado no %1 versão %2 ou mais recente.
AdminPrivilegesRequired=Deve iniciar sessão como administrador para instalar este programa.
PowerUserPrivilegesRequired=Deve iniciar sessão como administrador ou membro do grupo de Super Utilizadores para instalar este programa.
SetupAppRunningError=O Assistente de Instalação detectou que o %1 está em execução. Feche-o e de seguida clique em OK para continuar, ou clique em Cancelar para cancelar a instalação.
UninstallAppRunningError=O Assistente de Desinstalação detectou que o %1 está em execução. Feche-o e de seguida clique em OK para continuar, ou clique em Cancelar para cancelar a desinstalação.

; *** Misc. errors
ErrorCreatingDir=O Assistente de Instalação não consegue criar a directoria "%1"
ErrorTooManyFilesInDir=Não é possível criar um ficheiro na directoria "%1" porque esta contém demasiados ficheiros

; *** Setup common messages
ExitSetupTitle=Terminar a instalação
ExitSetupMessage=A instalação não está completa. Se terminar agora, o programa não será instalado.%n%nMais tarde poderá executar novamente este Assistente de Instalação e concluir a instalação.%n%nDeseja terminar a instalação?
AboutSetupMenuItem=&Acerca de...
AboutSetupTitle=Acerca do Assistente de Instalação
AboutSetupMessage=%1 versão %2%n%3%n%n%1 home page:%n%4
AboutSetupNote=Traduzido por RAC2004 (baseado em NARS)

; *** Buttons
ButtonBack=< &Anterior
ButtonNext=&Seguinte >
ButtonInstall=&Instalar
ButtonOK=OK
ButtonCancel=Cancelar
ButtonYes=&Sim
ButtonYesToAll=Sim para &todos
ButtonNo=&Não
ButtonNoToAll=Nã&o para todos
ButtonFinish=&Concluir
ButtonBrowse=&Procurar...
ButtonWizardBrowse=&Procurar...
ButtonNewFolder=&Criar Pasta

; *** "Select Language" dialog messages
SelectLanguageTitle=Seleccione o Idioma do Assistente de Instalação
SelectLanguageLabel=Seleccione o idioma para usar durante a Instalação:

; *** Common wizard text
ClickNext=Clique em Seguinte para continuar ou em Cancelar para cancelar a instalação.
BeveledLabel=
BrowseDialogTitle=Procurar uma Pasta
BrowseDialogLabel=Seleccione uma Pasta na lista e depois clique em OK.
NewFolderName=Nova Pasta

; *** "Welcome" wizard page
WelcomeLabel1=Bem-vindo ao Assistente de Instalação do [name]
WelcomeLabel2=O Assistente de Instalação irá instalar o [name/ver] no seu computador.%n%nÉ recomendado que feche todas as outras aplicações antes de continuar.

; *** "Password" wizard page
WizardPassword=Password
PasswordLabel1=Esta instalação está protegida por uma password.
PasswordLabel3=Insira a password e de seguida clique em Seguinte para continuar. Nas passwords existe diferença entre maiúsculas e minúsculas.
PasswordEditLabel=&Password:
IncorrectPassword=A password que introduziu não está correcta. Tente novamente.

; *** "License Agreement" wizard page
WizardLicense=Contrato de licença
LicenseLabel=É importante que leia as seguintes informações antes de continuar.
LicenseLabel3=Leia atentamente o seguinte contrato de licença. Deve aceitar os termos do contrato antes de continuar a instalação.
LicenseAccepted=A&ceito o contrato
LicenseNotAccepted=&Não aceito o contrato

; *** "Information" wizard pages
WizardInfoBefore=Informação
InfoBeforeLabel=É importante que leia as seguintes informações antes de continuar.
InfoBeforeClickLabel=Quando estiver pronto para continuar clique em Seguinte.
WizardInfoAfter=Informação
InfoAfterLabel=É importante que leia as seguintes informações antes de continuar.
InfoAfterClickLabel=Quando estiver pronto para continuar clique em Seguinte.

; *** "User Information" wizard page
WizardUserInfo=Informações do utilizador
UserInfoDesc=Introduza as suas informações.
UserInfoName=Nome do &utilizador:
UserInfoOrg=&Organização:
UserInfoSerial=Número de &série:
UserInfoNameRequired=Deve introduzir um nome.

; *** "Select Destination Directory" wizard page
WizardSelectDir=Escolha a directoria de destino
SelectDirDesc=Onde deverá ser instalado o [name]?
SelectDirLabel3=O [name] será instalado na seguinte pasta.
SelectDirBrowseLabel=Para continuar, clique em Seguinte. Se desejar escolher uma pasta diferente, clique em Procurar.
DiskSpaceMBLabel=Este programa necessita de pelo menos [mb] MB de espaço em disco.
ToUNCPathname=O Assistente de Instalação não pode instalar num caminho do tipo UNC. Se está a tentar fazer a instalação numa rede, precisa de mapear a unidade de rede.
InvalidPath=É necessário indicar o caminho completo com a letra de unidade; por exemplo:%n%nC:\APP%n%nou um caminho UNC no formato:%n%n\\servidor\partilha
InvalidDrive=A unidade ou partilha UNC seleccionada não existe ou não está acessível. Seleccione outra.
DiskSpaceWarningTitle=Não há espaço suficiente no disco
DiskSpaceWarning=O Assistente de Instalação necessita de pelo menos %1 KB de espaço livre, mas a unidade seleccionada tem apenas %2 KB disponíveis.%n%nDeseja continuar de qualquer forma?
DirNameTooLong=O nome da pasta ou o caminho indicado é demasiado longo.
InvalidDirName=O nome da pasta indicado não é válido.
BadDirName32=O nome da directoria não pode conter nenhum dos seguintes caracteres:%n%n%1
DirExistsTitle=A directoria já existe
DirExists=A directoria:%n%n%1%n%njá existe. Pretende instalar nesta directoria?
DirDoesntExistTitle=A directoria não existe
DirDoesntExist=A directoria:%n%n%1%n%nnão existe. Pretende que esta directoria seja criada?

; *** "Select Components" wizard page
WizardSelectComponents=Escolha os componentes
SelectComponentsDesc=Que componentes devem ser instalados?
SelectComponentsLabel2=Seleccione os componentes que quer instalar e desseleccione os componentes que não quer instalar. Clique em Seguinte quando estiver pronto para continuar.
FullInstallation=Instalação Completa
; if possible don't translate 'Compact' as 'Minimal' (I mean 'Minimal' in your language)
CompactInstallation=Instalação Compacta
CustomInstallation=Instalação Personalizada
NoUninstallWarningTitle=Componentes Encontrados
NoUninstallWarning=O Assistente de Instalação detectou que os seguintes componentes estão instalados no seu computador:%n%n%1%n%nSe desseleccionar estes componentes eles não serão desinstalados.%n%nDeseja continuar?
ComponentSize1=%1 KB
ComponentSize2=%1 MB
ComponentsDiskSpaceMBLabel=A selecção actual necessita de pelo menos [mb] MB de espaço em disco.

; *** "Select Additional Tasks" wizard page
WizardSelectTasks=Seleccione tarefas adicionais
SelectTasksDesc=Que tarefas adicionais devem ser executadas?
SelectTasksLabel2=Seleccione as tarefas adicionais que deseja que o Assistente de Instalação execute na instalação do [name] e depois clique em Seguinte.

; *** "Select Start Menu Folder" wizard page
WizardSelectProgramGroup=Escolha a pasta do Menu Iniciar
SelectStartMenuFolderDesc=Onde devem ser colocados os ícones de atalho do programa?
SelectStartMenuFolderLabel3=Os atalhos do programa serão criados na seguinte pasta do Menu Iniciar.
SelectStartMenuFolderBrowseLabel=Para continuar, clique em Seguinte. Se desejar escolher uma pasta diferente, clique em Procurar.
NoIconsCheck=&Não criar ícones
MustEnterGroupName=É necessário introduzir um nome para a pasta.
GroupNameTooLong=O nome da pasta ou o caminho indicado é demasiado longo.
InvalidGroupName=O nome da pasta indicado não é válido.
BadGroupName=O nome da pasta não pode conter nenhum dos seguintes caracteres:%n%n%1
NoProgramGroupCheck2=&Não criar nenhuma pasta no Menu Iniciar

; *** "Ready to Install" wizard page
WizardReady=Pronto para Instalar
ReadyLabel1=O Assistente de Instalação está pronto para instalar o [name] no seu computador.
ReadyLabel2a=Clique em Instalar para continuar a instalação, ou clique em Anterior se desejar rever ou alterar alguma das configurações.
ReadyLabel2b=Clique em Instalar para continuar a instalação.
ReadyMemoUserInfo=Informações do utilizador:
ReadyMemoDir=Directoria de destino:
ReadyMemoType=Tipo de instalação:
ReadyMemoComponents=Componentes seleccionados:
ReadyMemoGroup=Pasta do Menu Iniciar:
ReadyMemoTasks=Tarefas adicionais:

; *** "Preparing to Install" wizard page
WizardPreparing=Preparando-se para instalar
PreparingDesc=Preparando-se para instalar o [name] no seu computador.
PreviousInstallNotCompleted=A instalação/remoção de um programa anterior não foi completada. Necessitará de reiniciar o computador para completar essa instalação.%n%nDepois de reiniciar o computador, execute novamente este Assistente de Instalação para completar a instalação do [name].
CannotContinue=A Instalação não pode continuar. Clique em Cancelar para sair.

; *** "Installing" wizard page
WizardInstalling=A instalar
InstallingLabel=Aguarde enquanto o Assistente de Instalação instala o [name] no seu computador.

; *** "Setup Completed" wizard page
FinishedHeadingLabel=Terminando a instalação do [name]
FinishedLabelNoIcons=O Assistente de Instalação concluiu a instalação do [name] no seu computador.
FinishedLabel=O Assistente de Instalação concluiu a instalação do [name] no seu computador. A aplicação pode ser iniciada através dos ícones instalados.
ClickFinish=Clique em Concluir para finalizar o Assistente de Instalação.
FinishedRestartLabel=Para completar a instalação do [name], o Assistente de Instalação deverá reiniciar o seu computador. Deseja reiniciar agora?
FinishedRestartMessage=Para completar a instalação do [name], o Assistente de Instalação deverá reiniciar o seu computador.%n%nDeseja reiniciar agora?
ShowReadmeCheck=Sim, desejo ver o ficheiro LEIAME
YesRadio=&Sim, desejo reiniciar o computador agora
NoRadio=&Não, desejo reiniciar o computador mais tarde
; used for example as 'Run MyProg.exe'
RunEntryExec=Executar %1
; used for example as 'View Readme.txt'
RunEntryShellExec=Visualizar %1

; *** "Setup Needs the Next Disk" stuff
ChangeDiskTitle=O Assistente de Instalação precisa do disco seguinte
SelectDiskLabel2=Introduza o disco %1 e clique em OK.%n%nSe os ficheiros deste disco estiverem num local diferente do mostrado abaixo, indique o caminho correcto ou clique em Procurar.
PathLabel=&Caminho:
FileNotInDir2=O ficheiro "%1" não foi encontrado em "%2". Introduza o disco correcto ou escolha outra pasta.
SelectDirectoryLabel=Indique a localização do disco seguinte.

; *** Installation phase messages
SetupAborted=A instalação não está completa.%n%nCorrija o problema e execute o Assistente de Instalação novamente.
EntryAbortRetryIgnore=Clique em Repetir para tentar novamente, Ignorar para continuar de qualquer forma, ou Abortar para cancelar a instalação.

; *** Installation status messages
StatusCreateDirs=A criar directorias...
StatusExtractFiles=A extrair ficheiros...
StatusCreateIcons=A criar atalhos...
StatusCreateIniEntries=A criar entradas em INI...
StatusCreateRegistryEntries=A criar entradas no registo...
StatusRegisterFiles=A registar ficheiros...
StatusSavingUninstall=A guardar informações para desinstalação...
StatusRunProgram=A concluir a instalação...
StatusRollback=A anular as alterações...

; *** Misc. errors
ErrorInternal2=Erro interno: %1
ErrorFunctionFailedNoCode=%1 falhou
ErrorFunctionFailed=%1 falhou; código %2
ErrorFunctionFailedWithMessage=%1 falhou; código %2.%n%3
ErrorExecutingProgram=Não é possível executar o ficheiro:%n%1

; *** Registry errors
ErrorRegOpenKey=Erro ao abrir a chave de registo:%n%1\%2
ErrorRegCreateKey=Erro ao criar a chave de registo:%n%1\%2
ErrorRegWriteKey=Erro ao escrever na chave de registo:%n%1\%2

; *** INI errors
ErrorIniEntry=Erro ao criar entradas em INI no ficheiro "%1".

; *** File copying errors
FileAbortRetryIgnore=Clique em Repetir para tentar novamente, Ignorar para ignorar este ficheiro (não recomendado), ou Abortar para cancelar a instalação.
FileAbortRetryIgnore2=Clique em Repetir para tentar novamente, Ignorar para continuar de qualquer forma (não recomendado), ou Abortar para cancelar a instalação.
SourceIsCorrupted=O ficheiro de origem está corrompido
SourceDoesntExist=O ficheiro de origem "%1" não existe
ExistingFileReadOnly=O ficheiro existente tem o atributo "só de leitura".%n%nClique em Repetir para remover o atributo "só de leitura" e tentar novamente, Ignorar para ignorar este ficheiro, ou Abortar para cancelar a instalação.
ErrorReadingExistingDest=Ocorreu um erro ao tentar ler o ficheiro existente:
FileExists=O ficheiro já existe.%n%nDeseja substituí-lo?
ExistingFileNewer=O ficheiro existente é mais recente que o que está a ser instalado. É recomendado que mantenha o ficheiro existente.%n%nDeseja manter o ficheiro existente?
ErrorChangingAttr=Ocorreu um erro ao tentar alterar os atributos do ficheiro existente:
ErrorCreatingTemp=Ocorreu um erro ao tentar criar um ficheiro na directoria de destino:
ErrorReadingSource=Ocorreu um erro ao tentar ler o ficheiro de origem:
ErrorCopying=Ocorreu um erro ao tentar copiar um ficheiro:
ErrorReplacingExistingFile=Ocorreu um erro ao tentar substituir o ficheiro existente:
ErrorRestartReplace=O RestartReplace falhou:
ErrorRenamingTemp=Ocorreu um erro ao tentar mudar o nome de um ficheiro na directoria de destino:
ErrorRegisterServer=Não é possível registar o DLL/OCX: %1
ErrorRegisterServerMissingExport=DllRegisterServer export não encontrado
ErrorRegisterTypeLib=Não foi possível registar a type library: %1

; *** Post-installation errors
ErrorOpeningReadme=Ocorreu um erro ao tentar abrir o ficheiro LEIAME.
ErrorRestartingComputer=O Assistente de Instalação não consegue reiniciar o computador. Por favor reinicie manualmente.

; *** Uninstaller messages
UninstallNotFound=O ficheiro "%1" não existe. Não é possível desinstalar.
UninstallOpenError=Não foi possível abrir o ficheiro "%1". Não é possível desinstalar.
UninstallUnsupportedVer=O ficheiro log de desinstalação "%1" está num formato que não é reconhecido por esta versão do desinstalador. Não é possível desinstalar
UninstallUnknownEntry=Foi encontrada uma entrada desconhecida (%1) no ficheiro log de desinstalação
ConfirmUninstall=Tem a certeza que deseja remover completamente o %1 e todos os seus componentes?
OnlyAdminCanUninstall=Esta desinstalação só pode ser realizada por um utilizador com privilégios administrativos.
UninstallStatusLabel=Por favor aguarde enquanto o %1 está a ser removido do seu computador.
UninstalledAll=O %1 foi removido do seu computador com sucesso.
UninstalledMost=A desinstalação do %1 está concluída.%n%nAlguns elementos não puderam ser removidos. Estes elementos podem ser removidos manualmente.
UninstalledAndNeedsRestart=Para completar a desinstalação do %1, o computador deve ser reiniciado.%n%nDeseja reiniciar agora?
UninstallDataCorrupted=O ficheiro "%1" está corrompido. Não é possível desinstalar

; *** Uninstallation phase messages
ConfirmDeleteSharedFileTitle=Remover ficheiro partilhado?
ConfirmDeleteSharedFile2=O sistema indica que o seguinte ficheiro partilhado já não está a ser utilizado por nenhum programa. Deseja removê-lo?%n%nSe algum programa ainda necessitar deste ficheiro, poderá não funcionar correctamente depois de o remover. Se não tiver a certeza, escolha Não. Manter o ficheiro não causará nenhum problema.
SharedFileNameLabel=Nome do ficheiro:
SharedFileLocationLabel=Localização:
WizardUninstalling=Estado da desinstalação
StatusUninstalling=A desinstalar o %1...



[CustomMessages]

AdditionalIcons=Additional icons:
CreateDesktopIcon=Create a &desktop icon
CreateQuickLaunchIcon=Create a &Quick Launch icon
ProgramOnTheWeb=%1 on the Web
UninstallProgram=Uninstall %1
LaunchProgram=Launch %1
AssocFileExtension=&Associate %1 with the %2 file extension
AssocingFileExtension=Associating %1 with the %2 file extension...

ReportManagerDesigner=Report Manager Designer
DBExpressdatabasedrivers=Borland DBExpress database drivers
BorlandDatabaseEnginedatabasedrivers=Borland Database Engine database drivers
Commandlinetools=Command line tools
Documentation=Documentation
TCPserver=Net Server
TCPclientandmetafileviewer=Net client and metafile viewer
Webserver=Web server
ActiveXcomponent=ActiveX component for developers
InternetExplorerplugin=Internet Explorer plugin

LaunchReportManagerDesignerXP=Launch Report Manager Designer
DesignerXP=Designer XP
MetafileViewerandReportClientXP=Metafile Viewer and Report Client
TranslationUtility=Translation Utility
ServerapplicationXP=Net Server application
ServerconfigurationXP=Net Server configuration utility
RegisterActiveX=Register ActiveX
UnRegisterActiveX=UnRegister ActiveX
RegisterPlugin=Register Plugin
UnRegisterPlugin=UnRegister Plugin
ReportManagerDesignerXP=Report Manager Designer
ReportManagerClient=Report Manager client
ReportSamples=Report Examples

Fullinstallation=Full Installation
Custominstallation=Custom installation
ServiceInstallationtool=Service Installation tool
SLicense=License
