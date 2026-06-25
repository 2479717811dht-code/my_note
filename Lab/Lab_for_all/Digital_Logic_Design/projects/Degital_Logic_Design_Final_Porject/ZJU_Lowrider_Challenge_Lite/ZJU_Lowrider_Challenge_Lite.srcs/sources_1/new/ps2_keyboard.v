`timescale 1ns / 1ps

module ps2_keyboard(
    input clk,              
    input rstn,             
    input ps2_clk,          
    input ps2_data,         
    output reg [3:0] key_wasd, 
    output reg key_space    
);

    // 三级同步寄存器消除亚稳态
    reg [2:0] clk_sync;
    reg [2:0] data_sync;
    always @(posedge clk) begin
        clk_sync  <= {clk_sync[1:0], ps2_clk};
        data_sync <= {data_sync[1:0], ps2_data};
    end
    
    wire fall_edge = (clk_sync[2:1] == 2'b10); // 检测时钟下降沿

    reg [3:0] count;
    reg [10:0] shift_reg;

    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            count <= 0;
            shift_reg <= 0;
        end else if (fall_edge) begin
            shift_reg[count] <= data_sync[2];
            if (count == 10) 
                count <= 0;
            else 
                count <= count + 1;
        end
    end

    wire [7:0] data_byte = shift_reg[8:1];
    reg is_break; 

    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            key_wasd  <= 4'b0000;
            key_space <= 1'b0;
            is_break  <= 1'b0;
        end else begin
            key_space <= 1'b0; 
            
            if (fall_edge && count == 10) begin
                if (data_byte == 8'hF0) begin
                    is_break <= 1'b1; 
                end else begin
                    if (!is_break) begin 
                        case (data_byte)
                            8'h1C: key_wasd[0] <= 1'b1; // A -> 左1轨
                            8'h1B: key_wasd[1] <= 1'b1; // S -> 左2轨
                            8'h1D: key_wasd[2] <= 1'b1; // W -> 右2轨
                            8'h23: key_wasd[3] <= 1'b1; // D -> 右1轨
                            8'h29: key_space   <= 1'b1; // Space -> 开始/重来
                        endcase
                    end else begin 
                        case (data_byte)
                            8'h1C: key_wasd[0] <= 1'b0;
                            8'h1B: key_wasd[1] <= 1'b0;
                            8'h1D: key_wasd[2] <= 1'b0;
                            8'h23: key_wasd[3] <= 1'b0;
                        endcase
                        is_break <= 1'b0; 
                    end
                end
            end
        end
    end
endmodule