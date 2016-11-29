library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock is
	port(
		rst : in std_logic;
		clkIn : in std_logic;

		clk2 : out std_logic;
		clk4 : out std_logic
	);
end clock;

architecture Behavioral of clock is
	signal clk_1,clk_2,clk_4,clk_8: std_logic;
begin
	process (clkIn,rst)
		begin
			if (rst = '0') then
			elsif (clkIn'event and clkIn='1') then 
				clk_1<=not clk_1; 
				if (clk_1='1')then
					clk_2<=not clk_2; 
					if (clk_2='1')then
						clk_4<=not clk_4;
						if(clk_4='1')then
							clk_8<=not clk_8;
						end if;
					end if;
				end if;
			end if; 
			clk2<=clk_2;
			clk4<=clk_4;
		end process;

end Behavioral;