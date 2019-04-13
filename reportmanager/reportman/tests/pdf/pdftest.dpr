program pdftest;

{$APPTYPE CONSOLE}
uses rppdfreport;

var
 pdfrep:TPDFReport;

begin
 pdfrep:=TPDFReport.Create(nil);
 try
  pdfrep.PDFfilename:='prova.pdf';
  pdfrep.filename:='sample2.rep';
  pdfrep.Execute;
 finally
  pdfrep.free;
 end;
end.
