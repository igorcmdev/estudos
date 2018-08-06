unit unPromoCore;

interface

uses

  System.Generics.Collections, Contnrs, System.SysUtils;

type
  TValorDetalhado = Record
    ValorDesconto : Extended;
    IDPromo : String;
  end;

  TTipoAcumulo = (taSomar, taSubtrair);
  TTipoCombo = (tcPromocional, tcBeneficio, tcAmbos);

  IAcumulo = interface
    function GetAcumulado: extended;
    procedure Soma(AValue: Extended);
    procedure Subtrai(AValue: Extended);
    procedure Zera;
    property Acumulado: Extended read GetAcumulado;
  end;

  IProdutoCombo = interface
    ['{9B0E2FBA-0161-4DD3-9A4F-A56ACF905F43}']
    function GetCodigo: string;
    function GetTipo: string;
    function GetAcumulo: IAcumulo;
    procedure SetCodigo(const AValue: string);
    procedure SetTipo(const AValue: string);
    property Codigo: string read GetCodigo;
    property Tipo: string read GetTipo; // Se (P)romocional ou (B)enefício
    property Acumulo: IAcumulo read GetAcumulo;
  end;

  TProdutoComboList = class(TList<IProdutoCombo>)
  public
    function BuscaProduto(const ACodigo: string): IProdutoCombo;
    function ExisteProduto(const ACodigo: string): Boolean;
    function AcumuladoDosProdutos: Extended;
  end;

  IItemVenda = interface
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
    property Id: string read GetId;
    property CodigoProduto: string read GetCodigoProduto;
    property Quantidade: Integer read GetQuantidade;
    property Preco: extended read GetPreco;
  end;

  TItemVendaList = TList<IItemVenda>;

  IComboPromocao = interface
    ['{9B0E2FBA-0161-4DD3-9A4F-A56ACF905F43}']
    function GetTipo: string;
    function GetId: string;
    function GetQuantidadePromocional: Integer;
    function GetQuantidadeBeneficio: Integer;
    function GetAcumulado: Extended;
    function GetTipoDesconto: string;
    function GetDesconto: Extended;
    function GetQuantidadePromocionada: Integer;
    function GetDescontoPendente: Extended;
    function GetProdutos: TProdutoComboList;
    procedure SetId(const AValue: string);
    procedure SetTipo(const AValue: string);
    procedure SetQuantidadePromocional(const AValue: Integer);
    procedure SetQuantidadeBeneficio(const AValue: Integer);
    procedure SetQuantidadePromocionada(const AValue: Integer);
    procedure SetDescontoPendente(const AValue: Extended);
    procedure SetTipoDesconto(const AValue: string);
    procedure SetDesconto(const AValue: Extended);
    property Tipo: string read GetTipo write SetTipo;
    property Id: string read GetId write SetId;
    property QuantidadePromocional: Integer read GetQuantidadePromocional write SetQuantidadePromocional;
    property QuantidadeBeneficio: Integer read GetQuantidadeBeneficio write SetQuantidadeBeneficio;
    property QuantidadePromocionada: Integer read GetQuantidadePromocionada write SetQuantidadePromocionada; // Utilizado na Venda Casada e Desconto
    property DescontoPendente: Extended read GetDescontoPendente write SetDescontoPendente; // Utilizado na Venda Casada e Desconto
    property TipoDesconto: string read GetTipoDesconto write SetTipoDesconto;
    property Desconto: Extended read GetDesconto write SetDesconto;
    property Produtos: TProdutoComboList read GetProdutos;
    property Acumulado: Extended read GetAcumulado;
  end;

  TComboPromocaoList = TList<IComboPromocao>;

  IPromocao = interface
    ['{051DAA44-3D24-40FA-8389-65EBA6F24942}']
    function GetCombos: TComboPromocaoList;
    function GetId: string;
    function GetHoraInicial: string;
    function GetHoraFinal: string;
    function GetLimitePorCupom: Integer;
    function GetTipoPreco: string;
    function GetActive: Boolean;
    function GetResultado: TDictionary<string,TValorDetalhado>;
    function GetDescontoPendente: Extended;
    function GetContadorIncidenciaNoCupom: Integer;
    function Promociona(AItemVendaList: TItemVendaList): boolean;
    function AtendeRequisitosParaPromocionar: Boolean;
    function AtingidoLimiteDaPromocaoNoCupom: Boolean;
    function CarregaDetalhesValor(const AValor : Extended;const AIdpromo : String) : TValorDetalhado;
    procedure SetId(const AValue: string);
    procedure SetHoraInicial(const AValue: string);
    procedure SetHoraFinal(const AValue: string);
    procedure SetLimitePorCupom(const AValue: Integer);
    procedure SetTipoPreco(const AValue: string);
    procedure AcumulaItem(const ACodigoProduto: string; const AQuantidade: Integer; ATipoAcumulo: TTipoAcumulo);
    procedure ZeraAcumulado;
    procedure ZeraQuantidadePromocionadaDosCombos;
    procedure ZeraDescontoPendenteDosCombos;
    procedure ZeraContadorIncidenciaNoCupom;
    property Id: string read GetId write SetId;
    property HoraInicial: string read GetHoraInicial write SetHoraInicial;
    property HoraFinal: string read GetHoraFinal write SetHoraFinal;
    property LimitePorCupom: Integer read GetLimitePorCupom write SetLimitePorCupom;
    property TipoPreco: string read GetTipoPreco write SetTipoPreco;
    property Active: Boolean read GetActive;
    property Combos: TComboPromocaoList read GetCombos;
    property Resultado: TDictionary<string,TValorDetalhado> read GetResultado;
    property DescontoPendente: Extended read GetDescontoPendente;
    property ContadorIncidenciaNoCupom: Integer read GetContadorIncidenciaNoCupom;
  end;

  TPromocaoList = TList<IPromocao>;

  IPromocaoEngine = interface
    ['{BA66497C-EDF3-427E-BD60-76709E7E8719}']
    function GetPromocoesAtivas: TPromocaoList;
    function GetProdutosDePromocao: TProdutoComboList;
    function GetItensVenda: TItemVendaList;
    procedure RegistraPromocao(const APromocao: IPromocao);
    procedure RegistraProdutoDePromocao(const AProdutoDePromocao: IProdutoCombo);
    procedure RegistraItemDeVenda(const AItemDeVenda: IItemVenda);
    procedure AcumulaItem(const ACodigoProduto: string; const AQuantidade: Integer; ATipoAcumulo: TTipoAcumulo);
    property PromocoesAtivas: TPromocaoList read GetPromocoesAtivas;
    property ProdutosDePromocao: TProdutoComboList read GetProdutosDePromocao;
    property ItensVenda: TItemVendaList read GetItensVenda;
  end;

  TAcumulo = class(TInterfacedObject, IAcumulo)
  private
    FAcumulado: Extended;
    function GetAcumulado: extended;
  public
    constructor create;
    procedure Soma(AValue: Extended);
    procedure Subtrai(AValue: Extended);
    procedure Zera;
    property Acumulado: Extended read GetAcumulado;
  end;

  TProdutoComboImpl = class(TInterfacedObject, IProdutoCombo)
  private
    FCodigo: string;
    FTipo: string;
    FAcumulo: IAcumulo;
    function GetCodigo: string;
    function GetAcumulo: IAcumulo;
    function GetTipo: string;
  public
    constructor create;
    procedure SetCodigo(const AValue: string);
    procedure SetTipo(const AValue: string);
    property Codigo: string read GetCodigo;
    property Acumulo: IAcumulo read GetAcumulo;
  end;

  TItemVendaImpl = class(TInterfacedObject, IItemVenda)
  private
    FId: string;
    FCodigoProduto: string;
    FQuantidade: Integer;
    FPreco: extended;
    FQuantidadeJaPromocionada: Integer;
    FPossuiDescontoAplicado: boolean;
    function GetCodigoProduto: string;
    function GetId: string;
    function GetPreco: extended;
    function GetQuantidade: Integer;
    function GetQuantidadeJaPromocionada: Integer;
    function GetPossuiDescontoAplicado: boolean;
  public
    procedure SetId(const AValue: string);
    procedure SetCodigoProduto(const AValue: string);
    procedure SetQuantidade(const AValue: integer);
    procedure SetPreco(const AValue: Extended);
    procedure SetQuantidadeJaPromocionada(const AValue: Integer);
    procedure SetPossuiDescontoAplicado(const AValue: boolean);
    property Id: string read GetId;
    property CodigoProduto: string read GetCodigoProduto;
    property Quantidade: Integer read GetQuantidade;
    property Preco: extended read GetPreco;
  end;

  TPromocaoComboImpl = class(TInterfacedObject, IComboPromocao)
  private
    FProdutos: TProdutoComboList;
    FId: string;
    FQuantidadePromocional: Integer;
    FQuantidadeBeneficio: Integer;
    FTipo: string;
    FQuantidadePromocionada: Integer;
    FDescontoPendente: extended;
    FTipoDesconto: string;
    FDesconto: Extended;
    function GetProdutos: TProdutoComboList;
    function GetId: string;
    function GetQuantidadePromocional: Integer;
    function GetQuantidadeBeneficio: Integer;
    function GetTipo: string;
    function GetAcumulado: Extended;
    function GetQuantidadePromocionada: Integer;
    function GetDesconto: Extended;
    function GetTipoDesconto: string;
    function GetDescontoPendente: Extended;
  public
    procedure AfterConstruction; override;
    destructor Destroy; override;
    procedure SetId(const AValue: string);
    procedure SetTipo(const AValue: string);
    procedure SetQuantidadePromocional(const AValue: Integer);
    procedure SetQuantidadeBeneficio(const AValue: Integer);
    procedure SetQuantidadePromocionada(const AValue: Integer);
    procedure SetDescontoPendente(const AValue: Extended);
    procedure SetDesconto(const Value: Extended);
    procedure SetTipoDesconto(const Value: string);
    property Tipo: string read GetTipo write SetTipo;
    property Id: string read GetId write SetId;
    property QuantidadePromocional: Integer read GetQuantidadePromocional write SetQuantidadePromocional;
    property QuantidadeBeneficio: Integer read GetQuantidadeBeneficio write SetQuantidadeBeneficio;
    property QuantidadePromocionada: Integer read GetQuantidadePromocionada write SetQuantidadePromocionada; // Utilizado na Venda Casada e Desconto
    property DescontoPendente: Extended read GetDescontoPendente write SetDescontoPendente; // Utilizado na Venda Casada e Desconto
    property TipoDesconto: string read GetTipoDesconto write SetTipoDesconto;
    property Desconto: Extended read GetDesconto write SetDesconto;
    property Produtos: TProdutoComboList read GetProdutos;
    property Acumulado: Extended read GetAcumulado;
  end;

  TPromocaoImpl = class(TInterfacedObject, IPromocao)
  private
    FCombos: TComboPromocaoList;
    FActive: Boolean;
    FId: string;
    FHoraInicial: string;
    FHoraFinal: string;
    FTipoPreco: string;
    FContadorIncidenciaNoCupom: Integer;
    FLimitePorCupom: Integer;
    FResultado: TDictionary<string,TValorDetalhado>;
    function GetCombos: TComboPromocaoList;
    function GetId: string;
    function GetActive: Boolean;
    function GetResultado: TDictionary<string,TValorDetalhado>;
    function GetLimitePorCupom: Integer;
    function GetDescontoPendente: Extended;
    function GetHoraFinal: string;
    function GetHoraInicial: string;
    function GetTipoPreco: string;
    function GetContadorIncidenciaNoCupom: Integer;
    function AtingidoLimiteDaPromocaoNoCupom: Boolean;
    function AtendeRequisitosParaPromocionar: Boolean; virtual;
    function Promociona(AItemVendaList: TItemVendaList): boolean; virtual; abstract;
    function CarregaDetalhesValor(const AValor : Extended;const AIdpromo : String) : TValorDetalhado;
    procedure SetTipoPreco(const Value: string);
    procedure SetHoraFinal(const Value: string);
    procedure SetHoraInicial(const Value: string);
    procedure SetId(const Value: string);
    procedure SetLimitePorCupom(const Value: Integer);
    procedure TentaAplicarDescontoPendente(const AValorTotalItem: Extended; var ADescontoAplicadoAteOMomento: Extended);

    const
      FORMAT = '0.00';
  published
    function QuantidadePromocoesAplicadas: Integer; virtual;
    function ComboDoProduto(const ACodigoProduto: string; ATipoCombo: string=''): IComboPromocao;
    function ValorPromocionadoUnidade(const APrecoItem: Extended; const AQuantidadePromocional: Integer; const ATipoDesconto: string; const ADesconto: Extended): Extended;
    procedure AcumulaItem(const ACodigoProduto: string; const AQuantidade: Integer; ATipoAcumulo: TTipoAcumulo);
    procedure ZeraQuantidadePromocionadaDosCombos;
    procedure ZeraDescontoPendenteDosCombos;
    procedure ZeraContadorIncidenciaNoCupom;
  public
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure ZeraAcumulado;
    property Id: string read GetId write SetId;
    property HoraInicial: string read GetHoraInicial write SetHoraInicial;
    property HoraFinal: string read GetHoraFinal write SetHoraFinal;
    property LimitePorCupom: Integer read GetLimitePorCupom write SetLimitePorCupom;
    property TipoPreco: string read GetTipoPreco write SetTipoPreco;
    property Active: Boolean read GetActive;
    property Combos: TComboPromocaoList read GetCombos;
    property Resultado: TDictionary<string,TValorDetalhado> read GetResultado;
    property DescontoPendente: Extended read GetDescontoPendente;
    property ContadorIncidenciaNoCupom: Integer read GetContadorIncidenciaNoCupom;
  end;

  TPromoPagueXLeveY = class(TPromocaoImpl)
  public
    function AtendeRequisitosParaPromocionar: Boolean; override;
    function Promociona(AItemVendaList: TItemVendaList): boolean; override;
  end;

  TPromoVendaCasada = class(TPromocaoImpl)
  private
    FProdutosDaPromocao: TProdutoComboList;
    FAcumuladoPromocional: Integer;
    FProdutoPrincipalEBeneficio: TProdutoComboList;
    procedure PreencheProdutosDaPromocao;
  public
    function AtendeRequisitosParaPromocionar: Boolean; override;
    function QuantidadePromocoesAplicadas: Integer; override;
    function Promociona(AItemVendaList: TItemVendaList): boolean; override;
  end;

  TPromoDesconto = class(TPromocaoImpl)
  public
    function AtendeRequisitosParaPromocionar: Boolean; override;
    function Promociona(AItemVendaList: TItemVendaList): boolean; override;
  end;

  TPromocaoEngineImpl = class(TInterfacedObject, IPromocaoEngine)
  private
    FIndexPromocaoAplicada: Integer;
    FPromocoesAtivas: TPromocaoList;
    FProdutosDePromocao: TProdutoComboList;
    FItensVenda: TItemVendaList;
    function GetPromocoesAtivas: TPromocaoList;
    function GetItensVenda: TItemVendaList;
    function GetProdutosDePromocao: TProdutoComboList;
  public
    constructor Create;
    procedure RegistraPromocao(const APromocao: IPromocao);
    procedure RegistraProdutoDePromocao(const AProdutoDePromocao: IProdutoCombo);
    procedure RegistraItemDeVenda(const AItemDeVenda: IItemVenda);
    procedure AcumulaItem(const ACodigoProduto: string; const AQuantidade: Integer; ATipoAcumulo: TTipoAcumulo);
    function Promocionar: Boolean;
    property PromocoesAtivas: TPromocaoList read GetPromocoesAtivas;
    property ProdutosDePromocao: TProdutoComboList read GetProdutosDePromocao;
    property ItensVenda: TItemVendaList read GetItensVenda;
    property IndexPromocaoAplicada: Integer read FIndexPromocaoAplicada;
  end;

