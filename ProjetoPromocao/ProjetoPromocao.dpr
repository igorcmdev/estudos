program ProjetoPromocao;

uses
  Vcl.Forms,
  FrmInicial in 'FrmInicial.pas' {Form3},
  UnAcumulo in 'UnAcumulo.pas',
  UnItemVenda in 'UnItemVenda.pas',
  unPromoCore in 'unPromoCore.pas',
  UnCabecalhoVenda in 'UnCabecalhoVenda.pas',
  UnVenda in 'UnVenda.pas',
  UnProduto in 'UnProduto.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
