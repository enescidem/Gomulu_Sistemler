module cift_yollu_bellek
  # (
    parameter ADDR_WIDTH = 4, //adres genişliği
    parameter DATA_WIDTH = 16, //veri öbeği
    parameter DEPTH = 16 //satır sayısı
  )
  (
    input clk,
    input [ADDR_WIDTH-1:0] addr1,
    input [ADDR_WIDTH-1:0] addr2,
    inout [DATA_WIDTH-1:0] data1,
    inout [DATA_WIDTH-1:0] data2,
    input cs1,
    input cs2,
    input we1,
    input we2,
    input oe1,
    input oe2
  );

  reg [DATA_WIDTH-1:0] tmp_data_1;
  reg [DATA_WIDTH-1:0] tmp_data_2;
  reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

  always @ (negedge clk) begin //düşen kenar okuma
    if (cs1 & !we1)
      tmp_data_1 <= mem[addr1];
  end

  always @ (negedge clk) begin // düşen kenar okuma
    if (cs2 & !we2)
      tmp_data_2 <= mem[addr2];
  end

  always @ (posedge clk) begin //yükselen kenar yazma
    if (cs1 & we1)
      mem[addr1] <= data1;
  end

  always @ (posedge clk) begin //yükselen kenar yazma
    if (cs2 & we2)
      mem[addr2] <= data2;
  end

  assign data1 = (cs1 & oe1 & !we1) ? tmp_data_1 : 'hz;
  assign data2 = (cs2 & oe2 & !we2) ? tmp_data_2 : 'hz;
endmodule