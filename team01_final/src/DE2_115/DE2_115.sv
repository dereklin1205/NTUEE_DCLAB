module DE2_115 (
	input CLOCK_50,
	input CLOCK2_50,
	input CLOCK3_50,
	input ENETCLK_25,
	input SMA_CLKIN,
	output SMA_CLKOUT,
	output [8:0] LEDG,
	output [17:0] LEDR,
	input [3:0] KEY,
	input [17:0] SW,
	output [6:0] HEX0,
	output [6:0] HEX1,
	output [6:0] HEX2,
	output [6:0] HEX3,
	output [6:0] HEX4,
	output [6:0] HEX5,
	output [6:0] HEX6,
	output [6:0] HEX7,
	output LCD_BLON,
	inout [7:0] LCD_DATA,
	output LCD_EN,
	output LCD_ON,
	output LCD_RS,
	output LCD_RW,
	output UART_CTS,
	input UART_RTS,
	input UART_RXD,
	output UART_TXD,
	inout PS2_CLK,
	inout PS2_DAT,
	inout PS2_CLK2,
	inout PS2_DAT2,
	output SD_CLK,
	inout SD_CMD,
	inout [3:0] SD_DAT,
	input SD_WP_N,
	output [7:0] VGA_B,
	output VGA_BLANK_N,
	output VGA_CLK,
	output [7:0] VGA_G,
	output VGA_HS,
	output [7:0] VGA_R,
	output VGA_SYNC_N,
	output VGA_VS,
	input AUD_ADCDAT,
	inout AUD_ADCLRCK,
	inout AUD_BCLK,
	output AUD_DACDAT,
	inout AUD_DACLRCK,
	output AUD_XCK,
	output EEP_I2C_SCLK,
	inout EEP_I2C_SDAT,
	output I2C_SCLK,
	inout I2C_SDAT,
	output ENET0_GTX_CLK,
	input ENET0_INT_N,
	output ENET0_MDC,
	input ENET0_MDIO,
	output ENET0_RST_N,
	input ENET0_RX_CLK,
	input ENET0_RX_COL,
	input ENET0_RX_CRS,
	input [3:0] ENET0_RX_DATA,
	input ENET0_RX_DV,
	input ENET0_RX_ER,
	input ENET0_TX_CLK,
	output [3:0] ENET0_TX_DATA,
	output ENET0_TX_EN,
	output ENET0_TX_ER,
	input ENET0_LINK100,
	output ENET1_GTX_CLK,
	input ENET1_INT_N,
	output ENET1_MDC,
	input ENET1_MDIO,
	output ENET1_RST_N,
	input ENET1_RX_CLK,
	input ENET1_RX_COL,
	input ENET1_RX_CRS,
	input [3:0] ENET1_RX_DATA,
	input ENET1_RX_DV,
	input ENET1_RX_ER,
	input ENET1_TX_CLK,
	output [3:0] ENET1_TX_DATA,
	output ENET1_TX_EN,
	output ENET1_TX_ER,
	input ENET1_LINK100,
	input TD_CLK27,
	input [7:0] TD_DATA,
	input TD_HS,
	output TD_RESET_N,
	input TD_VS,
	inout [15:0] OTG_DATA,
	output [1:0] OTG_ADDR,
	output OTG_CS_N,
	output OTG_WR_N,
	output OTG_RD_N,
	input OTG_INT,
	output OTG_RST_N,
	input IRDA_RXD,
	output [12:0] DRAM_ADDR,
	output [1:0] DRAM_BA,
	output DRAM_CAS_N,
	output DRAM_CKE,
	output DRAM_CLK,
	output DRAM_CS_N,
	inout [31:0] DRAM_DQ,
	output [3:0] DRAM_DQM,
	output DRAM_RAS_N,
	output DRAM_WE_N,
	output [19:0] SRAM_ADDR,
	output SRAM_CE_N,
	inout [15:0] SRAM_DQ,
	output SRAM_LB_N,
	output SRAM_OE_N,
	output SRAM_UB_N,
	output SRAM_WE_N,
	output [22:0] FL_ADDR,
	output FL_CE_N,
	inout [7:0] FL_DQ,
	output FL_OE_N,
	output FL_RST_N,
	input FL_RY,
	output FL_WE_N,
	output FL_WP_N,
	inout [35:0] GPIO,
	input HSMC_CLKIN_P1,
	input HSMC_CLKIN_P2,
	input HSMC_CLKIN0,
	output HSMC_CLKOUT_P1,
	output HSMC_CLKOUT_P2,
	output HSMC_CLKOUT0,
	inout [3:0] HSMC_D,
	input [16:0] HSMC_RX_D_P,
	output [16:0] HSMC_TX_D_P,
	inout [6:0] EX_IO
);

