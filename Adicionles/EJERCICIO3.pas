Program adi3;
const
  dimf = 10;
type
  subrango = 1..dimf;
  
  producto = record
    codigo : integer;
    rubro : subrango;
    stock : integer;
    precio : real;
    end;
    
  datoarbol = record
    codigo : integer;
    stock : integer;
    precio : real;
    end;
    
  arbol = ^nodoarbol;
  
  nodoarbol = record
    dato: datoarbol;
    hi : arbol;
    hd : arbol;
    end;
   
  vector = array[subrango] of arbol;
  
  
procedure moduloA(var v:vector; var diml : integer);

  procedure leerinformacion(var p : producto);
  begin
    p.codigo := random(51);
    if p.codigo <> 0 then begin
      p.rubro := random(10)+1;
      p.stock := random(20)+1;
      p.precio := random(300)/10;
      end;
  end;

  procedure iniciararboles(var v : vector; diml : integer);
  begin
    if diml <= dimf then begin
      v[diml]:=nil;
      iniciararboles(v,diml+1);
    end;
  end;
  
  procedure insertararbol(var a:arbol; p : producto);
  var d:datoarbol;
  begin
    d.codigo := p.codigo; d.stock:= p.stock; d.precio := p.precio;
    if a=nil then begin
      new(a);
      a^.dato := d;
      a^.hi := nil;
      a^.hd := nil;
      end
      else if d.codigo < a^.dato.codigo then
        insertararbol(a^.hi,p)
        else insertararbol(a^.hd,p);
  end;
var
 p : producto;
begin
  iniciararboles(v,1);
  leerinformacion(p);
  while p.codigo <> 0 do begin
    if v[p.rubro] = nil then
      diml := diml + 1;
    insertararbol(v[p.rubro],p);
    leerinformacion(p);
  end;
end;

function moduloB(v : vector; rubro: subrango; codigo : integer): boolean;

  function buscarcodigo(a : arbol; codigo : integer): boolean;
    begin
      if a = nil then buscarcodigo := false
      else
        if a^.dato.codigo = codigo then buscarcodigo:= true
        else if a^.dato.codigo > codigo then buscarcodigo:=buscarcodigo(a^.hi,codigo)
        else buscarcodigo:=buscarcodigo(a^.hd,codigo);
    end;

begin
  moduloB:=buscarcodigo(v[rubro],codigo);
end;

procedure moduloC(v : vector; diml : integer);

  procedure recorrerarboles(a : arbol; var codemayor : integer; var stockmayor : integer);
  begin
    if a <> nil then
      if a^.hd = nil then begin
        codemayor:= a^.dato.codigo;
        stockmayor := a^.dato.stock;
        end
        else
          recorrerarboles(a^.hd,codemayor,stockmayor);
    end;
var
 stockmayor, codemayor : integer;
begin
  if diml>0 then begin
    stockmayor:=-1;
    codemayor:=-1;
    recorrerarboles(v[diml],codemayor,stockmayor);
    writeln('Para el rubro ',diml, ' -- Codigo mas grande : ',codemayor,'  -- stock: ',stockmayor);
    moduloC(v,diml-1);
    end;
end;

procedure moduloD(v : vector; izq,der : integer; diml : integer);
  function recorrerarbol(a : arbol; izq,der : integer): integer;
  begin
    if a = nil then recorrerarbol := 0
    else
      if a^.dato.codigo >= izq then
        if a^.dato.codigo <= der then
          recorrerarbol:= 1 + recorrerarbol(a^.hi,izq,der) + recorrerarbol(a^.hd,izq,der)
        else recorrerarbol:= recorrerarbol(a^.hi,izq,der)
      else recorrerarbol := recorrerarbol(a^.hd,izq,der);
  end;
var
  cant : integer;
begin
  if diml > 0 then begin
    cant := recorrerarbol(v[diml],izq,der);
    writeln('----------------');
    writeln('Para el rubro ',diml,' Hay ', cant,' codigos entre los valores ingresados');
    moduloD(v,izq,der,diml-1);
  end;
end;
   
        






var
  diml : integer;
 rub : subrango;
  v : vector;
  code : integer;
  izq, der : integer;
begin
  randomize;
  diml := 0;
  moduloA(v,diml);
  writeln('El vector de arboles se ha generado correctamente');
  writeln;
  writeln('Escriba un rubro (1..10) y un codigo de producto (1..50)');
  writeln;
  writeln('Rubro: ');readln(rub);
  writeln;
  writeln('Codigo: ');readln(code);
  writeln;
  if moduloB(v,rub,code) = true then
    writeln('El codigo ingresado existe en dicho rubro')
    else writeln('El codigo ingresado no existe en dicho rubro');
  writeln;
  moduloC(v,diml);
  writeln;
  writeln('Ingrese dos valores entre 1 y 50');
  writeln;
  writeln('Min: ');readln(izq);
  writeln('Max: ');readln(der);
  moduloD(v,izq,der,diml);
end.
