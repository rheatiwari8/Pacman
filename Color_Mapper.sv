//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Zuofu Cheng   08-19-2023                               --
//                                                                       --
//    Fall 2023 Distribution                                             --
//                                                                       --
//    For use with ECE 385 USB + HDMI                                    --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input  logic [9:0] BallX, BallY, DrawX, DrawY, Ball_size,
                       input logic [31:0] control_reg,
                       input logic [7:0] font_data,
                       input logic inverse, Clk,
                       output logic [3:0]  Red, Green, Blue );
    
    logic ball_on;

always_comb 
    if(inverse)
    begin
        if(font_data[7-DrawX[2:0]])
        begin
            Red = control_reg[12:9];
            Green = control_reg[8:5];
            Blue = control_reg[4:1];    
        end
        else   
        begin
            Red = control_reg[24:21];
            Green = control_reg[20:17];
            Blue = control_reg[16:13];
        end
    end
    else
    begin
        if(font_data[7-DrawX[2:0]])
        begin
            Red = control_reg[24:21];
            Green = control_reg[20:17];
            Blue = control_reg[16:13];   
        end
        else   
        begin
            Red = control_reg[12:9];
            Green = control_reg[8:5];
            Blue = control_reg[4:1];
        end
    end


//always_ff @( posedge Clk )   
//always_comb 

//        for(int i = 7; i > 0 ; i-- )
//        begin
//            if ( font_data[i] && (inverse == 0) )
//            begin 
//                 Red = control_reg[24:21];
//                 Green = control_reg[20:17];
//                 Blue = control_reg[16:13];
//            end 
//            else if ( (font_data[i] == 0) && (inverse == 0) )
//            begin 
//                 Red = control_reg[12:9];
//                 Green = control_reg[8:5];
//                 Blue = control_reg[4:1];
//            end 
//            else if ( font_data[i] && inverse)
//            begin 
//                 Red = control_reg[12:9];
//                 Green = control_reg[8:5];
//                 Blue = control_reg[4:1];
//            end 
//            else // ( (font_data[i] == 0) && inverse)
//            begin 
//                 Red = control_reg[24:21];
//                 Green = control_reg[20:17];
//                 Blue = control_reg[16:13];
//            end       
//         end

 /* Old Ball: Generated square box by checking if the current pixel is within a square of length
    2*BallS, centered at (BallX, BallY).  Note that this requires unsigned comparisons.
	 
    if ((DrawX >= BallX - Ball_size) &&
       (DrawX <= BallX + Ball_size) &&
       (DrawY >= BallY - Ball_size) &&
       (DrawY <= BallY + Ball_size))
       )

     New Ball: Generates (pixelated) circle by using the standard circle formula.  Note that while 
     this single line is quite powerful descriptively, it causes the synthesis tool to use up three
     of the 120 available multipliers on the chip!  Since the multiplicants are required to be signed,
	  we have to first cast them from logic to int (signed by default) before they are multiplied). */
	  
//    int DistX, DistY, Size;
//    assign DistX = DrawX - BallX;
//    assign DistY = DrawY - BallY;
//    assign Size = Ball_size;
 
//     always_comb
//    begin:Ball_on_proc
//        if ( (DistX*DistX + DistY*DistY) <= (Size * Size) )
//            ball_on = 1'b1;
//        else 
//            ball_on = 1'b0;
//     end  

////assign ball_on = 1'b1;
      
//    always_comb
//    begin:RGB_Display
//        if ((ball_on == 1'b1)) begin 
//            Red = 4'h0;
//            Green = 4'h7;
//            Blue = 4'h7;
//        end       
//        else begin 
//            Red = 4'h0 - DrawX[9:6]; 
//            Green = 4'hf - DrawX[9:6];
//            Blue = 4'hf - DrawX[9:6];
//        end      
//    end 
    
endmodule
