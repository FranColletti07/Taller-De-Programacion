program act2;
{
	El administrador de un edificio de oficinas cuenta, en papel, con la información del
	pago de las expensas de dichas oficinas. Implementar un programa que invoque a
	módulos para cada uno de los siguientes puntos:
	a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De
	cada oficina se ingresa el código de identificación, DNI del propietario y valor
	de la expensa. La lectura finaliza cuando se ingresa el código de identificación
	-1, el cual no se procesa.
	b. Ordene el vector aplicando el método de selección, por código de
	identificación de la oficina.
}
type
	oficina = record
	cod : integer;
	dni : integer;
	valor : real;
	end;
	vector = array [1..300] of oficina;
procedure leerOficina(var o:oficina);
begin
	readln(o.cod);
	if(o.cod<>-1)then
	begin
		readln(o.dni);
		readln(o.valor);
	end;
end;
procedure generarVector(var v:vector; var dimL:integer);
var
	o:oficina;
begin
	dimL:=0;
	leerOficina(o);
	while((o.cod<>-1) and (dimL<300)) do
	begin
		dimL:=dimL+1;
		v[dimL]:=o;
		leerOficina(o);
	end;
end;

procedure sort(var v:vector; dimL :integer);
var 
	aux:oficina;
	pos, i, j:integer;
begin
	for i:=1 to (dimL-1) do
	begin
		pos:=i;
		for j:=i+1 to dimL do
			if(v[pos].cod > v[j].cod)then pos:=j;
		aux:=v[pos];
		v[pos]:=v[i];
		v[i]:=aux;
	end;
end;
procedure mostrarVector(v:vector; dimL:integer);
var i:integer;
begin
	writeln('Mostrar: ');
	for i:=1 to dimL do
		writeln('Cod:',v[i].cod);
end;
var 
	v : vector;
	dimL: integer;
begin 
	generarVector(v, dimL);
	mostrarVector(v, dimL);
	sort(v, dimL);
	mostrarVector(v, dimL);
end.
