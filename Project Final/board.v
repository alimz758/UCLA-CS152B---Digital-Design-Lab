module board(
input wire clk,
input wire rst,
input wire [1:0] player_move,

output reg next_player,
output reg [1:0] board_state [0:2][0:2],
output reg game_ended,
output reg winner
);

always @(posedge clk) begin
end

endmodule
