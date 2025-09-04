//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Zuofu Cheng   08-19-2023                               --
//    Fall 2023 Distribution                                             --
//                                                                       --
//    For use with ECE 385 USB + HDMI Lab                                --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  ball ( input logic Reset, frame_clk,
			   input logic [7:0] keycode,
			   input logic vga_clk,
			   input logic stop,
			   input logic [3:0] blue,
               output logic [9:0]  BallX, BallY, BallS );
    
    logic [9:0] Ball_X_Motion, Ball_Y_Motion;
    logic [0:0] rom_q, romt, romb, romr, roml;
    logic [16:0]rom_address, rom_address_r, rom_address_l, rom_address_t, rom_address_b;
    logic negedge_vga_clk;
    assign negedge_vga_clk = ~vga_clk;
	 
    parameter [9:0] Ball_X_Center=320;  // Center position on the X axis  //320
    parameter [9:0] Ball_Y_Center=260;  // Center position on the Y axis  //240, 270
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=1;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=1;      // Step size on the Y axis

    assign BallS = 6;  // default ball size
    
    
    rom pac_maze_rom0 (
	.clka   (negedge_vga_clk),
	.addra (rom_address),
	.douta       (rom_q)
);

assign rom_address = ((BallX * 300) / 640) + (((BallY* 300) / 480) * 300);
assign rom_address_r = (((BallX + BallS) * 300) / 640) + (((BallY* 300) / 480) * 300);
assign rom_address_l = (((BallX - BallS) * 300) / 640) + (((BallY* 300) / 480) * 300);
assign rom_address_t = ((BallX * 300) / 640) + ((((BallY - BallS)* 300) / 480) * 300);
assign rom_address_b = ((BallX * 300) / 640) + ((((BallY + BallS)* 300) / 480) * 300);



    rom pac_maze_rom1 (
	.clka   (negedge_vga_clk),
	.addra (rom_address_r),
	.douta       (romr)
);
    rom pac_maze_rom2 (
	.clka   (negedge_vga_clk),
	.addra (rom_address_t),
	.douta       (romt)
);
    rom pac_maze_rom3 (
	.clka   (negedge_vga_clk),
	.addra (rom_address_l),
	.douta       (roml)
);
    rom pac_maze_rom4 (
	.clka   (negedge_vga_clk),
	.addra (rom_address_b),
	.douta       (romb)
);
   
    always_ff @ (posedge frame_clk or posedge Reset) //make sure the frame clock is instantiated correctly
    begin: Move_Ball
        if (Reset)  // asynchronous Reset
        begin 
            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
			Ball_X_Motion <= 10'd0; //Ball_X_Step;
			BallY <= Ball_Y_Center;
			BallX <= Ball_X_Center;
        end
           
//        else if (rom_q)
//        begin

//			Ball_Y_Motion <= 10'd0;
//			Ball_X_Motion <= 10'd0;

//        end
        else if (romr)
        begin
			BallX <= (BallX - 1);
			Ball_X_Motion <= 10'd0;
//            BallY <= Ball_Y_Center;
//			BallX <= Ball_X_Center;
            //BallX <= (BallX - 2) ;
        end
        else if (roml)
        begin
            BallX <= (BallX + 1);
            Ball_X_Motion <= 10'd0;
//            BallY <= (BallY + Ball_Y_Motion);  // Update ball position
//			BallX <= (BallX + Ball_X_Motion);
//            BallY <= Ball_Y_Center;
//			BallX <= Ball_X_Center;
            //BallX <= (BallX + 2) ;
        end
        else if (romt)
        begin
            BallY <= (BallY + 1);
            Ball_Y_Motion <= 10'd0;
//            Ball_Y_Motion <= Ball_Y_Step;
//            BallY <= (BallY + Ball_Y_Motion);  // Update ball position
//			BallX <= (BallX + Ball_X_Motion);
//            BallY <= Ball_Y_Center;
//			BallX <= Ball_X_Center;
            //BallX <= (BallY - 2) ;
        end
        else if (romb)
        begin
            BallY <= (BallY - 1);
            Ball_Y_Motion <= 10'd0;
//            Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);
//            BallY <= (BallY + Ball_Y_Motion);  // Update ball position
//			BallX <= (BallX + Ball_X_Motion);
//            BallY <= Ball_Y_Center;
//			BallX <= Ball_X_Center;
            //BallX <= (BallY + 2) ;
        end
        else if (rom_q)
        begin
            BallY <=  Ball_Y_Center;
			BallX <= Ball_X_Center;
            //BallX <= (BallY + 2) ;
        end
        else
        begin 
