unit rphashtable;

{$R-}
{$Q-}


(* when compiling with freePascal, use -S2 switch (-Sd won't work) *)
(* todo : see if making it compatible with -Sd is possible and / or necessary *)

(* -------------------------------------------------------- *)
(*                                                          *)
(*    (incomplete) rip-off of java hashtable                *)
(*                                                          *)
(*                                                          *)
(* -------------------------------------------------------- *)



interface

{$I rpconf.inc}

uses rpcomparable, sysutils;

type

tHashEntry = class(tComparable)
  private
     fkey : tComparable;
     fvalue : tObject;

  protected
     function compareObjects(object2 : tComparable) : integer; override;
  public
     next : tHashEntry;


     function  hashCode : integer; override;

     function getKey : tComparable;
     function getValue : tObject;
     procedure setValue(avalue : tObject);

     property key : tComparable read getKey;
     property value : tObject read getValue write setValue;


     constructor create(akey : tComparable; avalue : tObject);
end;

tHashEntryClass = class of tHashEntry;

tHashEntryFactory = class(tObject)
private
   fHashClass : tHashEntryClass;
public
   function getEntry(key: tComparable; value : tObject) : tHashEntry; virtual;
   constructor create(hashEntryClass : tHashEntryClass);
end;

tMapIterator = class (tObject)
public
   procedure next; virtual; abstract;
   procedure remove; virtual; abstract;
   function hasNext : boolean; virtual; abstract;
   function getKey : tComparable; virtual; abstract;
   function getValue : tObject; virtual; abstract;
   function validEntry : boolean; virtual; abstract;
   procedure setValue(value : tObject); virtual; abstract;
   function isValid : boolean; virtual; abstract;

   property key : tComparable read getKey;
   property value : tObject read getValue write setValue;
end;


{$IFNDEF FPC}
tHashEntryTable = array of tHashEntry;
pHashEntryTable = ^tHashEntryTable;
{$ELSE FPC}
pHashEntryTable = ^tHashEntry;
{$ENDIF}

tHashTable = class (tObject)
protected
    fTable : pHashEntryTable;
    fEntryFactory : tHashEntryFactory;
    fModCount : integer;
    fCapacity : integer;
    fThreshHold : integer;
    fLoadFactor : real;
    fCount      : integer;

    fOwnKeys    : boolean;

    function hashToIndex(key : tComparable) : integer;

    procedure rehash; virtual;


    (* there's a potential for memory leak here
       if key already in the table, it does not get re-inserted.
       function setvalue returns false if this happens, so key may be freed if necessary
       but procedure fsetvalue does not free keys. SO : don't use values property unless you're managing _all_ keys somewhere outsite of the hash table
       CORRECTION : if ownKeys is set, fSetvalue will free the key, so there's no leak
    *)
    (* another possibility for a leak - what happens if the value that is already in the table is not managed outside? Should be deleted, but how? *)
    procedure fSetValue(key : tComparable; value : tObject); virtual;

    procedure clearTable(deleteValues : boolean);
public
    function getIterator : tMapIterator; virtual;
    function containsKey(key : tComparable) : boolean; virtual;
    function containsValue(value : tObject) : boolean; virtual;
    function getValue(key : tComparable) : tObject; virtual;
    function setValue(key : tComparable; value : tObject) : boolean; virtual;
    function remove(key : tComparable) : tObject; virtual;

    function getCount : integer; virtual;

    property values[key : tComparable] : tObject read getValue write fsetValue;
    property count : integer read getCount;

    {$IFNDEF FPC}
    constructor create(initialcapacity : integer = 10; loadfactor : real = 0.75; entryfactory : tHashEntryFactory = nil; ownKeys : boolean = true);
    {$ELSE FPC}
    constructor create(initialcapacity : integer; loadfactor : real; entryfactory : tHashEntryFactory; ownKeys : boolean);
    constructor create;
    {$ENDIF}

    destructor Destroy; override;

    procedure clear; virtual;
    procedure deleteAll; virtual;
end;

tHashTableIterator = class(tMapIterator)
protected
       fIndex : integer;
       fEntry : tHashEntry;
       fModCount : integer;
       fIsRemoved : boolean;
       fCurrent : integer;

       fHashTable : tHashTable;
public
   constructor create(table : tHashTable);

   procedure next; override;
   procedure remove; override;
   function hasNext : boolean; override;
   function getKey : tComparable; override;
   function getValue : tObject; override;
   procedure setValue(avalue : tObject); override;
   function validEntry : boolean; override;
   function isValid : boolean; override;

end;


(* -------------------------------------------------------- *)
(*                                                          *)
(*                                                          *)
(*                                                          *)
(*                                                          *)
(* -------------------------------------------------------- *)

implementation

(********* pointer functions ***********)


{$IFNDEF FPC}
//delphi implementation, uses dynamic arrays

function getNewEntryTable(size : integer) : pHashEntryTable;
begin
     new(result);
     setLength(result^, size);
end;

procedure freeEntryTable(table : pHashEntryTable; oldSize : integer);
begin
     setLength(table^, 0);
     dispose(table);
end;

function arrayGet(arr : pHashEntryTable; index : integer) : tHashEntry;
begin
    result := arr^[index];
end;

procedure arrayPut(arr : pHashEntryTable; index : integer; value : tHashEntry);
begin
   arr^[index] := value;
end;

{$ELSE FPC}
//freepascal implementaion, uses pointers as arrays 

function getNewEntryTable(size: integer) : pHashEntryTable;
begin
     getmem(result, size * sizeOf(tHashEntry));
end;

procedure freeEntryTable(table : pHashEntryTable; oldSize : integer);
begin
     freemem(table, oldSize * sizeOf(tHashEntry));
end;

function arrayGet(arr : pHashEntryTable; index : integer) : tHashEntry;
begin
     result := arr[index];
end;

procedure arrayPut(arr : pHashEntryTable; index : integer; value : tHashEntry);
begin
   arr[index] := value;
end;

{$ENDIF FPC}


function equal(item1, item2 :tObject) : boolean;
begin
     if ((item1 = nil) or (item1 is tComparable)) and
        ((item2 = nil) or (item2 is tComparable)) then
        result := rpcomparable.equal(tComparable(item1), tComparable(item2))
     else
        result := false;
end;


constructor tHashEntryFactory.create(hashEntryClass : tHashEntryClass);
begin
  inherited create;
  fHashClass := hashEntryClass;
end;

function tHashEntryFactory.getEntry(key : tComparable; value : tObject) : tHashEntry;
begin
  result := fHashClass.create(key, value);
end;
//**

(************ thashentry ***************)
function tHashEntry.compareObjects(object2 : tComparable) : integer;
begin
     throwComparableException(object2, self.ClassType);
     // this is not really important so we'll just make it compare keys
     result := compare(fkey, tHashEntry(object2).key);
end;


function  tHashEntry.hashCode : integer;
begin
     // for our purposes the hash code of the key is good enough
     result := key.hashCode;
end;

function tHashEntry.getKey : tComparable;
begin
     result := fKey;
end;

function tHashEntry.getValue : tObject;
begin
     result := fValue;
end;

procedure tHashEntry.setValue(avalue : tObject);
begin
     fValue := avalue;
end;

constructor tHashEntry.create(akey : tComparable; avalue : tObject);
begin
     inherited create;
     fKey := akey;
     fValue := avalue;
     next := nil;
end;


(***************** hashtable *************************)
function tHashTable.hashToIndex(key : tComparable) : integer;
begin
     result := abs(key.hashCode) mod fCapacity;
end;



procedure tHashTable.rehash;
var
   oldCapacity : integer;
   oldTable : pHashEntryTable;
   newCapacity : integer;
   newTable : pHashEntryTable;
   i : integer;
   index : integer;
   entry, oldentry : tHashEntry;
begin

   oldCapacity := fCapacity;
   newCapacity := oldCapacity * 2 + 1;
   newTable    := getNewEntryTable(newCapacity);

   inc(fModCount);
   oldTable := fTable;
   fTable := newTable;
   fCapacity := newCapacity;
   fThreshHold := round(newCapacity * fLoadFactor);

   try

     for i := 0 to oldCapacity - 1 do begin
         oldEntry := arrayGet(oldTable, i);
         while oldEntry <> nil do begin
            entry := oldEntry;
            oldEntry := oldEntry.next;

            index := hashToIndex(entry.key);
            entry.next := arrayGet(fTable, index);
            arrayPut(fTable, index, entry);

         end;
     end;
   finally

     freeEntryTable(oldTable, oldCapacity);
   end;

end;

procedure tHashTable.fSetValue(key : tComparable; value : tObject);
begin
     setValue(key, value);
end;

function tHashTable.getIterator : tMapIterator;
begin
     result := tHashTableIterator.create(self); 
end;

function tHashTable.containsKey(key : tComparable) : boolean;
var
   idx : integer;
   entry : tHashEntry;
begin
   idx := hashToIndex(key);

   result := false;
   entry := arrayGet(fTable, idx);
   while (entry <> nil) and not result do begin
         result := equal(key, entry.key);
         entry := entry.next;
   end;

end;

function tHashTable.containsValue(value : tObject) : boolean;
var
   idx : integer;
   entry : tHashEntry;
begin
   result := false;
   for idx := 0 to fCapacity - 1 do begin
       entry := arrayGet(fTable, idx);
       while (entry <> nil) and not result do begin
             result := equal(value, entry.value);
             entry := entry.next;
       end;
       if result then break;
   end;
end;


function tHashTable.getValue(key : tComparable) : tObject;
var
   idx : integer;
   entry : tHashEntry;
begin
   idx := hashToIndex(key);
   result := nil;
   entry := arrayGet(fTable, idx);
   while (entry <> nil) do begin
         if equal(key, entry.key) then begin
            result := entry.value;
            break;
         end;
         entry := entry.next;
   end;
end;

function tHashTable.setValue(key : tComparable; value : tObject) : boolean;
var
   idx : integer;
   entry : tHashEntry;
begin

   // first try to find key in the table and replace the value
   idx := hashToIndex(key);
   entry := arrayGet(fTable, idx);
   while entry <> nil do begin
         if equal(key, entry.key) then begin
            result := false;
            entry.value := value;
            if fOwnKeys then
               key.free;
            exit;
         end;
         entry := entry.next;
   end;

   // inserting new key-value pair
   inc(fModCount);
   if fcount > fThreshHold then
      rehash;

   idx := hashToIndex(key);
   entry := fEntryFactory.getEntry(key, value);
   entry.next := arrayGet(ftable ,idx);
   arrayPut(ftable, idx, entry);
   inc(fcount);
   result := true;

end;


function tHashTable.remove(key : tComparable) : tObject;
var
   idx : integer;
   entry : tHashEntry;
   preventry : tHashEntry;
begin

   idx := hashToIndex(key);
   entry := arrayGet(fTable, idx);
   result := nil;
   prevEntry := nil;
   while entry <> nil do begin
         if equal(key, entry.key) then begin
            inc(fModCount);
            result := entry.value;
            if fOwnKeys then if entry.key <> key then key.free; //test this! 
            if fOwnKeys then entry.key.free;
            if prevEntry = nil then
               arrayPut(fTable, idx, entry.next)
            else
               prevEntry.next := entry.next;
            entry.free;
            dec(fCount);
            break;
         end;
         preventry := entry;
         entry := entry.next;
   end;

end;

function tHashTable.getCount : integer;
begin
     result := fCount;
end;


{$IFDEF FPC}
constructor tHashTable.create(initialcapacity : integer; loadfactor : real; entryfactory : tHashEntryFactory; ownKeys : boolean);
begin
     inherited create;

     fLoadFactor := loadfactor;
     fOwnKeys := ownKeys;
     if entryFactory = nil then
        fEntryFactory := tHashEntryFactory.create(tHashEntry)
     else
        fEntryFactory := entryfactory;
     fTable := getNewEntryTable(initialCapacity);
     fCapacity := initialcapacity;
     fThreshHold := round(fCapacity * fLoadFactor);
     fCount := 0;
     fModCount := 0;

end;

constructor tHashTable.create;
begin
     create(10, 0.75, nil, true);
end;

{$ELSE FPC}
constructor tHashTable.create(initialcapacity : integer = 10; loadfactor : real = 0.75; entryfactory : tHashEntryFactory = nil; ownKeys : boolean = true);
begin
     inherited create;

     fLoadFactor := loadfactor;
     fOwnKeys := ownKeys;
     if entryFactory = nil then
        fEntryFactory := tHashEntryFactory.create(tHashEntry)
     else
        fEntryFactory := entryfactory;
     fTable := getNewEntryTable(initialCapacity);
     fCapacity := initialcapacity;
     fThreshHold := round(fCapacity * fLoadFactor);
     fCount := 0;
     fModCount := 0;

end;
{$ENDIF}


destructor tHashTable.destroy;
begin
     clear;
     freeEntryTable(fTable, fCapacity);
     fEntryFactory.free;
     inherited;
end;

procedure tHashTable.clear;
begin
  clearTable(false);
end;

procedure tHashTable.deleteAll;
begin
  clearTable(true);
end;

procedure tHashTable.clearTable(deleteValues : boolean);
var
   idx : integer;
   entry : tHashEntry;
   temp  : tHashEntry;
begin
   for idx := 0 to fCapacity - 1 do begin
       entry := arrayGet(ftable, idx);
       while entry <> nil do begin
           temp := entry;
           entry := entry.next;
           if fOwnKeys then
              temp.key.free;
           if deleteValues then
              temp.value.free;
           temp.free;
       end;
       arrayPut(fTable, idx, nil);
   end;

end;

(************ iterator **************)
constructor tHashTableIterator.create(table : tHashTable);
var i : integer;

begin
   inherited create;

   fHashTable := table;
   fModCount := table.fModCount;

   fIsRemoved := false;
   fCurrent := 0;

   fEntry := nil;
   // get first element
   if fHashTable.count > 0 then
     for i := 0 to fHashTable.fCapacity - 1 do begin
         fEntry := arrayGet(fHashTable.ftable, i);
         if fEntry <> nil then begin
            fIndex := i;
            break;
         end;
     end;
end;


procedure tHashTableIterator.next;
var
   i : integer;
begin
   if fModCount <> fHashtable.fModCount then
      raise exception.create('Iterator no longer valid');

    if fIsRemoved then
       fisRemoved := false
    else if fCurrent < fHashTable.count then begin
       fEntry := fEntry.next;
       if fEntry = nil then
          for i := fIndex + 1 to fHashTable.fCapacity - 1 do
              if arrayGet(fHashTable.fTable, i) <> nil then begin
                 fEntry := arrayGet(fHashTable.fTable, i);
                 fIndex := i;
                 break;
              end;

       if fEntry <> nil then
          inc(fCurrent);
    end;

end;

function tHashTableIterator.isValid : boolean;
begin
     result := fModCount = fHashTable.fModCount;
end;


procedure tHashTableIterator.remove;
var
   oldEntry : tHashEntry;
   i : integer;
begin
   if fModCount <> fHashtable.fModCount then
      raise exception.create('Iterator no longer valid');

  if fIsRemoved or (fEntry = nil) then exit;

  oldEntry := fEntry;

  if fCurrent < fHashTable.count then begin
     fEntry := fEntry.next;
     if fEntry = nil then begin
        for i := fIndex + 1 to fHashTable.fCapacity - 1 do
            if arrayGet(fHashTable.fTable, i) <> nil then begin
               fEntry := arrayGet(fHashTable.fTable, i);
               fIndex := i;
               break;
            end;
     end;
  end;

  fHashTable.remove(oldEntry.key);
  fIsRemoved := true;
  fModCount := fHashTable.fmodCount;

end;


function tHashTableIterator.hasNext : boolean;
begin
   if fModCount <> fHashtable.fModCount then
      raise exception.create('Iterator no longer valid');
   result := (fCurrent < (fHashTable.count - 1)) or (fIsRemoved and (fCurrent < fHashTable.count));
end;

function tHashTableIterator.getKey : tComparable;
begin
   if fModCount <> fHashtable.fModCount then
      raise exception.create('Iterator no longer valid');
   if not (fIsRemoved or (fEntry = nil)) then
      result := fEntry.key
   else
      result := nil;
end;

procedure tHashTableIterator.setValue(avalue : tObject);
(* NOTE! at this point, dealing with the value that is being replaced is the responsibility of the user *)
begin
   if not isValid then
      raise exception.create('Iterator no longer valid');
   if validEntry then
      fEntry.value := avalue
   else
      raise exception.create('The entry is not valid');

end;

function tHashTableIterator.getValue : tObject;
begin
   if fModCount <> fHashtable.fModCount then
      raise exception.create('Iterator no longer valid');
   if not (fIsRemoved or (fEntry = nil)) then
      result := fEntry.value
   else
      result := nil;
end;

function tHashTableIterator.validEntry : boolean;
begin
   if fModCount <> fHashtable.fModCount then
      raise exception.create('Iterator no longer valid');
   result := (fEntry <> nil) and (fCurrent < fHashTable.count) and not fIsRemoved;
end;

end.
