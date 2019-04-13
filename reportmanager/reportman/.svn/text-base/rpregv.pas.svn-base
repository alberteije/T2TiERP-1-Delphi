{*******************************************************}
{                                                       }
{       Rpregv                                          }
{                                                       }
{       Units that registers the reportmanager engine   }
{       (visual controls into the component palette)    }
{                                                       }
{       Copyright (c) 1994-2003 Toni Martir             }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rpregv;

{$I rpconf.inc}

interface

uses
  Classes,
  rpexpredlg,rpcompobase,rpalias,rpdatainfo,
{$IFDEF LINUX}
{$IFNDEF BCB}
  DesignIntf,rpmdesigneditors,rpeditaliasclx,
{$ENDIF}
{$ENDIF}
  rpclxreport,rpmaskeditclx;

procedure Register;


implementation

procedure Register;
begin
 RegisterComponents('Reportman', [TRpExpreDialog]);
 RegisterComponents('Reportman', [TCLXReport]);
 RegisterComponents('Reportman', [TRpCLXMaskEdit]);
{$IFDEF LINUX}
{$IFNDEF BCB}
 RegisterPropertyEditor(TypeInfo(String),TCBaseReport,'ConnectionName',TRpReportLibNamePropEditor);
 RegisterPropertyEditor(TypeInfo(String),TCBaseReport,'ReportName',TRpReportNamePropEditor);
 RegisterPropertyEditor(TypeInfo(TRpDatabaseInfoList),TRpAlias,'',TRpConnectionPropEditor);
{$ENDIF}
{$ENDIF}
end;

end.
