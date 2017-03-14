`timescale 1 ns / 1 ps

	module slave_file #
	(			 
		// Do not modify the parameters beyond this line
		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S_AXI_DATA_WIDTH	= 32,
		parameter integer C_S_AXI_ADDR_WIDTH	= 4
	)
	(
		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s_aclk,
		input wire  s_aresetn,
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] s_awaddr,
		input wire [2 : 0] s_awprot,
		input wire  s_awvalid,
		output wire  s_awready,
		input wire [C_S_AXI_DATA_WIDTH-1 : 0] s_wdata,
		input wire  s_wvalid,
		output wire  s_wready,
		output wire [1 : 0] s_bresp,
		output wire  s_bvalid,
		input wire  s_bready,
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] s_araddr,
		input wire [2 : 0] s_arprot,
		input wire  s_arvalid,
		output wire  s_arready,
		output wire [C_S_AXI_DATA_WIDTH-1 : 0] s_rdata,
		output wire [1 : 0] s_rresp,
		output wire  s_rvalid,
		input wire  s_rready,
		output wire [C_S_AXI_DATA_WIDTH-1:0]rdata_out,
		output wire [C_S_AXI_DATA_WIDTH-1:0]data
	);
	
Slave_AXI4Lite # ( 
            .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
            .C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH)
        ) Slave_AXI4Lite_file (
            .S_AXI_ACLK(s_aclk),
            .S_AXI_ARESETN(s_aresetn),
            .S_AXI_AWADDR(s_awaddr),
            .S_AXI_AWPROT(s_awprot),
            .S_AXI_AWVALID(s_awvalid),
            .S_AXI_AWREADY(s_awready),
            .S_AXI_WDATA(s_wdata),
            .S_AXI_WVALID(s_wvalid),
            .S_AXI_WREADY(s_wready),
            .S_AXI_BRESP(s_bresp),
            .S_AXI_BVALID(s_bvalid),
            .S_AXI_BREADY(s_bready),
            .S_AXI_ARADDR(s_araddr),
            .S_AXI_ARPROT(s_arprot),
            .S_AXI_ARVALID(s_arvalid),
            .S_AXI_ARREADY(s_arready),
            .S_AXI_RDATA(s_rdata),
            .S_AXI_RRESP(s_rresp),
            .S_AXI_RVALID(s_rvalid),
            .S_AXI_RREADY(s_rready),
            .rdata_out(rdata_out)
        );

reg [C_S_AXI_ADDR_WIDTH-1 : 0] reg_waddr_in;
reg [C_S_AXI_ADDR_WIDTH-1 : 0] reg_raddr_in;
reg [C_S_AXI_DATA_WIDTH-1 : 0] slave_reg [16 : 1];

initial
    begin: d
        integer i;
        for (i=1; i< 17; i=i+1)
            slave_reg[i]=i;
    end

always @(posedge s_awready)
    begin
        reg_waddr_in <= s_awaddr;
    end
    
always @(posedge s_wready)
        begin
            slave_reg[reg_waddr_in] <= s_wdata;
        end

always @(posedge s_arready)
    begin
        reg_raddr_in <= s_araddr;
    end

assign data = slave_reg[reg_raddr_in];

endmodule
