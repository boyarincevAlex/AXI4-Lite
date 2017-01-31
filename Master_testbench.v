`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

module master_testbench #

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

master_file #(
	.C_M_AXI_DATA_WIDTH(C_M_AXI_DATA_WIDTH),
	.C_M_AXI_ADDR_WIDTH(C_M_AXI_ADDR_WIDTH)
	) Master_test
	(
    .aclk(aclk), 
    .aresetn(aresetn), 
    .awaddr(awaddr),
    .awvalid(awvalid),
    .awprot(awprot),
    .awready(awready),
    .wdata(wdata),
    .wvalid(wvalid),
    .wready(wready),
    .bresp(bresp),
    .bvalid(bvalid),
    .bready(bready),
    .araddr(araddr),
    .arprot(arprot),
    .arvalid(arvalid),
    .arready(arready),
    .rdata(rdata),
    .rresp(rresp),
    .rvalid(rvalid),
    .rready(rready)
    );                   
endmodule