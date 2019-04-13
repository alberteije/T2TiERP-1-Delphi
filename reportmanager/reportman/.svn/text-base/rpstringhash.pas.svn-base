unit rpstringhash;

{$R-}
{$Q-}


(* defines a hash table with string keys *)
(* this class is not derived from tHashTable because method signatures are different,
   but it embeds one *)
(* compatibility with *ix : check cases of unit names *)

interface
uses rphashtable, rpcomparable, sysutils;

type
tStrHashIterator = class(tHashTableIterator)
public
   function getKey : string; reintroduce;

   property key : string read getKey;

//protected
//   constructor create(table : tHashTable);
end;

_StringObjectFactory = class(tObject)
 private
  fCaseSensitive : boolean;
 public
   constructor create(isCaseSensitive : boolean);
   function createObject(value : string) : tString;
 end;

tStringHash = class(tObject)
private
    fHashTable : tHashTable;
    fObjectFactory : _StringObjectFactory;
protected
    procedure fSetValue(key : string; value : tObject); virtual;

public
    function getIterator : tStrHashIterator; virtual;
    function containsKey(key : string) : boolean; virtual;
    function containsValue(value : tObject) : boolean; virtual;
    function getValue(key : string) : tObject; virtual;
    function setValue(key : string; value : tObject) : boolean; virtual;
    function remove(key : string) : tObject; virtual;

    function getCount : integer; virtual;

    property values[key : string] : tObject read getValue write fsetValue;
    property count : integer read getCount;

    {$IFNDEF FPC}
    constructor create(caseSensitive : boolean = false; initialcapacity : integer = 10);
    {$ELSE FPC}
    constructor create;
    constructor create(caseSensitive : boolean);
    constructor create(caseSensitive : boolean; initialcapacity : integer);
    {$ENDIF FPC}

    destructor Destroy; override;

    procedure clear; virtual;
    procedure deleteAll; virtual;
end;

implementation

(* tStrHashIterator - iterator for string hash table *)
(* basically an adapter shell for tMapIterator *)

procedure throwTypeException(className : string);
begin
     raise exception.create('Wrong type. Expecting tString, got ' + className);
end;

function tStrHashIterator.getKey : string;
var
   s : tObject;
begin
     s := inherited getKey;
     if not (s is tString) then
        throwTypeException(s.ClassName);
     result := tString(s).value;
end;




(*
constructor tStrHashIterator.create(iterator : tMapIterator);
begin
     inherited create;
     fIterator := iterator;
end;
*)

(* _StringObjectFactory *)

constructor _StringObjectFactory.create(isCaseSensitive : boolean);
begin
     inherited create;
     fCaseSensitive := isCaseSensitive;
end;
function _StringObjectFactory.createObject(value : string) : tString;
begin
     if fCaseSensitive then
        result := tString.create(value)
     else
        result := tStringNoCase.create(value);
end;

(* tStringHash *)
procedure tStringHash.fSetValue(key : string; value : tObject);
begin
     setValue(key, value);
end;

function tStringHash.getIterator : tStrHashIterator;
begin
     result := tStrHashIterator.create(fHashTable);
end;

function tStringHash.containsKey(key : string) : boolean;
var
   s : tString;
begin
   s := fObjectFactory.createObject(key);
   try
   result := fHashTable.containsKey(s);
   finally
   s.free;
   end;
end;

function tStringHash.containsValue(value : tObject) : boolean;
begin
     result := fHashTable.containsValue(tComparable(value))
end;

function tStringHash.getValue(key : string) : tObject;
var
   s : tString;
begin
  s := fObjectFactory.createObject(key);
  try
    result := fHashTable.getValue(s);
  finally
    s.free;
  end;
end;

function tStringHash.setValue(key : string; value : tObject) : boolean;
begin
    result := fHashTable.setValue(fObjectFactory.createObject(key), value);
end;

function tStringHash.remove(key : string) : tObject;
var
   s : tString;
begin
   s := fObjectFactory.createObject(key);
   try
      result := fHashTable.remove(s);
   finally
      //s.free;
   end;
end;

function tStringHash.getCount : integer;
begin
     result := fHashTable.getCount;
end;


{$IFNDEF FPC}
constructor tStringHash.create(caseSensitive : boolean = false; initialcapacity : integer = 10);
begin
    inherited create;
    fObjectFactory := _StringObjectFactory.create(caseSensitive);
    fHashTable := tHashTable.create(initialcapacity, 0.75);

end;

{$ELSE FPC}

constructor tStringHash.create;
begin
    inherited create;
    fObjectFactory := _StringObjectFactory.create(false);
    fHashTable := tHashTable.create;
end;
constructor tStringHash.create(caseSensitive : boolean);
begin
    inherited create;
    fObjectFactory := _StringObjectFactory.create(caseSensitive);
    fHashTable := tHashTable.create;
end;

constructor tStringHash.create(caseSensitive : boolean; initialcapacity : integer);
begin
    inherited create;
    fObjectFactory := _StringObjectFactory.create(caseSensitive);
    fHashTable := tHashTable.create(initialcapacity, 0.75, nil, true);
end;
{$ENDIF FPC}

destructor tStringHash.destroy;
begin
     fHashTable.free;
     fObjectFactory.free;
     inherited destroy;
end;
procedure tStringHash.clear;
begin
     fHashTable.clear;
end;
procedure tStringHash.deleteAll;
begin
     fHashTable.deleteAll;
end;


end.

