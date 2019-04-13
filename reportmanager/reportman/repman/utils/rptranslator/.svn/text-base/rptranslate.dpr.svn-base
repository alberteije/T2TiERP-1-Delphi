{*******************************************************}
{                                                       }
{       RpTranslate application                         }
{                                                       }
{       To easy translate strings at                    }
{       runtime                                         }
{                                                       }
{       Copyright (c) 1994-2002 Toni Martir             }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{*******************************************************}

program rptranslate;

{$I rpconf.inc}

uses
  Graphics,
  Forms,
{$IFDEF USEVARIANTS}
  midaslib,
{$ENDIF}
  umain in 'umain.pas' {FMain},
  rptranslator in '..\..\..\rptranslator.pas',
  uflanginfo in 'uflanginfo.pas' {FLangInfo};

{$R *.RES}

begin
  Graphics.DefFontData.Name:=Screen.IconFont.Name;
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  FMain.Font.Assign(Screen.IconFont);
  Application.Run;
end.
