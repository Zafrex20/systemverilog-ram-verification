interface memory_if;
    bit       clk;
    bit       wr;
    bit [7:0] address;
    bit [7:0] data;
    bit [7:0] read_data;
endinterface
