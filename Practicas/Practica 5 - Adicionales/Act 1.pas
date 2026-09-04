program act1;
{
El administrador de un edificio de oficinas tiene la información del pago de expensas.
Implementar un programa con:
a) Un módulo que retorne un vector, sin orden, con a lo sumo las 300 oficinas. Se deben
cargar, para cada oficina, el código de identificación, DNI del propietario y valor de la
expensa. La lectura finaliza cuando llega el código de identificación 0.
b) Un módulo que reciba el vector retornado en inciso a) y retorne dicho vector ordenado
por código de identificación de la oficina.
c) Un módulo que realice una búsqueda dicotómica. Este módulo debe recibir el vector
generado en el inciso b) y un código de identificación de oficina. En caso de
encontrarlo, debe retornar la posición del vector donde se encuentra y en caso
contrario debe retornar 0. Luego el programa debe informar el DNI del propietario o un
cartel indicando que no se encontró la oficina.
d) Un módulo recursivo que retorne el monto total acumulado de las expensas
}
type 
	oficina = record
		cod : integer;
		dni: integer;
		valor: real;
	end;
	vector = array [1..300] of oficina;
//A
procedure crear(var v:vector; var dimL:integer);
	procedure generarOficina(var o : oficina);
	begin
		o.cod:= random(10) - 1;
		o.dni:= random(1000) + 1;
		o.valor := random(30000) + 200;
	end;
var o:oficina;
begin
	generarOficina(o);
	dimL:=0;
	while((dimL < 300) and (o.cod<>-1)) do
	begin
		dimL:=dimL+1;
		v[dimL] := o;
		generarOficina(o);
	end;
end;
//B 
procedure sort(var v:vector; dimL:integer);
var 
	i, j, min:integer;
	aux: oficina;
begin
	for i:= 1 to dimL-1 do 
	begin
		min:=i;
		for j := (i+1) to dimL do
			if(v[j].cod < v[min].cod) then min:=j;
		aux:= v[i];
		v[i]:=v[min];
		v[min]:=aux;
	end;
end;
//C
function busqueda(v: vector; dimL, cod:integer): integer;
var
	ok: boolean;
	ini, fin, pos: integer;
begin
	ini:= 1;
	fin:=dimL;
	ok:=false;
	while((ini <= fin) and (not ok)) do
	begin
		pos := (fin + ini) DIV 2;
		if(v[pos].cod < cod) then
			ini:= pos + 1
		else if(v[pos].cod > cod) then
			fin:= pos - 1
		else 
			ok:=true;
	end;
	if(ok) then
		busqueda:=pos
	else 
		busqueda := 0;
end;
//Bonus
procedure imprimir(v:vector; dimL:integer);
	var i:integer;
begin
	writeln('Imprimir');
	for i:=1 to dimL do
		writeln(v[i].cod);
end;
var 
	v:vector;
	dimL, n, pos:integer;
begin
	crear(v, dimL);
	imprimir(v, dimL);
	sort(v, dimL);
	imprimir(v, dimL);
	writeln('Ingrese cod de oficina');
	readln(n);
	pos:=(busqueda(v, diml, n));
	if(pos <>0) then writeln('Esta en la pos ', pos)
	else writeln('No esta'); 
end.
