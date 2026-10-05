module scale_score(
    input  logic               clk,
    input  logic               rst,
    
    input  logic               valid_in,
    input  logic signed [31:0] score_in,
    
    output logic signed [7:0]  scaled_out,
    output logic               valid_out
);

    always_ff @(posedge clk) begin
        if (rst) begin
            scaled_out <= 0;
            valid_out  <= 0;
        end else begin
            if (valid_in) begin
            // Write your shifting and valid logic here!
            scaled_out <=  score_in >>> 3;
            valid_out <= 1;

            end else if(!valid_in) begin
            valid_out <= 0;
            end
        end
    end

endmodule