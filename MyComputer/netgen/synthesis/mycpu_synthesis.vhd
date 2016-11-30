--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: P.20131013
--  \   \         Application: netgen
--  /   /         Filename: mycpu_synthesis.vhd
-- /___/   /\     Timestamp: Wed Nov 30 19:25:25 2016
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -ar Structure -tm mycpu -w -dir netgen/synthesis -ofmt vhdl -sim mycpu.ngc mycpu_synthesis.vhd 
-- Device	: xc3s1200e-4-fg320
-- Input file	: mycpu.ngc
-- Output file	: C:\Users\HASEE\Desktop\yanjy\Computer\MyComputer\netgen\synthesis\mycpu_synthesis.vhd
-- # of Entities	: 1
-- Design Name	: mycpu
-- Xilinx	: F:\Xlinx\14.7\ISE_DS\ISE\
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Command Line Tools User Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use UNISIM.VPKG.ALL;

entity mycpu is
  port (
    rdn : inout STD_LOGIC; 
    wrn : inout STD_LOGIC; 
    clk : in STD_LOGIC := 'X'; 
    ram1We : out STD_LOGIC; 
    ram2We : out STD_LOGIC; 
    rst : in STD_LOGIC := 'X'; 
    hs : out STD_LOGIC; 
    tbre : in STD_LOGIC := 'X'; 
    ram1En : out STD_LOGIC; 
    tsre : in STD_LOGIC := 'X'; 
    vs : out STD_LOGIC; 
    ram2En : out STD_LOGIC; 
    ram1Oe : out STD_LOGIC; 
    dataReady : in STD_LOGIC := 'X'; 
    ram2Oe : out STD_LOGIC; 
    ram1Data : inout STD_LOGIC_VECTOR ( 15 downto 0 ); 
    ram2Data : inout STD_LOGIC_VECTOR ( 15 downto 0 ); 
    redOut : out STD_LOGIC_VECTOR ( 2 downto 0 ); 
    ram2Addr : out STD_LOGIC_VECTOR ( 17 downto 0 ); 
    digit1 : out STD_LOGIC_VECTOR ( 6 downto 0 ); 
    digit2 : out STD_LOGIC_VECTOR ( 6 downto 0 ); 
    blueOut : out STD_LOGIC_VECTOR ( 2 downto 0 ); 
    ram1Addr : out STD_LOGIC_VECTOR ( 17 downto 0 ); 
    greenOut : out STD_LOGIC_VECTOR ( 2 downto 0 ); 
    led : out STD_LOGIC_VECTOR ( 15 downto 0 ) 
  );
end mycpu;

architecture Structure of mycpu is
  signal clk_BUFGP_4 : STD_LOGIC; 
  signal digit1_0_OBUF_12 : STD_LOGIC; 
  signal digit1_1_OBUF_13 : STD_LOGIC; 
  signal digit1_2_OBUF_14 : STD_LOGIC; 
  signal digit1_3_OBUF_15 : STD_LOGIC; 
  signal digit1_4_OBUF_16 : STD_LOGIC; 
  signal digit1_5_OBUF_17 : STD_LOGIC; 
  signal digit1_6_OBUF_18 : STD_LOGIC; 
  signal digit2_0_OBUF_26 : STD_LOGIC; 
  signal digit2_1_OBUF_27 : STD_LOGIC; 
  signal digit2_2_OBUF_28 : STD_LOGIC; 
  signal digit2_3_OBUF_29 : STD_LOGIC; 
  signal digit2_4_OBUF_30 : STD_LOGIC; 
  signal digit2_5_OBUF_31 : STD_LOGIC; 
  signal digit2_6_OBUF_32 : STD_LOGIC; 
  signal idexflush : STD_LOGIC; 
  signal led_2_OBUF_65 : STD_LOGIC; 
  signal rst_IBUF_161 : STD_LOGIC; 
  signal u1_clk_2_162 : STD_LOGIC; 
  signal u1_clk_2_not0001 : STD_LOGIC; 
  signal u1_clk_4_164 : STD_LOGIC; 
  signal u1_clk_41 : STD_LOGIC; 
  signal u1_clk_4_and0000 : STD_LOGIC; 
  signal u1_clk_4_not0001 : STD_LOGIC; 
  signal u12_Cto0_168 : STD_LOGIC; 
  signal u14_ExMemRead_or0000 : STD_LOGIC; 
  signal u2_PCNext_0_21 : STD_LOGIC; 
  signal u4_Madd_PCALUOut_cy_1_rt_193 : STD_LOGIC; 
  signal u4_Madd_PCALUOut_cy_2_rt_195 : STD_LOGIC; 
  signal u4_Madd_PCALUOut_cy_3_rt_197 : STD_LOGIC; 
  signal u4_Madd_PCALUOut_cy_4_rt_199 : STD_LOGIC; 
  signal u4_Madd_PCALUOut_cy_5_rt_201 : STD_LOGIC; 
  signal u4_Madd_PCALUOut_cy_6_rt_203 : STD_LOGIC; 
  signal u5_IfIdKeep_inv : STD_LOGIC; 
  signal u8_Madd_PCim_cy_2_rt_219 : STD_LOGIC; 
  signal u8_Madd_PCim_cy_3_rt_221 : STD_LOGIC; 
  signal u8_Madd_PCim_cy_4_rt_223 : STD_LOGIC; 
  signal u8_Madd_PCim_cy_5_rt_225 : STD_LOGIC; 
  signal u8_Madd_PCim_cy_6_rt_227 : STD_LOGIC; 
  signal u8_Madd_PCim_xor_7_rt_230 : STD_LOGIC; 
  signal idbjop : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal idpcaddimme : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal immsele : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal pcadderout : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal pcmuxout : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal u14_ExBJOp : STD_LOGIC_VECTOR ( 2 downto 1 ); 
  signal u14_ExPCAddimme : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal u14_ExRd : STD_LOGIC_VECTOR ( 3 downto 3 ); 
  signal u14_ExRx : STD_LOGIC_VECTOR ( 15 downto 15 ); 
  signal u3_PCOut : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal u4_Madd_PCALUOut_cy : STD_LOGIC_VECTOR ( 6 downto 0 ); 
  signal u4_Madd_PCALUOut_lut : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal u5_tmpCommand : STD_LOGIC_VECTOR ( 12 downto 12 ); 
  signal u5_tmpPC : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal u6_Rd : STD_LOGIC_VECTOR ( 3 downto 3 ); 
  signal u8_Madd_PCim_cy : STD_LOGIC_VECTOR ( 6 downto 0 ); 
  signal u8_Madd_PCim_lut : STD_LOGIC_VECTOR ( 1 downto 0 ); 
