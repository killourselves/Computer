----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:51:23 11/15/2015 
-- Design Name: 
-- Module Name:    PCRegister - Behavioral 
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

entity PCRegister is
	port(	rst : in std_logic;
			PCWrite : in std_logic;
			PCIn : in std_logic_vector(15 downto 0);
			PCOut : out std_logic_vector(15 downto 0)
			);
end PCRegister;

architecture Behavioral of PCRegister is

begin
	process
	begin
				if PCWrite = '0' then
					PCOut <= PCIn;
				end if;
	end process;
end Behavioral;

