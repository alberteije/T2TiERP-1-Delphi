VERSION 5.00
Object = "{D4D26F6B-6564-44F4-A913-03C91CE37740}#2.1#0"; "Reportman.ocx"
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   7170
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   9135
   LinkTopic       =   "Form1"
   ScaleHeight     =   7170
   ScaleWidth      =   9135
   StartUpPosition =   3  'Windows Default
   Begin Reportman.PreviewControl PreviewControl1 
      Height          =   6135
      Left            =   120
      TabIndex        =   1
      Top             =   840
      Width           =   8655
      Object.Visible         =   -1  'True
      AutoScroll      =   0   'False
      AutoSize        =   0   'False
      AxBorderStyle   =   1
      Caption         =   "PreviewControl"
      Color           =   -16777201
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      KeyPreview      =   0   'False
      PixelsPerInch   =   96
      PrintScale      =   1
      Scaled          =   -1  'True
      DropTarget      =   0   'False
      HelpFile        =   ""
      DoubleBuffered  =   0   'False
      Enabled         =   -1  'True
      Cursor          =   0
      AutoScale       =   4
      PreviewScale    =   0.01
      EntirePageCount =   1
      EntireTopDown   =   0   'False
      Page            =   -1
      Finished        =   0   'False
   End
   Begin Reportman.ReportManX ReportManX1 
      Height          =   300
      Left            =   480
      TabIndex        =   0
      Top             =   240
      Width           =   1125
      filename        =   ""
      Preview         =   0   'False
      ShowProgress    =   0   'False
      ShowPrintDialog =   0   'False
      Title           =   ""
      Language        =   0
      DoubleBuffered  =   0   'False
      Enabled         =   -1  'True
      Object.Visible         =   -1  'True
      Cursor          =   0
      HelpType        =   0
      HelpKeyword     =   ""
      DefaultPrinter  =   "Epson FX-880"
      AsyncExecution  =   0   'False
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Command2"
      Height          =   495
      Left            =   3840
      TabIndex        =   3
      Top             =   120
      Width           =   495
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   495
      Left            =   1800
      TabIndex        =   2
      Top             =   120
      Width           =   1695
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
  ReportManX1.FileName = "c:\cinta.rep"
  PreviewControl1.EntirePageCount = 2
  PreviewControl1.SetReport ReportManX1.Report
Rem  ReportManX1.Preview = True
Rem   ReportManX1.Execute
  
End Sub

Private Sub Command2_Click()
 PreviewControl1.NextPage
End Sub

Private Sub PreviewControl1_OnPageDrawn(ByVal PageDrawn As Long, ByVal PagesDrawn As Long)
 Command1.Caption = Str(PageDrawn)
End Sub
