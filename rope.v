//q'0 = (q0 * cos) - (q1 * sin)
//q'1 = (q0 * sin) + (q1 * cos)
module rope(
    input logic clk,
    input logic reset,
    input logic signed[7:0] q0,
    input logic signed[7:0] q1,
    input logic signed[7:0] cos,
    input logic signed[7:0] sin,
    output logic signed[15:0] q0_out_raw,
    output logic signed[15:0] q1_out_raw

);