{*******************************************************}
{                                                       }
{       Report Server Application with GUI              }
{                                                       }
{       reportserverapp                                 }
{                                                       }
{       Use the console appliation or the service       }
{       instead, it's more secure                       }
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

program reportserverapp;

{%ToDo 'reportserverapp.todo'}

uses
  QForms,
  fmainf in 'fmainf.pas' {FSerMain},
  urepserver in 'urepserver.pas' {modserver: TDataModule},
{$IFDEF MSWINDOWS}
  midaslib,
  QThemed in '..\..\repman\QThemed.pas',
  QThemeSrv in '..\..\repman\QThemeSrv.pas',
  TmSchema in '..\..\repman\TmSchema.pas',
  rpmdprotocol in '..\..\rpmdprotocol.pas';
{$ENDIF}
{$IFDEF LINUX}
  rpmdprotocol in '../../rpmdprotocol.pas';
{$ENDIF}

{$R *.res}

begin
  IsMultiThread:=True;
  Application.Initialize;
  Application.CreateForm(TFSerMain, FSerMain);
  Application.Run;
end.
