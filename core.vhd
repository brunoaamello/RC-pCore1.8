library ieee;
use ieee.std_logic_1164.all;
use work.base_components.all;
use work.primitives.all;
use work.basic_types.all;

entity core is 
		port(	
				signal clk: in std_logic;
				signal rst: in std_logic;
				
				signal pmem_addr: out std_logic_vector(15 downto 0);
				signal pmem_data_in: out std_logic_vector(7 downto 0);
				signal pmem_wr: out std_logic;
				signal pmem_rd: out std_logic;
				signal pmem_data_out: in std_logic_vector(15 downto 0);
				
				signal dmem_addr: out std_logic_vector(15 downto 0);
				signal dmem_data_in: out std_logic_vector(7 downto 0);
				signal dmem_wr: out std_logic;
				signal dmem_rd: out std_logic;
				signal dmem_data_out: in std_logic_vector(7 downto 0)				
		);
end entity core;

architecture simple of core is
---- Control signals
	signal 	ALUop: std_logic_vector(3 downto 0);
	signal 	RET, BRANCH, MSB_SEL, RD_OP, RT, STD_IMM,
				IMM, WRimm, WR0, WR1, LW, SW, LWC, SWC, 
				JAL, C, LZ, EZ, GZ: std_logic;

---- Instruction Fetch signals
	signal 	IF_PC_RET, IF_PC, IF_PC_IN, IF_PC_OUT,
				IF_PC0, IF_PC1, IF_PC_OFFSET, PM_ADDR,
				IF_INSTR, IF_DATA, IF_PM_ADDR1: std_logic_vector(15 downto 0);
	signal 	PM_DATA_IN, PM_DATA_OUT: std_logic_vector(7 downto 0);
	signal 	IF_PC_WE, nIF_PC_WE, PM_WR, PM_RD: std_logic;
	
---- Instruction Decode signals
	signal 	ID_PC, INSTRUCTION: std_logic_vector(15 downto 0);
	signal 	ID_SE_IN: std_logic_vector(11 downto 0);
	signal 	RB_DATA, RB_A, RB_B, RB_DPH, WB0_DATA, WB1_DATA, ID_IMM, ID_IMM0, ID_IMM1, ID_B: std_logic_vector(7 downto 0);
	signal	RB_RA, RB_RB, RB_RD, ID_RD, ID_RD0, ID_RD1, ID_RB1, WB0_RD, WB1_RD: std_logic_vector(3 downto 0);
	signal	ID_MSB_VEC, ID_RD_MSB_VEC: std_logic_vector(0 downto 0);
	signal 	ID_MSB, ID_RD_MSB, ID_WR0, ID_WR1, RB_WR: std_logic;
	
	constant JAL_RD0: std_logic_vector(3 downto 0) := "1110";
	constant JAL_RD1: std_logic_vector(3 downto 0) := "1101";
	
---- Execute signals
	signal 	EX_DPH, EX_A, EX_B: std_logic_vector(7 downto 0);
	signal 	EX_RD0, EX_RD1, EX_ALUop: std_logic_vector(3 downto 0);
	signal	EX_WRimm, EX_WR0, EX_WR1, EX_LW, EX_SW, EX_LWC, EX_SWC, EX_JAL, EX_C: std_logic;
	
begin

---- Instruction Fetch

-- Program memory interface
	pmem_addr <= PM_ADDR;
	pmem_data_in <= PM_DATA_IN;
	pmem_wr <= PM_WR;
	pmem_rd <= PM_RD;
	IF_DATA <= pmem_data_out;
	
-- Load/Store logic for program memory
	nIF_PC_WE <= PM_RD nor PM_WR;
	IF_PC_WE <= not nIF_PC_WE;
	
-- PC input mux
PC_IN_MUX:
	mux_n1 generic map(n=>16) port map(sel=>RET, data_in0=>IF_PC, data_in1=>IF_PC_RET, data_out=>IF_PC_IN);
	
-- PC register
PC_REG:
	reg_nen generic map(n=>16) port map(D=>IF_PC_IN, clk_in=>clk, clk_en=>IF_PC_WE, clr=>rst, Q=>IF_PC_OUT);
	
-- PC +2 Adder
PLUS2_ADDER:
	adder_xn generic map(n=>16, x=>2) port map(a=>IF_PC_OUT, s=>IF_PC0, cout=>open);
	
