program Actividad2;
{
a. Implemente un módulo recursivo que genere y retorne una lista de números enteros
“random” en el rango 200-230. Finalizar con el número 200.
b. Un módulo recursivo que reciba la lista generada en a) e imprima los valores de la lista en el
mismo orden que están almacenados.
c. Implemente un módulo recursivo que reciba la lista generada en a) e imprima los valores de
la lista en orden inverso al que están almacenados.
d. Implemente un módulo recursivo que reciba la lista generada en a) y devuelva el mínimo
valor de la lista.
e. Implemente un módulo recursivo que reciba la lista generada en a) y un valor y devuelva
verdadero si dicho valor se encuentra en la lista o falso en caso contrario.
}
type
	lista=^nodo;
	numero = 200..230;
	nodo = record
		sig : lista;
		val : numero;
	end;
procedure generarLista(var l:lista);
	function generarNumero():numero;
	begin
		generarNumero := random(20) + 200;
	end;
	procedure agregar(var l:lista; n:numero);
	var 
		nuevo : lista;
	begin
		new(nuevo);
		nuevo^.val:=n;
		nuevo^.sig:=l;
		l:=nuevo;
	end;
var
	n:numero;
begin
	l:=nil;
	n:=generarNumero();
	while(n<>200) do
	begin
		agregar(l, n);
		n:=generarNumero();
	end;
end;
procedure imprimirLista(l:lista);
begin
	while(l<>nil) do
	begin
		write(l^.val, ' ');
		l:=l^.sig;
	end;
end;
procedure imprimirListaRecursiva(l:lista);
begin
	if(l<>nil)then
	begin
		write(l^.val, ' ');
		l:=l^.sig;
		imprimirListaRecursiva(l);
	end;
end;
procedure imprimirListaInversa(l:lista);
begin
	if(l<>nil)then
	begin
		l:=l^.sig;
		imprimirListaInversa(l);
		if(l<>nil) then write(l^.val, ' ');
	end;
end;
function minimo(l:lista): integer;
var min:integer;
begin
	if(l<>nil) then
	begin
		min:= minimo(l^.sig);
		if(min < l^.val) then minimo:= min
		else minimo:=l^.val;
	end
	else 
		minimo:= 999;
end;
function find(l:lista; n:numero; ok :boolean) : boolean;
begin
	if((l<>nil) and (not ok)) then
	begin
		ok:=l^.val = n;
		find:= ok or (find(l^.sig, n, ok));
	end
	else 
		find:=false;
end;
var
	l:lista;
	n:numero;
begin
	randomize;
	writeln('Generando lista...');
	generarLista(l);
	writeln('Imprimiendo lista recursivamente...');
	imprimirListaRecursiva(l);
	writeln;
	writeln('Imprimiendo lista sin recursión...');
	imprimirLista(l);
	writeln;
	writeln('Imprimiendo lista inversa...');
	imprimirListaInversa(l);
	if(l<>nil) then
		write(l^.val, ' ');
	writeln;
	writeln('Buscando minimo');
	writeln('Minimo: ', minimo(l));
	write('Ingrese el numero a buscar: ');
	readln(n);
	writeln;
	if(find(l, n, false)) then writeln('El numero ', n, ' estaba en la lista')
	else writeln('El numero ', n, ' no estaba en la lista');
end.
