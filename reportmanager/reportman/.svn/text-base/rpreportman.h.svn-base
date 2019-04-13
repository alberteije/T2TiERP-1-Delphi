/*{*****************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpreportman                                     }
{       Exported functions for the Standarc C Library   }
{	  Microsoft Windows version                       }
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
int rp_open(char *filename);
int rp_new(void);
int rp_execute(int hreport,char *outputfilename,int metafile,int compressed);
int rp_setparamvalue(int hreport,char *paramname,int paramtype,
 void *paramvalue);
int rp_getparamcount(int hreport,int *paramcount);
int rp_getparamname(int hreport,int index,char *abuffer);
int rp_close(int hreport);
char * rp_lasterror(void);
int rp_print(int hreport,char *title,int showprogress,int showprintdialog);
int rp_preview(int hreport,char *title);
int rp_executeremote(char *hostname,int port,char *user,char *password,
 char *aliasname,char *reportname,char *outputfilename,int metafile,
 int compressed);
int rp_getremoteparams(char *hostname,int port,char *user,char *password,
 char *aliasname,char *reportname);
int rp_executeremote_report(int hreport,char *hostname,int port,char *user,char *password,
 char *aliasname,char *reportname,char *outputfilename,int metafile,
 int compressed);
int rp_previewremote(char *hostname,int port,char *user,char *password,
 char *aliasname,char *reportname,char *title);
int rp_previewremote_report(int hreport,char *hostname,int port,char *user,char *password,
 char *aliasname,char *reportname,char *title);
int rp_printremote(char *hostname,int port,char *user,char *password,
 char *aliasname,char *reportname,char *title,int showprogress,
 int showprintdialog);
int rp_printremote_report(int hreport,char *hostname,int port,char *user,char *password,
 char *aliasname,char *reportname,char *title,int showprogress,
 int showprintdialog);



/*int rp_setparamvaluevar(int hreport,char *paramname,OleVariant paramvalue);*/
int rp_setadoconnectionstring(int hreport,char *conname,char *constring);
char* rp_getprinters(void);
char* rp_getdefaultprinter(void);
int rp_setdefaultprinter(char *device); 


#ifdef __cplusplus
}
#endif
#endif



