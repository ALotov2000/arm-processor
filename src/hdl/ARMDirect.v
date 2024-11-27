// ============================================================================
// Copyright (c) 2012 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// ============================================================================
//           
//  Terasic Technologies Inc
//  9F., No.176, Sec.2, Gongdao 5th Rd, East Dist, Hsinchu City, 30070. Taiwan
//
//
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// ============================================================================
//
// Major Functions:	DE2 TOP LEVEL
//
// ============================================================================
//
// Revision History :
// ============================================================================
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| Johnny Chen       :| 05/08/19  :|      Initial Revision
//   V1.1 :| Johnny Chen       :| 05/11/16  :|      Added FLASH Address FL_ADDR[21:20]
//   V1.2 :| Johnny Chen       :| 05/11/16  :|		Fixed ISP1362 INT/DREQ Pin Direction.   
//   V1.3 :| Johnny Chen       :| 06/11/16  :|		Added the Dedicated TV Decoder Line-Locked-Clock Input
//													            for DE2 v2.X PCB.
//   V1.5 :| Eko    Yan        :| 12/01/30  :|      Update to version 11.1 sp1.
// ============================================================================

module ARM
	(
		////////////////////	Clock Input	 	////////////////////	 
		CLOCK_27,						//	27 MHz
		CLOCK_50,						//	50 MHz
		EXT_CLOCK,						//	External Clock
		////////////////////	Push Button		////////////////////
		KEY,							//	Pushbutton[3:0]
		////////////////////	DPDT Switch		////////////////////
		SW,								//	Toggle Switch[17:0]
		////////////////////	7-SEG Dispaly	////////////////////
		HEX0,							//	Seven Segment Digit 0
		HEX1,							//	Seven Segment Digit 1
		HEX2,							//	Seven Segment Digit 2
		HEX3,							//	Seven Segment Digit 3
		HEX4,							//	Seven Segment Digit 4
		HEX5,							//	Seven Segment Digit 5
		HEX6,							//	Seven Segment Digit 6
		HEX7,							//	Seven Segment Digit 7
		////////////////////////	LED		////////////////////////
		LEDG,							//	LED Green[8:0]
		LEDR,							//	LED Red[17:0]
		////////////////////////	UART	////////////////////////
		//UART_TXD,						//	UART Transmitter
		//UART_RXD,						//	UART Receiver
		////////////////////////	IRDA	////////////////////////
		//IRDA_TXD,						//	IRDA Transmitter
		//IRDA_RXD,						//	IRDA Receiver
		/////////////////////	SDRAM Interface		////////////////
		DRAM_DQ,						//	SDRAM Data bus 16 Bits
		DRAM_ADDR,						//	SDRAM Address bus 12 Bits
		DRAM_LDQM,						//	SDRAM Low-byte Data Mask 
		DRAM_UDQM,						//	SDRAM High-byte Data Mask
		DRAM_WE_N,						//	SDRAM Write Enable
		DRAM_CAS_N,						//	SDRAM Column Address Strobe
		DRAM_RAS_N,						//	SDRAM Row Address Strobe
		DRAM_CS_N,						//	SDRAM Chip Select
		DRAM_BA_0,						//	SDRAM Bank Address 0
		DRAM_BA_1,						//	SDRAM Bank Address 0
		DRAM_CLK,						//	SDRAM Clock
		DRAM_CKE,						//	SDRAM Clock Enable
		////////////////////	Flash Interface		////////////////
		FL_DQ,							//	FLASH Data bus 8 Bits
		FL_ADDR,						//	FLASH Address bus 22 Bits
		FL_WE_N,						//	FLASH Write Enable
		FL_RST_N,						//	FLASH Reset
		FL_OE_N,						//	FLASH Output Enable
		FL_CE_N,						//	FLASH Chip Enable
		////////////////////	SRAM Interface		////////////////
		SRAM_DQ,						//	SRAM Data bus 16 Bits
		SRAM_ADDR,						//	SRAM Address bus 18 Bits
		SRAM_UB_N,						//	SRAM High-byte Data Mask 
		SRAM_LB_N,						//	SRAM Low-byte Data Mask 
		SRAM_WE_N,						//	SRAM Write Enable
		SRAM_CE_N,						//	SRAM Chip Enable
		SRAM_OE_N,						//	SRAM Output Enable
		////////////////////	ISP1362 Interface	////////////////
		OTG_DATA,						//	ISP1362 Data bus 16 Bits
		OTG_ADDR,						//	ISP1362 Address 2 Bits
		OTG_CS_N,						//	ISP1362 Chip Select
		OTG_RD_N,						//	ISP1362 Write
		OTG_WR_N,						//	ISP1362 Read
		OTG_RST_N,						//	ISP1362 Reset
		OTG_FSPEED,						//	USB Full Speed,	0 = Enable, Z = Disable
		OTG_LSPEED,						//	USB Low Speed, 	0 = Enable, Z = Disable
		OTG_INT0,						//	ISP1362 Interrupt 0
		OTG_INT1,						//	ISP1362 Interrupt 1
		OTG_DREQ0,						//	ISP1362 DMA Request 0
		OTG_DREQ1,						//	ISP1362 DMA Request 1
		OTG_DACK0_N,					//	ISP1362 DMA Acknowledge 0
		OTG_DACK1_N,					//	ISP1362 DMA Acknowledge 1
		////////////////////	LCD Module 16X2		////////////////
		LCD_ON,							//	LCD Power ON/OFF
		LCD_BLON,						//	LCD Back Light ON/OFF
		LCD_RW,							//	LCD Read/Write Select, 0 = Write, 1 = Read
		LCD_EN,							//	LCD Enable
		LCD_RS,							//	LCD Command/Data Select, 0 = Command, 1 = Data
		LCD_DATA,						//	LCD Data bus 8 bits
		////////////////////	SD_Card Interface	////////////////
		//SD_DAT,							//	SD Card Data
		//SD_WP_N,						   //	SD Write protect 
		//SD_CMD,							//	SD Card Command Signal
		//SD_CLK,							//	SD Card Clock
		////////////////////	USB JTAG link	////////////////////
		TDI,  							// CPLD -> FPGA (data in)
		TCK,  							// CPLD -> FPGA (clk)
		TCS,  							// CPLD -> FPGA (CS)
	   TDO,  							// FPGA -> CPLD (data out)
		////////////////////	I2C		////////////////////////////
		I2C_SDAT,						//	I2C Data
		I2C_SCLK,						//	I2C Clock
		////////////////////	PS2		////////////////////////////
		PS2_DAT,						//	PS2 Data
		PS2_CLK,						//	PS2 Clock
		////////////////////	VGA		////////////////////////////
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,  						//	VGA Blue[9:0]
		////////////	Ethernet Interface	////////////////////////
		ENET_DATA,						//	DM9000A DATA bus 16Bits
		ENET_CMD,						//	DM9000A Command/Data Select, 0 = Command, 1 = Data
		ENET_CS_N,						//	DM9000A Chip Select
		ENET_WR_N,						//	DM9000A Write
		ENET_RD_N,						//	DM9000A Read
		ENET_RST_N,						//	DM9000A Reset
		ENET_INT,						//	DM9000A Interrupt
		ENET_CLK,						//	DM9000A Clock 25 MHz
		////////////////	Audio CODEC		////////////////////////
		AUD_ADCLRCK,					//	Audio CODEC ADC LR Clock
		AUD_ADCDAT,						//	Audio CODEC ADC Data
		AUD_DACLRCK,					//	Audio CODEC DAC LR Clock
		AUD_DACDAT,						//	Audio CODEC DAC Data
		AUD_BCLK,						//	Audio CODEC Bit-Stream Clock
		AUD_XCK,						//	Audio CODEC Chip Clock
		////////////////	TV Decoder		////////////////////////
		TD_DATA,    					//	TV Decoder Data bus 8 bits
		TD_HS,							//	TV Decoder H_SYNC
		TD_VS,							//	TV Decoder V_SYNC
		TD_RESET,						//	TV Decoder Reset
		TD_CLK27,                  //	TV Decoder 27MHz CLK
		////////////////////	GPIO	////////////////////////////
		GPIO_0,							//	GPIO Connection 0
		GPIO_1							//	GPIO Connection 1
	);

