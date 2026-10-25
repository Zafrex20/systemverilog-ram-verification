module memory (
    input  bit       clk,
    input  bit       wr,
    input  bit [7:0] address,
    input  bit [7:0] data,
    output bit [7:0] read_data
);

    bit [7:0] mem [0:255];

    always_ff @(posedge clk) begin
        if (wr)
            mem[address] <= data;
        else
            read_data <= mem[address];
    end
endmodule
