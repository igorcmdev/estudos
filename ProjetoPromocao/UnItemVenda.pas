unit UnItemVenda;

interface

uses
  UnPromoCore;

Type
  TItemVenda = class (TInterfacedObject, IItemVenda)
  private
    FId: string;
    FCodigoProduto: string;
    FQuantidade: Integer;
    FPreco: Extended;
    FPossuiDescontoAplicado: Boolean;

  public
//    property Id: string read GetId;
//    property CodigoProduto: string read GetCodigoProduto;
//    property Quantidade: Integer read GetQuantidade;
//    property Preco: extended read GetPreco;

    function GetId: string;
    function GetCodigoProduto: string;
    function GetQuantidade: Integer;
    function GetPreco: extended;
    function GetQuantidadeJaPromocionada: Integer;
    function GetPossuiDescontoAplicado: boolean;
    procedure SetId(const AValue: string);
    procedure SetCodigoProduto(const AValue: string);
    procedure SetQuantidade(const AValue: integer);
    procedure SetPreco(const AValue: Extended);
    procedure SetQuantidadeJaPromocionada(const AValue: Integer);
    procedure SetPossuiDescontoAplicado(const AValue: Boolean);

  end;
implementation

{ TItemVenda }

function TItemVenda.GetCodigoProduto: string;
begin
  Result := FCodigoProduto;
end;

function TItemVenda.GetId: string;
begin
  Result := FId;
end;

function TItemVenda.GetPossuiDescontoAplicado: boolean;
begin
  Result := FPossuiDescontoAplicado;
end;

function TItemVenda.GetPreco: extended;
begin
  Result := FPreco;
end;

function TItemVenda.GetQuantidade: Integer;
begin
  Result := FQuantidade;
end;

function TItemVenda.GetQuantidadeJaPromocionada: Integer;
begin
  Result := FQuantidade;
end;

procedure TItemVenda.SetCodigoProduto(const AValue: string);
begin
  FCodigoProduto := AValue;
end;

procedure TItemVenda.SetId(const AValue: string);
begin
  FId := AValue;
end;

procedure TItemVenda.SetPossuiDescontoAplicado(const AValue: Boolean);
begin
  FPossuiDescontoAplicado := AValue;
end;

procedure TItemVenda.SetPreco(const AValue: Extended);
begin
  FPreco := AValue;
end;

procedure TItemVenda.SetQuantidade(const AValue: integer);
begin
  FQuantidade := AValue;
end;

procedure TItemVenda.SetQuantidadeJaPromocionada(const AValue: Integer);
begin
  FQuantidade := AValue;
end;

end.
