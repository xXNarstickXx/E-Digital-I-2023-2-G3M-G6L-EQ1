# Separador de cajas por tamaño y por color

Integrantes:

- Diego Fernando Fernandez Narvaez
- Andres Felipe Clavijo Durán
- Erika Johanna Quintero Calderón
  
## Contexto del problema

En un centro de distribución industrial, se reciben grandes volúmenes de cajas provenientes de diferentes proveedores y con variados tamaños, formas y materiales. Estas cajas deben ser clasificadas eficientemente para su posterior almacenamiento y envío. Sin embargo, la clasificación manual en grandes cantidades consume mucho tiempo y dependiendo de la cantidad de productos a clasificar necesitará de menos o más personal, la variedad de cajas puede dificultar la optimización del espacio de almacenamiento y el personal puede estar realizando actividades que requieran de esfuerzo físico que puede inducir errores en la actividad de clasificación. El desafío radica en desarrollar un sistema automatizado que permita clasificar las cajas de manera precisa y eficiente.

Para el desarrollo de este proyecto se utilizó una banda transportadora con motor incluido, un sensor de ultrasonido, un módulo láser con una fotocelda, dos servomotores, arduino como convertidor ADC y la FPGA Lattice ice 40x.

### Aclaraciones
Debido a problemas con el sensor de color no se pudo implementar este en el proyecto, en reemplazo se implementó un sensor láser como detector de obstáculos, luego la máquina solo podrá separar cajas por tamaño.

### Funcionamiento
El sensor de ultrasonido utilizado para medir la altura de las cajas estará midiendo esto constantemente pero unicamente se tomarán los datos cuando una caja pase por debajo de esto, nos aseguramos de esto usando un módulo laser que apunta hacia una fotocelda al otro lado de la banda transportadora, cuando una caja pase en frente del láser esta permitirá que la FPGA tome datos únicamente en ese momento, datos que serán utilizados para mover los servomotores ubicados a los lados de la banda transportadora los cuales enviaran las cajas a diferentes lugares dependiendo de su tamaño.

## Banner
Link del video de la implementación del proyecto: <div align="left"><a href="https://youtu.be/ggKCQbyKBco" target="_blank">
    <img src="https://raw.githubusercontent.com/maurodesouza/profile-readme-generator/master/src/assets/icons/social/youtube/default.svg" width="52" height="40" alt="youtube logo"  />
  </a>
</div>

## RTL's sensor de proximidad.
### Módulo top (Módulo principal)

<img align="left" height="400" src="https://i.ibb.co/RBdpH71/top.jpg"  /> El módulo top interconecta todos los módulos de verilog utilizados para el funcionamiento de este proyecto, para este proyecto se utilizaron 6 módulos los cuales son los siguientes:
- Clkinult (Módulo que controla el intervalo de tiempo en el cual el módulo "ulttrigger" enviará pulsos).
- Ulttrigger (Módulo encargado de enviar un pulso con un ancho de pulso de 10uS para el pin "trigger" del sensor de ultrasonido).
- Echocounter (Módulo encargado de medir el ancho de pulso del pin "echo" del ultrasonido).
- Ultactuador (Módulo encargado de comparar anchos de pulso para escoger la acción que se ejecutará).
- Servo y servo2 (Módulo que controla servomotores. Servo y servo2 deben moverse en ángulos diferentes debido a que se ubican en lugares diferentes en la banda transportadora, por esta razón son dos módulos diferentes a pesar de que controlamos el mismo dispositivo).
- 
### Módulo clkinult (Reloj usado como temporizador para el módulo "ulttrigger")

<img align="left" height="300" src="https://i.ibb.co/9nf1P8S/clkinult.jpg"  /> Este módulo es básicamente un generador de ancho de pulso que utiliza el reloj (entrada clk_in) de la FPGA de 10ms con ciclo útil de 1/3, se define un valor de contador el cual mientras no sea alcanzado por un sumador, hará que el reloj mantenga un valor ALTO y otro valor límite que mientras no se alcance el reloj no se reiniciará.
- En el recuadro azul se encuentra el sumador.
- En el recuadro naranja el comparador que evalua si el reloj se reinicia.
- En el recuadro rojo el comparador encargado de ver si se ha llegado al límite del contador.
- En el recuadro morado se evalua si clk_out está en ALTO o BAJO dependiendo si el límite del contador se ha sobrepasado o no.

Entradas: clk_in (25MHz)

Salidas: clk_out

