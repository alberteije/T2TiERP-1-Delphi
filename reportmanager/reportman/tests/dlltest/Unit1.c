#include <stdio.h>
#include "..\..\rpreportmanapiqt.h"
int main(int argc, char* argv[])
{
        char filename[]="c:\\prog\\toni\\cvsroot\\reportman\\reportman\\repman\\repsamples\\sample2.rep";
        int hreport;

        printf("Hello, this is a test app for Report Manager engine\n");
        printf("The filename: %s\n",filename);

        hreport=rp_open(filename);
        if (hreport==0)
         printf("%s\n",rp_lasterror());
        else
         printf("Handle: %d\n",hreport);
        hreport=rp_preview(hreport,"Hello");
        if (hreport==0)
         printf("%s\n",rp_lasterror());
        else
         printf("Handle: %d\n",hreport);
        return 0;

}
 
