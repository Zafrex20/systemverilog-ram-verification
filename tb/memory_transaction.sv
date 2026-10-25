class MemoryTransaction;
    rand bit [7:0] address, data;
    rand bit       wr;

    bit [7:0] read_data;
  
    function void display();
        $display("Op: %0d | Address: %0d | Data: %0d", wr, address, data);
    endfunction
endclass
