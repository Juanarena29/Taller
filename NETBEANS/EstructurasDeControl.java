if (condicion)
    acciones if condicion = true
else
    acciones if condicion=false
----------------------------------
Pre-condicional
  while (condicion)
  {acciones cuando condicion=true}
----------------------------------
Post-condicional
  do { acciones(es) 
  } while (condicion)
----------------------------------
  for (inicializacion;condicion;expresion)
    accion(es)
  inicializacion = valor inicial de la variable indice, se ejecuta al comienzo
  condicion = el for sigue iterando mientras condicion = true
  expresion = expresion que se ejecuta al finalizar cada iteracion del for (inc o dec el indice)
  "int i
  for (i=1; i<=10; i++);"
  o 
  "for (int i=1; i<=10;System.out.println(i++);
    System.out.println(i);"
----------------------------------
  VECTOR
  - DECLARACION: TipoElemento [] nombreVariable;
  - CREACION: nombreVariable = new TipoElemento[DIMF]
  - ACCESO A ELEMENTO: nombreVariable[posicion]
  ejemplo:
    int [] contador = new int[10] ;
    for (i=0;i<10;i++) contador[i]=i;
    ...
    System.out.println("La posicion 1 tiene " + contador[1]);
