{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       The report component, it contains    }
{       subreports, pagesetup, printer selection...     }
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
// One report is composed of subreports, the report has
// page setup properties and a subreport list
// The subreports are printed in order and can have
// diferent datasources, grouping, sections etc

unit rpreport;

interface

{$I rpconf.inc}

uses Classes,rpbasereport,sysutils,rptypes,rpsubreport,rpsection,rpmdconsts,
 rpdatainfo,rpparams,rplabelitem,rpdrawitem,rpeval,rptypeval,
 rpmetafile,rpmdbarcode,rpprintitem,
{$IFDEF USEVARIANTS}
 types,dateutils,Variants,
{$ENDIF}
 rpalias,db,
{$IFDEF USEZLIB}
{$IFDEF DELPHI2009UP}
 zlib,
{$ENDIF}
{$IFNDEF DELPHI2009UP}
 rpmzlib,
{$ENDIF}
{$ENDIF}
{$IFDEF USERPDATASET}
 rpdataset,
{$ENDIF}
{$IFDEF LINUX}
  Libc,
{$ENDIF}
{$IFDEF MSWINDOWS}
  mmsystem,windows,
{$ENDIF}
 rpmunits,rpmdchart;


type
 TRpReport=class(TRpBaseReport)
  private
   FExternalsLoaded:Boolean;
  protected
    procedure DoUpdatepageSize(Driver:TRpPrintDriver;metafilepage:TRpMetafilePage);
    procedure Notification(AComponent:TComponent;Operation:TOperation);override;
    procedure Loaded;override;
    function NextSection(child:boolean):boolean;
    // Skip to next record returns true if a group has
    // changed and sets internally CurrentGroup
    function NextRecord(grouprestore:boolean):boolean;
  public
   IsDesignTime:Boolean;
   procedure LoadExternals;override;
   procedure BeginPrint(Driver:TRpPrintDriver);override;
   procedure EndPrint;override;
   function PrintNextPage:boolean;override;
   procedure PrintRange(Driver:TRpPrintDriver;allpages:boolean;
    frompage,topage,copies:integer;collate:boolean);
 end;

procedure RegisterRpReportClasses;

implementation

procedure TRpReport.LoadExternals;
var
 i,j,k:integer;
 subrep:TRpSubReport;
 sec:TRpSection;
 comp:TRpCommonComponent;
 rpexpre:TRpExpression;
 rpchart:TRpChart;
 externalexpression:boolean;
 reload:boolean;
begin
 inherited LoadExternals;

 if FExternalsLoaded then
  exit;
 externalexpression:=false;
 for i:=0 to Subreports.Count-1 do
 begin
  subrep:=Subreports.items[i].SubReport;
  for j:=0 to Subrep.Sections.Count-1 do
  begin
   sec:=SubRep.Sections.Items[j].Section;
   reload:=sec.IsExternal;
   if reload then
   begin
    reload:=not sec.LoadedExternal;
    if Length(sec.ExternalFilename)>0 then
     if sec.ExternalFilename[1]='@' then
     begin
      reload:=true;
      externalexpression:=true;
     end;
   end;
   // If it's a external section try to load it
   if (reload) then
   begin
    sec.LoadExternal;

    k:=0;
    while k<sec.ReportComponents.count do
    begin
     comp:=sec.ReportComponents.items[k].Component;
     if comp=nil then
      sec.ReportComponents.items[k].free
     else
     begin
      if (comp is TRpExpression) then
      begin
       rpexpre:=TRpExpression(comp);
       if Length(rpexpre.Identifier)>0 then
       begin
        try
         FIdentifiers.AddObject(rpexpre.Identifier,comp);
        except
         rpexpre.Identifier:='';
        end;
       end;
      end;
      if (comp is TRpChart) then
      begin
       rpchart:=TRpChart(comp);
       if Length(rpchart.Identifier)>0 then
       begin
        try
         FIdentifiers.AddObject(rpchart.Identifier,comp);
        except
         rpchart.Identifier:='';
        end;
       end;
      end;
      inc(k);
     end;
    end;
   end;
  end;
 end;
 // If exists one section with variable expression try reloading allways
 if not externalexpression then
  FExternalsLoaded:=true;
end;

procedure TRpReport.Loaded;
var
 i,j,k:integer;
 subrep:TRpSubReport;
 sec:TRpSection;
 comp:TRpCommonComponent;
 rpexpre:TRpExpression;
 rpchart:TRpChart;
begin
 inherited Loaded;

 for i:=0 to Subreports.Count-1 do
 begin
  subrep:=Subreports.items[i].SubReport;
  for j:=0 to Subrep.Sections.Count-1 do
  begin
   sec:=SubRep.Sections.Items[j].Section;
   // If it's a external section try to load it
   if IsDesignTime then
    if sec.IsExternal then
    begin
     AddReportItemsToEvaluator(evaluator);
     sec.LoadExternal;
    end;

   k:=0;
   while k<sec.ReportComponents.count do
   begin
    comp:=sec.ReportComponents.items[k].Component;
    if comp=nil then
     sec.ReportComponents.items[k].free
    else
    begin
     if (comp is TRpExpression) then
     begin
      rpexpre:=TRpExpression(comp);
      if Length(rpexpre.Identifier)>0 then
      begin
       try
        FIdentifiers.AddObject(rpexpre.Identifier,comp);
       except
        rpexpre.Identifier:='';
       end;
      end;
     end;
     if (comp is TRpChart) then
     begin
      rpchart:=TRpChart(comp);
      if Length(rpchart.Identifier)>0 then
      begin
       try
        FIdentifiers.AddObject(rpchart.Identifier,comp);
       except
        rpchart.Identifier:='';
       end;
      end;
     end;
     inc(k);
    end;
   end;
  end;
 end;
end;


