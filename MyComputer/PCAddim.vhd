library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PCAddim is
	port(
			NextPC : in std_logic_vector(15 downto 0);
			imme : in std_logic_vector(15 downto 0);

			PCim : out std_logic_vector(15 downto 0)
			
end PCAddim;

architecture Behavioral of PCAddim is

begin
	process(NextPC, imme)
	begin
		PCim <= NextPC + imme - "0000000000000001";
	end process;
end Behavioral;

