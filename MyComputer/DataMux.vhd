library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DataMux is
	port(
			Op1 : in std_logic_vector(15 downto 0);
			Op2 : in std_logic_vector(15 downto 0);
			DataSrc : in std_logic;
			
			ExData : out std_logic_vector(15 downto 0)
	);
end DataMux;

architecture Behavioral of DataMux is

begin
	process(Op1, Op2, DataSrc) 
	begin
		case DataSrc is
			when '0' =>--rx
				ExData <= Op1;
			when "1" =>--ry
				ExData <= Op2;
			when others =>
				ExData <= (others => '0');
		end case;
	end process;
end Behavioral;

