library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BJControler is
	port(
			Rx : in std_logic_vector(15 downto 0);
			T : in std_logic_vector(15 downto 0);
			BJOp : in std_logic(2 downto 0);
			
			IFIDFlush : out std_logic;
			PCSrc : out std_logic
	);
end BJControler;

architecture Behavioral of BJControler is

begin
	process(Rx, T, BJOp) 
	begin
		case BJOp is
			when '000' =>--PC ← PC + Si(imm)
				IFIDFlush <= '1';
				PCSrc <= "01";
			when "001" =>--"if (R[x] == 0)PC ← PC + Si(imm)"
				if(Rx = "0000000000000000") then
					IFIDFlush <= '1';
					PCSrc <= "01";
				else
					IFIDFlush <= '0';
					PCSrc <= "00";
				end if;
			when "010" =>--"if (R[x] != 0)PC ← PC + Si(imm)"
				if(Rx /= "0000000000000000") then
					IFIDFlush <= '1';
					PCSrc <= "01";
				else
					IFIDFlush <= '0';
					PCSrc <= "00";
				end if;
			when "011" =>--"if (T== 0)PC ← PC + Si(imm)"
				if(T = "0000000000000000") then
					IFIDFlush <= '1';
					PCSrc <= "01";
				else
					IFIDFlush <= '0';
					PCSrc <= "00";
				end if;
			when "100" =>--PC ← R[x]
				IFIDFlush <= '1';
				PCSrc <= "10";
			when others =>
				IFIDFlush <= '0';
				PCSrc <= "00";
		end case;
	end process;
end Behavioral;