procedure TRpReport.Notification(AComponent:TComponent;Operation:TOperation);
var i,index:integer;
begin
 inherited Notification(AComponent,Operation);

 if Operation=OpRemove then
 begin
  if (AComponent is TRpSubReport) then
  begin
   with SubReports do
   begin
    for i:=0 to Count -1 do
    begin
     if items[i]<>nil then
     begin
      if Items[i].SubReport=AComponent then
       Items[i].SubReport:=nil;
     end;
    end;
   end;
  end
  else
  if (AComponent is TRpExpression) then
  begin
   if Length(TRpExpression(AComponent).Identifier)>0 then
   begin
    index:=FIdentifiers.IndexOf(TRpExpression(AComponent).Identifier);
    if index>=0 then
     FIdentifiers.Delete(index);
   end;
  end
  else
  if (AComponent is TRpChart) then
  begin
   if Length(TRpChart(AComponent).Identifier)>0 then
   begin
    index:=FIdentifiers.IndexOf(TRpChart(AComponent).Identifier);
    if index>=0 then
     FIdentifiers.Delete(index);
   end;
  end
  else
  begin
   if AComponent=FAliasList then
    FAliasList:=nil;
  end;
 end;
 if operation=Opinsert then
 begin
  if (AComponent is TRpExpression) then
  begin
   if Length(TRpExpression(AComponent).Identifier)>0 then
   begin
    index:=FIdentifiers.IndexOf(TRpExpression(AComponent).Identifier);
    if index>=0 then
     TRpExpression(AComponent).Identifier:=''
    else
     FIdentifiers.AddObject(TRpExpression(AComponent).Identifier,AComponent);
   end;
  end
  else
  if (AComponent is TRpChart) then
  begin
   if Length(TRpChart(AComponent).Identifier)>0 then
   begin
    index:=FIdentifiers.IndexOf(TRpChart(AComponent).Identifier);
    if index>=0 then
     TRpChart(AComponent).Identifier:=''
    else
     FIdentifiers.Add(TRpChart(AComponent).Identifier);
   end;
  end;
 end;
end;



procedure TRpReport.PrintRange(Driver:TRpPrintDriver;allpages:boolean;
    frompage,topage,copies:integer;collate:boolean);
var
 i,j,k:integer;
 finished:boolean;
 printedfirst:boolean;
 endprintexecuted:boolean;
 reportcopies:integer;
 forcetwopass:boolean;
 hardwarecopies:integer;
 hardwarecollate:boolean;
begin
 if copies<0 then
  exit;
 if copies=0 then
  copies:=1;
 hardwarecopies:=1;
 hardwarecollate:=false;
 if (copies>1) then
 begin
  if collate then
  begin
   if Driver.SupportsCopies(copies) then
   begin
    if Driver.SupportsCollation then
    begin
     hardwarecopies:=copies;
     hardwarecollate:=true;
     collate:=false;
    end;
   end;
  end
  else
  begin
   if Driver.SupportsCopies(copies) then
    hardwarecopies:=copies;
  end;
 end;
 endprintexecuted:=False;
 printedfirst:=false;
 if allpages then
 begin
  frompage:=0;
  topage:=MAX_PAGECOUNT;
 end
 else
 begin
  dec(frompage);
  dec(topage);
 end;
 // Two pass report printing requires previeous calculation
 // of the metafile
 forceTwoPass:=TwoPass;
 if ((copies>1) and collate) then
  forcetwopass:=true;
 reportcopies:=1;
 if collate then
 begin
  reportcopies:=copies;
  copies:=1;
 end;
 if forceTwoPass then
 begin
  BeginPrint(Driver);
  try
   Driver.NewDocument(metafile,hardwarecopies,hardwarecollate);
   try
    RequestPage(MAX_PAGECOUNT);
    // Now the report is calculate with GetPageCount
    endprintexecuted:=true;
    // Then draw the generated metafile
    if topage>metafile.CurrentPageCount-1 then
     topage:=metafile.CurrentPageCount-1;
    for k:=1 to reportcopies do
    begin
     for j:=frompage to topage do
     begin
      for i:=1 to copies do
      begin
       if printedfirst then
       begin
        Driver.NewPage(metafile.pages[j]);
       end;
       printedfirst:=true;
       Driver.DrawPage(metafile.pages[j]);
       Driver.EndPage;
       if hardwarecopies>1 then
        break;
      end;
     end;
    end;
    // The report metafile must contain only the selected range
    if ((frompage>0) or (topage<metafile.CurrentPagecount-1)) then
    begin
     while frompage>0 do
     begin
      metafile.DeletePage(0);
      dec(frompage);
      dec(topage);
     end;
     while (metafile.Currentpagecount-1)>topage do
     begin
      metafile.DeletePage(metafile.CurrentPageCount-1);
     end;
    end;
    Driver.EndDocument;
   except
    Driver.AbortDocument;
    Raise;
   end;
  except
   if not endprintexecuted then
    EndPrint;
   Raise;
  end;
  exit;
 end;
 // One pass is more efficient in memory consuming
 // it frees each printed page
 printingonepass:=true;
 try
  BeginPrint(Driver);
  try
   Driver.NewDocument(metafile,hardwarecopies,hardwarecollate);
   try
    finished:=false;
    while Not PrintNextPage do
    begin
     if ((PageNum>=frompage) and  (PageNum<=topage)) then
     begin
      for i:=0 to copies-1 do
      begin
       if printedfirst then
        Driver.NewPage(metafile.pages[0]);
       printedfirst:=true;
       Driver.DrawPage(metafile.pages[0]);
       Driver.EndPage;
       if hardwarecopies>1 then
        break;
      end;
     end;
     if pagenum=topage then
     begin
      finished:=true;
      break;
     end;
     metafile.Pages[0].Clear;
    end;
    if not finished then
    begin
     if ((PageNum>=frompage) and  (PageNum<=topage)) then
     begin
      for i:=0 to copies-1 do
      begin
       if printedfirst then
        Driver.NewPage(metafile.pages[0]);
       printedfirst:=true;
       Driver.DrawPage(metafile.pages[0]);
       if hardwarecopies>1 then
        break;
      end;
     end;
    end;
    Driver.EndDocument;
   except
    Driver.AbortDocument;
    Raise;
   end;
  finally
   EndPrint;
  end;
 finally
  printingonepass:=false;
 end;
end;


procedure TRpReport.EndPrint;
begin
 if (FExecuting) then
 begin
  if not LastPage then
  begin
   AbortingThread:=true;
{$IFDEF MSWINDOWS}
   WaitForSingleObject(FThreadExec.Handle,INFINITE);
{$ENDIF}
{$IFDEF LINUX}
   FThreadExec.WaitFor;
{$ENDIF}
  end;
 end;
 DeActivateDatasets;
 FEvaluator.Free;
 FEvaluator:=nil;
 section:=nil;
 subreport:=nil;
// FDriver:=nil;
 printing:=false;
 if (FTotalPagesList.Count>0) then
  if (not TwoPass) then
   raise Exception.Create(SRpSTwoPassReportNeeded+'-'+TranslateStr(50,'Page setup'));
 metafile.UpdateTotalPages(FTotalPagesList);
end;