implementation

uses
  System.Generics.Defaults;

{ TPromocaoImpl }

procedure TPromocaoImpl.AcumulaItem(const ACodigoProduto: string; const AQuantidade: Integer; ATipoAcumulo: TTipoAcumulo);
var
  IndexCombo: Integer;
  IndexProduto: Integer;
begin
  for IndexCombo := 0 to GetCombos.Count - 1 do
  begin
    for IndexProduto := 0 to GetCombos[IndexCombo].Produtos.Count - 1 do
    begin
      if GetCombos[IndexCombo].Produtos[IndexProduto].Codigo = ACodigoProduto then
      begin
        if ATipoAcumulo = taSomar then
          GetCombos[IndexCombo].Produtos[IndexProduto].Acumulo.Soma(AQuantidade)
        else
          GetCombos[IndexCombo].Produtos[IndexProduto].Acumulo.Subtrai(AQuantidade);
        Exit;
      end;
    end;
  end;
end;

procedure TPromocaoImpl.AfterConstruction;
begin
  inherited;
  FCombos := TComboPromocaoList.Create;
  FResultado := TDictionary<string,TValorDetalhado>.Create;
  FContadorIncidenciaNoCupom := 0;
end;

function TPromocaoImpl.AtendeRequisitosParaPromocionar: Boolean;
begin
  Result := True;
  if (StrToIntDef(FHoraInicial, 0) > 0) or (StrToIntDef(FHoraFinal, 0) > 0) then
  begin
    if (StrToIntDef(FHoraInicial, 0) > StrToIntDef(FormatDateTime('hh', Now), 0)) or (StrToIntDef(FHoraFinal, 0) < StrToIntDef(FormatDateTime('hh', Now), 0)) then
      Result := False;
  end;
