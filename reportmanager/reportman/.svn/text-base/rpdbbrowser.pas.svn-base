{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       rpdbbrowser                                     }
{       Database broser frame                           }
{                                                       }
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

unit rpdbbrowser;

interface

{$I rpconf.inc}

uses
  SysUtils, Classes, QGraphics, QControls, QForms,
  rpdatainfo,rpmdconsts,rpreport,rptypeval,rpparser,rptypes,
{$IFDEF USEEVALHASH}
  rphashtable,
  rpstringhash,
{$ENDIF}
  QDialogs, QComCtrls, QImgList, QMenus, QTypes;

type
  TFRpBrowser = class(TFrame)
    ATree: TTreeView;
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    MRefresh: TMenuItem;
    procedure ATreeExpanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure ATreeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MRefreshClick(Sender: TObject);
  private
    { Private declarations }
    FShowDataTypes:Boolean;
    FReport:TRpReport;
    FShowDatasets:Boolean;
    FShowDatabases:Boolean;
    FShowEval:Boolean;
    procedure SetReport(Value:TRpReport);
    procedure InitTree;
    procedure SetShowDataTypes(value:Boolean);
    procedure FreeFieldsInfo;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    property Report:TRpReport read FReport write SetReport;
    property ShowEval:Boolean read FShowEval write FShowEval;
    property ShowDatasets:Boolean read FShowDatasets write FShowDatasets;
    property ShowDatabases:Boolean read FShowDatabases write FShowDatabases;
    property ShowDataTypes:Boolean read FShowDataTypes write SetShowDataTypes
     default true;
  end;

  TRpDBFieldInfo=class(TObject)
   FieldSize:Integer;
   dbinfo:TRpDatabaseInfoItem;
   dinfo:TRpDataInfoItem;
  end;

implementation


{$R *.xfm}

function NewTRpDBFieldInfo(fieldsize:integer;dbinfo:TRpDatabaseInfoItem;dinfo:TRpDataInfoItem):TRpDBFieldInfo;
begin
 Result:=TRpDBFieldInfo.Create;
 Result.FieldSize:=fieldsize;
 Result.dbinfo:=dbinfo;
 Result.dinfo:=dinfo;
end;

procedure TFRpBrowser.FreeFieldsInfo;
var
 i:integer;
begin
 for i:=0 to ATree.Items.Count-1 do
 begin
  if TObject(ATree.Items[i].Data) is TRpDBFieldInfo then
  begin
   TObject(ATree.Items[i].Data).free;
   ATree.Items[i].Data:=nil;
  end;
 end;
 ATree.Items.Clear;
end;

destructor TFRpBrowser.Destroy;
begin
 FreeFieldsInfo;
 inherited Destroy;
end;

procedure TFRpBrowser.SetReport(Value:TRpReport);
begin
 FReport:=Value;
 if Assigned(FReport) then
 begin
  InitTree;
 end
 else
 begin
  FreeFieldsInfo;
 end;
end;

