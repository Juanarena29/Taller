program uno;
type 
 rango = 12..100;
 cadena15 = string [15];
 socio = record
   numero: integer;
   nombre: cadena15;
   edad: rango;
     end;
 arbol = ^nodo;
 nodo = record
   dato: socio;
   HI: arbol;
   HD: arbol;
     end;
     
procedure GenerarArbol (var a: arbol);
{ Implementar un modulo que almacene informacion de socios de un club en un arbol binario de busqueda. De cada socio se debe almacenar numero de socio, 
nombre y edad. La carga finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. La informacion de cada socio debe generarse
aleatoriamente. }

  Procedure CargarSocio (var s: socio);
  var vNombres:array [0..9] of string= ('Ana', 'Jose', 'Luis', 'Ema', 'Ariel', 'Pedro', 'Lena', 'Lisa', 'Martin', 'Lola'); 
  
  begin
    s.numero:= random (51) * 100;
    If (s.numero <> 0)
    then begin
           s.nombre:= vNombres[random(10)];
           s.edad:= 12 + random (79);
         end;
  end;  
  
  Procedure InsertarElemento (var a: arbol; elem: socio);
  Begin
    if (a = nil) 
    then begin
           new(a);
           a^.dato:= elem; 
           a^.HI:= nil; 
           a^.HD:= nil;
         end
    else if (elem.numero < a^.dato.numero) 
         then InsertarElemento(a^.HI, elem)
         else InsertarElemento(a^.HD, elem); 
  End;

var unSocio: socio;  
Begin
 writeln;
 writeln ('----- Ingreso de socios y armado del arbol ----->');
 writeln;
 a:= nil;
 CargarSocio (unSocio);
 while (unSocio.numero <> 0)do
  begin
   InsertarElemento (a, unSocio);
   CargarSocio (unSocio);
  end;
 writeln;
 writeln ('//////////////////////////////////////////////////////////');
 writeln;
end;

procedure InformarSociosOrdenCreciente (a: arbol);
{ Informar los datos de los socios en orden creciente. }
  
  procedure InformarDatosSociosOrdenCreciente (a: arbol);
  begin
    if ((a <> nil) and (a^.HI <> nil))
    then InformarDatosSociosOrdenCreciente (a^.HI);
    writeln ('Numero: ', a^.dato.numero, ' Nombre: ', a^.dato.nombre, ' Edad: ', a^.dato.edad);
    if ((a <> nil) and (a^.HD <> nil))
    then InformarDatosSociosOrdenCreciente (a^.HD);
  end;

Begin
 writeln;
 writeln ('----- Socios en orden creciente por numero de socio ----->');
 writeln;
 InformarDatosSociosOrdenCreciente (a);
 writeln;
 writeln ('//////////////////////////////////////////////////////////');
 writeln;
end;

procedure InformarSociosOrdenDecreciente (a: arbol);
{ Informar los datos de los socios en orden Decreciente. }
  
  procedure InformarDatosSociosOrdenDecreciente (a: arbol);
  begin
    if ((a <> nil) and (a^.HD <> nil))
    then InformarDatosSociosOrdenDecreciente (a^.HD);
    writeln ('Numero: ', a^.dato.numero, ' Nombre: ', a^.dato.nombre, ' Edad: ', a^.dato.edad);
    if ((a <> nil) and (a^.HI <> nil))
    then InformarDatosSociosOrdenDecreciente (a^.HI);
  end;

Begin
 writeln;
 writeln ('----- Socios en orden Dereciente por numero de socio ----->');
 writeln;
 InformarDatosSociosOrdenDecreciente (a);
 writeln;
 writeln ('//////////////////////////////////////////////////////////');
 writeln;
end;

procedure InformarNumeroSocioConMasEdad (a: arbol);
{ Informar el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor.  }

     procedure actualizarMaximo(var maxValor,maxElem : integer; nuevoValor, nuevoElem : integer);
	begin
	  if (nuevoValor >= maxValor) then
	  begin
		maxValor := nuevoValor;
		maxElem := nuevoElem;
	  end;
	end;
	procedure NumeroMasEdad (a: arbol; var maxEdad: integer; var maxNum: integer);
	begin
	   if (a <> nil) then
	   begin
		  actualizarMaximo(maxEdad,maxNum,a^.dato.edad,a^.dato.numero);
		  numeroMasEdad(a^.hi, maxEdad,maxNum);
		  numeroMasEdad(a^.hd, maxEdad,maxNum);
	   end; 
	end;

var maxEdad, maxNum: integer;
begin
  writeln;
  writeln ('----- Informar Numero Socio Con Mas Edad ----->');
  writeln;
  maxEdad := -1;
  NumeroMasEdad (a, maxEdad, maxNum);
  if (maxEdad = -1) 
  then writeln ('Arbol sin elementos')
  else begin
         writeln;
         writeln ('Numero de socio con mas edad: ', maxNum);
         writeln;
       end;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

