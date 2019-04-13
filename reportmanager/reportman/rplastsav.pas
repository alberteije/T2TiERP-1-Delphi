{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rplastsav                                       }
{                                                       }
{       A component to store last opened files...       }
{       or anything else, that is last used strings     }
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

unit rplastsav;

interface

uses Classes,Sysutils,IniFiles;

type
 TRpLastUsedStrings=class(TComponent)
  private
   FHistoryCount:integer;
   FCaseSensitive:boolean;
   FLastUsed:TStrings;
   FSaveIndex:integer;
   procedure SetLastUsed(Newlist:TStrings);
   procedure SetCaseSensitive(NewCase:boolean);
   procedure SetHistoryCount(NewCount:integer);
   procedure AdjustSize;
  public
   constructor Create(AOwner:TComponent);override;
   destructor Destroy;override;
   procedure UseString(newstring:string);
   procedure SaveToConfigFile(filename:string);
   procedure LoadFromConfigFile(filename:string);
   property LastUsed:TStrings read FLastUsed write SetLastUsed;
   procedure FillWidthShortNames(alist:TStrings;width:integer);
  published
   property HistoryCount:integer read FHistoryCount write SetHistoryCount default 5;
   property CaseSensitive:boolean read FCaseSensitive write SetCaseSensitive default false;
   property SaveIndex:integer read FSaveIndex write FSaveIndex;
 end;
implementation

constructor TRpLastUsedStrings.Create(AOwner:TComponent);
begin
 inherited create(AOwner);

 FHistoryCount:=5;
 FLastUsed:=TStringList.Create;
{$IFDEF USEVARIANTS}
 TStringList(FLastUsed).CaseSensitive:=false;
{$ENDIF}
end;

destructor TRpLastUsedStrings.Destroy;
begin
 FLastUsed.free;
 inherited destroy;
end;

procedure TRpLastUsedStrings.SetCaseSensitive(NewCase:boolean);
begin
 FCaseSensitive:=NewCase;
{$IFDEF USEVARIANTS}
 TStringList(FLastUsed).CaseSensitive:=NewCase;
{$ENDIF}
end;

procedure TRpLastUsedStrings.SetLastUsed(Newlist:TStrings);
begin
 FLastUsed.Assign(Newlist);
end;

procedure TRpLastUsedStrings.UseString(newstring:string);
var
 index:integer;
begin
 // Search it in strings
 index:=FLastUsed.IndexOf(newstring);
 if index>=0 then
  FLastUsed.delete(index);
 // Insert it
 FLastUsed.Insert(0,newstring);
 // Delete the old strings
 Adjustsize;
end;

procedure TRpLastUsedStrings.SetHistoryCount(NewCount:integer);
begin
 if NewCount<1 then
  NewCount:=1;
 FHistoryCount:=Newcount;
 AdjustSize;
end;

procedure TRpLastUsedStrings.AdjustSize;
begin
 While (FLastUsed.Count>FHistoryCount) do
  FLastUsed.Delete(FLastUsed.Count-1);
end;

procedure TRpLastUsedStrings.SaveToConfigFile(filename:string);
var
 inif:TInifile;
 i:integer;
begin
 inif:=TInifile.create(filename);
 try
  inif.WriteInteger('LastUsed'+IntToStr(FSaveIndex),'SaveCount',FLastUsed.count);
  for i:=0 to FLastUsed.count-1 do
  begin
   inif.WriteString('LastUsed'+IntToStr(FSaveIndex)+'-'+IntToStr(i),'Filename',FLastUsed.Strings[i]);
  end;
  inif.UpdateFile;
 finally
  inif.free;
 end;
end;


procedure TRpLastUsedStrings.LoadFromConfigFile(filename:string);
var
 inif:TInifile;
 i:integer;
 stringcount:integer;
begin
 FLastUsed.clear;
 inif:=TInifile.create(filename);
 try
  stringcount:=inif.ReadInteger('LastUsed'+IntToStr(FSaveIndex),'SaveCount',0);
  for i:=0 to stringcount-1 do
  begin
   FLastUsed.Add(inif.ReadString('LastUsed'+IntToStr(FSaveIndex)+'-'+IntToStr(i),'Filename',''));
  end;
 finally
  inif.free;
 end;
end;

procedure TRpLastUsedStrings.FillWidthShortNames(alist:TStrings;width:integer);
var
 i:integer;
 astring:string;
begin
 alist.clear;

 for i:=0 to LastUsed.count-1 do
 begin
  astring:=Lastused.Strings[i];
  if (Length(astring)  <= width) then
  begin
   alist.Add(astring);
  end
  else
  begin
   width:=width-3;
   astring:=Copy(astring,length(astring)-width,width+1);
   astring:='...'+astring;
   alist.Add(astring);
  end;
 end;
end;

end.
