{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       rpmdysinfo                                      }
{       Form showing info about printer and system      }
{                                                       }
{                                                       }
{                                                       }
{       Copyright (c) 1994-2003 Toni Martir             }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{*******************************************************}

unit rpmdsysinfo;

interface

{$I rpconf.inc}

uses Windows, Messages,SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls,Printers,rpmdconsts,WinSpool,Dialogs,rptypes,
  rpmunits;

type
  TFRpSysInfo = class(TForm)
    BOK: TButton;
    GSelectedPrinter: TGroupBox;
    Label1: TLabel;
    EStatus: TEdit;
    EPrinterName: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    EDevice: TEdit;
    EDriver: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    EPort: TEdit;
    Label6: TLabel;
    LMaxCopies: TLabel;
    Label7: TLabel;
    LCollation: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LColor: TLabel;
    LResolution: TLabel;
    GroupBox2: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    LProcessors: TLabel;
    LOEMID: TLabel;
    LDisplay: TLabel;
    Label13: TLabel;
    LOS: TLabel;
    Label14: TLabel;
    Label12: TLabel;
    LVersion: TLabel;
    Label15: TLabel;
    LTechnology: TLabel;
    Label16: TLabel;
    CLineCaps: TComboBox;
    CRasterCaps: TComboBox;
    Label17: TLabel;
    CPolyCaps: TComboBox;
    Label18: TLabel;
    Label19: TLabel;
    CTextCaps: TComboBox;
    Label20: TLabel;
    CCurveCaps: TComboBox;
    LFormNameL: TLabel;
    LFormName: TLabel;
    LFormpageSize: TLabel;
    LFormPageSizeL: TLabel;
    LPageSizeL: TLabel;
    LPageSize: TLabel;
    LOrientation: TLabel;
    LOrientationL: TLabel;
    LPaperSources: TLabel;
    ComboSource: TComboBox;
    Label21: TLabel;
    ComboSeparators: TComboBox;
    LDuplexL: TLabel;
    LDuplex: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


procedure RpShowSystemInfo;

implementation

uses rpvgraphutils;

{$R *.dfm}

procedure RpShowSystemInfo;
var
 dia:TFRpSysInfo;
begin
 dia:=TFRpSysInfo.Create(Application);
 try
  dia.ShowModal;
 finally
  dia.free;
 end;
end;



procedure TFRpSysInfo.FormCreate(Sender: TObject);
begin
{$IFNDEF DOTNETD}
 SendMessage(ComboSource.Handle, CB_SETDROPPEDWIDTH, 250, 0);
{$ENDIF}
 Caption:=TranslateStr(976,Caption);
 BOK.Caption:=SRpOk;
 LMaxCopies.Font.Style:=[fsBold];
 Lresolution.Font.Style:=[fsBold];
 LFormName.Font.Style:=[fsBold];
 LPageSize.Font.Style:=[fsBold];
 LOrientation.Font.Style:=[fsBold];
 LFormPageSize.Font.Style:=[fsBold];
 LCollation.Font.Style:=[fsBold];
 LColor.Font.Style:=[fsBold];
 LOemID.Font.Style:=[fsBold];
 LProcessors.Font.Style:=[fsBold];
 LDisplay.Font.Style:=[fsBold];
 LOS.Font.Style:=[fsBold];
 LVersion.Font.Style:=[fsBold];
 LTechnology.Font.Style:=[fsBold];
 GSelectedPrinter.Caption:=SRpSelectedPrinter;
 Label2.Caption:=TranslateStr(1061,Label2.Caption);
 Label1.Caption:=TranslateStr(1062,Label1.Caption);
 Label3.Caption:=TranslateStr(1063,Label3.Caption);
 Label4.Caption:=TranslateStr(1064,Label4.Caption);
 Label8.Caption:=TranslateStr(1065,Label8.Caption);
 Label5.Caption:=TranslateStr(1066,Label5.Caption);
 Label6.Caption:=TranslateStr(1067,Label6.Caption);
 Label7.Caption:=TranslateStr(1068,Label7.Caption);
 LPaperSources.Caption:=TranslateStr(1323,LPaperSources.Caption);
 Label9.Caption:=TranslateStr(1069,Label9.Caption);
 Label15.Caption:=TranslateStr(1070,Label15.Caption);
 Label16.Caption:=TranslateStr(1071,Label16.Caption);
 Label17.Caption:=TranslateStr(1072,Label17.Caption);
 Label18.Caption:=TranslateStr(1073,Label18.Caption);
 Label19.Caption:=TranslateStr(1074,Label19.Caption);
 Label20.Caption:=TranslateStr(1075,Label20.Caption);
 GroupBox2.Caption:=TranslateStr(976,GroupBox2.Caption);
 Label14.Caption:=TranslateStr(1076,Label14.Caption);
 Label10.Caption:=TranslateStr(1077,Label10.Caption);
 Label12.Caption:=TranslateStr(91,Label12.Caption);
 Label11.Caption:=TranslateStr(1078,Label11.Caption);
 Label13.Caption:=TranslateStr(1079,Label13.Caption);
 LPageSizeL.Caption:=SRpPageSize;
 LOrientationL.Caption:=TranslateStr(98,LOrientation.Caption);
 LFormPageSizeL.Caption:=SRpFormPageSize;
 LFormNameL.Caption:=SRpFormName;

