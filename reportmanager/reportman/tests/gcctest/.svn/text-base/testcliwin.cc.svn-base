#include <stdio.h>
#include "../../rpreportmanapiqt.h"

int main(void)
{
 int hreport;

 char reportmanfile[]="sampl.rep";
 char aliasname[]="SAMPLE";
 int port=3060;

 printf("Test for report manager TCP client\n");
 printf("Will load :");
 printf(reportmanfile);
 printf("\n");

 hreport=rp_previewremote("LOCALHOST",port,"ADMIN","",aliasname,reportmanfile,"Sample for report manager");
// hreport=rp_executeremote("LOCALHOST",port,"ADMIN","",aliasname,reportmanfile,"Sample.pdf",0,1);
 if (hreport==0)
 {	 
   printf("Error loading: ");
   printf(rp_lasterror());
   printf("\n");
 }
 else
 printf("Correct execution\n");
}