end;

function TPromocaoImpl.AtingidoLimiteDaPromocaoNoCupom: Boolean;
begin
  Result := False;
  if FLimitePorCupom > 0 then
    Result := FContadorIncidenciaNoCupom = FLimitePorCupom;
end;

function TPromocaoImpl.CarregaDetalhesValor(const AValor: Extended;
  const AIdpromo: String): TValorDetalhado;
begin
  with Result do
  begin
    ValorDesconto := AValor;
    IDPromo := AIdpromo;
  end;
end;

function TPromocaoImpl.ComboDoProduto(const ACodigoProduto: string; ATipoCombo: string): IComboPromocao;
var
  Index: Integer;
begin
  Result := nil;
  for Index := 0 to Combos.Count - 1 do
  begin
    if Combos[Index].Produtos.ExisteProduto(ACodigoProduto) then
    begin
      if ATipoCombo <> EmptyStr then
      begin
        if SameText(ATipoCombo, Combos[Index].Tipo) then
          Result := Combos[Index]
      end
      else
        Result := Combos[Index];
    end;
  end;
end;

function TPromocaoImpl.ValorPromocionadoUnidade(const APrecoItem: Extended;
  const AQuantidadePromocional: Integer; const ATipoDesconto: string; const ADesconto: Extended): Extended;
begin
  Result := 0;
  if ATipoDesconto = 'P' then
    if ADesconto = 100 then
      Result := APrecoItem - 0.01
    else
      Result := APrecoItem * ADesconto / 100
  else
  if ATipoDesconto = 'V' then
    Result := ADesconto / AQuantidadePromocional
  else
    Result := APrecoItem - ADesconto;
end;

destructor TPromocaoImpl.Destroy;
begin
  FCombos.Free;
  FResultado.Free;
  inherited;
end;

function TPromocaoImpl.GetActive: Boolean;
begin
  Result := FActive;
end;

function TPromocaoImpl.GetId: string;
begin
  Result := FId;
end;

function TPromocaoImpl.GetLimitePorCupom: Integer;
begin
  Result := FLimitePorCupom;
end;

function TPromocaoImpl.GetResultado: TDictionary<string, TValorDetalhado>;
begin
  Result := FResultado;
end;

function TPromocaoImpl.GetTipoPreco: string;
begin
  Result := FTipoPreco;
end;

function TPromocaoImpl.QuantidadePromocoesAplicadas: Integer;
var
  Index: Integer;
begin
  Result := 0;
  for Index := 0 to Combos.Count - 1 do
  begin
    if Index = 0 then
      Result := Trunc(Combos[Index].Acumulado / Combos[Index].QuantidadePromocional)
    else
    if Trunc(Combos[Index].Acumulado / Combos[Index].QuantidadePromocional) < Result then
      Result := Trunc(Combos[Index].Acumulado / Combos[Index].QuantidadePromocional);
  end;
end;

procedure TPromocaoImpl.SetTipoPreco(const Value: string);
begin
  FTipoPreco := Value;
end;

procedure TPromocaoImpl.SetHoraFinal(const Value: string);
begin
  FHoraFinal := Value;
