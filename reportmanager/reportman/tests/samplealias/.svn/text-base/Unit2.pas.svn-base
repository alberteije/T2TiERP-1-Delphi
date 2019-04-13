unit Unit2;

interface

uses
  SysUtils, Classes, rpcompobase, rppdfreport, rpalias, DB, DBClient;

type
  Tdatamod = class(TDataModule)
    ClientDataSet1: TClientDataSet;
    ClientDataSet1CODE: TStringField;
    ClientDataSet1NAME: TStringField;
    ClientDataSet1PRICE: TCurrencyField;
    RpAlias1: TRpAlias;
    PDFReport1: TPDFReport;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.xfm}

procedure Tdatamod.DataModuleCreate(Sender: TObject);
begin
 ClientDataSet1.CreateDataSet;
 ClientDataset1.AppendRecord(['XF','Phone mod 25',134.25]);
 ClientDataset1.AppendRecord(['XF','Phone mod 31',145.25]);
 ClientDataset1.AppendRecord(['XF','Alcaone Phone HG45',450.25]);
 ClientDataSet1.First;
 PDFReport1.Filename:='sample.rep';
 PDFReport1.PDFFilename:='sample.pdf';
end;

end.
