----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:48:17 11/16/2015 
-- Design Name: 
-- Module Name:    Controller - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Controller is
	port(	commandIn : in std_logic_vector(15 downto 0);
			rst : in std_logic;
			imm : out std_logic_vector(2 downto 0);
			controllerOut :  out std_logic_vector(4 downto 0) ;
			-- RegWrite(1) ALUSrc(1) MemRead(1)MemWrite(1)MemtoReg(1)
			Rd : out std_logic_vector(3 downto 0);
			ALUOp : out std_logic_vector(3 downto 0);
			

			rx : out std_logic_vector(3 downto 0);
			ry : out std_logic_vector(3 downto 0);
			BJOp : out std_logic_vector(2 downto 0)
			);
end Controller;

architecture Behavioral of Controller is
--signal tmp : std_logic_vector(20 downto 0);
begin
	process(rst, commandIn)
	begin
		if rst = '0' then
			controllerOut <= (others => '0');
			imm <= (others => '0');
			BJOp<="111";
			Rd<="1111";
			ALUOp<="1111";
		else
			case commandIn(15 downto 11) is
				when "11101" =>
					
					case commandIn(4 downto 0) is
						when "01100" =>--AND
							imm <= "000";
							controllerOut <= "10000";
							BJOp<="101";
							
							Rd<='0'& commandIn(10 downto 8);
							ALUOp<="0010";
							rx<='0'&commandIn(10 downto 8);
							ry<='0'&commandIn(7 downto 5);
						when "01010" =>--CMP 
							imm <= "000";
							BJOp<="101";
							
							controllerOut <= "10000";
							Rd<="1110";
							ALUOp<="1010";
							rx<='0'&commandIn(10 downto 8);
							ry<='0'&commandIn(7 downto 5);
						when "00000" =>
							if (commandIn(7 downto 0) = "00000000") then --JR
								imm <= "000";
							
								BJOp<="100";
								controllerOut <= "00000";
								Rd<="1111";
								ALUOp<="1111";
								rx<='0'&commandIn(10 downto 8);
								ry<="1111";
						--wjf
							elsif (commandIn(7 downto 0) = "01000000") then--MFPC
								imm <= "000";
								BJOp<="101";
							
								controllerOut <= "10000";
								Rd<='0'&commandIn(10 downto 8);
								ALUOp<="0000";
								rx<="1010";
								ry<="1011";
						
							end if;
						when "01101" => --OR
							imm <= "000";
							BJOp<="101";
							
							controllerOut <= "10000";
							ALUOp<="0011";
							Rd<='0'&commandIn(10 downto 8);
							rx<='0'&commandIn(10 downto 8);
							ry<='0'&commandIn(7 downto 5);
						
						when "00111" => --SRAV
							imm <= "000";
							BJOp<="101";
							
							controllerOut <= "10000";
							Rd<='0'&commandIn(7 downto 5);
							ALUOp<="1000";
							rx<='0'&commandIn(7 downto 5);
							ry<='0'&commandIn(10 downto 8);
						
						when "00010" => --SLT
							imm<="000";
							BJOp<="101";
							
							controllerOut<="10000";
							Rd<="1110";
							ALUOp<="1011";
							rx<='0'&commandIn(10 downto 8);
							ry<='0'&commandIn(7 downto 5);
						
						when "01111" => --NOT
							imm<="000";
							BJOp<="101";
							
							controllerOut<="10000";
							Rd<='0'&commandIn(10 downto 8);
							ALUOp<="0101";
							rx<='0'&commandIn(7 downto 5);
							ry<="1011";
						
						when others =>--error	
					end case;
				when "01001" => --ADDIU
					imm <= "111";
					
					BJOp<="101";
					controllerOut <= "11000";
					Rd<='0'&commandIn(10 downto 8);
					ALUOp<="0000";
					rx<='0'&commandIn(10 downto 8);
					ry<="1111";
						
					
				when "01000" => --ADDIU3
					imm <= "101";
					
					BJOp<="101";
					controllerOut <= "11000";
					Rd<='0'&commandIn(7 downto 5);
					ALUOp<="0000";
					rx<='0'&commandIn(10 downto 8);
					ry<="1111";
						
				when "01100" =>
					case commandIn(10 downto 8) is 
						when "011" => --ADDSP
							imm <= "111";
					
							BJOp<="101";
							controllerOut <= "11000";
							Rd<="1000";
							ALUOp<="0000";
							rx<="1000";
							ry<="1111";
						
						when "000" => --BTEQZ
							imm <= "111";
					
							controllerOut <= "01000";
							BJOp<="011";
							Rd<="1111";
							ALUOp<="0001";
							rx<="1110";
							ry<="1111";
						
						when "100" => --MTSP
							imm <= "000";
					
							BJOp<="101";
							controllerOut <= "10000";
							Rd<="1000";
							ALUOp<="0000";
							rx<='0'&commandIn(7 downto 5);
							ry<="1011";
						
						when others => --error
					end case;
				when "00010" => --B
					imm <= "001";
					
					controllerOut <= "01000";
					BJOp<="000";
					ALUOp<="1111";
					rx<="1111";
					ry<="1111";
						
				when "11100" =>
					if (commandIn(1 downto 0) = "01") then--ADDU
						imm <= "000";
					
						BJOp<="101";
						controllerOut <= "10000";
						Rd<='0'&commandIn(4 downto 2);
						ALUOp<="0000";
						rx<='0'&commandIn(10 downto 8);
						ry<='0'&commandIn(7 downto 5);
					elsif(commandIn(1 downto 0) = "11") then --SUBU
						imm <= "000";
						
						BJOp <= "101";
						controllerOut <= "10000";
						Rd<='0'&commandIn(4 downto 2);
						ALUOp<="0001";
						rx<='0'&commandIn(10 downto 8);
						ry<='0'&commandIn(7 downto 5);
					end if;
				when "00100" => --BEQZ
					imm <= "111";
					
					controllerOut <= "01000";
					BJOp<="001";
					Rd<="1111";
					ALUOp<="0001";
					rx<='0'&commandIn(10 downto 8);
					ry<="1111";
						
				when "00101" => --BNEZ
					imm <= "111";
					controllerOut <= "01000";
					BJOp<="010";
					
					Rd<="1111";
					ALUOp<="0001";
					rx<='0'&commandIn(10 downto 8);
					ry<="1111";
						
				when "01101" => --LI
					imm <= "011";
					
					BJOp<="101";
					controllerOut <= "11000";
					Rd<='0'&commandIn(10 downto 8);
					ALUOp<="0000";
					rx<="1011";
					ry<="1111";
						
				when "10011" => --LW
					imm <= "110";
					BJOp<="101";
					
					controllerOut <= "11101";
					Rd<='0'&commandIn(7 downto 5);
					ALUOp<="0000";
					rx<='0'&commandIn(10 downto 8);
					ry<="1111";
						
				when "10010" => --LW_SP
					imm <= "111";
					
					BJOp<="101";
					controllerOut <= "11101";
					Rd<='0'&commandIn(10 downto 8);
					ALUOp<="0000";
					rx<="1000";
					ry<="1111";
						
				when "11110" =>
					if (commandIn(0) = '0') then --MFIH
						imm <= "000";
					
						BJOp<="101";
						controllerOut <= "10000";
						Rd<='0'&commandIn(10 downto 8);
						ALUOp<="0000";
						rx<="1001";
						ry<="1011";
						
					else --MTIH
						imm <= "000";
					
						BJOp<="101";
						controllerOut <= "10000";
						Rd<="1001";
						ALUOp<="0000";
						rx<='0'&commandIn(10 downto 8);
						ry<="1011";
						
					end if;
				when "00110" =>
					if (commandIn(1 downto 0) = "00") then --SLL
						imm <= "100";
						BJOp<="101";
					
						controllerOut <= "11000";
						Rd<='0'&commandIn(10 downto 8);
						ALUOp<="0110";
						rx<='0'&commandIn(7 downto 5);
						ry<="1111";
						
					elsif (commandIn(1 downto 0) = "11") then --SRA
						imm <= "100";
						BJOp<="101";
					
						controllerOut <= "11000";
						Rd<='0'&commandIn(10 downto 8);
						ALUOp<="1000";
						rx<='0'&commandIn(7 downto 5);
						ry<="1111";
						
					elsif(commandIn(1 downto 0) = "10") then --SRL
						imm<="100";
						BJOp<="101";
					
						controllerOut<="11000";
						Rd<='0'&commandIn(10 downto 8);
						ALUOp<="0111";
						rx<='0'&commandIn(7 downto 5);
						ry<="1111";
						
					end if;
				when "11011" => --SW
					imm <= "110";
					
					BJOp<="101";
					controllerOut <= "01010";
					Rd<="1111";
					ALUOp<="0000";
					rx<='0'&commandIn(10 downto 8);
					ry<='0'&commandIn(7 downto 5);
						
				when "11010" => --SW_SP
					imm <= "111";
					
					BJOp<="101";
					controllerOut <= "01010";
					Rd<="1111";
					ALUOp<="0000";
					rx<="1000";
					ry<='0'&commandIn(10 downto 8);
						
				when "01110" => --CMPI
					imm <= "111";
					BJOp<="101";
					
					controllerOut <= "11000";
					Rd<="1110";
					ALUOp<="1010";
					rx<='0'&commandIn(10 downto 8);
					ry<="1111";
						
				when others => --error or NOP
					imm <= "000";
					BJOp<="101";
					
					controllerOut <= "00000";
					Rd<="1111";
					ALUOp<="1111";
					rx<="1111";
					ry<="1111";
						
			end case;
		end if;
	end process;
end Behavioral;