end;

procedure TPromocaoImpl.SetHoraInicial(const Value: string);
begin
  FHoraInicial := Value;
end;

procedure TPromocaoImpl.SetId(const Value: string);
begin
  FId := Value;
end;

procedure TPromocaoImpl.SetLimitePorCupom(const Value: Integer);
begin
  FLimitePorCupom := Value;
end;

procedure TPromocaoImpl.TentaAplicarDescontoPendente(
  const AValorTotalItem: Extended; var ADescontoAplicadoAteOMomento: Extended);
var
  ListaDeCombos: TComboPromocaoList;
  Comparison: TComparison<IComboPromocao>;
  DelegateComparer: TDelegatedComparer<IComboPromocao>;
  Index: Integer;
begin
  ListaDeCombos := TComboPromocaoList.Create;
  try
    Comparison := function (const AValue1, AValue2: IComboPromocao): Integer
                  begin
                    Result := StrToInt(FloatToStr(AValue1.DescontoPendente * 100)) -  StrToInt(FloatToStr(AValue2.DescontoPendente * 100));
                  end;
    DelegateComparer := TDelegatedComparer<IComboPromocao>.Create(comparison);
    try
      for Index := 0 to Combos.Count - 1 do
        ListaDeCombos.Add(Combos[Index]);

      ListaDeCombos.Sort(DelegateComparer);
      for Index := 0 to ListaDeCombos.Count - 1 do
      begin
        if ListaDeCombos[Index].DescontoPendente > 0 then
        begin
          if ADescontoAplicadoAteOMomento + ListaDeCombos[Index].DescontoPendente < AValorTotalItem then
          begin
            ADescontoAplicadoAteOMomento := ADescontoAplicadoAteOMomento + ListaDeCombos[Index].DescontoPendente;
            ListaDeCombos[Index].SetDescontoPendente(0);
          end;
        end;
      end;
    finally
      FreeAndNil(DelegateComparer);
    end;
  finally
    FreeAndNil(ListaDeCombos);
  end;
end;

procedure TPromocaoImpl.ZeraAcumulado;
var
  IndexCombo: Integer;
  IndexProduto: Integer;
begin
  for IndexCombo := 0 to GetCombos.Count - 1 do
  begin
    for IndexProduto := 0 to GetCombos[IndexCombo].Produtos.Count - 1 do
      GetCombos[IndexCombo].Produtos[IndexProduto].Acumulo.Zera;
  end;
end;

procedure TPromocaoImpl.ZeraContadorIncidenciaNoCupom;
begin
  FContadorIncidenciaNoCupom := 0;
end;

procedure TPromocaoImpl.ZeraDescontoPendenteDosCombos;
var
  Index: Integer;
begin
  for Index := 0 to GetCombos.Count - 1 do
    GetCombos[Index].SetDescontoPendente(0);
end;

procedure TPromocaoImpl.ZeraQuantidadePromocionadaDosCombos;
var
  Index: Integer;
begin
  for Index := 0 to GetCombos.Count - 1 do
    GetCombos[Index].SetQuantidadePromocionada(0);;
end;

function TPromocaoImpl.GetCombos: TComboPromocaoList;
begin
  Result := FCombos;
end;

function TPromocaoImpl.GetContadorIncidenciaNoCupom: Integer;
begin
  Result := FContadorIncidenciaNoCupom;
end;

function TPromocaoImpl.GetDescontoPendente: Extended;
var
  Index: Integer;
begin
  Result := 0;
  for Index := 0 to Combos.Count - 1 do
    Result := Result + Combos[Index].DescontoPendente;
end;

function TPromocaoImpl.GetHoraFinal: string;
begin
  Result := FHoraFinal;
end;

function TPromocaoImpl.GetHoraInicial: string;
begin
  Result := FHoraInicial;
end;

{ TPromocaoEngineImpl }

procedure TPromocaoEngineImpl.AcumulaItem(const ACodigoProduto: string;
  const AQuantidade: Integer; ATipoAcumulo: TTipoAcumulo);
var
  Index: Integer;
begin
  for Index := 0 to FProdutosDePromocao.Count - 1 do
  begin
    if FProdutosDePromocao[Index].Codigo = ACodigoProduto then
    begin
      if ATipoAcumulo = taSomar then
        FProdutosDePromocao[Index].Acumulo.Soma(AQuantidade)
      else
        FProdutosDePromocao[Index].Acumulo.Subtrai(AQuantidade);
      Break;
    end;
  end;
end;
constructor TPromocaoEngineImpl.Create;
begin
  FPromocoesAtivas := TPromocaoList.Create;
  FProdutosDePromocao := TProdutoComboList.Create;
  FItensVenda := TItemVendaList.Create;;
end;

function TPromocaoEngineImpl.GetItensVenda: TItemVendaList;
begin
  Result := FItensVenda;
end;

function TPromocaoEngineImpl.GetProdutosDePromocao: TProdutoComboList;
begin
  Result := FProdutosDePromocao;
end;

function TPromocaoEngineImpl.GetPromocoesAtivas: TPromocaoList;
begin
  Result := FPromocoesAtivas;
end;

function TPromocaoEngineImpl.Promocionar: Boolean;
var
  Index, IndexCombo: Integer;
begin
  Result := False;
  FIndexPromocaoAplicada := -1;
  AcumulaItem(FItensVenda[FItensVenda.Count-1].CodigoProduto, FItensVenda[FItensVenda.Count-1].Quantidade, taSomar);
  for Index := 0 to FPromocoesAtivas.Count - 1 do
  begin
    if FPromocoesAtivas[Index].AtendeRequisitosParaPromocionar then
    begin
      FPromocoesAtivas[Index].ZeraQuantidadePromocionadaDosCombos;
      FPromocoesAtivas[Index].ZeraDescontoPendenteDosCombos;
      Result := FPromocoesAtivas[Index].Promociona(FItensVenda);
      if Result then
      begin
        FIndexPromocaoAplicada := Index;
        Break;
      end;
    end;
  end;
end;

procedure TPromocaoEngineImpl.RegistraItemDeVenda(
  const AItemDeVenda: IItemVenda);
begin
  FItensVenda.Add(AItemDeVenda);
end;

procedure TPromocaoEngineImpl.RegistraProdutoDePromocao(
  const AProdutoDePromocao: IProdutoCombo);
begin
  FProdutosDePromocao.Add(AProdutoDePromocao);
end;

procedure TPromocaoEngineImpl.RegistraPromocao(const APromocao: IPromocao);
begin
  FPromocoesAtivas.Add(APromocao);
end;

{ TPromocaoComboImpl }

procedure TPromocaoComboImpl.AfterConstruction;
begin
  inherited;
  FProdutos := TProdutoComboList.create;
  FQuantidadePromocionada := 0;
  FDescontoPendente := 0;
end;

destructor TPromocaoComboImpl.Destroy;
begin
  FProdutos.Free;
  inherited;
end;

