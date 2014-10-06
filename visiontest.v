module lastPixel(
vsync,
pixelReady,
href,
inputRed[7:0],
inputGreen[7:0],
inputBlue[7:0],
lastY[7:0],
lastX[7:0]
);

input vsync;
input pixelReady;
input href;
input [7:0] inputRed;
input [7:0] inputGreen;
input [7:0] inputBlue;
output reg [7:0] lastY;
output reg [7:0] lastX;

reg [7:0] targetRed;
reg [7:0] targetGreen;
reg [7:0] targetBlue;

reg [7:0] y;
reg [7:0] x;
reg [7:0] runningY;
reg [7:0] runningX;


always @(posedge vsync or posedge pixelReady or posedge href) begin
      if (vsync) begin
            y <= 0;            
            x <= 0;
            lastY <= runningY;
            lastX <= runningX;
            runningX <= 0;
            runningY <= 0;
      end else if (pixelReady) begin
            if (
                  ((targetRed>inputRed)?(targetRed - inputRed):(inputRed-targetRed))<20 
                  & ((targetGreen>inputGreen)?(targetGreen - inputGreen):(inputGreen-targetGreen))<20
                  & ((targetBlue>inputBlue)?(targetBlue - inputBlue):(inputBlue-targetBlue))<20
                  ) begin
                  runningX <= x;
                  runningY <= y;
            end
            x <= x+1;
      end else if (href) begin
            y <= y+1;
      end
end


endmodule