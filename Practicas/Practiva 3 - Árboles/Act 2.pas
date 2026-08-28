program act2;
{
	Escribir un programa que:
	a. Implemente un módulo que genere aleatoriamente información de ventas de un comercio.
	Para cada venta generar código de producto (entre 1 y 100), fecha (dia, mes, año) y cantidad de
	unidades vendidas. Finalizar con el código de producto 0. Un producto puede estar en más de
	una venta. Se pide:
	i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de
	producto. Los códigos repetidos van a la derecha.
	ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
	código de producto. Cada nodo del árbol debe contener el código de producto y la
	cantidad total de unidades vendidas.
	iii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
	código de producto. Cada nodo del árbol debe contener el código de producto y la lista de
	las ventas realizadas del producto. Nota: No repetir información!!!
	Nota: El módulo debe retornar TRES árboles.
	b. Implemente un módulo que reciba el árbol generado en i. y una fecha (día, mes y año) y
	retorne la cantidad total de productos vendidos en la fecha recibida.
	c. Implemente un módulo que reciba el árbol generado en ii. y retorne el código de producto
	con mayor cantidad total de unidades vendidas.
	c. Implemente un módulo que reciba el árbol generado en iii. y retorne el código de producto
	con mayor cantidad de ventas
}
type 
	codProd = 0..100;
	date = record
		dia: 1..31;
		mes: 1..12;
		anio: 1900..2026;
	end;
	venta = record
		cod : codProd;
		fecha : date;
		cant : integer;
	end;
	arbolVentas=^nodoVentas;
	nodoVentas = record
		HI: arbolVentas;
		HD: arbolVentas;
		dato: venta;
	end;
	infoProducto = record
		cod : codProd;
		cantTotal : integer;
	end;
	arbolProductos=^nodoProductos;
	nodoProductos = record
		HI: arbolProductos;
		HD: arbolProductos;
		dato: infoProducto;
	end;
	lista = ^nodoLista;
	nodoLista = record
		sig: lista;
		dato: venta;
	end;
	datoConLista = record
		l : lista;
		cod : codProd;
	end;
	arbolListas=^nodoListas;
	nodoListas = record
		HI: arbolListas;
		HD: arbolListas;
		dato: datoConLista;
	end;
procedure generarArboles(var aV: arbolVentas; var aP: arbolProductos; var aL:arbolListas);
	procedure generarVenta(var v: venta);
		begin
			v.cod:= random(101);
			if(v.cod <>0) then
			begin
				v.fecha.dia := random(31) + 1;
				v.fecha.mes := random(12) +1;
				v.fecha.anio := random(126) + 1900;
				v.cant:= random(100) + 1;
			end;
		end;
	procedure insertarVenta(var a:arbolVentas; v:venta);
	var nuevo: arbolVentas;
	begin
		if(a<>nil) then
		begin
			if(a^.dato.cod <= v.cod) then
				insertarVenta(a^.HD, v)
			else
				insertarVenta(a^.HI, v);
		end
		else
		begin
			new(nuevo);
			nuevo^.HI:=nil;
			nuevo^.HD:=nil;
			nuevo^.dato:=v;
			a:=nuevo;
		end;
	end;
	procedure agregarOSumar(var a: arbolProductos; dato: infoProducto);
	var
		nuevo : arbolProductos;
	begin
		if(a <> nil) then
		begin
			if(a^.dato.cod > dato.cod)then
				agregarOSumar(a^.HI, dato)
			else 
			begin
				if(a^.dato.cod < dato.cod) then
					agregarOSumar(a^.HD, dato)
				else 
				begin
					a^.dato.cantTotal:= dato.cantTotal + a^.dato.cantTotal;
				end;
			end;
		end
		else
		begin
			new(nuevo);
			nuevo^.HI:=nil;
			nuevo^.HD:=nil;
			nuevo^.dato := dato;
			a:=nuevo;
		end;
	end;
	procedure agregarAdelante(var l:lista; v: venta);
	var nue:lista;
	begin
		new(nue);
		nue^.sig:=l;
		nue^.dato:=v;
		l:=nue;
	end;
	procedure agregarArbolTres(var a:arbolListas; v:venta);
	var nuevo : arbolListas;
	begin
		if(a<>nil)then
		begin
			if(a^.dato.cod > v.cod)then
			begin
				agregarArbolTres(a^.HI, v);
			end
			else
			begin
				if(a^.dato.cod < v.cod) then
				begin
					agregarArbolTres(a^.HD, v);
				end
				else
				begin
					agregarAdelante(a^.dato.l, v);
				end;
			end;
		end
		else
		begin
			new(nuevo);
			nuevo^.dato.cod := v.cod;
			nuevo^.dato.l:=nil;
			agregarAdelante(nuevo^.dato.l, v);
			nuevo^.HI:= nil;
			nuevo^.HD:=nil;
			a:=nuevo;
		end
	end;