function TPromocaoComboImpl.GetAcumulado: Extended;
var
  Produto: IProdutoCombo;
begin
  Result := 0;
  for Produto in GetProdutos do
    Result := Result + Produto.Acumulo.Acumulado;
end;

function TPromocaoComboImpl.GetDesconto: Extended;
begin
  Result := FDesconto;
end;

function TPromocaoComboImpl.GetDescontoPendente: Extended;
begin
  Result := FDescontoPendente;
end;

function TPromocaoComboImpl.GetId: string;
begin
  Result := FId;
end;

function TPromocaoComboImpl.GetProdutos: TProdutoComboList;
begin
  Result := FProdutos;
end;

function TPromocaoComboImpl.GetQuantidadeBeneficio: Integer;
begin
  Result := FQuantidadeBeneficio;
end;

function TPromocaoComboImpl.GetQuantidadePromocionada: Integer;
begin
  Result := FQuantidadePromocionada;
end;

function TPromocaoComboImpl.GetQuantidadePromocional: Integer;
begin
  Result := FQuantidadePromocional;
end;

function TPromocaoComboImpl.GetTipo: string;
begin
  Result := FTipo;
end;

function TPromocaoComboImpl.GetTipoDesconto: string;
begin
  Result := FTipoDesconto;
end;

procedure TPromocaoComboImpl.SetDesconto(const Value: Extended);
begin
  FDesconto := Value;
end;

procedure TPromocaoComboImpl.SetDescontoPendente(const AValue: Extended);
begin
  FDescontoPendente := StrToFloat(FormatFloat('0.00', AValue));
end;

procedure TPromocaoComboImpl.SetId(const AValue: string);
begin
  FId := AValue;
end;

procedure TPromocaoComboImpl.SetQuantidadeBeneficio(const AValue: Integer);
begin
  FQuantidadeBeneficio := AValue;
end;

procedure TPromocaoComboImpl.SetQuantidadePromocionada(const AValue: Integer);
begin
  FQuantidadePromocionada := AValue;
end;

procedure TPromocaoComboImpl.SetQuantidadePromocional(const AValue: Integer);
begin
  FQuantidadePromocional := AValue;
end;

procedure TPromocaoComboImpl.SetTipo(const AValue: string);
begin
  FTipo := AValue;
end;

procedure TPromocaoComboImpl.SetTipoDesconto(const Value: string);
begin
  FTipoDesconto := Value;
end;

{ TProdutoComboImpl }

constructor TProdutoComboImpl.create;
begin
  FAcumulo := TAcumulo.create;
end;

function TProdutoComboImpl.GetAcumulo: IAcumulo;
begin
  Result := FAcumulo;
end;

function TProdutoComboImpl.GetCodigo: string;
begin
  Result := FCodigo;
end;

function TProdutoComboImpl.GetTipo: string;
begin
  Result := FTipo;
end;

procedure TProdutoComboImpl.SetCodigo(const AValue: string);
begin
  FCodigo := AValue;
end;

procedure TProdutoComboImpl.SetTipo(const AValue: string);
begin
  FTipo := AValue;
end;

{ TItemVendaImpl }

function TItemVendaImpl.GetCodigoProduto: string;
begin
  Result := FCodigoProduto;
end;

function TItemVendaImpl.GetId: string;
begin
  Result := FId;
end;

function TItemVendaImpl.GetPossuiDescontoAplicado: boolean;
begin
  Result := FPossuiDescontoAplicado;
end;

function TItemVendaImpl.GetPreco: extended;
begin
  Result := FPreco;
end;

function TItemVendaImpl.GetQuantidade: Integer;
begin
  Result := FQuantidade;
end;

function TItemVendaImpl.GetQuantidadeJaPromocionada: Integer;
begin
  Result := FQuantidadeJaPromocionada;
end;

procedure TItemVendaImpl.SetCodigoProduto(const AValue: string);
begin
  FCodigoProduto := AValue;
end;

procedure TItemVendaImpl.SetId(const AValue: string);
begin
  FId := AValue;
end;

procedure TItemVendaImpl.SetPossuiDescontoAplicado(const AValue: boolean);
begin
  FPossuiDescontoAplicado := AValue;
end;

procedure TItemVendaImpl.SetPreco(const AValue: Extended);
begin
  FPreco := AValue;
end;

procedure TItemVendaImpl.SetQuantidade(const AValue: integer);
begin
  FQuantidade := AValue;
end;

procedure TItemVendaImpl.SetQuantidadeJaPromocionada(const AValue: Integer);
begin
  FQuantidadeJaPromocionada := AValue;
end;

{ TAcumulo }

constructor TAcumulo.create;
begin
  FAcumulado := 0;
end;

function TAcumulo.GetAcumulado: extended;
begin
  Result := FAcumulado;
end;

procedure TAcumulo.Soma(AValue: Extended);
begin
  FAcumulado := FAcumulado + AValue;
end;

procedure TAcumulo.Subtrai(AValue: Extended);
begin
  FAcumulado := FAcumulado - AValue;
end;

procedure TAcumulo.Zera;
begin
  FAcumulado := 0;
end;

{ TPromoPagueXLeveY }

function TPromoPagueXLeveY.AtendeRequisitosParaPromocionar: Boolean;
begin
  if inherited then
    Result := Combos[0].Acumulado >= Combos[0].QuantidadePromocional; //Pague X Leve Y possui apenas 1 combo
end;

function TPromoPagueXLeveY.Promociona(AItemVendaList: TItemVendaList): Boolean;
var
  Index: Integer;
  QuantidadeDePromocoesAplicadas: integer;
  QuantidadeItensPromocionaveis: integer;
  ValorPromocionado: Extended;
  ValorPromocionadoAcumulado: Extended;
  ValorPromocionadoPorUnidade: Extended;
  QuantidadeDescontos: integer;
  ValorDescontoPromocao: Extended;
  ValorDescontoPendentePromocao: Extended;