function TRpReport.NextRecord(grouprestore:boolean):boolean;
var
 subrep:TRpSubreport;
 index:integeR;
{$IFDEF USERPDATASET}
 data:TRpDataset;
{$ENDIF}
begin
{$IFDEF QUERYLINKBUG}
 datainfo.DisableLinks;
{$ENDIF}
{$IFDEF USERPDATASET}
 data:=nil;
{$ENDIF}
 Result:=false;
 subrep:=Subreports.Items[CurrentSubreportIndex].SubReport;
 if Length(Trim(subrep.Alias))<1 then
  subrep.Lastrecord:=True
 else
 begin
  index:=DataInfo.IndexOf(subrep.Alias);
  if index<0 then
   Raise TRpReportException.Create(SRPAliasNotExists+subrep.alias,subrep,SRpMainDataset);
{$IFDEF USERPDATASET}
  if datainfo.Items[index].Cached then
  begin
   data:=DataInfo.Items[index].CachedDataset;
   data.DoNext;
  end
  else
{$ENDIF}
   DataInfo.Items[index].Dataset.Next;
  UpdateCachedSources(subrep.Alias);
  // Update all dependent cached datasets
  // If its the last record no group change
  if not grouprestore then
  begin
{$IFDEF USERPDATASET}
   if datainfo.Items[index].Cached then
    subrep.LastRecord:=data.Eof
   else
{$ENDIF}
    subrep.LastRecord:=datainfo.Items[index].Dataset.Eof;
  end;
  if Not Subrep.LastRecord then
  begin
   if not grouprestore then
   begin
    subrep.GroupChanged;
    if subrep.CurrentGroupIndex>0 then
    begin
     Result:=true;
{$IFDEF USERPDATASET}
     if datainfo.Items[index].Cached then
      data.DoPrior
     else
{$ENDIF}
      datainfo.Items[index].Dataset.Prior;
    end
    else
     subrep.SubReportChanged(rpDataChange);
   end
   else
    subrep.SubReportChanged(rpDataChange);
  end;

  inc(FRecordCount);

  CheckProgress(false);
 end;
{$IFDEF QUERYLINKBUG}
 datainfo.EnableLinks;
{$ENDIF}
end;



function TRpReport.NextSection(child:boolean):boolean;
var
 subrep:TRpSubreport;
 sec:TRpSection;
 oldsection:TRpSection;
// oldsectionindex:integer;
 lastdetail,firstdetail:integer;
 dataavail:boolean;
 index:integer;
 SearchGroupHeader:Boolean;
 dbinfo:TRpDatabaseInfoItem;
 doreopen:boolean;
begin
 SearchGroupHeader:=false;
 oldsection:=section;
 section:=nil;
// oldsectionindex:=currentsectionindex;
 // If the old selected section has a child subreport then execute first
 if (Assigned(oldsection) AND child) then
 begin
  if Assigned(oldsection.ChildSubReport) then
  begin
   dataavail:=false;
   subrep:=TRpSubReport(oldsection.ChildSubReport);
   if (Length(subrep.Alias)<1) then
    dataavail:=true
   else
   begin
    index:=DataInfo.IndexOf(subrep.Alias);
    if index<0 then
     Raise Exception(SRPAliasNotExists+' '+subrep.Alias);
    if Length(Datainfo.Items[index].DataSource)<1 then
    begin
     doreopen:=true;
     // for datasets unions does not read again but call first method
     dbinfo:=DatabaseInfo.ItemByName(DataInfo.Items[index].DatabaseAlias);
     if Assigned(dbinfo) then
     begin
      if dbinfo.Driver=rpdatamybase then
      begin
       Datainfo.Items[index].Dataset.First;
       doreopen:=false;
      end;
     end;
     if doreopen then
     begin
      Datainfo.Items[index].Disconnect;
      UpdateParamsBeforeOpen(index,true);
      Datainfo.Items[index].Connect(DatabaseInfo,params);
     end;
    end
    else
    begin
     if (Datainfo.Items[index].Dataset.Eof) then
     begin
      if subrep.ReOpenOnPrint then
      begin
       Datainfo.Items[index].Disconnect;
       UpdateParamsBeforeOpen(index,true);
       Datainfo.Items[index].Connect(DatabaseInfo,params);
      end
     end;
    end;
{$IFDEF USERPDATASET}
    if Datainfo.Items[index].Cached then
    begin
{     if Datainfo.Items[index].Dataset.Bof then
     begin
//      Datainfo.Items[index].CachedDataset.DoClose;
      UpdateParamsBeforeOpen(index,true);
      Datainfo.Items[index].CachedDataset.DoOpen;
     end;
}     if (Not Datainfo.Items[index].Dataset.Eof) then
     begin
      dataavail:=true;
     end
     else
       SearchGroupHeader:=true;
    end
    else
{$ENDIF}
    begin
     if (Not Datainfo.Items[index].Dataset.Eof) then
     begin
      dataavail:=true;
     end
     else
       SearchGroupHeader:=true;
    end;
   end;
   subrep.LastRecord:=Not dataavail;
   if (dataavail or (Not subrep.PrintOnlyIfDataAvailable)) then
   begin
    subrep.SubReportChanged(rpSubReportStart);
//    subrep.SubReportChanged(rpDataChange);
    subreport:=subrep;
    section:=nil;