//				 if ( (BallY + BallS) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
//					  Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);  // 2's complement.
					  
//				 else if ( (BallY - BallS) <= Ball_Y_Min )  // Ball is at the top edge, BOUNCE!
//					  Ball_Y_Motion <= Ball_Y_Step;
					  
//				  else if ( (BallX + BallS) >= Ball_X_Max )  // Ball is at the Right edge, BOUNCE!
//					  Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);  // 2's complement.
					  
//				 else if( (BallX - BallS) <= Ball_X_Min )  // Ball is at the Left edge, BOUNCE!
//					  Ball_X_Motion <= Ball_X_Step;
					  
//			     else if( stop )  // Ball is at the left wall boundary!
//			     begin
//					  Ball_X_Motion <= 10'd0;
//					  Ball_Y_Motion <= 10'd0;
//			     end
					  
					  
//				 else  begin
//					  Ball_Y_Motion <= Ball_Y_Motion;
//					  Ball_X_Motion <= Ball_X_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving
//					  end
				 //modify to control ball motion with the keycode
				 if (keycode == 8'h1A ) begin
				    if ( (BallY - BallS) <= Ball_Y_Min )  // Ball is at the top edge, BOUNCE!
					  //Ball_Y_Motion <= Ball_Y_Step;
					  begin
					       Ball_X_Motion <= 10'd0;
					       Ball_Y_Motion <= 10'd0;
					  end
					else if( romt )  // Ball is at the left wall boundary!
			         begin
			               Ball_Y_Motion <= Ball_Y_Step;
//					       Ball_X_Motion <= 10'd0;
//					       Ball_Y_Motion <= 10'd0;
			         end
					else begin
                        Ball_Y_Motion <= -10'd1;
				        Ball_X_Motion <= 10'd0;  
				     end 
				     end 
				        
//				 BallY <= (BallY + Ball_Y_Motion);  // Update ball position
//				 BallX <= (BallX + Ball_X_Motion);
				 
				  else if (keycode == 8'h16) begin //S - to go down
				    if ( (BallY + BallS) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
					   Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);
					    
					else if( romb )  // Ball is at the left wall boundary!
			         begin
			         Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);
//					       Ball_X_Motion <= 10'd0;
//					       Ball_Y_Motion <= 10'd0;
			         end
			         				 
				    else begin
                        Ball_Y_Motion <= 10'd1; //change to be 10'd1
				        Ball_X_Motion <= 10'd0;
				    end
				  end
				     
//				 BallY <= (BallY + Ball_Y_Motion);  // Update ball position
//				 BallX <= (BallX + Ball_X_Motion);
				 
				 else if (keycode == 8'h04) begin//A - to go left
				    if ( (BallX - BallS) <= Ball_X_Min )  // Ball is at the Left edge, BOUNCE!
					    Ball_X_Motion <= Ball_X_Step;
					    
					else if( roml )  // Ball is at the left wall boundary!
			         begin
			               Ball_X_Motion <= Ball_X_Step;
//					       Ball_X_Motion <= 10'd0;
//					       Ball_Y_Motion <= 10'd0;
			         end
			          
			          else begin
                        Ball_X_Motion <= -10'd1; //change to be -10'd1
		                Ball_Y_Motion <= 10'd0; 
		              end
		           end		 
				 
//				 BallY <= (BallY + Ball_Y_Motion);  // Update ball position
//				 BallX <= (BallX + Ball_X_Motion);
				 
				 else if (keycode == 8'h07) begin //D - to go right
				    if ( (BallX + BallS) >= Ball_X_Max )  // Ball is at the Right edge, BOUNCE!
					  Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);
					
					else if( romr )  // Ball is at the left wall boundary!
			         begin
			               Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);
//					       Ball_X_Motion <= 10'd0;
//					       Ball_Y_Motion <= 10'd0;
			         end
					
					else begin
                        Ball_X_Motion <= 10'd1; //change to be -10'd1
				        Ball_Y_Motion <= 10'd0; 
				     end
				 end
				 
				 else begin
                        Ball_Y_Motion <= Ball_Y_Motion;
				        Ball_X_Motion <= Ball_X_Motion;  
//				        Ball_Y_Motion <= 10'd0;
//				        Ball_X_Motion <= 10'd0; 
				     end 
				 BallY <= (BallY + Ball_Y_Motion);  // Update ball position
				 BallX <= (BallX + Ball_X_Motion);
			
		end  
    end
      
endmodule