procedure AumentarEdadNumeroImpar (a: arbol);
{Aumentar en 1 la edad de los socios con edad impar e informar la cantidad de socios que se les aumento la edad.}
  
  function AumentarEdad (a: arbol): integer;
  var resto: integer;
  begin
     if (a = nil) 
     then AumentarEdad:= 0
     else begin
            resto:= a^.dato.edad mod 2;
            if (resto = 1) then a^.dato.edad:= a^.dato.edad + 1;
            AumentarEdad:= resto + AumentarEdad (a^.HI) + AumentarEdad (a^.HD);
          end;  
  end;
begin
  writeln;
  writeln ('----- Cantidad de socios con edad aumentada ----->');
  writeln;
  writeln ('Cantidad: ', AumentarEdad (a));
  writeln;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;


function InformarExistenciaNombreSocio(a : arbol; nombre: cadena15): boolean;
var
 existe : boolean;
begin
  if a = nil then
    InformarExistenciaNombreSocio := false
    else begin
      if a^.dato.nombre = nombre then
        InformarExistenciaNombreSocio:= true
        else begin
          existe:=InformarExistenciaNombreSocio(a^.HI,nombre);
          if (not existe) then
            existe:=InformarExistenciaNombreSocio(a^.HD,nombre);
          InformarExistenciaNombreSocio:=existe;
        end;
      end;
end;


function InformarCantidadSocios(a : arbol): integer;
begin
  if a = nil then InformarCantidadSocios:= 0
  else InformarCantidadSocios:= 1 + InformarCantidadSocios(a^.HI) + InformarCantidadSocios(a^.HD);
end;


function InformarPromedioDeEdad(a : arbol; can : integer): real;
function sumaredades(a:arbol): integer;
begin
if a = nil then 
    sumaredades:= 0
    else
      sumaredades:= a^.dato.edad +  sumaredades(a^.HI) +  sumaredades(a^.HD);
end;
var
  sumaedades:integer;
begin
  sumaedades:=sumaredades(a);
  if can=0 then
    InformarPromedioDeEdad:=0
    else InformarPromedioDeEdad:=sumaedades/can;
end;

procedure sociogrande(a : arbol; var nsg : integer);
begin
  if a<> nil then begin
     nsg:=a^.dato.numero; 
     sociogrande(a^.HD,nsg);
   
   end;	
end;

procedure sociochico(a : arbol; var s : socio);
begin
  if a<>nil then begin
    s:=a^.dato;  //antes de cada llamada, guardo el ultimo dato leido
    sociochico(a^.HI,s);
	end;
end;

function existesocio(a : arbol; valor : integer): boolean;
begin
  if a = nil then 
    existesocio :=false
  else  if a^.dato.numero=valor then 
    existesocio:=true
	
  else 
    if a^.dato.numero<valor then 
    existesocio:=existesocio(a^.HD,valor)
  else existesocio:=existesocio(a^.HI,valor);
end;

function socioentrerango(a : arbol; izq,der : integer): integer;
begin
  if a = nil then 
    socioentrerango:=0
  else if (a^.dato.numero>izq) and (a^.dato.numero<der) then
	socioentrerango:=socioentrerango(a^.HI,izq,der) + socioentrerango(a^.HD,izq,der) + 1
  else if a^.dato.numero < izq then socioentrerango:=socioentrerango(a^.HD,izq,der)
	else  socioentrerango:=socioentrerango(a^.HI,izq,der);

end;


var a: arbol; 
socio1: cadena15;
s : socio;
cant : integer;
numsocio : integer;
valor : integer;
izq,der : integer;
Begin
  randomize;
  GenerarArbol(a);
  InformarSociosOrdenCreciente(a);
  InformarSociosOrdenDecreciente(a); 
  InformarNumeroSocioConMasEdad(a);
  AumentarEdadNumeroImpar(a);
  writeln('Ingrese nombre del socio: ');readln(socio1);
  if InformarExistenciaNombreSocio(a,socio1) then writeln('existe')
  else writeln('no existe');  
  writeln;
  writeln;
  cant:=InformarCantidadSocios(a);
  writeln('La cantidad de socios es: ',cant);
  writeln('El promedio de edad de los socios es: ', InformarPromedioDeEdad(a,cant):2:0);
  sociogrande(a,numsocio);
  writeln('El numero de socio mas grande es: ',numsocio);
  sociochico(a,s);
  writeln('Socio con el numero mas chico: ');
  writeln('Numero: ',s.numero);
  writeln('Nombre: ',s.nombre);
  writeln('Edad: ',s.edad);
  writeln('Escriba un valor entero:  ');readln(valor);
  writeln;
  if existesocio(a,valor) then writeln('EXISTE EL SOCIO')
  else writeln('NO EXISTE EL SOCIO');
  writeln;
  writeln('Escriba valor inferior del rango: ');readln(izq);
  writeln('Escriba valor superior del rango: ');readln(der);
  writeln;
  writeln('Dentro del rango existen ',socioentrerango(a,izq,der),' socios');
End.