//    oldsectionindex:=-1;
    CurrentSectionIndex:=-1;
    FPendingSections.AddObject(IntToStr(CurrentSubReportIndex),oldsection);
    CurrentSubReportIndex:=Subreports.IndexOf(subreport);
    subreport.SubReportChanged(rpDataChange);
    Subreport.CurrentGroupIndex:=-Subreport.GroupCount;
    if SubReport.CurrentGroupIndex<0 then
    begin
     CurrentSectionIndex:=Subreport.FirstDetail+SubReport.CurrentGroupIndex-1;
    end;
   end;
  end
  else
   SearchGroupHeader:=true;
 end
 else
  SearchGroupHeader:=true;
 if FGroupHeaders.Count<1 then
  SearchGroupHeader:=false;
 if SearchGroupHeader then
 begin
  index:=FGroupHeaders.IndexOfObject(oldsection);
  if index>=0 then
  begin
   FGroupHeaders.Delete(index);
   if FGroupHeaders.Count>0 then
   begin
    section:=TRpSection(FGroupHeaders.Objects[0]);
    CurrentSubReportIndex:=StrToInt(FPendingSections.Strings[FPendingSections.Count-1]);
    Subreport:=TRpSubReport(Section.SubReport);
   end
   else
   begin
    Section:=TRpSection(FPendingSections.Objects[FPendingSections.Count-1]);
    CurrentSubReportIndex:=StrToInt(FPendingSections.Strings[FPendingSections.Count-1]);
    FPendingSections.Delete(FPendingSections.Count-1);
    Subreport:=TRpSubReport(Section.SubReport);
    Currentsectionindex:=Subreport.Sections.IndexOf(Section);
   end
  end;
 end;
 if assigned(section) then
 begin
  Result:=true;
  exit;
 end;
 // Check the condition
 while CurrentSubReportIndex<Subreports.count do
 begin
  CheckProgress(false);

  subrep:=Subreports.Items[CurrentSubReportIndex].SubReport;
  // The first section are the group footers until
  // CurrentGropup
  while subrep.CurrentGroupIndex<>0 do
  begin
   CheckProgress(false);

   lastdetail:=subrep.LastDetail;
   firstdetail:=subrep.FirstDetail;
   inc(CurrentSectionIndex);
   if subrep.CurrentGroupIndex>0 then
   begin
    if subrep.CurrentGroupIndex<(CurrentSectionIndex-lastdetail) then
    begin
     // Restore position
     // And the next will be group headers
     if subrep.LastRecord then
     begin
      CurrentSectionIndex:=subrep.Sections.Count;
      subrep.CurrentGroupIndex:=0;
      break;
     end
     else
     begin
      // Send Messages for each group
      subrep.InitGroups(subrep.CurrentGroupIndex);
      // Restores position
      NextRecord(true);
      CurrentSectionIndex:=subrep.FirstDetail-subrep.CurrentGroupIndex;
      subrep.CurrentGroupIndex:=-subrep.CurrentGroupIndex;
      sec:=Subrep.Sections[CurrentSectionIndex].Section;
      if Sec.EvaluatePrintCondition then
      begin
       Section:=sec;
       Subreport:=subrep;
       break;
      end;
     end;
    end
    else
    begin
     Sec:=subrep.Sections[CurrentSectionIndex].Section;
     if Sec.EvaluatePrintCondition then
     begin
      Section:=sec;
      Subreport:=subrep;
      break;
     end;
    end;
   end
   else
   begin
    // Group headers
    if CurrentSectionIndex<firstdetail then
    begin
     sec:=Subrep.Sections.Items[CurrentSectionIndex].Section;
     if sec.EvaluatePrintCondition then
     begin
      Section:=sec;
      Subreport:=subrep;
      break;
     end;
    end
    else
    begin
     subrep.CurrentGroupIndex:=0;
     CurrentSectionIndex:=-1;
    end;
   end;
  end;
  if Assigned(section) then
   break;
  while CurrentSectionIndex<subrep.Sections.Count do
  begin
   CheckProgress(false);
   if CurrentSectionIndex<0 then
    CurrentSectionIndex:=subrep.FirstDetail
   else
    inc(CurrentSectionIndex);
   if Not subrep.LastRecord then
   begin
    if CurrentSectionIndex>subrep.LastDetail then
    begin
//     if oldsectionindex>=0 then
      if NextRecord(false) then
      begin
       CurrentSectionIndex:=subrep.LastDetail;
       break;
      end;
     if Not subrep.LastRecord then
     begin
      CurrentSectionIndex:=subrep.FirstDetail;
      sec:=Subrep.Sections.Items[CurrentSectionIndex].Section;
      if sec.EvaluatePrintCondition then
      begin
       Section:=sec;
       subreport:=subrep;
       break;
      end;
     end
     else
     begin
      CurrentSectionIndex:=subrep.LastDetail;
      subrep.CurrentGroupIndex:=subrep.GroupCount;
      break;
     end;
    end
    else
    begin
     if CurrentSectionIndex<=subrep.LastDetail then
     begin
      sec:=Subrep.Sections.Items[CurrentSectionIndex].Section;
      if sec.EvaluatePrintCondition then
      begin
       Section:=sec;
       subreport:=subrep;
       break;
      end;
     end;
    end;
   end;
  end;
  if ((Not assigned(Section)) AND (subrep.CurrentGroupIndex=0)) then
  begin
   // If it's a child subreport
   // Returns null section so pending will print
   if Assigned(subrep.ParentSubReport) then
    break;
   repeat
    subrep.SubReportChanged(rpSubReportEnd);
    inc(CurrentSubReportIndex);
    if CurrentSubReportIndex>=Subreports.count then
     break;
    subrep:=Subreports.Items[CurrentSubReportIndex].SubReport;
    if subrep.ParentSubreport=nil then
    begin
     if subrep.IsDataAvailable then
     begin
      subrep.SubReportChanged(rpSubReportStart);
      subrep.SubReportChanged(rpDataChange);
      break;
     end;
    end;
   until false;
   if CurrentSubReportIndex>=Subreports.count then
    break;
//   subrep.SubReportChanged(rpDataChange);
   CurrentSectionIndex:=subrep.FirstDetail-subrep.GroupCount-1;
   subrep.CurrentGroupIndex:=-subrep.GroupCount;
   subrep.LastRecord:=false;
  end
  else
   if subrep.CurrentGroupIndex=0 then
     break;
 end;

 Result:=Assigned(Section);
 // If there are still pending sections
 if not Assigned(Section) then
 begin
  if FPendingSections.Count>0 then
  begin
   //
   Section:=TRpSection(FPendingSections.Objects[FPendingSections.Count-1]);
   CurrentSubReportIndex:=StrToInt(FPendingSections.Strings[FPendingSections.Count-1]);
   FPendingSections.Delete(FPendingSections.Count-1);
   Subreport:=TRpSubReport(Section.SubReport);
   Currentsectionindex:=Subreport.Sections.IndexOf(Section);
   NextSection(false);
  end;
 end;
end;





procedure TRpReport.DoUpdatepageSize(Driver:TRpPrintDriver;metafilepage:TRpMetafilePage);
var
 apagesize:TPoint;
begin
 // Sets page orientation and size
 rpagesizeqt.PhysicWidth:=metafile.CustomX;
 rpagesizeqt.PhysicHeight:=metafile.CustomY;
 metafilepage.Orientation:=currentorientation;
 metafilepage.PageSizeqt:=rPageSizeQt;
 if Not FUpdatePageSize then
  exit;
 metafilepage.UpdatedPageSize:=true;
 // Sets and gets page size from the driver
 Driver.SetOrientation(currentorientation);
 if PageSize<>rpPageSizeDefault then
 begin
  apagesize:=Driver.SetPagesize(rPageSizeQt);
 end
 else
 begin
  apagesize:=Driver.GetPageSize(rPageSizeqt.indexqt);
 end;
 FInternalPageWidth:=apagesize.X;
 FInternalPageHeight:=apagesize.Y;

 rpagesizeqt.PhysicWidth:=apagesize.X;
 rpagesizeqt.PhysicHeight:=apagesize.Y;
 metafilepage.PageSizeqt:=rPageSizeQt;
end;

procedure TRpReport.BeginPrint(Driver:TRpPrintDriver);
var
 i,index:integer;
 item:TRpAliaslistItem;
 apagesize:TPoint;
 paramname:string;
 subrep:TRpSubReport;
 dataavail:Boolean;
 newpagesize:integer;
