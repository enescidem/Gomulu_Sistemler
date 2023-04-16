module trafik_lambasi (
input clk,
output reg [2:0] led
);

reg [31:0] counter;

always @(posedge clk) begin
    if (counter < 32'd408_000_000) //10s(kırmızı)+2s(mavi)+5s(yeşil)=17 17*24000000(1s)=408000000 ->toplam dönmesi gereken clock sayısı
        counter <= counter + 1;
    else
        counter <= 32'd0;
end
//110-> yeşil 101-> kırmızı 011->mavi
always @(posedge clk) begin
    if(counter <= 32'd240_000_000) //10s(kırmızı)*24000000=240000000 -> kırmızı clock sayısı
        led <= 3'b101; //10s kırmızı yanar
    else if (counter > 32'd288_000_000) //2s(mavi)*24000000=48000000 48000000+240000000=288000000 -> kırmızı+mavi clock sayısı
        led <= 3'b110; //5s yeşil yanar
    else
        led <= 3'b011; // 2s mavi yanar
   
end
endmodule