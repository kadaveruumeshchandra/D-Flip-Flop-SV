//Scoreboard Class
class scoreboard;
  transaction trans;
  transaction trref;

  mailbox #(transaction) mon2scb;
  mailbox #(transaction) gen2scb;

  virtual dff_if vif;

  event scbnxt;

  function new(mailbox #(transaction) mon2scb, mailbox #(transaction) gen2scb);
    this.mon2scb=mon2scb;
    this.gen2scb=gen2scb;
  endfunction

  task main();
    mon2scb.get(trans);
    gen2scb.get(trref);
    trans.display("SCB");
    trref.display("REF");

    if(trans.dout==trref.din) begin
      $display("[SCB]:: Data Matched");
    end
    else begin
      $display("[SCB]:: Data Mismatched");
    end
    $display("-------------------------------");
    ->scbnxt;
    end
  endtask
endclass
