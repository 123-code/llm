
/*
multiply accumulate for an int 8 transformer accelerator
must compoute the dot product of two streaming vectors
must handle signed 8 bit integers. 
uses a synchronous active high reset, not an asynchronous active-low one.
*/
module signed_q_k_mac(
input logic clk,
input logic rst,
input logic valid_in,
input logic last_in,


input logic signed [7:0] q_in,
input logic signed [7:0] k_in,
output logic signed [31:0] score_out,
//high when final vector score is ready
output logic valid_out
);

always_ff @(posedge clk) begin
    if(rst)begin
        score_out <= 0;
        valid_out <= 0;
    //check if valid in
 

    end else begin
   if(valid_in) begin
   //if last
   if(last_in)begin
   score_out <= score_out + (q_in * k_in);
   valid_out <= 1;

   end else begin
//if streaming operation
if(valid_out == 1) begin
    score_out <= (q_in * k_in); // if last in is on we empty the bucket, because we are in a new vectr
    valid_out <= 0;
end else begin
   score_out <= score_out + (q_in * k_in);
   valid_out <= 0;
end
end
   end else begin
    valid_out <=0;
   end

end
end




endmodule