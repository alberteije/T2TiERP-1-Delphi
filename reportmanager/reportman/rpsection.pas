{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       Rpsection                                       }
{       TRpSection - Report manager Band                }
{       The class representation of a reporting section }
{       It can be a detail, a pageheader...             }
{       It has childs, that prints                      }
{                                                       }
{       Copyright (c) 1994-2002 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rpsection;

interface

{$I rpconf.inc}

uses Classes,
{$IFDEF USEZLIB}
{$IFDEF DELPHI2009UP}
 zlib,
{$ENDIF}
{$IFNDEF DELPHI2009UP}
 rpmzlib,
{$ENDIF}
{$ENDIF}
{$IFDEF MSWINDOWS}
 windows,
{$ENDIF}
{$IFDEF USEVARIANTS}
 Types,Variants,
{$ENDIF}
 rptypes,rpmdconsts,rpmunits,rpprintitem,rplabelitem,db,
 sysutils,rpmetafile,rptypeval,rpeval;

const
 C_DEFAULT_SECTION_WIDTH=19;
 C_DEFAULT_SECTION_HEIGHT=3;
 DEFAULT_DPI_BACK=100;

type
 TRpSectionType=(rpsecpheader,rpsecgheader,
  rpsecdetail,rpsecgfooter,rpsecpfooter);

 TRpSkipType=(secskipdefault,secskipbefore,secskipafter);


 TRpSection=class(TRpCommonComponent)
  private
   FStream,FDecompStream,FOldStream:TMemoryStream;
   FBackExpression:WideString;
   Fdpires:integer;
   FBackStyle:TrpBackStyle;
   FDrawStyle:TRpImageDrawStyle;
   FSubReport:TComponent;
   FChildSubReport:TComponent;
   FGroupName:String;           // [rpsecgheader,rpsecgfooter]
   FChangeExpression:WideString;// [rpsecgheader,rpsecgfooter]
   FChangeBool:boolean;         // [rpsecgheader,rpsecgfooter]
   FPageRepeat:boolean;         // [rpsecgheader,rpsecgfooter]
   FAlignBottom:boolean;        // [rpsecrheader,rpsecrfooter,rpsecgheader,rpsecgfooter,rpsecdetail]
   FSkipPage:boolean;           // [rpsecrheader,rpsecrfooter,rpsecgheader,rpsecgfooter,rpsecdetail]
   FSectionType:TRpSectionType;
   FReportComponents:TRpCommonList;
   FAutoExpand:Boolean;
   FAutoContract:Boolean;
   FHorzDesp:Boolean;
   FVertDesp:Boolean;
   FExternalFilename:string;
   FExternalConnection:String;
   FExternalTable:String;
   FExternalField:String;
   FExternalSearchField:String;
   FExternalSearchValue:String;
   FStreamFormat:TRpStreamFormat;
   FBeginPageExpression:widestring;
   FFooterAtReportEnd:boolean;
   FSkipRelativeV:Boolean;
   FSkipRelativeH:Boolean;
   FSkipExpreH:WideString;
   FSkipExpreV:WideString;
   FSkipToPageExpre:WideString;
   FIniNumPage:Boolean;
   // deprecated
   FBeginPage:boolean;
   FReadError:Boolean;
   FSkipType:TRpSkipType;
   // Global headers
   FGlobal:Boolean;
   FPageGroupCountList:TList;
   cachedpos:Int64;
   FCachedImage:TRpCachedImage;
   procedure SetReportComponents(Value:TRpCommonList);
   procedure SetGroupName(Value:string);
   procedure SetChangeExpression(Value:widestring);
   procedure OnReadError(Reader: TReader; const Message: string; var Handled: Boolean);
   procedure SetChildSubReport(Value:TComponent);
   procedure AssignSection(sec:TRpSection);
   procedure WriteChangeExpression(Writer:TWriter);
   procedure ReadChangeExpression(Reader:TReader);
   procedure WriteBeginPageExpression(Writer:TWriter);
   procedure ReadBeginPageExpression(Reader:TReader);
   procedure WriteSkipExpreV(Writer:TWriter);
   procedure WriteSkipExpreH(Writer:TWriter);
   procedure WriteSkipToPageExpre(Writer:TWriter);
   procedure ReadSkipExpreH(Reader:TReader);
   procedure ReadSkipExpreV(Reader:TReader);
   procedure ReadSkipToPageExpre(Reader:TReader);
   procedure LoadExternalFromDatabase;
   procedure SetIniNumPage(Value:Boolean);
   function GetIsExternal:Boolean;
   procedure WriteBackExpression(Writer:TWriter);
   procedure ReadBackExpression(Reader:TReader);
   procedure ReadStream(AStream:TStream);
   procedure WriteStream(AStream:TStream);
   procedure AddPageGroupCountItem(apageindex,aobjectindex:integer;
    adisplayformat:widestring);
  protected
   procedure DoPrint(adriver:TRpPrintDriver;aposx,aposy,newwidth,newheight:integer;metafile:TRpMetafileReport;
    MaxExtent:TPoint;var PartialPrint:Boolean);override;
   procedure DefineProperties(Filer:TFiler);override;
   procedure GetChildren(Proc: TGetChildProc; Root: TComponent);override;
   procedure Notification(AComponent: TComponent;
    Operation: TOperation);override;
   function GetOwnedComponent(index:Integer):TComponent;
   procedure SetPageRepeat(Value:Boolean);
   procedure Loaded;override;
  public
   GroupValue:Variant;
   FirstPage:Integer;
   ChildSubReportName:String;
   SubReportName:String;
   LoadedExternal:Boolean;
   constructor Create(AOwner:TComponent);override;
   destructor Destroy;override;
   function SectionCaption(addchild:boolean):WideString;
   function GetStream:TMemoryStream;
   procedure SubReportChanged(newstate:TRpReportChanged;newgroup:string='');override;
   procedure FreeComponents;
   procedure DeleteComponent(com:TRpCommonComponent);
   function GetExtension(adriver:TRpPrintDriver;MaxExtent:TPoint;forcepartial:boolean):TPoint;override;
   function EvaluateBeginPage:boolean;
   procedure LoadFromStream(stream:TStream);
   procedure SaveToStream(stream:TStream);
   procedure LoadExternal;
   procedure SaveExternal;
   procedure SaveExternalToDatabase;
   function GetExternalDataDescription:String;
   procedure GetChildSubReportPossibleValues(lvalues:TRpWideStrings);
   function AddComponent(componentclass:TRpCommonPosClass):TRpCommonPosComponent;
   procedure UpdatePageCounts;
   function GetChildSubReportName:string;
   procedure SetChildSubReportByName(avalue:String);
   procedure ClearPageCountList;
   procedure SetStream(Value:TMemoryStream);
   property ChangeExpression:widestring read FChangeExpression write SetChangeExpression;
   property BeginPageExpression:widestring read FBeginPageExpression
    write FBeginPageExpression;
   property SkipToPageExpre:WideString read FSkipToPageExpre
    write FSkipToPageExpre;
   property SkipExpreH:Widestring read FSkipExpreH write FSkipExpreH;
   property SkipExpreV:Widestring read FSkipExpreV write FSkipExpreV;
   property ReportComponents:TRpCommonList read FReportComponents;
   property OwnedComponents[index:integer]:TComponent read GetOwnedComponent;
   property IsExternal:Boolean read GetIsExternal;
   property BackExpression:WideString read FBackExpression write FBackExpression;
   property Stream:TMemoryStream read FStream write SetStream;
  published
   property SubReport:TComponent read FSubReport write FSubReport;
   property GroupName:String read FGroupName write SetGroupName;
   property ChangeBool:boolean read FChangeBool write FChangeBool;
   property PageRepeat:boolean read FPageRepeat write SetPageRepeat;
   property SkipPage:boolean read FSkipPage write FSkipPage;
   property AlignBottom:boolean read FAlignBottom write FAlignBottom;
   property SectionType:TRpSectionType read FSectionType write FSectionType;
   property Components:TRpCommonList read FReportComponents write SetReportComponents;
   property AutoExpand:Boolean read FAutoExpand write FAutoExpand
    default false;
   property AutoContract:Boolean read FAutoContract write FAutoContract
    default false;
   property HorzDesp:Boolean read FHorzDesp write FHorzDesp default false;
   property VertDesp:Boolean read FVertDesp write FVertDesp default false;
//   property IsExternal:Boolean read FIsExternal
//    write FIsExternal default false;
   // External filename is a alias.field or if not exists a filename
   // If it's length is 0 it's not external
   property ExternalFilename:string read FExternalFilename
    write FExternalFilename;
   property ExternalConnection:string read FExternalConnection
    write FExternalConnection;
   property ExternalTable:string read FExternalTable write FExternalTable;
   property ExternalField:string read FExternalField write FExternalField;
   property ExternalSearchField:string read FExternalSearchField
    write FExternalSearchField;
   property ExternalSearchValue:string read FExternalSearchValue
    write FExternalSearchValue;
   property StreamFormat:TRpStreamFormat read FStreamFormat
    write FStreamFormat;

   property ChildSubReport:TComponent read FChildSubReport write SetChildSubReport;
   // Deprecated properties for compatibility only
   property BeginPage:boolean read FBeginpage write FBeginPage default false;
   // For page footer force page footer print at end of the report
   // For group headers force print header even when the footer is to be print
   property FooterAtReportEnd:boolean read FFooterAtReportEnd write
    FFooterAtReportEnd default false;
   // Skip inside page before print
   property SkipRelativeH:boolean Read FSkipRelativeH write FSkipRelativeH default false;
   property SkipRelativeV:boolean Read FSkipRelativeV write FSkipRelativeV default false;
   property SkipType:TRpSkipType read FSkipType write FSkipType default secskipdefault;
   property IniNumPage:Boolean read FIniNumPage write SetIniNumPage default false;
   // Global page headers and footers
   property Global:Boolean read FGlobal write FGlobal default false;
   property dpires:integer read   Fdpires write Fdpires default DEfAULT_DPI_BACK;
   property BackStyle:TrpBackStyle read FBackStyle write FBackStyle default baDesign;
   property DrawStyle:TRpImageDrawStyle read FDrawStyle write FDrawStyle
    default rpDrawFull;
   property CachedImage:TRpCachedImage read FCachedImage write FCachedImage default rpCachedNone;
 end;


function RpSkipTypeToText(value:TRpSkipType):String;
function StringToRpSkipType(value:String):TRpSkipType;
procedure GetSkipTypePossibleValues(alist:TRpWideStrings);

implementation

uses rpsubreport,rpbasereport, Math,rpxmlstream;

type
  TGraphicHeader = record
    Count: Word;                { Fixed at 1 }
    HType: Word;                { Fixed at $0100 }
    Size: Longint;              { Size not including header }
  end;


constructor TRpSection.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

 FPageGroupCountList:=TList.Create;
 FSkipType:=secskipdefault;
 FReportComponents:=TRpCommonList.Create(Self);
 FExternalTable:='REPMAN_REPORTS';
 FExternalField:='REPORT';
 FExternalSearchField:='REPORT_NAME';
 FFooterAtReportEnd:=false;
 FStream:=TMemoryStream.Create;
 FDecompStream:=TMemoryStream.Create;
 FOldStream:=TMemoryStream.Create;
 Fdpires:=DEFAULT_DPI_BACK;
 FDrawStyle:=rpDrawFull;
 FStreamFormat:=rpStreamtext;

 Width:=Round(C_DEFAULT_SECTION_WIDTH*TWIPS_PER_INCHESS/CMS_PER_INCHESS);
 Height:=Round(C_DEFAULT_SECTION_HEIGHT*TWIPS_PER_INCHESS/CMS_PER_INCHESS);
end;

procedure TRpSection.SetReportComponents(Value:TRpCommonList);
begin
 FReportComponents.Assign(Value);
end;

destructor TRpSection.Destroy;
begin
 ClearPageCountList;
 FPageGroupCountList.free;
 //FReportComponents.Free;
 FStream.free;
 FDecompStream.free;
 FOldStream.free;

 inherited destroy;
end;

procedure TRpSection.Notification(AComponent: TComponent;
 Operation: TOperation);
begin
 inherited Notification(AComponent,Operation);

 if Operation=opRemove then
 begin
  if (AComponent is TRpSubReport) then
  begin
   if AComponent=FChildSubReport then
    FChildSubReport:=nil;
  end;
 end;
end;

function TRpSection.SectionCaption(addchild:boolean):WideString;
var
 index:integer;
 acount:integer;
 subrep:TRpSubReport;
begin
 case FSectionType of
  rpsecdetail:
   begin
    subrep:=TRpSubReport(Subreport);
    if subrep.DetailCount>1 then
    begin
     index:=subrep.FirstDetail;
     acount:=1;
     while self<>subrep.Sections.Items[index].Section do
     begin
      inc(index);
      inc(acount);
      if index>subrep.Sections.Count then
       break;
     end;
     Result:=SRpDetail+'_'+IntToStr(acount);
    end
    else
     Result:=SRpDetail;
   end;
  rpsecpheader:
   begin
    Result:=SRpPageHeader;
   end;
  rpsecpfooter:
   begin
    Result:=SRpPageFooter;
   end;
  rpsecgheader:
   begin
    Result:=SRpHeader+' - '+FGroupName;
   end;
  rpsecgfooter:
   begin
    Result:=SRpFooter+' - '+FGroupName;
   end;
 end;
 if addchild then
 begin
  if Assigned(ChildSubreport) then
  begin
   Result:=Result+'('+TRpSubReport(ChildSubReport).GetDisplayName(false)+')';
  end;
 end;
end;

procedure TRpSection.FreeComponents;
var
 i:integer;
begin
 for i:=0 to FReportComponents.Count-1 do
 begin
  FReportComponents.Items[i].Component.free;
 end;
 FReportComponents.Clear;
end;

procedure TRpSection.DeleteComponent(com:TRpCommonComponent);
var
 i:integer;
begin
 i:=0;
 while i<FReportComponents.Count do
 begin
  if FReportComponents.Items[i].Component=Com then
  begin
   com.Free;
   FReportComponents.Items[i].Free;
//   Components.Delete(i);
   break;
  end;
  inc(i);
 end;
end;

procedure TRpSection.SetChangeExpression(Value:widestring);
var
 subrep:TRpSubreport;
 i:integer;
begin
 if (csLoading in ComponentState) then
 begin
  FChangeExpression:=Value;
  exit;
 end;
 if FChangeExpression=Value then
  exit;
 if not assigned(FSubreport) then
 begin
  FChangeExpression:=Value;
  exit;
 end;
 subrep:=TRpSubreport(FSubReport);
 // Assign header and footer
 for i:=0 to subrep.Sections.Count-1 do
 begin
  if (subrep.Sections.Items[i].Section.SectionType in [rpsecgheader,rpsecgfooter]) then
   if subrep.Sections.Items[i].Section.GroupName=FGroupName then
    subrep.Sections.Items[i].Section.FChangeExpression:=Value;
 end;
end;


procedure TRpSection.SetIniNumPage(Value:Boolean);
var
 subrep:TRpSubreport;
 i:integer;
 AGroupName:String;
begin
 if (csLoading in ComponentState) then
 begin
  FIniNumPage:=Value;
  exit;
 end;
 if not assigned(FSubreport) then
 begin
  FIniNumPage:=Value;
  exit;
 end;
 subrep:=TRpSubreport(FSubReport);
 // Assign header and footer
 AGroupName:=FGroupName;
 for i:=0 to subrep.Sections.Count-1 do
 begin
  if (subrep.Sections.Items[i].Section.SectionType in [rpsecgheader,rpsecgfooter]) then
   if subrep.Sections.Items[i].Section.FGroupName=AGroupName then
    subrep.Sections.Items[i].Section.FIniNumPage:=Value;
 end;
end;


procedure TRpSection.SetGroupName(Value:string);
var
 subrep:TRpSubreport;
 i:integer;
 aexpre:TRpExpression;
 AGroupName:string;
begin
 if (csLoading in ComponentState) then
 begin
  FGroupName:=Value;
  exit;
 end;
 Value:=UpperCase(Value);
 if FGroupName=Value then
  exit;
 if not assigned(FSubreport) then
 begin
  FGroupName:=Value;
  exit;
 end;
 subrep:=TRpSubreport(FSubReport);
 subrep.CheckGroupExists(Value);
 if Length(FGroupName)>0 then
 begin
  for i:=0 to Owner.ComponentCount-1 do
  begin
   if (Owner.Components[i] is TRpExpression) then
   begin
    aexpre:=TRpExpression(Owner.Components[i]);
    if aexpre.GroupName=FGroupName then
     aexpre.GroupName:=Value;
   end;
  end;
 end;
 // Assign header and footer
 AGroupName:=FGroupName;
 for i:=0 to subrep.Sections.Count-1 do
 begin
  if (subrep.Sections.Items[i].Section.SectionType in [rpsecgheader,rpsecgfooter]) then
   if subrep.Sections.Items[i].Section.FGroupName=AGroupName then
    subrep.Sections.Items[i].Section.FGroupName:=Value;
 end;
end;

procedure TRpSection.DoPrint(adriver:TRpPrintDriver;aposx,aposy,newwidth,newheight:integer;metafile:TRpMetafileReport;
    MaxExtent:TPoint;var PartialPrint:Boolean);
var
 i:integer;
 compo:TRpCommonPosComponent;
 newposx,newposy:integer;
 intPartialPrint:Boolean;
 dummypartial:Boolean;
 DoPartialPrint:BOolean;
 astream:TMemoryStream;
 compoprinted:boolean;
begin
 inherited DoPrint(adriver,aposx,aposy,newwidth,newheight,metafile,MaxExtent,PartialPrint);

 // Draw the background if needed
 if BackStyle<>baDesign then
 begin
  astream:=GetStream;
  if astream.Size>0 then
  begin
   if CachedImage<>rpCachedNone then
   begin
    metafile.Pages[metafile.CurrentPage].NewImageObjectShared(aposy,aposx,
     PrintWidth,PrintHeight,10,Integer(FDrawStyle),Integer(dpires),cachedpos,aStream,BackStyle=baPreview);
   end
   else
    metafile.Pages[metafile.CurrentPage].NewImageObject(aposy,aposx,
     PrintWidth,PrintHeight,10,Integer(FDrawStyle),Integer(dpires),aStream,BackStyle=baPreview);
  end;
 end;
 DoPartialPrint:=False;
 // Look for a partial print
 for i:=0 to FReportComponents.Count-1 do
 begin
  compo:=TRpCommonPosComponent(FReportComponents.Items[i].Component);
  if (compo is TRpExpression) then
   if TRpExpression(compo).IsPartial then
   begin
    DoPartialPrint:=true;
    break;
   end;
 end;
 PartialPrint:=false;
 for i:=0 to FReportComponents.Count-1 do
 begin
  compo:=TRpCommonPosComponent(FReportComponents.Items[i].Component);
  newwidth:=-1;
  newheight:=-1;
  // Component alignment
  case compo.align of
   rpalnone:
    begin
     newposx:=aposx+compo.PosX;
     newposy:=aposy+compo.PosY;
    end;
   rpalbottom:
    begin
     newposx:=aposx+compo.PosX;
     newposy:=aposy+lastextent.Y-compo.lastextent.Y;
    end;
   rpalright:
    begin
     newposx:=aposx+lastextent.X-compo.lastextent.X;
     newposy:=aposy+compo.PosY;
    end;
   rpalbotright:
    begin
     newposx:=aposx+compo.PosX;
     newposy:=aposy+lastextent.Y-compo.lastextent.Y;
    end;
   rpalleftright:
    begin
     newposx:=aposx;
     newposy:=aposy+compo.PosY;
     newwidth:=lastextent.X;
    end;
   rpaltopbottom:
    begin
     newposx:=aposx+compo.PosX;
     newposy:=aposy+compo.PosY;
     newheight:=lastextent.Y;
    end;
   rpalclient:
    begin
     newposx:=aposx;
     newposy:=aposy;
     newwidth:=lastextent.X;
     newheight:=lastextent.Y;
    end;
   else
    begin
     newposx:=aposx+compo.PosX;
     newposy:=aposy+compo.PosY;
    end;
  end;

  if DoPartialPrint then
  begin
   compoprinted:=false;
   if (compo is TRpExpression) then
    if TRpExpression(Compo).IsPartial then
    begin
     IntPartialPrint:=false;
     compo.Print(adriver,newposx,newposy,
      newwidth,newheight,metafile,MaxExtent,IntPartialPrint);
     if IntPartialPrint then
      PartialPrint:=True;
     compoprinted:=true;
    end;
   if ((not compoprinted) and compo.PartialFlag and (not PartialPrint)) then
   begin
    compo.PartialFlag:=false;
    compo.Print(adriver,newposx,newposy,
      newwidth,newheight,metafile,MaxExtent,IntPartialPrint);
   end;
   // For all other elements if alignment is allclient print again
   if ((not (compo is TRpExpression)) AND ((compo.Align=rpaltopbottom)
    or (compo.Align=rpalclient))) then
   begin
    dummypartial:=false;
    compo.Print(adriver,newposx,newposy,
      newwidth,newheight,metafile,MaxExtent,dummypartial);
   end;
  end
  else
  begin
   compo.PartialFlag:=false;
   // Evaluates print condition of each comonent
   if compo.EvaluatePrintCondition then
   begin
    IntPartialPrint:=false;
    if (PartialPrint and (compo.Align in [rpalbottom,rpalbotright])) then
     compo.PartialFlag:=true
    else
    begin
     compo.Print(adriver,newposx,newposy,
      newwidth,newheight,metafile,
      MaxExtent,IntPartialPrint);
    end;
    if IntPartialPrint then
     PartialPrint:=True;
    if compo is TRpExpression then
     if TRpExpression(compo).IsGroupPageCount then
      if TRpExpression(compo).LastMetaIndex>0 then
       AddPageGroupCountItem(metafile.currentpage,TRpExpression(compo).LastMetaIndex,TRpExpression(compo).displayformat);
   end;
  end;
 end;
end;

function TRpSection.EvaluateBeginPage:boolean;
var
 report:TRpBaseReport;
 eval:TRpEvaluator;
begin
 Result:=false;
 try
  if Length(FBeginPageExpression)<1 then
   exit;
  report:=TRpBaseReport(Owner);
  eval:=report.Evaluator;
  eval.Expression:=FBeginPageExpression;
  eval.Evaluate;
  Result:=eval.EvalResult;
 except
  on E:Exception do
  begin
   Raise TRpReportException.Create(E.Message+':'+SRPSBeginPage,self,SRPSBeginPage);
  end;
 end;
end;


function TRpSection.GetExtension(adriver:TRpPrintDriver;MaxExtent:TPoint;
 forcepartial:boolean):TPoint;
var
 minsize,maxsize,currentsize:integer;
 compsize:TPoint;
 newsize:integer;
 i:integer;
 newextent:TPoint;
 acompo:TRpCommonPosComponent;
 DoPartialPrint:Boolean;
begin
 Result:=inherited GetExtension(adriver,MaxExtent,forcepartial);
 DoPartialPrint:=False;
 // Look for a partial print
 for i:=0 to FReportComponents.Count-1 do
 begin
  acompo:=TRpCommonPosComponent(FReportComponents.Items[i].Component);
  if (acompo is TRpExpression) then
   if TRpExpression(acompo).IsPartial then
   begin
    DoPartialPrint:=true;
    break;
   end;
 end;

 if FAutoContract then
 begin
  minsize:=0;
  currentsize:=0;
 end
 else
 begin
  minsize:=Result.Y;
  currentsize:=Result.Y;
 end;
 if FAutoExpand then
  maxsize:=MaxInt
 else
  maxsize:=Result.X;
 if ((Not FAutoExpand) and (Not FAutoContract)) then
 begin
  Result.Y:=currentsize;
  lastextent:=Result;
  for i:=0 to FReportComponents.Count-1 do
  begin
   acompo:=TRpCommonPosComponent(FReportComponents.Items[i].Component);
   if not (acompo.Align=rpalnone) then
    acompo.GetExtension(adriver,newExtent,forcepartial);
  end;
  exit;
 end;
 for i:=0 to FReportComponents.Count-1 do
 begin
  acompo:=TRpCommonPosComponent(FReportComponents.Items[i].Component);
  if acompo.EvaluatePrintCondition then
  if DoPartialPrint then
  begin
   if (acompo is TRpExpression) then
    if TRpExpression(acompo).IsPartial then
    begin
     newextent:=MaxExtent;
     newextent.Y:=newextent.Y-acompo.PosY;
     compsize:=acompo.GetExtension(adriver,newExtent,forcepartial);
     if compsize.Y>0 then
     begin
      if acompo.Align in [rpalbottom,rpalbotright] then
       newsize:=compsize.Y
      else
       newsize:=acompo.PosY+compsize.Y;
      if newsize<maxsize then
      begin
       if newsize>currentsize then
        currentsize:=newsize;
      end;
     end;
    end;
  end
  else
  begin
   newextent:=MaxExtent;
   newextent.Y:=newextent.Y-acompo.PosY;
   compsize:=acompo.GetExtension(adriver,newExtent,forcepartial);
   if compsize.Y>0 then
   begin
    if acompo.Align in [rpalbottom,rpalbotright] then
     newsize:=compsize.Y
    else
     newsize:=acompo.PosY+compsize.Y;
    if newsize<maxsize then
    begin
     if newsize>currentsize then
      currentsize:=newsize;
    end;
   end;
  end;
 end;
 if currentsize<minsize then
  currentsize:=minsize;
 Result.Y:=currentsize;
 lastextent:=Result;
end;


procedure TRpSection.SaveToStream(stream:TStream);
var
 i:integer;
 acompo:TComponent;
{$IFDEF USEZLIB}
 zstream:TCompressionStream;
{$ENDIF}
 writer:TWriter;
 theformat:TRpStreamFormat;
 memstream:TMemoryStream;
begin
 // Looks if it's not external
 for i:=0 to FReportComponents.Count-1 do
 begin
  acompo:=FReportComponents.Items[i].Component;
  if assigned(acompo) then
  begin
   if (acompo.Owner=Owner) then
   begin
    Owner.RemoveComponent(acompo);
    Self.InsertComponent(acompo);
   end;
  end;
 end;


 theformat:=FStreamFormat;
{$IFNDEF USEZLIB}
 if theformat=rpStreamZLib then
  theformat:=rpStreambinary;
{$ENDIF}
{$IFDEF USEZLIB}
 if theformat=rpStreamZLib then
 begin
  zstream:=TCompressionStream.Create(clDefault,Stream);
  try
   writer:=TWriter.Create(zStream,4096);
   try
    writer.WriteRootComponent(Self);
   finally
    writer.free;
   end;
  finally
   zstream.free;
  end;
 end
 else
 if theformat=rpStreamXMLZLib then
 begin
  zstream:=TCompressionStream.Create(clDefault,Stream);
  try
   WriteSectionXML(Self,zStream);
  finally
   zstream.free;
  end;
 end
 else
{$ENDIF}
 if theformat=rpStreamBinary then
 begin
  writer:=TWriter.Create(Stream,4096);
  try
   writer.WriteRootComponent(Self);
  finally
   writer.free;
  end;
 end
 else
 if theformat=rpStreamXML then
 begin
  WriteSectionXML(Self,Stream);
 end
 else
 begin
  memstream:=TMemoryStream.Create;
  try
   writer:=TWriter.Create(memStream,4096);
   try
    writer.WriteRootComponent(Self);
   finally
    writer.free;
   end;
   memstream.Seek(0,soFromBeginning);
   ObjectBinaryToText(memstream,Stream);
  finally
   memstream.free;
  end;
 end;
end;


procedure TRpSection.SaveExternal;
var
 AStream:TStream;
 ffilename:string;
 report:TRpBaseReport;
begin
 // Saves the components as a external section
 if Length(FExternalFilename)>0 then
 begin
  report:=TRpBaseReport(Owner);
  if FExternalFilename[1]='@' then
  begin
   try
    report.evaluator.Expression:=Copy(FExternalFilename,2,Length(FExternalFileName));
    report.evaluator.evaluate;
    ffilename:=report.evaluator.EvalResultString;
   except
    on E:exception do
    begin
      Raise TRpReportException.Create(E.Message+':'+SRpSExternalpath+': '+FExternalFileName+' :'+Name,self,SRpSExternalPath);
    end;
   end;
  end
  else
   ffilename:=FExternalFilename;
  AStream:=TFileStream.Create(ffilename,fmCreate);
  try
   SaveToStream(AStream);
  finally
   AStream.free;
  end;
 end
 else
 begin
  if Length(GetExternalDataDescription)>0 then
  begin
   SaveExternalToDatabase;
  end;
 end;
end;

procedure TRpSection.SaveExternalToDatabase;
var
 report:TRpBaseReport;
 astream:TStream;
 index:integer;
 sqlsentence:string;
 alist:TStringList;
 aparam:TRpParamObject;
 aparam2:TRpParamObject;
begin
 report:=TRpBaseReport(Owner);
 index:=report.DatabaseInfo.IndexOf(ExternalCOnnection);
 if index<0 then
  Exit;
 sqlsentence:='UPDATE '+ExternalTable+' SET '+
  ExternalField+'=:'+ExternalField+
  ' WHERE '+ExternalSearchField+'=:'+ExternalSearchField;
 alist:=TStringList.Create;
 try
  aparam:=TRpParamObject.Create;
  aparam2:=TRpParamObject.Create;
  try
   aparam.Value:=ExternalSearchValue;
   alist.AddObject(ExternalField,aparam2);
   alist.AddObject(ExternalSearchField,aparam);
   astream:=TMemoryStream.Create;
   try
    aparam2.Stream:=astream;
    SaveToStream(AStream);
    astream.Seek(0,soFromBeginning);
    report.DatabaseInfo.Items[index].OpenDatasetFromSQL(sqlsentence,alist,true,report.params);
   finally
    astream.free;
   end;
  finally
   aparam.free;
   aparam2.free;
  end;
 finally
  alist.free;
 end;
end;


procedure TRpSection.LoadFromStream(stream:TStream);
var
 i:integer;
 abyte:Byte;
 reader:TReader;
{$IFDEF USEZLIB}
 buf:pointer;
 zlibs:TDeCompressionStream;
 readed:integer;
{$ENDIF}
 memstream,amemstream:TMemoryStream;
 tempsec:TRpSection;
 theformat:TRpStreamFormat;
begin
 // Free all components
 for i:=0 to FReportComponents.Count-1 do
 begin
  if Assigned(FReportComponents.Items[i].Component) then
   FReportComponents.Items[i].Component.Free;
 end;
 FReportComponents.Clear;
 FReadError:=false;
 aMemStream:=TMemoryStream.Create;
 try
  aMemStream.LoadFromStream(stream);
  amemstream.Seek(0,soFromBeginning);
  if amemstream.Size<1 then
   Raise Exception.Create(SRpStreamFormat);
  amemstream.Read(abyte,1);
  amemstream.Seek(0,soFromBeginning);
  if Char(abyte)='x' then
   theformat:=rpStreamzlib
  else
   if Char(abyte)='o' then
    theformat:=rpStreamText
   else
    if Char(abyte)='<' then
     theformat:=rpStreamXML
    else
     theformat:=rpStreambinary;
{$IFNDEF USEZLIB}
  if theformat=rpStreamzlib then
   Raise Exception.Create(SRpZLibNotSupported);
{$ENDIF}
{$IFDEF USEZLIB}
  if theformat=rpStreamzlib then
  begin
   MemStream:=TMemoryStream.Create;
   try
    zlibs:=TDeCompressionStream.Create(amemstream);
    try
     buf:=AllocMem(120000);
     try
      repeat
       readed:=zlibs.Read(buf^,120000);
       memstream.Write(buf^,readed);
      until readed<120000;
     finally
      freemem(buf);
     end;
     memstream.Seek(0,soFrombeginning);

     // Check if is xml
     if PChar(memstream.memory)^='<' then
     begin
      tempsec:=TRpSection.Create(nil);
      try
       ReadSectionXML(tempsec,memstream);
       AssignSection(tempsec);
      finally
       tempsec.free;
      end;
     end
     else
     begin
      reader:=TReader.Create(memstream,1000);
      try
       reader.OnError:=OnReadError;
       tempsec:=TRpSection.Create(nil);
       try
        reader.ReadRootComponent(tempsec);
        AssignSection(tempsec);
       finally
        tempsec.free;
       end;
      finally
       reader.free;
      end;
     end;
    finally
     zlibs.Free;
    end;
   finally
    MemStream.free;
   end;
  end
  else
{$ENDIF}
  begin
   if theformat=rpStreamXML then
   begin
    tempsec:=TRpSection.Create(nil);
    try
     ReadSectionXML(tempsec,amemstream);
     AssignSection(tempsec);
    finally
     tempsec.free;
    end;
   end
   else
   begin
    if theformat=rpStreamtext then
    begin
     // Converts to binary
     memstream:=TMemoryStream.Create;
     try
      memstream.LoadFromStream(amemstream);
      amemstream.clear;
      ObjectTextToBinary(memstream,amemstream);
      amemstream.Seek(0,soFromBeginning);
     finally
      memstream.free;
     end;
    end;
    MemStream:=TMemoryStream.Create;
    try
     MemStream.LoadFromStream(amemstream);
     memstream.Seek(0,soFrombeginning);
     reader:=TReader.Create(memstream,1000);
     try
      reader.OnError:=OnReadError;
      tempsec:=TRpSection.Create(nil);
      try
       reader.ReadRootComponent(tempsec);
       AssignSection(tempsec);
      finally
       tempsec.free;
      end;
     finally
      reader.free;
     end;
    finally
     MemStream.Free;
    end;
   end;
  end
 finally
  aMemStream.free;
 end;

 if FReadError then
 begin
  for i:=0 to ComponentCount-1 do
  begin
   Components[i].Free;
  end;
  Height:=0;
  exit;
 end;
 LoadedExternal:=true;
end;


procedure TRpSection.LoadExternal;
var
 AStream:TStream;
 report:TRpBaseReport;
 ffilename:String;
begin
 report:=TRpBaseReport(Owner);
 try
  // Try to load the section as an external section
  if Length(FExternalFilename)>0 then
  begin
   if FExternalFilename[1]='@' then
   begin
    try
     report.evaluator.Expression:=Copy(FExternalFilename,2,Length(FExternalFileName));
     report.evaluator.evaluate;
     ffilename:=report.evaluator.EvalResultString;
    except
     on E:exception do
     begin
       Raise TRpReportException.Create(E.Message+':'+SRpSExternalpath+': '+FExternalFileName+' :'+Name,self,SRpSExternalPath);
     end;
    end
   end
   else
    ffilename:=FExternalFileName;
   AStream:=TFileStream.Create(ffilename,fmOpenRead or fmShareDenyWrite);
   try
    LoadFromStream(AStream);
   finally
    AStream.free;
   end;
  end
  else
  begin
   if Length(GetExternalDataDescription)>0 then
   begin
    LoadExternalFromDatabase;
   end;
  end;
 except
  On E:Exception do
  begin
   if report.FailIfLoadExternalError then
    Raise;
  end;
 end;
end;

procedure TRpSection.LoadExternalFromDatabase;
var
 report:TRpBaseReport;
 astream:TStream;
 index:integer;
 sqlsentence:string;
 errordata:boolean;
 alist:TStringList;
 aparam:TRpParamObject;
begin
 report:=TRpBaseReport(Owner);
 index:=report.DatabaseInfo.IndexOf(ExternalCOnnection);
 if index<0 then
  Exit;
 astream:=nil;
 sqlsentence:='SELECT '+ExternalField+' FROM '+ExternalTable+
  ' WHERE '+ExternalSearchField+'=:'+ExternalSearchField;
 alist:=TStringList.Create;
 try
  aparam:=TRpParamObject.Create;
  try
   aparam.Value:=ExternalSearchValue;
   alist.AddObject(ExternalSearchField,aparam);
   errordata:=false;
   try
    astream:=report.DatabaseInfo.Items[index].GetStreamFromSQL(sqlsentence,alist,report.Params);
   except
    errordata:=True;
   end;
   if not errordata then
   begin
    try
     LoadFromStream(astream);
    finally
     astream.Free;
    end;
   end;
  finally
   aparam.free;
  end;
 finally
  alist.free;
 end;
end;


procedure TRpSection.OnReadError(Reader: TReader;
 const Message: string; var Handled: Boolean);
begin
 // Omit Messages
 FReadError:=true;
end;

// GetChildren helps streaming the subreports
procedure TRpSection.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
  OwnedComponent: TComponent;
//  rpsubreport:TRpSubReport;
begin
 inherited GetChildren(Proc, Root);
 if Root = Self then
  for I := 0 to ComponentCount - 1 do
  begin
   OwnedComponent := OwnedComponents[I];
   if not OwnedComponent.HasParent then
    Proc(OwnedComponent);
//   if OwnedComponent is TRpSubReport then
//   begin
//    if subreport.
//      Proc(OwnedComponent);
//   end;
  end;
end;

procedure TRpSection.GetChildSubReportPossibleValues(lvalues:TRpWideStrings);
var
 rep:TRpBaseReport;
 i:integer;
begin
 rep:=TRpBaseReport(Subreport.Owner);
 lvalues.clear;
 lvalues.Add(' ');
 for i:=0 to rep.Subreports.count-1 do
 begin
  lvalues.Add(rep.Subreports.items[i].SubReport.GetDisplayName(false));
 end;
end;

function TRpSection.GetChildSubReportName:string;
begin
 Result:=' ';
 if Assigned(ChildSubReport) then
  Result:=TRpSubReport(ChildSubReport).GetDisplayName(false);
end;

procedure TRpSection.SetChildSubReportByName(avalue:String);
var
 rep:TRpBaseReport;
 i:integer;
begin
 rep:=TRpBaseReport(Subreport.Owner);
 ChildSubReport:=nil;
 for i:=0 to rep.Subreports.count-1 do
 begin
  if rep.Subreports.items[i].SubReport.ParentSection=Self then
  begin
   rep.Subreports.items[i].SubReport.ParentSection:=nil;
   rep.Subreports.items[i].SubReport.ParentSubReport:=nil;
  end;
  if rep.Subreports.items[i].SubReport.GetDisplayName(false)=avalue then
  begin
   rep.Subreports.items[i].SubReport.ParentSection:=Self;
   rep.Subreports.items[i].SubReport.ParentSubReport:=TRpSubReport(SubReport);
   ChildSubReport:=rep.Subreports.items[i].SubReport;
  end;
 end;
end;

procedure TRpSection.SetChildSubReport(Value:TComponent);
var
 i:integer;
 rep:TRpSubReport;
begin
 if (csReading in ComponentState) then
 begin
  FChildSubReport:=Value;
  exit;
 end;
 if (csLoading in ComponentState) then
 begin
  FChildSubReport:=Value;
  exit;
 end;
 if Not Assigned(Value) then
 begin
  FChildSubReport:=Value;
  exit;
 end;
 if Value=SubReport then
  Raise Exception.Create(SRpCircularDatalink);
 rep:=TRpSubReport(Value);
 for i:=0 to rep.Sections.Count-1 do
 begin
  if rep.Sections.Items[i].Section.ChildSubReport=SubReport then
    rep.Sections.Items[i].Section.ChildSubReport:=nil;
//   Raise Exception.Create(SRpCircularDatalink);
 end;
 FChildSubReport:=Value;
end;

procedure TRpSection.AssignSection(sec:TRpSection);
var
 i:integer;
begin
 Width:=sec.Width;
 Height:=sec.Height;
 FSkipPage:=sec.SkipPage;
 FAutoExpand:=sec.FAutoExpand;
 FAutoContract:=sec.FAutoContract;
 FBeginPageExpression:=sec.FBeginPageExpression;
 FSkipRelativeH:=sec.FSkipRelativeH;
 FSkipRelativeV:=sec.FSkipRelativeV;
 FSkipExpreH:=sec.FSkipExpreH;
 FSkipExpreV:=sec.FSkipExpreV;
 FBeginPage:=sec.FBeginPage;
 PrintCondition:=sec.PrintCondition;
 DoBeforePrint:=sec.DoBeforePrint;
 DoAfterPrint:=sec.DoAfterPrint;
 FVertDesp:=sec.FVertDesp;
 FGlobal:=sec.FGlobal;
 FFooterAtReportEnd:=sec.FFooterAtReportEnd;
 FIniNumPage:=sec.FIniNumPage;
 for i:=0 to FReportComponents.Count-1 do
 begin
  if FReportComponents.Items[i].Component.Owner=Self then
   FReportComponents.Items[i].Component.Free;
 end;
 FReportComponents.Clear;
 for i:=0 to sec.FReportComponents.Count-1 do
 begin
  (FReportComponents.Add).Component:=sec.FReportComponents.Items[i].Component;
  sec.RemoveComponent(sec.FReportComponents.Items[i].Component);
  InsertComponent(sec.FReportComponents.Items[i].Component);
 end;
end;


procedure TRpSection.WriteChangeExpression(Writer:TWriter);
begin
 WriteWideString(Writer, FChangeExpression);
end;

procedure TRpSection.ReadChangeExpression(Reader:TReader);
begin
 FChangeExpression:=ReadWideString(Reader);
end;

procedure TRpSection.WriteBeginPageExpression(Writer:TWriter);
begin
 WriteWideString(Writer, FBeginPageExpression);
end;

procedure TRpSection.ReadBeginPageExpression(Reader:TReader);
begin
 FBeginPageExpression:=ReadWideString(Reader);
end;

procedure TRpSection.WriteSkipExpreV(Writer:TWriter);
begin
 WriteWideString(Writer, FSkipExpreV);
end;

procedure TRpSection.ReadSkipExpreH(Reader:TReader);
begin
 FSkipExpreH:=ReadWideString(Reader);
end;

procedure TRpSection.WriteSkipExpreH(Writer:TWriter);
begin
 WriteWideString(Writer, FSkipExpreH);
end;

procedure TRpSection.WriteSkipToPageExpre(Writer:TWriter);
begin
 WriteWideString(Writer, FSkipToPageExpre);
end;

procedure TRpSection.ReadSkipExpreV(Reader:TReader);
begin
 FSkipExpreV:=ReadWideString(Reader);
end;

procedure TRpSection.ReadSkipToPageExpre(Reader:TReader);
begin
 FSkipToPageExpre:=ReadWideString(Reader);
end;

procedure TRpSection.DefineProperties(Filer:TFiler);
begin
 inherited;

 Filer.DefineProperty('ChangeExpression',ReadChangeExpression,WriteChangeExpression,True);
 Filer.DefineProperty('BeginPageExpression',ReadBeginPageExpression,WriteBeginPageExpression,True);
 Filer.DefineProperty('ChangeExpression',ReadChangeExpression,WriteChangeExpression,True);
 Filer.DefineProperty('SkipExpreV',ReadSkipExpreV,WriteSkipExpreV,True);
 Filer.DefineProperty('SkipExpreH',ReadSkipExpreH,WriteSkipExpreH,True);
 Filer.DefineProperty('SkipToPageExpre',ReadSkipToPageExpre,WriteSkipToPageExpre,True);
 Filer.DefineProperty('BackExpression',ReadBackExpression,WriteBackExpression,True);
 Filer.DefineBinaryProperty('Stream', ReadStream, WriteStream, true);
end;

function TRpSection.GetExternalDataDescription:String;
begin
 Result:='';
 if Length(ExternalConnection)<1 then
  exit;
 if Length(ExternalTable)<1 then
  exit;
 if Length(ExternalField)<1 then
  exit;
 if Length(ExternalSearchField)<1 then
  exit;
 if Length(ExternalSearchValue)<1 then
  exit;
 Result:=ExternalConnection+'-'+
  ExternalTable+'-'+ExternalField+'-'+
  ExternalSearchField+'-'+ExternalSearchValue;
end;

function RpSkipTypeToText(value:TRpSkipType):String;
begin
 case value of
  secskipdefault:
   begin
    Result:=SRpSDefault;
   end;
  secskipbefore:
   begin
    Result:=SRpSSkipBefore;
   end;
  secskipafter:
   begin
    Result:=SRpSSkipAfter;
   end;
 end;
end;

function StringToRpSkipType(value:String):TRpSkipType;
begin
 Result:=secskipdefault;
 if SRpSSkipBefore=value then
 begin
  Result:=secskipbefore;
  exit
 end;
 if SRpSSkipAfter=value then
 begin
  Result:=secskipafter;
  exit;
 end;
end;

procedure GetSkipTypePossibleValues(alist:TRpWideStrings);
begin
 alist.clear;
 alist.Add(SRpSDefault);
 alist.Add(SRpSSkipBefore);
 alist.Add(SRpSSkipAfter);
end;

function TRpSection.GetOwnedComponent(index:Integer):TComponent;
begin
 Result:=inherited Components[index];
end;

procedure TRpSection.Loaded;
begin
 inherited Loaded;
end;

procedure TRpSection.SetPageRepeat(Value:Boolean);
begin
 if (csReading in ComponentState) then
 begin
  FPageRepeat:=Value;
  exit;
 end;
 if (csLoading in ComponentState) then
 begin
  FPageRepeat:=Value;
  exit;
 end;
 FPageRepeat:=Value;
end;

function TRpSection.AddComponent(componentclass:TRpCommonPosClass):TRpCommonPosComponent;
begin
 Result:=componentclass.Create(Owner);
 GenerateNewName(Result);
 Components.Add.Component:=Result;
end;

function TRpSection.GetIsExternal:Boolean;
begin
 Result:=false;
 if Length(FExternalFilename)>0 then
 begin
  Result:=true;
  exit;
 end;
 if Length(GetExternalDataDescription)>0 then
 begin
  Result:=true;
  exit;
 end;
end;

procedure TRpSection.WriteBackExpression(Writer:TWriter);
begin
 WriteWideString(Writer, FBackExpression);
end;

procedure TRpSection.ReadBackExpression(Reader:TReader);
begin
 FBackExpression:=ReadWideString(Reader);
end;

procedure TRpSection.SetStream(Value:TMemoryStream);
begin
 if IsCompressed(Value) then
 begin
  FStream.LoadFromStream(Value);
 end
 else
 begin
  if TRpBaseReport(GetReport).StreamFormat=rpStreamzlib then
  begin
   CompressStream(Value,FStream);
  end
  else
   FStream.LoadFromStream(Value);
 end;
end;

procedure TRpSection.ReadStream(AStream:TStream);
var
 ssize:Int64;
begin
 if (sizeof(ssize)<>AStream.Read(ssize,sizeof(ssize))) then
  Raise Exception.Create(SRpInvalidStreaminRpImage);
 FStream.SetSize(ssize);
 FStream.Seek(0,soFromBeginning);
 if ssize=0 then
  exit;
{$IFDEF DOTNETD}
 if ssize<>FStream.CopyFrom(AStream,ssize) then
  Raise Exception.Create(SRpInvalidStreaminRpImage);
{$ENDIF}
{$IFNDEF DOTNETD}
 if ssize<>AStream.Read(FStream.memory^,ssize) then
  Raise Exception.Create(SRpInvalidStreaminRpImage);
{$ENDIF}
end;

procedure TRpSection.WriteStream(AStream:TStream);
var
 ssize:Int64;
begin
 ssize:=FStream.Size;
 AStream.Write(ssize,sizeof(ssize));
 FStream.Seek(0,soFromBeginning);
 AStream.CopyFrom(FStream,ssize);
// AStream.Write(FStream.Memory^,ssize);
end;


{$IFDEF DOTNETD}
function BytesToGraphicHeader(const ABytes: TBytes): TGraphicHeader;
begin
  Result.Count := System.BitConverter.ToUInt16(ABytes, 0);
  Result.HType := System.BitConverter.ToUInt16(ABytes, sizeof(Result.Count));
  Result.Size := System.BitConverter.ToUInt32(ABytes, sizeof(Result.Count) +
    sizeof(Result.HType));
end;
{$ENDIF}

function TRpSection.GetStream:TMemoryStream;
var
 evaluator:TRpEvaluator;
{$IFDEF DOTNETD}
 Temp:TBytes;
{$ENDIF}
begin
 try
  Result:=nil;
  if Length(Trim(BackExpression))>0 then
  begin
   // If the expression is a field
   if Not Assigned(TRpBaseReport(GetReport).Evaluator) then
    Exit;
   evaluator:=TRpBaseReport(GetReport).evaluator;
   Result:=evaluator.GetStreamFromExpression(BackExpression);
   if CachedImage=rpCachedVariable then
   begin
    if Assigned(Result) then
    begin
     if Result.Size>0 then
     begin
      Result.Seek(0,soFromBeginning);
      FOldStream.Seek(0,soFromBeginning);
      if not StreamCompare(FOldStream,Result) then
      begin
       cachedpos:=-1;
      end;
     end;
    end;
   end;
  end
  else
  begin
   if FStream.Size=0 then
    exit;
   if IsCompressed(FStream) then
   begin
    if FDecompStream.Size=0 then
     DecompressStream(FStream,FDecompStream);
    Result:=FDecompStream;
   end
   else
    Result:=FStream;
  end;
 except
  on E:Exception do
  begin
   Raise TRpReportException.Create(E.Message+':'+SRpSExpression+' '+Name,self,SRpSImage);
  end;
 end;
end;

procedure TRpSection.AddPageGroupCountItem(apageindex,aobjectindex:integer;
 adisplayformat:widestring);
var
 aobject:TTotalPagesObject;
 subrep:TRpSubReport;
 index:integer;
begin
 subrep:=TRpSubReport(SubReport);
 index:=subrep.GroupIndex(groupname);
 if index>0 then
 begin
  aobject:=TTotalPagesObject.Create;
  subrep.Sections[subrep.FirstDetail-index].Section.FPageGroupCountList.Add(aobject);
  aobject.PageIndex:=apageindex;
  aobject.ObjectIndex:=aobjectindex;
  aobject.DisplayFormat:=adisplayformat;
 end;
end;

procedure TRpSection.SubReportChanged(newstate:TRpReportChanged;newgroup:string='');
begin
 inherited SubReportChanged(newstate,newgroup);
 if newstate=rpReportStart then
 begin
  cachedpos:=-1;
  FirstPage:=0;
  FDecompStream.SetSize(0);
  FOldStream.SetSize(0);
 end;
end;


procedure TRpSection.ClearPageCountList;
var
 i:integer;
begin
 for i:=0 to FPageGroupCountList.Count-1 do
 begin
  TObject(FPageGroupCountList.Items[i]).Free;
 end;
 FPageGroupCountList.Clear;
end;

procedure TRpSection.UpdatePageCounts;
var
 areport:TRpBaseReport;
 ametafile:TRpMetafileReport;
begin
 areport:=TRpBaseReport(Owner);
 ametafile:=areport.metafile;
 // Two pass report is needed for UpdateTotalPages
 if (FPageGroupCountList.Count>0) then
 begin
  if (not areport.TwoPass)  then
   raise Exception.Create(SRpSTwoPassReportNeeded+'-'+TranslateStr(50,'Page setup'));
 end;
 if (FPageGroupCountList.Count>0) then
  if (not areport.TwoPass) then
   raise Exception.Create(SRpSTwoPassReportNeeded+'-'+TranslateStr(50,'Page setup'));
 ametafile.UpdateTotalPagesPCount(FPageGroupCountList,ametafile.CurrentPageCount-FirstPage);
end;


end.
