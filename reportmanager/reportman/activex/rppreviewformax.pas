unit rppreviewformax;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActiveX, AxCtrls, reportman_TLB, StdVcl, rppreviewmeta, rppreviewcontrol,
  rpreport,rppdfdriver,rptextdriver,rpexceldriver,rpgdidriver,
  rphtmldriver,rpsvgdriver,rpcsvdriver,rpmetafile;

type
  TPreviewControl = class(TActiveForm, IPreviewControl)
    PControl: TRpPreviewControl;
    procedure ActiveFormDestroy(Sender: TObject);
    procedure ActiveFormCreate(Sender: TObject);
  private
    { Private declarations }
    FEvents: IPreviewControlEvents;
    procedure ActivateEvent(Sender: TObject);
    procedure ClickEvent(Sender: TObject);
    procedure CreateEvent(Sender: TObject);
    procedure DblClickEvent(Sender: TObject);
    procedure DeactivateEvent(Sender: TObject);
    procedure DestroyEvent(Sender: TObject);
    procedure KeyPressEvent(Sender: TObject; var Key: Char);
    procedure PaintEvent(Sender: TObject);
    procedure WorkProgressEvent(Sender:TObject;recordcount,pagecount:integer;var docancel:boolean);
    procedure PageDrawn(prm:TRpPreviewMeta);
  protected
    { Protected declarations }
    procedure DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage); override;
    procedure EventSinkChanged(const EventSink: IUnknown); override;
    function Get_Active: WordBool; safecall;
    function Get_AutoScroll: WordBool; safecall;
    function Get_AutoSize: WordBool; safecall;
    function Get_AxBorderStyle: TxActiveFormBorderStyle; safecall;
    function Get_Caption: WideString; safecall;
    function Get_Color: OLE_COLOR; safecall;
    function Get_Cursor: Smallint; safecall;
    function Get_DoubleBuffered: WordBool; safecall;
    function Get_DropTarget: WordBool; safecall;
    function Get_Enabled: WordBool; safecall;
    function Get_Font: IFontDisp; safecall;
    function Get_HelpFile: WideString; safecall;
    function Get_KeyPreview: WordBool; safecall;
    function Get_PixelsPerInch: Integer; safecall;
    function Get_PrintScale: TxPrintScale; safecall;
    function Get_Scaled: WordBool; safecall;
    function Get_Visible: WordBool; safecall;
    function Get_VisibleDockClientCount: Integer; safecall;
    procedure Set_AutoScroll(Value: WordBool); safecall;
    procedure Set_AutoSize(Value: WordBool); safecall;
    procedure Set_AxBorderStyle(Value: TxActiveFormBorderStyle); safecall;
    procedure Set_Caption(const Value: WideString); safecall;
    procedure Set_Color(Value: OLE_COLOR); safecall;
    procedure Set_Cursor(Value: Smallint); safecall;
    procedure Set_DoubleBuffered(Value: WordBool); safecall;
    procedure Set_DropTarget(Value: WordBool); safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
//    procedure Set_Font(var Value: IFontDisp); safecall;
    procedure Set_HelpFile(const Value: WideString); safecall;
    procedure Set_KeyPreview(Value: WordBool); safecall;
    procedure Set_PixelsPerInch(Value: Integer); safecall;
    procedure Set_PrintScale(Value: TxPrintScale); safecall;
    procedure Set_Scaled(Value: WordBool); safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    procedure SetReport(const Report: IReportReport); safecall;
    function Get_AutoScale: TxAutoScaleType; safecall;
    function Get_EntirePageCount: Integer; safecall;
    function Get_EntireTopDown: WordBool; safecall;
    function Get_Finished: WordBool; safecall;
    function Get_Page: Integer; safecall;
    function Get_PreviewScale: Double; safecall;
    procedure FirstPage; safecall;
    procedure LastPage; safecall;
    procedure NextPage; safecall;
    procedure PriorPage; safecall;
    procedure RefreshMetafile; safecall;
    procedure DoScroll(vertical: WordBool; increment: Integer); safecall;
    procedure Set_AutoScale(Value: TxAutoScaleType); safecall;
    procedure Set_EntirePageCount(Value: Integer); safecall;
    procedure Set_EntireTopDown(Value: WordBool); safecall;
    procedure Set_Finished(Value: WordBool); safecall;
    procedure Set_Page(Value: Integer); safecall;
    procedure Set_PreviewScale(Value: Double); safecall;
    procedure SaveToFile(const filename: WideString; format: Integer;
      const textdriver: WideString; horzres, vertres: Integer;
      mono: WordBool); safecall;
    procedure Set_Font(const Value: IFontDisp); safecall;
    procedure _Set_Font(var Value: IFontDisp); safecall;
    procedure Clear; safecall;
  public
    { Public declarations }
    procedure Initialize; override;
  end;

