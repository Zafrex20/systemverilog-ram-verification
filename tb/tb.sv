module tb;
    import memory_tb_pkg::*;

    mailbox #(MemoryTransaction) mbx_gen_drv;
    mailbox #(MemoryTransaction) mbx_gen_sb;
    mailbox #(MemoryTransaction) mbx_mon_sb;

    memory_if mif();

    scoreboard sb;
    generator  grt;
    monitor    mon;
    driver     drv;

    memory dut (
        .clk       (mif.clk),
        .wr        (mif.wr),
        .address   (mif.address),
        .data      (mif.data),
        .read_data (mif.read_data)
    );  

    initial begin
        mif.clk = 0;
        forever #5 mif.clk = ~mif.clk;
    end

    initial begin
        mbx_gen_drv = new();
        mbx_gen_sb  = new();
        mbx_mon_sb  = new();

        grt = new(mbx_gen_drv, mbx_gen_sb);
        drv = new(mbx_gen_drv, mif);
        mon = new(mbx_mon_sb, mif);
        sb  = new(mbx_gen_sb, mbx_mon_sb);

        fork
            grt.gen();
            drv.drive();
            mon.monitor_data();
            sb.scoreboard_data();
        join

        $finish;
    end
endmodule
