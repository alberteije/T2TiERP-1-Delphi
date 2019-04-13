program testqtlin;

 {$mode objfpc}{$H+}
//{$L libborqt-6.9-qt2.3.so}
//{$L libborunwind.so.6.0}

 uses
 rpreportmanapiqt;

 var
 HReport: Integer;
 const
 reportmanfile = 'sample4.rep';

 begin

 writeln('Test for report manager');
 write('Will load :');
 writeln(reportmanfile);

 hreport := rp_open(reportmanfile);

 if hreport = 0 then
 begin
 write('Error loading: ');
 writeln(rp_lasterror);
 end
 else
 begin
 writeln(hreport);
 if (rp_preview(hreport,'Hello') = 0) then
 begin
 writeln(rp_lasterror());
 end;
 //f (0==rp_print(hreport,"Test",0,1))
 //{
 // printf(rp_lasterror());
 // printf("\n");
 //}

 rp_close(hreport);
 end;
 //if
 //(rp_previewremote('localhost',3060,'admin','','test','sample4.rep','Test') <>
 //0) then
 //begin
 //writeln(rp_lasterror());
 //end;
 writeln;
 end.
