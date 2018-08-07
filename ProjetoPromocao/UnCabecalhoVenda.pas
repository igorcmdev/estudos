unit UnCabecalhoVenda;

interface


type
  TTipoVenda = (taVenda, taCancelamento, taDevolucao);

  TCabecalhoVenda = class
  private
    FCodigoVenda: Integer;
    FDataVenda: string;
    FValorTotal: Extended;
    FTotalDescontos: Extended;
    FTotalAcrescimos: Extended;
    FTipoVenda: TTipoVenda;
  public
    property CodigoVenda: Integer read FCodigoVenda write FCodigoVenda;
    property DataVenda: string read FDataVenda write FDataVenda;
    property ValorTotal: Extended read FValorTotal write FValorTotal;
    property TotalDescontos: Extended read FTotalDescontos write FTotalDescontos;
    property TotalAcrescimos: Extended read FTotalAcrescimos write FTotalAcrescimos;

  end;

implementation

end.
