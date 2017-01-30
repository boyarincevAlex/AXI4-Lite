`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

module master_file #

(		parameter integer C_M_AXI_DATA_WIDTH	= 32,
		parameter integer C_M_AXI_ADDR_WIDTH	= 4

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
//Чтение адреса
output wire [C_M_AXI_ADDR_WIDTH-1 : 0] araddr,
input wire [2 : 0] arprot,
output wire arvalid,
input wire arready,
//Чтение данных
input wire [C_M_AXI_DATA_WIDTH-1 : 0] rdata,
input wire [1 : 0] rresp,
input wire rvalid,
output wire rready
);

Master_AXI4Lite #(
	.C_M_AXI_DATA_WIDTH(C_M_AXI_DATA_WIDTH),
	.C_M_AXI_ADDR_WIDTH(C_M_AXI_ADDR_WIDTH)
	) Master_AXI4Lite_file
	(
    .M_AXI_ACLK(aclk), 
    .M_AXI_ARESETN(aresetn), 
    .M_AXI_AWADDR(awaddr),
    .M_AXI_AWVALID(awvalid),
    .M_AXI_AWPROT(awprot),
    .M_AXI_AWREADY(awready),
    .M_AXI_WDATA(wdata),
    .M_AXI_WVALID(wvalid),
    .M_AXI_WREADY(wready),
    .M_AXI_BRESP(bresp),
    .M_AXI_BVALID(bvalid),
    .M_AXI_BREADY(bready),
    .M_AXI_ARADDR(araddr),
    .M_AXI_ARPROT(arprot),
    .M_AXI_ARVALID(arvalid),
    .M_AXI_ARREADY(arready),
    .M_AXI_RDATA(rdata),
    .M_AXI_RRESP(rresp),
    .M_AXI_RVALID(rvalid),
    .M_AXI_RREADY(rready)
    );                   
endmodule