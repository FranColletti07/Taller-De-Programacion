program ACT4;
{4.- Implementar un programa que invoque a los siguientes módulos.
a. Un módulo recursivo que retorne un vector de 30 números enteros “random” mayores a 300
y menores a 550 (incluidos ambos).
b. Un módulo que reciba el vector generado en a) y lo retorne ordenado. (Utilizar lo realizado
en la práctica anterior)
c. Un módulo que realice una búsqueda dicotómica en el vector, utilizando el siguiente
encabezado:
Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice);
Nota: El parámetro “pos” debe retornar la posición del dato o el valor -1 si el dato no se
encuentra en el vector.
}
const dimF = 10;
type
	indice = 1..dimF;
	numero = 300..550;
	vector = array [indice] of numero;
procedure crearVector(var v: vector);
var i:indice;
begin
	for i:=1 to dimF do
		v[i]:= 300 + random(250);
end;
procedure sort(var v: vector);
var 
	aux :numero;
	i, j, pos :indice;
begin
	for i:=1 to dimF-1 do
	begin
		pos:=i;
		for j:=i+1 to dimF do
			if(v[pos]>v[j]) then pos:=j;
		aux:=v[pos];
		v[pos]:=v[i];
		v[i]:=aux;
	end;
end;
procedure imprimirVector(v: vector);
var i:integer;
begin
	write('Vector: | ');
	for i:=1 to dimF do write(v[i], ' | ');
	writeln;
end;
procedure busquedaDicotomica (v: vector; ini, fin: indice; dato:integer; var pos: integer);
var 
	ok:boolean;
begin
	ok:=false;
	while((not ok) and (fin>=ini)) do
	begin
		pos:= (fin + ini) DIV 2;
		if(dato = v[pos]) then
			ok:=true
		else 
		begin
			if(dato < v[pos]) then
				begin
					fin:= pos - 1;
				end
			else
				ini:= pos + 1;
		end;
	end; 
	if(not(ok)) then pos:=-1;
end;
//PP
var 
	v : vector;
	pos:integer;
	n : numero;
begin
	randomize;
	crearVector(v);
	imprimirVector(v);
	sort(v);
	imprimirVector(v);
	writeln;
	readln(n);
	busquedaDicotomica(v, 1, dimF, n, pos);
	writeln('El valor ', n, ' se encuentra en la posicion ', pos);
end.