procedure TFRpBrowser.InitTree;
var
 i:integer;
 dbinfo:TRpDatabaseInfoList;
 dinfo:TRpDataInfoList;
 anode,nnode:TTreeNode;
 aiden:TRpIdentifier;
 alist:TStringList;
 astringiden:string;
{$IFDEF USEEVALHASH}
 ait:TstrHashIterator;
{$ENDIF}
begin
 FreeFieldsInfo;
 if FShowDatabases then
 begin
  dbinfo:=FReport.DatabaseInfo;
  for i:=0 to dbinfo.Count-1 do
  begin
   anode:=ATree.Items.AddChild(nil,dbinfo.Items[i].Alias);
   anode.Data:=NewTRpDBFieldInfo(0,dbinfo.Items[i],nil);
   anode.ImageIndex:=0;
   anode.SelectedIndex:=0;
   // Place an empty child
   ATree.Items.AddChild(anode,'');
  end;
 end;
 if FShowDatasets then
 begin
  dinfo:=FReport.DataInfo;
  for i:=0 to dinfo.Count-1 do
  begin
   anode:=ATree.Items.AddChild(nil,dinfo.Items[i].Alias);
   anode.Data:=NewTRpDBFieldInfo(0,nil,dinfo.Items[i]);
   anode.ImageIndex:=1;
   anode.SelectedIndex:=1;
   // Place an empty child
   ATree.Items.AddChild(anode,'');
  end;
 end;
 if FShowEval then
 begin
  anode:=ATree.Items.AddChild(nil,SRpVariables);
  anode.ImageIndex:=1;
  anode.SelectedIndex:=1;
  FReport.InitEvaluator;
  FReport.AddReportItemsToEvaluator(FReport.Evaluator);
  alist:=TStringList.Create;
  try
   alist.Sorted:=true;
{$IFDEF USEEVALHASH}
   ait:=FReport.Evaluator.Identifiers.getIterator;
   while ait.hasnext do
   begin
    ait.next;
    aiden:=TRpIdentifier(ait.getValue);
    astringiden:=ait.getKey;
{$ENDIF}
{$IFNDEF USEEVALHASH}
   for i:=0 to FReport.Evaluator.Identifiers.Count-1 do
   begin
    aiden:=TRpIdentifier(FReport.Evaluator.Identifiers.Objects[i]);
    astringiden:=FReport.Evaluator.Identifiers.Strings[i];
{$ENDIF}
    if Length(aiden.Idenname)>0 then
     if ((astringiden<>'CIERTO') AND
      (astringiden<>'M.PAGINA') AND (astringiden<>'M.NUMPAGINA')) then
    begin
     if alist.Indexof(aiden.IdenName)<0 then
     begin
      if aiden is TIdenConstant then
      begin
       alist.Add(astringiden);
       nnode:=ATree.Items.AddChild(anode,astringiden);
       nnode.ImageIndex:=2;
       nnode.SelectedIndex:=2;
      end
      else
      begin
       if aiden is TIdenVariable then
       begin
        alist.Add(astringiden);
        nnode:=ATree.Items.AddChild(anode,astringiden);
        nnode.ImageIndex:=2;
        nnode.SelectedIndex:=2;
       end
       else
       begin
        if aiden is TIdenFunction then
        begin
         if TIdenFunction(aiden).ParamCount=0 then
         begin
          alist.Add(astringiden);
          nnode:=ATree.Items.AddChild(anode,astringiden);
          nnode.ImageIndex:=2;
          nnode.SelectedIndex:=2;
         end;
        end;
       end;
      end;
     end;
    end;
   end;
   nnode:=ATree.Items.AddChild(anode,'PAGECOUNT');
   nnode.ImageIndex:=2;
   nnode.SelectedIndex:=2;
   nnode:=ATree.Items.AddChild(anode,'GROUPPAGECOUNT');
   nnode.ImageIndex:=2;
   nnode.SelectedIndex:=2;
  finally
   alist.free;
  end;
 end;
end;

procedure TFRpBrowser.ATreeExpanding(Sender: TObject; Node: TTreeNode;
  var AllowExpansion: Boolean);
var
 dbitem:TRpDatabaseInfoItem;
 ditem:TRpDataInfoItem;
 achild:TTreeNode;
 alist,fieldtypes,fieldsizes:TStringList;
 usebrackets:Boolean;
 i,j:integer;
 aname:string;
 ainfo:TRpDBFieldInfo;
