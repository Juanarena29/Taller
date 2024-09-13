function funcion(a : arbol ; dni1,dni2 : integer): integer;
begin
  if a=nil then
    funcion := 0 // caso base
    else 
      if a^.dato.dni > dni1 then //mayor que valor 1
        if a^.dato.dni < dni2 then // menor que valor 2 - cumple condicion y sumo
          funcion := a^.dato.cant + funcion(a^.hi,dni1,dni2) + funcion(a^hd,dni1,dni2)
        else
          funcion:=funcion(a^.hi,dni1,dni2) //mayor que 1 y mayor que 2, muevo izq
      else funcion:=funcion(a^.hd,dni1,dni2); //menor que 1, muevo derecha
end;
