{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpwebmetaclient                                 }
{       Metafile reading and printing                   }
{       From a http address                             }
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

// Install lang boolean
// Language install

unit rpwebmetaclient;


interface

{$I rpconf.inc}

uses classes,SysUtils,Windows,graphics,controls,forms,
 rptypes,
{$IFDEF USEVARIANTS}
 Types,
{$ENDIF}
 rpmetafile,rpfmainmetaviewvcl,rpmdconsts,SyncObjs,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
 rpgdidriver,rpmdprintconfigvcl,rpmdshfolder,IdThreadComponent,
 rpfmetaviewvcl,IdSync,rpvgraphutils,IdSSLOpenSSL;

const
 READ_TIMEOUT=10000;
type
 TRpWebMetaPrint=class(TCustomControl)
  private
   FSSL:boolean;
   abyte:array of byte;
   FFinished:Boolean;
   FCaption:WideString;
   FPrinterConfig:Boolean;
   FFontName:String;
   FFontSize:integer;
   FMetaUrl:String;
   FPort:integer;
   FPreview:Boolean;
   FInstall:Boolean;
   FShowProgress:Boolean;
   FShowPrintDialog:Boolean;
   FCopies:Integer;
   errormessage:String;
   FAsyncRead:Boolean;
   FNewStream,FStream:TMemoryStream;
   readcount:integer;
   idthreadcomp: TIdThreadComponent;
   aborting:boolean;
   connect:TIdHttp;
   metafile:TrpMetafileReport;
   FStreamSize:Integer;
   procedure DoInstall;
   procedure SetCaption(Value:WideString);
   procedure OnRequestData(Sender:TObject;count:integer);
   procedure connectWorkEnd(Sender: TObject;
    AWorkMode: TWorkMode);
{$IFNDEF INDY10_2}
{$IFNDEF INDY10}
   procedure idthreadcompRun(Sender: TIdCustomThreadComponent);
   procedure connectWork(Sender: TObject; AWorkMode:TWorkMode;const AWorkCount:Integer);
{$ENDIF}
{$IFDEF INDY10}
   procedure idthreadcompRun(Sender: TIdThreadComponent);
   procedure connectWork(Sender: TObject; AWorkMode: TWorkMode;
    AWorkCount: Integer);
{$ENDIF}
{$ENDIF}
{$IFDEF INDY10_2}
   procedure idthreadcompRun(Sender: TIdThreadComponent);
   procedure connectWork(Sender: TObject; AWorkMode:TWorkMode;AWorkCount:Int64);
{$ENDIF}
  protected
   procedure Paint;override;
  public
   aForm:TWinControl;
   Meta:TFRpMetaVCL;
   property StreamSize:integer read FStreamSize;
   constructor Create(AOwner:TComponent);override;
   destructor Destroy;override;
   procedure Execute;
  published
   property Left;
   property Top;
   property Width;
   property Height;
   property Install:Boolean read FInstall write FInstall;
   property PrinterConfig:Boolean read FPrinterConfig write FPrinterConfig;
   property Caption:WideString read FCaption write SetCaption;
   property MetaUrl:String read FMetaUrl write FMetaUrl;
   property Port:integer read FPort write FPort default 90;
   property SSL:boolean read FSSL write FSSL default false;
   property FontSize:Integer read FFontSize write FFontSize default 0;
   property FontName:String read FFontName write FFontName;
   property Preview:Boolean read FPreview write FPreview default false;
   property AsyncRead:Boolean read FAsyncRead write FAsyncRead default false;
   property Copies:Integer read FCopies write FCopies default 1;
   property ShowProgress:Boolean read FShowProgress write FShowProgress
    default true;
   property ShowPrintDialog:Boolean read FShowPrintDialog
    write FShowPrintDialog default false;
  end;
{$IFDEF DELPHI2007UP}
  TIdSSLIOHandlerSocket=class(TIdSSLIOHandlerSocketOpenSSL);
{$ENDIF}

