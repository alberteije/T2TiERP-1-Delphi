unit rpnetpreview;

interface

uses
  System.Drawing, System.Collections, System.ComponentModel,
  System.Windows.Forms, System.Data, System.Resources;

type
  FRpNetPreview = class(System.Windows.Forms.Form)
  {$REGION 'Designer Managed Code'}
  strict private
    /// <summary>
    /// Required designer variable.
    /// </summary>
    components: System.ComponentModel.IContainer;
    BToolBar: System.Windows.Forms.ToolBar;
    Imalist: System.Windows.Forms.ImageList;
    BPrior: System.Windows.Forms.ToolBarButton;
    BNext: System.Windows.Forms.ToolBarButton;
    BLast: System.Windows.Forms.ToolBarButton;
    ImageContainer: System.Windows.Forms.Panel;
    AImage: System.Windows.Forms.PictureBox;
    BPrint: System.Windows.Forms.ToolBarButton;
    BSave: System.Windows.Forms.ToolBarButton;
    BParameters: System.Windows.Forms.ToolBarButton;
    BScale1: System.Windows.Forms.ToolBarButton;
    BScaleWide: System.Windows.Forms.ToolBarButton;
    BScaleFull: System.Windows.Forms.ToolBarButton;
    BZoomplus: System.Windows.Forms.ToolBarButton;
    BZoomMinus: System.Windows.Forms.ToolBarButton;
    BExit: System.Windows.Forms.ToolBarButton;
    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    procedure InitializeComponent;
    procedure FRpNetPreview_Load(sender: System.Object; e: System.EventArgs);
    procedure BToolBar_ButtonClick(sender: System.Object; e: System.Windows.Forms.ToolBarButtonClickEventArgs);
  {$ENDREGION}
  strict protected
    /// <summary>
    /// Clean up any resources being used.
    /// </summary>
    procedure Dispose(Disposing: Boolean); override;
  public
    printed:Boolean;
    BFirst: System.Windows.Forms.ToolBarButton;
    constructor Create;
  end;

function ShowPreview(caption:string):boolean;

implementation

{$R 'rpnetpreview.FRpNetPreview.resources'}

{$REGION 'Windows Form Designer generated code'}
/// <summary>
/// Required method for Designer support - do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure FRpNetPreview.InitializeComponent;
type
  TSystem_Windows_Forms_ToolBarButtonArray = array of System.Windows.Forms.ToolBarButton;
var
  resources: System.Resources.ResourceManager;
