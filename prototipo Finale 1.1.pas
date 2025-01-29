Program Bingo_Roraima;

USES
crt;

TYPE
Bingo= ARRAY [1..5,1..5,1..15] Of INTEGER;
Vector= ARRAY [1..90] Of INTEGER;
PCarton= ARRAY [1..15] Of STRING[80];
Logico= ARRAY [1..15] Of INTEGER;
Jugados= ARRAY [1..5] Of INTEGER;
Participa= ARRAY [1..5] Of STRING[80];
Datos= array [1..3,1..5] of string[50];

VAR
Registro : Text;//Reporte con las estadísticas de cada jugador
ANumero{Cantidad de numeros acertados por carton},Aleatorio{Numeros que van saliendo en cada turno},
Control{Bandera para mantener los numeros marcados},i,j,l,n,x{Filas},y{Columnas},z{Ciclo para hasta jugadores},Gano{Jugador ganador},
Ganar{Cantidad de ganadores} : BYTE;
Jugadores{Cantidad de cartones}: BYTE;
Ganador : BINGO; {Cartones que se van a generar}
Carton : BINGO; {Imágenes auxiliares de los cartones para determinar el ganador}
Cartones : VECTOR; {Vector auxiliar para que no se repitan los numeros en los cartones}
Numeros : VECTOR; {Números que salen en cada ronda}
Victoria : VECTOR; {Ganadores de la partida}
Player : PCarton; {Guarda los nombres de los cartones asignados}
ControlP,Codigo : LOGICO; {Permite que dos personas no escogan el mismo carton}
Nombre : PARTICIPA; {Guarda los nombres de los jugadores al elegir el carton}
Cant : JUGADOS; {Imagen de los cartones por cada jugador}
E4,DP,DS,LH,LV,CLL,XG,EDP,DDP,EDS,DDS,CG,CP:BYTE; {Banderas de las formas de ganar}
Menu : CHAR;{Usado para selecionar las opciones en el menú}
Participantes : DATOS;{datos de cada jugador}
Personas{Cantidad de jugadores} : Integer;
Porcentaje : REAL;{Porcentaje de los numeros no acertados en todos los cartones de una persona}
Acertado : LOGICO;{Guarda todos los numeros acertados del carton}
BotonMenu : BYTE;

{--------------------------------------------------------PROCEDIMIENTOS------------------------------------------------}
PROCEDURE CodigoUnico;
BEGIN
     Randomize;
     //INICIALIZACION
     For x:=1 to jugadores do
     Codigo[x]:=0;

     //CREACION DEL CODIGO
     For x:=1 to jugadores do
     BEGIN
       Codigo[x]:=Random(99999)+10000;
     END;
END;

