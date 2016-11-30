library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL ;
use IEEE.STD_LOGIC_UNSIGNED.ALL ;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Registers is
	port(
		clk : in std_logic;
		rst : in std_logic;
		rx : in std_logic_vector(3 downto 0);
		ry : in std_logic_vector(3 downto 0);
		WbRd : in std_logic_vector(3 downto 0);
		WbData : in std_logic_vector(15 downto 0);
		PCIn : in std_logic_vector(15 downto 0);
		RegWrite : in std_logic;
		
		
		r0Out, r1Out, r2Out,r3Out,r4Out,r5Out,r6Out,r7Out : out std_logic_vector(15 downto 0);
		dataA : out std_logic_vector(15 downto 0);
		dataB : out std_logic_vector(15 downto 0);
		dataSP : out std_logic_vector(15 downto 0);
		dataIH : out std_logic_vector(15 downto 0)
	);
end Registers;

architecture Behavioral of Registers is

	signal r0 : std_logic_vector(15 downto 0);
	signal r1 : std_logic_vector(15 downto 0);
	signal r2 : std_logic_vector(15 downto 0);
	signal r3 : std_logic_vector(15 downto 0);
	signal r4 : std_logic_vector(15 downto 0);
	signal r5 : std_logic_vector(15 downto 0);
	signal r6 : std_logic_vector(15 downto 0);
	signal r7 : std_logic_vector(15 downto 0);
	signal IH : std_logic_vector(15 downto 0);
	signal SP : std_logic_vector(15 downto 0);
	signal PC : std_logic_vector(15 downto 0);
	signal T  : std_logic_vector(15 downto 0);
begin
	
	process(clk, rst)
	begin
		if (rst = '0') then
			r0 <= (others => '0');
			r1 <= (others => '0');
			r2 <= (others => '0');
			r3 <= (others => '0');
			r4 <= (others => '0');
			r5 <= (others => '0');
			r6 <= (others => '0');
			r7 <= (others => '0');
			IH <= (others => '0');			
			SP <= (others => '0');
			PC <= (others => '0');
			T  <= (others => '0');
		elsif (clk'event and clk = '0') then
			PC <= PCIn - x"0001";
			if(RegWrite = '1') then
				case WbRd is 
					when "0000" => r0 <= WbData;
					when "0001" => r1 <= WbData;
					when "0010" => r2 <= WbData;
					when "0011" => r3 <= WbData;
					when "0100" => r4 <= WbData;
					when "0101" => r5 <= WbData;
					when "0110" => r6 <= WbData;
					when "0111" => r7 <= WbData;
					when "1000" => SP <= WbData;
					when "1001" => IH <= WbData;
					when "1110" => T  <= WbData;
					--Pc "1010"
					
					when others =>
				end case;
			end if;
		end if;
	end process;
	
	process
	begin 
		case  rx is 
			when "0000" => dataA <= r0;
			when "0001" => dataA <= r1;
			when "0010" => dataA <= r2;
			when "0011" => dataA <= r3;
			when "0100" => dataA <= r4;
			when "0101" => dataA <= r5;
			when "0110" => dataA <= r6;
			when "0111" => dataA <= r7;
			when "1000" => dataA <= SP;
			when "1001" => dataA <= IH;
			when "1010" => dataA <= PC;
			when "1011" => dataA <= (others => '0');
			when "1110" => dataA <= T;
			when others =>
				dataA <= (others => '1');
		end case;
	end process;
	
	process
	begin 
		case  ry is
			when "0000" => dataB <= r0;
			when "0001" => dataB <= r1;
			when "0010" => dataB <= r2;
			when "0011" => dataB <= r3;
			when "0100" => dataB <= r4;
			when "0101" => dataB <= r5;
			when "0110" => dataB <= r6;
			when "0111" => dataB <= r7;
			when "1000" => dataB <= SP;
			when "1001" => dataB <= IH;
			when "1010" => dataB <= PC;
			when "1011" => dataB <= (others => '0');
			when "1110" => dataB <= T;
			when others =>
				dataB <= (others => '1');
		end case;
	end process;
	
	dataSP <= SP;
	dataIH <= IH;
	
	r0Out <= r0;
	r1Out <= r1;
	r2Out <= r2;
	r3Out <= r3;
	r4Out <= r4;
	r5Out <= r5;
	r6Out <= r6;
	r7Out <= r7;
end Behavioral;