### Módulo ulttrigger (Encargado de enviar un pulso de 10us al pin "Trigger" del ultrasonido)

<img align="left" height="220" src="https://i.ibb.co/JrJHWxM/ulttrigger.png"  /> Este módulo usa la misma lógica del módulo anterior, busca crear un generador de ancho de banda de 10us, solo que en el caso de este módulo el pulso se generará cada vez que la señal "start" (conectada al módulo clkinult) tenga un valor de 1.
En el recuadro azul está el flip-flop encargado de realizar la acción de ver el valor de "start", en el recuadro rojo está en generador del pulso, similar al módulo clkinult.

Entradas: clk_in (25MHz), start

Salidas: pulse

### Módulo echocounter (Encargado de medir el ancho de pulso de la señal recibida por el ultrasonido)

<img align="left" height="230" src="https://i.ibb.co/fX6RV5K/echocounter.png"  /> Es el módulo con mayor simpleza se encarga de tener un sumador (recuadro verde) que empezará con un flanco de subida de la señal de entrada "echo" y terminará con un flanco de bajada de esta misma señal, también en el flanco de bajada se guardará el valor final del sumador en el registro de salida "ciclos" (recuadro morado).

Entradas: clk_in (25MHz), echo

Salidas: ciclos

//

### Módulo actuador (Dependiendo del ancho de pulso se elije una acción)

<img align="left" height="400" src="https://i.ibb.co/8NMsMSZ/actuador.png"  /> Es el módulo mas grande pero se repite constantemente, usa el valor de entrada count y compara si esta entre ciertos intervalos definidos por los parámetros encerrados en círculos rojos, esto por medio de comparadores (recuadros amarillos) y dependiendo de los resultados se llevan a los flip-flops al final hacia las salidas xled,rled,vled,aled (recuadro azul). Se debe aclarar que esta comparación solo se hace si la entrada "laser" vale 1, esto para tomar medidas del ultrasonido solo cuando se necesitan.

Entradas: count, laser

Salidas: xled, rled, vled, aled

//

//

//

//

### Módulos servo y servo2 (Controlador de servomotores)

<img align="right" height="426" src="https://i.ibb.co/8KJ8QDN/servo2.jpg"  />

<img align="left" height="426" src="https://i.ibb.co/1vNRCtN/servo.png"  />
 
 //

Primero se utiliza un multiplexor que utiliza como señal de control la entrada "rg" (recuadro rojo), dependiendo de si es 1 o 0 se determina un valor diferente para el límite de contador del generador de ancho de pulso (recuadro azul) el cual irá a salida "clk_out". Los valores límite están determinados para que los ángulos marcados por los servomotores sean 0° y 45° para el módulo "servo" y 180° y 135° para el módulo "servo2".

Entradas: clk_in (25MHz), rg (servo), vg(servo2)

Salidas: clk_out

## RTL's sensor de color
### Modulo Top (Modulo Principal)
<img align="right" height="400" src="https://i.ibb.co/DD3j4Nf/Rtl-Sensor-Color.png" />

El módulo top interconecta todos los módulos de verilog utilizados para el funcionamiento de este proyecto, para esta parte del proyecto se utilizaron 2 módulos los cuales son los siguientes: 
- Color (Módulo que se encarga de la captura de datos del sensor).
- Control (Módulo encargado de el control de datos del sensor (Encender un led)).

 ### Modulo color
 <img align="right" height="450" src="https://i.ibb.co/tD7R5CZ/Rtl-Datos-Color.png"  />
 
 El modulo de color basicamente funciona filtrando cada señal obtenida en un cable que es enviado al modulo de control para realizar la gestion y manejo de datos. se definen las siguientes entradas out, clk y las salidas s0, s1, s2, s3, rojo y azul ( los colores a filtrar), el modulo asigna los valores de 1 a s0 y s1 para manejar el 100% de la frecuencia del sensor, y s2 en 0 ya que para los colores que se filtraron se necesitaba que este estuviera con un nivel logico en bajo, luego se inicia un conteo de 0,2 segundos en los cuales se van tomando los anchos de pulso de cada matriz de color selecionada (en este caso rojo y azul), las cuales se activan y desactivan con s2 y s3.

 ### Modulo color
 <img align="right" height="450" src="https://i.ibb.co/F8BJnVV/Rtl-Control-Color.png"  />

 El modulo de control funciona obteniendo los datos del sensor de color el cual si el ancho de pulso de la matriz del sensor rojo es menor que la del sensor azul se encienda el led rojo y viceversa.

 