begin
  Self.components := System.ComponentModel.Container.Create;
  resources := System.Resources.ResourceManager.Create(TypeOf(FRpNetPreview));
  Self.BToolBar := System.Windows.Forms.ToolBar.Create;
  Self.BFirst := System.Windows.Forms.ToolBarButton.Create;
  Self.BPrior := System.Windows.Forms.ToolBarButton.Create;
  Self.BNext := System.Windows.Forms.ToolBarButton.Create;
  Self.BLast := System.Windows.Forms.ToolBarButton.Create;
  Self.BPrint := System.Windows.Forms.ToolBarButton.Create;
  Self.BSave := System.Windows.Forms.ToolBarButton.Create;
  Self.BParameters := System.Windows.Forms.ToolBarButton.Create;
  Self.BScale1 := System.Windows.Forms.ToolBarButton.Create;
  Self.BScaleWide := System.Windows.Forms.ToolBarButton.Create;
  Self.BScaleFull := System.Windows.Forms.ToolBarButton.Create;
  Self.BZoomMinus := System.Windows.Forms.ToolBarButton.Create;
  Self.BZoomplus := System.Windows.Forms.ToolBarButton.Create;
  Self.BExit := System.Windows.Forms.ToolBarButton.Create;
  Self.Imalist := System.Windows.Forms.ImageList.Create(Self.components);
  Self.ImageContainer := System.Windows.Forms.Panel.Create;
  Self.AImage := System.Windows.Forms.PictureBox.Create;
  Self.ImageContainer.SuspendLayout;
  Self.SuspendLayout;
  // 
  // BToolBar
  // 
  Self.BToolBar.Appearance := System.Windows.Forms.ToolBarAppearance.Flat;
  Self.BToolBar.Buttons.AddRange(TSystem_Windows_Forms_ToolBarButtonArray.Create(Self.BFirst, Self.BPrior, Self.BNext, Self.BLast, Self.BPrint, Self.BSave, Self.BParameters, Self.BScale1, Self.BScaleWide, Self.BScaleFull, Self.BZoomMinus, Self.BZoomplus, Self.BExit));
  Self.BToolBar.ButtonSize := System.Drawing.Size.Create(25, 24);
  Self.BToolBar.DropDownArrows := True;
  Self.BToolBar.ImageList := Self.Imalist;
  Self.BToolBar.Location := System.Drawing.Point.Create(0, 0);
  Self.BToolBar.Name := 'BToolBar';
  Self.BToolBar.ShowToolTips := True;
  Self.BToolBar.Size := System.Drawing.Size.Create(292, 56);
  Self.BToolBar.TabIndex := 0;
  Include(Self.BToolBar.ButtonClick, Self.BToolBar_ButtonClick);
  // 
  // BFirst
  // 
  Self.BFirst.ImageIndex := 0;
  Self.BFirst.ToolTipText := 'Goes to the first page of the report';
  // 
  // BPrior
  // 
  Self.BPrior.ImageIndex := 1;
  Self.BPrior.ToolTipText := 'Shows the previous page';
  // 
  // BNext
  // 
  Self.BNext.ImageIndex := 2;
  Self.BNext.ToolTipText := 'Shows the next page';
  // 
  // BLast
  // 
  Self.BLast.ImageIndex := 3;
  Self.BLast.ToolTipText := 'Goes to the last page of the report';
  // 
  // BPrint
  // 
  Self.BPrint.ImageIndex := 4;
  Self.BPrint.ToolTipText := 'Print the report, you can select pages to print';
  // 
  // BSave
  // 
  Self.BSave.ImageIndex := 5;
  Self.BSave.ToolTipText := 'Save the report as a metafile report';
  // 
  // BParameters
  // 
  Self.BParameters.ImageIndex := 7;
  Self.BParameters.ToolTipText := 'Show report parameters';
  // 
  // BScale1
  // 
  Self.BScale1.ImageIndex := 8;
  Self.BScale1.ToolTipText := 'Shows the report in real size';
  // 
  // BScaleWide
  // 
  Self.BScaleWide.ImageIndex := 9;
  Self.BScaleWide.ToolTipText := 'Scale adjusting the paper to the window width';
  // 
  // BScaleFull
  // 
  Self.BScaleFull.ImageIndex := 10;
  Self.BScaleFull.ToolTipText := 'Scale to view full page';
  // 
  // BZoomMinus
  // 
  Self.BZoomMinus.ImageIndex := 11;
  Self.BZoomMinus.ToolTipText := 'Zooms out the view';
  // 
  // BZoomplus
  // 
  Self.BZoomplus.ImageIndex := 12;
  Self.BZoomplus.ToolTipText := 'Zooms in the view';
  // 
  // BExit
  // 
  Self.BExit.ImageIndex := 6;
  Self.BExit.ToolTipText := 'Closes the preview window';
  // 
  // Imalist
  // 
  Self.Imalist.ImageSize := System.Drawing.Size.Create(19, 19);
  Self.Imalist.ImageStream := (System.Windows.Forms.ImageListStreamer(resources.GetObject('Imalist.ImageStream')));
  Self.Imalist.TransparentColor := System.Drawing.Color.Transparent;
  // 
  // ImageContainer
  // 
  Self.ImageContainer.AutoScroll := True;
  Self.ImageContainer.Controls.Add(Self.AImage);
  Self.ImageContainer.Dock := System.Windows.Forms.DockStyle.Fill;
  Self.ImageContainer.Location := System.Drawing.Point.Create(0, 56);
  Self.ImageContainer.Name := 'ImageContainer';
  Self.ImageContainer.Size := System.Drawing.Size.Create(292, 210);
  Self.ImageContainer.TabIndex := 1;
  // 
  // AImage
  // 
  Self.AImage.Location := System.Drawing.Point.Create(0, 0);
  Self.AImage.Name := 'AImage';
  Self.AImage.Size := System.Drawing.Size.Create(80, 88);
  Self.AImage.TabIndex := 0;
  Self.AImage.TabStop := False;
  // 
  // FRpNetPreview
  // 
  Self.AutoScaleBaseSize := System.Drawing.Size.Create(5, 13);
  Self.ClientSize := System.Drawing.Size.Create(292, 266);
  Self.Controls.Add(Self.ImageContainer);
  Self.Controls.Add(Self.BToolBar);
  Self.Name := 'FRpNetPreview';
  Self.StartPosition := System.Windows.Forms.FormStartPosition.CenterScreen;
  Self.Text := 'Preview';
  Include(Self.Load, Self.FRpNetPreview_Load);
  Self.ImageContainer.ResumeLayout(False);
  Self.ResumeLayout(False);
end;
{$ENDREGION}

procedure FRpNetPreview.Dispose(Disposing: Boolean);
begin
  if Disposing then
  begin
    if Components <> nil then
      Components.Dispose();
  end;
  inherited Dispose(Disposing);
end;

constructor FRpNetPreview.Create;
begin
  inherited Create;
  //
  // Required for Windows Form Designer support
  //
  InitializeComponent;
  //
  // TODO: Add any constructor code after InitializeComponent call
  //
end;

procedure FRpNetPreview.BToolBar_ButtonClick(sender: System.Object; e: System.Windows.Forms.ToolBarButtonClickEventArgs);
begin
 if e.Button=BExit then
  Close;
end;


procedure FRpNetPreview.FRpNetPreview_Load(sender: System.Object; e: System.EventArgs);
begin

end;

function ShowPreview(caption:string):boolean;
var
 dia:FRpNetPreview;
{ oldprogres:TRpProgressEvent;
 hasparams:boolean;
 i:integer;
}begin
 dia:=FRpNetPreview.Create;
 try
  dia.Text:=caption;
{  oldprogres:=report.OnProgress;
  try
   dia.report:=report;
   hasparams:=false;
   for i:=0 to report.params.count-1 do
   begin
    if report.params.items[i].Visible then
    begin
     hasparams:=true;
     break;
    end;
   end;
   dia.AParams.Enabled:=hasparams;
   dia.enableparams:=hasparams;
   dia.AScale100.Checked:=False;
   dia.AScaleFull.Checked:=False;
   dia.AScaleWide.Checked:=False;
   case report.PreviewStyle of
    spNormal:
     begin
      dia.AScale100.Checked:=True;
      dia.gdidriver.PreviewStyle:=spNormal;
     end;
    spEntirePage:
     begin
      dia.AScaleFull.Checked:=True;
      dia.gdidriver.PreviewStyle:=spEntirePage;
     end
    else
      dia.AScaleWide.Checked:=True;
   end;
   if report.PreviewWindow=spwMaximized then
    dia.WindowState:=wsMaximized;
   report.OnProgress:=dia.RepProgress;
   Application.OnIdle:=dia.AppIdle;
}
   dia.ShowDialog;
   Result:=dia.printed;
{  finally
   report.OnProgress:=oldprogres;
  end;
} finally
  dia.Free;
 end;
end;

end.
