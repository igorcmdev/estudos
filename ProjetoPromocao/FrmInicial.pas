unit FrmInicial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    btnNovaVenda: TButton;
    btnCancelar: TButton;
    btnFinalizaVenda: TButton;
    pnlBotoes: TPanel;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    edtCodigoProduto: TEdit;
    edtValor: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    btnAdicionarProduto: TButton;
    btnRemoverProduto: TButton;
    Label4: TLabel;
    Memo1: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

end.
