unit rpfpcutils;


{$mode delphi}

interface


uses SysUtils;


function FormatFloat(format:string;number:Double):String;
function FormatCurr(format:string;number:Double):String;

implementation

function FormatFloat(format:string;number:Double):String;
begin

 Result:=FloatToStr(number);
end;

function FormatCurr(format:string;number:Double):String;
begin
 Result:=CurrToStr(number);
end;

end.