end;

procedure TFRpSysInfo.FormShow(Sender: TObject);
type
 TBin_name=array [0..23] of char;
var
 printererror:boolean;
 printererrormessage:String;
 maxcopies:Integer;
 FPrinterHandle:THandle;
{$IFNDEF DOTNETD}
 DeviceMode: THandle;
 Device, Driver, Port: array[0..1023] of char;
 pdevmode:^DEVMODE;
 buf:PChar;
 pforminfo:^Form_info_1;
 numbins,i:integer;
 bufint:array of Word;
 bufchar:array of TBin_name;
{$ENDIF}
{$IFDEF DOTNETD}
 DeviceMode: IntPtr;
 PDevMode :  TDeviceMode;
 Device, Driver, Port:String;
 pforminfo:Form_info_1;
{$ENDIF}
 asize:integer;
 cadenaimp:String;
 sysinfo:SYSTEM_INFO;
 osinfo:TOsVersionInfo;
 caps:integer;
 needed:DWord;
 dc:HDC;
 pagesize:TPoint;
 laste:integer;
begin
 ComboSeparators.Items.Clear;
 ComboSeparators.Items.Add(SRpDate+' '+DateSeparator);
 ComboSeparators.Items.Add(SRpTime+' '+TimeSeparator);
 ComboSeparators.Items.Add('Decimal'+' '+DecimalSeparator);
 ComboSeparators.Items.Add('Thousand'+' '+ThousandSeparator);
 ComboSeparators.ItemIndex:=0;
 ComboSource.Items.Clear;
 ComboSource.Items.Add(SRpUnknown);
 ComboSource.ItemIndex:=0;
 dc:=0;
 pagesize.x:=0;
 pagesize.y:=0;
 if Printer.Printers.Count>0 then
 begin
  EPrinterName.text:=Printer.Printers.Strings[Printer.PrinterIndex];
  // Printer selected not valid error
  printererror:=false;
  try
   dc:=Printer.Handle;
   Printer.GetPrinter(Device, Driver, Port, DeviceMode);
  except
   on E:Exception do
   begin
    printererror:=true;
    printererrormessage:=E.Message;
   end;
  end;
  if printererror then
  begin
   EStatus.Text:=printererrormessage;
  end
  else
  begin
   EStatus.Text:=SRpSReady;
{$IFNDEF DOTNETD}
   EDevice.Text:=StrPas(Device);
   EDriver.Text:=StrPas(Driver);
   EPort.Text:=StrPas(Port);
{$ENDIF}
{$IFDEF DOTNETD}
   EDevice.Text:=Device;
   EDriver.Text:=Driver;
   EPort.Text:=Port;
{$ENDIF}
   maxcopies:=PrinterMaxCopiesSupport;
   if PrinterDuplexSupport then
    LDuplex.Caption:=SRpYes
   else
    LDuplex.Caption:=SRpNo;
   LMaxCopies.Caption:=FormatFloat('####,0',maxcopies);
   if PrinterSupportsCollation then
    LCollation.Caption:=SRpYes
   else
    LCollation.Caption:=SRpNo;
   cadenaimp:=Device;
{$IFNDEF DOTNETD}
   buf:=Pchar(cadenaimp);
   if OpenPrinter(buf,fprinterhandle,nil) then
   begin
    try
     pdevmode:=nil;
     asize:=DocumentProperties(0,fprinterhandle,Device,pdevmode^,pdevmode^,0);
     pdevmode:=AllocMem(sizeof(asize));
     try
      if asize>0 then
      begin
       FreeMem(pdevmode);
       pdevmode:=AllocMem(asize);
       if IDOK=DocumentProperties(0,fprinterhandle,Device,pdevmode^,pdevmode^,DM_OUT_BUFFER) then
       begin
        // Orientation
        if (pdevmode^.dmFields AND DM_ORIENTATION)>0 then
        begin
         if pdevmode^.dmOrientation=1 then
          LOrientation.Caption:=TranslateStr(106,'Portrait')
         else
         if pdevmode^.dmOrientation=2 then
          LOrientation.Caption:=TranslateStr(107,'Landscape');
        end;
        // Dev mode properties
        if (pdevmode^.dmFields AND DM_COLOR)>0 then
        begin
         if (pdevmode^.dmColor=DMCOLOR_COLOR) then
         begin
          LColor.Caption:=SRpSColorPrinting;
         end
         else
         begin
          LColor.Caption:=SRpSMonoPrinting;
         end;
        end;
        pagesize:=GetPhysicPageSizeTwips;
        if pagesize.x>0 then
        begin
         LPageSize.Caption:=gettextfromtwips(pagesize.x)+
          ' x '+gettextfromtwips(pagesize.y)+
           ' '+rpunitlabels[defaultunit];
        end;
        pagesize.x:=0;
        pagesize.y:=0;
        try
         if IsWindowsNT then
         begin
          if (pdevmode^.dmFields AND DM_FORMNAME)>0 then
          begin
           LFormName.Caption:=StrPas(pdevmode^.dmFormName);
           pforminfo:=allocmem(sizeof(form_info_1));
           try
            if Not GetForm(handle,Pchar(LFormName.Caption),1,pforminfo,sizeof(Form_info_1),needed) then
            begin
             laste:=GetLasterror;
             if ((laste<>122) AND (Laste<>123) AND (laste<>1902)) then
              RaiseLastOSError
             else
             begin
              if laste<>1902 then
              begin
               if needed>0 then
               begin
                freemem(pforminfo);
                pforminfo:=AllocMem(needed);
                if Not GetForm(handle,Pchar(LFormName.Caption),1,pforminfo,needed,needed) then
                 RaiseLastOSError;
                Pagesize.x:=pforminfo.Size.cy div 100;
                Pagesize.y:=pforminfo.Size.cx div 100;
               end;
              end;
             end;
            end
            else
            begin
             Pagesize.x:=pforminfo.Size.cy div 100;
             PageSize.y:=pforminfo.Size.cx div 100;
            end;
           finally
            freemem(pforminfo);
           end;
          end;
          if pagesize.x>0 then
          begin
           pagesize.x:=Round(pagesize.x/100/CMS_PER_INCHESS*TWIPS_PER_INCHESS);
           pagesize.y:=Round(pagesize.y/100/CMS_PER_INCHESS*TWIPS_PER_INCHESS);
           LFormPageSize.Caption:=gettextfromtwips(pagesize.x)+
            ' x '+gettextfromtwips(pagesize.y)+
             ' '+rpunitlabels[defaultunit];
          end;
         end;
        except
         On E:Exception do
         begin
           LFormpageSize.Caption:=SRpError+'-'+E.Message;
         end;
        end;
        if (pdevmode^.dmFields AND DM_YRESOLUTION)>0 then
        begin
         LResolution.Caption:=FormatFloat('###,###',pdevmode^.dmPrintQuality)+
          ' x '+FormatFloat('###,###',pdevmode^.dmYResolution);
        end
        else
        begin
         if integer(pdevmode^.dmPrintQuality)<=0 then
         begin
          case DWORD(pdevmode^.dmPrintQuality) of
           DMRES_HIGH:
            LResolution.Caption:=SRpSHighResolution;
           DMRES_MEDIUM:
            LResolution.Caption:=SRpSMediumResolution;
           DMRES_LOW:
            LResolution.Caption:=SRpSLowResolution;
           DMRES_DRAFT:
            LResolution.Caption:=SRpSDraftResolution;
          end;
         end
         else
         begin
          LResolution.Caption:=FormatFloat('###,###',pdevmode^.dmPrintQuality)+
           ' x '+FormatFloat('###,###',pdevmode^.dmPrintQuality);
         end;
        end;
       end;
      end
      else
      begin
       try
        RaiseLastOSError;
       except
        on E:Exception do
        begin
         ShowMessage(E.Message);
        end;

       end;

      end;

      // Se obtienen las posibles bandejas de entrada
      ComboSource.Items.Clear;
      numbins:=DeviceCapabilities(Device,Port,DC_BINS,nil,nil);
      if numbins=0 then
      begin
       ComboSource.Items.Add(SRpNo);
      end
      else
      begin
       SetLength(bufint,numbins);
       DeviceCapabilities(Device,Port,DC_BINS,@bufint[0],nil);
       for i:=0 to numbins-1 do
       begin
        ComboSource.Items.Add(IntToStr(bufint[i]));
       end;
       SetLength(bufchar,numbins);
       DeviceCapabilities(Device,Port,DC_BINNAMES,@bufchar[0],nil);
       for i:=0 to numbins-1 do
       begin
        ComboSource.Items.Strings[i]:=ComboSource.Items.Strings[i]
         +'-'+StrPas(bufchar[i]);
       end;
      end;
      ComboSource.ItemIndex:=0;
     finally
      FreeMem(pdevmode);
     end;
    finally
     ClosePrinter(fprinterhandle);
    end;
   end;
{$ENDIF}
   caps:=GetDeviceCaps(dc,TECHNOLOGY);
   case caps of
    DT_PLOTTER:
     LTechnology.Caption:=SRSPlotter;
    DT_RASDISPLAY:
     LTechnology.Caption:=SRSRasterDisplay;
    DT_RASPRINTER:
     LTechnology.Caption:=SRSRasterPrinter;
    DT_RASCAMERA:
     LTechnology.Caption:=SRSRasterCamera;
    DT_CHARSTREAM:
     LTechnology.Caption:=SRSCharStream;
    DT_METAFILE:
     LTechnology.Caption:=SRpSMetafile;
    DT_DISPFILE:
     LTechnology.Caption:=SRSDisplayFile;
    else
     LTechnology.Caption:=SRpSUnknownType;
   end;
   caps:=GetDeviceCaps(dc,LINECAPS);
   if caps=LC_NONE then
    CLineCaps.Items.Add(SRpNone)
   else
   begin
    CLineCaps.Items.Add(SRpYes);
    if (caps AND LC_POLYLINE)>0 then
     CLineCaps.Items.Add(SRpSPolyline);
    if (caps AND LC_MARKER)>0 then
     CLineCaps.Items.Add(SRpSMarker);
    if (caps AND LC_WIDE)>0 then
     CLineCaps.Items.Add(SRpSWideCap);
    if (caps AND LC_STYLED)>0 then
     CLineCaps.Items.Add(SRpSSTyledCap);
    if (caps AND LC_WIDESTYLED)>0 then
     CLineCaps.Items.Add(SRpSWideSTyledCap);
    if (caps AND LC_INTERIORS)>0 then
     CLineCaps.Items.Add(SRpSInteriorsCap);
   end;
   CLineCaps.ItemIndex:=0;
   caps:=GetDeviceCaps(dc,POLYGONALCAPS);
   if caps=PC_NONE then
    CPolyCaps.Items.Add(SRpNone)
   else
   begin
    CPolyCaps.Items.Add(SRpYes);
    if (caps AND PC_POLYGON)>0 then
     CPolyCaps.Items.Add(SRpSPolygon);
    if (caps AND PC_RECTANGLE)>0 then
     CPolyCaps.Items.Add(SRpSRectanglecap);
    if (caps AND PC_WINDPOLYGON)>0 then
     CPolyCaps.Items.Add(SRpSWindPolygon);
    if (caps AND PC_STYLED)>0 then
     CPolyCaps.Items.Add(SRpSSTyledCap);
    if (caps AND PC_WIDE)>0 then
     CPolyCaps.Items.Add(SRpSWideCap);
    if (caps AND PC_WIDESTYLED)>0 then
     CPolyCaps.Items.Add(SRpSWideSTyledCap);
    if (caps AND PC_INTERIORS)>0 then
     CPolyCaps.Items.Add(SRpSInteriorsCap);
   end;
   CPolyCaps.ItemIndex:=0;
   caps:=GetDeviceCaps(dc,CURVECAPS);
   if caps=CC_NONE then
    CCurveCaps.Items.Add(SRpNone)
   else
   begin
    CCurveCaps.Items.Add(SRpYes);
    if (caps AND CC_CIRCLES)>0 then
     CCurveCaps.Items.Add(SRpSCircleCap);
    if (caps AND CC_PIE)>0 then
     CCurveCaps.Items.Add(SRpSPiecap);
    if (caps AND CC_CHORD)>0 then
     CCurveCaps.Items.Add(SRpSCHordCap);
    if (caps AND CC_ELLIPSES)>0 then
     CCurveCaps.Items.Add(SRpSEllipses);
    if (caps AND CC_ROUNDRECT)>0 then
     CCurveCaps.Items.Add(SRpSRoundRectCap);
    if (caps AND CC_STYLED)>0 then
     CCurveCaps.Items.Add(SRpSSTyledCap);
    if (caps AND CC_WIDE)>0 then
     CCurveCaps.Items.Add(SRpSWideCap);
    if (caps AND CC_WIDESTYLED)>0 then
     CCurveCaps.Items.Add(SRpSWideSTyledCap);
    if (caps AND CC_INTERIORS)>0 then
     CCurveCaps.Items.Add(SRpSInteriorsCap);
   end;
   CCurveCaps.ItemIndex:=0;
   caps:=GetDeviceCaps(dc,RASTERCAPS);
   if (caps AND RC_BANDING)>0 then
    CRasterCaps.Items.Add(SRpSBandingRequired);
   if (caps AND RC_BITBLT)>0 then
    CRasterCaps.Items.Add(SRpSBitmapTransfer);
   if (caps AND RC_BITMAP64)>0 then
    CRasterCaps.Items.Add(SRpSBitmapTransfer64);
   if (caps AND RC_DI_BITMAP)>0 then
    CRasterCaps.Items.Add(SRpSDIBTransfer);
   if (caps AND RC_DIBTODEV)>0 then
    CRasterCaps.Items.Add(SRpSDIBDevTransfer);
   if (caps AND RC_FLOODFILL)>0 then
    CRasterCaps.Items.Add(SRpSFloodFillcap);
   if (caps AND RC_GDI20_OUTPUT	)>0 then
    CRasterCaps.Items.Add(SRpSGDI20Out);
   if (caps AND RC_PALETTE)>0 then
    CRasterCaps.Items.Add(SRPSPaletteDev);
   if (caps AND RC_SCALING)>0 then
    CRasterCaps.Items.Add(SRpSScalingCap);
   if (caps AND RC_STRETCHBLT)>0 then
    CRasterCaps.Items.Add(SRpSStretchCap);
   if (caps AND RC_STRETCHDIB	)>0 then
    CRasterCaps.Items.Add(SRpSStretchDIBCap);

   if CRasterCaps.Items.Count=0 then
    CRasterCaps.Items.Add(SRpNone)
   else
    CRasterCaps.Items.Insert(0,SRpYes);
   CRasterCaps.ItemIndex:=0;
   // Text caps
   caps:=GetDeviceCaps(dc,TEXTCAPS);
   if (caps AND TC_OP_CHARACTER)>0 then
    CTextCaps.Items.Add(SRpSCharOutput);
   if (caps AND TC_OP_STROKE)>0 then
    CTextCaps.Items.Add(SRpSCharStroke);
   if (caps AND TC_CP_STROKE)>0 then
    CTextCaps.Items.Add(SRpSClipStroke);
   if (caps AND TC_CR_90)>0 then
    CTextCaps.Items.Add(SRpS90Rotation);
   if (caps AND TC_CR_ANY)>0 then
    CTextCaps.Items.Add(SRpSAnyRotation);
   if (caps AND TC_SF_X_YINDEP)>0 then
    CTextCaps.Items.Add(SRpSScaleXY);
   if (caps AND TC_SA_DOUBLE)>0 then
    CTextCaps.Items.Add(SRpSDoubleChar);
   if (caps AND TC_SA_INTEGER)>0 then
    CTextCaps.Items.Add(SRpSIntegerScale);
   if (caps AND TC_SA_CONTIN)>0 then
    CTextCaps.Items.Add(SRpSAnyrScale);
   if (caps AND TC_EA_DOUBLE)>0 then
    CTextCaps.Items.Add(SRpSDoubleWeight);
   if (caps AND TC_IA_ABLE)>0 then
    CTextCaps.Items.Add(SRpItalic);
   if (caps AND TC_UA_ABLE)>0 then
    CTextCaps.Items.Add(SRpUnderline);
   if (caps AND TC_SO_ABLE)>0 then
    CTextCaps.Items.Add(SRpStrikeOut);
   if (caps AND TC_RA_ABLE)>0 then
    CTextCaps.Items.Add(SRpRasterFonts);
   if (caps AND TC_VA_ABLE)>0 then
    CTextCaps.Items.Add(SRpVectorFonts);
   if (caps AND TC_SCROLLBLT)>0 then
    CTextCaps.Items.Add(SRpNobitBlockScroll);
   if CTextCaps.Items.Count=0 then
    CTextCaps.Items.Add(SRpNone)
   else
    CTextCaps.Items.Insert(0,SRpYes);
   CTextCaps.ItemIndex:=0;
  end;
 end;
 GetSystemInfo(sysinfo);
 LOemID.Caption:=IntToStr(sysinfo.dwOemId);
 LProcessors.Caption:=IntToStr(sysinfo.dwNumberOfProcessors);
 LDisplay.Caption:=FormatCurr('##,##',GetSysTemMetrics(SM_CXSCREEN))+
  ' x '+FormatCurr('##,##',GetSysTemMetrics(SM_CYSCREEN))+' '+
   SRpDPIRes+':'+IntToStr(Screen.PixelsPerInch);
 osinfo.dwOSVersionInfoSize:=sizeof(osinfo);
 if GetVersionEx(osinfo) then
 begin
  if osinfo.dwPlatformId=VER_PLATFORM_WIN32_NT then
   LOS.Caption:='Windows NT/XP/NET'
  else
   LOS.Caption:='Windows 95/98/ME';
  LVersion.Caption:=IntToStr(osinfo.dwMajorVersion)+
   '.'+IntToStr(osinfo.dwMinorVersion)+' Build:'+IntToStr(osinfo.dwBuildNumber)+
{$IFNDEF DOTNETD}
   '-'+StrPas(osinfo.szCSDVersion);
{$ENDIF}
{$IFDEF DOTNETD}
   '-'+osinfo.szCSDVersion;
{$ENDIF}
 end;
end;

end.
