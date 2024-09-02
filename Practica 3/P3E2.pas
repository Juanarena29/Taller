program dos;
const
  cod = 61;
  can = 20;
type 
  dias = 1..31;
  meses = 1..12;
  años = 2022..2024;
  
  fechas = record
    dia : dias;
    mes : meses;
    año: años;
    end;  
    
  venta = record
    codigo : integer;
    fecha : fechas;
    cantidad : integer;
    end;

  arbola =^nodoa;
  
  nodoa = record 
    dato : venta;
    hi : arbola;
    hd : arbola;
    end;
    
  arbolb = ^nodob;
  
  nodob = record
    codigob : integer;
    cantidadb : integer;
    hi : arbolb;
    hd : arbolb;
    end;
  
  listac = ^nodolista;
  
  nodolista=record
    dato : cant;
    sig : listac;
    end;

  arbolc = ^nodoc;
  
  nodoc = record
    codigoc : integer;
    lista : listac;
    hi : arbolc;
    hd : arbolc;
    end;
    

procedure leerventa(var v:venta);
begin
  v.codigo:=random(cod);
  v.fecha.dia:=random(31)+1;
  v.fecha.mes:=random(12)+1;
  v.fecha.año:=random(3)+2022;
  v.cantidad:=random(can)+1;
end;


procedure generararboles(var a,b,c : arbol)

procedure arbolaa(var a: arbol; v : venta);
begin
  if a = nil then
    begin
    new(a);
    a^.dato:=v;
    a^.hi:=nil;
    a^.hd:=nil; 
    end
    else 
      if v.codigo >= a^.dato.codigo then arbolaa(a^.hd,v)
      else arbolaa(a^.hi,v);
end;  

procedure arbolbb(var b: arbol; v : venta);
begin  
  if b = nil then
    begin
    new(b);
    b^.dato.codigob:=v.codigo;
    b^.dato.cantidadb:=v.cantidad;
    b^.hi:=nil;
    b^.hd:=nil; 
    end
    else
      if v.codigo >= b^.dato.codigob then arbolbb(b^.hd,v)
      else arbolbb(b^.hi,v);
end;

procedure arbolcc(var c:arbol; v : venta);

procedure agregaradelante(var l : lista; num : integer);
var aux : lista;
begin
  new(aux);
  aux^.dato:=num;
  aux^.sig:=l;
  l:=aux;
end; 
 
  
begin
  if c = nil then
    begin
      new(c)
      c^.codigoc:=v.codigo;
      c^.lista:=nil; //inicializo la lista de venta en nil
      c^.hi:=nil;
      c^.hd:=nil;
      agregaradelante(c^.lista,v.cantidad); //le paso por parametro la lista
      end
      else if c^.codigoc=v.codigo then agregaradelante(c^.lista,v.cantidad)
        //nodo encontrado, agrego a la lista
      else if v.codigo < c^.codigoc then arbolcc(c^.hi,v)
      else arbolcc(c^.hd,v);
end;

var
  v : venta;
  
begin
  a:=nil;
  b:=nil;
  c:=nil;
  leerventa(v);
  while v.codigo <> 0 do begin
    arbolaa(a,v);
    arbolbb(b,v);
    arbolcc(c,v);
    leerventa(v);
    end;
end;
  
function cantidad(a: arbol; f: fecha): integer;
var 
  total: integer;

procedure acumular(a: arbol; f: fecha; var total: integer);
begin
  if a <> nil then 
  begin
    acumular(a^.hi, f, total);  // Recorrer el subárbol izquierdo
    if a^.dato.fecha = f then 
      total := total + a^.dato.cantidad;  // Sumar cantidad si la fecha coincide
    acumular(a^.hd, f, total);  // Recorrer el subárbol derecho
  end;
end;

begin
  total := 0;  // Inicializar total en 0 antes de comenzar
  acumular(a, f, total);  // Llamar al procedimiento auxiliar
  cantidad := total;  // Devolver el resultado
end;


      
var
  a : arbola;
  b : arbolb;
  c : arbolc;
  diax : dias;
  mesx : meses;
  añox : años;
begin
  randomize;
  generararboles(a,b,c);   
  writeln;
  writeln('Cantidad de productos en fecha');
  writeln('dia: ');readln(f.dia);
  writeln('mes: ');readln(f.mes);
  writeln('año: ');readln(f.año);
  writeln('La cantidad de productos vendidos en la fecha  -  ',f.dia,'/',f.mes,'/',f.año);
  writeln('cantidad : ', cantidad(a,f);
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
