library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FirstOpMux is
	port(
			Rx : in std_logic_vector(15 downto 0);
			WBData : in std_logic_vector(15 downto 0);
			MemData : in std_logic_vector(15 downto 0);
			
			Forward1 : in std_logic_vector(1 downto 0);
			
			FirstOp : out std_logic_vector(15 downto 0)
	);
end FirstOpMux;

architecture Behavioral of FirstOpMux is

begin
	process(Rx, WBData, MemData, Forward1)
	begin
		case Forward1 is
			when "00" =>--rx
				FirstOp <= Rx;
			when "01" =>--WBData
				FirstOp <= WBData;
			when "10" =>--MemData
				FirstOp <= MemData;
			when others =>
				FirstOp <= (others => '0');
		end case;
	end process;
end Behavioral;