procedure PrintHttpReport(httpstring:String;usessl:boolean=false);



implementation




procedure TRpWebMetaPrint.Execute;
var
 frompage,topage,copies:integer;
 allpages,collate:boolean;
 rpPageSize:TPageSizeQt;
 okselected:Boolean;
 pconfig:TPrinterConfig;
begin
 FStreamSize:=0;
 GetDefaultDocumentProperties;
 errormessage:='';
 try
  if FPrinterconfig then
  begin
   ShowPrintersConfiguration;
  end
  else
  if install then
  begin
   DoInstall;
  end
  else
  begin
   readcount:=0;
   if Assigned(FNewStream) then
   begin
    FNewStream.free;
    FNewStream:=nil;
   end;
   if Assigned(FStream) then
   begin
    FStream.free;
    FStream:=nil;
   end;
   FNewStream:=TMemoryStream.Create;
   FStream:=TMemoryStream.Create;
   if Assigned(idthreadcomp) then
   begin
    idthreadcomp.Active:=false;
    idthreadcomp.Free;
    idthreadcomp:=nil;
   end;
   idthreadcomp:=TIdThreadComponent.Create(nil);
   idthreadcomp.OnRun:=idthreadcompRun;
   if Assigned(connect) then
   begin
    connect.free;
    connect:=nil;
   end;
   connect:=TIdHttp.Create(Self);
{$IFNDEF DOTNETD}
 {$IFNDEF INDY10}
    connect.Port:=FPort;
 {$ENDIF}
{$ENDIF}
     if (FSSL) then
     begin
      connect.IOHandler:=TIdSSLIOHandlerSocket.Create(nil);
      TIdSSLIOHandlerSocket(connect.IOHandler).SSLOptions.Mode:= sslmClient;
      TIdSSLIOHandlerSocket(connect.IOHandler).SSLOptions.Method:=sslvSSLv23;
     end;
     metafile:=TrpMetafileReport.Create(nil);
     try
       metafile.AsyncReading:=AsyncRead;
       if AsyncRead then
       begin
        metafile.OnRequestData:=OnRequestData;
        idthreadcomp.Active:=true;
//        idthreadcomp.WaitFor;
       end
       else
       begin
        metafile.OnRequestData:=nil;
        connect.Request.ContentType:='octet/stream';
        connect.ReadTimeout:=READ_TIMEOUT;
        connect.HandleRedirects:= True;
        connect.Request.AcceptEncoding := 'gzip,deflate';
        connect.Get(MetaUrl,FNewStream);
        FNewStream.Seek(0,soFromBeginning);
       end;
       FStreamSize:=FNewStream.Size;
       try
        metafile.LoadFromStream(FNewStream);
       except
        On E:Exception do
        begin
         E.Message:=E.Message;
         raise;
        end;
       end;
       if preview then
       begin
        Meta:=PreviewMetafile(metafile,aform,ShowPrintDialog,false);
       end
       else
       begin
        // Prints the report
        rpPageSize.Custom:=metafile.PageSize<0;
        rpPageSize.Indexqt:=metafile.PageSize;
        rpPageSize.CustomWidth:=metafile.CustomX;
        rpPageSize.CustomHeight:=metafile.CustomY;
        frompage:=1;
        topage:=999999;
        allpages:=true;
        collate:=false;
        copies:=FCopies;
        pconfig.changed:=false;
        try
        rpgdidriver.PrinterSelection(metafile.PrinterSelect,metafile.papersource,metafile.duplex,pconfig);
        rpgdidriver.PageSizeSelection(rpPageSize);
        rpgdidriver.OrientationSelection(metafile.orientation);
        okselected:=true;
        if ShowPrintDialog then
         okselected:=rpgdidriver.DoShowPrintDialog(allpages,frompage,topage,copies,collate);
        if okselected then
         rpgdidriver.PrintMetafile(metafile,SRpPrintingFile,FShowProgress,allpages,
          frompage,topage,copies,collate,
          GetDeviceFontsOption(metafile.PrinterSelect),metafile.PrinterSelect);
        finally
        SetPrinterConfig(pconfig);
        end;
       end;
