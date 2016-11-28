----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:39:24 11/20/2015 
-- Design Name: 
-- Module Name:    Registers - Behavioral 
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

entity TRegisters is
	port(
		rst : in std_logic;
		dataA : in std_logic_vector(15 downto 0);
		dataB : in std_logic_vector(15 downto 0);
		TOp : in std_logic_vector(1 downto 0);
		dataImme : in std_logic_vector(15 downto 0);
		
		dataT : out std_logic;
	);
end TRegisters;

architecture Behavioral of TRegisters is
signal T : std_logic;
begin
	process(rst)
	begin
		if(rst = '0') then
			T<='1';
		end if;
	end process;
	
	process(dataA,dataB,commendIn)
	begin
		if(dataA = dataB) and (TOp = "00") then
			T<='0';
		elsif (dataA < dataB) and (TOp = "01")  then
			T<='1';
		elsif (dataA = dataImme) and TOp = "10" then
			T<='0';
		end if;
	end process;
	dataT<=T;
end Behavioral;