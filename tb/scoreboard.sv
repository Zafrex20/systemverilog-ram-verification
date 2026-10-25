class scoreboard;
    MemoryTransaction tr_expected;
    MemoryTransaction tr_actual;

    mailbox #(MemoryTransaction) mbx_gen_sb;
    mailbox #(MemoryTransaction) mbx_mon_sb;

    bit [7:0] expected_mem [0:255];

    function new(
        mailbox #(MemoryTransaction) mbx_gen_sb,
        mailbox #(MemoryTransaction) mbx_mon_sb
    );
        this.mbx_gen_sb = mbx_gen_sb;
        this.mbx_mon_sb = mbx_mon_sb;
    endfunction

    task scoreboard_data();
        int i = 0;
        while (i < 10) begin
            mbx_gen_sb.get(tr_expected);
            mbx_mon_sb.get(tr_actual);

            if (tr_expected.wr) begin
                expected_mem[tr_actual.address] = tr_expected.data;
            end else begin
                if (tr_actual.read_data == expected_mem[tr_actual.address]) begin
                    $display("PASS: Transaction correct");
                    $display("");
                end else begin
                    $display("FAIL     | Transaction dismatch");
                    $display("EXPECTED | Address: %0d | Data: %0d", tr_expected.address, expected_mem[tr_actual.address]);
                    $display("ACTUAL   | Address: %0d | Data: %0d", tr_actual.address, tr_actual.read_data);
                    $display("");
                end
            end
            i++;
        end
    endtask
endclass
