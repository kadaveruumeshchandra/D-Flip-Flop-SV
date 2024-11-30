module dff(dff_if vif);
  always@(posedge vif.clk) begin
    if(vif.reset) begin
      vif.dout<=0;
    end
    else begin
      vif.dout<=vif.din;
    end
  end
endmodule

interface dff_if();
  logic clk;
  logic reset;
  logic din;
  logic dout;
endinterface
