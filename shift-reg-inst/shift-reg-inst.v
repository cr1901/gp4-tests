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


`ifdef NO_INFER_GP_SHREG_AT_ALL
    reg[0:11] shift_hi = 12'b1; // Force non-instantiation.
    wire[0:1] shift_mid_taps;
`else
    reg[0:11] shift_hi;
    reg[0:1] shift_mid_taps;
`endif


wire[0:1] shift_lo_taps;

assign {bit0, bit1} = shift_lo_taps;
assign {bit2, bit3} = shift_mid_taps;

assign {bit4,
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
} = shift_hi;

GP_SHREG #(
    .OUTA_TAP(1),
    .OUTA_INVERT(0),
    .OUTB_TAP(2)
) shift_lo (
    .nRST(1'b1),
    .CLK(clk),
    .IN(sin),
    .OUTA(shift_lo_taps[0]),
    .OUTB(shift_lo_taps[1])
);

`ifdef NO_INFER_GP_SHREG_AT_ALL
    GP_SHREG #(
        .OUTA_TAP(0),
        .OUTA_INVERT(0),
        .OUTB_TAP(1)
    ) shift_mid (
        .nRST(1'b1),
        .CLK(clk),
        .IN(shift_lo_taps[1]),
        .OUTA(shift_mid_taps[0]),
        .OUTB(shift_mid_taps[1])
    );
`endif

    
always @(posedge clk) begin
    shift_hi = {shift_mid_taps[1], shift_hi[0:10]};
    `ifndef NO_INFER_GP_SHREG_AT_ALL
        shift_mid_taps = {shift_lo_taps[0], shift_mid_taps[0]};
    `endif
end


endmodule
