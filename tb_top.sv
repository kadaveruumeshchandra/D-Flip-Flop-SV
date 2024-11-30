`include "environment.sv"
`include "rtl.sv"

module tb_top();
  dff_if vif();

  dff dut(vif);

  environment env;

  initial begin
    vif.clk<=0;
  end

  always #10 vif.clk=~vif.clk;

  initial begin
    env=new(vif);
    env.gen.trans_count=10;
    env.run();
  end
endmodule
