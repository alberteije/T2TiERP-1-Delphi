{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpmunits                                        }
{       Unit conversion to allow international          }
{       designment of reports                           }
{                                                       }
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

// The report units are always in twips that is 1440 twips=1 inchess=2.54 cms

unit rpmunits;

interface

{$I rpconf.inc}

uses rptypes,
sysutils;

const
 CMS_PER_INCHESS=2.54;
 TWIPS_PER_INCHESS=1440;
 POINTS_PER_INCHESS=72;
type
 Trpmunits=(rpUnitcms,rpUnitInchess);

var
 defaultunit:Trpmunits;
 rpunitconversions:array [Low(TrpmUnits)..High(TRpmUnits)] of double;
 rpunitlabels:array [Low(TrpmUnits)..High(TRpmUnits)] of string;
 rpunitformats:array [Low(TrpmUnits)..High(TRpmUnits)] of string;


function gettextfromtwips(twips1:TRptwips):string;
function gettwipsfromtext(atext:string):TRptwips;
function getdefaultunitstring:string;
function twipstoinchess(twips1:TRpTwips):double;
function twipstocms(twips1:TRpTwips):double;

implementation

function gettextfromtwips(twips1:TRptwips):string;
begin
 Result:=FormatFloat(rpunitformats[defaultunit],twips1/rpunitconversions[defaultunit]);
end;

function gettwipsfromtext(atext:string):TRptwips;
begin
 atext:=Trim(atext);
 if Length(atext)<1 then
  Result:=0
 else
  Result:=Round(StrToFloat(atext)*rpunitconversions[defaultunit]);
end;

function getdefaultunitstring:string;
begin
 Result:=rpunitlabels[defaultunit];
end;

function twipstoinchess(twips1:TRpTwips):double;
begin
 Result:=twips1/TWIPS_PER_INCHESS;
end;

function twipstocms(twips1:TRpTwips):double;
begin
 Result:=(twips1/TWIPS_PER_INCHESS)*CMS_PER_INCHESS;
end;



initialization
 defaultunit:=rpUnitcms;
 rpunitconversions[rpUnitcms]:=TWIPS_PER_INCHESS/CMS_PER_INCHESS;
 rpunitlabels[rpUnitcms]:='cms.';
 rpunitformats[rpUnitcms]:='#######0.###';
 rpunitconversions[rpUnitInchess]:=TWIPS_PER_INCHESS;
 rpunitlabels[rpUnitInchess]:='inch.';
 rpunitformats[rpUnitInchess]:='#######0.####';
end.
