Program P2E1;

const
  dimF = 15;
  min = 10;
  max = 155;

type
  vector = array[1..dimF] of integer;

procedure CargarVector(var v: vector; var dimL: integer);

  procedure CargarVectorRecursivo(var v: vector; var dimL: integer);
  var
    valor: integer;
  begin
    valor := min + random(max - min + 1);
    if (valor <> 20) and (dimL < dimF) then
    begin
      dimL := dimL + 1;
      v[dimL] := valor;
      CargarVectorRecursivo(v, dimL);
    end;
  end;

begin
  dimL := 0;
  CargarVectorRecursivo(v, dimL);
end;

procedure ImprimirVector(v: vector; dimL: integer);
var
  i: integer;
begin
  for i := 1 to dimL do
    write('----');
  writeln;
  write(' ');
  for i := 1 to dimL do
    write(v[i], ' | ');
  writeln;
  for i := 1 to dimL do
    write('----');
  writeln;
  writeln;
end;

procedure ImprimirVectorRecursivo(v: vector; dimL: integer);
begin
  if dimL > 0 then
  begin
    writeln('Posicion: ', dimL, '  ', v[dimL]);
    ImprimirVectorRecursivo(v, dimL - 1);
  end;
end;

function Sumar(v: vector; dimL: integer): integer;

  function SumarRecursivo(v: vector; pos, dimL: integer): integer;
  begin
    if pos <= dimL then
      SumarRecursivo := SumarRecursivo(v, pos + 1, dimL) + v[pos]
    else
      SumarRecursivo := 0;
  end;

begin
  Sumar := SumarRecursivo(v, 1, dimL);
end;

function ObtenerMaximo(v: vector; dimL: integer): integer;
var
  max: integer;
begin
  if dimL = 0 then
    ObtenerMaximo := -1
  else
  begin
    max := ObtenerMaximo(v, dimL - 1);
    if v[dimL] > max then
      ObtenerMaximo := v[dimL]
    else
      ObtenerMaximo := max;
  end;
end;

function BuscarValor(v: vector; dimL: integer; valor: integer): boolean;
begin
  if dimL = 0 then
    BuscarValor := false
  else if v[dimL] = valor then
    BuscarValor := true
  else
    BuscarValor := BuscarValor(v, dimL - 1, valor);
end;

procedure ImprimirDigitos(v: vector; dimL: integer);
var
  num, dig: integer;
begin
  if dimL > 0 then
  begin
    num := v[dimL];
    dig := num DIV 100;
    if dig <> 0 then
    begin
      write(dig);
      num := num MOD 100;
    end;
    dig := num DIV 10;
    write(' ', dig);
    dig := num MOD 10;
    write(' ', dig);
    writeln;
    ImprimirDigitos(v, dimL - 1);
  end;
end;

var
  dimL, suma, maximo, valor: integer;
  v: vector;
 
begin
  randomize;
  CargarVector(v, dimL);
  writeln;
  if dimL = 0 then
    writeln('--- Vector sin elementos ---')
  else
  begin
    ImprimirVector(v, dimL);
    { ImprimirVectorRecursivo(v, dimL); }
  end;

  suma := Sumar(v, dimL);
  writeln('La suma de los valores del vector es ', suma);
  
  maximo := ObtenerMaximo(v, dimL);
  writeln('El maximo del vector es ', maximo);

  write('Ingrese un valor a buscar: ');
  readln(valor);
  if BuscarValor(v, dimL, valor) then
    writeln('El ', valor, ' esta en el vector')
  else
    writeln('El ', valor, ' no esta en el vector');

  ImprimirDigitos(v, dimL);
end.