PROCEDURE FormasDeGanar;
BEGIN
REPEAT
   ClrScr;
   TextColor(White);
   WriteLn('');
	WriteLn('            X 0 0 0 X                              X 0 0 0 0   ');
	WriteLn('            0 0 0 0 0                              0 X 0 0 0   ');
	WriteLn('            0 0 0 0 0                              0 0 X 0 0   ');
	WriteLn('            0 0 0 0 0                              0 0 0 X 0   ');
	WriteLn('            X 0 0 0 X                              0 0 0 0 X   ');
    If E4=0 then
       TextColor(LightRed)
     ELSE
       TextColor(Green);
	Write('       (1)Cuatro Esquinas      ');
     If DP=0 then
       TextColor(LightRed)
     ELSE
       TextColor(Green);
	WriteLn('             (2)Diagonal Principal');
   TextColor(White);
   WriteLn('');
   WriteLn('            0 0 0 0 X                              0 0 0 0 0   ');
	WriteLn('            0 0 0 X 0                              0 0 0 0 0   ');
	WriteLn('            0 0 X 0 0                              X X X X X   ');
	WriteLn('            0 X 0 0 0                              0 0 0 0 0   ');
	WriteLn('            X 0 0 0 0                              0 0 0 0 0   ');
     If DS=0 then
       TextColor(LightRed)
     ELSE
       TextColor(Green);
	 Write('      (3)Diagonal Secundaria  ');
     If LH=0 then
       TextColor(LightRed)
     ELSE
       TextColor(Green);
	WriteLn('               (4)Linea Horizontal ');
   TextColor(White);
   WriteLn('');
	WriteLn('            X 0 0 0 0                              X X X X X   ');
	WriteLn('            X 0 0 0 0                              X X X X X   ');
	WriteLn('            X 0 0 0 0                              X X X X X   ');
	WriteLn('            X 0 0 0 0                              X X X X X   ');
	WriteLn('            X 0 0 0 0                              X X X X X   ');
     If LV=0 then
       TextColor(LightRed)
     ELSE
       TextColor(Green);
	  Write('       (5)Linea Vertical ');
     If CLL=0 then
       TextColor(LightRed)
     ELSE
       TextColor(Green);
	WriteLn('                       (6)Carton Lleno');
   TextColor(White);
   WriteLn('');
	WriteLn('            X 0 0 0 X                              0 X X X X   ');
	WriteLn('            0 X 0 X 0                              0 0 X X X   ');
	WriteLn('            0 0 X 0 0                              0 0 0 X X   ');
	WriteLn('            0 X 0 X 0                              0 0 0 0 X   ');
	WriteLn('            X 0 0 0 X                              0 0 0 0 0   ');
     If XG=0 then
       TextColor(LightRed)
     ELSE
       TextColor(Green);
	  Write('      (7)equis "X" Grande   ');
     If EDP=0 then
       TextColor(LightRed)
     ELSE
       TextColor(Green);
	WriteLn('         (8)encima de la diagonal principal ');
   TextColor(White);
   WriteLn('');
   WriteLn('            0 0 0 0 0                              X X X X 0   ');
	WriteLn('            X 0 0 0 0                              X X X 0 0   ');
	WriteLn('            X X 0 0 0                              X X 0 0 0   ');
	WriteLn('            X X X 0 0                              X 0 0 0 0   ');
	WriteLn('            X X X X 0                              0 0 0 0 0   ');
     If DDP=0 then
       TextColor(LightRed)
     ELSE
       TextColor(Green);
	  Write('(9)Debajo de la diagonal principal');
     If EDS=0 then
       TextColor(LightRed)
     ELSE
       TextColor(Green);
	WriteLn('   (10)Encima de la diagonal secundaria');
   TextColor(White);
   WriteLn('');
	WriteLn('            0 0 0 0 0                              0 0 X 0 0   ');
	WriteLn('            0 0 0 0 X                              0 0 X 0 0   ');
	WriteLn('            0 0 0 X X                              X X X X X   ');
	WriteLn('            0 0 X X X                              0 0 X 0 0   ');
	WriteLn('            0 X X X X                              0 0 X 0 0   ');
     If DDS=0 then
       TextColor(LightRed)
     ELSE
       TextColor(Green);
	  Write('(11)Debajo de la diagonal secundaria ');
     If CG=0 then
       TextColor(LightRed)
     ELSE
       TextColor(Green);
	WriteLn('           (12)Cruz Grande');
   TextColor(White);
   WriteLn('');
	WriteLn('            0 0 0 0 0');
	WriteLn('            0 0 X 0 0');
	WriteLn('            0 X X X 0');
	WriteLn('            0 0 X 0 0');
	WriteLn('            0 0 0 0 0');
     If CP=0 then
       TextColor(LightRed)
     ELSE
       TextColor(Green);
	WriteLn('        (13)Cruz pequena');
   TextColor(White);
   WriteLn();
   WriteLn();
   TextColor(Yellow);
   WriteLn('Las "X" representan la forma de rellenar el carton');
   WriteLn('Una forma de ganar esta seleccionada si esta es de color verde , sino estara de color rojo.');
   WriteLn();
   TextColor(White);
   WriteLn('Introduzca un numero para seleccionar una forma de ganar. ');
   WriteLn('Para iniciar el juego introduzca 0');
   Readln(z);
 CASE z of
 1 :If E4=0 then
       E4:=1
      ELSE
       E4:=0;
 2 :If DP=0 then
       DP:=1
      ELSE
       DP:=0;
 3 :If DS=0 then
       DS:=1
      ELSE
       DS:=0;
 4 :If LH=0 then
       LH:=1
      ELSE
       LH:=0;
 5 :If LV=0 then
       LV:=1
      ELSE
       LV:=0;
 6 :If CLL=0 then
       CLL:=1
      ELSE
       CLL:=0;
 7 :If XG=0 then
       XG:=1
      ELSE
       XG:=0;
 8 :If EDP=0 then
       EDP:=1
      ELSE
       EDP:=0;
 9 :If DDP=0 then
       DDP:=1
      ELSE
       DDP:=0;
 10:If EDS=0 then
       EDS:=1
      ELSE
       EDS:=0;
 11:If DDS=0 then
       DDS:=1
      ELSE
       DDS:=0;
 12:If CG=0 then
       CG:=1
      ELSE
       CG:=0;
 13:If CP=0 then
       CP:=1
      ELSE
       CP:=0;
      END;
  UNTIL ((z=0) and ((E4=1) or (DP=1) or (DS=1) or (LH=1) or (LV=1) or (CLL=1) or (XG=1)
                      or (EDP=1) or (DDP=1) or (EDS=1) or (DDS=1) or (CG=1) or (CP=1)))
END;

//ELECCION DE CARTONES
PROCEDURE Eleccion (l,z,y,x,n:BYTE);
VAR
Carto:Integer; //CARTON A ELEGIR

