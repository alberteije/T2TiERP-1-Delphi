unit rpcomparable;


interface

{$I rpconf.inc}

uses sysutils;

{$R-}
{$Q-}

type
 ECompareException = class(Exception);



  (** the base object for collections to operate on
      all item objects should inherit from it (tInteger, tString, etc)
  *)
tComparable = class(tObject)
  protected
       function compareObjects(object2 : tComparable) : integer; virtual; abstract;
  public
       function  hashCode : integer; virtual; abstract;
       function compareTo(object2 : tComparable) : integer;
  end;


  (* ************************ CLASSES FOR PRIMITIVE TYPES ******************)


  (** Derive all numeric classes from here *)
tNumeric = class(tComparable)
  protected
       function compareObjects(object2 : tComparable) : integer; override;
  public
        function asDouble : double; virtual; abstract;
  end;

tInteger = class(tNumeric)
  protected
        fValue : integer;
  public
        property value : integer read fValue write fValue;
        function hashCode : integer; override;
        constructor create(val : integer);
        function asDouble : double; override;
  end;

tDouble = class(tNumeric)
  protected
         fValue : Double;
         fHashCode : integer;

         procedure setValue(value : double);
  public
        property value : double read fValue write setValue;
        function hashCode : integer; override;
        constructor create(val : double);
        function asDouble : double; override;
  end;

tString = class(tComparable)
  protected
        fValue : string;
        fHashCode  : integer;

        procedure setValue(value : string);
        function compareObjects(object2 : tComparable) : integer; override;
  public
        property value : string read fValue write setvalue;
        function hashCode : integer; override;
        constructor create(val : string);
  end;

tStringNoCase = class(tString)
  protected
       function compareObjects(object2 : tComparable) : integer; override;
  end;



function equal(obj1, obj2 : tComparable) : boolean;
function compare(Item1, Item2 : tComparable) : integer;

procedure throwComparableException(obj : tComparable; targetClass : tClass);

implementation

procedure throwComparableException(obj : tComparable; targetClass : tClass);
begin
     if not (obj is targetClass) then
        raise ECompareException.create(targetClass.ClassName + ' cannot be compared with ' + obj.className);
end;

(* ************ tComparable ************** *)
function tComparable.compareTo(object2 : tComparable) : integer;
begin
   if object2 = nil then
      result := -1
   else
      result := self.compareObjects(object2);

end;

(* ************* tNumeric *************** *)
function tNumeric.compareObjects(object2 : tComparable) : integer;
var
   otherDouble : double;
begin
     throwComparableException(object2, tNumeric);
     otherDouble := tNumeric(object2).asDouble;
     if asDouble > otherDouble then
        result := 1
     else if asDouble < otherDouble then
        result := -1
     else result := 0;
end;
(* ********** tInteger ************ *)
function tInteger.hashCode : integer;
(* make sure hash is never 0 so that it's different for nulls - I don't even know why :) *)
begin
     if fValue >= 0 then
        result := fValue + 1
     else
        result := fValue;
end;


constructor tInteger.create(val : integer);
begin
     inherited create;
     value := val;
end;

function tInteger.asDouble : double;
begin
     result := value;
end;


(* *********** tDouble ******************* *)
procedure tDouble.setValue(value : double);
begin
    fValue := value;

    // calculate hash code
    while (value * 10) < maxint do
          value := value * 10;
    while value > maxInt do
          value := value / 10;

    fHashCode := round(value);
end;

function tDouble.hashCode : integer;
begin
   result := fHashCode;
end;


constructor tDouble.create(val : double);
begin
     inherited create;
     value := val;
end;

function tDouble.asDouble : double;
begin
    result := value;
end;

(* tStringNoCase *)

function tStringNoCase.compareObjects(object2 : tComparable) : integer;
begin
    throwComparableException(object2, tString);
    result := CompareText(value, tString(object2).value);
end;


(* **************** tString ****************** *)

function tString.compareObjects(object2 : tComparable) : integer;
begin
     throwComparableException(object2, tString);

     result := CompareStr(value, tString(object2).value);
end;


procedure tString.setValue(value : string);
var
   h, i : integer;
begin
     fValue := value;

     // calculate hash code

     h := 0;
     for i := 1 to length(value) do
         h := h * 31 + integer(value[i]);
     fHashCode := h;
end;

function tString.hashCode : integer;
begin
     result := fHashCode;
end;


constructor tString.create(val : string);
begin
     inherited create;
     value := val;
end;



(* ************ FUNCTIONS *************** *)
function equal(obj1, obj2 : tComparable) : boolean;
begin
     if ((obj1 = nil) and (obj2 = nil)) or (obj1 = obj2) then
        result := true
     else if obj1 = nil then
        result := false
     else
        result := (obj1.classType = obj2.classType) and (obj1.compareto(obj2) = 0);
end;

function compare(Item1, Item2 : tComparable) : integer;
begin
     if ((Item1 = nil) and (Item2 = nil)) or (Item1 = Item2) then
        result := 0
     else if item1 = nil then
        result := -1
     else
        result := item1.compareTo(item2);
end;



end.