begin
  Result := False;
  Resultado.Clear;
  QuantidadeDePromocoesAplicadas := QuantidadePromocoesAplicadas;
  if not AtingidoLimiteDaPromocaoNoCupom then
  begin
    if FLimitePorCupom > 0 then
    begin
      if (FContadorIncidenciaNoCupom + QuantidadeDePromocoesAplicadas) > FLimitePorCupom then
        QuantidadeDePromocoesAplicadas := FLimitePorCupom - FContadorIncidenciaNoCupom;
    end;
    ValorPromocionadoAcumulado := 0;
    ValorDescontoPendentePromocao := 0;
    QuantidadeItensPromocionaveis := QuantidadeDePromocoesAplicadas * Combos[0].QuantidadePromocional;
    ValorPromocionado := ((Combos[0].QuantidadePromocional - (Combos[0].QuantidadePromocional - Combos[0].QuantidadeBeneficio)) *
                           QuantidadeDePromocoesAplicadas) * AItemVendaList[AItemVendaList.Count-1].Preco;
    ValorPromocionadoPorUnidade := ValorPromocionado / QuantidadeItensPromocionaveis;
    for Index := 0 to AItemVendaList.Count - 1 do
    begin
      if Combos[0].Produtos.ExisteProduto(AItemVendaList.Items[Index].CodigoProduto) then
      begin
        if AItemVendaList.Items[Index].Quantidade - AItemVendaList.Items[Index].GetQuantidadeJaPromocionada > 0 then
        begin
          if QuantidadeItensPromocionaveis > 0 then
          begin
            if (AItemVendaList.Items[Index].Quantidade - AItemVendaList.Items[Index].GetQuantidadeJaPromocionada) > QuantidadeItensPromocionaveis then
              QuantidadeDescontos := QuantidadeItensPromocionaveis
            else
              QuantidadeDescontos := AItemVendaList.Items[Index].Quantidade - AItemVendaList.Items[Index].GetQuantidadeJaPromocionada;

            ValorDescontoPromocao := StrToFloat(FormatFloat(FORMAT, QuantidadeDescontos * ValorPromocionadoPorUnidade));
            QuantidadeItensPromocionaveis := QuantidadeItensPromocionaveis - QuantidadeDescontos;

            if AItemVendaList.Items[Index].GetPossuiDescontoAplicado then
            begin
              ValorDescontoPendentePromocao := ValorDescontoPromocao;
              AItemVendaList.Items[Index].SetQuantidadeJaPromocionada(AItemVendaList.Items[Index].GetQuantidadeJaPromocionada + QuantidadeDescontos);
            end
            else
            begin
              if ValorDescontoPendentePromocao > 0 then
              begin
                if ValorDescontoPromocao + ValorDescontoPendentePromocao < StrToFloat(FormatFloat(FORMAT, AItemVendaList.Items[Index].Quantidade * AItemVendaList.Items[Index].Preco)) then
                begin
                  ValorDescontoPromocao := ValorDescontoPromocao + ValorDescontoPendentePromocao;
                  ValorDescontoPendentePromocao := 0;
                end
                else
                begin
                  ValorDescontoPendentePromocao := (ValorDescontoPromocao + ValorDescontoPendentePromocao) - (StrToFloat(FormatFloat(FORMAT, AItemVendaList.Items[Index].Quantidade * AItemVendaList.Items[Index].Preco)) - 0.01);
                  ValorDescontoPromocao := StrToFloat(FormatFloat(FORMAT, AItemVendaList.Items[Index].Quantidade * AItemVendaList.Items[Index].Preco)) - 0.01;
                end;
              end;
              ValorPromocionadoAcumulado := ValorPromocionadoAcumulado + ValorDescontoPromocao;
              if (QuantidadeItensPromocionaveis = 0) and (ValorPromocionadoAcumulado <> ValorPromocionado) then
              begin
                if ValorPromocionadoAcumulado > ValorPromocionado then
                begin
                  if ValorDescontoPromocao - Abs(ValorPromocionadoAcumulado - ValorPromocionado) < StrToFloat(FormatFloat(FORMAT, AItemVendaList.Items[Index].Quantidade * AItemVendaList.Items[Index].Preco)) then
                    ValorDescontoPromocao := ValorDescontoPromocao - Abs(ValorPromocionadoAcumulado - ValorPromocionado);
                end
                else
                if ValorPromocionadoAcumulado < ValorPromocionado then
                begin
                  if ValorDescontoPromocao + Abs(ValorPromocionadoAcumulado - ValorPromocionado) < StrToFloat(FormatFloat(FORMAT, AItemVendaList.Items[Index].Quantidade * AItemVendaList.Items[Index].Preco)) then
                    ValorDescontoPromocao := ValorDescontoPromocao + Abs(ValorPromocionadoAcumulado - ValorPromocionado);
                end
              end;

              Resultado.Add(AItemVendaList.Items[Index].Id, CarregaDetalhesValor(ValorDescontoPromocao,Self.Id));
              AItemVendaList.Items[Index].SetPossuiDescontoAplicado(True);
              AItemVendaList.Items[Index].SetQuantidadeJaPromocionada(AItemVendaList.Items[Index].GetQuantidadeJaPromocionada + QuantidadeDescontos);
              Result := True;
            end;
            AcumulaItem(AItemVendaList.Items[Index].CodigoProduto, QuantidadeDescontos, taSubtrair);
          end;
        end;
      end;
    end;
    if Result then
      FContadorIncidenciaNoCupom := FContadorIncidenciaNoCupom + QuantidadeDePromocoesAplicadas;
  end;
end;

{ TPromoVendaCasada }

function TPromoVendaCasada.AtendeRequisitosParaPromocionar: Boolean;
var
  Index: Integer;
begin
  if inherited then
  begin
    Result := True;
    if not Assigned(FProdutosDaPromocao) then
    begin
      FAcumuladoPromocional := 0;
      FProdutosDaPromocao := TProdutoComboList.Create;
      PreencheProdutosDaPromocao;
    end;
    for Index := 0 to Combos.Count - 1 do
    begin
      if Combos[Index].Acumulado < Combos[Index].QuantidadePromocional then
      begin
        Result := False;
        Break;
      end;
    end;
    if Result then
    begin
      if FProdutosDaPromocao.AcumuladoDosProdutos < FAcumuladoPromocional  then
        Result := False;
    end;
  end;
end;

procedure TPromoVendaCasada.PreencheProdutosDaPromocao;
var
  IndexCombo, IndexProduto: Integer;
  Produto: IProdutoCombo;
begin
  for IndexCombo := 0 to Combos.Count - 1 do
  begin
    FAcumuladoPromocional := FAcumuladoPromocional + Combos[IndexCombo].QuantidadePromocional;
    for IndexProduto := 0 to Combos[IndexCombo].Produtos.Count - 1 do
    begin
      Produto := FProdutosDaPromocao.BuscaProduto(Combos[IndexCombo].Produtos[IndexProduto].Codigo);
      if Assigned(Produto) then
      begin
        if not SameText(Produto.Tipo, Combos[IndexCombo].Tipo) then
        begin
          if not Assigned(FProdutoPrincipalEBeneficio) then
            FProdutoPrincipalEBeneficio := TProdutoComboList.Create;
          FProdutoPrincipalEBeneficio.Add(Produto);
        end;
      end
      else
      begin
        Combos[IndexCombo].Produtos[IndexProduto].SetTipo(Combos[IndexCombo].Tipo);
        FProdutosDaPromocao.Add(Combos[IndexCombo].Produtos[IndexProduto]);
      end;
    end;
  end;
end;

