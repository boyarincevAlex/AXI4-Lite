`timescale 1 ns / 1 ps
module Master_AXI4Lite #
	(
	parameter integer C_M_AXI_DATA_WIDTH	= 32,
    parameter integer C_M_AXI_ADDR_WIDTH    = 4
    )
    (	
input wire M_AXI_ACLK,
input wire M_AXI_ARESETN,
// Запись адреса 
output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_AWADDR,
output wire [2 : 0] M_AXI_AWPROT,
output wire M_AXI_AWVALID,
input wire M_AXI_AWREADY,
//Запись данных
output wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_WDATA,
output wire M_AXI_WVALID,
input wire M_AXI_WREADY,
//Отклик записи данных
input wire [1 : 0] M_AXI_BRESP,
input wire M_AXI_BVALID,
output wire M_AXI_BREADY,
//Чтение адреса
output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_ARADDR,
output wire [2 : 0] M_AXI_ARPROT,
output wire M_AXI_ARVALID,
input wire M_AXI_ARREADY,
//Чтение данных
input wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_RDATA,
input wire [1 : 0] M_AXI_RRESP,
input wire M_AXI_RVALID,
output wire M_AXI_RREADY,

output wire [C_M_AXI_DATA_WIDTH-1 : 0] wdata_out
);

reg [C_M_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
reg axi_awvalid;

reg [C_M_AXI_DATA_WIDTH-1 : 0] axi_wdata;

reg axi_wvalid;

reg axi_bready;

reg [C_M_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
reg axi_arvalid;
reg axi_rready;

assign M_AXI_AWVALID = axi_awvalid;
assign M_AXI_WDATA = axi_wdata;
assign M_AXI_WVALID = axi_wvalid;
assign M_AXI_BREADY	= axi_bready;
assign M_AXI_ARVALID = axi_arvalid;
assign M_AXI_RREADY	= axi_rready;
 
//Описание AWVALID
always @( posedge M_AXI_ACLK )
	begin
	  if ( M_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awvalid <= 1'b0;
	    end 
	  else 
	    begin 
	      if (M_AXI_AWADDR)
	      axi_awvalid <= 1'b1;
	      else if (~M_AXI_AWADDR)
	           begin
	           axi_awvalid <= 1'b0;
	           end
        end 
	 end  
	     
//Описание AWADDR
always @( posedge M_AXI_ACLK )
	begin
	if ( M_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awaddr <= 0;
	    end 
    else 
        begin
          axi_awaddr <= M_AXI_AWADDR;
        end
    end

//Описание WDATA
always @( posedge M_AXI_ACLK )
	begin
	if ( M_AXI_ARESETN == 1'b0 )
	    begin
	      axi_wdata <= 0;
	    end 
    else 
        begin
         if (~M_AXI_AWREADY)
          axi_wdata <= wdata_out;
         else 
            axi_wdata <= 0;
        end
    end
    
//Описание WVALID    
always @( posedge M_AXI_ACLK )
	begin
	  if ( M_AXI_ARESETN == 1'b0 )
	    begin
	      axi_wvalid <= 1'b0;
	    end 
	  else 
	    begin 
	      if (M_AXI_WDATA)
	               axi_wvalid <= 1'b1;
	      else 
	        if (~M_AXI_WDATA)
	           begin
	               axi_wvalid <= 1'b0;
	           end
        end 
	 end   
//Описание BREADY
always @( posedge M_AXI_ACLK )
	begin
	  if ( M_AXI_ARESETN == 1'b0 )
	    begin
	      axi_bready <= 1'b0;
	    end 
	  else
	    begin    
	      if (M_AXI_BVALID)
	        begin
	          axi_bready <= 1'b1;
	        end
	      else           
	        begin
	          axi_bready <= 1'b0;
	        end
	    end 
	end
//Описание ARVALID
always @( posedge M_AXI_ACLK )
	begin
	  if ( M_AXI_ARESETN == 1'b0 )
	    begin
	      axi_arvalid <= 0;
	    end 
	  else 
	    begin 
	        if (M_AXI_ARADDR)
	          axi_arvalid <= 1'b1;
	      else
	        begin
	          axi_arvalid <= 1'b0;
	        end
        end 
	 end  
	     
//Описание ARADDR
always @( posedge M_AXI_ACLK )
	begin
	if ( M_AXI_ARESETN == 1'b0 )
	    begin
	      axi_araddr <= 0;
	    end 
    else 
        begin
          axi_araddr <= M_AXI_ARADDR;
        end
    end

//Описание RREADY
always @( posedge M_AXI_ACLK )
	begin
	  if ( M_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rready <= 1'b0;
	    end 
	  else
	    begin    
	      if (M_AXI_RVALID)
	        begin
	          axi_rready <= 1'b1;
	        end
	      else           
	        begin
	          axi_rready <= 1'b0;
	        end
	    end 
	end
   
endmodule

