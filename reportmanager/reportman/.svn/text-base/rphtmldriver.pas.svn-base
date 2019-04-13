{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rphtmldriver                                    }
{       Exports a metafile to HTML CSS                  }
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

// To do, provide page breaks using <p style="page-break-before: always">


unit rphtmldriver;

interface

{$I rpconf.inc}

uses
 Classes,sysutils,rpmetafile,rpmdconsts,
 rpmunits,rppdffile,
{$IFDEF USEVARIANTS}
 types,Variants,
{$ENDIF}
{$IFNDEF FORWEBAX}
 rpbasereport,rppdfdriver,
{$ENDIF}
 rptypes;



function ExportMetafileToHtml (metafile:TRpMetafileReport;caption,filename:string;
 showprogress,allpages:boolean; frompage,topage:integer):boolean;
function ExportMetafileToHtmlSingle (metafile:TRpMetafileReport; caption,filename:string):boolean;
function MetafilePageToHtml(metafile:TRpMetafileReport;index:integer;Stream:TStream;caption,filename:String):boolean;
function ColorToHTMLColor(color:integer):String;
{$IFNDEF FORWEBAX}
procedure ExportReportToHtml(report:TRpBaseReport;filename:String;progress:Boolean);
procedure ExportReportToHtmlSingle(report:TRpBaseReport;filename:String);
{$ENDIF}

implementation

function TwipsToPoints(twips:Int64):integer;
var
 sizepoints:double;
begin
 sizepoints:=twips*72/1440;
 Result:=Round(sizepoints);
end;

function TwipsToPX(twips:Int64):String;
var
 sizepoints:double;
begin
 sizepoints:=twips*72/1440;
 // Adjust size beacuse IE custom sizing?
 sizepoints:=sizepoints*1.3;
 Result:=IntToStr(Round(sizepoints));
end;

function ColorToHTMLColor(color:integer):String;
var
 acolor:string;
begin
 acolor:=Format('%.8x', [Color]);
 Result:='#'+Copy(acolor,7,2)+Copy(acolor,5,2)+Copy(acolor,3,2);
end;

const
 AlignmentFlags_SingleLine=64;
 AlignmentFlags_AlignHCenter = 4 { $4 };
 AlignmentFlags_AlignHJustify = 1024 { $400 };
 AlignmentFlags_AlignTop = 8 { $8 };
 AlignmentFlags_AlignBottom = 16 { $10 };
 AlignmentFlags_AlignVCenter = 32 { $20 };
 AlignmentFlags_AlignLeft = 1 { $1 };
 AlignmentFlags_AlignRight = 2 { $2 };