////////////////////////	Clock Input	 	////////////////////////
input		   	CLOCK_27;				//	27 MHz
input		   	CLOCK_50;				//	50 MHz
input			   EXT_CLOCK;				//	External Clock
////////////////////////	Push Button		////////////////////////
input	   [3:0]	KEY;					//	Pushbutton[3:0]
////////////////////////	DPDT Switch		////////////////////////
input	  [17:0]	SW;						//	Toggle Switch[17:0]
////////////////////////	7-SEG Dispaly	////////////////////////
output	[6:0]	HEX0;					//	Seven Segment Digit 0
output	[6:0]	HEX1;					//	Seven Segment Digit 1
output	[6:0]	HEX2;					//	Seven Segment Digit 2
output	[6:0]	HEX3;					//	Seven Segment Digit 3
output	[6:0]	HEX4;					//	Seven Segment Digit 4
output	[6:0]	HEX5;					//	Seven Segment Digit 5
output	[6:0]	HEX6;					//	Seven Segment Digit 6
output	[6:0]	HEX7;					//	Seven Segment Digit 7
////////////////////////////	LED		////////////////////////////
output	[8:0]	LEDG;					//	LED Green[8:0]
output  [17:0]	LEDR;					//	LED Red[17:0]
////////////////////////////	UART	////////////////////////////
//output			UART_TXD;				//	UART Transmitter
//input			   UART_RXD;				//	UART Receiver
////////////////////////////	IRDA	////////////////////////////
//output			IRDA_TXD;				//	IRDA Transmitter
//input			   IRDA_RXD;				//	IRDA Receiver
///////////////////////		SDRAM Interface	////////////////////////
inout	  [15:0]	DRAM_DQ;				//	SDRAM Data bus 16 Bits
output  [11:0]	DRAM_ADDR;				//	SDRAM Address bus 12 Bits
output			DRAM_LDQM;				//	SDRAM Low-byte Data Mask 
output			DRAM_UDQM;				//	SDRAM High-byte Data Mask
output			DRAM_WE_N;				//	SDRAM Write Enable
output			DRAM_CAS_N;				//	SDRAM Column Address Strobe
output			DRAM_RAS_N;				//	SDRAM Row Address Strobe
output			DRAM_CS_N;				//	SDRAM Chip Select
output			DRAM_BA_0;				//	SDRAM Bank Address 0
output			DRAM_BA_1;				//	SDRAM Bank Address 0
output			DRAM_CLK;				//	SDRAM Clock
output			DRAM_CKE;				//	SDRAM Clock Enable
////////////////////////	Flash Interface	////////////////////////
inout	  [7:0]	FL_DQ;					//	FLASH Data bus 8 Bits
output [21:0]	FL_ADDR;				//	FLASH Address bus 22 Bits
output			FL_WE_N;				//	FLASH Write Enable
output			FL_RST_N;				//	FLASH Reset
output			FL_OE_N;				//	FLASH Output Enable
output			FL_CE_N;				//	FLASH Chip Enable
////////////////////////	SRAM Interface	////////////////////////
inout	 [15:0]	SRAM_DQ;				//	SRAM Data bus 16 Bits
output [17:0]	SRAM_ADDR;				//	SRAM Address bus 18 Bits
output			SRAM_UB_N;				//	SRAM High-byte Data Mask 
output			SRAM_LB_N;				//	SRAM Low-byte Data Mask 
output			SRAM_WE_N;				//	SRAM Write Enable
output			SRAM_CE_N;				//	SRAM Chip Enable
output			SRAM_OE_N;				//	SRAM Output Enable
////////////////////	ISP1362 Interface	////////////////////////
inout	 [15:0]	OTG_DATA;				//	ISP1362 Data bus 16 Bits
output  [1:0]	OTG_ADDR;				//	ISP1362 Address 2 Bits
output			OTG_CS_N;				//	ISP1362 Chip Select
output			OTG_RD_N;				//	ISP1362 Write
output			OTG_WR_N;				//	ISP1362 Read
output			OTG_RST_N;				//	ISP1362 Reset
output			OTG_FSPEED;				//	USB Full Speed,	0 = Enable, Z = Disable
output			OTG_LSPEED;				//	USB Low Speed, 	0 = Enable, Z = Disable
input			   OTG_INT0;				//	ISP1362 Interrupt 0
input			   OTG_INT1;				//	ISP1362 Interrupt 1
input			   OTG_DREQ0;				//	ISP1362 DMA Request 0
input			   OTG_DREQ1;				//	ISP1362 DMA Request 1
output			OTG_DACK0_N;			//	ISP1362 DMA Acknowledge 0
output			OTG_DACK1_N;			//	ISP1362 DMA Acknowledge 1
////////////////////	LCD Module 16X2	////////////////////////////
inout	  [7:0]	LCD_DATA;				//	LCD Data bus 8 bits
output			LCD_ON;					//	LCD Power ON/OFF
output			LCD_BLON;				//	LCD Back Light ON/OFF
output			LCD_RW;					//	LCD Read/Write Select, 0 = Write, 1 = Read
output			LCD_EN;					//	LCD Enable
output			LCD_RS;					//	LCD Command/Data Select, 0 = Command, 1 = Data
////////////////////	SD Card Interface	////////////////////////
//inout	 [3:0]	SD_DAT;					//	SD Card Data
//input			   SD_WP_N;				   //	SD write protect
//inout			   SD_CMD;					//	SD Card Command Signal
//output			SD_CLK;					//	SD Card Clock
////////////////////////	I2C		////////////////////////////////
inout			   I2C_SDAT;				//	I2C Data
output			I2C_SCLK;				//	I2C Clock
////////////////////////	PS2		////////////////////////////////
input		 	   PS2_DAT;				//	PS2 Data
input			   PS2_CLK;				//	PS2 Clock
////////////////////	USB JTAG link	////////////////////////////
input  			TDI;					// CPLD -> FPGA (data in)
input  			TCK;					// CPLD -> FPGA (clk)
input  			TCS;					// CPLD -> FPGA (CS)
output 			TDO;					// FPGA -> CPLD (data out)
////////////////////////	VGA			////////////////////////////
output			VGA_CLK;   				//	VGA Clock
output			VGA_HS;					//	VGA H_SYNC
output			VGA_VS;					//	VGA V_SYNC
output			VGA_BLANK;				//	VGA BLANK
output			VGA_SYNC;				//	VGA SYNC
output	[9:0]	VGA_R;   				//	VGA Red[9:0]
output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
////////////////	Ethernet Interface	////////////////////////////
inout	[15:0]	ENET_DATA;				//	DM9000A DATA bus 16Bits
output			ENET_CMD;				//	DM9000A Command/Data Select, 0 = Command, 1 = Data
output			ENET_CS_N;				//	DM9000A Chip Select
output			ENET_WR_N;				//	DM9000A Write
output			ENET_RD_N;				//	DM9000A Read
output			ENET_RST_N;				//	DM9000A Reset
input			   ENET_INT;				//	DM9000A Interrupt
output			ENET_CLK;				//	DM9000A Clock 25 MHz
////////////////////	Audio CODEC		////////////////////////////
inout			   AUD_ADCLRCK;			//	Audio CODEC ADC LR Clock
input			   AUD_ADCDAT;				//	Audio CODEC ADC Data
inout			   AUD_DACLRCK;			//	Audio CODEC DAC LR Clock
output			AUD_DACDAT;				//	Audio CODEC DAC Data
inout			   AUD_BCLK;				//	Audio CODEC Bit-Stream Clock
output			AUD_XCK;				//	Audio CODEC Chip Clock
////////////////////	TV Devoder		////////////////////////////
input	 [7:0]	TD_DATA;    			//	TV Decoder Data bus 8 bits
input			   TD_HS;					//	TV Decoder H_SYNC
input			   TD_VS;					//	TV Decoder V_SYNC
output			TD_RESET;				//	TV Decoder Reset
input          TD_CLK27;            //	TV Decoder 27MHz CLK
////////////////////////	GPIO	////////////////////////////////
inout	[35:0]	GPIO_0;					//	GPIO Connection 0
inout	[35:0]	GPIO_1;					//	GPIO Connection 1

