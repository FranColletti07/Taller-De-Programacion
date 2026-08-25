program ArbolGeneral;
type 
	arbol = ^nodo;
	nodo = record
		HI : arbol;
		HD : arbol;
		val : integer;
	end;
{
* Nodo inicial = raiz
* Nodo en el medio = nodo
* Nodo sin hijos = Hojas
* Estructura dinámica, homogénea, no lineal
* Maximo dos hojas 
* Para procesar es cuestión de copiar el modulo de imprimir y modificar el writeln por el procesamiento deseado
* Ejemplo: contarElementos
* }
procedure insertarEnArbol(var a:arbol; n:integer);
var nuevo : arbol;
begin
	writeln('Valor a insertar: ', n);
	if(a <> nil)then
	begin
		if(a^.val > n)then
		begin
			writeln(n, ' se va a la izq');
			insertarEnArbol(a^.HI, n);
		end
		else 
		begin
			writeln(n, ' se va a la derecha');
			insertarEnArbol(a^.HD, n);
		end;
	end
	else
	begin
		new(nuevo);
		nuevo^.HI:=nil;
		nuevo^.HD:=nil;
		nuevo^.val:=n;
		writeln(n, ' llego a destino');
		a:=nuevo;
	end;
end;
procedure imprimirArbol(a:arbol);
begin
	if(a<>nil)then
	begin
		imprimirArbol(a^.HI);
		writeln(a^.val);
		imprimirArbol(a^.HD);
	end;
end;
procedure contarElementos(a:arbol;var cont:integer);
begin
	if(a<>nil)then
	begin
		contarElementos(a^.HI, cont);
		cont:=cont+1;
		contarElementos(a^.HD, cont);
	end;
end;
var
	a:arbol;
	cantidad:integer;
begin
	a:=nil;
	insertarEnArbol(a, 4);
	insertarEnArbol(a, 5);
	insertarEnArbol(a,3);
	insertarEnArbol(a,9);
	insertarEnArbol(a, 10);
	writeln('-------------------------');
	imprimirArbol(a);
	cantidad:=0;
	contarElementos(a, cantidad);
	writeln('cant', cantidad);
end.
