`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

module testbench_read #

(		parameter integer C_M_AXI_DATA_WIDTH	= 32,
		parameter integer C_M_AXI_ADDR_WIDTH	= 4,
		parameter integer C_S_AXI_DATA_WIDTH	= 32,
        parameter integer C_S_AXI_ADDR_WIDTH    = 4,
		parameter integer address = 12
)
(
input wire aclk,
input wire aresetn,
input wire [2 : 0] arprot,
output wire [C_M_AXI_ADDR_WIDTH-1 : 0] araddr,
output wire arvalid,
input wire arready,
input wire [C_M_AXI_DATA_WIDTH-1 : 0] rdata,
input wire [1 : 0] rresp,
input wire rvalid,
output wire rready,
output wire [C_M_AXI_DATA_WIDTH-1 : 0] rdata_out,
output wire [C_M_AXI_DATA_WIDTH-1 : 0] data,

input wire  s_aclk,
input wire  s_aresetn,
input wire [C_S_AXI_ADDR_WIDTH-1 : 0] s_araddr,
input wire [2 : 0] s_arprot,
input wire  s_arvalid,
output wire  s_arready,
output wire [C_S_AXI_DATA_WIDTH-1 : 0] s_rdata,
output wire [1 : 0] s_rresp,
output wire  s_rvalid,
input wire  s_rready
);

master_file #(
	.C_M_AXI_DATA_WIDTH(C_M_AXI_DATA_WIDTH),
	.C_M_AXI_ADDR_WIDTH(C_M_AXI_ADDR_WIDTH),
	.address(address)
	) master_file_test
	(
    .m_aclk(aclk), 
    .m_aresetn(aresetn), 
    .m_araddr(araddr),
    .m_arprot(arprot),
    .m_arvalid(arvalid),
    .m_arready(arready),
    .m_rdata(rdata),
    .m_rresp(rresp),
    .m_rvalid(rvalid),
    .m_rready(rready)
    );
    
 slave_file #(
        .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
        .C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH)
        ) slave_file_test
        (
        .s_aclk(s_aclk), 
        .s_aresetn(s_aresetn), 
        .s_araddr(s_araddr),
        .s_arprot(s_arprot),
        .s_arvalid(s_arvalid),
        .s_arready(s_arready),
        .s_rdata(s_rdata),
        .s_rresp(s_rresp),
        .s_rvalid(s_rvalid),
        .s_rready(s_rready),
        .rdata_out(rdata_out),
        .data(data)    
        );

//Связывание Master и Slave
assign s_aclk = aclk; 
assign s_aresetn = aresetn; 
assign s_araddr = araddr;
assign s_arprot = arprot;
assign s_arvalid = arvalid;
assign arready = s_arready;
assign rdata = s_rdata;
assign rresp = s_rresp;
assign rvalid = s_rvalid;
assign s_rready = rready;   
//Задание вспомогательных регистров для теста
reg aclk_test;
reg aresetn_test;
reg [C_M_AXI_ADDR_WIDTH-1 : 0] araddr_test;
reg [C_M_AXI_DATA_WIDTH-1 : 0] rdata_out_test;
reg [2:0] arprot_test = 0;

assign aclk = aclk_test;
assign araddr = araddr_test;
assign aresetn = aresetn_test;
assign rdata_out = rdata_out_test;
assign arprot = arprot_test;

always #10 aclk_test = ~aclk_test;
initial 
    begin
        aclk_test = 0;
        aresetn_test = 0;
        rdata_out_test = 0;
        araddr_test = 0;
        #100 aresetn_test = 1;      //Включение ARESETN
        #50 araddr_test = address;  //Выставление на шину адреса 
        #100 araddr_test = 0;
        #50  rdata_out_test = data; //Выставление на шину данных
        #100 rdata_out_test = 0;
    end                     
endmodule