begin
 params.UpdateInitialValues;
 maximum_width:=0;
 maximum_height:=0;
 FUpdatePageSize:=false;
 FillGlobalHeaders;
 FDriver:=Driver;
 FPendingSections.Clear;
 errorprocessing:=false;
 AbortingThread:=false;
 if Not Assigned(FDriver) then
  Raise Exception.Create(SRpNoDriverPassedToPrint);
 if (not Metafile.BlockPrinterSelection) then
  Driver.SelectPrinter(PrinterSelect);
 if FCompose then
 begin
  printingonepass:=false;
  FInternalPageWidth:=metafile.CustomX;
  FInternalPageHeight:=metafile.CustomY;
  PageNum:=metafile.CurrentPageCount-2;
 end
 else
 begin
  metafile.Clear;
  metafile.Copies := Copies;
  metafile.PreviewAbout:=PreviewAbout;
  metafile.PreviewMargins:=PreviewMargins;
  metafile.LinesPerInch:=LinesPerInch;
  ClearTotalPagesList;
  // Sets page orientation
  currentorientation:=PageOrientation;
  if PageOrientation<>rpOrientationDefault then
  begin
   FDriver.SetOrientation(PageOrientation);
  end;
  rPageSizeQt.papersource:=papersource;
  rPageSizeQt.duplex:=duplex;
  SetForcePaperName(rpagesizeqt,forcepapername);
  metafile.ForcePaperName:=ForcePaperName;
  if PageSize<>rpPageSizeDefault then
  begin
   if PageSize=rpPageSizeUser then
   begin
     metafile.PageSize:=-1;
    rPageSizeQt.Indexqt:=PageSizeQt;
    rPageSizeQt.Custom:=true;
    rPageSizeQt.CustomWidth:=CustomPageWidth;
    rPageSizeQt.Customheight:=CustomPageHeight;
   end
   else
   begin
    metafile.PageSize:=PageSizeQt;
    rPageSizeQt.Indexqt:=PageSizeQt;
    rPageSizeQt.Custom:=false;
    rPageSizeQt.CustomWidth:=CustomPageWidth;
    rPageSizeQt.Customheight:=CustomPageHeight;
   end;
   apagesize:=Driver.SetPagesize(rPageSizeQt);
  end
  else
  begin
   newpagesize:=metafile.PageSize;
   apagesize:=Driver.GetPageSize(newpagesize);
   metafile.PageSize:=newpagesize;
  end;
  FInternalPageWidth:=apagesize.X;
  FInternalPageHeight:=apagesize.Y;
  metafile.Orientation:=PageOrientation;
  metafile.Duplex:=duplex;
  metafile.BackColor:=PageBackColor;
  metafile.CustomX:=FInternalPageWidth;
  metafile.CustomY:=FInternalPageHeight;
  PageNum:=-1;
 end;
 metafile.PrinterSelect:=PrinterSelect;
 metafile.PreviewStyle:=PreviewStyle;
 metafile.PreviewWindow:=PreviewWindow;
 metafile.OpenDrawerBefore:=rpDrawerBefore in ReportAction;
 metafile.OpenDrawerAfter:=rpDrawerAfter in ReportAction;
 for i:=0 to SubReports.Count-1 do
 begin
  Subreports.Items[i].Subreport.LastRecord:=false;
 end;
 // Get the time
{$IFDEF MSWINDOWS}
 mmfirst:=TimeGetTime;
{$ENDIF}
{$IFDEF LINUX}
 milifirst:=now;
{$ENDIF}
 LastPage:=false;
 EndPrint;
 // Evaluator
 InitEvaluator;


 PageNumGroup:=-1;
 FRecordCount:=0;

 // Add the report items to the evaluator
 AddReportItemsToEvaluator(FEvaluator);
 // Maybe parameters are used in ActivateDatasets (BDESetRange)

 // Evaluates parameter expressions before open
 for i:=0 to Params.Count-1 do
 begin
  if params.items[i].ParamType=rpParamExpreB then
  begin
   paramname:=params.items[i].Name;
   try
    if Not VarIsNull(params.items[i].Value) then
    begin
     FEvaluator.EvaluateText(paramname+':=('+String(params.items[i].Value)+')');
     params.items[i].LastValue:=FEvaluator.EvaluateText(paramname);
    end;
   except
    on E:Exception do
    begin
{$IFDEF DOTNETD}
     Raise Exception.Create(E.Message+SRpParameter+'-'+paramname);
{$ENDIF}
{$IFNDEF DOTNETD}
     E.Message:=E.Message+SRpParameter+'-'+paramname;
     Raise;
{$ENDIF}
    end;
   end;
  end
  else
  begin
   params.Items[i].LastValue:=params.Items[i].ListValue;
  end;
 end;


 FDataAlias.List.Clear;
 for i:=0 to DataInfo.Count-1 do
 begin
  item:=FDataAlias.List.Add;
  item.Alias:=DataInfo.Items[i].Alias;
  DataInfo.Items[i].OnConnect:=item.CacheFields;
  DataInfo.Items[i].OnDisConnect:=item.UnCacheFields;
 end;


 ActivateDatasets;
 try
  // After activating dataset we must check wich subreport to activate
  // if printonly if data avaliable report option is check
  CheckIfDataAvailable;
 except
  DeActivateDatasets;
  Raise;
 end;


 for i:=0 to DataInfo.Count-1 do
 begin
  index:=FDataAlias.List.indexof(DataInfo.Items[i].Alias);
  item:=FDataAlias.List.Items[index];
{$IFDEF USERPDATASET}
  if Datainfo.Items[i].Cached then
   item.Dataset:=DataInfo.Items[i].CachedDataset
  else
{$ENDIF}
   item.Dataset:=DataInfo.Items[i].Dataset;
 end;
 FEvaluator.Rpalias:=FDataAlias;

 // Evaluates parameter expressions after open
 for i:=0 to Params.Count-1 do
 begin
  if params.items[i].ParamType=rpParamExpreA then
  begin
   paramname:=params.items[i].Name;
   try
    if Not VarIsNull(params.items[i].Value) then
    FEvaluator.EvaluateText(paramname+':=('+String(params.items[i].Value)+')')
   except
    on E:Exception do
    begin
{$IFDEF DOTNETD}
     Raise Exception.Create(E.Message+SRpParameter+'-'+paramname);
{$ENDIF}
{$IFNDEF DOTNETD}
     E.Message:=E.Message+SRpParameter+'-'+paramname;
     Raise;
{$ENDIF}
    end;
   end;
  end;
 end;
 // Load External sections
 LoadExternals;

 // Sends the message report header to all components

 for i:=0 to SubReports.Count-1 do
 begin
  Subreports.Items[i].Subreport.SubReportChanged(rpReportStart);
 end;

 CurrentSubReportIndex:=-1;
 dataavail:=False;
 repeat
  inc(CurrentSubReportIndex);
  if CurrentSubReportIndex>=Subreports.count then
   break;
  subrep:=subreports.Items[CurrentSubReportIndex].SubReport;
  if Not Assigned(subrep.ParentSubReport) then
  begin
   if (Length(subrep.Alias)<1) then
    dataavail:=true
   else
   begin
    if subrep.PrintOnlyIfDataAvailable then
    begin
     index:=DataInfo.IndexOf(subrep.Alias);
{$IFDEF USERPDATASET}
     if Datainfo.Items[index].Cached then
     begin
      if (Not Datainfo.Items[index].CachedDataset.Eof) then
      begin
       dataavail:=true;
      end;
     end
     else
{$ENDIF}
     begin
      if (Not Datainfo.Items[index].Dataset.Eof) then
      begin
       dataavail:=true;
      end;
     end;
    end
    else
    begin
     dataavail:=true;
    end;
   end;
  end;
  if dataavail then
  begin
   subrep.SubReportChanged(rpSubReportStart);
   subrep.SubReportChanged(rpDataChange);
   CurrentSectionIndex:=-1;
   Subrep.CurrentGroupIndex:=-subrep.GroupCount;
   if subrep.CurrentGroupIndex<0 then
   begin
    CurrentSectionIndex:=subrep.FirstDetail+subrep.CurrentGroupIndex-1;
   end;
   section:=nil;
   subreport:=nil;
   if Not NextSection(true) then
    dataavail:=false;
  end;
 until dataavail;
 if not dataavail then
 begin
  EndPrint;
  Raise Exception.Create(SRpNoDataAvailableToPrint);
 end;
 printing:=True;