begin
 if not assigned(Node.Data) then
  exit;
 if Node.Count<1 then
  exit;
 achild:=Node.Item[0];
 // It's already readed
 if achild.Text<>'' then
  exit;
 try
  if Assigned(Node.Data) then
  begin
   ainfo:=TRpDBFieldInfo(Node.Data);
    if Assigned(ainfo.dbinfo) then
    begin
     dbitem:=ainfo.dbinfo;
     alist:=TStringList.Create;
     fieldtypes:=TStringList.Create;
     fieldsizes:=TStringList.Create;
     try
      // Tables
      Atree.Items.Delete(achild);
      if Node.Parent=nil then
      begin
       dbitem.GetTableNames(alist,FReport.Params);
       if alist.count<1 then
        AllowExpansion:=false
       else
       begin
        for i:=0 to alist.Count-1 do
        begin
         aname:=alist.Strings[i];
         if ((i<fieldtypes.Count) and (FShowDataTypes)) then
         begin
          aname:=aname+'-'+fieldtypes.Strings[i];
          if (i<fieldsizes.Count) then
           if Length(fieldsizes.Strings[i])>0 then
            aname:=aname+'('+fieldsizes.Strings[i]+')';
         end;
         achild:=ATree.Items.AddChild(Node,aname);
         achild.Data:=NewTRpDBFieldInfo(0,dbitem,nil);
         ATree.Items.AddChild(achild,'');
        end;
       end;
      end
      // Fields
      else
      begin
       dbitem.GetFieldNames(Node.Text,alist,fieldtypes,fieldsizes,FReport.Params);
       if alist.count<1 then
        AllowExpansion:=false
       else
       begin
        for i:=0 to alist.Count-1 do
        begin
         aname:=alist.Strings[i];
         if ((i<fieldtypes.Count) and (FShowDataTypes)) then
         begin
          aname:=aname+' '+fieldtypes.Strings[i];
          if i<fieldsizes.Count then
           if Length(fieldsizes.Strings[i])>0 then
            aname:=aname+'('+fieldsizes.Strings[i]+')';
         end;
         achild:=ATree.Items.AddChild(Node,aname);
         achild.ImageIndex:=2;
         achild.SelectedIndex:=2;
         achild.Data:=NewTRpDBFieldInfo(10,nil,nil);
         if (i<fieldsizes.Count) then
          if Length(fieldsizes.Strings[i])>0 then
          begin
           TObject(achild.Data).free;
           achild.Data:=NewTRpDBFieldInfo(StrToInt(fieldsizes.strings[i]),nil,nil);
          end;
         achild.ImageIndex:=1;
         achild.SelectedIndex:=1;
        end;
       end;
      end;
     finally
      alist.free;
      fieldtypes.free;
      fieldsizes.free;
     end;
    end
    else
    begin
     if Assigned(ainfo.dinfo) then
     begin
      ditem:=ainfo.dinfo;
//      FReport.PrepareParamsBeforeOpen;
//      ditem.Connect(Freport.DatabaseInfo,FReport.Params);
      alist:=TStringList.Create;
      fieldtypes:=TStringList.Create;
      fieldsizes:=TStringList.Create;
      try
       Atree.Items.Delete(achild);
       ditem.GetFieldNames(alist,fieldtypes,fieldsizes);
//       FillFieldsInfo(ditem.Dataset,alist,fieldtypes,fieldsizes);
       if alist.count<1 then
        AllowExpansion:=false
       else
       begin
        for i:=0 to alist.Count-1 do
        begin
         aname:=alist.Strings[i];
         usebrackets:=false;
         for j:=1 to Length(aname) do
         begin
          if Not (aname[j] in ParserSetChars) then
          begin
           usebrackets:=true;
           break;
          end;
         end;
         if usebrackets then
          aname:='['+ditem.Alias+'.'+aname+']'
         else
          aname:=ditem.Alias+'.'+aname;
         if ((i<fieldtypes.Count) and (FShowDataTypes)) then
         begin
          aname:=aname+' '+fieldtypes.Strings[i];
          if Length(fieldsizes.Strings[i])>0 then
           aname:=aname+'('+fieldsizes.Strings[i]+')';
         end;
         achild:=ATree.Items.AddChild(Node,aname);
         achild.Data:=NewTRpDBFieldInfo(10,nil,nil);
         if i<fieldsizes.Count then       
          if Length(fieldsizes.Strings[i])>0 then
          begin
           TObject(achild.Data).free;
           achild.Data:=NewTRpDBFieldInfo(StrToInt(fieldsizes.strings[i]),nil,nil);
          end;       
         achild.ImageIndex:=2;
         achild.SelectedIndex:=2;
        end;
       end;
      finally
       alist.free;
       fieldtypes.free;
       fieldsizes.free;
      end;
     end;
    end;
  end;
 except
  on E:Exception do
  begin
   ShowMessage(E.Message);
   AllowExpansion:=false;
  end;
 end;
end;

constructor TFRpBrowser.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

 FShowDatasets:=true;
 FShowEval:=true;
 FShowDatabases:=true;
 MRefresh.Caption:=SRpRefresh;
end;


procedure TFRpBrowser.ATreeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 anode:TTreeNode;
begin
 if Not Assigned(ATree.Selected) then
  exit;
 anode:=ATree.Selected;
 if Not Assigned(anode.Parent) then
  exit;
 if anode.ImageIndex=2 then
 begin
  BeginDrag(False);
 end;
end;

procedure TFRpBrowser.MRefreshClick(Sender: TObject);
begin
 SetReport(FReport);
end;


procedure TFRpBrowser.SetShowDataTypes(value:Boolean);
begin
 if value<>FShowDataTypes then
 begin
  FShowDataTypes:=value;
  SetReport(FReport);
 end;
end;

end.

