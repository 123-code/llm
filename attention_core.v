module q_k_dot_product(
input logic clk,
input logic rst_n,

input logic [7:0] q_in,
input logic [7:0] k_in,

input logic valid_in,
input logic last_in,
output logic [31:0] score_out,
output logic valid_out
);

always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        score_out <= 0;
        valid_out <= 0;
    end else if (valid_in) begin
        if(last_in) begin
            score_out <= score_out + (q_in * k_in);
            valid_out <= 1;
        end else begin
            
            score_out <= score_out + (q_in * k_in);
            valid_out <= 0;
        end
    end else begin
        valid_out <= 0;
    end
end

endmodule