BEGIN
  CodigoUnico;

  //INICIALIZACION
  For i:=1 to jugadores do
  Player[i]:='';


  For i:=1 to jugadores do
  ControlP[i]:=0;   //Vector logico para evitar que escogan 2 veces un carton


  For l:=1 to personas do
  BEGIN
    For z:=1 to jugadores do
    BEGIN

      If player[z]='' then
      BEGIN
        TextColor(White);
        Writeln('');
        Writeln('');
        Writeln(' Carton #',z,' Codigo: #',Codigo[z]);
        Writeln(' B   I   N   G   O');
        For y:=1 to 5 do
        BEGIN
          Writeln('');
          //SI EL NUMERO ES MENOR A 10 SE LE COLOCA UN 0 AL INICIO
          For x:=1 to 5 do
          If ((Carton[x,y,z]) div 10 >= 1) then
             Write('|',Carton[x,y,z],'|')
          ELSE
             Write('|0',Carton[x,y,z],'|');
          //FIN 0 AL INICIO
        END;//FIN Y
      END; //FIN PLAYER
    END; //FIN JUGADORES

    //ASIGNACION DE LOS CARTONES
    For n:=1 to Cant[l]do
    BEGIN
      If n=1 then
      BEGIN
        Writeln('');
        Writeln('');
        Write('Jugador ',Nombre[l],' introduzca el numero del primer carton que desea elegir: ');
        Readln(Carto);
        Repeat
          If (Carto<1) Or (Carto>Jugadores) then
          BEGIN
            TextColor(Yellow);
            WriteLn('Por favor ingrese un numero valido');
            ReadLn(Carto);
            TextColor(White);
          END;
        Until (Carto>=1) And (Carto<=Jugadores);
        If ControlP[carto]=1 then
          BEGIN
            Repeat
              TextColor(Yellow);
              WriteLn('Por favor seleccione un carton disponible.');
              ReadLn(Carto);
              TextColor(White);
            Until ControlP[carto]<>1
          END;
          PLayer[carto]:=Nombre[l];
          ControlP[carto]:=1
      END
      Else
        If n=2 Then
        BEGIN
          Writeln('');
          Write('Jugador ',Nombre[l],' introduzca el numero del segundo carton que desea elegir: ');
          Readln(Carto);
          Repeat
            If (Carto<1) Or (Carto>Jugadores) Then
            BEGIN
            TextColor(Yellow);
             WriteLn('Por favor ingrese un numero valido');
             ReadLn(Carto);
             TextColor(White)
           END;
          Until (Carto>=1) And (Carto<=Jugadores);
          If ControlP[carto]=1 then
          BEGIN
            Repeat
              TextColor(Yellow);
              WriteLn('Por favor seleccione un carton disponible.');
              ReadLn(Carto);
              TextColor(White)
            Until ControlP[carto]<>1
          END;
          PLayer[carto]:=Nombre[l];
          ControlP[carto]:=1
        END
        ELSE
          If n=3 Then
          BEGIN
            Writeln('');
            Write('Jugador ',Nombre[l],' introduzca el numero del tercer carton que desea elegir: ');
            Readln(Carto);
            Repeat
              If (Carto<1) Or (Carto>Jugadores) Then
              BEGIN
                TextColor(Yellow);
                WriteLn('Por favor ingrese un numero valido');
                ReadLn(Carto);
                TextColor(White);
              END;
            Until (Carto>=1) And (Carto<=Jugadores);
            If ControlP[carto]=1 then
            BEGIN
            Repeat
              TextColor(Yellow);
              WriteLn('Por favor seleccione un carton disponible.');
              ReadLn(Carto);
              TextColor(White);
            Until ControlP[carto]<>1
          END;
          PLayer[carto]:=Nombre[l];
          ControlP[carto]:=1
          END;
    END;//FINAL JUGADORES
    ClrScr;
  END;//FINAL PERSONAS
END;

{---------------------------------------------FORMAS DE GANAR--------------------------------------}
//DIAGONAL SECUNDARIA
PROCEDURE DiagonalS;
VAR
Bandera : BYTE;
BEGIN
  For z:=1 to Jugadores do
    BEGIN
    Bandera:=0;
    x:=6;
     For y:=1 to 5 do
      BEGIN
      x:=x-1;
      If Carton[x,y,z]=Aleatorio then
         Ganador[x,y,z]:=1;
      If Ganador[x,y,z]<>1 then
         Bandera:=1;
      END;

      If (Gano<>z) and(Bandera=0) then
       BEGIN
          Gano:=z;
          Ganar:=Ganar+1;
          Victoria[Ganar]:=Gano;
       END;
    END;//FIN JUGADORES
END;//FIN PROCEDIMIENTO

//CRUZ PEQUEÑA
PROCEDURE CruzPequena;
VAR
Bandera : BYTE;
BEGIN
  For z:=1 to Jugadores do
    BEGIN
    Bandera:=1;
     For y:=1 to 5 do
      BEGIN
       For x:=1 to 5 do
        BEGIN
         If Carton[x,y,z]=Aleatorio then
            Ganador[x,y,z]:=1;
         If ((x>1) and (x<5)) and ((y>1) and (y<5)) and (Gano<>z)  then
          BEGIN
            If  (Ganador[x,y,z]=1) and (Ganador[x+1,y,z]=1) and (Ganador[x-1,y,z]=1) and (Ganador[x,y+1,z]=1) and (Ganador[x,y-1,z]=1) then
                Bandera:=0;
          END;
         END;
      END;

     If (Bandera=0) and (Gano<>z) then
     BEGIN
       Gano:=z;
       Ganar:=Ganar+1;
       Victoria[Ganar]:=Gano;
     END;
    END;//FIN JUGADORES
