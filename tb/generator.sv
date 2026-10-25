class generator;
    MemoryTransaction tr;
    MemoryTransaction tr_drv;
    MemoryTransaction tr_sb;

    mailbox #(MemoryTransaction) mbx_gen_drv;
    mailbox #(MemoryTransaction) mbx_gen_sb;

    function new(
        mailbox #(MemoryTransaction) mbx_gen_drv,
        mailbox #(MemoryTransaction) mbx_gen_sb
    );
        this.mbx_gen_drv = mbx_gen_drv;
        this.mbx_gen_sb = mbx_gen_sb;
    endfunction

    task gen();
        $display("------------ GENERATOR ------------");
        for (int i = 0; i < 5; i++) begin
            // WRITE
            tr = new(); 
            if (!tr.randomize() with {wr == 1;}) begin
                $error("Write randomization failed");
            end else begin
                tr_drv = new();
                tr_drv.address = tr.address;
                tr_drv.data    = tr.data;
                tr_drv.wr      = tr.wr;

                tr_sb = new();
                tr_sb.address  = tr.address;
                tr_sb.data     = tr.data;
                tr_sb.wr       = tr.wr;

                tr.display();
                mbx_gen_drv.put(tr_drv);
                mbx_gen_sb.put(tr_sb);
            end

            // READ
            tr = new();

            tr.address = tr_drv.address;
            tr.data    = 0;
            tr.wr      = 0;

            tr_drv = new();
            tr_drv.address = tr.address;
            tr_drv.data    = tr.data;
            tr_drv.wr      = tr.wr;

            tr_sb = new();
            tr_sb.address  = tr.address;
            tr_sb.data     = tr.data;
            tr_sb.wr       = tr.wr;

            tr.display();
            mbx_gen_drv.put(tr_drv);
            mbx_gen_sb.put(tr_sb);
        end
    endtask
endclass