end;

// Resturns true if is the last pabe
function TRpReport.PrintNextPage:boolean;
var
 sectionext:TPoint;
 pagefooters:TStringList;
 asection:TrpSection;
 pagefooterpos:integer;
 havepagefooters:boolean;
 oldsubreport:TRpSubreport;
 i,oldhorzdespposition:integer;
 pagespacex:integer;
 sectionextevaluated:boolean;
 PartialPrint:Boolean;
 MaxExtent:TPoint;
 lastvertpos:TPoint;
 oldpageposx:Integer;


procedure SkipToPageAndPosition;
var
 newpage:integer;
 newposx,newposy:integer;
 moveh,movev:boolean;
begin
 newposx:=0;
 newposy:=0;
 try
  // Go to page?
  if Length(asection.SkipToPageExpre)>0 then
  begin
   if not TwoPass then
    Raise Exception.Create(SRpSTwoPassReportNeeded);
   newpage:=Evaluator.EvaluateText(asection.SkipToPageExpre);
   newpage:=newpage-1;
   if newpage<0 then
    // Loadstr(960)?
    Raise Exception.Create(SRpCannotCombine);
   while newpage>Metafile.CurrentPageCount do
   begin
    Metafile.NewPage;
    Metafile.Pages[Metafile.CurrentPageCount-1].Orientation:=currentorientation;
    Metafile.Pages[Metafile.CurrentPageCount-1].PageSizeQt:=rpagesizeqt;
    CheckProgress(false);
   end;
   Metafile.CurrentPage:=newpage;
   PageNum:=Metafile.CurrentPage;
  end;
 except
  on E:Exception do
  begin
   Raise TRpReportException.Create(E.Message,asection,SRPSkipPage);
  end;
 end;
 moveh:=false;
 try
  // Go to page?
  if Length(asection.SkipExpreH)>0 then
  begin
   newposx:=Evaluator.EvaluateText(asection.SkipExpreH);
   moveh:=true;
  end;
 except
  on E:Exception do
  begin
   Raise TRpReportException.Create(E.Message,asection,SRpSHSkipExpre);
  end;
 end;
 movev:=false;
 try
  // Go to page?
  if Length(asection.SkipExpreV)>0 then
  begin
   newposy:=Evaluator.EvaluateText(asection.SkipExpreV);
   movev:=true;
  end;
 except
  on E:Exception do
  begin
   Raise TRpReportException.Create(E.Message,asection,SRpSVSkipExpre);
  end;
 end;
 if moveh then
 begin
  if asection.SkipRelativeH then
   pageposx:=pageposx+newposx
  else
//   pageposx:=FLeftMargin+newposx;
   pageposx:=newposx;
 end;
 if movev then
 begin
  if asection.SkipRelativeV then
   pageposy:=pageposy+newposy
  else
//   pageposy:=FTopMargin+newposy;
   pageposy:=newposy;
 end;
// freespace:=FInternalPageheight-pageposy;
 freespace:=pagefooterpos-pageposy;
 if freespace<0 then
  freespace:=0;
end;

function CheckSpace:boolean;
var
 MaxExtent:TPoint;
begin
 if freespace=0 then
 begin
  Result:=false;
  exit;
 end;
 MaxExtent.x:=pagespacex;
 MaxExtent.y:=freespace;
 if not sectionextevaluated then
 begin
  // Skip to page and position
  if asection.SkipType=secskipbefore then
   SkipToPageAndPosition;
  sectionext:=asection.GetExtension(FDriver,MaxExtent,false);
 end;
 Result:=true;
 if sectionext.Y>freespace then
 begin
  if printedsomething then
  begin
   Result:=false;
  end
  else
  begin
   // Retry forcing printing partial texts
   // else it can not be printed
   sectionext:=asection.GetExtension(FDriver,MaxExtent,true);
   if sectionext.Y>freespace then
    Raise Exception.Create(SRpNoSpaceToPrint+' '+
     SRpSubReport+':'+IntToStr(CurrentSubReportIndex)+' '+
     SRpSection+':'+IntToStr(CurrentSectionIndex));
  end;
 end;
 sectionextevaluated:=false;
end;

procedure PrintSection(adriver:TRpPrintDriver;datasection:boolean;var PartialPrint:Boolean);
var
 MaxExtent:TPoint;
 ispagerepeat:boolean;
