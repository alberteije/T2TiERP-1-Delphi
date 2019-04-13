/*{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpreportmanapi                                  }
{       Exported functions for the Standarc C Library   }
{       Copyright (c) 1994-2003 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}
*/

#ifndef _REPORTMAN_H
#define _REPORTMAN_H


#ifdef __cplusplus
extern "C" {
#endif
/* Add __stdcall in Microsoft Windows? */
int rp_new(void);
int rp_open(char *filename);
int rp_execute(int hreport,char *outputfilename,int metafile,int compressed);
int rp_close(int hreport);
int rp_setparamvalue(int hreport,char *paramname,int paramtype,
 void *paramvalue);
int rp_getparamcount(int hreport,int *paramcount);
int rp_getparamname(int hreport,int index,char *abuffer);
char * rp_lasterror(void);
int rp_print(int hreport,char *title,int showprogress,int showprintdialog);
int rp_preview(int hreport,char *title);
int rp_executeremote(char *hostname,int port,char *user,char *password,
 char *aliasname,char *reportname,char *outputfilename,int metafile,
 int compressed);
int rp_executeremote_report(int hreport,char *hostname,int port,char *user,char *password,
 char *aliasname,char *reportname,char *outputfilename,int metafile,
 int compressed);
int rp_getremoteparams(int hreport,char *hostname,int port,char *user,char *password,
 char *aliasname,char *reportname);
int rp_previewremote(char *hostname,int port,char *user,char *password,
 char *aliasname,char *reportname,char *title);
int rp_printremote(char *hostname,int port,char *user,char *password,
 char *aliasname,char *reportname,char *title,int showprogress,
 int showprintdialog);
int rp_previewremote_report(int hreport,char *hostname,int port,char *user,char *password,
 char *aliasname,char *reportname,char *title);
int rp_printremote_report(int hreport,char *hostname,int port,char *user,char *password,
 char *aliasname,char *reportname,char *title,int showprogress,
 int showprintdialog);
int rp_bitmap(int hreport,char *outputfilename,int ask,int mono,int vertres,int horzres);

#ifdef __cplusplus
}
#endif
#endif



