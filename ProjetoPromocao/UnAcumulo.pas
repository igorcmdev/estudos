unit UnAcumulo;

interface

uses
  System.Generics.Collections, UnPromoCore;

Type
  TTipoAcumulo = (taSomar, taSubtrair);

  TAcumulo = class (TInterfacedObject, IAcumulo)
  private
    FAcumulado: Extended;
  public
    property Acumulado: Extended read FAcumulado;
    function GetAcumulado: Extended;
    procedure Soma(AValue: Extended);
    procedure Subtrai(AValue: Extended);
    procedure Zera;
  end;

implementation

{ TAcumulo }

function TAcumulo.GetAcumulado: extended;
begin
  Result := FAcumulado;
end;

procedure TAcumulo.Soma(AValue: Extended);
begin

end;

procedure TAcumulo.Subtrai(AValue: Extended);
begin

end;

procedure TAcumulo.Zera;
begin

end;

end.
