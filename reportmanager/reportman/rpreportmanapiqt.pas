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

unit rpreportmanapiqt;

interface

{$IFNDEF LINUX}
 {$DEFINE MSWINDOWS}
{$ENDIF}

const
{$IFDEF MSWINDOWS}
 REP_LIBNAME='ReportMan.ocx';
{$ENDIF}
{$IFDEF LINUX}
 REP_LIBNAME='reportmanapiqt.so';
{$ENDIF}

function rp_open(filename:PChar):integer;stdcall;external REP_LIBNAME;
function rp_execute(hreport:integer;outputfilename:PChar;metafile,
 compressed:integer):integer;stdcall;external REP_LIBNAME;
function rp_close(hreport:integer):integer;stdcall;external REP_LIBNAME;
function rp_lasterror:PChar;stdcall;external REP_LIBNAME;
function rp_print(hreport:integer;Title:PChar;
 showprogress,ShowPrintDialog:integer):integer;stdcall;external REP_LIBNAME;
function rp_executeremote(hostname:PChar;port:integer;user,password,aliasname,reportname:PChar;outputfilename:PChar;metafile,
 compressed:integer):integer;stdcall;external REP_LIBNAME;
function rp_preview(hreport:integer;Title:PChar):integer;stdcall;external REP_LIBNAME;
function rp_previewremote(hostname:PChar;port:integer;user,password,aliasname,reportname,title:PChar):integer;stdcall;external REP_LIBNAME;
function rp_printremote(hostname:PChar;port:integer;user,password,aliasname,reportname,title:PChar;showprogress,showprintdialog:integer):integer;stdcall;external REP_LIBNAME;

implementation

end.

