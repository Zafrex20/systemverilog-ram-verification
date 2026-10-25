class driver; 
    MemoryTransaction tr;
    virtual memory_if vif;
    mailbox #(MemoryTransaction) mbx;

    function new(
        mailbox #(MemoryTransaction) mbx_gen_drv, 
        virtual memory_if mif
    );
        this.mbx = mbx_gen_drv;
        this.vif = mif;
    endfunction

    task drive();
        //$display("");
        //$display("-------------- DRIVER --------------");
        for (int i = 0; i < 10; i++) begin
            mbx.get(tr);

            @(negedge vif.clk);

            vif.address = tr.address;
            vif.data = tr.data;
            vif.wr = tr.wr;
        end
    endtask
endclass
