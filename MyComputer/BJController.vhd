library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BJController is
	port(
			Rx : in std_logic_vector(15 downto 0);
			BJOp : in std_logic_vector(2 downto 0);
			
			PCSrc : out std_logic_vector(1 downto 0)
	);
end BJController;

architecture Behavioral of BJController is

begin
	process(Rx, BJOp) 
	begin
		case BJOp is
			when "000" =>--PC â†PC + Si(imm)

				
				PCSrc <= "01";
			when "001" =>--"if (R[x] == 0)PC â†PC + Si(imm)"
				if(Rx = "0000000000000000") then
		
					
					PCSrc <= "01";
				else
			
					
					PCSrc <= "00";
				end if;
			when "010" =>--"if (R[x] != 0)PC â†PC + Si(imm)"
				if(Rx /= "0000000000000000") then
			
					
					PCSrc <= "01";
				else
			
					
					PCSrc <= "00";
				end if;
			when "011" =>--"if (T== 0)PC â†PC + Si(imm)"
				if(Rx = "0000000000000000") then
				
					
					PCSrc <= "01";
				else
			
					
					PCSrc <= "00";
				end if;
			when "100" =>--PC â†R[x]
		
				
				PCSrc <= "10";
			when others =>
	
				PCSrc <= "00";
		end case;
	end process;
end Behavioral;

