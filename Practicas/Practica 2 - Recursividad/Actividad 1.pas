{1.- Implementar un programa que invoque a los siguientes m.dulos.
a. Un m.dulo recursivo que retorne un vector de a lo sumo 15 n.meros enteros .random. mayores a 130 y menores a 145 (incluidos ambos). 
* La carga finaliza con el valor 130.
b. Un m.dulo no recursivo que reciba el vector generado en a) e imprima el contenido del vector.
c. Un m.dulo recursivo que reciba el vector generado en a) e imprima el contenido del vector.
d. Un m.dulo recursivo que reciba el vector generado en a) y devuelva la suma de los valores contenidos en el vector.
e. Un m.dulo recursivo que reciba el vector generado en a) y devuelva el m.ximo valor del vector.
f. Un m.dulo recursivo que reciba el vector generado en a) y un valor y devuelva verdadero si dicho valor se encuentra en el vector o falso en caso contrario.
g. Un m.dulo que reciba el vector generado en a) e imprima, para cada n.mero contenido en el vector, sus d.gitos en el orden en que 
   aparecen en el n.mero. Debe implementarse un m.dulo recursivo que reciba el n.mero e imprima lo pedido.
   Ejemplo si se recibe el valor 134, se debe imprimir 1  3  4
}

Program Clase2MI;
const dimF = 15;
      min = 130;
      max = 145;
type vector = array [1..dimF] of integer;
     

procedure CargarVector (var v: vector; var dimL: integer);

  procedure CargarVectorRecursivo (var v: vector; var dimL: integer);
  var valor: integer;
  begin
    valor:= min + random (max - min + 1);
    if ((valor <> 130 ) and (dimL < dimF)) 
    then begin
          dimL:= dimL + 1;
          v[dimL]:= valor;
          CargarVectorRecursivo (v, dimL);
         end;
  end;
  
begin
  dimL:= 0;
  CargarVectorRecursivo (v, dimL);
end;
 
procedure ImprimirVector (v: vector; dimL: integer);
var
   i: integer;
begin
     for i:= 1 to dimL do
         write ('------');
     writeln;
     write (' ');
     for i:= 1 to dimL do begin
        write(v[i], ' | ');
     end;
     writeln;
     for i:= 1 to dimL do
         write ('------');
     writeln;
     writeln;
End;     

procedure ImprimirVectorRecursivo (v: vector; dimL: integer; pos : integer);
begin    
     if(pos <= dimL) then
     begin
		write('|', v[pos], '|');
		pos := pos + 1;
		ImprimirVectorRecursivo(v, dimL, pos);
     end;
end; 
    
function Sumar (v: vector; dimL: integer): integer; 

  function SumarRecursivo (v: vector; pos, dimL: integer): integer;

  Begin
    if (pos <= dimL)  
    then SumarRecursivo:= SumarRecursivo (v, pos + 1, dimL) + v[pos]  
    else SumarRecursivo:=0  
  End;
 
var pos: integer; 
begin
 pos:= 1;
 Sumar:= SumarRecursivo (v, pos, dimL);
end;   
function  ObtenerMaximoRecursivo (v: vector; dimL: integer; pos:integer): integer;
var max : integer;
begin 
	if(pos<dimL)then 
	begin
		pos:=pos+1;
		max:=obtenerMaximoRecursivo(v, dimL, pos);
		if(max<v[pos])then
			max:=v[pos];
		obtenerMaximoRecursivo:=max;
	end
	else 
	begin
		obtenerMaximoRecursivo:=0;
	end;
end;     
function  BuscarValor (v: vector; dimL, valor: integer): boolean;
	function buscarValorRecursivo(v:vector; dimL, valor, pos : integer):boolean;
	begin
		if(pos>dimL)then
		begin
			buscarValorRecursivo:=false;
		end
		else
			buscarValorRecursivo:= (v[pos] = valor) or buscarValorRecursivo(v, dimL, valor, pos+1);
		
	end;
begin
	BuscarValor := buscarValorRecursivo(v, dimL, valor, 1);
end; 

procedure ImprimirDigitos (v: vector; dimL: integer);
	procedure imprimirDigitosRecursivo(n:integer);
	begin
		if(n<>0)then
		begin
			imprimirDigitosRecursivo(n DIV 10);
			write(n MOD 10, ' ');
		end;
	end;
var i:integer;
begin    
	for i:=1 to dimL do
	begin
		write('Nro: ', v[i], '= ');
		imprimirDigitosRecursivo(v[i]);
		writeln;
	end;
end; 

var dimL, suma, maximo, valor: integer; 
    v: vector;
    encontre: boolean;

Begin 
  randomize;
  CargarVector (v, dimL);
  writeln;
  if (dimL = 0) then writeln ('--- Vector sin elementos ---')
                else begin
                       ImprimirVector (v, dimL);
                       ImprimirVectorRecursivo (v, dimL, 1);
                     end;
  writeln;
  writeln;                   
  suma:= Sumar(v, dimL);
  writeln;
  writeln;
  writeln('La suma de los valores del vector es ', suma); 
  writeln;
  writeln;
  maximo:= ObtenerMaximoRecursivo(v, dimL, 1);
  writeln;
  writeln;
  writeln('El maximo del vector es ', maximo); 
  writeln;
  writeln;
  
  write ('Ingrese un valor a buscar: ');
  read (valor);
  encontre:= BuscarValor(v, dimL, valor);
  writeln;
  writeln;
  if (encontre) then writeln('El ', valor, ' esta en el vector')
                else writeln('El ', valor, ' no esta en el vector');
                
  writeln;
  writeln;
  ImprimirDigitos (v, dimL);
end.
