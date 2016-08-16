module top(
    clk,
    sin,
    bit0,
    bit1,
    bit2,
    bit3,
    bit4,
    bit5,
    bit6,
    bit7,
    bit8,
    bit9,
    bita,
    bitb,
    bitc,
    bitd,
    bite,
    bitf
);

input wire clk;
input wire sin;
output wire bit0;
output wire bit1;
output wire bit2;
output wire bit3;
output wire bit4;
output wire bit5;
output wire bit6;
output wire bit7;
output wire bit8;
output wire bit9;
output wire bita;
output wire bitb;
output wire bitc;
output wire bitd;
output wire bite;
output wire bitf;

reg[0:15] shift_reg;

assign {bit0,
    bit1,
    bit2,
    bit3,
    bit4,
    bit5,
    bit6,
    bit7,
    bit8,
    bit9,
    bita,
    bitb,
    bitc,
    bitd,
    bite,
    bitf
} = shift_reg;
    
always @(posedge clk) begin
    shift_reg = {sin, shift_reg[0:14]};
end


endmodule
