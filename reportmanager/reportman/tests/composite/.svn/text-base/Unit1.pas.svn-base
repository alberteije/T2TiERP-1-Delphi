unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, rpcompobase, rpvclreport,rpgdidriver;

type
  TForm1 = class(TForm)
    reportman1: TVCLReport;
    reportman2: TVCLReport;
    reportman3: TVCLReport;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
        reportman1.filename := 'c:\prog\toni\cvsroot\reportman\reportman\repman\repsamples\sampl2.rep';
        CalcReportWidthProgress(reportman1.report);
        reportman2.filename := 'c:\prog\toni\cvsroot\reportman\reportman\repman\repsamples\sampl2.rep';
        reportman2.report.Compose(reportman1.Report, False,nil);
        CalcReportWidthProgress(reportman2.report);
        reportman3.filename := 'c:\prog\toni\cvsroot\reportman\reportman\repman\repsamples\sampl2.rep';
        reportman3.report.Compose(reportman2.Report, false,nil);
        reportman3.preview:=true;
        reportman3.execute;
end;

end.
