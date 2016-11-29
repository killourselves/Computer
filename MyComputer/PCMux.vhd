library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PCMux is
	port( PCSrc : in std_logic_vector(1 downto 0);
			PCImme : in std_logic_vector(15 downto 0);
			PCFour : in std_logic_vector(15 downto 0);
			PCRx : in std_logic_vector(15 downto 0);
			
			PCNext : out std_logic_vector(15 downto 0)
			);
end PCMux;

architecture Behavioral of PCMux is
begin
	process(PCImme, PCSrc, PCFour, PCRx)
	begin 
		if (PCSrc = "00") then
			PCNext <= PCFour;
		elsif (PCSrc = "01") then
			PCNext <= PCImme;
		else PCNext <= PCRx;
		end if;
		--if (branch = '1') then 
		--	PCNext <= PCJump;
		--else PcNext <= PcAdd;
		--end if;
	end process;

end Behavioral;