function TPromoVendaCasada.Promociona(AItemVendaList: TItemVendaList): boolean;
var
  Index: Integer;
  QuantidadeDePromocoesAplicadas: integer;
  QuantidadeItensPromocionaveis: integer;
  ValorPromocionadoPorUnidade: Extended;
  QuantidadeDescontos: integer;
  ValorDescontoPromocao: Extended;
  ComboProduto: IComboPromocao;

  procedure ProcessaProdutoPromocional;
  begin
    if (AItemVendaList.Items[Index].Quantidade - AItemVendaList.Items[Index].GetQuantidadeJaPromocionada) > QuantidadeItensPromocionaveis then
      QuantidadeDescontos := QuantidadeItensPromocionaveis
    else
      QuantidadeDescontos := AItemVendaList.Items[Index].Quantidade - AItemVendaList.Items[Index].GetQuantidadeJaPromocionada;
    QuantidadeItensPromocionaveis := QuantidadeItensPromocionaveis - QuantidadeDescontos;
    AItemVendaList.Items[Index].SetQuantidadeJaPromocionada(AItemVendaList.Items[Index].GetQuantidadeJaPromocionada + QuantidadeDescontos);
    AcumulaItem(AItemVendaList.Items[Index].CodigoProduto, QuantidadeDescontos, taSubtrair);
    ComboProduto.SetQuantidadePromocionada(ComboProduto.GetQuantidadePromocionada + QuantidadeDescontos);
  end;

  procedure ProcessaProdutoBeneficio;
  begin
    ValorPromocionadoPorUnidade := ValorPromocionadoUnidade(AItemVendaList.Items[Index].Preco,
                                        ComboProduto.QuantidadePromocional,
                                        ComboProduto.TipoDesconto,
                                        ComboProduto.Desconto);
    if (AItemVendaList.Items[Index].Quantidade - AItemVendaList.Items[Index].GetQuantidadeJaPromocionada) > QuantidadeItensPromocionaveis then
    begin
      QuantidadeDescontos := QuantidadeItensPromocionaveis;
      ValorDescontoPromocao := StrToFloat(FormatFloat(FORMAT, QuantidadeDescontos * ValorPromocionadoPorUnidade));
      QuantidadeItensPromocionaveis := QuantidadeItensPromocionaveis - QuantidadeDescontos;
    end
    else
    begin
      QuantidadeDescontos := AItemVendaList.Items[Index].Quantidade - AItemVendaList.Items[Index].GetQuantidadeJaPromocionada;
      ValorDescontoPromocao := StrToFloat(FormatFloat(FORMAT, QuantidadeDescontos * ValorPromocionadoPorUnidade));
      QuantidadeItensPromocionaveis := QuantidadeItensPromocionaveis - QuantidadeDescontos;
    end;
    if AItemVendaList.Items[Index].GetPossuiDescontoAplicado then
    begin
      ComboProduto.SetDescontoPendente(ComboProduto.GetDescontoPendente + ValorDescontoPromocao);
    end
    else
    begin
      // Aplica o desconto pendente do combo
      if GetDescontoPendente > 0 then
      begin
        if ComboProduto.GetDescontoPendente > 0 then
        begin
          if ComboProduto.GetDescontoPendente + ValorDescontoPromocao <  StrToFloat(FormatFloat(FORMAT, AItemVendaList.Items[Index].Quantidade * AItemVendaList.Items[Index].Preco)) then
          begin
            ValorDescontoPromocao := ValorDescontoPromocao + ComboProduto.GetDescontoPendente;
            ComboProduto.SetDescontoPendente(0);
          end;
        end;
        // Tenta aplicar o restante
        TentaAplicarDescontoPendente(StrToFloat(FormatFloat(FORMAT, AItemVendaList.Items[Index].Quantidade * AItemVendaList.Items[Index].Preco)), ValorDescontoPromocao);
      end;
      Resultado.Add(AItemVendaList.Items[Index].Id, CarregaDetalhesValor(ValorDescontoPromocao,Self.Id));
      AItemVendaList.Items[Index].SetPossuiDescontoAplicado(True);
      Result := True;
    end;
    AItemVendaList.Items[Index].SetQuantidadeJaPromocionada(AItemVendaList.Items[Index].GetQuantidadeJaPromocionada + QuantidadeDescontos);
    AcumulaItem(AItemVendaList.Items[Index].CodigoProduto, QuantidadeDescontos, taSubtrair);
    ComboProduto.SetQuantidadePromocionada(ComboProduto.GetQuantidadePromocionada + QuantidadeDescontos);
  end;

begin
  Result := False;
  Resultado.Clear;
  QuantidadeDePromocoesAplicadas := QuantidadePromocoesAplicadas;
  if not AtingidoLimiteDaPromocaoNoCupom then
  begin
    if FLimitePorCupom > 0 then
    begin
      if (FContadorIncidenciaNoCupom + QuantidadeDePromocoesAplicadas) > FLimitePorCupom then
        QuantidadeDePromocoesAplicadas := FLimitePorCupom - FContadorIncidenciaNoCupom;
    end;
    ValorPromocionadoPorUnidade := 0;
    for Index := 0 to AItemVendaList.Count - 1 do
    begin
      if AItemVendaList.Items[Index].Quantidade - AItemVendaList.Items[Index].GetQuantidadeJaPromocionada > 0 then
      begin
        if Assigned(FProdutoPrincipalEBeneficio) and (FProdutoPrincipalEBeneficio.ExisteProduto(AItemVendaList.Items[Index].CodigoProduto)) then //Quando o produto é promocional e benefício ao mesmo tempo
        begin
          ComboProduto := ComboDoProduto(AItemVendaList.Items[Index].CodigoProduto, 'B');
          QuantidadeItensPromocionaveis := (QuantidadeDePromocoesAplicadas * ComboProduto.QuantidadePromocional) - ComboProduto.GetQuantidadePromocionada;
          if QuantidadeItensPromocionaveis > 0 then
          begin
            ProcessaProdutoBeneficio;
          end;

          if AItemVendaList.Items[Index].Quantidade - AItemVendaList.Items[Index].GetQuantidadeJaPromocionada > 0 then
          begin
            ComboProduto := ComboDoProduto(AItemVendaList.Items[Index].CodigoProduto, 'P');
            QuantidadeItensPromocionaveis := (QuantidadeDePromocoesAplicadas * ComboProduto.QuantidadePromocional) - ComboProduto.GetQuantidadePromocionada;
            if QuantidadeItensPromocionaveis > 0 then
            begin
              ProcessaProdutoPromocional;
            end;
          end;
        end
        else
        begin
          ComboProduto := ComboDoProduto(AItemVendaList.Items[Index].CodigoProduto);
          if Assigned(ComboProduto) then
          begin
            if ComboProduto.Tipo = 'P' then
            begin
              QuantidadeItensPromocionaveis := (QuantidadeDePromocoesAplicadas * ComboProduto.QuantidadePromocional) - ComboProduto.GetQuantidadePromocionada;
              if QuantidadeItensPromocionaveis > 0 then
              begin
                ProcessaProdutoPromocional;
              end;
            end
            else
            begin
              QuantidadeItensPromocionaveis := (QuantidadeDePromocoesAplicadas * ComboProduto.QuantidadePromocional) - ComboProduto.GetQuantidadePromocionada;
              if QuantidadeItensPromocionaveis > 0 then
              begin
                ProcessaProdutoBeneficio;
              end;
            end;
          end;
        end;
      end;
    end;
    if GetDescontoPendente > 0 then
      Result := True;
    if Result then
      FContadorIncidenciaNoCupom := FContadorIncidenciaNoCupom + QuantidadeDePromocoesAplicadas;
  end;