END;//FIN PROCEDIMIENTO

//CUATRO ESQUINAS
PROCEDURE CuatroEsquinas;
VAR
Bandera : BYTE;
BEGIN
  For z:=1 to Jugadores do
    BEGIN
     Bandera:=0;
     For y:=1 to 5 do
      BEGIN
       For x:=1 to 5 do
        BEGIN
          If Carton[x,y,z]=Aleatorio then
             Ganador[x,y,z]:=1;
          If ((y=1) or (y=5))  and ((x=1) or (x=5))  and (Gano<>z)  then
         BEGIN
           If Ganador[x,y,z]<>1 then
              Bandera:=1;
          END;
        END;
      END;

      If (bandera=0) and (gano<>z) then
       BEGIN
          Gano:=z;
          Ganar:=Ganar+1;
          Victoria[Ganar]:=Gano;
       END;
    END;//FIN JUGADORES
END;//FIN PROCEDIMIENTO

//CRUZ GRANDE
PROCEDURE CruzGrande;
VAR
Bandera : BYTE;
BEGIN
  For z:=1 to jugadores do
  BEGIN
    Bandera:=0;
     For y:=1 to 5 do
      BEGIN
       For x:=1 to 5 do
        BEGIN
         If Carton[x,y,z]=Aleatorio then
            Ganador[x,y,z]:=1;
         If ((x=3 ) or (y=3)) and (gano<>z)  then
            if  Ganador[x,y,z]<>1 then
                Bandera:=1
        END;//Final x
      END;//Final y

     If (Bandera=0) And (Gano<>z) then
     BEGIN
       Gano:=z;
       Ganar:=Ganar+1;
       Victoria[Ganar]:=Gano;
     END;
  END;//FIN JUGADORES
END;//FIN PROCEDIMIENTO

//DEBAJO DE LA DIAGONAL SECUNDARIA
PROCEDURE DebajodeDS;
VAR
Bandera : BYTE;
BEGIN
  For z:=1 to Jugadores do
    BEGIN
    Bandera:=0;
     For y:=1 to 5 do
      BEGIN
       For x:=1 to 5 do
        BEGIN
         If Carton[x,y,z]=Aleatorio then
            Ganador[x,y,z]:=1;
         If (x+y>6) then
            If Ganador[x,y,z]<>1 then
               Bandera:=1;
         END;
        END;

      If (gano<>z) and (bandera=0) then
      BEGIN
        Gano:=z;
        Ganar:=Ganar+1;
        Victoria[Ganar]:=Gano;
      END;
    END;//FIN JUGADORES
END;//FIN PROCEDIMIENTO

//ENCIMA DE LA DIAGONAL PRINCIPAL
PROCEDURE EncimadeDP;
VAR
Bandera : BYTE;
BEGIN
  For z:=1 to Jugadores do
    BEGIN
    Bandera:=0;
     For y:=1 to 5 do
      BEGIN
       For x:=1 to 5 do
        BEGIN
         If Carton[x,y,z]=Aleatorio then
            Ganador[x,y,z]:=1;
         If y<x then
          BEGIN
           If (Ganador[x,y,z]<>1) then
               Bandera:=1;
          END;
        END;//Fin x
      END;//Fin y

      If (Bandera=0) And (Gano<>z) then
         BEGIN
           Gano:=z;
           Ganar:=ganar+1;
           Victoria[ganar]:=gano;
         END;
    END;//FIN JUGADORES
END;//FIN PROCEDIMIENTO

//DEBAJO DE LA DIAGONAL PRINCIPAL
PROCEDURE DebajodeDP;
Var
Bandera : BYTE;
BEGIN
  For z:=1 to Jugadores do
    BEGIN
    Bandera:=0;
     For y:=1 to 5 do
      BEGIN
       For x:=1 to 5 do
        BEGIN
         If Carton[x,y,z]=Aleatorio then
            Ganador[x,y,z]:=1;
         If (y>x) and (gano<>z)  then
         BEGIN
           If  Ganador[x,y,z]<>1 then
             Bandera:=1;
         END;
        END;
      END;

      If (Bandera=0) and (Gano<>z) then
         BEGIN
           Gano:=z;
           Ganar:=Ganar+1;
           Victoria[Ganar]:=Gano;
         END;
    END;//FIN JUGADORES
END;//FIN PROCEDIMIENTO

//ENCIMA DE LA DIAGONAL SECUNDARIA
PROCEDURE EncimadeDS  ;
VAR
Bandera : BYTE;
BEGIN
  For z:=1 to Jugadores do
    BEGIN
    Bandera:=0;
     For y:=1 to 5 do
      BEGIN
       For x:=1 to 5 do
        BEGIN
         If Carton[x,y,z]=Aleatorio then
            Ganador[x,y,z]:=1;
         If (x+y<6) then
            If Ganador[x,y,z]<>1 then
               Bandera:=1;
         END;
        END;

      If (Gano<>z) and (Bandera=0) then
      BEGIN
        Gano:=z;
        Ganar:=Ganar+1;
        Victoria[Ganar]:=Gano;
      END;
    END;//FIN JUGADORES
