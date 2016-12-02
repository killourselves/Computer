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

entity ControllerMux is
	port(
		controllerin : in std_logic_vector(4 downto 0);
		CTo0 : in std_logic;
		controllerout : out std_logic_vector(4 downto 0)
	);

end ControllerMux;

architecture Behavioral of ControllerMux is
begin
	process(controllerin,CTo0)
	begin
		if (CTo0 = '1') then
		controllerout<="00000";
		else 
		controllerout<=controllerin;
		end if;
	end process;
end Behavioral;