function TextToHtml(astring:String):String;
begin
 astring:=RpHtmlEncode(astring);
 astring:=StringReplace(astring,#10,'<br/>',[rfReplaceall]);
 astring:=StringReplace(astring,#13,'',[rfReplaceall]);
 Result:=astring;
end;


function ObjectToStyle(page:TRpMetafilePage;obj:TRpMetaObject):String;
begin
 Result:='{ ';
 case obj.Metatype of
  rpMetaText:
   begin
    Result:=Result+'FONT-FAMILY:"'+page.GetWFontName(obj)+'","'+
     page.GetLFontName(obj)+'";';
    Result:=Result+'COLOR:'+ColorToHTMLColor(obj.FontColor)+';';
    if obj.Transparent then
     Result:=Result+'BACKGROUND-COLOR:TRANSPARENT;'
    else
     Result:=Result+'BACKGROUND-COLOR:'+ColorToHTMLColor(obj.BackColor)+';';

    Result:=Result+'FONT-SIZE:'+IntToStr(obj.FontSize)+'PT;';
    if ((obj.Fontstyle and 1)>0) then
     Result:=Result+'FONT-WEIGHT:BOLD;'
    else
     Result:=Result+'FONT-WEIGHT:NORMAL;';
    if (obj.Fontstyle and (1 shl 1))>0 then
     Result:=Result+'FONT-STYLE:ITALIC;'
    else
     Result:=Result+'FONT-STYLE:NORMAL;';
    if (obj.FontStyle and (1 shl 2))>0 then
     Result:=Result+'TEXT-DECORATION:UNDERLINE;';
     if (obj.FontStyle and (1 shl 3))>0 then
      Result:=Result+'TEXT-DECORATION:LINE-THROUGHT;'
     else
      Result:=Result+'TEXT-DECORATION:NONE;';
   end;
  rpMetaDraw:
   begin
   end;
  rpMetaImage:
   begin
   end;
 end;
 Result:=Result+'}';
end;

function ObjectToHtmlText(apage:TrpMetafilePage;pageindex:integer;obj:TRpMetaObject;filename:string;index:integer;embedimages:boolean):String;
var
 imafilename:String;
 format:string;
 fimagestream:TMemoryStream;
 indexed:boolean;
 bitmapwidth,bitmapheight,imagesize:Integer;
 palette:string;
 bitsperpixel,numcolors,nwidth,nheight:integer;
 fileext:string;
begin
 Result:='';
 case obj.Metatype of
  rpMetaText:
   begin
    Result:=TextToHtml(apage.GetText(obj));
   end;
  rpMetaDraw:
   begin
   end;
  rpMetaImage:
   begin
    fileext:='';
    // Saves the object as objectindex
    try
     imafilename:=ChangeFileExt(filename,'');
     imafilename:=imafilename+'page'+IntToStr(pageindex)+'obj'+IntToStr(index);
     // Get information and save the image
     fimagestream:=apage.GetStream(obj);
     format:='';
      GetJPegInfo(fimagestream,bitmapwidth,bitmapheight,format);
      if (format='JPEG') then
      begin
       // Read image dimensions
       imafilename:=ChangeFileExt(imafilename,'.jpg');
       fileext:='jpg';
      end
      else
      begin
       fimagestream.Seek(0,soFromBeginning);
       if (format='BMP') then
       begin
        GetBitmapInfo(fimagestream,bitmapwidth,bitmapheight,imagesize,nil,indexed,bitsperpixel,numcolors,palette);
        imafilename:=ChangeFileExt(imafilename,'.bmp');
        fileext:='bmp';
       end
       else
       begin
        // Al otther formats
       end
      end;
      fimagestream.Seek(0,soFromBeginning);
      if (embedimages) then
      begin
{$IFDEF USEINDY}
       imafilename:='data:image/'+fileext+';base64,'+MIMEEncodeString(fimagestream);
{$ENDIF}
{$IFNDEF USEINDY}
       raise Exception.Create('Embedding images in html not supported, compilation option USEINDY disabled');
{$ENDIF}
      end
      else
      begin
       fimagestream.SaveToFile(imafilename);
      end;
      nwidth:=obj.Width;
      nheight:=obj.Height;
      case TRpImageDrawStyle(obj.DrawImageStyle) of
       rpDrawFull:
        begin
         nwidth:=round(bitmapwidth/obj.dpires*1440);
         nheight:=round(bitmapheight/obj.dpires*1440);
        end;
       rpDrawTile,rpDrawTiledpi:
        imafilename:='';
      end;
      if Length(imafilename)>0 then
      begin
       Result:='<IMG SRC="'+imafilename+'" HEIGHT='+TwipsToPX(nHeight)+'PX '+
        ' WIDTH='+TwipsToPX(nWidth)+'PX'+' BORDER=0>';
      end;
//     Result:='<IMG SRC="'+imafilename+'" HEIGHT='+IntToStr(bitmapheight)+
//      ' WIDTH='+IntToStr(bitmapwidth)+' BORDER=0>';
    except
     // Omit image processing errors?
     on E:Exception do
     begin
      Result:=TextToHtml(E.Message);
     end;
    end;
   end;
 end;
end;



function TwipsToIntPX(twips:Integer):Int64;
var
 sizepoints:double;
begin
 sizepoints:=twips*72/1440;
 // Adjust size beacuse IE custom sizing?
 sizepoints:=sizepoints*1.3;
 Result:=Round(sizepoints);
end;

const
 DEFAULT_DPI=96;

function ObjectBounds(page:TRpMetafilePage;pageindex:integer;obj:TRpMetaObject;filename:String;index:integer;yoffset:Int64;embedimages:boolean):String;
var
 penwidth:integer;
 dtype:TRpShapeType;
 nwidth,nheight:integer;
 format:string;
 fimagestream:TMemoryStream;
 indexed:boolean;
 bitmapwidth,bitmapheight,imagesize:Integer;
 palette:string;
 bitsperpixel,numcolors:integer;
 imafilename:String;
 fileext:string;
begin
 Result:='';
 case obj.Metatype of
  rpMetaText:
   begin
    Result:='"';
    Result:=Result+'left:'+TwipsToPX(obj.Left)+'PX;'+
    'top:'+TwipsToPX(obj.Top+yoffset)+'PX;'+
    'width:'+TwipsToPX(obj.Width)+'PX;'+
    'height:'+TwipsToPX(obj.Height)+'PX;';
    if  ((obj.Alignment AND AlignmentFlags_AlignRight)>0) then
     Result:=Result+'text-align:right;'
    else
     if (obj.Alignment AND AlignmentFlags_AlignHCenter)>0 then
      Result:=Result+'text-align:center;'
     else
      if  ((obj.Alignment AND AlignmentFlags_AlignHJustify)>0) then
       Result:=Result+'text-align:justify;'
      else
       Result:=Result+'text-align:left;';
    if (obj.AlignMent AND AlignmentFlags_AlignBottom)>0 then
     Result:=Result+'vertical-align:bottom;'
    else
     if (obj.AlignMent AND AlignmentFlags_AlignVCenter)>0 then
      REsult:=Result+'vertical-align:middle;';
    Result:=Result+'"';
   end;
  rpMetaDraw:
   begin
    dtype:=TRpShapeType(obj.DrawStyle);
    penwidth:=TwipsToPoints(obj.PenWidth);
    if (penwidth<1) then
     penwidth:=1;
    case dtype of
     rpsRectangle:
      begin
       Result:='"';
       Result:=Result+'left:'+TwipsToPX(obj.Left)+'PX;'+
        'top:'+TwipsToPX(obj.Top+yoffset)+'PX;';
       Result:=Result+'width:'+TwipsToPX(obj.Width)+'PX;';
       Result:=Result+'height:'+TwipsToPX(obj.Height)+'PX;';
       if obj.PenStyle<>5 then
       begin
        Result:=Result+'BORDER-STYLE:SOLID;';
        Result:=Result+'BORDER-COLOR:'+ColorToHTMLColor(obj.PenColor)+';';
        Result:=Result+'BORDER-WIDTH:'+IntToStr(penwidth)+'PX;';
       end;
       if obj.BrushStyle=1 then
        Result:=Result+'BACKGROUND-COLOR:TRANSPARENT;'
       else
        Result:=Result+'BACKGROUND-COLOR:'+ColorToHTMLColor(obj.BrushColor)+';';
       Result:=Result+'"';
      end;
     rpsHorzLine:
      begin
       Result:='"';
       Result:=Result+'left:'+TwipsToPX(obj.Left)+'PX;'+
        'top:'+TwipsToPX(obj.Top+yoffset)+'PX;';
       Result:=Result+'width:'+TwipsToPX(obj.Width)+'PX;';
       Result:=Result+'height:1PX;';
       if obj.PenStyle<>5 then
       begin
        Result:=Result+'BORDER-TOP:'+IntToStr(penwidth)+'PX SOLID '+ColorToHTMLColor(obj.PenColor)+';';
       end;
       Result:=Result+'"';
      end;
     rpsVertLine:
      begin
       Result:='"';
       Result:=Result+'left:'+TwipsToPX(obj.Left)+'PX;'+
        'top:'+TwipsToPX(obj.Top+yoffset)+'PX;';
       Result:=Result+'width:1PX;';
       Result:=Result+'height:'+TwipsToPX(obj.Height)+'PX;';
       if obj.PenStyle<>5 then
       begin
        Result:=Result+'BORDER-LEFT:'+IntToStr(penwidth)+'PX SOLID '+ColorToHTMLColor(obj.PenColor)+';';
       end;
       Result:=Result+'"';
      end;
    end;
   end;
  rpMetaImage:
   begin
    Result:='"';
    Result:=Result+'left:'+TwipsToPX(obj.Left)+'PX;'+
    'top:'+TwipsToPX(obj.Top+yoffset)+'PX;';
    nwidth:=obj.Width;
    nheight:=obj.Height;
    imafilename:=ChangeFileExt(filename,'');
    imafilename:=imafilename+'page'+IntToStr(pageindex)+'obj'+IntToStr(index);
    fimagestream:=page.GetStream(obj);
    format:='';
    GetJPegInfo(fimagestream,bitmapwidth,bitmapheight,format);
    if format='JPEG' then
    begin
      imafilename:=ChangeFileExt(imafilename,'.jpg');
      fileext:='jpg';
    end
    else
    begin
     // Read image dimensions
     fimagestream.Seek(0,soFromBeginning);
     if (format='BMP') then
     begin
       GetBitmapInfo(fimagestream,bitmapwidth,bitmapheight,imagesize,nil,indexed,bitsperpixel,numcolors,palette);
       imafilename:=ChangeFileExt(imafilename,'.bmp');
       fileext:='bmp';
     end
     else
     begin
      // All other formats
     end;
    end;
    case TRpImageDrawStyle(obj.DrawImageStyle) of
     rpDrawFull:
      begin
       nwidth:=round(bitmapwidth/obj.dpires*1440);
       nheight:=round(bitmapheight/obj.dpires*1440);
      end;
     rpDrawTile,rpDrawTiledpi:
      begin
       if (embedimages) then
       begin
{$IFDEF USEINDY}
        imafilename:='data:image/'+fileext+';base64,'+MIMEEncodeString(fimagestream);
{$ENDIF}
{$IFNDEF USEINDY}
        raise Exception.Create('Embedding images in html not supported, compilation option USEINDY disabled');
{$ENDIF}
       end;
       Result:=Result+'background-image:url('+imafilename+');';
      end;
    end;
    Result:=Result+'width:'+TwipsToPX(nwidth)+'PX;'+
     'height:'+TwipsToPX(nheight)+'PX;';
    Result:=Result+'"';
   end;
 end;
end;


procedure ExportPageToHtml(metafile:TRpMetafileReport;page:TrpMetafilePage;pageindex:integer;Stream:TStream;caption,filename:String);
var
 astring:String;
 pstyles:array of Integer;
 astyle:String;
 pstyledescriptions:TStringList;
 i,index:integer;
 singleline:Boolean;
begin
 astring:='<HTML>';
 if page.ObjectCount>0 then
 begin
  astring:=astring+LINE_FEED+'<STYLE>';
  astring:=astring+LINE_FEED+'.pg{position:absolute;top:0px;left:0px;height:'+
   twipstopx(metafile.CustomY)+'px;width:'+twipstopx(metafile.CustomX)+'px;}';
  astring:=astring+LINE_FEED+'DIV {position:absolute}';
  SetLength(pstyles,page.ObjectCount);
  pstyledescriptions:=TStringList.Create;
  try
   // Generates a style for each report component
   pstyledescriptions.Sorted:=true;
   for i:=0 to page.ObjectCount-1 do
   begin
    astyle:=ObjectToStyle(page,page.Objects[i]);
    index:=pstyledescriptions.IndexOf(astyle);
    if index>=0 then
     pstyles[i]:=Integer(pstyledescriptions.Objects[index])
    else
    begin
     astring:=astring+LINE_FEED+'.fc'+IntToStr(i)+' '+
      astyle;
     pstyledescriptions.AddObject(astyle,TObject(i));
     pstyles[i]:=i;
    end;
   end;
  finally
   pstyledescriptions.free;
  end;
  astring:=astring+LINE_FEED+'</STYLE>';
 end;
 astring:=astring+LINE_FEED+'<TITLE>'+TextToHtml(Caption)+'</TITLE>';
 if page.ObjectCount>0 then
 begin
  astring:=astring+LINE_FEED+'<BODY  BGCOLOR="'+
   ColorToHTMLColor(metafile.BackColor)   +'" LEFTMARGIN=0 TOPMARGIN=0 BOTTOMMARGIN=0 RIGHTMARGIN=0>';
  // This line defines the page size
  //astring:=astring+LINE_FEED+'<DIV CLASS="pg"></DIV>';
  for i:=0 to page.ObjectCount-1 do
  begin
   singleline:=(page.Objects[i].Alignment AND AlignmentFlags_SingleLine)>0;
   astring:=astring+LINE_FEED+'<DIV style='+
    ObjectBounds(page,pageindex,page.Objects[i],filename,i,0,false)+
    '><span class="fc'+IntToStr(pstyles[i])+'">';
   if singleline then
    astring:=astring+'<NOBR>';
   astring:=astring+ObjectToHtmlText(page,pageindex,page.Objects[i],filename,i,false);
   if singleline then
    astring:=astring+'</NOBR>';
   astring:=astring+'</span></DIV>';
  end;
  astring:=astring+LINE_FEED+'</BODY>';
 end;
 astring:=astring+LINE_FEED+'</HTML>';
 WriteStringToStream(astring,stream);
end;


procedure ExportPagesToHtml(metafile:TRpMetafileReport;Stream:TStream;caption,filename:String);
var
 astring:String;
 pstyles:array of Integer;
 astyle:String;
 pstyledescriptions:TStringList;
 i,p,index:integer;
 singleline:Boolean;
 page:TrpMetafilePage;
 currentposy:Int64;
 objid,objcount:integer;
begin
 astring:='<HTML>';
  astring:=astring+LINE_FEED+'<STYLE>';
 astring:=astring+LINE_FEED+'.pg{position:absolute;top:'+
  '0px;left:0px;height:'+
  twipstopx(metafile.CustomY*metafile.CurrentPageCount)+'px;width:'+twipstopx(metafile.CustomX)+'px;}';
 astring:=astring+LINE_FEED+'DIV {position:absolute}';
 SetLength(pstyles,100);
 objcount:=100;
 objid:=0;
 pstyledescriptions:=TStringList.Create;
 try
  // Generates a style for each report component
  pstyledescriptions.Sorted:=true;
  for p:=0 to metafile.CurrentPageCount -1 do
  begin
   page:=metafile.Pages[p];
   if page.ObjectCount>0 then
   begin
    for i:=0 to page.ObjectCount-1 do
    begin
     astyle:=ObjectToStyle(page,page.Objects[i]);
     index:=pstyledescriptions.IndexOf(astyle);
     if index>=0 then
      pstyles[objid]:=Integer(pstyledescriptions.Objects[index])
     else
     begin
      astring:=astring+LINE_FEED+'.fc'+IntToStr(i)+' '+
       astyle;
      pstyledescriptions.AddObject(astyle,TObject(i));
      pstyles[objid]:=i;
     end;
     inc(objid);
     if (objid>(objcount-2)) then
     begin
      objcount:=objcount*2;
      SetLength(pstyles,objcount);
     end;
    end;
   end;
  end;
 finally
   pstyledescriptions.free;
  end;
 astring:=astring+LINE_FEED+'</STYLE>';
 astring:=astring+LINE_FEED+'<TITLE>'+TextToHtml(Caption)+'</TITLE>';
 astring:=astring+LINE_FEED+'<BODY  BGCOLOR="'+
  ColorToHTMLColor(metafile.BackColor)   +'" LEFTMARGIN=0 TOPMARGIN=0 BOTTOMMARGIN=0 RIGHTMARGIN=0>';
 currentposy:=0;
 objid:=0;
 for p:=0 to metafile.CurrentPageCount -1 do
 begin
  page:=metafile.Pages[p];
  if page.ObjectCount>0 then
  begin
   // This line defines the page size
   //astring:=astring+LINE_FEED+'<DIV CLASS="pg"></DIV>';
   for i:=0 to page.ObjectCount-1 do
   begin
    singleline:=(page.Objects[i].Alignment AND AlignmentFlags_SingleLine)>0;
    astring:=astring+LINE_FEED+'<DIV style='+
     ObjectBounds(page,p,page.Objects[i],filename,i,currentposy,true)+
     '><span class="fc';
    astring:=astring+IntToStr(pstyles[objid])+'">';
    inc(objid);
    if singleline then
     astring:=astring+'<NOBR>';
    astring:=astring+ObjectToHtmlText(page,p,page.Objects[i],filename,i,true);
    if singleline then
     astring:=astring+'</NOBR>';
    astring:=astring+'</span></DIV>';
   end;
  end;
  currentposy:=currentposy+metafile.CustomY;
//  astring:=astring+'<DIV style="page-break-after:allways">';
//  astring:=astring+'</DIV>';
 end;
 astring:=astring+LINE_FEED+'</BODY>';
 astring:=astring+LINE_FEED+'</HTML>';
 WriteStringToStream(astring,stream);
end;


(*procedure ExportPagesToHtml(metafile:TRpMetafileReport;Stream:TStream;caption,filename:String);
var
 astring:String;
 pstyles:array of Integer;
 astyle:String;
 pstyledescriptions:TStringList;
 i,p,index:integer;
 singleline:Boolean;
 page:TrpMetafilePage;
 currentposy:LongInt;
begin
 currentposy:=0;
 astring:='<HTML>';
 for p:=0 to metafile.CurrentPageCount -1 do
 begin
 page:=metafile.Pages[p];
 if page.ObjectCount>0 then
 begin
  astring:=astring+LINE_FEED+'<STYLE>';
  astring:=astring+LINE_FEED+'.pg{position:absolute;top:'+
   twipstopx(currentposy)+'px;left:0px;height:'+
   twipstopx(metafile.CustomY)+'px;width:'+twipstopx(metafile.CustomX)+'px;}';
  astring:=astring+LINE_FEED+'DIV {position:absolute}';
  currentposy:=currentposy+metafile.CustomY;
  SetLength(pstyles,page.ObjectCount);
  pstyledescriptions:=TStringList.Create;
  try
   // Generates a style for each report component
   pstyledescriptions.Sorted:=true;
   for i:=0 to page.ObjectCount-1 do
   begin
    astyle:=ObjectToStyle(page,page.Objects[i]);
    index:=pstyledescriptions.IndexOf(astyle);
    if index>=0 then
     pstyles[i]:=Integer(pstyledescriptions.Objects[index])
    else
    begin
     astring:=astring+LINE_FEED+'.fc'+IntToStr(i)+' '+
      astyle;
     pstyledescriptions.AddObject(astyle,TObject(i));
     pstyles[i]:=i;
    end;
   end;
  finally
   pstyledescriptions.free;
  end;
  astring:=astring+LINE_FEED+'</STYLE>';
 end;
 astring:=astring+LINE_FEED+'<TITLE>'+TextToHtml(Caption)+'</TITLE>';
 if page.ObjectCount>0 then
 begin
  astring:=astring+LINE_FEED+'<BODY  BGCOLOR="'+
   ColorToHTMLColor(metafile.BackColor)   +'" LEFTMARGIN=0 TOPMARGIN=0 BOTTOMMARGIN=0 RIGHTMARGIN=0>';
  // This line defines the page size
  //astring:=astring+LINE_FEED+'<DIV CLASS="pg"></DIV>';
  for i:=0 to page.ObjectCount-1 do
  begin
   singleline:=(page.Objects[i].Alignment AND AlignmentFlags_SingleLine)>0;
   astring:=astring+LINE_FEED+'<DIV style='+
    ObjectBounds(page,page.Objects[i],filename,i,currentposy)+
    '><span class="fc'+IntToStr(pstyles[i])+'">';
   if singleline then
    astring:=astring+'<NOBR>';
   astring:=astring+ObjectToHtmlText(page,p,page.Objects[i],filename,i);
   if singleline then
    astring:=astring+'</NOBR>';
   astring:=astring+'</span></DIV>';
  end;
  astring:=astring+LINE_FEED+'</BODY>';
 end;
 end;
 astring:=astring+LINE_FEED+'</HTML>';
 WriteStringToStream(astring,stream);
end;
*)
function ExportMetafileToHtml (metafile:TRpMetafileReport; caption,filename:string;
 showprogress,allpages:boolean; frompage,topage:integer):boolean;
var
 i:integer;
 oldext,nfilename:String;
 astream:TMemoryStream;
begin
 if allpages then
 begin
  metafile.RequestPage(MAX_PAGECOUNT);
  frompage:=0;
  topage:=metafile.CurrentPageCount-1;
 end
 else
 begin
  frompage:=frompage-1;
  topage:=topage-1;
  metafile.RequestPage(topage);
  if topage>metafile.CurrentPageCount-1 then
   topage:=metafile.CurrentPageCount-1;
 end;
 oldext:=ExtractFileExt(filename);
 for i:=frompage to topage do
 begin
  astream:=TMemoryStream.Create;
  try
   ExportPageToHtml(metafile,metafile.Pages[i],i,astream,caption,filename);
   nfilename:=ChangeFileExt(filename,'');
   nfilename:=nfilename+IntToStr(i);
   nfilename:=ChangeFileExt(nfilename,oldext);
   astream.Seek(0,soFromBeginning);
   astream.SaveToFile(nfilename);
  finally
   astream.free;
  end;
 end;
 Result:=true;
end;

function ExportMetafileToHtmlSingle (metafile:TRpMetafileReport; caption,filename:string):boolean;
var
 oldext:String;
 astream:TFileStream;
begin
 metafile.RequestPage(MAX_PAGECOUNT);
 oldext:=ExtractFileExt(filename);
 astream:=TFileStream.Create(filename,fmCreate);
 try
  ExportPagesToHtml(metafile,astream,caption,filename);
 finally
  astream.free;
 end;
 Result:=true;
end;


function MetafilePageToHtml(metafile:TRpMetafileReport;index:integer;Stream:TStream;caption,filename:String):boolean;
begin
 ExportPageToHtml(metafile,metafile.pages[index],index,stream,Caption,filename);
 Result:=true;
end;

{$IFNDEF FORWEBAX}
procedure ExportReportToHtml(report:TRpBaseReport;filename:String;progress:Boolean);
var
 pdfdriver:TRpPDFDriver;
 apdfdriver:TRpPrintDriver;
 oldprogres:TRpProgressEvent;
 astream:TMemoryStream;
 oldtwopass:boolean;
begin
 pdfdriver:=TRpPDFDriver.Create;
 pdfdriver.compressed:=true;
 astream:=TMemoryStream.Create;
 try
  pdfdriver.DestStream:=aStream;
  apdfdriver:=pdfdriver;
  // If report progress must print progress
  oldprogres:=report.OnProgress;
  try
   if progress then
    report.OnProgress:=pdfdriver.RepProgress;
   oldtwopass:=report.TwoPass;
   try
    report.TwoPass:=true;
    report.PrintAll(apdfdriver);
    ExportMetafileToHtml(report.metafile,filename,filename,true,true,1,MAX_PAGECOUNT);
   finally
    report.TwoPass:=oldtwopass;
   end;
  finally
   report.OnProgress:=oldprogres;
  end;
 finally
  astream.free;
 end;
end;

procedure ExportReportToHtmlSingle(report:TRpBaseReport;filename:String);
var
 pdfdriver:TRpPDFDriver;
 oldprogres:TRpProgressEvent;
 astream:TMemoryStream;
 oldtwopass:boolean;
 oldpagesize:TRpPageSize;
 oldwidth,oldheight:integer;
begin
 pdfdriver:=TRpPDFDriver.Create;
 pdfdriver.compressed:=true;
 astream:=TMemoryStream.Create;
 try
  pdfdriver.DestStream:=aStream;
  // If report progress must print progress
  oldprogres:=report.OnProgress;
  try
  oldtwopass:=report.TwoPass;
   oldpagesize:=report.Pagesize;
   oldwidth:=report.CustomPageWidth;
   oldheight:=report.CustomPageHeight;
   try
    report.TwoPass:=true;
     report.Pagesize:=rpPageSizeUser;
     // Maximum of aprox 25000 A4 pages
     if (report.PrinterFonts=rppfontsrecalculate) then
        report.CustomPageHeight:=TWIPS_PER_INCHESS*100000;
     report.PrintAll(pdfdriver);
     if (report.Metafile.CurrentPageCount=1) then
     begin
      // For only one page shorts the page to maximum printed
      // area
      report.Metafile.CustomY:=report.maximum_height;
      report.Metafile.CustomX:=report.maximum_width;
     end;
     ExportMetafileToHtmlSingle(report.metafile,filename,filename);
   finally
    report.Pagesize:=oldpagesize;
    report.CustomPageWidth:=oldwidth;
    report.CustomPageHeight:=oldheight;
    report.TwoPass:=oldtwopass;
   end;
  finally
   report.OnProgress:=oldprogres;
  end;
 finally
  astream.free;
 end;
end;


{$ENDIF}

end.

