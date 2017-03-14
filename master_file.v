`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

module master_file #

(		parameter integer C_M_AXI_DATA_WIDTH	= 32,
		parameter integer C_M_AXI_ADDR_WIDTH	= 4,
		parameter integer address = 13

)
(
input wire m_aclk,
input wire m_aresetn,
// Запись адреса (issued by master, acceped by Slave)
output wire [C_M_AXI_ADDR_WIDTH-1 : 0] m_awaddr,
output wire [2 : 0] m_awprot,
output wire m_awvalid,
input wire m_awready,
//Запись данных
output wire [C_M_AXI_DATA_WIDTH-1 : 0] m_wdata,
output wire m_wvalid,
input wire m_wready,
//Отклик записи данных
input wire [1 : 0] m_bresp,
input wire m_bvalid,
output wire m_bready,
//Чтение адреса
output wire [C_M_AXI_ADDR_WIDTH-1 : 0] m_araddr,
output wire [2 : 0] m_arprot,
output wire m_arvalid,
input wire m_arready,
//Чтение данных
input wire [C_M_AXI_DATA_WIDTH-1 : 0] m_rdata,
input wire [1 : 0] m_rresp,
input wire m_rvalid,
output wire m_rready,
output wire [C_M_AXI_DATA_WIDTH-1 : 0] wdata_out,
output wire [C_M_AXI_DATA_WIDTH-1 : 0] data
);

Master_AXI4Lite #(
	.C_M_AXI_DATA_WIDTH(C_M_AXI_DATA_WIDTH),
	.C_M_AXI_ADDR_WIDTH(C_M_AXI_ADDR_WIDTH)
	) Master_AXI4Lite_file
	(
    .M_AXI_ACLK(m_aclk), 
    .M_AXI_ARESETN(m_aresetn), 
    .M_AXI_AWADDR(m_awaddr),
    .M_AXI_AWVALID(m_awvalid),
    .M_AXI_AWPROT(m_awprot),
    .M_AXI_AWREADY(m_awready),
    .M_AXI_WDATA(m_wdata),
    .M_AXI_WVALID(m_wvalid),
    .M_AXI_WREADY(m_wready),
    .M_AXI_BRESP(m_bresp),
    .M_AXI_BVALID(m_bvalid),
    .M_AXI_BREADY(m_bready),
    .M_AXI_ARADDR(m_araddr),
    .M_AXI_ARPROT(m_arprot),
    .M_AXI_ARVALID(m_arvalid),
    .M_AXI_ARREADY(m_arready),
    .M_AXI_RDATA(m_rdata),
    .M_AXI_RRESP(m_rresp),
    .M_AXI_RVALID(m_rvalid),
    .M_AXI_RREADY(m_rready),
    .wdata_out(wdata_out)
    );

reg [C_M_AXI_ADDR_WIDTH-1 : 0] reg_waddr_out;
reg [C_M_AXI_ADDR_WIDTH-1 : 0] reg_raddr_out;
reg [C_M_AXI_DATA_WIDTH-1 : 0] master_reg [16 : 1];

initial
    begin: d
        integer i;
        for (i=1; i< 17; i=i+1)
            master_reg[i]=i+i;
    end

assign data = master_reg[address];
   
always @(posedge m_rready)
        begin
            master_reg[address] <= m_rdata;
        end
              
endmodule