end;

function TPromoVendaCasada.QuantidadePromocoesAplicadas: Integer;
begin
  Result := inherited;
  if Assigned(FProdutoPrincipalEBeneficio) then
  begin
    if Trunc(FProdutosDaPromocao.AcumuladoDosProdutos / FAcumuladoPromocional) < Result  then
      Result := Trunc(FProdutosDaPromocao.AcumuladoDosProdutos / FAcumuladoPromocional);
  end;
end;

{ TProdutoComboList }

function TProdutoComboList.AcumuladoDosProdutos: Extended;
var
  Index: Integer;
begin
  Result := 0;
  for Index := 0 to Self.Count - 1 do
    Result := Result + Self[Index].Acumulo.Acumulado;
end;

function TProdutoComboList.BuscaProduto(const ACodigo: string): IProdutoCombo;
var
  Index: Integer;
begin
  Result := nil;
  for Index := 0 to Self.Count - 1 do
  begin
    if SameText(Self[Index].Codigo, ACodigo) then
    begin
      Result := Self[Index];
      Break;
    end;
  end;
end;

function TProdutoComboList.ExisteProduto(const ACodigo: string): Boolean;
var
  Index: Integer;
begin
  Result := False;
  for Index := 0 to Self.Count - 1 do
  begin
    if SameText(Self[Index].Codigo, ACodigo) then
    begin
      Result := True;
      Break;
    end;
  end;
end;

{ TPromoDesconto }

function TPromoDesconto.AtendeRequisitosParaPromocionar: Boolean;
var
  Index: Integer;
begin
  if inherited then
  begin
    Result := True;
    for Index := 0 to Combos.Count - 1 do
    begin
      if Combos[Index].Acumulado < Combos[Index].QuantidadePromocional then
      begin
        Result := False;
        Break;
      end;
    end;
  end;
end;

function TPromoDesconto.Promociona(AItemVendaList: TItemVendaList): boolean;
var
  Index: Integer;
  QuantidadeDePromocoesAplicadas: integer;
  QuantidadeItensPromocionaveis: integer;
  ValorPromocionadoPorUnidade: Extended;
  ValorDescontoPromocao: Extended;
  QuantidadeDescontos: integer;
  ComboProduto: IComboPromocao;
begin
  Result := False;
  Resultado.Clear;
  QuantidadeDePromocoesAplicadas := QuantidadePromocoesAplicadas;
  if not AtingidoLimiteDaPromocaoNoCupom then
  begin
    if FLimitePorCupom > 0 then
    begin
      if (FContadorIncidenciaNoCupom + QuantidadeDePromocoesAplicadas) > FLimitePorCupom then
        QuantidadeDePromocoesAplicadas := FLimitePorCupom - FContadorIncidenciaNoCupom;
    end;
    ValorPromocionadoPorUnidade := 0;
    for Index := 0 to AItemVendaList.Count - 1 do
    begin
      ComboProduto := ComboDoProduto(AItemVendaList.Items[Index].CodigoProduto);
      if Assigned(ComboProduto) then
      begin
        if AItemVendaList.Items[Index].Quantidade - AItemVendaList.Items[Index].GetQuantidadeJaPromocionada > 0 then
        begin
          QuantidadeItensPromocionaveis := (QuantidadeDePromocoesAplicadas * ComboProduto.QuantidadePromocional) - ComboProduto.GetQuantidadePromocionada;
          if QuantidadeItensPromocionaveis > 0 then
          begin
            ValorPromocionadoPorUnidade := ValorPromocionadoUnidade(AItemVendaList.Items[Index].Preco,
                                                ComboProduto.QuantidadePromocional,
                                                ComboProduto.TipoDesconto,
                                                ComboProduto.Desconto);
            if (AItemVendaList.Items[Index].Quantidade - AItemVendaList.Items[Index].GetQuantidadeJaPromocionada) > QuantidadeItensPromocionaveis then
            begin
              QuantidadeDescontos := QuantidadeItensPromocionaveis;
              ValorDescontoPromocao := StrToFloat(FormatFloat(FORMAT, QuantidadeDescontos * ValorPromocionadoPorUnidade));
              QuantidadeItensPromocionaveis := QuantidadeItensPromocionaveis - QuantidadeDescontos;
            end
            else
            begin
              QuantidadeDescontos := AItemVendaList.Items[Index].Quantidade - AItemVendaList.Items[Index].GetQuantidadeJaPromocionada;
              ValorDescontoPromocao := StrToFloat(FormatFloat(FORMAT, QuantidadeDescontos * ValorPromocionadoPorUnidade));
              QuantidadeItensPromocionaveis := QuantidadeItensPromocionaveis - QuantidadeDescontos;
            end;
            if AItemVendaList.Items[Index].GetPossuiDescontoAplicado then
            begin
              ComboProduto.SetDescontoPendente(ComboProduto.GetDescontoPendente + ValorDescontoPromocao);
            end
            else
            begin
              if GetDescontoPendente > 0 then
              begin
                // Aplica o desconto pendente do combo
                if ComboProduto.GetDescontoPendente > 0 then
                begin
                  if ComboProduto.GetDescontoPendente + ValorDescontoPromocao < StrToFloat(FormatFloat(FORMAT, AItemVendaList.Items[Index].Quantidade * AItemVendaList.Items[Index].Preco)) then
                  begin
                    ValorDescontoPromocao := ValorDescontoPromocao + ComboProduto.GetDescontoPendente;
                    ComboProduto.SetDescontoPendente(0);
                  end;
                end;
                // Tenta aplicar o restante
                TentaAplicarDescontoPendente(StrToFloat(FormatFloat(FORMAT, AItemVendaList.Items[Index].Quantidade * AItemVendaList.Items[Index].Preco)), ValorDescontoPromocao);
              end;
              Resultado.Add(AItemVendaList.Items[Index].Id, CarregaDetalhesValor(ValorDescontoPromocao,Self.Id));
              AItemVendaList.Items[Index].SetPossuiDescontoAplicado(True);
              Result := True;
            end;
            AItemVendaList.Items[Index].SetQuantidadeJaPromocionada(AItemVendaList.Items[Index].GetQuantidadeJaPromocionada + QuantidadeDescontos);
            AcumulaItem(AItemVendaList.Items[Index].CodigoProduto, QuantidadeDescontos, taSubtrair);
            ComboProduto.SetQuantidadePromocionada(ComboProduto.GetQuantidadePromocionada + QuantidadeDescontos);
          end;
        end;
      end;
    end;
    if GetDescontoPendente > 0 then
      Result := True;
    if Result then
      FContadorIncidenciaNoCupom := FContadorIncidenciaNoCupom + QuantidadeDePromocoesAplicadas;
  end;
end;

end.

