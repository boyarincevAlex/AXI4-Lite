`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

module testbench_write #

(		parameter integer C_M_AXI_DATA_WIDTH	= 32,
		parameter integer C_M_AXI_ADDR_WIDTH	= 4,
		parameter integer C_S_AXI_DATA_WIDTH	= 32,
        parameter integer C_S_AXI_ADDR_WIDTH    = 4,
		parameter integer address = 13
)
(
input wire aclk,
input wire aresetn,
// Запись адреса (issued by master, acceped by Slave)
output wire [C_M_AXI_ADDR_WIDTH-1 : 0] awaddr,
input wire [2 : 0] awprot,
output wire awvalid,
input wire awready,
//Запись данных
output wire [C_M_AXI_DATA_WIDTH-1 : 0] wdata,
output wire wvalid,
input wire wready,
//Отклик записи данных
input wire [1 : 0] bresp,
input wire bvalid,
output wire bready,

output wire [C_M_AXI_DATA_WIDTH-1 : 0] wdata_out,
output wire [C_M_AXI_DATA_WIDTH-1 : 0] data,
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
input wire  s_bready
);

master_file #(
	.C_M_AXI_DATA_WIDTH(C_M_AXI_DATA_WIDTH),
	.C_M_AXI_ADDR_WIDTH(C_M_AXI_ADDR_WIDTH),
	.address(address)
	) master_file_test
	(
    .m_aclk(aclk), 
    .m_aresetn(aresetn), 
    .m_awaddr(awaddr),
    .m_awvalid(awvalid),
    .m_awprot(awprot),
    .m_awready(awready),
    .m_wdata(wdata),
    .m_wvalid(wvalid),
    .m_wready(wready),
    .m_bresp(bresp),
    .m_bvalid(bvalid),
    .m_bready(bready),
    .wdata_out(wdata_out),
    .data(data)
    );
    
 slave_file #(
     .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
     .C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH)
      ) slave_file_test
      (
     .s_aclk(s_aclk), 
     .s_aresetn(s_aresetn), 
     .s_awaddr(s_awaddr),
     .s_awvalid(s_awvalid),
     .s_awprot(s_awprot),
     .s_awready(s_awready),
     .s_wdata(s_wdata),
     .s_wvalid(s_wvalid),
     .s_wready(s_wready),
     .s_bresp(s_bresp),
     .s_bvalid(s_bvalid),
     .s_bready(s_bready)   
      );

assign s_aclk = aclk; 
assign s_aresetn = aresetn; 
assign s_awaddr = awaddr;
assign s_awvalid = awvalid;
assign s_awprot = awprot;
assign  awready = s_awready;
assign s_wdata = wdata;
assign s_wvalid = wvalid;
assign wready = s_wready;
assign bresp = s_bresp;
assign bvalid = s_bvalid;
assign s_bready = bready;

reg aclk_test;
reg aresetn_test;
reg [C_M_AXI_ADDR_WIDTH-1 : 0] awaddr_test;
reg [C_M_AXI_DATA_WIDTH-1 : 0] reg_wdata;
reg [1:0] bresp_test;
reg [2:0] awprot_test = 0;

assign aclk = aclk_test;
assign awprot = awprot_test;
assign awaddr = awaddr_test;
assign aresetn = aresetn_test;
assign wdata_out = reg_wdata;
assign s_bresp = bresp_test;

always #10 aclk_test = ~aclk_test;
initial 
    begin
        bresp_test = 2'bZ;
        aclk_test = 0;
        aresetn_test = 0;
        reg_wdata = 0;
        awaddr_test = 0;
        #100 aresetn_test = 1;
        #50 awaddr_test = address;
        #100 awaddr_test = 0;
        #50  reg_wdata = data;
        #100 reg_wdata = 0;
        #50  bresp_test = 0;
        #50  bresp_test = 2'bZ;
    end                     
endmodule