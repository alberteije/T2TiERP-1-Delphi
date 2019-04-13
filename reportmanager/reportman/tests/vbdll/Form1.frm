VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3090
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3090
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   360
      TabIndex        =   1
      Text            =   "Text1"
      Top             =   1080
      Width           =   1575
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   495
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   1575
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
 Dim rhan As Long
 Dim paramcount As Long
 Dim paramname As String
 Dim ares As Long
 Dim Avar As Variant
 
 
 paramname = "                                  "
 rhan = rp_open("samplevb.rep")
 MsgBox (Str(rhan))
 If rhan = 0 Then
  Text1.Text = rp_lasterror
 Else
  Text1.Text = Str(rhan)
  Avar = "TESTING PARAM"
  ares = rp_setparamvaluevar(rhan, "PARAMETER1", Avar)
  Avar = 24
  ares = rp_setparamvaluevar(rhan, "PARAMETER2", Avar)
  ares = rp_getparamcount(rhan, paramcount)
  MsgBox (paramcount)
  ares = rp_getparamname(rhan, 0, paramname)
  MsgBox (paramname)
  If ares = 0 Then
   Text1.Text = rp_lasterror
  Else
   ares = rp_preview(rhan, "Hello from VB")
  End If
  rp_close (rhan)
 End If
End Sub
