{*******************************************************}
{                                                       }
{       Rpregvcl                                        }
{                                                       }
{       Units that registers the reportmanager engine   }
{       vcl version Delphi 6 component palette          }
{                                                       }
{       Copyright (c) 1994-2003 Toni Martir             }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{*******************************************************}


unit rpregvcl;

interface

{$I rpconf.inc}

uses
  Classes,rpvclreport,rpexpredlgvcl,rpmaskedit,rpdbgridvcl,rpdbdatetimepicker,
{$IFDEF DELPHI2007UP}
  rpactivexreport,rpwebmetaclient,
{$ENDIF}
  rppreviewcontrol;


procedure Register;

implementation


procedure Register;
begin
  RegisterComponents('Reportman', [TVCLReport]);
  RegisterComponents('Reportman', [TRpExpreDialogVCL]);
  RegisterComponents('Reportman', [TRpMaskEdit]);
  RegisterComponents('Reportman', [TRpGrid]);
  RegisterComponents('Reportman', [TRpPreviewControl]);
  RegisterComponents('Reportman', [TRpDateTimePicker]);
  // TRpActiveXReport is a Wrapper to generate the ActiveX version
  // with Delphi 6 Active X Control Wizard
{$IFDEF DELPHI2007UP}
  RegisterComponents('Reportman', [TRpActiveXReport]);
  RegisterComponents('Reportman', [TRpWebMetaPrint]);
{$ENDIF}
end;

end.
