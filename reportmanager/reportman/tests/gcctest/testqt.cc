#include <stdio.h>
#include "../../rpreportmanapiqt.h"

int main(void)
{
 int hreport;

 char reportmanfile[]="c:\\prog\\toni\\reportman\\repman\\repsamples\\sample2.rep";
 printf("Test for report manager\n");
 printf("Will load :");
 printf(reportmanfile);
 printf("\n");

 hreport=rp_open(reportmanfile);
 if (hreport==0)
 {	 
   printf("Error loading: ");
   printf(rp_lasterror());
   printf("\n");
 }
 else
 {
  printf("%d \n",hreport);
  if (0==rp_preview(hreport,"Hello"))
  {
   printf(rp_lasterror());
   printf("\n");
  }
  rp_close(hreport);
 }
 printf("\n");
}

