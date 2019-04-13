{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       RpSecutil                                       }
{       A collection of sections                        }
{       Used by a subreport                             }
{                                                       }
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


unit rpsecutil;

interface

uses Classes,Sysutils,rpsection;

type
  TRpSectionListItem=class;
  TRpSectionList=class(TCollection)
   private
    FSubReport:TComponent;
    function GetItem(Index:Integer):TRpSectionListItem;
    procedure SetItem(index:integer;Value:TRpSectionListItem);
   public
    constructor Create(rp:TComponent);
    function Add:TRpSectionListItem;
    function IndexOf(Value:TRpSection):integer;
    property Items[index:integer]:TRpSectionListItem read GetItem write SetItem;default;
   published
   end;

  TRpSectionListItem=class(TCollectionItem)
   private
    FSection:TRpSection;
    procedure SetSection(Value:TRpSection);
   public
    procedure Assign(Source:TPersistent);override;
   published
    property Section:TRpSection read FSection write SetSection;
   end;


implementation


constructor TRpSectionList.Create(rp:TComponent);
begin
 inherited Create(TRpSectionListItem);
 FSubReport:=rp;
end;

procedure TRpSectionListItem.SetSection(Value:TRpSection);
begin
 FSection:=Value;
 Changed(False);
end;

procedure TRpSectionListItem.Assign(Source:TPersistent);
begin
 if Source is TRpSectionListItem then
 begin
  FSection:=TRpSectionListItem(Source).FSection;
 end
 else
  inherited Assign(Source);
end;


function TRpSectionlist.Add:TRpSectionListItem;
begin
 Result:=TRpSectionListItem(inherited Add);
end;

function TRpSectionList.IndexOf(Value:TRpSection):integer;
var
 i:integer;
begin
 Result:=-1;
 i:=0;
 While i<count do
 begin
  if items[i].FSection=vALUE then
  begin
   Result:=i;
   break;
  end;
  inc(i);
 end;
end;

function TRpSectionList.GetItem(Index:Integer):TRpSectionListItem;
begin
 Result:=TRpSectionListItem(inherited GetItem(index));
end;

procedure TRpSectionList.SetItem(index:integer;Value:TRpSectionListItem);
begin
 inherited SetItem(Index,Value);
end;


end.

