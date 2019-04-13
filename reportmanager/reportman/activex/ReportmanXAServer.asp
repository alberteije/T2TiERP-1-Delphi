<%@ Language=VBScript %>
<% Set Reportobj = Server.CreateObject("ReportMan.ReportmanX") 
   ReportObj.Filename = "c:\inetpub\wwwroot\cgi-bin\nettest.rep"
   Set DelphiASPObj = Server.CreateObject("ReportMan.ReportmanXAServer") 
   Response.Clear 
   Response.ContentType="application/pdf"
   DelphiASPObj.GetPDF ReportObj.Report,false
%>
