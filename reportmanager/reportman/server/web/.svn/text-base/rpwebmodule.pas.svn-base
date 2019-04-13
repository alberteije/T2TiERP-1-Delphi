unit rpwebmodule;

interface


uses
  SysUtils, Classes, HTTPApp,rptypes,rpmdconsts,inifiles,
{$IFDEF USEADO}
  ActiveX,
{$ENDIF}
  rpmdshfolder,
  rpwebpages;

type
  Trepwebmod = class(TWebModule)
    procedure repwebmodaversionAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModuleDestroy(Sender: TObject);
    procedure repwebmodaindexAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure repwebmodaloginAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure repwebmodashowaliasAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure repwebmodashowparamsAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure repwebmodaexecuteAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure repwebmodaexecute2Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
    pageloader:TRpWebPageLoader;
  public
    { Public declarations }
  end;

var
  repwebmod: Trepwebmod;

implementation

{$R *.dfm}

procedure Trepwebmod.repwebmodaversionAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
 pageloader.GetWebPage(Request,rpwVersion,Response);
end;


procedure Trepwebmod.WebModuleCreate(Sender: TObject);
begin
 pageloader:=TRpWebPageLoader.Create(Self);
{$IFDEF USEADO}
 Coinitialize(nil);
{$ENDIF}
end;




procedure Trepwebmod.WebModuleDestroy(Sender: TObject);
begin
 pageloader.free;
end;

procedure Trepwebmod.repwebmodaindexAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
 pageloader.GetWebPage(Request,rpwIndex,Response);
end;

procedure Trepwebmod.repwebmodaloginAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
 pageloader.GetWebPage(Request,rpwLogin,Response);
end;

procedure Trepwebmod.repwebmodashowaliasAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
 pageloader.GetWebPage(Request,rpwShowAlias,Response);
end;

procedure Trepwebmod.repwebmodashowparamsAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
 pageloader.GetWebPage(Request,rpwShowParams,Response);
end;


procedure Trepwebmod.repwebmodaexecuteAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
 pageloader.ExecuteReport(Request,Response);
end;

procedure Trepwebmod.repwebmodaexecute2Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
 pageloader.ExecuteReport(Request,Response);
end;

end.

