unit Acumulo;

interface

uses
  System.Generics.Collections, UnPromoCore;

Type
  TTipoAcumulo = (taSomar, taSubtrair);

  TAcumulo = class (TInterfacedObject, IAcumulo)
    property Acumulado: Extended read GetAcumulado;
    function GetAcumulado: extended;
    procedure Soma(AValue: Extended);
    procedure Subtrai(AValue: Extended);
    procedure Zera;
  end;

implementation

{ TAcumulo }

function TAcumulo.GetAcumulado: extended;
begin

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