END;//FIN PROCEDIMIENTO

//LINEA HORIZONTAL
PROCEDURE LineaHorizontal;
VAR
Bandera : BYTE;
BEGIN
  For z:=1 to Jugadores do
    BEGIN
     For y:=1 to 5 do
      BEGIN
       Bandera:=0;
       For x:=1 to 5 do
        BEGIN
         If Carton[x,y,z]=Aleatorio then
            Ganador[x,y,z]:=1;
         If  (Ganador[x,y,z]<>1) then
           Bandera:=1;
         END;

        If (Bandera=0) and (Gano<>z) then
         BEGIN
           Gano:=z;
           Ganar:=Ganar+1;
           Victoria[Ganar]:=Gano;
         END;
      END;
    END;//FIN JUGADORES
END;//FIN PROCEDIMIENTO

//LINEA VERTICAL
PROCEDURE LineaVertical;
VAR
Bandera : BYTE;
BEGIN
  For z:=1 to Jugadores do
    BEGIN
     For x:=1 to 5 do
      BEGIN
        Bandera:=0;
       For y:=1 to 5 do
        BEGIN
         If Carton[x,y,z]=Aleatorio then
            Ganador[x,y,z]:=1;
         If  (Ganador[x,y,z]<>1) then
           Bandera:=1;
         END;

        If (Bandera=0) and (Gano<>z) then
         BEGIN
           Gano:=z;
           Ganar:=Ganar+1;
           Victoria[Ganar]:=Gano;
         END;
      END;
    END;//FIN JUGADORES
END;//FIN PROCEDIMIENTO

//CARTON LLENO
PROCEDURE CartonLLeno;
VAR
ct : BYTE;
BEGIN
  For z:=1 to Jugadores do
    BEGIN
    ct:=0;
     For y:=1 to 5 do
      BEGIN
       For x:=1 to 5 do
        BEGIN
         If Carton[x,y,z]=Aleatorio then
            Ganador[x,y,z]:=1;
         If (Gano<>z) and (Ganador[x,y,z]<>1) then
            ct:=1;   
         END;
      END;

     If (ct=0) And (Gano<>z)then
     BEGIN
       Gano:=z;
       Ganar:=Ganar+1;
       Victoria[Ganar]:=Gano;
     END;
    END;//FIN JUGADORES
END;//FIN PROCEDIMIENTO

//DIAGONAL PRINCIPAL
PROCEDURE DiagonalP;
VAR
Bandera : BYTE;
BEGIN

For z:=1 to Jugadores do
   BEGIN
   Bandera:=0;
    For y:=1 to 5 do
        BEGIN
          For x:=1 to 5 do
             BEGIN
               If Carton[x,y,z]=Aleatorio then
                  Ganador[x,y,z]:=1;

               If x=y then
               BEGIN
                 If Ganador[x,y,z]<>1 then
                 Bandera:=1;
               END;
             END;
        END;

   If (Bandera=0) and (Gano<>z)then
     BEGIN
       Gano:=z;
       Ganar:=Ganar+1;
       Victoria[Ganar]:=Gano;
     END;
   END;
END;

//EQUIS
PROCEDURE Equis;
VAR
cl,Bandera : BYTE;
BEGIN
For z:=1 to Jugadores do
   BEGIN
   cl:=0;
    For y:=1 to 5 do
        BEGIN
          For x:=1 to 5 do
             BEGIN
            If Carton[x,y,z]=Aleatorio then
               Ganador[x,y,z]:=1;
              If (x=y) and (gano<>z)  then
                 If ganador[x,y,z]<>1 then
                    cl:=1;
             END;
        END;
    Bandera:=0;
    x:=6;
     For y:=1 to 5 do
      BEGIN
      x:=x-1;
      If Carton[x,y,z]=Aleatorio then
         Ganador[x,y,z]:=1;
       If Ganador[x,y,z]<>1 then
           Bandera:=1;
      END;

      If (Bandera=0) and (cl=0) and (Gano<>z)  then
       BEGIN
          Gano:=z;
          Ganar:=Ganar+1;
          Victoria[Ganar]:=Gano;
       END;
    END;//FIN JUGADORES
END;//FIN PROCEDIMIENTO


PROCEDURE Encabezado;
BEGIN
     TextColor(Yellow);
     Gotoxy(35,2);
     WriteLn('|--------------------------------------------------|');
     Gotoxy(35,3);
     WriteLn('|Bienvenido al juego de bingo automatizado RORAIMA!|');
     Gotoxy(35,4);
     WriteLn('|--------------------------------------------------|');
     WriteLn('');
     TextColor(White);
END;

PROCEDURE Inicio;
BEGIN
//Parpadeo
     For i:=1 to 7 do
     BEGIN
       ClrScr;
       If i=7 then
         TextColor(White)
       Else
       TextColor(0+i);
       WriteLn('                                                |---------------|');
       WriteLn('                                                |-BINGO RORAIMA-|');
       WriteLn('                                                |---------------|');
       Delay(300);
     END;

     TextColor(White);
     WriteLn('');
     WriteLn('');
     WriteLn('                                              Seleccione una opcion');
     WriteLn('                                               |------------------|');
     WriteLn('                                               |-     Jugar      -|');
     WriteLn('                                               |-  Instrucciones -|');
     WriteLn('                                               |-    Creditos    -|');
     WriteLn('                                               |-     Salir      -|');
     WriteLn('                                               |------------------|');
