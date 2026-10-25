class monitor;
    MemoryTransaction tr;
    virtual memory_if vif;
    mailbox #(MemoryTransaction) mbx;

    function new(
        mailbox #(MemoryTransaction) mbx_mon_sb,
        virtual memory_if mif
    );
        this.mbx = mbx_mon_sb;
        this.vif = mif;
    endfunction

    task monitor_data();
        int i = 0;
        $display("-------------- MONITOR --------------");
        @(negedge vif.clk);
        while (i < 10) begin
            @(posedge vif.clk);
            #1;
            tr = new();

            tr.read_data = vif.read_data;
            tr.address   = vif.address;
            tr.data      = vif.data;
            tr.wr        = vif.wr;
            $display("Op: %0d | Address: %0d | Data: %0d | Read Data: %0d", tr.wr, tr.address, tr.data, tr.read_data);

            mbx.put(tr);
            i++;
        end
    endtask
endclass
