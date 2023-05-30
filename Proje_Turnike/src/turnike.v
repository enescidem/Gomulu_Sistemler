module turnike(
  input clk,             // Dahili clock
  input btn1,            // Buton1 girişi
  input btn2,            // Buton2 girişi
  output reg [2:0] led   // LED çıkışı
);

reg [31:0] counter1 =-1;
reg [31:0] counter2 =-1;
reg [31:0] counter3;

always @(posedge clk) begin
    if (!btn1)
        counter1 <= 32'd0;
    else if (counter1 < 32'd100_000_000)
        counter1 <= counter1 + 1;
end

always @(posedge clk) begin
    if (!btn2)
        counter2 <= 32'd0;
    else if (counter2 < 32'd100_000_000)
        counter2 <= counter2 + 1;
end

always @(posedge clk) begin
    if (counter3 < 32'd48_000_000)
        counter3 <= counter3 + 1;
    else
        counter3 <= 32'd0;
end

always @(posedge clk) begin
    if (counter1 < 32'd100_000_000)      // 5 saniye yeşil
        led <= 3'b011; 
    else if (counter2 < 32'd100_000_000) // 5 saniye kırmızı
        led <= 3'b110;
    else if (counter3 < 32'd24_000_000)  // 1 saniye mavi
        led <= 3'b101;
    else                                 // 1 saniye ledleri kapat
        led <= 3'b111;
end

endmodule