//      end
//      else
//      begin
//       astream.Seek(0,soFromBeginning);
//       if ((astream.size)<=0) then
//        Raise Exception.Create(SRpEmptyResponse)
//       else
//       begin
//        SetLength(astring,astream.size);
//        astream.Read(astring[1],astream.size);
//        Raise Exception.Create(Copy(astring,1,2000));
//       end;
//      end;
     finally
      if not Preview then
       metafile.free;
     end;
  end;
 except
  On E:Exception do
  begin
   errormessage:=E.Message;
   raise;
  end;
 end;
end;

destructor TRpWebMetaPrint.Destroy;
begin
    if Assigned(idthreadcomp) then
    begin
     idthreadcomp.Active:=false;
     idthreadcomp.Free;
     idthreadcomp:=nil;
    end;
    if Assigned(FStream) then
    begin
     FStream.free;
     FStream:=nil;
    end;
    if Assigned(FNewStream) then
    begin
     FNewStream.free;
     FNewStream:=nil;
    end;

    inherited Destroy;
end;


procedure TRpWebMetaPrint.SetCaption(Value:WideString);
begin
 FCaption:=Value;
 Invalidate;
end;

constructor TRpWebMetaPrint.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

 FPreview:=false;
 FFontSize:=0;
 FPort:=80;
 FSSL:=false;
 FShowProgress:=True;
 FCopies:=1;
end;

procedure TRpWebMetaPrint.Paint;
var
 rec:TRect;
begin
 if FontSize>0 then
  Font.Size:=FontSize;
 if Length(FFontName)>0 then
  Font.Name:=FontName;
 rec:=GetClientRect;
 Canvas.Brush.Style:=bsClear;
 Canvas.Pen.Color:=clWindowText;
 Canvas.Rectangle(rec.Left,rec.Top,rec.Right,rec.Bottom);
 Canvas.Font.Color:=clWindowText;
 Canvas.Brush.Color:=clBtnFace;
 Canvas.TextRect(rec,0,1,Caption);
 if Length(errormessage)>0 then
 begin
  rec.Top:=rec.Top+30;
  Canvas.TextRect(rec,0,1,RM_VERSION);
  rec.Top:=rec.Top+30;
  Canvas.TextRect(rec,0,1,errormessage);
 end;
end;

procedure PrintHttpReport(httpstring:String;usessl:boolean=false);
var
 connect:TIdHttp;
 astream:TMemoryStream;
 metafile:TrpMetafileReport;
 astring:string;
begin
 connect:=TIdHttp.Create(nil);
 try
  astream:=TMemoryStream.Create;
  try
   if (usessl) then
   begin
    connect.IOHandler:=TIdSSLIOHandlerSocket.Create(nil);
    TIdSSLIOHandlerSocket(connect.IOHandler).SSLOptions.Mode:= sslmClient;
    TIdSSLIOHandlerSocket(connect.IOHandler).SSLOptions.Method:=sslvSSLv23;
   end;
   connect.Request.ContentType:='octet/stream';
   connect.ReadTimeout:=READ_TIMEOUT;
   connect.HandleRedirects:= True;
   connect.Request.AcceptEncoding := 'gzip,deflate';
   connect.Get(httpstring,astream);
   metafile:=TrpMetafileReport.Create(nil);
   try
    astream.Seek(0,soFromBeginning);
    if (IsMetafile(astream)) then
    begin
     astream.Seek(0,soFromBeginning);
     metafile.AsyncReading:=false;
     metafile.LoadFromStream(astream);
     rpgdidriver.PrintMetafile(metafile,'Printing',true,true,0,1,1,true,false);
    end
    else
    begin
     astream.Seek(0,soFromBeginning);
     if ((astream.size)<=0) then
      Raise Exception.Create(SRpEmptyResponse)
     else
     begin
      SetLength(astring,astream.size);
      astream.Read(astring[1],astream.size);
      Raise Exception.Create(astring);
     end;
    end;
   finally
    metafile.free;
   end;
  finally
   astream.free;
  end;
 finally
  connect.free;
 end;