logic key1down, key3down;
logic [6:0] GPIO_control;
logic [3:0] move, input_move;

assign GPIO[7] = GPIO_control[6];

assign GPIO[0] = GPIO_control[0];
assign GPIO[10] = !GPIO_control[0];
assign GPIO[1] = GPIO_control[1];
assign GPIO[11] =!GPIO_control[1];
assign GPIO[2] = GPIO_control[2];
assign GPIO[12] = !GPIO_control[2];
assign GPIO[3] = GPIO_control[3];
assign GPIO[13] = !GPIO_control[3];
assign GPIO[4] = GPIO_control[4];
assign GPIO[14] = !GPIO_control[4];
assign GPIO[5] = GPIO_control[5];
assign GPIO[15] = !GPIO_control[5];

assign LEDR[17:14] = input_move;


Altpll pll0( // generate with qsys, please follow lab2 tutorials
	.clk_clk(CLOCK_50),
	.reset_reset_n(key3down),
	.altpll_12m_clk(CLK_12M),
	.altpll_100k_clk(CLK_100K),
	.altpll_2k_clk(CLK_2K)
);


// generate start signal
Debounce deb0(
	.i_in(KEY[1]),
	.i_rst_n(KEY[0]),
	.i_clk(CLK_2K),
	.o_neg(key1down)
);
Debounce deb1(
	.i_in(KEY[3]),
	.i_rst_n(KEY[0]),
	.i_clk(CLK_2K),
	.o_neg(key3down)
);
Debounce deb2(
	.i_in(KEY[2]),
	.i_rst_n(KEY[0]),
	.i_clk(CLK_2K),
	.o_neg(key2down)
);

Top Top (
    .i_clk_12m(CLK_12M),
	.i_clk_2k(CLK_2K),
    .i_clk_100k(CLK_100K),
    .i_rst_n(KEY[0]), //key[0]
    .i_start(key1down), //key[1]
	.i_start_s(key3down), //key[3]
	.i_finish_load(key2down),

	.i_input_move(input_move),
    //sensor
	.LS_1_sdat(GPIO[18]),
    .LS_2_sdat(GPIO[20]),
    .LS_1_sclk(GPIO[22]),
    .LS_2_sclk(GPIO[24]),

	//LED state display for debugging
	.o_top_state(LEDR[4:0]),

    //motor
    .M_1_en(GPIO_control[0]), // GPIO[0]// maybe we can integrate step and dir as a pin and control merely by en
    .M_2_en(GPIO_control[1]),// GPIO[1]
    .M_3_en(GPIO_control[2]),// GPIO[2]
    .M_4_en(GPIO_control[3]),// GPIO[3]
    .M_5_en(GPIO_control[4]),// GPIO[4]
    .M_6_en(GPIO_control[5]),// GPIO[5]
    .M_step(GPIO[6]),// GPIO[6]
    .M_dir(GPIO_control[6]),// GPIO[7]
	.M_ms(GPIO[8]),

	.current_move(move)

	
);


SevenHexDecoder seven_dec0(
	.i_hex(move),
	.o_seven_1(HEX1),
	.o_seven_2(HEX2),
	.o_seven_3(HEX3)
);

assign HEX0 = '1;
assign HEX4 = '1;
assign HEX5 = '1;
assign HEX6 = '1;
assign HEX7 = '1;

ps2_keyboard_driver ps(
	.clk(CLOCK_50),
	.rst_n(KEY[0]),
	.ps2k_clk(PS2_CLK),
	.ps2k_data(PS2_DAT),


	.ps2_state(),
	.sm_bit(),
	.sm_seg(input_move)
);

endmodule
