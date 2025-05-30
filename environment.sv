//Environment Class
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;
  generator gen;
  driver drv;
  monitor mon;
  scoreboard scb;

  mailbox #(transaction) gen2drv;
  mailbox #(transaction) gen2scb;
  maailbox #(transaction) mon2scb;

  event scbnxt;

  virtual dff_if vif;

  function new(virtual dff_if vif);
    gen2drv=new();
    gen2scb=new();
    mon2scb=new();

    gen=new(gen2drv,gen2scb);
    drv=new(gen2drv);
    mon=new(mon2scb);
    scb=new(mon2scb,gen2scb);

    gen.scbnxt=scbnxt;
    scb.scbnxt=scbnxt;

    this.vif=vif;
    drv.vif=this.vif;
    mon.vif=this.vif;
  endfunction

  task pre_test();
    drv.reset();
  endtask

  task test();
    fork
      gen.main();
      drv.main();
      mon.main();
      scb.main();
    join_any
  endtask

  task post_test();
    wait(gen.gen_ended.triggered);
    $finish;
  endtask

  task run();
    pre_test();
    test();
    post_test();
  endtask
endclass