-- PC offset Adder
PC_OFFSER_ADDER:
	adder_n generic map(n=>16) port map(a=>IF_PC_OFFSET, b=>IF_PC_OUT, cin=>IF_PC_OFFSET(15), s=>IF_PC1, cout=>open);
	
-- PC adder mux
PC_ADD_MUX:
	mux_n1 generic map(n=>16) port map(sel=>BRANCH, data_in0=>IF_PC0, data_in1=>IF_PC1, data_out=>IF_PC);
	
-- PM address mux
PM_ADDR_MUX:
	mux_n1 generic map(n=>16) port map(sel=>nIF_PC_WE, data_in0=>IF_PC_OUT, data_in1=>IF_PM_ADDR1, data_out=>IF_PC);
	
-- PM data mux
PM_DATA_MUX:
	mux_n1 generic map(n=>16) port map(sel=>nIF_PC_WE, data_in0=>IF_DATA, data_in1=>(others =>'0'), data_out=>IF_INSTR);
	
-- PM data out mux
PC_DATA_OUT_MUX:
	mux_n1 generic map(n=>8) port map(sel=>IF_PM_ADDR1(0), data_in0=>IF_DATA(7 downto 0), data_in1=>IF_DATA(15 downto 8), data_out=>PM_DATA_OUT);


---- IF/ID Registers

--	PC Register
IF_ID_PC_REG:
	reg_n generic map(n=>16) port map(D=>IF_PC, clk_in=>clk, clr=>rst, Q=>ID_PC);

-- Instruction register
IF_ID_INSTR_REG:
	reg_n generic map(n=>16) port map(D=>IF_INSTR, clk_in=>clk, clr=>rst, Q=>INSTRUCTION);


---- Instruction Decode

-- Control Unit
CONTROL_UNIT_DECL:
	control_unit port map(	opcode=>INSTRUCTION(15 downto 11), C=>C, GZ=>GZ, EZ=>EZ, LZ=>LZ, 
									RET=>RET, BRANCH=>BRANCH, MSB_SEL=>MSB_SEL, RD_OP=>RD_OP, RT=>RT,
									STD_IMM=>STD_IMM, IMM=>IMM, WRimm=>WRimm, WR0=>WR0, WR1=>WR1,
									LW=>LW, SW=>SW, LWC=>LWC, ALUop=>ALUop, JAL=>JAL);

-- Sign extender
	ID_SE_IN(11 downto 1) <= INSTRUCTION(10 downto 0);
	ID_SE_IN(0) <= '0';
SIGN_EXTENDER:
	sign_extend_nm generic map(n=>12, m=>16) port map(A=>ID_SE_IN, B=>IF_PC_OFFSET);
	
-- MSB register
MSB_REG:
	ff_d_cen port map(D=>INSTRUCTION(10), clk_in=>clk, clk_en=>INSTRUCTION(9), clr=>rst, Q=>ID_MSB);

--	MSB RD Mux
	ID_MSB_VEC(0) <= ID_MSB;
ID_MSB_RD_MUX:
	mux_n1 generic map(n=>1) port map(sel=>MSB_SEL, data_in0=>INSTRUCTION(3 downto 3), data_in1=>ID_MSB_VEC, data_out=>ID_RD_MSB_VEC);
	ID_RD_MSB <= ID_RD_MSB_VEC(0);

-- RD Signal
	ID_RD(2 downto 0) <= INSTRUCTION(2 downto 0);
	ID_RD(3) <= ID_RD_MSB;
	
-- RB1 MUX Signal
	ID_RB1(2 downto 0) <= INSTRUCTION(10 downto 8);
	ID_RB1(3) <= ID_MSB;
	
-- RA Mux
ID_RA_MUX:
	mux_n1 generic map(n=>4) port map(sel=>RD_OP, data_in0=>INSTRUCTION(7 downto 4), data_in1=>ID_RD, data_out=>RB_RA);

-- RB Mux
ID_RB_MUX:
	mux_n1 generic map(n=>4) port map(sel=>RT, data_in0=>INSTRUCTION(7 downto 4), data_in1=>ID_RB1, data_out=>RB_RB);
	
-- WR signal logic
	RB_WR <= ID_WR0 or ID_WR1;
	
-- RD Mux
ID_RD_MUX:
	mux_n1 generic map(n=>4) port map(sel=>ID_WR1, data_in0=>WB0_RD, data_in1=>WB1_RD, data_out=>RB_RD);
	
-- Register bank DATA Mux
ID_DATA_MUX:
	mux_n1 generic map(n=>8) port map(sel=>ID_WR1, data_in0=>WB0_DATA, data_in1=>WB1_DATA, data_out=>RB_DATA);
	
