{*******************************************************}
{                                                       }
{       Report Manager Server configuration             }
{                                                       }
{       repserverconfigxp                               }
{                                                       }
{       Main project to build repserverconfig           }
{                                                       }
{       Copyright (c) 1994-2002 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

program repserverconfigxp;

{$I rpconf.inc}

uses
  Graphics,
  Forms,
  mainfvcl in 'mainfvcl.pas' {FMainVCL},
  unewuservcl in 'unewuservcl.pas' {FNewUserVCL},
  unewaliasvcl in 'unewaliasvcl.pas' {FNewAliasVCL},
{$IFDEF USEVARIANTS}
  midaslib,
{$ENDIF}
  rpmdrepclient in '..\..\rpmdrepclient.pas' {modclient: TDataModule},
  rpmdprotocol in '..\..\rpmdprotocol.pas',
  ureptreevcl in 'ureptreevcl.pas' {FReportTreeVCL};

{$R *.res}

begin
  Graphics.DefFontData.Name:=Screen.IconFont.Name;
  IsMultiThread:=True;
  Application.Initialize;
  Application.CreateForm(TFMainVCL, FMainVCL);
  FMainVCL.Font.Assign(Screen.IconFont);
  Application.Run;
end.