implementation

uses ComObj, ComServ;

{$R *.DFM}

{ TPreviewControl }

procedure TPreviewControl.DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage);
begin
  { Define property pages here.  Property pages are defined by calling
    DefinePropertyPage with the class id of the page.  For example,
      DefinePropertyPage(Class_PreviewControlPage); }
end;

procedure TPreviewControl.EventSinkChanged(const EventSink: IUnknown);
begin
  FEvents := EventSink as IPreviewControlEvents;
end;

procedure TPreviewControl.Initialize;
begin
  inherited Initialize;
  OnActivate := ActivateEvent;
  OnClick := ClickEvent;
  OnCreate := CreateEvent;
  OnDblClick := DblClickEvent;
  OnDeactivate := DeactivateEvent;
  OnDestroy := DestroyEvent;
  OnKeyPress := KeyPressEvent;
  OnPaint := PaintEvent;
end;

function TPreviewControl.Get_Active: WordBool;
begin
  Result := Active;
end;

function TPreviewControl.Get_AutoScroll: WordBool;
begin
  Result := AutoScroll;
end;

function TPreviewControl.Get_AutoSize: WordBool;
begin
  Result := AutoSize;
end;

function TPreviewControl.Get_AxBorderStyle: TxActiveFormBorderStyle;
begin
  Result := Ord(AxBorderStyle);
end;

function TPreviewControl.Get_Caption: WideString;
begin
  Result := WideString(Caption);
end;

function TPreviewControl.Get_Color: OLE_COLOR;
begin
  Result := OLE_COLOR(Color);
end;

function TPreviewControl.Get_Cursor: Smallint;
begin
  Result := Smallint(Cursor);
end;

function TPreviewControl.Get_DoubleBuffered: WordBool;
begin
  Result := DoubleBuffered;
end;

function TPreviewControl.Get_DropTarget: WordBool;
begin
  Result := DropTarget;
end;

function TPreviewControl.Get_Enabled: WordBool;
begin
  Result := Enabled;
end;

function TPreviewControl.Get_Font: IFontDisp;
begin
  GetOleFont(Font, Result);
end;

function TPreviewControl.Get_HelpFile: WideString;
begin
  Result := WideString(HelpFile);
end;

function TPreviewControl.Get_KeyPreview: WordBool;
begin
  Result := KeyPreview;
end;

function TPreviewControl.Get_PixelsPerInch: Integer;
begin
  Result := PixelsPerInch;
end;

function TPreviewControl.Get_PrintScale: TxPrintScale;
begin
  Result := Ord(PrintScale);
end;

function TPreviewControl.Get_Scaled: WordBool;
begin
  Result := Scaled;
end;

function TPreviewControl.Get_Visible: WordBool;
begin
  Result := Visible;
end;

function TPreviewControl.Get_VisibleDockClientCount: Integer;
begin
  Result := VisibleDockClientCount;
end;


procedure TPreviewControl.ActivateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnActivate;
end;

procedure TPreviewControl.ClickEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnClick;
end;

procedure TPreviewControl.CreateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnCreate;
end;

procedure TPreviewControl.DblClickEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDblClick;
end;

procedure TPreviewControl.DeactivateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDeactivate;
end;

procedure TPreviewControl.DestroyEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDestroy;
end;

procedure TPreviewControl.WorkProgressEvent(Sender:TObject;recordcount,pagecount:integer;var docancel:boolean);
var
 ncancel:WordBool;
