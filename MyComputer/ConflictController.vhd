library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ConflictController is
	port(
			ExMemRead : in std_logic;
			ExRd : in std_logic_vector(3 downto 0);
			
			RxAddr : in std_logic_vector(3 downto 0);
			RyAddr : in std_logic_vector(3 downto 0);
			
			PCKeep : out std_logic;
			IFIDKeep : out std_logic;
			Cto0 : out std_logic
	);
			
end ConflictController;

architecture Behavioral of ConflictController is

begin
	process(ExMemRead, ExRd, RxAddr, RyAddr)
	begin
		if(ExMemRead = '0') then
			PCKeep <= '0';
			IFIDKeep <= '0';
			Cto0 <= '0';
		elsif(ExRd = RxAddr or ExRd = RyAddr) then
			PCKeep <= '1';
			IFIDKeep <= '1';
			Cto0 <= '1';
		end if;
	end process;
end Behavioral;

