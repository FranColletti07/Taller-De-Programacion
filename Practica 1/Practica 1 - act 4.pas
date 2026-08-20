program act4;
{	Una librería requiere el procesamiento de la información de sus productos. De cada
	producto se conoce el código del producto, código de rubro (del 1 al 6) y precio.
	Implementar un programa que invoque a módulos para cada uno de los siguientes
	puntos:
	a. Lea los datos de los productos y los almacene ordenados por código de
	producto y agrupados por rubro, en una estructura de datos adecuada. El
	ingreso de los productos finaliza cuando se lee el precio -1.
	b. Una vez almacenados, muestre los códigos de los productos pertenecientes a
	cada rubro.
	c. Genere un vector (de a lo sumo 20 elementos) con los productos del rubro 3.
	Considerar que puede haber más o menos de 20 productos del rubro 3. Si la
	cantidad de productos del rubro 3 es mayor a 20, se debe almacenar los
	primeros 20 que están en la lista e ignore el resto.
	d. Ordenar, por precio, los elementos del vector generado en c) utilizando el
	método visto en la teoría.
	e. Muestre los precios del vector resultante del punto d).
	f. Calcule el promedio de los precios del vector resultante del punto d).
}
type
	rubro = 1..6;
	producto = record
		codP : integer;
		codR : rubro;
		precio : real;
	end;
	lista = ^nodo;
	nodo = record
		sig: lista;
		val: producto;
	end;
	vectorRubros = array [rubro] of lista;
	rubroTres = array [1..20] of producto;
procedure leerProducto(var p:producto);
begin
	readln(p.codP);
	readln(p.codR);
	readln(p.precio);
end;
{
//Para debugging
procedure generarProducto(var p:producto);
begin
	p.codP:=random(100)+1;
	p.codR:=random(6) + 1;
	p.precio:= random(100)-1;
end;
}
procedure insertarOrdenado(var l:lista; p:producto);
var act, ant, nuevo : lista;
begin
	new(nuevo);
	nuevo^.val := p;
	if(l=nil)then 
	begin
		nuevo^.sig:=l;
		l:=nuevo;
	end
	else
	begin
		act:=l;
		ant:=l;
		while((act<>nil) and(act^.val.codP < p.codP))do
		begin
			ant:=act;
			act:=act^.sig;
		end;
		nuevo^.sig:=act;
		if(act=l)then
			l:=nuevo
		else
			ant^.sig:=nuevo;
	end;
end;
procedure inicializarEstructura(var v:vectorRubros);
var i: integer;
begin
	for i:=1 to 6 do 
		v[i]:=nil;
end;
procedure crearEstructura(var v:vectorRubros);
var p:producto;
begin
	inicializarEstructura(v);
	leerProducto(p);
	//generarProducto(p); //Para debugging
	while(p.precio<>-1) do
	begin
		insertarOrdenado(v[p.codR], p);
		leerProducto(p);
		//generarProducto(p); //Para debugging
	end;
end;
procedure imprimirProducto(p:producto);
begin
	writeln('Codigo de prod: ', p.codP);
	writeln('Codigo de rubro: ', p.codR);
	writeln('Precio:          ', p.precio);
end;
procedure imprimirLista(l:lista);
begin
	while(l<>nil)do
	begin
		imprimirProducto(l^.val);
		l:=l^.sig;
	end;
end;
procedure imprimirEstructura(v:vectorRubros);
var i:integer;
begin
	writeln('Imprimiendo Vector');
	for i:=1 to 6 do
	begin
		writeln('Imprimiendo Lista numero', i);
		imprimirLista(v[i]);
	end;
end;
procedure crearRubroTres(var v:rubroTres; l:lista;var dimL:integer);
begin
	dimL:=0;
	while((l<>nil) and (dimL<20))do
	begin
		dimL:=dimL+1;
		v[dimL]:=l^.val;
		l:=l^.sig;
	end;
end;
procedure sortRTres(var v:rubroTres; dimL:integer);
var 
	pos, i, j:integer;
	aux:producto;
begin
	for i:=1 to dimL-1 do 
	begin
		pos:=i;
		for j:=i to dimL do
			if (v[pos].precio > v[j].precio) then pos:=j;
		aux:=v[pos];
		v[pos]:=v[i];
		v[i]:=aux;
	end;
end;
procedure imprimirRTres(v:rubroTres; dimL:integer);
var i:integer;
begin
	writeln('Precios de rubro tres: ');
	for i:=1 to dimL do
		writeln(v[i].precio);
end;
function calcularProm(v:rubroTres; dimL:integer):real;
var 
	i:integer;
	sum:real;
begin
	sum:=0;
	for i:=1 to dimL do
		sum:=v[i].precio+sum;
	if(dimL<>0)then
		calcularProm:=(sum/dimL)
	else
		begin
		calcularProm:=0;
		writeln('No habían productos y no se puede dividir por cero');
		end;
end;
var
	v:vectorRubros;
	vTres : rubroTres;
	dimL:integer;
begin
	randomize;
	crearEstructura(v);
	imprimirEstructura(v);
	crearRubroTres(vTres, v[3], dimL);
	sortRTres(vTres, dimL);
	imprimirRTres(vTres, dimL);
	writeln(calcularProm(vTres, dimL));
end.

