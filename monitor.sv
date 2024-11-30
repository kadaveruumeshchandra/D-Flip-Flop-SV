//Monitor Class
class monitor;
  transaction trans;

  mailbox #(transaction) mon2scb;

  virtual dff_if vif;

  function new(mailbox #(transaction) mon2scb);
    this.mon2scb=mon2scb);
  endfunction

  task main();
    forever begin
      repeat(2) @(posedge vif.clk);
      trans.dout=vif.dout;
      trans.display("MON");
    end
  endtask
endclass
