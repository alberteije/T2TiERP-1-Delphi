{*******************************************************}
{                                                       }
{       Report Manager Server configuration             }
{                                                       }
{       repserverconfig                                 }
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

program repserverconfig;

{$I rpconf.inc}

uses
  QForms,
  mainf in 'mainf.pas' {FMain},
  unewuser in 'unewuser.pas' {FNewUser},
  unewalias in 'unewalias.pas' {FNewAlias},
{$IFDEF MSWINDOWS}
  midaslib,
  QThemed in '..\..\repman\QThemed.pas',
  QThemeSrv in '..\..\repman\QThemeSrv.pas',
  TmSchema in '..\..\repman\TmSchema.pas',
  rpmdrepclient in '..\..\rpmdrepclient.pas' {modclient: TDataModule},
{$ENDIF}
{$IFDEF LINUX}
  rpmdrepclient in '../../rpmdrepclient.pas' {modclient: TDataModule},
{$ENDIF}
  ureptree in 'ureptree.pas' {FReportTree};


{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