end;

procedure TRpWebMetaPrint.DoInstall;
var
 connect:TIdHttp;
 sysdir:String;
 astream:TMemoryStream;
begin
 // Install need the url to install languages from
 connect:=TIdHttp.Create(nil);
 try
{$IFNDEF DOTNETD}
 {$IFNDEF INDY10}
  connect.Port:=FPort;
 {$ENDIF}
{$ENDIF}
  if (FSSL) then
  begin
   connect.IOHandler:=TIdSSLIOHandlerSocket.Create(nil);
   TIdSSLIOHandlerSocket(connect.IOHandler).SSLOptions.Mode:= sslmClient;
  end;
  astream:=TMemoryStream.Create;
  try
   sysdir:=GetTheSystemDirectory;
   connect.Request.ContentType:='octet/stream';
   connect.ReadTimeout:=READ_TIMEOUT;
   connect.HandleRedirects:= True;
   connect.Request.AcceptEncoding := 'gzip,deflate';
   connect.Get(MetaUrl+'/reportmanres.es',astream);
   if astream.size=0 then
    Raise Exception.Create(SRpNotFound+' - es '+MetaUrl);
   astream.Seek(0,soFromBeginning);
   astream.SaveToFile(sysdir+DIR_SEPARATOR+'reportmanres.es');
   //
   connect.Get(MetaUrl+'/reportmanres.cat',astream);
   if astream.size=0 then
    Raise Exception.Create(SRpNotFound+' - cat '+MetaUrl);
   astream.Seek(0,soFromBeginning);
   astream.SaveToFile(sysdir+DIR_SEPARATOR+'reportmanres.cat');
   //
   connect.Get(MetaUrl+'/reportmanres.fr',astream);
   if astream.size=0 then
    Raise Exception.Create(SRpNotFound+' - fr '+MetaUrl);
   astream.Seek(0,soFromBeginning);
   astream.SaveToFile(sysdir+DIR_SEPARATOR+'reportmanres.fr');
   //
   connect.Get(MetaUrl+'/reportmanres.pt',astream);
   if astream.size=0 then
    Raise Exception.Create(SRpNotFound+' - pt '+MetaUrl);
   astream.Seek(0,soFromBeginning);
   astream.SaveToFile(sysdir+DIR_SEPARATOR+'reportmanres.pt');
   //
   connect.Get(MetaUrl+'/reportmanres.de',astream);
   if astream.size=0 then
    Raise Exception.Create(SRpNotFound+' - de '+MetaUrl);
   astream.Seek(0,soFromBeginning);
   astream.SaveToFile(sysdir+DIR_SEPARATOR+'reportmanres.de');
   //
   connect.Get(MetaUrl+'/reportmanres.it',astream);
   if astream.size=0 then
    Raise Exception.Create(SRpNotFound+' - it '+MetaUrl);
   astream.Seek(0,soFromBeginning);
   astream.SaveToFile(sysdir+DIR_SEPARATOR+'reportmanres.it');
   //
   connect.Get(MetaUrl+'/reportmanres.en',astream);
   if astream.size=0 then
    Raise Exception.Create(SRpNotFound+' - en '+MetaUrl);
   astream.Seek(0,soFromBeginning);
   astream.SaveToFile(sysdir+DIR_SEPARATOR+'reportmanres.en');
{   connect.Get(MetaUrl+'/WebReportManX.ocx.manifest',astream);
   if astream.size=0 then
    Raise Exception.Create(SRpNotFound+' - '+MetaUrl);
   astream.Seek(0,soFromBeginning);
   astream.SaveToFile(sysdir+DIR_SEPARATOR+'WebReportManX.ocx.manifest');
}  finally
   astream.free;
  end;
 finally
  connect.free;
 end;