begin
  XST_GND : GND
    port map (
      G => led_2_OBUF_65
    );
  XST_VCC : VCC
    port map (
      P => u2_PCNext_0_21
    );
  u1_clk_4 : FDE
    port map (
      C => clk_BUFGP_4,
      CE => u1_clk_4_and0000,
      D => u1_clk_4_not0001,
      Q => u1_clk_41
    );
  u1_clk_2 : FDE
    port map (
      C => clk_BUFGP_4,
      CE => rst_IBUF_161,
      D => u1_clk_2_not0001,
      Q => u1_clk_2_162
    );
  u12_Cto0 : LDC
    port map (
      CLR => u2_PCNext_0_21,
      D => u2_PCNext_0_21,
      G => u14_ExRd(3),
      Q => u12_Cto0_168
    );
  u8_Madd_PCim_cy_0_Q : MUXCY
    port map (
      CI => led_2_OBUF_65,
      DI => u5_tmpPC(0),
      S => u8_Madd_PCim_lut(0),
      O => u8_Madd_PCim_cy(0)
    );
  u8_Madd_PCim_xor_0_Q : XORCY
    port map (
      CI => led_2_OBUF_65,
      LI => u8_Madd_PCim_lut(0),
      O => idpcaddimme(0)
    );
  u8_Madd_PCim_cy_1_Q : MUXCY
    port map (
      CI => u8_Madd_PCim_cy(0),
      DI => u5_tmpPC(1),
      S => u8_Madd_PCim_lut(1),
      O => u8_Madd_PCim_cy(1)
    );
  u8_Madd_PCim_xor_1_Q : XORCY
    port map (
      CI => u8_Madd_PCim_cy(0),
      LI => u8_Madd_PCim_lut(1),
      O => idpcaddimme(1)
    );
  u8_Madd_PCim_cy_2_Q : MUXCY
    port map (
      CI => u8_Madd_PCim_cy(1),
      DI => led_2_OBUF_65,
      S => u8_Madd_PCim_cy_2_rt_219,
      O => u8_Madd_PCim_cy(2)
    );
  u8_Madd_PCim_xor_2_Q : XORCY
    port map (
      CI => u8_Madd_PCim_cy(1),
      LI => u8_Madd_PCim_cy_2_rt_219,
      O => idpcaddimme(2)
    );
  u8_Madd_PCim_cy_3_Q : MUXCY
    port map (
      CI => u8_Madd_PCim_cy(2),
      DI => led_2_OBUF_65,
      S => u8_Madd_PCim_cy_3_rt_221,
      O => u8_Madd_PCim_cy(3)
    );
  u8_Madd_PCim_xor_3_Q : XORCY
    port map (
      CI => u8_Madd_PCim_cy(2),
      LI => u8_Madd_PCim_cy_3_rt_221,
      O => idpcaddimme(3)
    );
  u8_Madd_PCim_cy_4_Q : MUXCY
    port map (
      CI => u8_Madd_PCim_cy(3),
      DI => led_2_OBUF_65,
      S => u8_Madd_PCim_cy_4_rt_223,
      O => u8_Madd_PCim_cy(4)
    );
  u8_Madd_PCim_xor_4_Q : XORCY
    port map (
      CI => u8_Madd_PCim_cy(3),
      LI => u8_Madd_PCim_cy_4_rt_223,
      O => idpcaddimme(4)
    );
  u8_Madd_PCim_cy_5_Q : MUXCY
    port map (
      CI => u8_Madd_PCim_cy(4),
      DI => led_2_OBUF_65,
      S => u8_Madd_PCim_cy_5_rt_225,
      O => u8_Madd_PCim_cy(5)
    );
  u8_Madd_PCim_xor_5_Q : XORCY
    port map (
      CI => u8_Madd_PCim_cy(4),
      LI => u8_Madd_PCim_cy_5_rt_225,
      O => idpcaddimme(5)
    );
  u8_Madd_PCim_cy_6_Q : MUXCY
    port map (
      CI => u8_Madd_PCim_cy(5),
      DI => led_2_OBUF_65,
      S => u8_Madd_PCim_cy_6_rt_227,
      O => u8_Madd_PCim_cy(6)
    );
  u8_Madd_PCim_xor_6_Q : XORCY
    port map (
      CI => u8_Madd_PCim_cy(5),
      LI => u8_Madd_PCim_cy_6_rt_227,
      O => idpcaddimme(6)
    );
  u8_Madd_PCim_xor_7_Q : XORCY
    port map (
      CI => u8_Madd_PCim_cy(6),
      LI => u8_Madd_PCim_xor_7_rt_230,
      O => idpcaddimme(7)
    );
  u4_Madd_PCALUOut_cy_0_Q : MUXCY
    port map (
      CI => led_2_OBUF_65,
      DI => u2_PCNext_0_21,
      S => u4_Madd_PCALUOut_lut(0),
      O => u4_Madd_PCALUOut_cy(0)
    );
  u4_Madd_PCALUOut_xor_0_Q : XORCY
    port map (
      CI => led_2_OBUF_65,
      LI => u4_Madd_PCALUOut_lut(0),
      O => pcadderout(0)
    );
  u4_Madd_PCALUOut_cy_1_Q : MUXCY
    port map (
      CI => u4_Madd_PCALUOut_cy(0),
      DI => led_2_OBUF_65,
      S => u4_Madd_PCALUOut_cy_1_rt_193,
      O => u4_Madd_PCALUOut_cy(1)
    );
  u4_Madd_PCALUOut_xor_1_Q : XORCY
    port map (
      CI => u4_Madd_PCALUOut_cy(0),
      LI => u4_Madd_PCALUOut_cy_1_rt_193,
      O => pcadderout(1)
    );
  u4_Madd_PCALUOut_cy_2_Q : MUXCY
    port map (
      CI => u4_Madd_PCALUOut_cy(1),
      DI => led_2_OBUF_65,
      S => u4_Madd_PCALUOut_cy_2_rt_195,
      O => u4_Madd_PCALUOut_cy(2)
    );
  u4_Madd_PCALUOut_xor_2_Q : XORCY
    port map (
      CI => u4_Madd_PCALUOut_cy(1),
      LI => u4_Madd_PCALUOut_cy_2_rt_195,
      O => pcadderout(2)
    );
  u4_Madd_PCALUOut_cy_3_Q : MUXCY
    port map (
      CI => u4_Madd_PCALUOut_cy(2),
      DI => led_2_OBUF_65,
      S => u4_Madd_PCALUOut_cy_3_rt_197,
      O => u4_Madd_PCALUOut_cy(3)
    );
  u4_Madd_PCALUOut_xor_3_Q : XORCY
    port map (
      CI => u4_Madd_PCALUOut_cy(2),
      LI => u4_Madd_PCALUOut_cy_3_rt_197,
      O => pcadderout(3)
    );
  u4_Madd_PCALUOut_cy_4_Q : MUXCY
    port map (
      CI => u4_Madd_PCALUOut_cy(3),
      DI => led_2_OBUF_65,
      S => u4_Madd_PCALUOut_cy_4_rt_199,
      O => u4_Madd_PCALUOut_cy(4)
    );
  u4_Madd_PCALUOut_xor_4_Q : XORCY
    port map (
      CI => u4_Madd_PCALUOut_cy(3),
      LI => u4_Madd_PCALUOut_cy_4_rt_199,
      O => pcadderout(4)
    );
  u4_Madd_PCALUOut_cy_5_Q : MUXCY
    port map (
      CI => u4_Madd_PCALUOut_cy(4),
      DI => led_2_OBUF_65,
      S => u4_Madd_PCALUOut_cy_5_rt_201,
      O => u4_Madd_PCALUOut_cy(5)
    );
  u4_Madd_PCALUOut_xor_5_Q : XORCY
    port map (
      CI => u4_Madd_PCALUOut_cy(4),
      LI => u4_Madd_PCALUOut_cy_5_rt_201,
      O => pcadderout(5)
    );
  u4_Madd_PCALUOut_cy_6_Q : MUXCY
    port map (
      CI => u4_Madd_PCALUOut_cy(5),
      DI => led_2_OBUF_65,
      S => u4_Madd_PCALUOut_cy_6_rt_203,
      O => u4_Madd_PCALUOut_cy(6)
    );
  u4_Madd_PCALUOut_xor_6_Q : XORCY
    port map (
      CI => u4_Madd_PCALUOut_cy(5),
      LI => u4_Madd_PCALUOut_cy_6_rt_203,
      O => pcadderout(6)
    );
  u4_Madd_PCALUOut_xor_7_Q : XORCY
    port map (
      CI => u4_Madd_PCALUOut_cy(6),
      LI => u3_PCOut(7),
      O => pcadderout(7)
    );
  u3_PCOut_0 : LD_1
    port map (
      D => pcmuxout(0),
      G => u12_Cto0_168,
      Q => u3_PCOut(0)
    );
  u3_PCOut_1 : LD_1
    port map (
      D => pcmuxout(1),
      G => u12_Cto0_168,
      Q => u3_PCOut(1)
    );
  u3_PCOut_2 : LD_1
    port map (
      D => pcmuxout(2),
      G => u12_Cto0_168,
      Q => u3_PCOut(2)
    );
  u3_PCOut_3 : LD_1
    port map (
      D => pcmuxout(3),
      G => u12_Cto0_168,
      Q => u3_PCOut(3)
    );
  u3_PCOut_4 : LD_1
    port map (
      D => pcmuxout(4),
      G => u12_Cto0_168,
      Q => u3_PCOut(4)
    );
  u3_PCOut_5 : LD_1
    port map (
      D => pcmuxout(5),
      G => u12_Cto0_168,
      Q => u3_PCOut(5)
    );
  u3_PCOut_6 : LD_1
    port map (
      D => pcmuxout(6),
      G => u12_Cto0_168,
      Q => u3_PCOut(6)
    );
  u3_PCOut_7 : LD_1
    port map (
      D => pcmuxout(7),
      G => u12_Cto0_168,
      Q => u3_PCOut(7)
    );
  u5_tmpPC_7 : FDCE
    port map (
      C => u1_clk_4_164,
      CE => u5_IfIdKeep_inv,
      CLR => u14_ExMemRead_or0000,
      D => pcadderout(7),
      Q => u5_tmpPC(7)
    );
  u5_tmpPC_6 : FDCE
    port map (
      C => u1_clk_4_164,
      CE => u5_IfIdKeep_inv,
      CLR => u14_ExMemRead_or0000,
      D => pcadderout(6),
      Q => u5_tmpPC(6)
    );
  u5_tmpPC_5 : FDCE
    port map (
      C => u1_clk_4_164,
      CE => u5_IfIdKeep_inv,
      CLR => u14_ExMemRead_or0000,
      D => pcadderout(5),
      Q => u5_tmpPC(5)
    );
  u5_tmpPC_4 : FDCE
    port map (
      C => u1_clk_4_164,
      CE => u5_IfIdKeep_inv,
      CLR => u14_ExMemRead_or0000,
      D => pcadderout(4),
      Q => u5_tmpPC(4)
    );
  u5_tmpPC_3 : FDCE
    port map (
      C => u1_clk_4_164,
      CE => u5_IfIdKeep_inv,
      CLR => u14_ExMemRead_or0000,
      D => pcadderout(3),
      Q => u5_tmpPC(3)
    );
  u5_tmpPC_2 : FDCE
    port map (
      C => u1_clk_4_164,
      CE => u5_IfIdKeep_inv,
      CLR => u14_ExMemRead_or0000,
      D => pcadderout(2),
      Q => u5_tmpPC(2)
    );
  u5_tmpPC_1 : FDCE
    port map (
      C => u1_clk_4_164,
      CE => u5_IfIdKeep_inv,
      CLR => u14_ExMemRead_or0000,
      D => pcadderout(1),
      Q => u5_tmpPC(1)
    );
  u5_tmpPC_0 : FDCE
    port map (
      C => u1_clk_4_164,
      CE => u5_IfIdKeep_inv,
      CLR => u14_ExMemRead_or0000,
      D => pcadderout(0),
      Q => u5_tmpPC(0)
    );
  u5_tmpCommand_12 : FDCE
    port map (
      C => u1_clk_4_164,
      CE => u5_IfIdKeep_inv,
      CLR => u14_ExMemRead_or0000,
      D => u2_PCNext_0_21,
      Q => u5_tmpCommand(12)
    );
  u14_ExRx_15 : FDC
    port map (
      C => u1_clk_4_164,
      CLR => u14_ExMemRead_or0000,
      D => u2_PCNext_0_21,
      Q => u14_ExRx(15)
    );
  u14_ExRd_3 : FDP
    port map (
      C => u1_clk_4_164,
      D => u6_Rd(3),
      PRE => u14_ExMemRead_or0000,
      Q => u14_ExRd(3)
    );
  u14_ExBJOp_2 : FDP
    port map (
      C => u1_clk_4_164,
      D => idbjop(0),
      PRE => u14_ExMemRead_or0000,
      Q => u14_ExBJOp(2)
    );
  u14_ExBJOp_1 : FDP
    port map (
      C => u1_clk_4_164,
      D => idbjop(1),
      PRE => u14_ExMemRead_or0000,
      Q => u14_ExBJOp(1)
    );
  u14_ExPCAddimme_7 : FDC
    port map (
      C => u1_clk_4_164,
      CLR => u14_ExMemRead_or0000,
      D => idpcaddimme(7),
      Q => u14_ExPCAddimme(7)
    );
  u14_ExPCAddimme_6 : FDC
    port map (
      C => u1_clk_4_164,
      CLR => u14_ExMemRead_or0000,
      D => idpcaddimme(6),
      Q => u14_ExPCAddimme(6)
    );
  u14_ExPCAddimme_5 : FDC
    port map (
      C => u1_clk_4_164,
      CLR => u14_ExMemRead_or0000,
      D => idpcaddimme(5),
      Q => u14_ExPCAddimme(5)
    );
  u14_ExPCAddimme_4 : FDC
    port map (
      C => u1_clk_4_164,
      CLR => u14_ExMemRead_or0000,
      D => idpcaddimme(4),
      Q => u14_ExPCAddimme(4)
    );
  u14_ExPCAddimme_3 : FDC
    port map (
      C => u1_clk_4_164,
      CLR => u14_ExMemRead_or0000,
      D => idpcaddimme(3),
      Q => u14_ExPCAddimme(3)
    );
  u14_ExPCAddimme_2 : FDC
    port map (
      C => u1_clk_4_164,
      CLR => u14_ExMemRead_or0000,
      D => idpcaddimme(2),
      Q => u14_ExPCAddimme(2)
    );
  u14_ExPCAddimme_1 : FDC
    port map (
      C => u1_clk_4_164,
      CLR => u14_ExMemRead_or0000,
      D => idpcaddimme(1),
      Q => u14_ExPCAddimme(1)
    );
  u14_ExPCAddimme_0 : FDC
    port map (
      C => u1_clk_4_164,
      CLR => u14_ExMemRead_or0000,
      D => idpcaddimme(0),
      Q => u14_ExPCAddimme(0)
    );
  u6_Rd_3 : LD
    port map (
      D => idbjop(0),
      G => idbjop(0),
      Q => u6_Rd(3)
    );
  u6_Rd_not00011 : LUT2
    generic map(
      INIT => X"7"
    )
    port map (
      I0 => rst_IBUF_161,
      I1 => u5_tmpCommand(12),
      O => idbjop(0)
    );
  u2_PCNext_7_26 : LUT4
    generic map(
      INIT => X"A820"
    )
    port map (
      I0 => u2_PCNext_0_21,
      I1 => idexflush,
      I2 => u5_tmpPC(7),
      I3 => u14_ExPCAddimme(7),
      O => pcmuxout(7)
    );
  u2_PCNext_6_26 : LUT4
    generic map(
      INIT => X"A820"
    )
    port map (
      I0 => u2_PCNext_0_21,
      I1 => idexflush,
      I2 => u5_tmpPC(6),
      I3 => u14_ExPCAddimme(6),
      O => pcmuxout(6)
    );
  u2_PCNext_5_26 : LUT4
    generic map(
      INIT => X"A820"
    )
    port map (
      I0 => u2_PCNext_0_21,
      I1 => idexflush,
      I2 => u5_tmpPC(5),
      I3 => u14_ExPCAddimme(5),
      O => pcmuxout(5)
    );
  u2_PCNext_4_26 : LUT4
    generic map(
      INIT => X"A820"
    )
    port map (
      I0 => u2_PCNext_0_21,
      I1 => idexflush,
      I2 => u5_tmpPC(4),
      I3 => u14_ExPCAddimme(4),
      O => pcmuxout(4)
    );
  u2_PCNext_3_26 : LUT4
    generic map(
      INIT => X"A820"
    )
    port map (
      I0 => u2_PCNext_0_21,
      I1 => idexflush,
      I2 => u5_tmpPC(3),
      I3 => u14_ExPCAddimme(3),
      O => pcmuxout(3)
    );
  u2_PCNext_2_26 : LUT4
    generic map(
      INIT => X"A820"
    )
    port map (
      I0 => u2_PCNext_0_21,
      I1 => idexflush,
      I2 => u5_tmpPC(2),
      I3 => u14_ExPCAddimme(2),
      O => pcmuxout(2)
    );
  u2_PCNext_1_26 : LUT4
    generic map(
      INIT => X"A820"
    )
    port map (
      I0 => u2_PCNext_0_21,
      I1 => idexflush,
      I2 => u5_tmpPC(1),
      I3 => u14_ExPCAddimme(1),
      O => pcmuxout(1)
    );
  u2_PCNext_0_26 : LUT4
    generic map(
      INIT => X"A820"
    )
    port map (
      I0 => u2_PCNext_0_21,
      I1 => idexflush,
      I2 => u5_tmpPC(0),
      I3 => u14_ExPCAddimme(0),
      O => pcmuxout(0)
    );
  u6_controllerOut_mux0005_3_1 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => rst_IBUF_161,
      I1 => u5_tmpCommand(12),
      O => immsele(0)
    );
  u1_clk_4_and00001 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => rst_IBUF_161,
      I1 => u1_clk_2_162,
      O => u1_clk_4_and0000
    );
  Mrom_digit241 : LUT4
    generic map(
      INIT => X"FB31"
    )
    port map (
      I0 => pcadderout(2),
      I1 => pcadderout(0),
      I2 => pcadderout(1),
      I3 => pcadderout(3),
      O => digit2_4_OBUF_30
    );
  Mrom_digit221 : LUT4
    generic map(
      INIT => X"76F7"
    )
    port map (
      I0 => pcadderout(3),
      I1 => pcadderout(2),
      I2 => pcadderout(0),
      I3 => pcadderout(1),
      O => digit2_2_OBUF_28
    );
  Mrom_digit251 : LUT4
    generic map(
      INIT => X"A6EF"
    )
    port map (
      I0 => pcadderout(3),
      I1 => pcadderout(2),
      I2 => pcadderout(1),
      I3 => pcadderout(0),
      O => digit2_5_OBUF_31
    );
  Mrom_digit261 : LUT4
    generic map(
      INIT => X"BDEE"
    )
    port map (
      I0 => pcadderout(3),
      I1 => pcadderout(1),
      I2 => pcadderout(0),
      I3 => pcadderout(2),
      O => digit2_6_OBUF_32
    );
  Mrom_digit2111 : LUT4
    generic map(
      INIT => X"497F"
    )
    port map (
      I0 => pcadderout(3),
      I1 => pcadderout(0),
      I2 => pcadderout(1),
      I3 => pcadderout(2),
      O => digit2_1_OBUF_27
    );
  Mrom_digit211 : LUT4
    generic map(
      INIT => X"F76B"
    )
    port map (
      I0 => pcadderout(3),
      I1 => pcadderout(0),
      I2 => pcadderout(2),
      I3 => pcadderout(1),
      O => digit2_0_OBUF_26
    );
  Mrom_digit231 : LUT4
    generic map(
      INIT => X"3DEB"
    )
    port map (
      I0 => pcadderout(3),
      I1 => pcadderout(2),
      I2 => pcadderout(0),
      I3 => pcadderout(1),
      O => digit2_3_OBUF_29
    );
  Mrom_digit141 : LUT4
    generic map(
      INIT => X"FB31"
    )
    port map (
      I0 => pcadderout(6),
      I1 => pcadderout(4),
      I2 => pcadderout(5),
      I3 => pcadderout(7),
      O => digit1_4_OBUF_16
    );
  Mrom_digit121 : LUT4
    generic map(
      INIT => X"76F7"
    )
    port map (
      I0 => pcadderout(7),
      I1 => pcadderout(6),
      I2 => pcadderout(4),
      I3 => pcadderout(5),
      O => digit1_2_OBUF_14
    );
  Mrom_digit151 : LUT4
    generic map(
      INIT => X"A6EF"
    )
    port map (
      I0 => pcadderout(7),
      I1 => pcadderout(6),
      I2 => pcadderout(5),
      I3 => pcadderout(4),
      O => digit1_5_OBUF_17
    );
  Mrom_digit161 : LUT4
    generic map(
      INIT => X"BDEE"
    )
    port map (
      I0 => pcadderout(7),
      I1 => pcadderout(5),
      I2 => pcadderout(4),
      I3 => pcadderout(6),
      O => digit1_6_OBUF_18
    );
  Mrom_digit1111 : LUT4
    generic map(
      INIT => X"497F"
    )
    port map (
      I0 => pcadderout(7),
      I1 => pcadderout(4),
      I2 => pcadderout(5),
      I3 => pcadderout(6),
      O => digit1_1_OBUF_13
    );
  Mrom_digit111 : LUT4
    generic map(
      INIT => X"F76B"
    )
    port map (
      I0 => pcadderout(7),
      I1 => pcadderout(4),
      I2 => pcadderout(6),
      I3 => pcadderout(5),
      O => digit1_0_OBUF_12
    );
  Mrom_digit131 : LUT4
    generic map(
      INIT => X"3DEB"
    )
    port map (
      I0 => pcadderout(7),
      I1 => pcadderout(6),
      I2 => pcadderout(4),
      I3 => pcadderout(5),
      O => digit1_3_OBUF_15
    );
  rst_IBUF : IBUF
    port map (
      I => rst,
      O => rst_IBUF_161
    );
  rdn_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => rdn
    );
  wrn_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => wrn
    );
  ram1Data_15_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram1Data(15)
    );
  ram1Data_14_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram1Data(14)
    );
  ram1Data_13_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram1Data(13)
    );
  ram1Data_12_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram1Data(12)
    );
  ram1Data_11_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram1Data(11)
    );
  ram1Data_10_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram1Data(10)
    );
  ram1Data_9_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram1Data(9)
    );
  ram1Data_8_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram1Data(8)
    );
  ram1Data_7_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram1Data(7)
    );
  ram1Data_6_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram1Data(6)
    );
  ram1Data_5_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram1Data(5)
    );
  ram1Data_4_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram1Data(4)
    );
  ram1Data_3_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram1Data(3)
    );
  ram1Data_2_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram1Data(2)
    );
  ram1Data_1_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram1Data(1)
    );
  ram1Data_0_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram1Data(0)
    );
  ram2Data_15_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram2Data(15)
    );
  ram2Data_14_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram2Data(14)
    );
  ram2Data_13_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram2Data(13)
    );
  ram2Data_12_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram2Data(12)
    );
  ram2Data_11_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram2Data(11)
    );
  ram2Data_10_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram2Data(10)
    );
  ram2Data_9_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram2Data(9)
    );
  ram2Data_8_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram2Data(8)
    );
  ram2Data_7_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram2Data(7)
    );
  ram2Data_6_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram2Data(6)
    );
  ram2Data_5_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram2Data(5)
    );
  ram2Data_4_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram2Data(4)
    );
  ram2Data_3_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram2Data(3)
    );
  ram2Data_2_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram2Data(2)
    );
  ram2Data_1_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram2Data(1)
    );
  ram2Data_0_OBUFT : OBUFT
    port map (
      I => led_2_OBUF_65,
      T => u2_PCNext_0_21,
      O => ram2Data(0)
    );
  ram1We_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram1We
    );
  ram2We_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram2We
    );
  hs_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => hs
    );
  ram1En_OBUF : OBUF
    port map (
      I => u2_PCNext_0_21,
      O => ram1En
    );
  vs_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => vs
    );
  ram2En_OBUF : OBUF
    port map (
      I => u2_PCNext_0_21,
      O => ram2En
    );
  ram1Oe_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram1Oe
    );
  ram2Oe_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram2Oe
    );
  redOut_2_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => redOut(2)
    );
  redOut_1_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => redOut(1)
    );
  redOut_0_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => redOut(0)
    );
  ram2Addr_17_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram2Addr(17)
    );
  ram2Addr_16_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram2Addr(16)
    );
  ram2Addr_15_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram2Addr(15)
    );
  ram2Addr_14_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram2Addr(14)
    );
  ram2Addr_13_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram2Addr(13)
    );
  ram2Addr_12_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram2Addr(12)
    );
  ram2Addr_11_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram2Addr(11)
    );
  ram2Addr_10_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram2Addr(10)
    );
  ram2Addr_9_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram2Addr(9)
    );
  ram2Addr_8_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram2Addr(8)
    );
  ram2Addr_7_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram2Addr(7)
    );
  ram2Addr_6_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram2Addr(6)
    );
  ram2Addr_5_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram2Addr(5)
    );
  ram2Addr_4_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram2Addr(4)
    );
  ram2Addr_3_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram2Addr(3)
    );
  ram2Addr_2_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram2Addr(2)
    );
  ram2Addr_1_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram2Addr(1)
    );
  ram2Addr_0_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram2Addr(0)
    );
  digit1_6_OBUF : OBUF
    port map (
      I => digit1_6_OBUF_18,
      O => digit1(6)
    );
  digit1_5_OBUF : OBUF
    port map (
      I => digit1_5_OBUF_17,
      O => digit1(5)
    );
  digit1_4_OBUF : OBUF
    port map (
      I => digit1_4_OBUF_16,
      O => digit1(4)
    );
  digit1_3_OBUF : OBUF
    port map (
      I => digit1_3_OBUF_15,
      O => digit1(3)
    );
  digit1_2_OBUF : OBUF
    port map (
      I => digit1_2_OBUF_14,
      O => digit1(2)
    );
  digit1_1_OBUF : OBUF
    port map (
      I => digit1_1_OBUF_13,
      O => digit1(1)
    );
  digit1_0_OBUF : OBUF
    port map (
      I => digit1_0_OBUF_12,
      O => digit1(0)
    );
  digit2_6_OBUF : OBUF
    port map (
      I => digit2_6_OBUF_32,
      O => digit2(6)
    );
  digit2_5_OBUF : OBUF
    port map (
      I => digit2_5_OBUF_31,
      O => digit2(5)
    );
  digit2_4_OBUF : OBUF
    port map (
      I => digit2_4_OBUF_30,
      O => digit2(4)
    );
  digit2_3_OBUF : OBUF
    port map (
      I => digit2_3_OBUF_29,
      O => digit2(3)
    );
  digit2_2_OBUF : OBUF
    port map (
      I => digit2_2_OBUF_28,
      O => digit2(2)
    );
  digit2_1_OBUF : OBUF
    port map (
      I => digit2_1_OBUF_27,
      O => digit2(1)
    );
  digit2_0_OBUF : OBUF
    port map (
      I => digit2_0_OBUF_26,
      O => digit2(0)
    );
  blueOut_2_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => blueOut(2)
    );
  blueOut_1_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => blueOut(1)
    );
  blueOut_0_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => blueOut(0)
    );
  ram1Addr_17_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram1Addr(17)
    );
  ram1Addr_16_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram1Addr(16)
    );
  ram1Addr_15_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram1Addr(15)
    );
  ram1Addr_14_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram1Addr(14)
    );
  ram1Addr_13_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram1Addr(13)
    );
  ram1Addr_12_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram1Addr(12)
    );
  ram1Addr_11_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram1Addr(11)
    );
  ram1Addr_10_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram1Addr(10)
    );
  ram1Addr_9_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram1Addr(9)
    );
  ram1Addr_8_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram1Addr(8)
    );
  ram1Addr_7_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram1Addr(7)
    );
  ram1Addr_6_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram1Addr(6)
    );
  ram1Addr_5_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram1Addr(5)
    );
  ram1Addr_4_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram1Addr(4)
    );
  ram1Addr_3_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram1Addr(3)
    );
  ram1Addr_2_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram1Addr(2)
    );
  ram1Addr_1_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram1Addr(1)
    );
  ram1Addr_0_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => ram1Addr(0)
    );
  greenOut_2_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => greenOut(2)
    );
  greenOut_1_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => greenOut(1)
    );
  greenOut_0_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => greenOut(0)
    );
  led_15_OBUF : OBUF
    port map (
      I => u2_PCNext_0_21,
      O => led(15)
    );
  led_14_OBUF : OBUF
    port map (
      I => u2_PCNext_0_21,
      O => led(14)
    );
  led_13_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => led(13)
    );
  led_12_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => led(12)
    );
  led_11_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => led(11)
    );
  led_10_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => led(10)
    );
  led_9_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => led(9)
    );
  led_8_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => led(8)
    );
  led_7_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => led(7)
    );
  led_6_OBUF : OBUF
    port map (
      I => immsele(0),
      O => led(6)
    );
  led_5_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => led(5)
    );
  led_4_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => led(4)
    );
  led_3_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => led(3)
    );
  led_2_OBUF : OBUF
    port map (
      I => led_2_OBUF_65,
      O => led(2)
    );
  led_1_OBUF : OBUF
    port map (
      I => idexflush,
      O => led(1)
    );
  led_0_OBUF : OBUF
    port map (
      I => idexflush,
      O => led(0)
    );
  u8_Madd_PCim_cy_2_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => u5_tmpPC(2),
      O => u8_Madd_PCim_cy_2_rt_219
    );
  u8_Madd_PCim_cy_3_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => u5_tmpPC(3),
      O => u8_Madd_PCim_cy_3_rt_221
    );
  u8_Madd_PCim_cy_4_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => u5_tmpPC(4),
      O => u8_Madd_PCim_cy_4_rt_223
    );
  u8_Madd_PCim_cy_5_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => u5_tmpPC(5),
      O => u8_Madd_PCim_cy_5_rt_225
    );
  u8_Madd_PCim_cy_6_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => u5_tmpPC(6),
      O => u8_Madd_PCim_cy_6_rt_227
    );
  u4_Madd_PCALUOut_cy_1_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => u3_PCOut(1),
      O => u4_Madd_PCALUOut_cy_1_rt_193
    );
  u4_Madd_PCALUOut_cy_2_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => u3_PCOut(2),
      O => u4_Madd_PCALUOut_cy_2_rt_195
    );
  u4_Madd_PCALUOut_cy_3_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => u3_PCOut(3),
      O => u4_Madd_PCALUOut_cy_3_rt_197
    );
  u4_Madd_PCALUOut_cy_4_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => u3_PCOut(4),
      O => u4_Madd_PCALUOut_cy_4_rt_199
    );
  u4_Madd_PCALUOut_cy_5_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => u3_PCOut(5),
      O => u4_Madd_PCALUOut_cy_5_rt_201
    );
  u4_Madd_PCALUOut_cy_6_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => u3_PCOut(6),
      O => u4_Madd_PCALUOut_cy_6_rt_203
    );
  u8_Madd_PCim_xor_7_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => u5_tmpPC(7),
      O => u8_Madd_PCim_xor_7_rt_230
    );
  u8_Madd_PCim_lut_0_Q : LUT3
    generic map(
      INIT => X"6C"
    )
    port map (
      I0 => rst_IBUF_161,
      I1 => u5_tmpPC(0),
      I2 => u5_tmpCommand(12),
      O => u8_Madd_PCim_lut(0)
    );
  u8_Madd_PCim_lut_1_Q : LUT3
    generic map(
      INIT => X"6C"
    )
    port map (
      I0 => rst_IBUF_161,
      I1 => u5_tmpPC(1),
      I2 => u5_tmpCommand(12),
      O => u8_Madd_PCim_lut(1)
    );
  u11_PCSrc_0_11 : LUT3
    generic map(
      INIT => X"31"
    )
    port map (
      I0 => u14_ExBJOp(1),
      I1 => u14_ExBJOp(2),
      I2 => u14_ExRx(15),
      O => idexflush
    );
  u5_tmpPC_or00001 : LUT4
    generic map(
      INIT => X"31FF"
    )
    port map (
      I0 => u14_ExBJOp(1),
      I1 => u14_ExBJOp(2),
      I2 => u14_ExRx(15),
      I3 => rst_IBUF_161,
      O => u14_ExMemRead_or0000
    );
  u1_clk_4_BUFG : BUFG
    port map (
      I => u1_clk_41,
      O => u1_clk_4_164
    );
  clk_BUFGP : BUFGP
    port map (
      I => clk,
      O => clk_BUFGP_4
    );
  u4_Madd_PCALUOut_lut_0_INV_0 : INV
    port map (
      I => u3_PCOut(0),
      O => u4_Madd_PCALUOut_lut(0)
    );
  u5_IfIdKeep_inv1_INV_0 : INV
    port map (
      I => u12_Cto0_168,
      O => u5_IfIdKeep_inv
    );
  u6_BJOp_mux0005_1_1_INV_0 : INV
    port map (
      I => rst_IBUF_161,
      O => idbjop(1)
    );
  u1_clk_4_not00011_INV_0 : INV
    port map (
      I => u1_clk_41,
      O => u1_clk_4_not0001
    );
  u1_clk_2_not00011_INV_0 : INV
    port map (
      I => u1_clk_2_162,
      O => u1_clk_2_not0001
    );

end Structure;