var
	v:venta;
	info: infoProducto;
begin
	generarVenta(v);
	while(v.cod<>0) do
	begin
		info.cantTotal:= v.cant;
		info.cod:=v.cod;
		insertarVenta(aV, v);
		agregarOSumar(aP, info);
		agregarArbolTres(aL, v);
		generarVenta(v);
	end;
end;
procedure leerFecha(var f:date);
begin
	writeln('Dia: ');
	readln(f.dia);
	writeln('Mes: ');
	readln(f.mes);
	writeln('Año: ');
	readln(f.anio);
end;
function equalsFecha(f1, f2: date): boolean;
	begin
		equalsFecha:= (f1.dia = f2.dia) and (f1.mes = f2.mes) and (f1.anio = f2.anio);
	end;
procedure getCantByFecha(aV: arbolVentas; f:date; var total: integer);
begin
	if(aV<>nil)then
	begin
		getCantByFecha(aV^.HI, f, total);
		getCantByFecha(aV^.HD, f, total);
		if(equalsFecha(aV^.dato.fecha, f)) then
			total:= total + aV^.dato.cant;
	end;
end;
procedure imprimirArbol1(a: arbolVentas);
begin
	if(a<>nil) then
	begin
		imprimirArbol1(a^.HI);
		write(a^.dato.cod, '|', a^.dato.fecha.dia, '/',a^.dato.fecha.mes, '/', a^.dato.fecha.anio, '|', a^.dato.cant);
		writeln;
		imprimirArbol1(a^.HD);
	end;
end;
procedure imprimirArbol2(a: arbolProductos);
begin
	if(a<>nil) then
	begin
		imprimirArbol2(a^.HI);
		write(a^.dato.cod, '|', a^.dato.cantTotal);
		writeln;
		imprimirArbol2(a^.HD);
	end;
end;
procedure imprimirArbol3(a: arbolListas);
	procedure imprimirLista(l:lista);
	begin
		write('Lista: ');
		while(l<>nil)do begin
			write('Item: ',l^.dato.cod, '| cant', l^.dato.cant, '| ');
			l:=l^.sig;
		end;
	end;
begin
	if(a<>nil) then
	begin
		imprimirArbol3(a^.HI);
		imprimirLista(a^.dato.l);
		writeln;
		imprimirArbol3(a^.HD);
	end;
end;
procedure getMaxArbolDos(a: arbolProductos; var codMax : codProd;var max: integer);
begin
	if(a<>nil)then
	begin
		getMaxArbolDos(a^.HI, codMax, max);
		getMaxArbolDos(a^.HD, codMax, max);
		if(max < a^.dato.cantTotal) then
		begin
			max:= a^.dato.cantTotal;
			codMax:= a^.dato.cod;
		end;
	end;
end;
function getCantDeLista(l: lista): integer;
var cont: integer;
begin
	cont:=0;
	while(l<>nil) do
	begin
		cont:=cont+1;
		l:=l^.sig
	end;
	getCantDeLista:=cont;
end;
procedure getMaxArbolTres(a: arbolListas; var codMax : codProd; var max: integer);
var cant : integer;
begin
	if(a<>nil)then
	begin
		getMaxArbolTres(a^.HI, codMax, max);
		getMaxArbolTres(a^.HD, codMax, max);
		cant:= getCantDeLista(a^.dato.l);
		if(max < cant) then
		begin
			max:= cant;
			codMax:= a^.dato.cod;
		end;
	end;
end;
var
	aV: arbolVentas;
	aP: arbolProductos;
	aL: arbolListas;
	f: date;
	cantEnFecha: integer;
	codMaxP, codMaxL: codProd;
	maxP, maxL: integer;
begin
	aV:=nil;
	aP:=nil;
	aL:=nil;
	generarArboles(aV, aP, aL);
	writeln('Arbol ventas: ');
	imprimirArbol1(aV);
	writeln('------------------------------------------------------------');
	writeln('Arbol Productos: ');
	imprimirArbol2(aP);
	writeln('------------------------------------------------------------');
	writeln('Arbol Listas: ');
	imprimirArbol3(aL);
	writeln('------------------------------------------------------------');
	leerFecha(f);
	getCantByFecha(aV, f, cantEnFecha);
	writeln('Cantidad de productos vendidos en esa fecha: ', cantEnFecha);
	maxP:= -1;
	getMaxArbolDos(aP, codMaxP, maxP);
	if(maxP > -1) then writeln('Cod del producto mas vendido:', codMaxP);
	getMaxArbolTres(aL, codMaxL, maxL);
	if(maxL > -1) then writeln('Cod de la lista con mas ventas:', codMaxL);
end.