wire clk, rst;

assign clk = CLOCK_50;
assign rst = SW[0];


wire freeze, flush, hazard;
    wire twoSrc;
    wire [3:0] src1, src2;
    
    wire [31:0] pc_if, insturction_if;
    
    wire writeBackEnabled_id, memoryReadEnabled_id, memoryWriteEnabled_id;
    wire b_id, s_id;
    wire [3:0] executionCommand_id;
    wire [31:0] pc_id, insturction_id;
    wire [31:0] valRn_id, valRm_id;
    wire imm_id;
    wire [11:0] shiftOperand_id;
    wire [23:0] imm24_id;
    wire [3:0] destination_id;
    wire [3:0] status_id;
    
    wire writeBackEnabled_exe, memoryReadEnabled_exe, memoryWriteEnabled_exe;
    wire b_exe, s_exe;
    wire [3:0] executionCommand_exe;
    wire [31:0] pc_exe;
    wire [31:0] valRn_exe, valRm_exe;
    wire imm_exe;
    wire [11:0] shiftOperand_exe;
    wire [23:0] imm24_exe;
    wire [3:0] destination_exe;
    wire [3:0] status_exe;
    wire [31:0] aluResult_exe, branchAddress_exe;
    wire [3:0] statusOut_exe;
    
    wire writeBackEnabled_mem, memoryReadEnabled_mem, memoryWriteEnabled_mem;
    wire [31:0] aluResult_mem, valRm_mem;
    wire [3:0] destination_mem;
    wire [31:0] data_mem;
    
    wire writeBackEnabled_wb, memoryReadEnabled_wb;
    wire [31:0] aluResult_wb, data_wb, writeBackValue_wb;
    wire [3:0] destination_wb;
    
    wire [3:0] status_in, status;
    
    assign hazard = 1'b0; // todo: this will be changed when hazard block is added
    assign flush  = b_exe;
    assign freeze = hazard;
    
    InstructionFetchStage u_InstructionFetchStage(
    .clk          (clk),
    .rst          (rst),
    .freeze       (freeze),
    .Branch_taken (branchTaken_exe),
    .BranchAddr   (branchAddress_exe),
    .PC           (pc_if),
    .Instruction  (instruction_if),
    .flush        (flush)
    );
    
    InstructionFetchStageReg u_InstructionFetchStageReg(
    .clk             (clk),
    .rst             (rst),
    .freeze          (freeze),
    .flush           (flush),
    .PC_in           (pc_if),
    .Instruction_in  (insturction_if),
    .PC_out          (pc_id),
    .Instruction_out (instruction_id)
    );
    
    assign status_id = status;
    
    InstructionDecodeStage u_InstructionDecodeStage(
    .clk           (clk),
    .rst           (rst),
    .INSTRUCTION   (instruction_id),
    .RESULT_WB     (writeBackValue_wb),
    .WB_EN_IN      (writeBackEnabled_wb),
    .DEST_WB       (destination_wb),
    .HAZARD        (hazard),
    .SR            (status),
    .WB_EN         (writeBackEnabled_id),
    .MEM_R_EN      (memoryReadEnabled_id),
    .MEM_W_EN      (memoryWriteEnabled_id),
    .B             (b_id),
    .S             (s_id),
    .EXE_CMD       (executionCommand_id),
    .VAL_RN        (valRn_id),
    .VAL_RM        (valRm_id),
    .IMM           (imm),
    .SHIFT_OPERAND (shiftOperand_id),
    .SIGNED_IMM_24 (imm24_id),
    .DEST          (destination_id),
    .SRC1          (src1),
    .SRC2          (src2),
    .TWO_SRC       (twoSrc)
    );
    
    InstructionDecodeStageReg u_InstructionDecodeStageReg(
    .clk                   (clk),
    .rst                   (rst),
    .flush                 (flush),
    .writeBackEnabled_in   (writeBackEnabled_id),
    .memoryReadEnabled_in  (memoryReadEnabled_id),
    .memoryWriteEnabled_in (memoryWriteEnabled_id),
    .b_in                  (b_id),
    .s_in                  (s_id),
    .executionCommand_in   (executionCommand_id),
    .pc_in                 (pc_id),
    .valRn_in              (valRn_id),
    .valRm_in              (valRm_id),
    .imm_in                (imm_id),
    .shiftOperand_in       (shiftOperand_id),
    .imm24_in              (imm24_id),
    .destination_in        (destination_id),
    .status_in             (status_id),
    .writeBackEnabled      (writeBackEnabled_exe),
    .memoryReadEnabled     (memoryReadEnabled_exe),
    .memoryWriteEnabled    (memoryWriteEnabled_exe),
    .b                     (b_exe),
    .s                     (s_exe),
    .executionCommand      (executionCommand_exe),
    .pc                    (pc_exe),
    .valRn                 (valRn_exe),
    .valRm                 (valRm_exe),
    .imm                   (imm_exe),
    .shiftOperand          (shiftOperand_exe),
    .imm24                 (imm24_exe),
    .destination           (destination_exe),
    .status                (status_exe)
    );
    
    assign status_in = statusOut_exe;
    
    ExecutionStage u_ExecutionStage(
    .clk                (clk),
    .executionCommand   (executionCommand_exe),
    .memoryReadEnabled  (memoryReadEnabled_exe),
    .memoryWriteEnabled (memoryWriteEnabled_exe),
    .pc                 (pc_exe),
    .valRn              (valRn_exe),
    .valRm              (valRm_exe),
    .imm                (imm_exe),
    .shiftOperand       (shiftOperand_exe),
    .imm24              (imm24_exe),
    .status             (status_exe),
    .aluResult          (aluResult_exe),
    .branchAddress      (branchAddress_exe),
    .statusOut          (statusOut_exe)
    );
    
    ExecutionStageReg u_ExecutionStageReg(
    .clk                  (clk),
    .rst                  (rst),
    .writebackEnabledIn   (writebackEnabled_exe),
    .memoryReadEnabledIn  (memoryReadEnabled_exe),
    .memoryWriteEnabledIn (memoryWriteEnabled_exe),
    .aluResultIn          (aluResult_exe),
    .valRmIn              (valRm_exe),
    .destinationIn        (destination_exe),
    .writebackEnabled     (writebackEnabled_mem),
    .memoryReadEnabled    (memoryReadEnabled_mem),
    .memoryWriteEnabled   (memoryWriteEnabled_mem),
    .aluResult            (aluResult_mem),
    .valRm                (valRm_mem),
    .destination          (destination_mem)
    );
    
    MemoryStage u_MemoryStage(
    .clk                (clk),
    .rst                (rst),
    .memoryReadEnabled  (memoryReadEnabled_mem),
    .memoryWriteEnabled (memoryWriteEnabled_mem),
    .aluResult          (aluResult_mem),
    .valRm              (valRm_mem),
    .data               (data_mem)
    );
    
    MemoryStageReg u_MemoryStageReg(
    .clk                  (clk),
    .rst                  (rst),
    .destination_in       (destination_mem),
    .data_in              (data_mem),
    .aluResult_in         (aluResult_mem),
    .memoryReadEnabled_in (memoryReadEnabled_mem),
    .writeBackEnabled_in  (writeBackEnabled_mem),
    .destination          (destination_wb),
    .data                 (data_wb),
    .aluResult            (aluResult_wb),
    .memoryReadEnabled    (memoryReadEnabled_wb),
    .writeBackEnabled     (writeBackEnabled_wb)
    );
    
    WriteBackStage u_WriteBackStage(
    .clk               (clk),
    .rst               (rst),
    .data              (data_wb),
    .aluResult         (aluResult_wb),
    .memoryReadEnabled (memoryReadEnabled_wb),
    .writeBackValue    (writeBackValue_wb)
    );
    
    StatusRegister u_StatusRegister(
    .clk (clk),
    .rst (rst),
    .s   (s_exe),
    .in  (status_in),
    .out (status)
    );
    
    HazardControlUnit u_HazardControlUnit(
    .twoSrc               (twoSrc),
    .src1                 (src1),
    .src2                 (src2),
    .destination_exe      (destination_exe),
    .destination_mem      (destination_mem),
    .writeBackEnabled_exe (writeBackEnabled_exe),
    .writeBackEnabled_mem (writeBackEnabled_mem),
    .hazard               (hazard)
    );

endmodule