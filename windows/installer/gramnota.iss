; Gramnota per-user installer.
; Built by windows/installer/package.ps1 from the Flutter Release folder.
;
; AppId must stay the same for every release so a later installer upgrades
; in place (same folder, shortcuts replaced, previous files overwritten).

#ifndef AppVersion
  #define AppVersion "1.0.0"
#endif
#ifndef AppBuild
  #define AppBuild "0"
#endif

#define AppName "Gramnota"
#define AppExe "gramnota.exe"
#define ReleaseDir "..\..\build\windows\x64\runner\Release"

[Setup]
AppId={{27490BFC-E669-4D7D-8898-3763FBEFA6E9}
AppName={#AppName}
AppVersion={#AppVersion}
AppVerName={#AppName} {#AppVersion}
AppPublisher=Gramnota
AppComments=Sale prices for 3D prints
AppPublisherURL=https://github.com/Mahinika/gramnota
VersionInfoVersion={#AppVersion}.{#AppBuild}
VersionInfoProductVersion={#AppVersion}
VersionInfoCompany=Gramnota
VersionInfoDescription=Gramnota
VersionInfoProductName=Gramnota
DefaultDirName={autopf}\{#AppName}
DefaultGroupName={#AppName}
DisableProgramGroupPage=yes
OutputDir=..\..\build\windows\installer
OutputBaseFilename=Gramnota-Setup-{#AppVersion}
SetupIconFile=..\runner\resources\app_icon.ico
UninstallDisplayIcon={app}\{#AppExe}
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
; Admin install to Program Files. An already-elevated CI runner cannot
; complete a per-user (PrivilegesRequired=lowest) install, because Inno
; re-launches unelevated and that re-launch fails there.
PrivilegesRequired=admin
MinVersion=10.0
CloseApplications=yes
RestartApplications=no
UsedUserAreasWarning=no

[Tasks]
; Checked by default. There is no "checked" flag; "unchecked" would opt out.
Name: "desktopicon"; Description: "Create a &desktop shortcut"; GroupDescription: "Additional icons:"

[Files]
Source: "{#ReleaseDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pdb,*.ilk,*.exp,*.lib"

[Icons]
Name: "{group}\{#AppName}"; Filename: "{app}\{#AppExe}"
Name: "{autodesktop}\{#AppName}"; Filename: "{app}\{#AppExe}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#AppExe}"; Description: "Launch {#AppName}"; Flags: nowait postinstall skipifsilent
