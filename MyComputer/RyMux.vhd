library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RyMux is
	port(
			Ry : in std_logic_vector(15 downto 0);
			WBData : in std_logic_vector(15 downto 0);
			MemData : in std_logic_vector(15 downto 0);
			
			Forward2 : in std_logic_vector(1 downto 0);
			
			RyOut : out std_logic_vector(15 downto 0)
	);
end RyMux;

architecture Behavioral of RyMux is

begin

	process(Ry, WBData, MemData, Forward2)
	begin
		case Forward2 is
			when "00" =>--ry
				RyOut <= Ry;
			when "01" =>--WBData
				RyOut <= WBData;
			when "10" =>--MemData
				RyOut <= MemData;
			when others =>
				RyOut <= (others => '0');
		end case;
	end process;
end Behavioral;

