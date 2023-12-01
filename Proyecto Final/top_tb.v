`timescale 1ns/1ps // Escala de tiempo para la simulación
module top_tb;

    // Definición de señales
    reg clock;     // Señal de reloj
    reg laser;     // Señal de entrada relacionada con el láser
    reg echo;      // Señal de entrada relacionada con la respuesta del eco

    wire pulse;    // Salida relacionada con el pulso
    wire rled, vled, aled, ledx;    // Salidas relacionadas con LED
    wire clkout1, clkout2;  // Salidas de reloj de los módulos servo1 y servo2

    // Instanciación del módulo top
    top dut (
        .clock(clock),
        .laser(laser),
        .pulse(pulse),
        .echo(echo),
        .rled(rled),
        .vled(vled),
        .aled(aled),
        .ledx(ledx),
        .clkout1(clkout1),
        .clkout2(clkout2)
    );

    // Generación de señales de prueba
    initial begin
        $dumpfile("top.vcd"); // Nombre del archivo .vcd a guardar
        $dumpvars(0, top_tb); // Guardar todas las señales del testbench

        // Establecer la entrada clock
        clock = 0;
		echo=0;
		laser=0;
        // Ciclo de clock para simular el funcionamiento
		repeat (1000000) begin
        #10;  // Incrementar el tiempo de manera más precisa

        clock = ~clock;
        
        // Cambios en la señal de echo a intervalos precisos
        if ($time % 32000 == 0) begin
            #0.00064;  // Cambiar echo cada 0.64us
            echo = ~echo;
        end
        if ($time % 200000 == 0) begin
            #0.002;  // Cambiar echo cada 0.64us
            laser=~laser;
        end
    end
        // Agregar más cambios y pruebas según sea necesario...
    end

endmodule
