{*******************************************************}
{                                                       }
{       Rpmregnet                                       }
{                                                       }
{       Units that registers the reportmanager engine   }
{       into the Delphi component palette               }
{                                                       }
{       Copyright (c) 1994-2003 Toni Martir             }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{*******************************************************}

unit rpmregnet;

interface

{$I rpconf.inc}

uses
  Classes,rplastsav,rptranslator,rpeval,rpalias,
  rppdfreport,rpvclreport;


procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Reportman', [TRpEvaluator]);
  RegisterComponents('Reportman', [TRpAlias]);
  RegisterComponents('Reportman', [TRpLastUsedStrings]);
  RegisterComponents('Reportman', [TRpTranslator]);
  RegisterComponents('Reportman', [TPDFReport]);
  RegisterComponents('Reportman', [TVCLReport]);
end;

end.
