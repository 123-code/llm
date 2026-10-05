module value_mixer(
    input  logic               clk,
    input  logic               rst,
    
    input  logic               valid_in,
    input  logic               last_token, // High when we are on the final V vector
    
    input  logic [7:0]         prob_in,    // UNSIGNED from Softmax
    input  logic signed [7:0]  v_in,       // SIGNED from BRAM Cache
    
    output logic signed [31:0] final_out,  // The completed Attention Output
    output logic               valid_out
);

    always_ff @(posedge clk) begin
        if (rst) begin
            final_out <= 0;
            valid_out <= 0;
        end else begin
            // YOUR MISSION:
            // Write the valid_in and last_token logic.
            if(valid_in) begin
              
                if(last_token)begin
                    final_out <= final_out + $signed({1'b0, prob_in}) * v_in;
                    valid_out <= 1;
                end else begin
                    //do the operation, if this is not the final token
                    if(valid_out == 1)begin
                        final_out <= $signed({1'b0, prob_in}) * v_in;
                        valid_out <= 0;
                    end else begin
                        final_out <= final_out + $signed({1'b0, prob_in}) * v_in;
                        valid_out <= 0;

                    end
                end
                
            end else begin
                valid_out <= 0;
            end
            // It is the EXACT same structural logic as your signed_q_k_mac,
            // but use the mixed-sign multiplication trick above!
            
        end
    end

endmodule