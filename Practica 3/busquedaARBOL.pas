Programa arboles;
Type
  arbol = ^nodo;
  nodo = record
          dato: integer;
          HI: arbol;
          HD: arbol;
         end;
{-----BUSCAR-----}
Procedure enOrden ( a : arbol );
begin
   if ( a <> nil ) then begin
    enOrden (a^.HI);
    write (a^.dato); //o cualquier otra acción
    enOrden (a^.HD);
   end;
end;

{-----PREORDEN-----}
{ Preorden (preOrden)
Orden de visita: Raíz → Hijo Izquierdo → Hijo Derecho
Descripción: En la búsqueda en preorden, primero se procesa el nodo raíz, luego se recorre el subárbol izquierdo en preorden, y finalmente se recorre el subárbol derecho en preorden.
Secuencia de ejecución: El valor del nodo actual (a^.dato) se procesa antes de explorar los subárboles.}
Procedure preOrden (a:arbol);
begin
   if ( a <> nil ) then 
     begin
      write (a^.dato);
      preOrden (a^.HI);
      preOrden (a^.HD);
   end;
end;

{-----POSTORDEN-----}
{Postorden (postOrden)
Orden de visita: Hijo Izquierdo → Hijo Derecho → Raíz
Descripción: En la búsqueda en postorden, primero se recorren los subárboles izquierdo y derecho (en ese orden) en postorden, y finalmente se procesa el nodo raíz.
Secuencia de ejecución: El valor del nodo actual (a^.dato) se procesa después de haber explorado ambos subárboles.}
Procedure postOrden (a:arbol);
begin
   if ( a <> nil ) then 
     begin
      postOrden (a^.HI);
      postOrden (a^.HD);
      write (a^.dato);
   end;
end;
{Preorden: Procesa primero el nodo y luego los subárboles. Es útil para clonar árboles o imprimir su estructura.
Postorden: Procesa primero los subárboles y luego el nodo. Es útil para eliminar árboles o calcular propiedades acumulativas desde las hojas hasta la raíz.
Ambos métodos son formas de recorridos en profundidad (DFS, Depth-First Search), pero la diferencia está en cuándo se visita la raíz en relación con sus hijos.}

{-----BUSQUEDAS-----}

 --{--DEVUELVE BOOLEAN--}--

 Programa arbolesEnteros;
Type
  arbol = ^nodo;
  nodo = record
          dato: integer;
          HI: arbol;
          HD: arbol;
         end;

Function buscar (a:arbol; x:integer): boolean; 

begin
  if (a = nil) then buscar:= false
  else (a^.dato = x) then buscar:= true

  else if (x > a^.dato) then buscar:= buscar(a^.HD, x)
  else buscar:= buscar(a^.HI, x)

end;

Var
 a:arbol;min:integer;ok:booleanx:integer
Begin
 cargarArbol(a);  read(x);
 if (a <> nil) then
   ok:= buscar(a,x);
   write (ok);
End.

--{--DEVUELVE EL NODO--}--

Programa arbolesEnteros;
Type
  arbol = ^nodo;
  nodo = record
          dato: integer;
          HI: arbol;
          HD: arbol;
         end;

function buscarNodo (a:arbol; x:integer): arbol; 

Begin
 if (a = nil) then buscarNodo:= nil
  else (a^.dato = x) then buscarNodo:= a

  else if (x > a^.dato) then 
                 buscarNodo:= buscarNodo(a^.HD, x)
  else buscarNodo:= buscarNodo(a^.HI, x);
End;


Var
 a:arbol; bus:arbol; x:integer;
Begin
 cargarArbol(a);  read(x);
 bus:= buscarNodo(a,x);
   if (bus <> nil) then   write (“encontro”);
End.


{PROGRAMA PRINCIPAL ENORDEN}
Var
 a:arbol;  num:integer;
Begin
  a:= nil; 
 read (num); 
  while (num <> 50) do
   begin
    agregar (a,num); 
    read (num);
   end;
  enOrden(a);
End.
