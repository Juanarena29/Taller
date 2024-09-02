{Un sistema de gestion de correos electronicos desea manejar los correos
recibidos por cada cliente. De cada cliente se conoce su codigo (1..1000),
direccion de email y la cantidad de correos sin leer.

Realizar un programa que invoque a modulos para:

1) Leer y almacenar los clientes de una estructura de datos eficiente para
la busqueda por codigo de cliente. La lectura finaliza al ingresar el codigo
1000.

2)Leer un codigo de cliente e informar la cantidad de correos sin leer

3)Imprimir todos los codigos de lciente de mayor a menor

4)Leer una direccion de correo e informar si existe un cliente con esa direccion}
program ejemplo;

type
  rango = 1..1000;

  cliente = record
    codigo : rango;
    email : string;
    correos : integer;
  end;

  arbol = ^nodo;

  nodo = record
    dato : cliente;
    HI : arbol;
    HD : arbol;
  end;

procedure leercliente(var c : cliente);
begin
writeln('Ingrese el codigo entre 1 y 1000');readln(c.codigo);
writeln('Ingrese el email');readln(c.email);
writeln('Ingrese la cantidad de correos sin leer');readln(c.correos);
end;

procedure agregar(var a: arbol; c: cliente);
var aux : arbol;
begin
  if a = nil then
  begin
    new(aux);
    aux^.dato := c;
    aux^.HI := nil;
    aux^.HD := nil;
    a := aux;
  end
  else
  begin
    if (c.codigo <= a^.dato.codigo) then
      agregar(a^.HI, c)
    else
      agregar(a^.HD, c);
  end;
end;



procedure almacenarclientes(var a : arbol);
var
  c : cliente;
begin
  repeat
    leercliente(c);
    agregar(a,c);
  until (c.codigo = 1000);
end;

function cantidaddecorreossinleer(cod :rango; a : arbol): integer;
begin
  if a=nil then
    cantidaddecorreossinleer:=-1
    else
      begin
        if a^.dato.codigo = cod then 
          cantidaddecorreossinleer:=a^.dato.correos
        else if (a^.dato.codigo > cod) then
          cantidaddecorreossinleer:=cantidaddecorreossinleer(cod,a^.HI)
          else cantidaddecorreossinleer:=cantidaddecorreossinleer(cod,a^.HD);      
      end;
end;

function buscar(a: arbol; mail : string): boolean;
var
 existe : boolean;
begin
  if a=nil then
  buscar:=false
  else begin
  if a^.dato.email = mail then
    buscar:=true
    else begin
      existe:=buscar(a^.HI,mail);
      if (not existe) then
      existe := buscar(a^.HD,mail);
      buscar:=existe;
    end;
   end;
end;


procedure postorden(a : arbol);
begin
  if a<>nil then
    begin
      postorden(a^.HD);
      writeln('codigo : ',a^.dato.codigo);
      postorden(a^.HI);
    end;
end;

var
  a : arbol;
  cod : rango;
  mail : string;
begin
  a:=nil;
  almacenarclientes(a);
  writeln('Ingrese un codigo de cliente: ');readln(cod);
  writeln(cantidaddecorreossinleer(cod,a));
  postorden(a);
  writeln('Ingrese un email: ');readln(mail);
  if buscar(a,mail) then writeln('existe') else writeln('no existe');

end.

        
      



