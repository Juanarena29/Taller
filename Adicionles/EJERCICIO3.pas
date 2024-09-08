{Un supermercado requiere el procesamiento de sus productos. De cada producto se
conoce código, rubro (1..10), stock y precio unitario. Se pide:
a) Generar una estructura adecuada que permita agrupar los productos por rubro. A su
vez, para cada rubro, se requiere que la búsqueda de un producto por código sea lo
más eficiente posible. El ingreso finaliza con el código de producto igual a 0.
b) Implementar un módulo que reciba la estructura generada en a), un rubro y un código
de producto y retorne si dicho código existe o no para ese rubro.
c) Implementar un módulo que reciba la estructura generada en a), y retorne, para cada
rubro, el código y stock del producto con mayor código.
d) Implementar un módulo que reciba la estructura generada en a), dos códigos y
retorne, para cada rubro, la cantidad de productos con códigos entre los dos valores
ingresados.}

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
      p.stock := random(20);
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
  iniciararboles(v,diml+1);
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
      if a^.HD = nil then begin
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
    writeln('Para el rubro ',diml, 'Codigo mayor : ',codemayor,' - stock: ',stockmayor);
    moduloC(v,diml-1);
    end;
end;

procedure moduloD(v : vector; izq,der : integer);


   
        






var
  diml : integer;
 rub : subrango;
  v : vector;
  code : integer;
begin
  diml := 0;
  moduloA(v,diml);
  writeln('El vector de arboles se ha generado correctamente');
  writeln;
  writeln('Escriba un rubro (1..10) y un codigo de producto (1..50)');
  writeln;
  writeln('Rubro: ');readln(rub);
  writeln('Codigo: ');readln(code);
  writeln;
  if moduloB(v,rub,code) = true then
    writeln('El codigo ingresado existe en dicho rubro')
    else writeln('El codigo ingresado no existe en dicho rubro');
  writeln;
  moduloC(v,diml);
end.
  
  



