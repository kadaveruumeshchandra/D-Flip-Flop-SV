//Transaction Class
class transaction;
  rand bit din;
  bit reset;
  bit dout;

  function transaction copy();
    copy=new();
    copy.din=this.din;
    copy.reset=this.reset;
    copy.dout=this.dout;
  endfunction

  function void display(input string tag);
    $display("[%0s]::Din: %0d\t Dout: %0d",tag,din,dout);
  endfunction
endclass
