Programa arboles;

Type
  arbol = ^nodo;

  nodo = record
   dato: integer;
   HI: arbol;
   HD: arbol;
  end;

Procedure agregar (var a:árbol; num:integer);
Begin
  if (a = nil) then
   begin
      new(A);
      a^.dato:= num; a^.HI:= nil; a^.HD:= nil;
   end
   else
    if (num <= A^.dato) then agregar(a^.HI,num)
    else agregar (a^.HD,num)   
End;

Var
 abb:arbol; x:integer;
Begin
 abb:=nil;
 read (x);
 while (x<>50)do
  begin
   AGREGAR(abb,x);
   read(x);
  end;
End.