begin
 if subreport.CurrentGroupIndex<0 then
 begin
  if section.groupname=
   subreport.Sections[SubReport.FirstDetail+subreport.CurrentGroupIndex].Section.groupname then
  begin
   if section.IniNumPage then
    PageNumGroup:=0;
   section.FirstPage:=metafile.CurrentPage;
  end;
 end;
 pagefooterpos:=pageposy+freespace;
 PartialPrint:=False;
 MaxExtent.x:=pagespacex;
 MaxExtent.y:=freespace;

 if datasection then
 begin
  ispagerepeat:=false;
  if asection.SectionType=rpsecgheader then
   ispagerepeat:=asection.Pagerepeat;
  if Not ispagerepeat then
  begin
   oldprintedsection:=section;
   oldprintedsectionext:=sectionext;
   // If the section have been derived from a page repeat
   //...
   if FGroupHeaders.Count<1 then
    printedsomething:=true;
  end;
 end;
 // If the section is not aligned at bottom of the page then
 if Not asection.AlignBottom then
 begin
  asection.Print(adriver,pageposx,pageposy,-1,-1,metafile,MaxExtent,PartialPrint);
  freespace:=freespace-sectionext.Y;
  pageposy:=pageposy+sectionext.Y;
  maximum_height:=pageposy;
 end
 else
 // Align to bottom
 begin
  pageposy:=pageposy+freespace-sectionext.Y;
  asection.Print(adriver,pageposx,pageposy,-1,-1,metafile,MaxExtent,PartialPrint);
  freespace:=0;
  if ((pageposy+sectionext.Y)>maximum_height) then
   maximum_height:=pageposy+sectionext.Y;
 end;
 if (sectionext.X>maximum_width) then
  maximum_width:=sectionext.X;
 if asection.SkipType=secskipafter then
  SkipToPageAndPosition;
end;

procedure PrintFixedSections(adriver:TRpPrintDriver;headers:boolean);
var
 pheader,pfooter:integer;
 pheadercount,pfootercount:integer;
 i,j,index:integer;
 psection:TRpSection;
 afirstdetail:integer;
 printit:boolean;
 MaxExtent:TPoint;
 PartialPrint:Boolean;
 psubreports:TStringList;
 subrep:TRpSubReport;
 dopagerepeat:boolean;
begin
 PartialPrint:=false;
 MaxExtent.x:=pagespacex;
 MaxExtent.y:=freespace;
 if Headers then
 begin
  // First the global headers
  for i:=0 to gheaders.count-1 do
  begin
   psection:=TRpSection(gheaders.Items[i]);
   if psection.EvaluatePrintCondition then
   begin
    asection:=psection;
    CheckSpace;
    PrintSection(adriver,false,PartialPrint);
   end;
  end;

  // Print the header fixed sections
  pheader:=subreport.FirstPageHeader;
  pheadercount:=subreport.PageHeaderCount;
  for i:=0 to pheadercount-1 do
  begin
   psection:=subreport.Sections.Items[i+pheader].Section;
   if Not psection.Global then
   begin
    if psection.EvaluatePrintCondition then
    begin
     asection:=psection;
     CheckSpace;
     PrintSection(adriver,false,PartialPrint);
    end;
   end;
  end;
  psubreports:=TStringList.Create;
  try
   for i:=0 to FPendingSections.Count-1 do
   begin
    psection:=TRpSection(FPendingSections.Objects[i]);
    index:=psubreports.IndexOf(psection.SubReport.Name);
    if index<0 then
     psubreports.AddObject(psection.SubReport.Name,psection.SubReport);
   end;
   index:=psubreports.IndexOf(subreport.Name);
   if index<0 then
    psubreports.AddObject(subreport.Name,subreport);
   // Now prints repeated group headers for all pending subreports
   for j:=0 to psubreports.Count-1 do
   begin
    subrep:=TRpSubReport(psubreports.Objects[j]);
    afirstdetail:=subrep.FirstDetail;
    for i:=subrep.GroupCount downto 1 do
    begin
     psection:=subrep.Sections.Items[afirstdetail-i].Section;
     if psection.PageRepeat then
     begin
      dopagerepeat:=false;
      // Allways if there is another active subreport
      if (subrep <> subreport) then
      begin
       if (psection.FooterAtReportEnd) then
         dopagerepeat := true
      end
      else
      begin
       // Never if the current section is just the group header
       if (section <> psection) then
       begin
        // If the section is enclosed between the header
        // and the footer (footer included)
        if (CurrentSectionIndex > subrep.FirstDetail - i) then
        begin
         // Force print even if the footer is pending
         if psection.FooterAtReportEnd then
         begin
          if (CurrentSectionIndex <= subrep.LastDetail + i) then
           dopagerepeat := true;
         end
         else
         begin
          // Print only if the current secion is lower than the footer
          if (CurrentSectionIndex < subrep.LastDetail + i) then
           dopagerepeat := true;
         end;
        end;
       end;
      end;
      if (dopagerepeat) then
//      if ((Abs(subrep.CurrentGroupIndex)<=i) and (section<>psection)) then
      begin
       if psection.EvaluatePrintCondition then
       begin
         FGroupHeaders.AddObject(psection.GroupName,psection)
       end;
      end;
     end;
    end;
   end;
  finally
   psubreports.free;
  end;
  pagefooterpos:=pageposy+freespace;
  // Reserve space for page footers
  // Print conditions for footers are evaluated at the begining of
  // the page

  // Global page footers
  for i:=0 to gfooters.count-1 do
  begin
   psection:=TRpSection(gfooters.Items[i]);
   asection:=psection;
   CheckSpace;
   pagefooterpos:=pageposy+freespace-sectionext.Y;
   freespace:=freespace-sectionext.Y;
  end;

  pfooter:=subreport.FirstPageFooter;
  pfootercount:=subreport.PageFooterCount;
  for i:=0 to pfootercount-1 do
  begin
   psection:=subreport.Sections.Items[i+pfooter].Section;
   if Not psection.Global then
   begin
    asection:=psection;
    havepagefooters:=true;
    CheckSpace;
    pagefooters.add(IntToStr(i+pfooter));
    pagefooterpos:=pageposy+freespace-sectionext.Y;
    freespace:=freespace-sectionext.Y;
   end;
  end;
 end
 else
 begin
  // Print page footers
  if ((gfooters.Count>0) or (pagefooters.Count>0)) then
  begin
   pageposy:=pagefooterpos;
   for i:=0 to pagefooters.Count-1 do
   begin
    asection:=oldsubreport.Sections.Items[StrToInt(pagefooters.Strings[i])].Section;
    if not asection.global then
    begin
     printit:=true;
     if Not asection.FooterAtReportEnd then
     begin
      if Not Assigned(Section) then
       printit:=false;
     end;
     sectionext:=asection.GetExtension(FDriver,MaxExtent,false);
     if printit then
      if asection.EvaluatePrintCondition then
      begin
       PrintSection(adriver,false,PartialPrint);
       freespace:=0;
      end;
    end;
   end;
   // Global page footers
   for i:=0 to gfooters.count-1 do
   begin
    asection:=TRpSection(gfooters.Items[i]);
    printit:=true;
    if Not asection.FooterAtReportEnd then
    begin
     if Not Assigned(Section) then
      printit:=false;
    end;
    sectionext:=asection.GetExtension(FDriver,MaxExtent,false);
    if printit then
     if asection.EvaluatePrintCondition then
     begin
      PrintSection(adriver,false,PartialPrint);
      freespace:=0;
     end;
   end;
  end;
 end;
end;