END;

PROCEDURE CrearArchivo;
BEGIN
     Assign(Registro,'C:\Users\Carlos Parra\Documents\2do Semestre\AlgoritmosyProgramaciónI\Práctica\Proyecto\Archivos\reporte.txt');
     ReWrite(Registro);
     For j:=1 to Personas do
      BEGIN
       porcentaje:=0;
       WriteLn(Registro,'|-------------------------------------------------|');
       WriteLn(Registro,'|     REPORTE DE ESTADISTICAS DE LOS JUGADORES    |');
       WriteLn(Registro,'|-------------------------------------------------|');
       WriteLn(Registro,'');
       WriteLn(Registro,'');
       WriteLn(Registro,'//jugador ',j,'\\');
       WriteLn(Registro,'Nombre: ',Nombre[j]);
       WriteLn(Registro,'Cedula: ',Participantes[1,j]);
       WriteLn(Registro,'Direcccion: ',Participantes[2,j]);
       WriteLn(Registro,'Tlf: ',Participantes[3,1]);
       WriteLn(Registro,' Sus cartones son: ');
       For z:=1 to Jugadores do
       BEGIN
       ANumero:=0;
       Gano:=0;
        If  (Nombre[j]=Player[z]) then
          BEGIN
            WriteLn(Registro,'');
            WriteLn(Registro,'|-------------------------|');
            WriteLn(Registro,'|carton: ',z,' Codigo: #',Codigo[z]);
            For y:=1 to 5 do
            BEGIN
              WriteLn(Registro,'');
               For x:=1 to 5 do
               BEGIN
                 Control:=0;
                 For l:=1 to 90 do
                 BEGIN
                   If Numeros[l]=carton[x,y,z] then //Mantener el numero marcado.
                      Control:=1;
                 END;
              If ((carton[x,y,z]) div 10 >= 1) then
               Write(Registro,'|',Carton[x,y,z],'|')
              ELSE
              Write(Registro,'|0',Carton[x,y,z],'|');
              END;
         END;
         For i:=1 to ganar do
          BEGIN
           If (z=Victoria[i]) then
            Gano:=1;
          END;
          WriteLn(Registro,'');
          If Gano=1 then
            WriteLn(Registro,' **Carton Ganador!!!  ')
          ELSE
           WriteLn(Registro,' *Este carton no gano ');
           WriteLn(Registro,'');
      WriteLn(Registro,'**Los numeros acertados de este carton son: ');
      For x:=1 to 5 do
       BEGIN
        For y:=1 to 5 do
         BEGIN
          For i:=1 to 90 do
           BEGIN
             If Carton[x,y,z]=Numeros[i] then
              BEGIN
                Write(Registro,Carton[x,y,z],' ');
                ANumero:=ANumero+1;
             END;
          END;
         END;
       END;

       WriteLn(Registro,'');
       WriteLn(Registro,'**El porcentaje de aciertos del carton  es de ',((ANumero/25)*100):4:2,'%'); Porcentaje:=(100-((ANumero/25)*100))+Porcentaje;
       WriteLn(Registro,'');
       WriteLn(Registro,'**Los numeros no acertados por el carton fueron  ');
       If Acertado[z]=0 then
         Acertado[z]:=Round(((ANumero/25)*100));
      For x:=1 to 5 do
       BEGIN
        For y:=1 to 5 do
         BEGIN
             If Ganador[x,y,z]=0 then
                Write(Registro,Carton[x,y,z],' ');
         END;
       END;
      END;
     END;
      WriteLn(Registro,'');
      WriteLn(Registro,'**El porcentaje de numeros no acertados con respecto al total de numeros entre todos los cartones con que jugo:  ',porcentaje/cant[j]:4:2,'%');
    END;
      WriteLn(Registro,'');
      WriteLn(Registro,'**Diagrama de numeros acertados (cada <*> es 5%) ');
     For n:=1 to Jugadores do
      BEGIN
      WriteLn(Registro,'');
      Write(Registro,'Carton #',n,': ');
       For i:=1 to (Acertado[n] div 5) do
           Write(Registro,'*');
      END;
   Close(Registro);

END;

