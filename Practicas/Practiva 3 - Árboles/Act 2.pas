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
	arbolListas=^nodoListas;
	nodoListas = record
		HI: arbolListas;
		HD: arbolListas;
		listaVentas: lista;
		cod : codProd;
	end;
procedure generarArbolVentas(var a:arbolVentas);
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
			if(a^.dato.cod < v.cod) then
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
		end;
	end;
var v:venta;
begin
	generarVenta(v);
	while(v.cod<>0) do
	begin
		insertarVenta(a, v);
		generarVenta(v);
	end;
end;
procedure generarArbolProductos(var aP: arbolProductos; aV: arbolVentas);
	procedure obtenerTotalVentas(aV: arbolVentas; codP: codProd; var total: integer);
	begin
		if(aV<>nil)then
		begin
			if(aV^.dato.cod > codP) then
				obtenerTotalVentas(aV^.HI);
			//SEGUIR ACÁ-------------------------------------------------------------------------
			else
		end
		else
			total:=0;
	end;
var 
	codP: codProd;
	total: integer;
	info: infoProducto;
begin
	for codP := 1 to 100 do begin
		obtenerTotalVentas(aV, codP, total);
		if(total>0) then
		begin
			info.cod:=codP
			info.cantTotal:=total;
			insertarProducto(aP, info);
		end;
	end;
end;
var
	aV: arbolVentas;
	aP: arbolProductos;
	aL: arbolListas;
begin
	generarArbolVentas(aV);
	generarArbolProductos(aP, aV);
end.
