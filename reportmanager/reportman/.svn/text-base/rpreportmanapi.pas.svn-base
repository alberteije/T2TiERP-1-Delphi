{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpdllutil                                       }
{       Exported functions for the Standarc C Library   }
{                                                       }
{       Copyright (c) 1994-2003 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rpreportmanapi;

interface

{$IFNDEF LINUX}
 {$DEFINE MSWINDOWS}
{$ENDIF}

const
{$IFDEF MSWINDOWS}
 REP_LIBNAME='ReportMan.ocx';
{$ENDIF}
{$IFDEF LINUX}
 REP_LIBNAME='reportmanapi.so';
{$ENDIF}

function rp_open(filename:PChar):integer;stdcall;external REP_LIBNAME;
function rp_execute(hreport:integer;outputfilename:PChar;metafile,
 compressed:integer):integer;stdcall;external REP_LIBNAME;
function rp_close(hreport:integer):integer;stdcall;external REP_LIBNAME;
function rp_lasterror:PChar;stdcall;external REP_LIBNAME;
function rp_executeremote(hostname:PChar;port:integer;user,password,aliasname,reportname:PChar;outputfilename:PChar;metafile,
 compressed:integer):integer;stdcall;external REP_LIBNAME;
function rp_setparamvalue(hreport:integer;paramname:pchar;paramtype:integer;
 paramvalue:Pointer):integer;external REP_LIBNAME;
function rp_getparamcount(hreport:integer;var paramcount:Integer):integer;external REP_LIBNAME;
function rp_getparamname(hreport:integer;index:integer;
 abuffer:PChar):integer;external REP_LIBNAME;
{$IFDEF MSWINDOWS}
function rp_print(hreport:integer;Title:PChar;
 showprogress,ShowPrintDialog:integer):integer;stdcall;external REP_LIBNAME;
function rp_preview(hreport:integer;Title:PChar):integer;stdcall;external REP_LIBNAME;
function rp_previewremote(hostname:PChar;port:integer;user,password,aliasname,reportname,title:PChar):integer;stdcall;external REP_LIBNAME;
function rp_printremote(hostname:PChar;port:integer;user,password,aliasname,reportname,title:PChar;showprogress,showprintdialog:integer):integer;external REP_LIBNAME;
function rp_setparamvaluevar(hreport:integer;paramname:pchar;
 paramvalue:OleVariant):integer;external REP_LIBNAME;
function rp_setadoconnectionstring(hreport:integer;conname:pchar;
 constring:PChar):integer;external REP_LIBNAME;
function rp_bitmap(hreport:integer;outputfilename:PChar;
 ask,mono,vertres,horzres:integer):integer;stdcall;external REP_LIBNAME;
function rp_getdefaultprinter:pchar;stdcall;external REP_LIBNAME;
function rp_getprinters:pchar;stdcall;external REP_LIBNAME;
function rp_setdefaultprinter(device:pchar):integer;stdcall;external REP_LIBNAME;
{$ENDIF}

implementation

end.

