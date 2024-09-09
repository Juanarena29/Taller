Program Parcial;

Const
  dimf = 12;

Type
  consulta = record
    matricula : integer;
    dni : integer;
    mes : integer;
    diagnos : char;
  end;
  
  regarbol = record
    dni : integer;
    diagnos : char;
  end;

  arbol = ^nodoarbol;
  
  nodoarbol = record
    dato : regarbol;
    hi   : arbol;
    hd   : arbol;
  end;

  vector = array[1..dimf] of arbol;
  
Procedure moduloA(var v: vector);

  Procedure leerconsulta(var c: consulta);
  Var 
    v : array[1..5] of char = ('L', 'M', 'N', 'O', 'P');
  Begin
    c.matricula := random(100);
    if c.matricula <> 0 then begin
      c.dni := random(40) + 1;
      c.mes := random(12) + 1;
      c.diagnos := v[random(5) + 1];
    end;
  End;
  
  Procedure iniciarvector(var v: vector; diml: integer);
  Begin
    if diml <= dimf then begin
      v[diml] := nil;
      iniciarvector(v, diml + 1);
    end;
  End;

  Procedure insertararbol(var a: arbol; r: regarbol);
  Begin
    if a = nil then begin
      new(a);
      a^.dato := r;
      a^.hi := nil;
      a^.hd := nil;
    end
    else if r.dni < a^.dato.dni then 
      insertararbol(a^.hi, r)
    else 
      insertararbol(a^.hd, r);
  End;

Var
  c : consulta;
  r : regarbol;
Begin
  iniciarvector(v, 1);
  leerconsulta(c);
  while c.matricula <> 0 do begin
    r.dni := c.dni;
    r.diagnos := c.diagnos;
    insertararbol(v[c.mes], r);
    leerconsulta(c);
  end;
End;

Function contararbol(a: arbol): integer;
Begin
  if a = nil then 
    contararbol := 0
  else 
    contararbol := 1 + contararbol(a^.hi) + contararbol(a^.hd);
End;

Procedure moduloB(v: vector; var mesmax, maxcant: integer; diml: integer);
Begin
  if diml <= dimf then begin
    if contararbol(v[diml]) > maxcant then begin
      mesmax := diml;
      maxcant := contararbol(v[diml]);
    end;
    moduloB(v, mesmax, maxcant, diml + 1);
  end;
End;

Function moduloC(v: vector; dni: integer): boolean;

  Function recorrerarbol(a: arbol; dni: integer): boolean;
  Begin
    if a = nil then 
      recorrerarbol := false
    else if a^.dato.dni = dni then 
      recorrerarbol := true
    else if dni < a^.dato.dni then 
      recorrerarbol := recorrerarbol(a^.hi, dni)
    else 
      recorrerarbol := recorrerarbol(a^.hd, dni);
  End;

Var
  esta: boolean;
  i: integer;
Begin
  i := 1;
  esta := false;
  while (i <= dimf) and (esta = false) do begin
    esta := recorrerarbol(v[i], dni);
    i := i + 1;
  end;
  moduloC := esta;
End;

Procedure imprimirvector(v: vector);
Var
  i: integer;
Begin
  for i := 1 to 12 do begin
    writeln('-----------');
    writeln('El mes ', i, ' tuvo ', contararbol(v[i]), ' consultas');
  end;
End;

Var
  v: vector;
  mesmax, maxcant: integer;
  dnix: integer;
Begin
  randomize;
  moduloA(v);
  writeln('El vector se ha generado correctamente');
  writeln;
  imprimirvector(v);
  writeln;
  maxcant := -1;
  moduloB(v, mesmax, maxcant, 1);
  writeln('El mes que más consultas tuvo fue el mes ', mesmax);
  writeln;
  writeln('Escriba el DNI que desea consultar: '); readln(dnix);
  writeln;
  if moduloC(v, dnix) then
    writeln('El paciente con DNI ', dnix, ' ha sido atendido')
  else
    writeln('El paciente con DNI ', dnix, ' NO ha sido atendido');
End.


