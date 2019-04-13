{*******************************************************}
{                                                       }
{       Rpmregdesign                                    }
{                                                       }
{       Units that registers the Report Manager Designer}
{       into the Delphi component palette               }
{                                                       }
{       Copyright (c) 1994-2002 Toni Martir             }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{*******************************************************}

unit rpmregdesign;

interface

uses Classes,rpmdesigner,rpruler;

procedure Register;

implementation

procedure Register;
begin
 RegisterComponents('Reportman', [TRpDesigner]);
 RegisterComponents('Reportman', [TRpRuler]);
end;

end.