end;




{$IFDEF INDY10_2}
procedure TRpWebMetaPrint.idthreadcompRun(Sender: TIdThreadComponent);
{$ENDIF}
{$IFNDEF INDY10_2}
{$IFDEF INDY10}
procedure TRpWebMetaPrint.idthreadcompRun(Sender: TIdThreadComponent);
{$ENDIF}
{$IFNDEF INDY10}
procedure TRpWebMetaPrint.idthreadcompRun(Sender: TIdCustomThreadComponent);
{$ENDIF}
{$ENDIF}
begin
 FFinished:=false;
 SetLength(abyte,64000);
 try
  if (FSSL) then
  begin
   connect.IOHandler:=TIdSSLIOHandlerSocket.Create(nil);
   TIdSSLIOHandlerSocket(connect.IOHandler).SSLOptions.Mode:= sslmClient;
   TIdSSLIOHandlerSocket(connect.IOHandler).SSLOptions.Method:=sslvSSLv23;
  end;
  connect.OnWorkEnd:=connectWorkEnd;
  connect.OnWork:=connectWork;
  connect.Request.ContentType:='octet/stream';
  connect.ReadTimeout:=READ_TIMEOUT;
  connect.HandleRedirects:= True;
  connect.Request.AcceptEncoding := 'gzip,deflate';
  connect.Get(metaurl,FStream);
 finally
  FFinished:=true;
 end;
 idthreadcomp.Active:=false;
end;


{$IFNDEF INDY10_2}
{$IFNDEF INDY10}
procedure TRpWebMetaPrint.connectWork(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
{$ENDIF}
{$IFDEF INDY10}
procedure TRpWebMetaPrint.connectWork(Sender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Integer);
{$ENDIF}
{$ENDIF}
{$IFDEF INDY10_2}
procedure TRpWebMetaPrint.connectWork(Sender: TObject; AWorkMode:TWorkMode;AWorkCount:Int64);
{$ENDIF}
var
 oldposition:int64;
 oldpos2:int64;
 readed:integer;
begin
 if aborting then
  Raise Exception.Create(SrpOperationAborted);
  oldpos2:=FStream.Position;
 readed:=FStream.Position-FNewStream.Size;
 if readed<1 then
  exit;
 if Length(abyte)<readed then
  SetLength(abyte,readed);
 FStream.Position:=FNewStream.Size;
 FStream.Read(abyte[0],readed);
 metafile.critsec.enter;
 try
  oldposition:=FNewStream.Position;
  FNewStream.Position:=FNewStream.Size;
  FNewStream.Write(abyte[0],readed);
  FNewStream.Position:=oldposition;
 finally
  metafile.critsec.leave;
 end;
 FStream.Position:=oldpos2;
end;

procedure TRpWebMetaPrint.connectWorkEnd(Sender: TObject;
  AWorkMode: TWorkMode);
begin
 try
  connectWork(Sender,wmRead,0);
 finally
  FFinished:=true;
 end;
end;



procedure TRpWebMetaPrint.OnRequestData(Sender:TObject;count:integer);
var
 currentcount:integer;
begin
 if (not assigned(idthreadcomp)) then
  exit;
 readcount:=readcount+count;
 currentcount:=FNewStream.Size;
 while ((not FFinished) and (currentcount<readcount)) do
 begin
  WaitForSingleObject(idthreadcomp.Handle,200);
  currentcount:=FNewStream.Size;
 end;
// idthreadcomp.WaitFor;
{ FGetThread.critsec.enter;
 try
  currentcount:=FGetThread.FNewStream.Size;
 finally
  FGetThread.critsec.leave;
 end;
 while ((not FGetThread.FFinished) and (currentcount<readcount)) do
 begin
   WaitForSingleObject(FGetThread.Handle,INFINITE);
   try
    currentcount:=FGetThread.FNewStream.Size;
   finally
    FGetThread.critsec.leave;
   end;
 end;
}
end;


end.
