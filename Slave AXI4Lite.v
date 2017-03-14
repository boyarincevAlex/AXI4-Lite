
`timescale 1 ns / 1 ps

module Slave_AXI4Lite #
	(
		parameter integer C_S_AXI_DATA_WIDTH	= 32,
		parameter integer C_S_AXI_ADDR_WIDTH	= 4
	)
	(
		input wire  S_AXI_ACLK,
		input wire  S_AXI_ARESETN,
		// Канал адреса записи 
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
		input wire [2 : 0] S_AXI_AWPROT,
		input wire  S_AXI_AWVALID,
		output wire  S_AXI_AWREADY,
		//Канал записи данных
		input wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
		input wire  S_AXI_WVALID,
		output wire  S_AXI_WREADY,
		//Канал отклика записи данных
		output wire [1 : 0] S_AXI_BRESP,
		output wire  S_AXI_BVALID,
		input wire  S_AXI_BREADY,
		//Канал адреса чтения
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
		input wire [2 : 0] S_AXI_ARPROT,
		input wire  S_AXI_ARVALID,
		output wire  S_AXI_ARREADY,
		//Канал чтения данных
		output wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
		output wire [1 : 0] S_AXI_RRESP,
		output wire  S_AXI_RVALID,
		input wire  S_AXI_RREADY,
		// Буфер данных чтения
		output wire [C_S_AXI_DATA_WIDTH-1:0]rdata_out
	);

	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
	reg  	axi_awready;
	reg  	axi_wready;
	reg [1 : 0] 	axi_bresp;
	reg  	axi_bvalid;
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
	reg  	axi_arready;
	reg [C_S_AXI_DATA_WIDTH-1 : 0] 	axi_rdata;
	reg [1 : 0] 	axi_rresp;
	reg  	axi_rvalid;

	assign S_AXI_AWREADY	= axi_awready;
	assign S_AXI_WREADY	= axi_wready;
	assign S_AXI_BRESP	= axi_bresp;
	assign S_AXI_BVALID	= axi_bvalid;
	assign S_AXI_ARREADY	= axi_arready;
	assign S_AXI_RDATA	= axi_rdata;
	assign S_AXI_RRESP	= axi_rresp;
	assign S_AXI_RVALID	= axi_rvalid;

//Описание AWREADY
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awready <= 1'b0;
	    end 
	  else
	    begin    
	      if (S_AXI_AWADDR < 16 && S_AXI_AWADDR > 0 && S_AXI_AWVALID)
	        begin 
	          axi_awready <= 1'b1;
	        end
	      else           
	        begin
	          axi_awready <= 1'b0;
	        end
	    end 
	end       
//Описание AWADDR
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awaddr <= 0;
	    end 
	  else
	        begin
	          axi_awaddr <= S_AXI_AWADDR;
	    end 
	end       
//Описание WREADY
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_wready <= 1'b0;
	    end 
	  else
	    begin    
	      if (S_AXI_WVALID && ~S_AXI_AWVALID)
	        begin
	          axi_wready <= 1'b1;
	        end
	      else
	        begin
	          axi_wready <= 1'b0;
	        end
	    end 
	end       
//Описание BVALID и BRESP
	always @( posedge S_AXI_ACLK)
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_bvalid  <= 0;
	      axi_bresp   <= 2'bZ;
	    end 
	  else
	    begin    
	      if (S_AXI_BRESP == 2'b0)
	        begin
	          axi_bvalid <= 1'b1;
	        end 
	      else
	          axi_bvalid <= 1'b0; 
	    end
	end   
//Описание ARREADY
always @( posedge S_AXI_ACLK )
    begin
      if ( S_AXI_ARESETN == 1'b0 )
         begin
            axi_arready <= 1'b0;
         end 
      else
         begin    
           if (S_AXI_ARADDR < 16 && S_AXI_ARADDR > 0)
             begin 
               axi_arready <= 1'b1;
             end
           else           
             begin
               axi_arready <= 1'b0;
             end
         end 
    end
 //Описание RVALID и RRESP
 always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rvalid <= 0;
	      axi_rresp <= 2'bZ;
	    end 
	else
	  begin    
	     if (S_AXI_RDATA)
	         begin
	            axi_rvalid <= 1'b1;
	            axi_rresp <= 2'b0;
	         end   
	     else 
         if (~S_AXI_RDATA)
             begin
                axi_rvalid <= 1'b0;
                axi_rresp <= 2'bZ;
	        end                
	    end
	end    
//Описание RDATA
always @( posedge S_AXI_ACLK )
    begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rdata  <= 0;
	    end 
	 else 
       begin
          if (~S_AXI_ARREADY)
             axi_rdata <= rdata_out;
          else 
             axi_rdata <= 0;
          end
      end
	      
endmodule