PROCEDURE Jugar;
//INICIO DE LAS MECÁNICAS DEL JUEGO
BEGIN
  ClrScr;
  TextColor(White);
  E4:=0;
  DP:=0;
  DS:=0;
  LH:=0;
  LV:=0;
  CLL:=0;
  XG:=0;
  EDP:=0;
  DDP:=0;
  EDS:=0;
  DDS:=0;
  CG:=0;
  CP:=0;
  z:=0;
  Jugadores:=0;
  Ganar:=0;
  Gano:=0;
  Encabezado;
  TextColor(White);
  //LECTURA DE DATOS DE ENTRADA
  REPEAT
    ClrScr;
    Encabezado;
    Write('Ingrese la cantidad de jugadores (Max 5): ');
    TextColor(Yellow);
    Readln(Personas);
  UNTIL (personas>0) and (personas<=5);
  For i:=1 to personas do
  BEGIN
    ClrScr;
    TextColor(White);
    Encabezado;
    Write('Ingrese nombre del participante ',i,': ');
    TextColor(Yellow);
    Readln(Nombre[i]);
    TextColor(White);
    WriteLn('');
    WriteLn('Ingrese la cedula de ',Nombre[i]);
    TextColor(Yellow);
    ReadLn(Participantes[1,i]);
    TextColor(White);
    WriteLn('Ingrese la direccion de ',Nombre[i]);
    TextColor(Yellow);
    ReadLn(Participantes[2,i]);
    TextColor(White);
    WriteLn('Ingrese telefono de ',Nombre[i]);
    TextColor(Yellow);
    ReadLn(Participantes[3,i]);
    TextColor(White);
    Repeat
      Writeln('Introduzca cuantos cartones quiere el jugador ',Nombre[i],' (Max 3): ');
      TextColor(Yellow);
      Readln(cant[i]);
    Until (Cant[i]>=1) And (Cant[i]<=3);
    z:=jugadores;
    jugadores:=jugadores+cant[i];

  END;
  TextColor(LightRed);
  WriteLn('');
  WriteLn('Espere mientras se generan sus cartones...');
  //FIN LECTURA
  Ganar:=0;
  //INICIALIZACION CARTONES
  For i:=1 to 90 do
    Cartones[i]:=0;

  //RELLENO DE LOS CARTONES
  For z:=1 to jugadores do
  BEGIN
    n:=0;
    For y:=1 to 5 do
    BEGIN
      for x:=1 to 5 do
      BEGIN
        //NO REPETIR NUMEROS EN EL CARTON
        REPEAT
          Control:=0;
          Randomize;
          Aleatorio:=random(90)+1;
          For j:=1 to 90 do
          BEGIN
            If cartones[j]=aleatorio then
            Control:=1
          END;
        UNTIL control=0;
          n:=n+1;
          Cartones[n]:=Aleatorio;
          Carton[x,y,z]:=Aleatorio;
          Ganador[x,y,z]:=0
      END;
      //FIN NO REPETIR NUMEROS DEL CARTON
    END;
  END;
  n:=0;
  l:=0;

  Eleccion(l,z,y,x,n);
  FormasDeGanar;


  //INICIALIZACION NUMEROS
  For i:=1 to 90 do
    Numeros[i]:=0;

  //INICIO DETERMINACION DEL GANADOR
  REPEAT
    ClrScr;
    //MOSTRAR LOS CARTONES JUGADORES
    For z:=1 to jugadores do
    BEGIN
      TextColor(Yellow);
      Writeln('');
      Writeln(' Carton #',z,' Codigo: #',codigo[z]);
      Writeln(' B   I   N   G   O');
      TextColor(White);
      For y:=1 to 5 do
      BEGIN
        For x:=1 to 5 do
        BEGIN
          Textcolor(White);
          Control:=0;
          For l:=1 to 90 do
          BEGIN
            If Numeros[l]=Carton[x,y,z] then
              Control:=1;
          END;
          If control=1 then
            TextColor (lightred);
          If ((carton[x,y,z]) div 10 >= 1) then
            Write('|',Carton[x,y,z],'|')
          Else
            Write('|0',Carton[x,y,z],'|');
        END;
        WriteLn('')
      END;
    END;
    //NO REPETIR LOS NUMEROS QUE SALEN
    REPEAT
      Control:=0;
      Aleatorio:=Random(90)+1;
      For j:=1 to 90 do
      BEGIN
        If Numeros[j]=aleatorio then
        Control:=1;
      END;
    UNTIL Control=0;
    //FIN NO REPETIR LOS NUMEROS QUE SALEN
    n:=n+1;
    Numeros[n]:=Aleatorio;
    TextColor(Yellow);
    WriteLn();
    WriteLn('-------------------------[',Aleatorio,']------------ es el numero del turno');
     //keypressed;
     ReadKey;
    //LLAMADO DE SUBPROGRAMAS
  if E4=1 then
      CuatroEsquinas;
  if DP=1 then
      DiagonalP;
  if DS=1 then
      DiagonalS;
  if LH=1 then
      LineaHorizontal;
  if LV=1 then
      Lineavertical;
  if CLL=1 then
      CartonLleno;
  if XG=1 then
      Equis;
  if EDP=1 then
      EncimadeDP;
  if DDP=1 then
      DebajodeDP;
  if EDS=1 then
      EncimadeDS;
  if DDS=1 then
      DebajodeDS;
  if CG=1 then
      CruzGrande;
  if CP=1 then
      CruzPequena;
    //FIN LLAMADO DE SUBPROGRAMAS

  UNTIL (Ganar>0);
  //FIN DETERMINACION DEL GANADOR
  WriteLn('');
  TextColor(Yellow);
  Writeln('ya hay un ganador(es)');
  ReadKey;
  ClrScr;
  For n:=0 to 7 do
  BEGIN
    ClrScr;
    For z:=1 to Ganar do
    BEGIN
      TextColor(Blue+n);
      Writeln();
      Writeln(' B   I   N   G   O    Jugador ganador!: ',player[victoria[z]]);
    For y:=1 to 5 do
    BEGIN
      Writeln();
      For x:=1 to 5 do
      BEGIN
        TextColor(white);
        Control:=0;
          For l:=1 to 90 do
          BEGIN
            If Numeros[l]=Carton[x,y,victoria[z]] then //Mantener el numero marcado.
               Control:=1;
          END;
            If Control=1 then
              TextColor (lightRed);
            If ((Carton[x,y,Victoria[z]]) div 10 >= 1) then
              Write('|',Carton[x,y,Victoria[z]],'|')
            Else
              Write('|0',Carton[x,y,Victoria[z]],'|');
      END;
    END;
     Delay(300);
  END;
  END;
  ReadKey;
  Writeln();
  TextColor(White);
  Writeln('Todos los numeros que salieron son: ');
  For n:=1 to 15 do
      acertado[n]:=0;

  For i:=1 to 90 do
    If Numeros[i]<>0 then
     begin
       Write(Numeros[i],'  ');
     end;

  CrearArchivo;

  WriteLn('');
  WriteLn('');
  TextColor(LightRed);
  WriteLn('Presione cualquier tecla para volver al menu principal.');
  ReadKey;
  ClrScr;
  Inicio;