-- Register Bank
REG_BANK:
	register_bank port map(clk=>clk, ra=>RB_RA, rb=>RB_RB, wr=>RB_WR, rd=>RB_RD, wr_data=>RB_DATA, A=>RB_DATA, B=>RB_DATA, DPH=>RB_DPH);

-- IF_PC_RET Signal
	IF_PC_RET(15 downto 8) <= RB_A;
	IF_PC_RET(7 downto 0) <= RB_B;
	
-- Immediate shift Signal
	ID_IMM0(2 downto 0) <= INSTRUCTION(10 DOWNTO 8);
	ID_IMM0(7 downto 3) <= (others=>'0');
	
-- Immediate standard Signal
	ID_IMM1 <= INSTRUCTION(10 downto 3);
	
-- Immediate Mux
ID_IMM_MUX:
	mux_n1 generic map(n=>8) port map(sel=>STD_IMM, data_in0=>ID_IMM0, data_in1=>ID_IMM1, data_out=>ID_IMM);
	
-- B Mux
ID_B_MUX:
	mux_n1 generic map(n=>8) port map(sel=>IMM, data_in0=>RB_B, data_in1=>ID_IMM, data_out=>ID_B);
	
-- RD0 Mux
ID_RD0_MUX:
	mux_n1 generic map(n=>4) port map(sel=>JAL, data_in0=>ID_RD, data_in1=>JAL_RD0, data_out=>ID_RD0);
	
-- RD1 Mux
ID_RD1_MUX:
	mux_n1 generic map(n=>4) port map(sel=>JAL, data_in0=>ID_RD, data_in1=>JAL_RD1, data_out=>ID_RD1);
	
---- ID/EX Registers

-- DPH register
ID_EX_DPH_REG:
	reg_n generic map(n=>8) port map(D=>RB_DPH, clk_in=>clk, clr=>rst, Q=>EX_DPH);
	
-- A register
ID_EX_A_REG:
	reg_n generic map(n=>8) port map(D=>RB_A, clk_in=>clk, clr=>rst, Q=>EX_A);
	
-- B register
ID_EX_B_REG:
	reg_n generic map(n=>8) port map(D=>ID_B, clk_in=>clk, clr=>rst, Q=>EX_B);
	
-- RD0 register
ID_EX_RD0_REG:
	reg_n generic map(n=>4) port map(D=>ID_RD0, clk_in=>clk, clr=>rst, Q=>EX_RD0);

-- RD1 register
ID_EX_RD1_REG:
	reg_n generic map(n=>4) port map(D=>ID_RD1, clk_in=>clk, clr=>rst, Q=>EX_RD1);
	
-- ALUop register
ID_EX_ALUOP_REG:
	reg_n generic map(n=>4) port map(D=>ALUop, clk_in=>clk, clr=>rst, Q=>EX_ALUop);

-- WRimm register
ID_EX_WRIMM_REG:
	ff_d_c port map(D=>WRimm, clk_in=>clk, clr=>rst, Q=>EX_WRimm);
	
-- WR0 register
ID_EX_WR0_REG:
	ff_d_c port map(D=>WR0, clk_in=>clk, clr=>rst, Q=>EX_WR0);
	
-- WR1 register
ID_EX_WR1_REG:
	ff_d_c port map(D=>WR1, clk_in=>clk, clr=>rst, Q=>EX_WR1);
	
-- LW register
ID_EX_LW_REG:
	ff_d_c port map(D=>LW, clk_in=>clk, clr=>rst, Q=>EX_LW);
	
-- SW register
ID_EX_SW_REG:
	ff_d_c port map(D=>SW, clk_in=>clk, clr=>rst, Q=>EX_SW);
	
-- LWC register
ID_EX_LWC_REG:
	ff_d_c port map(D=>LWC, clk_in=>clk, clr=>rst, Q=>EX_LWC);
	
-- SWC register
ID_EX_SWC_REG:
	ff_d_c port map(D=>SWC, clk_in=>clk, clr=>rst, Q=>EX_SWC);
	
-- JAL register
ID_EX_JAL_REG:
	ff_d_c port map(D=>JAL, clk_in=>clk, clr=>rst, Q=>EX_JAL);

-- Carry register
ID_EX_C_REG:
	ff_d_c port map(D=>C, clk_in=>clk, clr=>rst, Q=>EX_C);
	
	
	
end architecture simple;
