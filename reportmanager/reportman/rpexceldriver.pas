{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       Rpexceldriver                                   }
{       Exports a metafile to a excel sheet             }
{       can be used only for windows                    }
{                                                       }
{       Copyright (c) 1994-2003 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rpexceldriver;

interface

{$I rpconf.inc}

uses
 mmsystem,windows,
 Classes,sysutils,rpmetafile,rpmdconsts,Graphics,Forms,
 rpmunits,Dialogs, Controls,Comobj,
 StdCtrls,ExtCtrls,rppdffile,rpgraphutilsvcl,
{$IFDEF VCLNOTATION}
 Vcl.Imaging.jpeg,
{$ENDIF}
{$IFNDEF VCLNOTATION}
 jpeg,
{$ENDIF}
{$IFDEF USEVARIANTS}
 types,Variants,
{$ENDIF}
 rptypes,rpvgraphutils;


const
 XLS_PRECISION=100;

const
  xlHAlignCenter = $FFFFEFF4;
  xlHAlignCenterAcrossSelection = $00000007;
  xlHAlignDistributed = $FFFFEFEB;
  xlHAlignFill = $00000005;
  xlHAlignGeneral = $00000001;
  xlHAlignJustify = $FFFFEFDE;
  xlHAlignLeft = $FFFFEFDD;
  xlHAlignRight = $FFFFEFC8;
  xlExclusive = $00000003;
  xlNoChange = $00000001;
  xlShared = $00000002;



type
  TFRpExcelProgress = class(TForm)
    BCancel: TButton;
    LProcessing: TLabel;
    LRecordCount: TLabel;
    LTitle: TLabel;
    LTittle: TLabel;
    BOK: TButton;
    GPrintRange: TGroupBox;
    EFrom: TEdit;
    ETo: TEdit;
    LTo: TLabel;
    LFrom: TLabel;
    RadioAll: TRadioButton;
    RadioRange: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
    procedure BOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    allpages:boolean;
    isvisible:boolean;
    frompage,topage:integer;
    onesheet:boolean;
    dook:boolean;
    procedure AppIdle(Sender:TObject;var done:boolean);
  public
    { Public declarations }
    cancelled:boolean;
    oldonidle:TIdleEvent;
    tittle:string;
    filename:string;
    metafile:TRpMetafileReport;
  end;



function ExportMetafileToExcel (metafile:TRpMetafileReport; filename:string;
 showprogress,visible,allpages:boolean; frompage,topage:integer;
 onesheet:Boolean=false):boolean;

implementation



{$R *.dfm}

const
 AlignmentFlags_SingleLine=64;
 AlignmentFlags_AlignHCenter = 4 { $4 };
 AlignmentFlags_AlignHJustify = 1024 { $400 };
 AlignmentFlags_AlignTop = 8 { $8 };
 AlignmentFlags_AlignBottom = 16 { $10 };
 AlignmentFlags_AlignVCenter = 32 { $20 };
 AlignmentFlags_AlignLeft = 1 { $1 };
 AlignmentFlags_AlignRight = 2 { $2 };


function IsValidNumberChar(achar:char):Boolean;
begin
 Result:=false;
{$IFNDEF DOTNETD}
 if (achar in ['-','+','e','E','0'..'9',' ',DecimalSeparator]) then
{$ENDIF}
{$IFDEF DOTNETD}
 if ((achar in ['-','+','e','E','0'..'9',' ']) or
  (achar=DecimalSeparator[1])) then
{$ENDIF}
  Result:=true;
end;

function VarTryStrToFloat(S: string; var Value: Double): Boolean;
var
 index,i:integer;
begin
 Result:=true;
 S:=Trim(S);
 // Remove thousand separators
 repeat
  index:=Pos(ThousandSeparator,S);
  if index>0 then
   S:=Copy(S,1,index-1)+Copy(S,index+1,Length(S));
 until index=0;
 for i:=1 to Length(S) do
 begin
  if Not IsValidNumberChar(S[i]) then
  begin
   result:=false;
   break;
  end;
 end;
 if not result then
  exit;
 try
  Value:=StrToFloat(S);
 except
  Result:=false;
 end;
end;

function VarTryStrToDate(S: string; var Value: TDateTime): Boolean;
begin
 Result:=true;
 try
  Value:=StrToDate(S);
 except
  Result:=false;
 end;
end;


{$IFNDEF DOTNETD}
procedure PrintObject(sh:Variant;page:TRpMetafilePage;obj:TRpMetaObject;dpix,dpiy:integer;toprinter:boolean;
 rows,columns:TStringList;FontName:String;FontSize,rowinit:integer);
var
 aansitext:string;
 arow,acolumn:integer;
 leftstring,topstring:String;
 number:Double;
 isanumber:boolean;
 afontStyle:TFontStyles;
 acolor:TColor;
 isadate:boolean;
 adate:TDateTime;
begin
 topstring:=FormatCurr('0000000000',obj.Top/XLS_PRECISION);
 leftstring:=FormatCurr('0000000000',obj.Left/XLS_PRECISION);
 arow:=rows.IndexOf(topstring)+1+rowinit;
 acolumn:=columns.IndexOf(leftstring)+1;
 if acolumn<1 then
  acolumn:=1;
 if arow<1 then
  arow:=1;
 case obj.Metatype of
  rpMetaText:
   begin
    aansitext:=page.GetText(Obj);
    // If it's a number
    isanumber:=VarTryStrToFloat(aansitext,number);
    if isanumber then
     sh.Cells.item[arow,acolumn].Value:=number
    else
    begin
     isadate:=VarTryStrToDate(aansitext,adate);
     if isadate then
     begin
      sh.Cells.item[arow,acolumn].Value:=FormatDateTime('mm"/"dd"/"yyyy',adate);
     end
     else
     begin
      if Length(aansitext)>0 then
      begin
        if aansitext[1]='=' then
        aansitext:=''''+aansitext;
      end;
      sh.Cells.item[arow,acolumn].Value:=aansitext;
     end;
    end;
    if FontName<>page.GetWFontName(Obj) then
     sh.Cells.item[arow,acolumn].Font.Name:=page.GetWFontName(Obj);
    if obj.FontSize<>FontSize then
     sh.Cells.item[arow,acolumn].Font.Size:=Obj.FontSize;
    acolor:=CLXColorToVCLColor(Obj.FontColor);
    if acolor<>clBlack then
     sh.Cells.item[arow,acolumn].Font.Color:=acolor;
    afontstyle:=CLXIntegerToFontStyle(obj.FontStyle);
    if fsItalic in afontstyle then
     sh.Cells.item[arow,acolumn].Font.Italic:=true;
    if fsBold in afontstyle then
     sh.Cells.item[arow,acolumn].Font.Bold:=true;
    if fsUnderline in afontstyle then
    sh.Cells.item[arow,acolumn].Font.Underline:=true;
    if fsStrikeout in afontstyle then
     sh.Cells.item[arow,acolumn].Font.Strikethrough:=true;
    // Font rotation not possible
    if (obj.AlignMent AND AlignmentFlags_AlignHCenter)>0 then
     sh.Cells.item[arow,acolumn].HorizontalAlignment:=xlHAlignCenter;
    // Multiline not supported
 //    if (obj.AlignMent AND AlignmentFlags_SingleLine)=0 then
//     sh.Cells.item[arow,acolumn].Multiline:=true;
    if (obj.AlignMent AND AlignmentFlags_AlignLEFT)>0 then
     if isanumber then
      sh.Cells.item[arow,acolumn].HorizontalAlignment:=xlHAlignLeft;
    if (obj.AlignMent AND AlignmentFlags_AlignRight)>0 then
     if not isanumber then
      sh.Cells.item[arow,acolumn].HorizontalAlignment:=xlHAlignRight;
    // Word wrap not supported
//    if obj.WordWrap then
//     sh.Cells.item[arow,acolumn].WordWrap:=True;
//    if Not obj.CutText then
//     aalign:=aalign or DT_NOCLIP;
//    if obj.RightToLeft then
//     aalign:=aalign or DT_RTLREADING;
    // In word 97, not supported
//    if Not obj.Transparent then
//     sh.Cells.Item[arow,acolumn].Color:=CLXColorToVCLColor(obj.BackColor);
   end;
  rpMetaDraw:
   begin
{    Width:=round(obj.Width*dpix/TWIPS_PER_INCHESS);
    Height:=round(obj.Height*dpiy/TWIPS_PER_INCHESS);
    abrushstyle:=obj.BrushStyle;
    if obj.BrushStyle>integer(bsDiagCross) then
     abrushstyle:=integer(bsDiagCross);
    Canvas.Pen.Color:=CLXColorToVCLColor(obj.Pencolor);
    Canvas.Pen.Style:=TPenStyle(obj.PenStyle);
    Canvas.Brush.Color:=CLXColorToVCLColor(obj.BrushColor);
    Canvas.Brush.Style:=TBrushStyle(abrushstyle);
    Canvas.Pen.Width:=Round(dpix*obj.PenWidth/TWIPS_PER_INCHESS);
    X := Canvas.Pen.Width div 2;
    Y := X;
    W := Width - Canvas.Pen.Width + 1;
    H := Height - Canvas.Pen.Width + 1;
    if Canvas.Pen.Width = 0 then
    begin
     Dec(W);
     Dec(H);
    end;
    if W < H then
     S := W
    else
     S := H;
    if TRpShapeType(obj.DrawStyle) in [rpsSquare, rpsRoundSquare, rpsCircle] then
    begin
     Inc(X, (W - S) div 2);
     Inc(Y, (H - S) div 2);
     W := S;
     H := S;
    end;
    case TRpShapeType(obj.DrawStyle) of
     rpsRectangle, rpsSquare:
      Canvas.Rectangle(X+PosX, Y+PosY, X+PosX + W, Y +PosY+ H);
     rpsRoundRect, rpsRoundSquare:
      Canvas.RoundRect(X+PosX, Y+PosY, X +PosX + W, Y + PosY+ H, S div 4, S div 4);
     rpsCircle, rpsEllipse:
      Canvas.Ellipse(X+PosX, Y+PosY, X+PosX + W, Y+PosY + H);
     rpsHorzLine:
      begin
       Canvas.MoveTo(X+PosX, Y+PosY);
       Canvas.LineTo(X+PosX+W, Y+PosY);
      end;
     rpsVertLine:
      begin
       Canvas.MoveTo(X+PosX, Y+PosY);
       Canvas.LineTo(X+PosX, Y+PosY+H);
      end;
     rpsOblique1:
      begin
       Canvas.MoveTo(X+PosX, Y+PosY);
       Canvas.LineTo(X+PosX+W, Y+PosY+H);
      end;
     rpsOblique2:
      begin
       Canvas.MoveTo(X+PosX, Y+PosY+H);
       Canvas.LineTo(X+PosX+W, Y+PosY);
      end;
    end;
}   end;
  rpMetaImage:
   begin
    // Inserting images to excel is not supported for now
{    Width:=round(obj.Width*dpix/TWIPS_PER_INCHESS);
    Height:=round(obj.Height*dpiy/TWIPS_PER_INCHESS);
    rec.Top:=PosY;
    rec.Left:=PosX;
    rec.Bottom:=rec.Top+Height-1;
    rec.Right:=rec.Left+Width-1;

    stream:=page.GetStream(obj);
    bitmap:=TBitmap.Create;
    try
     bitmap.PixelFormat:=pf32bit;
     bitmap.HandleType:=bmDIB;
     if GetJPegInfo(stream,bitmapwidth,bitmapheight) then
     begin
      jpegimage:=TJPegImage.Create;
      try
       jpegimage.LoadFromStream(stream);
       bitmap.Assign(jpegimage);
      finally
       jpegimage.free;
      end;
     end
     else
     // Looks if it's a jpeg image
      bitmap.LoadFromStream(stream);
//     Copy mode does not work for StretDIBBits
//     Canvas.CopyMode:=CLXCopyModeToCopyMode(obj.CopyMode);

     case TRpImageDrawStyle(obj.DrawImageStyle) of
      rpDrawFull:
       begin
        rec.Bottom:=rec.Top+round(bitmap.height/obj.dpires*dpiy)-1;
        rec.Right:=rec.Left+round(bitmap.width/obj.dpires*dpix)-1;
        recsrc.Left:=0;
        recsrc.Top:=0;
        recsrc.Right:=bitmap.Width-1;
        recsrc.Bottom:=bitmap.Height-1;
        DrawBitmap(Canvas,bitmap,rec,recsrc);
       end;
      rpDrawStretch:
       begin
        recsrc.Left:=0;
        recsrc.Top:=0;
        recsrc.Right:=bitmap.Width-1;
        recsrc.Bottom:=bitmap.Height-1;
        DrawBitmap(Canvas,bitmap,rec,recsrc);
       end;
      rpDrawCrop:
       begin
        recsrc.Left:=0;
        recsrc.Top:=0;
        recsrc.Right:=rec.Right-rec.Left;
        recsrc.Bottom:=rec.Bottom-rec.Top;
        DrawBitmap(Canvas,bitmap,rec,recsrc);
       end;
      rpDrawTile:
       begin
        // Set clip region
        oldrgn:=CreateRectRgn(0,0,2,2);
        aresult:=GetClipRgn(Canvas.Handle,oldrgn);
        newrgn:=CreateRectRgn(rec.Left,rec.Top,rec.Right,rec.Bottom);
        SelectClipRgn(Canvas.handle,newrgn);
        DrawBitmapMosaicSlow(Canvas,rec,bitmap);
        if aresult=0 then
         SelectClipRgn(Canvas.handle,0)
        else
         SelectClipRgn(Canvas.handle,oldrgn);
       end;
     end;
    finally
     bitmap.Free;
    end;}
   end;
 end;
end;
{$ENDIF}


procedure DoExportMetafile(metafile:TRpMetafileReport;filename:string;
 aform:TFRpExcelProgress;visible,allpages:boolean;frompage,topage:integer;
  onesheet:Boolean);
{$IFNDEF DOTNETD}
var
 i:integer;
 j:integer;
 apage:TRpMetafilePage;
 dpix,dpiy:integer;
 mmfirst,mmlast:DWORD;
 difmilis:int64;
 wb:Variant;
 sh:Variant;
 Excel:Variant;
 columns:TStringList;
 rows:TStringList;
 index:integer;
 topstring,leftstring:string;
 shcount:integer;
 FontName:String;
 FontSize:integer;
 rowinit:integer;
 version:string;
{$ENDIF}
begin
{$IFNDEF DOTNETD}
 dpix:=Screen.PixelsPerInch;
 dpiy:=dpix;
 // Get the time
 mmfirst:=TimeGetTime;
 if allpages then
 begin
  metafile.RequestPage(MAX_PAGECOUNT);
  frompage:=0;
  topage:=metafile.CurrentPageCount-1;
 end
 else
 begin
  frompage:=frompage-1;
  topage:=topage-1;
  metafile.RequestPage(topage);
  if topage>metafile.CurrentPageCount-1 then
   topage:=metafile.CurrentPageCount-1;
 end;
 // Distribute in rows and columns
 columns:=TStringList.Create;
 rows:=TStringList.Create;
 try
   rows.sorted:=true;
   columns.sorted:=true;
   // Creates the excel file
   Excel:=CreateOleObject('excel.application');
   Excel.Visible:=Visible;
   wb:=Excel.Workbooks.Add;
   shcount:=1;
   sh:=wb.Worksheets.item[shcount];
   FontName:=sh.Cells.Font.Name;
   FontSize:=sh.Cells.Font.Size;

   for i:=frompage to topage do
   begin
    apage:=metafile.Pages[i];
    for j:=0 to apage.ObjectCount-1 do
    begin
     if apage.Objects[j].Metatype in [rpMetaText,rpMetaImage] then
     begin
      leftstring:=FormatCurr('0000000000',apage.Objects[j].Left/XLS_PRECISION);
      index:=columns.IndexOf(leftstring);
      if index<0 then
       columns.Add(leftstring);
     end;
    end;
   end;
   rowinit:=0;
   for i:=frompage to topage do
   begin
    if not onesheet then
    begin
     rowinit:=0;
     if wb.Worksheets.Count<shcount then
      wb.Worksheets.Add(NULL,wb.Worksheets.Item[wb.Worksheets.Count],1,NULL);
     sh:=wb.Worksheets.item[shcount];
    end
    else
     rowinit:=rowinit+rows.count;
    inc(shcount);
    apage:=metafile.Pages[i];
    rows.clear;
    for j:=0 to apage.ObjectCount-1 do
    begin
     if apage.Objects[j].Metatype in [rpMetaText,rpMetaImage] then
     begin
      topstring:=FormatCurr('0000000000',apage.Objects[j].Top/XLS_PRECISION);
      index:=rows.IndexOf(topstring);
      if index<0 then
       rows.Add(topstring);
     end;
    end;

    for j:=0 to apage.ObjectCount-1 do
    begin
     PrintObject(sh,apage,apage.Objects[j],dpix,dpiy,true,
      rows,columns,FontName,FontSize,rowinit);
     if assigned(aform) then
     begin
      mmlast:=TimeGetTime;
      difmilis:=(mmlast-mmfirst);
      if difmilis>MILIS_PROGRESS then
      begin
       // Get the time
       mmfirst:=TimeGetTime;
       aform.LRecordCount.Caption:=SRpPage+':'+ IntToStr(i+1)+
         ' - '+SRpItem+':'+ IntToStr(j+1);
       Application.ProcessMessages;
       if aform.cancelled then
        Raise Exception.Create(SRpOperationAborted);
      end;
     end;
    end;
   end;
 finally
  columns.free;
  rows.free;
 end;
 if Length(Filename)>0 then
 begin
  if (UpperCase(ExtractFileExt(Filename))='.XLSX') then
   wb.SaveAs(Filename)
  else
  begin
   version:=Excel.Version;
   index:=Pos('.',version);
   if (index>=0) then
    version:=Copy(version,1,index-1);
   If StrToInt(version)<12 Then
    wb.SaveAs(Filename)
   else
    wb.SaveAs(Filename,56);
  end;
  wb.Close;
 end;
 if not visible then
  Excel.Quit;
 if assigned(aform) then
  aform.close;
{$ENDIF}
end;

function ExportMetafileToExcel (metafile:TRpMetafileReport; filename:string;
 showprogress,visible,allpages:boolean; frompage,topage:integer;
 onesheet:Boolean=false):boolean;
var
 dia:TFRpExcelProgress;
begin
 Result:=true;
 if Not ShowProgress then
 begin
  DoExportMetafile(metafile,filename,nil,visible,allpages,frompage,topage,onesheet);
  exit;
 end;
 dia:=TFRpExcelProgress.Create(Application);
 try
  dia.oldonidle:=Application.OnIdle;
  try
   dia.metafile:=metafile;
   dia.filename:=filename;
   dia.allpages:=allpages;
   dia.frompage:=frompage;
   dia.onesheet:=onesheet;
   dia.isvisible:=visible;
   dia.topage:=topage;
   Application.OnIdle:=dia.AppIdle;
   dia.ShowModal;
   Result:=Not dia.cancelled;
  finally
   Application.OnIdle:=dia.oldonidle;
  end;
 finally
  dia.free;
 end;
end;


procedure TFRpExcelProgress.FormCreate(Sender: TObject);
begin
 LRecordCount.Font.Style:=[fsBold];
 LTittle.Font.Style:=[fsBold];

 BOK.Caption:=TranslateStr(93,BOK.Caption);
 BCancel.Caption:=TranslateStr(94,BCancel.Caption);
 LTitle.Caption:=TranslateStr(252,LTitle.Caption);
 LProcessing.Caption:=TranslateStr(253,LProcessing.Caption);
 GPrintRange.Caption:=TranslateStr(254,GPrintRange.Caption);
 LFrom.Caption:=TranslateStr(255,LFrom.Caption);
 LTo.Caption:=TranslateStr(256,LTo.Caption);
 RadioAll.Caption:=TranslateStr(257,RadioAll.Caption);
 RadioRange.Caption:=TranslateStr(258,RadioRange.Caption);
 Caption:=TranslateStr(259,Caption);

end;

procedure TFRpExcelProgress.AppIdle(Sender:TObject;var done:boolean);
begin
 cancelled:=false;
 Application.OnIdle:=nil;
 done:=false;
 LTittle.Caption:=tittle;
 LProcessing.Visible:=true;
 DoExportMetafile(metafile,filename,self,isvisible,allpages,frompage,topage,onesheet);
end;


procedure TFRpExcelProgress.BCancelClick(Sender: TObject);
begin
 cancelled:=true;
end;




procedure TFRpExcelProgress.BOKClick(Sender: TObject);
begin
 FromPage:=StrToInt(EFrom.Text);
 ToPage:=StrToInt(ETo.Text);
 if FromPage<1 then
  FromPage:=1;
 if ToPage<FromPage then
  ToPage:=FromPage;
 Close;
 dook:=true;
end;

procedure TFRpExcelProgress.FormShow(Sender: TObject);
begin
 if BOK.Visible then
 begin
  EFrom.Text:=IntToStr(FromPage);
  ETo.Text:=IntToStr(ToPage);
 end;
end;


end.