END;


//PROGRAMA PRINCIPAL
BEGIN
   TextColor(White);
   Repeat
     BotonMenu:=0;
     Inicio;
     Menu:=ReadKey;

     Case Menu of
       '1':
           BEGIN
             Jugar;
           END;
       '2':
           BEGIN
             BotonMenu:=1;
             ClrScr;
             WriteLn('');
             TextColor(Yellow);
             WriteLn('      |--------------------------------------------------------------------------------------------------------|');
             WriteLn('      |                                          INSTRUCCIONES DE USO                                          |');
             WriteLn('      |--------------------------------------------------------------------------------------------------------|');
             TextColor(White);
             WriteLn('      |1. Pueden jugar hasta un maximo de 5 personas al mismo tiempo.                                          |');
             WriteLn('      |2. Cada jugador puede pedir un maximo de 3 cartones.                                                    |');
             WriteLn('      |3. Dos jugadores no pueden escoger el mismo carton, y escoge el jugadore que primero se registre.       |');
             WriteLn('      |4. Se debe escoger por lo menos una forma de ganar para poder jugar.                                    |');
             WriteLn('      |5. Se puede escoger la cantidad de formas de ganar que se quiera al mismo tiempo.                       |');
             WriteLn('      |6. Al finalizar el juego se puede revisar en la carpeta de instalacion el archivo con las estadisticas  |');
             WriteLn('      | de cada jugador.                                                                                       |');
             WriteLn('      |--------------------------------------------------------------------------------------------------------|');
             WriteLn('');
             TextColor(LightRed);
		       WriteLn('                                   Presione cualquier tecla para continuar.');
		       ReadKey;



           END;
       '3':
           BEGIN
             BotonMenu:=1;
             ClrScr;
             TextColor(White);
             WriteLn('');
             WriteLn('');
             WriteLn('                       |-----------------------------------------------------------|');
	      	 WriteLn('                       |              UNIVERSIDAD CATOLICA ANDRES BELLO            |');
			    WriteLn('                       |                   FACULTAD DE INGENIERIA                  |');
			    WriteLn('                       |              ESCUELA DE INGENIERIA INFORMATICA            |');
			    WriteLn('                       |                  ALGORITMOS Y PROGRAMACION I              |');
			    WriteLn('                       |                        PROYECTO FINAL                     |');
			    WriteLn('                       |           SEGUNDO SEMESTRE DE INGENIERIA INFORMATICA      |');
             WriteLn('                       |                                                           |');
			    WriteLn('                       |                                                           |');
			    WriteLn('                       |                Gonzalez Niebla, Roger Daniel.             |');
			    WriteLn('                       |                    C.I.: V-26.362.022                     |');
			    WriteLn('                       |                Parra Pulgar, Carlos Douglas.              |');
			    WriteLn('                       |                    C.I.: V-27.158.715                     |');
			    WriteLn('                       |                                                           |');
			    WriteLn('                       |                                                           |');
			    WriteLn('                       |                                                           |');
			    WriteLn('                       |                CIUDAD GUAYANA, JUNIO 2016                 |');
		       WriteLn('                       |-----------------------------------------------------------|');
			    WriteLn('');
             TextColor(LightRed);
		       WriteLn('                                   Presione cualquier tecla para continuar.');
		       ReadKey;
           END
       ELSE
       If BotonMenu=0 then
       BEGIN
         Repeat
           WriteLn('Por favor seleccione una opcion entre 1 y 4');
           Menu:=ReadKey;
         Until (Menu>='1') And (Menu<='4');
       END
     END;
   Until Menu = '4';

END.


