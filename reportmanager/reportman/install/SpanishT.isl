; Translation made with Translator 1.32 (http://www2.arnes.si/~sopjsimo/translator.html)
; $Translator:NL=%n:TB=%t
;
; *** Inno Setup version 3.0.3+ Spanish messages ***
;
; To download user-contributed translations of this file, go to:
;   http://www.jrsoftware.org/is3rdparty.htm
;
; Note: When translating this text, do not add periods (.) to the end of
; messages that didn't have them already, because on those messages Inno
; Setup adds the periods automatically (appending a period would result in
; two periods being displayed).
;
; $Id: SpanishT.isl,v 1.4 2004/05/15 08:37:01 tonim Exp $

[LangOptions]
LanguageName=Español
LanguageID=$040a
; If the language you are translating to requires special font faces or
; sizes, uncomment any of the following entries and change them accordingly.

DialogFontName=
DialogFontSize=8
WelcomeFontName=Verdana
WelcomeFontSize=12
TitleFontName=Arial
TitleFontSize=29
CopyrightFontName=Arial
CopyrightFontSize=8
[Messages]

; *** Application titles
SetupAppTitle=Instalar
SetupWindowTitle=Instalar - %1
UninstallAppTitle=Desinstalar
UninstallAppFullTitle=Desinstalar - %1

; *** Misc. common
InformationTitle=Información
ConfirmTitle=Confirmar
ErrorTitle=Error

; *** SetupLdr messages
SetupLdrStartupMessage=Este programa instalará %1 en su sistema. ¿Desea continuar?
LdrCannotCreateTemp=Imposible crear un archivo temporal. Instalación cancelada
LdrCannotExecTemp=Imposible ejecutar archivo en el directorio temporal. Instalación interrumpida

LastErrorMessage=%1.%n%nError %2: %3
SetupFileMissing=El archivo %1 no se encuentra en la carpeta de instalación. Por favor corrija el problema u obtenga una nueva copia del programa.
SetupFileCorrupt=Los archivos de instalación están dañados. Por favor obtenga una copia nueva del programa.
SetupFileCorruptOrWrongVer=Los archivos de instalación están dañados, o son incompatibles con esta versión del Instalador. Por favor corrija el problema u obtenga una nueva copia del programa.
NotOnThisPlatform=Este programa no funcionará en un sistema %1.
OnlyOnThisPlatform=Este programa debe ejecutarse en un sistema %1.
WinVersionTooLowError=Este programa requiere %1 versión %2 o posterior.
WinVersionTooHighError=Este programa no puede instalarse en %1 versión %2 o posterior.
AdminPrivilegesRequired=Debe iniciar la sesión como un administrador cuando instale este programa.
PowerUserPrivilegesRequired=Debe iniciar la sesion como administrador o un usuario con suficientes privilegios para instalar este programa.
SetupAppRunningError=El Instalador ha detectado que %1 está en ejecución.%n%nPor favor cierre todas sus instancias, luego seleccione Aceptar para continuar, o Cancelar para salir.
UninstallAppRunningError=El Instalador ha detectado que %1 está en ejecución.%n%nPor favor cierre todas sus instancias, luego seleccione Aceptar para continuar, o Cancelar para salir.

; *** Misc. errors
ErrorCreatingDir=Imposible crear la carpeta "%1"
ErrorTooManyFilesInDir=Imposible crear un archivo en la carpeta "%1" porque contiene demasiados archivos


; *** Misc. errors

; *** Setup common messages
ExitSetupTitle=Salir de la Instalación
ExitSetupMessage=La instalación no está completa. Si abandona ahora, el programa no será instalado.%n%nPodrá ejecutar de nuevo este programa para completar el proceso.%n%n¿Salir de la Instalación?
AboutSetupMenuItem=&Acerca del Instalador...
AboutSetupTitle=Acerca del Instalador
AboutSetupMessage=%1 versión %2%n%3%n%n%1 página Web:%n%4
AboutSetupNote=

; *** Buttons
ButtonBack=< &Atrás
ButtonNext=&Siguiente >
ButtonInstall=&Instalar
ButtonOK=Aceptar
ButtonCancel=Cancelar
ButtonYes=&Sí
ButtonYesToAll=Sí a &Todo
ButtonNo=&No
ButtonNoToAll=N&o a Todo
ButtonFinish=&Terminar
ButtonBrowse=&Examinar...

; *** Common wizard text
ButtonWizardBrowse=Explo&rar...
ButtonNewFolder=&Crear nueva carpeta
SelectLanguageTitle=Seleccione el idioma de instalación
SelectLanguageLabel=Selecione el idioma a utilizar durante la instalación:
ClickNext=Haga clic sobre Siguiente para continuar o sobre Cancelar para salir.
BeveledLabel=

; *** "Welcome" wizard page
BrowseDialogTitle=Buscar carpeta
BrowseDialogLabel=Seleccione una carpeta de la lista y pulse Ok.
NewFolderName=Nueva Carpeta
WelcomeLabel1=Bienvenido a la instalación de [name].
WelcomeLabel2=Este programa instalará [name/ver] en su ordenador.%n%nSe recomienda que cierre todas los programas en ejecución antes de continuar.  Esto ayudará a prevenir conflictos durante el proceso.

; *** "Password" wizard page
WizardPassword=Contraseña
PasswordLabel1=Esta instalación está protegida.
PasswordLabel3=Por favor suministre su contraseña.%n%nLas contraseñas diferencian entre mayúsculas y minúsculas.
PasswordEditLabel=&Contraseña:
IncorrectPassword=La contraseña suministrada no es correcta. Por favor intente de nuevo.

; *** "License Agreement" wizard page
WizardLicense=Acuerdo de Licencia
LicenseLabel=Por favor lea la siguiente información importante antes de continuar.
LicenseLabel3=Por favor lea el siguiente Acuerdo de Licencia.  Use la barra de desplazamiento o presione la tecla Av Pág para ver el resto de la licencia.
LicenseAccepted=&Acepto los términos del Acuerdo
LicenseNotAccepted=&No acepto los términos del Acuerdo

; *** "Information" wizard pages
WizardInfoBefore=Información
InfoBeforeLabel=Por favor lea la siguiente información importante antes de continuar.
InfoBeforeClickLabel=Cuando esté listo para continuar con la instalación, haga clic sobre el botón Siguiente.
WizardInfoAfter=Información
InfoAfterLabel=Por favor lea la siguiente información importante antes de continuar.
InfoAfterClickLabel=Cuando esté listo para continuar, haga clic sobre el botón Siguiente.

; *** "User Information" wizard page
WizardUserInfo=Información de usuario
UserInfoDesc=Por favor proporcione su información.
UserInfoName=Nombre de &usuario:
UserInfoOrg=&Organización:
UserInfoSerial=&Número de serie:
UserInfoNameRequired=Debe proporcionar su nombre.

; *** "Select Destination Directory" wizard page
WizardSelectDir=Seleccione la Carpeta Destino
SelectDirDesc=¿En dónde será instalado [name]?
SelectDirBrowseLabel=Para continuar haga clic en siguiente, si desea cambiar la carpeta de instalación seleccione uno diferente.
SelectDirLabel3=La instalación copiará [name] en la siguiente carpeta.
DiskSpaceMBLabel=Se requiere un mínimo de [mb] MB de espacio en el disco.
ToUNCPathname=No se puede instalar en un directorio UNC. Si está tratando de instalar en una red, necesitará asignarlo a una unidad de red.
InvalidPath=Debe proporcionar una ruta completa con la letra de la unidad; por ejemplo:%nC:\APP
InvalidDrive=La unidad que seleccionó no existe. Por favor seleccione otra.
DiskSpaceWarningTitle=No hay espacio suficiente en el disco
DiskSpaceWarning=Se requiere al menos %1 KB de espacio libre para la instalación, pero la unidad seleccionada solamente tiene %2 KB disponibles.%n%n¿Desea continuar de todas formas?
DirNameTooLong=El nombre de directorio es demasiado largo.
InvalidDirName=El nombre de carpeta no es válido.
BadDirName32=El nombre de la carpeta no puede incluir ninguno de los siguientes caracteres después de los dos puntos:%n%n%1
DirExistsTitle=La Carpeta ya Existe
DirExists=La carpeta:%n%n%1%n%nya existe. ¿Desea instalar en esta carpeta de todas formas?
DirDoesntExistTitle=La Carpeta No Existe
DirDoesntExist=La carpeta:%n%n%1%n%n no existe. ¿Desea crear la carpeta?

; *** "Select Components" wizard page
WizardSelectComponents=Selección de Componentes
SelectComponentsDesc=¿Qué componentes desea instalar?
SelectComponentsLabel2=Seleccione los componentes que desea instalar; desmarque aquellos que no desea.  Haga clic sobre Siguiente cuando esté listo para continuar.
FullInstallation=Instalación Completa
; if possible don't translate 'Compact' as 'Minimal' (I mean 'Minimal' in your language)
CompactInstallation=Instalación Compacta
CustomInstallation=Instalación Personalizada
NoUninstallWarningTitle=Componentes Existentes
NoUninstallWarning=La Instalación ha detectado que los siguientes componentes ya están instalados en su ordenador:%n%n%1%n%nAl desmarcarlos, no se instalarán.%n%n¿Desea continuar de todos modos?
ComponentSize1=%1 KB
ComponentSize2=%1 MB
ComponentsDiskSpaceMBLabel=La selección actual requiere al menos [mb] MB de espacio en disco.

; *** "Select Additional Tasks" wizard page
WizardSelectTasks=Seleccione las Tareas Adicionales
SelectTasksDesc=¿Qué tareas adicionales deberán ejecutarse?
SelectTasksLabel2=Seleccione las tareas adicionales que desea ejecutar mientras se instala [name], luego haga clic sobre el botón Siguiente.

; *** "Select Start Menu Folder" wizard page
WizardSelectProgramGroup=Seleccione la carpeta del Menú de Inicio
SelectStartMenuFolderDesc=¿En dónde deberán colocarse los iconos de acceso directo al programa?
NoIconsCheck=&No crear icono
MustEnterGroupName=Debe proporcionar el nombre de la carpeta.
GroupNameTooLong=El nombre de directorio es demasiado largo.
InvalidGroupName=El nombre de carpeta no es válido.
BadGroupName=El nombre de la carpeta no puede incluir ninguno de los siguientes caracteres:%n%n%1
NoProgramGroupCheck2=&No crear carpeta en el Menú de Inicio

; *** "Ready to Install" wizard page
WizardReady=Listo para Instalar
ReadyLabel1=El programa está listo para iniciar la instalación de [name] en su ordenador.
ReadyLabel2a=Haga clic sobre Instalar para continuar con el proceso o sobre Atrás si desea revisar o cambiar la configuración.
ReadyLabel2b=Haga clic sobre Instalar para continuar con el proceso.
ReadyMemoUserInfo=Información del usuario:
ReadyMemoDir=Carpeta Destino:
ReadyMemoType=Tipo de Instalación:
ReadyMemoComponents=Componentes Seleccionados:
ReadyMemoGroup=Carpeta del Menú de Inicio:
ReadyMemoTasks=Tareas adicionales:

; *** "Preparing to Install" wizard page
WizardPreparing=Preparándose a Instalar
PreparingDesc=El instalado está preparándose para copiar [name] en su ordenador.
PreviousInstallNotCompleted=La instalación/ desinstalación previa del programa no se completó. Deberá reiniciar el ordenador para completar el proceso.%n%nUna vez reiniciado el ordenador ejecute de nuevo este programa para completar la instalación de [name].
CannotContinue=No se pudo continuar con la instalación. Haga clic sobre el botón Cancelar para salir.

; *** "Installing" wizard page
WizardInstalling=Instalando
InstallingLabel=Por favor espere mientras se instala [name] en su ordenador.

; *** "Setup Completed" wizard page
FinishedHeadingLabel=Terminado la instalación de [name]
FinishedLabelNoIcons=El programa terminó la instalación de [name] en su ordenador.
FinishedLabel=El programa terminó la instalación de [name] en su ordenador.  El programa puede ser ejecutado seleccionando el icono creado.
ClickFinish=Haga clic sobre Terminar para concluir la Instalación.
FinishedRestartLabel=Para completar la instalación de [name], debe reiniciar su ordenador.  ¿Desea reiniciar ahora?
FinishedRestartMessage=Para completar la instalación de [name], debe reiniciar su ordenador.%n%n¿Desea reiniciar ahora?
ShowReadmeCheck=Sí, deseo ver el archivo LEAME
YesRadio=&Sí, deseo reiniciar el ordenador ahora
NoRadio=&No, reiniciaré el ordenador más tarde
; used for example as 'Run MyProg.exe'
RunEntryExec=Ejecutar %1
; used for example as 'View Readme.txt'
RunEntryShellExec=Ver %1

; *** "Setup Needs the Next Disk" stuff
ChangeDiskTitle=La Instalación necesita el siguiente disco
SelectDiskLabel2=Por favor inserte el Disco %1 y haga clic sobre Aceptar.%n%nSi los archivos se localizan en una carpeta diferente a la mostrada abajo, proporcione la ruta correcta o haga clic sobre Examinar.
PathLabel=&Ruta:
FileNotInDir2=El archivo "%1" no se encuentra en "%2".  Por favor inserte el disco correcto o seleccione otra carpeta.
SelectDirectoryLabel=Por favor especifique la ubicación del siguiente disco.
SelectStartMenuFolderLabel3=La instalación creará el grupo de programas en el menú inicio.
SelectStartMenuFolderBrowseLabel=Para continuar haga clic en siguiente. Puede seleccionar una carpeta diferente.

; *** Installation phase messages
SetupAborted=La instalación no fue terminada.%n%nPor favor corrija el problema y ejecute Instalar de nuevo.
EntryAbortRetryIgnore=Haga clic sobre Reintentar para intentar de nuevo, Ignorar para proceder de cualquier forma o sobre Cancelar para interrumpir la instalación.

; *** Installation status messages
StatusCreateDirs=Creando carpetas...
StatusExtractFiles=Copiando archivos...
StatusCreateIcons=Creando iconos del programa...
StatusCreateIniEntries=Creando entradas INI...
StatusCreateRegistryEntries=Creando entradas en el registro...
StatusRegisterFiles=Registrando archivos...
StatusSavingUninstall=Guardando información para desinstalar...
StatusRunProgram=Terminando la instalación...
StatusRollback=Deshaciendo los cambios...

; *** Misc. errors
ErrorInternal2=Error Interno %1
ErrorFunctionFailedNoCode=%1 falló
ErrorFunctionFailed=%1 falló; código %2
ErrorFunctionFailedWithMessage=%1 falló; código %2.%n%3
ErrorExecutingProgram=Imposible ejecutar el archivo:%n%1

; *** Registry errors
ErrorRegOpenKey=Error abriendo la clave de registro:%n%1\%2
ErrorRegCreateKey=Error creando la clave de registro:%n%1\%2
ErrorRegWriteKey=Error escribiendo en la clave de registro:%n%1\%2

; *** INI errors
ErrorIniEntry=Error creando entrada en archivo INI "%1".

; *** File copying errors
FileAbortRetryIgnore=Haga clic sobre Reintentar para probar de nuevo, Ignorar para omitir este archivo (no recomendado) o Cancelar para interrumpir la instalación.
FileAbortRetryIgnore2=Haga clic sobre Reintentar para probar de nuevo, Ignorar para proceder de cualquier forma (no se recomienda) o Cancelar para interrumpir la instalación.
SourceIsCorrupted=El archivo de origen está dañado
SourceDoesntExist=El archivo de origen "%1" no existe
ExistingFileReadOnly=El archivo existente está marcado como de sólo lectura.%n%nHaga clic sobre Reintentar para quitar el atributo de sólo lectura y probar de nuevo, Ignorar para saltar este archivo o Cancelar para interrumpir la instalación.
ErrorReadingExistingDest=Ocurrió un error al tratar de leer el archivo:
FileExists=El archivo ya existe.%n%n¿Desea sobrescribirlo?
ExistingFileNewer=El archivo existente es más reciente que el que está tratando de instalar.  Se recomienda conservarlo.%n%n¿Desea mantener el archivo existente?
ErrorChangingAttr=Ocurrió un error al tratar de cambiar los atributos del archivo:
ErrorCreatingTemp=Ocurrió un error al tratar de crear un archivo en la carpeta destino:
ErrorReadingSource=Ocurrió un error al tratar de leer el archivo origen:
ErrorCopying=Ocurrió un error al tratar de copiar el archivo:
ErrorReplacingExistingFile=Ocurrió un error al tratar de reemplazar el archivo existente:
ErrorRestartReplace=Falló el reintento de reemplazar:
ErrorRenamingTemp=Ocurrió un error al tratar de renombrar un archivo en la carpeta destino:
ErrorRegisterServer=Imposible registrar el DLL/OCX: %1
ErrorRegisterServerMissingExport=No se encuentra DllRegisterServer export
ErrorRegisterTypeLib=Imposible registrar la biblioteca de tipo: %1

; *** Post-installation errors
ErrorOpeningReadme=Ocurrió un error al tratar de abrir el archivo LEAME.
ErrorRestartingComputer=El programa de Instalación no puede reiniciar el ordenador. Por favor hágalo manualmente.

; *** Uninstaller messages
UninstallNotFound=El archivo "%1" no existe. No se puede desinstalar.
UninstallOpenError=No se puede abrir el archivo "%1". No se puede desinstalar
UninstallUnsupportedVer=El archivo log para desinstalar "%1" está en un formato no reconocido por esta versión del programa. No se puede continuar
UninstallUnknownEntry=Se encontró una entrada desconocida (%1) en la log de desinstalación
ConfirmUninstall=¿Está seguro que desea eliminar completamente %1 y todos sus componentes?
OnlyAdminCanUninstall=Este programa sólo puede desinstalarlo un usuario con privilegios administrativos.
UninstallStatusLabel=Por favor espere mientras se elimina %1 de su ordenador.
UninstalledAll=%1 se eliminó con éxito de su ordenador.
UninstalledMost=La desinstalación de %1 terminó.%n%nAlgunos elementos no pudieron eliminarse. Estos pueden eliminarse manualmente.
UninstalledAndNeedsRestart=Para completar la desinstalación de %1 se requiere reiniciar el ordenador.%n%n¿Desea reiniciarla en este momento?
UninstallDataCorrupted=El archivo "%1" está dañado. No se puede desinstalar

; *** Uninstallation phase messages
ConfirmDeleteSharedFileTitle=¿Eliminar Archivos Compartidos?
ConfirmDeleteSharedFile2=El sistema informa que el siguiente archivo compartido no es utilizado por otros programas.  ¿Desea eliminar este archivo?%n%nSi otros programas están usándolo y es eliminado, éstos podrían no funcionar correctamente. Si no está seguro, elija No.  Dejando el archivo en su sistema no causa ningún daño.
SharedFileNameLabel=Nombre del archivo:
SharedFileLocationLabel=Ubicación:
WizardUninstalling=Estado de la Desinstalación
StatusUninstalling=Desinstalando %1...


[CustomMessages]

AdditionalIcons=Iconos adicionales:
CreateDesktopIcon=Crear un icono en el escritorio
CreateQuickLaunchIcon=Crear un icono en la barra del menú inicio
ProgramOnTheWeb=%1 en la Web
UninstallProgram=Desinstalar %1
LaunchProgram=Ejecutar %1
AssocFileExtension=&Asociar %1 con la extensión %2
AssocingFileExtension=Asociando %1 con la extensión de archivo %2...

ReportManagerDesigner=Diseñador Report Manager
DBExpressdatabasedrivers=Controladores DBExpress (Borland DBExpress)
BorlandDatabaseEnginedatabasedrivers=Controladores BDE (Borland Database Engine)
Commandlinetools=Utilidades de línea de comandos
Documentation=Documentación
TCPserver=Servidor de informes de red
TCPclientandmetafileviewer=Cliente de red y visor de metaarchivos
Webserver=Servidor web de informes
ActiveXcomponent=Componente ActiveX para desarrolladores
InternetExplorerplugin=Plugin para Internet Explorer

LaunchReportManagerDesignerXP=Ejecutar diseñador de informes
DesignerXP=Diseñador de informes
MetafileViewerandReportClientXP=Cliente de informes y visor de metaarchivos
TranslationUtility=Utilidad de traducción
ServerapplicationXP=Servidor de informes de red
ServerconfigurationXP=Utilidad de configuración del servidor de red
RegisterActiveX=Instalar ActiveX en el registro
UnRegisterActiveX=Eliminar ActiveX del registro
RegisterPlugin=Registrar Plugin
UnRegisterPlugin=Eliminar Plugin del registro
ReportManagerDesignerXP=Diseñador Report Manager
ReportManagerClient=Cliente Report Manager
ReportSamples=Ejemplos de informes

Fullinstallation=Instalación completa
Custominstallation=Instalación personalizada
ServiceInstallationtool=Utilidad de instalación de servicio
SLicense=Licencia