begin
 ncancel:=docancel;
 if FEvents<>nil then
  FEvents.OnWorkProgress(recordcount,pagecount,ncancel);
 docancel:=ncancel;
end;

procedure TPreviewControl.KeyPressEvent(Sender: TObject; var Key: Char);
var
  TempKey: Smallint;
begin
  TempKey := Smallint(Key);
  if FEvents <> nil then FEvents.OnKeyPress(TempKey);
  Key := Char(TempKey);
end;

procedure TPreviewControl.PaintEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnPaint;
end;

procedure TPreviewControl.Set_AutoScroll(Value: WordBool);
begin
  AutoScroll := Value;
end;

procedure TPreviewControl.Set_AutoSize(Value: WordBool);
begin
  AutoSize := Value;
end;

procedure TPreviewControl.Set_AxBorderStyle(
  Value: TxActiveFormBorderStyle);
begin
  AxBorderStyle := TActiveFormBorderStyle(Value);
end;

procedure TPreviewControl.Set_Caption(const Value: WideString);
begin
  Caption := TCaption(Value);
end;

procedure TPreviewControl.Set_Color(Value: OLE_COLOR);
begin
  Color := TColor(Value);
end;

procedure TPreviewControl.Set_Cursor(Value: Smallint);
begin
  Cursor := TCursor(Value);
end;

procedure TPreviewControl.Set_DoubleBuffered(Value: WordBool);
begin
  DoubleBuffered := Value;
end;

procedure TPreviewControl.Set_DropTarget(Value: WordBool);
begin
  DropTarget := Value;
end;

procedure TPreviewControl.Set_Enabled(Value: WordBool);
begin
  Enabled := Value;
end;

procedure TPreviewControl._Set_Font(var Value: IFontDisp);
safecall;
begin
  SetOleFont(Font, Value);
end;

procedure TPreviewControl.Set_HelpFile(const Value: WideString);
begin
  HelpFile := String(Value);
end;

procedure TPreviewControl.Set_KeyPreview(Value: WordBool);
begin
  KeyPreview := Value;
end;

procedure TPreviewControl.Set_PixelsPerInch(Value: Integer);
begin
  PixelsPerInch := Value;
end;

procedure TPreviewControl.Set_PrintScale(Value: TxPrintScale);
begin
  PrintScale := TPrintScale(Value);
end;

procedure TPreviewControl.Set_Scaled(Value: WordBool);
begin
  Scaled := Value;
end;

procedure TPreviewControl.Set_Visible(Value: WordBool);
begin
  Visible := Value;
end;

procedure TPreviewControl.SetReport(const Report: IReportReport);
var
 aobj:TObject;
begin
 if (Report=nil) then
 begin
  PControl.Report:=nil;
  exit;
 end;
 aobj:=TObject(Report.VCLReport);
 if not (aobj is TRpReport) then
  Raise Exception.Create('Report not assigned');
 PControl.Report:=TRpReport(aobj);
end;

procedure TPreviewControl.ActiveFormDestroy(Sender: TObject);
begin
 PControl.Report:=nil;
end;

procedure TPreviewControl.ActiveFormCreate(Sender: TObject);
begin
 PControl.OnPageDrawn:=PageDrawn;
 PControl.OnWorkProgress:=WorkProgressEvent;
end;

procedure TPreviewControl.PageDrawn(prm:TRpPreviewMeta);
begin
 if FEvents<>nil then
  FEvents.OnPageDrawn(prm.PageDrawn,prm.PagesDrawn);
end;

function TPreviewControl.Get_AutoScale: TxAutoScaleType;
begin
 Result:=TxAutoScaleType(PControl.AutoScale);
end;

function TPreviewControl.Get_EntirePageCount: Integer;
begin
 Result:=PControl.EntirePageCount;
end;

function TPreviewControl.Get_EntireTopDown: WordBool;
begin
 Result:=PControl.EntireTopDown;
end;

function TPreviewControl.Get_Finished: WordBool;
begin
 Result:=false;
 if Assigned(PControl.Report) then
  Result:=PControl.Report.LastPage;
end;

