//Generator Class
class generator;
  transaction trans;

  int trans_count;

  mailbox #(transaction) gen2drv;
  mailbox #(transaction) gen2scb;

  event scbnxt;

  function new(mailbox #(transaction) gen2drv, mailbox #(transaction) gen2scb);
    this.gen2drv=gen2drv;
    this.gen2scb=gen2scb;
    trans=new();
  endfunction

  task main();
    repeat(trans_count) begin
      assert(trans.randomize()) 
      else $fatal([GEN]:: Randomization Failed");
      gen2drv.put(trans.copy);
      gen2scb.put(trans.copy);
      trans.display("GEN");
      @(scbnxt);
    end
    ->gen-ended;
  endtask
endclass
                                            
                                            
