module softmax_lut(
    input  logic               clk,
    input  logic               rst,
    
    input  logic               valid_in,
    input  logic signed [7:0]  score_in,
    
    output logic [7:0]         prob_out,  // Unsigned! 0 to 255 represents 0% to 100%
    output logic               valid_out
);

    // 1. Declare the BRAM array: 256 slots, 8 bits wide
    logic [7:0] rom_memory [0:255];

    // 2. Load the Python math during synthesis
    initial begin
        $readmemh("softmax.mem", rom_memory);
    end

    // 3. Strip the signed label to use as a pure memory address
    logic [7:0] address;
    assign address = score_in;

    always_ff @(posedge clk) begin
        if (rst) begin
            prob_out  <= 0;
            valid_out <= 0;
        end else begin
            // YOUR MISSION:
            // 1. Read from rom_memory using 'address' and assign to prob_out
            prob_out <= rom_memory[address];
            // 2. Propagate the valid_in signal to valid_out so the pipeline stays synchronized
            valid_out <= valid_in;
        end
    end

endmodule