function TPreviewControl.Get_Page: Integer;
begin
 REsult:=PControl.Page;
end;

function TPreviewControl.Get_PreviewScale: Double;
begin
 REsult:=PControl.PreviewScale;
end;

procedure TPreviewControl.FirstPage;
begin
 PControl.FirstPage;
end;

procedure TPreviewControl.LastPage;
begin
 PControl.LastPage;
end;

procedure TPreviewControl.NextPage;
begin
 PControl.NextPage;
end;

procedure TPreviewControl.PriorPage;
begin
 PControl.PriorPage;
end;

procedure TPreviewControl.RefreshMetafile;
begin
 PControl.RefreshMetafile;
end;

procedure TPreviewControl.DoScroll(vertical: WordBool; increment: Integer);
begin
 PControl.Scroll(vertical,increment);
end;

procedure TPreviewControl.Set_AutoScale(Value: TxAutoScaleType);
begin
 PControl.AutoScale:=TAutoScaleType(Value);
end;

procedure TPreviewControl.Set_EntirePageCount(Value: Integer);
begin
 PControl.EntirePageCount:=Value;
end;

procedure TPreviewControl.Set_EntireTopDown(Value: WordBool);
begin
 PControl.EntireTopDown:=Value;
end;

procedure TPreviewControl.Set_Finished(Value: WordBool);
begin
 Raise Exception.Create('Finished can not be set');
end;

procedure TPreviewControl.Set_Page(Value: Integer);
begin
 PControl.Page:=Value;
end;

procedure TPreviewControl.Set_PreviewScale(Value: Double);
begin
 PControl.PreviewScale:=Value;
end;


procedure TPreviewControl.SaveToFile(const filename: WideString;
  format: Integer; const textdriver: WideString; horzres, vertres: Integer;
  mono: WordBool);
var
 apage:integer;
 abitmap:TBitmap;
 PreviewControl:TRpPreviewControl;
begin
 apage:=PControl.Page;
 PControl.LastPage;
 PControl.Page:=apage;
 PreviewControl:=PControl;
 case format of
     1:
     begin
      PreviewControl.Metafile.SaveToFile(filename)
     end;
     2,3:
      begin
       SaveMetafileToPDF(PreviewControl.Metafile,FileName,format=2);
      end;
     4,5:
      begin
       ExportMetafileToExcel(PreviewControl.Metafile,FileName,
        true,false,true,1,9999,format=5);
      end;
     7:
      begin
       abitmap:=MetafileToBitmap(PreviewControl.Metafile,true,mono,horzres,vertres);
       try
        if assigned(abitmap) then
         abitmap.SaveToFile(FileName);
       finally
        abitmap.free;
       end;
      end;
     8:
      begin
       ExportMetafileToHtml(PreviewControl.Metafile,Caption,FileName,
        true,true,1,9999);
      end;
     9:
      begin
       ExportMetafileToSVG(PreviewControl.Metafile,Caption,FileName,
        true,true,1,9999);
      end;
     10:
      begin
       ExportMetafileToCSV(PreviewControl.metafile,Filename,true,true,
        1,9999,',');
      end;
     11:
      begin
       ExportMetafileToTextPro(PreviewControl.metafile,Filename,true,true,
        1,9999);
      end;
     12:
     begin
      PreviewControl.Metafile.SaveToFile(Filename,false);
     end;
{$IFNDEF DOTNETD}
     13:
      begin
       MetafileToExe(PreviewControl.metafile,Filename);
      end;
{$ENDIF}
     else
     begin
      SaveMetafileToTextFile(PreviewControl.Metafile,FileName);
     end;
    end;
end;

procedure TPreviewControl.Set_Font(const Value: IFontDisp);
safecall;
begin
  SetOleFont(Font, Value);
end;

procedure TPreviewControl.Clear;
begin
 PControl.Report:=nil;
end;

initialization
  TActiveFormFactory.Create(
    ComServer,
    TActiveFormControl,
    TPreviewControl,
    Class_PreviewControl,
    1,
    '',
    OLEMISC_SIMPLEFRAME or OLEMISC_ACTSLIKELABEL,
    tmSingle);
end.
