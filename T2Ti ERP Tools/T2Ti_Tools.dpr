program T2Ti_Tools;

uses
  Forms,
  UTools in 'UTools.pas' {FT2TiTools},
  Biblioteca in '..\Fontes\ERP\Comum\Biblioteca.pas',
  Constantes in '..\Fontes\ERP\Comum\Constantes.pas',
  JSonVO in '..\Fontes\ERP\Comum\VO\JSonVO.pas',
  Atributos in '..\Fontes\ERP\Comum\Atributos.pas',
  UDadosPadroes in 'DadosEmpresa\UDadosPadroes.pas' {FDadosPadroes};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFT2TiTools, FT2TiTools);
  Application.Run;
end.