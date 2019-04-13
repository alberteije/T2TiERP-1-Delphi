object ReportManServer: TReportManServer
  OldCreateOrder = False
  OnCreate = ServiceCreate
  DisplayName = 'Report Manager Service'
  OnContinue = ServiceContinue
  OnPause = ServicePause
  OnShutdown = ServiceShutdown
  OnStart = ServiceStart
  OnStop = ServiceStop
  Left = 192
  Top = 114
  Height = 150
  Width = 215
end
