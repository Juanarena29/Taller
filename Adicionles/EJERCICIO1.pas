Program ad1;
const
  dimf=300;
type
  indice =0..300;
  oficina = record
    codigo : integer;
    dni : integer;
    valor : real;
    end;

  vector = array[1..dimf] of oficina;
  
procedure moduloA(var v : vector; var diml : integer);

  procedure leeroficina(var o : oficina);
  begin
    o.codigo:=random(300);
    if o.codigo <> 0 then begin
    o.dni:=random(1000)+1;
    o.valor:=random(300)+200;
    end;
  end;
  
  procedure cargarrecursivo(var v : vector; var  diml : integer);
  begin
    leeroficina(o);
    if (o.codigo <> 0) and diml<dimf then begin
      diml:=diml+1;
      v[diml]:=o;
      cargarrecursivo(v,diml,o);
      end;
  end;

begin
  diml:=0;
  cargarrecursivo(v,diml);
end;

procedure moduloB(var v:vector; diml : integer);
var 
  j,i,p : indice;
  item : oficina;
begin
  for i:=1 to diml-1 do begin
    p:=1;
    for j:=i+1 to diml do
      if v[j] < v[p] then p:=j;
    item:=v[p];
    v[p]:=v[i];
    v[i]:=item;
    end;
end;

moduloC()
