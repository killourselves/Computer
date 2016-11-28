library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SecondOpMux is
	port(
			Ry : in std_logic_vector(15 downto 0);
			imme : in std_logic_vector(15 downto 0);
			AluSrc : in std_logic;
			
			SecondOp : out std_logic_vector(15 downto 0)
	);
end SecondOpMux;

architecture Behavioral of SecondOpMux is

begin
	process(Ry, imme, AluSrc) 
	begin
		case AluSrc is
			when '0' =>--ry
				SecondOp <= Ry;
			when "1" =>--imme
				SecondOp <= imme;
			when others =>
				SecondOp <= (others => '0');
		end case;
	end process;
end Behavioral;

