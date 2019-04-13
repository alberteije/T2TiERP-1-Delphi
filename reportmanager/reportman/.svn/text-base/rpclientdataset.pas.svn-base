unit rpclientdataset;

interface


{$I rpconf.inc}
uses Classes, DB,
{$IFDEF DELPHI2006UP}
 DbCommonTypes,
{$ENDIF}
 DBClient;

type
  TRpClientDataset = class(TClientDataSet)
  protected
    function LocateRecordUsingIndex(const KeyFields: string; const KeyValues:
        Variant; Options: TLocateOptions; SyncCursor: Boolean; out CouldUseIndex:
        Boolean): Boolean;
    function MapsToIndex(Fields: TList; CaseInsensitive: Boolean): Boolean;
  public
    function Locate(const KeyFields: string; const KeyValues: Variant; Options:
        TLocateOptions): Boolean; override;
    function Lookup(const KeyFields: string; const KeyValues: Variant; const
        ResultFields: string): Variant; override;
  end;


implementation

{$IFDEF USEVARIANTS}
uses Variants; // not needed for Delphi 5
{$ENDIF}

function TRpClientDataset.Locate(const KeyFields: string; const KeyValues:
    Variant; Options: TLocateOptions): Boolean;
var
  CouldUseIndex: Boolean;
begin
  Result := LocateRecordUsingIndex(KeyFields, KeyValues, Options, True, CouldUseIndex);
  if not CouldUseIndex then
    Result := inherited Locate(KeyFields, KeyValues, Options);
end;

function TRpClientDataset.LocateRecordUsingIndex(const KeyFields: string; const
    KeyValues: Variant; Options: TLocateOptions; SyncCursor: Boolean; out
    CouldUseIndex: Boolean): Boolean;
var
  I: Integer;
  Fields: TList;
  SavedIndexName, SavedIndexFieldNames: string;
  KeyIndex: TIndexDef;
begin
  if (loPartialKey in Options) then
  begin
    CouldUseIndex := False;
    Result := False;
    Exit;
  end;

  KeyIndex := nil;
  Fields := TList.Create;
  try
    GetFieldList(Fields, KeyFields);
    if MapsToIndex(Fields, loCaseInsensitive in Options) then
      CouldUseIndex := True
    else
    begin
      KeyIndex := IndexDefs.GetIndexForFields(KeyFields, loCaseInsensitive in Options);
      CouldUseIndex := KeyIndex <> nil;
    end;
    if CouldUseIndex then
    begin
      if Assigned(KeyIndex) then
      begin
        SavedIndexName := IndexName;
        SavedIndexFieldNames := IndexFieldNames;
        IndexName := KeyIndex.Name;
      end;
      try
        SetKey;
        if Fields.Count = 1 then
        begin
          if VarIsArray(KeyValues) then
            TField(Fields.First).Value := KeyValues[0] else
            TField(Fields.First).Value := KeyValues;
        end
        else
          for I := 0 to Fields.Count - 1 do
            TField(Fields[I]).Value := KeyValues[I];
        {make sure that it only searches on first Fields.Count records, set FieldCount}
        GetKeyBuffer(kiLookUp).FieldCount := Fields.Count;
        Result := GotoKey;
      finally
        if Assigned(KeyIndex) then
        begin
          {Restore indexes, always restore at least one of them}
          if SavedIndexFieldNames <> '' then
            IndexFieldNames := SavedIndexFieldNames
          else
            IndexName := SavedIndexName;
        end;
      end;
    end
    else
      Result := False; // if we can't use an index we always return False!
 finally
    Fields.Free;
  end;
end;

function TRpClientDataset.Lookup(const KeyFields: string; const KeyValues:
    Variant; const ResultFields: string): Variant;
var
  CouldUseIndex: Boolean;
begin
  if LocateRecordUsingIndex(KeyFields, KeyValues, [], False, CouldUseIndex) then
    Result := FieldValues[ResultFields]
  else
  begin
    if not CouldUseIndex then
      Result := inherited Lookup(KeyFields, KeyValues, ResultFields)
    else
      Result := Null;
  end;
end;

function TRpClientDataset.MapsToIndex(Fields: TList; CaseInsensitive: Boolean):
    Boolean;
var
  I: Integer;
begin
  Result := False;
  if (IndexFieldNames = '') then
    Exit;
  if Fields.Count > IndexFieldCount then Exit;
  for I := 0 to Fields.Count - 1 do
    if Fields[I] <> IndexFields[I] then Exit;
  Result := True;
end;

//procedure Register;
//begin
//  RegisterComponents('Data Access', [TRpClientDataset]);
//end;

end.