begin
 if errorprocessing then
  Raise Exception.Create(SRpErrorProcessing+#10+lasterrorprocessing);
 inc(Pagenum);
 inc(Pagenumgroup);

 // Updates page size, and orientation
 if not printingonepass then
 begin
  if metafile.CurrentPageCount<=PageNum then
  begin
   metafile.NewPage;
  end;
  metafile.CurrentPage:=PageNum;
 end
 else
 begin
  if metafile.CurrentPageCount<1 then
  begin
   metafile.NewPage;
  end
  else
   metafile.Pages[0].Clear;
 end;
 DoUpdatePageSize(FDriver,Metafile.Pages[Metafile.CurrentPageCount-1]);


 FGroupHeaders.Clear;
 printedsomething:=false;
 if Not Assigned(Section) then
  Raise Exception.Create(SRpLastPageReached);
 if assigned(subreport) then
 begin
  for i:=0 to SubReports.Count-1 do
  begin
   subreports.Items[i].Subreport.SubReportChanged(rpPageChange);
  end;
 end;
 havepagefooters:=false;
 sectionextevaluated:=false;
 if Not FCompose then
 begin
  freespace:=FInternalPageheight;
  freespace:=freespace-TopMargin-BottomMargin;
  pageposy:=TopMargin;
  pageposx:=LeftMargin;
  oldprintedsection:=nil;
 end
 else
 begin
  if (gheaders.count>0) or (subreport.PageHeaderCount>0) then
  begin
   // Create new page
   metafile.NewPage;
   inc(PageNum);
   metafile.CurrentPage:=Metafile.CurrentPageCount-1;
   freespace:=FInternalPageheight;
   freespace:=freespace-TopMargin-BottomMargin;
   pageposy:=TopMargin;
   pageposx:=LeftMargin;
   DoUpdatePageSize(FDriver,Metafile.Pages[Metafile.CurrentPageCount-1]);
  end
  else
  begin
   printedsomething:=true;
  end;
  FCompose:=false;
 end;


 pagespacex:=FInternalPageWidth;
 oldhorzdespposition:=LeftMargin;


 pagefooters:=TStringList.Create;
 try
  // Fills the page with fixed sections
  PrintFixedSections(FDriver,true);
  // Group headers with child subreports
  if FGroupHeaders.Count>0 then
  begin
   FPendingSections.AddObject(IntToStr(CurrentSubReportIndex),section);
   section:=TRpSection(FGroupHeaders.Objects[0]);
  end;
  oldsubreport:=subreport;
  lastvertpos.x:=pageposx;
  lastvertpos.y:=pageposy;
  while Assigned(section)  do
  begin
   if printedsomething then
   begin
    if section.EvaluateBeginPage then
     break;
   end;
   asection:=section;
   // Horz.Desp.
   if Assigned(oldprintedsection) then
   begin
    if oldprintedsection.HorzDesp then
    begin
     if section.HorzDesp then
     begin
      MaxExtent.x:=pagespacex;
      MaxExtent.y:=freespace;
      sectionext:=section.GetExtension(FDriver,MaxExtent,false);
      sectionextevaluated:=true;
      if (pageposx+oldprintedsectionext.X+sectionext.X)<=pagespacex then
      begin
       pageposx:=pageposx+oldprintedsectionext.X;
       pageposy:=pageposy-oldprintedsectionext.Y;
       freespace:=freespace+oldprintedsectionext.Y;
      end
      else
       pageposx:=LeftMargin;
     end
     else
     begin
      pageposx:=oldhorzdespposition;
     end;
    end
    else
     oldhorzdespposition:=pageposx;
   end;
   if Not CheckSpace then
   begin
    // If the current section have vert desp, do
    // a vertical and horz. desp if possible
    if section.VertDesp then
    begin
     // Go to old vertical position if fits horizontally
     MaxExtent.x:=pagespacex;
     MaxExtent.y:=lastvertpos.y-BottomMargin;
     sectionext:=section.GetExtension(FDriver,MaxExtent,false);
     sectionextevaluated:=true;
     if (pageposx+sectionext.X*2)<=pagespacex then
     begin
       freespace:=freespace+(pageposy-lastvertpos.y);
       pageposx:=pageposx+sectionext.X;
       pageposy:=lastvertpos.y;
     end
     else
     begin
      pageposx:=LeftMargin;
      break;
     end;
     if Not CheckSpace then
      break;
    end
    else
     break;
   end;
   PartialPrint:=False;
   PrintSection(FDriver,true,PartialPrint);
   if Not PartialPrint then
   begin
    if (Not section.VertDesp) then
    begin
     lastvertpos.x:=pageposx;
     lastvertpos.y:=pageposy;
    end;
    NextSection(true);
    if assigned(section) then
    begin
     if (Not section.VertDesp) then
     begin
      lastvertpos.x:=pageposx;
      lastvertpos.y:=pageposy;
     end;
    end;
   end;
   if printedsomething then
   begin
    if asection.SkipPage then
     break;
   end;
   // if Subreport changed and has have pagefooter
   if ((oldsubreport<>subreport) and (havepagefooters)) then
    break;
   oldsubreport:=subreport;
  end;
  // Fills the page with fixed sections
  oldpageposx:=pageposx;
  if PrintedSomething then
  begin
   if Assigned(oldprintedsection) then
   begin
    if oldprintedsection.HorzDesp then
    begin
     pageposx:=oldhorzdespposition;
    end;
   end;
  end;
  PrintFixedSections(FDriver,false);
  pageposx:=oldpageposx;
  pagefooters.Free;
 except
  on E:Exception do
  begin
   pagefooters.Free;
   errorprocessing:=true;
   lasterrorprocessing:=E.Message;
   raise;
  end;
 end;
 Result:=Not Assigned(Section);
 LastPage:=Result;
 if LastPage then
 begin
  CheckProgress(true);
  metafile.Finish;
 end;
 if Result then
 begin
  EndPrint;
 end;
end;



procedure RegisterRpReportClasses;
begin
 Classes.RegisterClass(TRpCommonComponent);
 Classes.RegisterClass(TRpCommonPosComponent);
 Classes.RegisterClass(TRpSection);
 Classes.RegisterClass(TRpSubReport);
 Classes.RegisterClass(TRpGenTextComponent);
 Classes.RegisterClass(TRpLabel);
 Classes.RegisterClass(TRpExpression);
 Classes.RegisterClass(TRpBaseReport);
 Classes.RegisterClass(TRpReport);
 Classes.RegisterClass(TRpImage);
 Classes.RegisterClass(TRpShape);
 Classes.RegisterClass(TRpChart);
 Classes.RegisterClass(TRpBarcode);
end;




initialization
 // Need clas registration to be streamable
 RegisterRpReportClasses;
end.
