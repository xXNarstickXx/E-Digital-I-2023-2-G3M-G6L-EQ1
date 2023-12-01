module Color(
    input clk,
    input out,
    output wire s0,
    output wire s1,
    output wire s2,
    output wire s3,
    output wire [22:0] rojo,
    output wire [22:0] azul 
);
    assign s0 = 1'b1;
    assign s1 = 1'b1;
    assign s2 = 1'b0;
    
    parameter size = 23; // 2^23 = 8388608, contiene a 5000000.
    parameter limite = 23'd5000000; // (25MHz/ 1/200 ms) = 5000000.

    reg [size - 1 : 0] contador = 23'd0; // contador de 0.2 s.
    reg [size - 1 : 0] Ancho_Pulso = 23'd0; 
    reg estado = 1'b0;
 
    always @(posedge clk)
    begin
        case (estado)
            1'b0: // SensorRojo
                begin
                    s3 = 1'b0;   // Activamos los sensores rojos
                    if (contador < limite)
                    begin 
                        contador <= contador + 1;
                        if (out == 1)
                            Ancho_Pulso <= Ancho_Pulso + 1;
                        else 
                        begin
                            rojo <= Ancho_Pulso;
                            Ancho_Pulso <= 23'd0;
                        end
                    end
                    else 
                    begin
                        contador <= 23'd0;
                        estado <= 1'b1;   // Pasamos al siguiente estado   
                    end
                end

            1'b1: // SensorAzul
                begin
                    s3 = 1'b1;   // Activamos los sensores azules
                    if (contador < limite)
                    begin 
                        contador <= contador + 1;
                        if (out == 1)
                            Ancho_Pulso <= Ancho_Pulso + 1;
                        else 
                        begin
                            azul <= Ancho_Pulso;
                            Ancho_Pulso <= 23'd0;
                        end
                    end
                    else
                    begin
                        contador <= 23'd0;
                        estado <= 1'b0;   // Pasamos al estado inicial.
                    end
                end
        endcase
    end
endmodule


