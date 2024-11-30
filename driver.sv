//Driver Class
class driver;
  transaction trans;

  virtual dff_if vif;

  mailbox #(transaction) gen2drv;

  function new(mailbox #(transaction) gen2drv);
    this.gen2drv=gen2drv;
  endfunction

  task reset();
    vif.reset<=1'b1;
    repeat(5) @(posedge vif.clk);
    vif.reset<=1'b0;
    $display("DRV:: Reset is Done");
  endtask

  task main();
    forever begin
      gen2drv.get(trans);
      vif.din<=trans.din;
      @(posedge vif.clk);
      tr.display("DRV");
      vif.din<=0;
      @(posedge vif.clk);
    end
  endtask
endclass
