----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:37:06 11/20/2015 
-- Design Name: 
-- Module Name:    IfIdRegisters - Behavioral 
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

entity IfIdRegisters is
	port(
			rst : in std_logic;
			clk : in std_logic;
			commandIn : in std_logic_vector(15 downto 0);
			PCFour : in std_logic_vector(15 downto 0); 
			IfIdKeep : in std_logic;
			IfIdFlush : in std_logic;
			
			imme : out std_logic_vector(10 downto 0);
				
			commandOut : out std_logic_vector(15 downto 0);
			PCOut : out std_logic_vector(15 downto 0)
			);
end IfIdRegisters;

architecture Behavioral of IfIdRegisters is
	signal tmpImm : std_logic_vector(10 downto 0);
	signal tmpCommand : std_logic_vector(15 downto 0);
	signal tmpPC : std_logic_vector(15 downto 0);
begin
	imme <= tmpImm;
	commandOut <= tmpCommand;
	PCOut <= tmpPC;
	process(rst, clk)
	begin 
		if (rst = '0' or IfIdFlush = '1') then
			tmpImm <= (others => '0');
			tmpCommand <= (others => '0');
			tmpPC <= "0000000000000000";
		elsif (clk'event and clk = '1') then 
				if (IfIdKeep = '0')then
					tmpImm <= commandIn(10 downto 0);
					tmpCommand<= commandIn;
					tmpPC <= PCFour;
				end if;
		end if;
	end process;
end Behavioral;

