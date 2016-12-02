library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;
entity IO is
	port(
		rst 			: in std_logic;
		clk 			: in std_logic;

		MemWrite		: in std_logic;
		MemRead			: in std_logic;
		data		: in std_logic_vector(15 downto 0);--WriteData  IN
		addr		: in std_logic_vector(15 downto 0);--MemAddr IN
		pcaddr		: in std_logic_vector(15 downto 0);	
		MemData		: out std_logic_vector(15 downto 0);--MemData OUT
		PC			: out std_logic_vector(15 downto 0);--PC OUT

		tbre			: in std_logic;
		tsre			: in std_logic;
		rdn 			: inout std_logic;
		wrn				: inout std_logic;
		data_ready		: in std_logic;

		ram1_en 		: out std_logic;
		ram1_oe			: out std_logic;
		ram1_we			: out std_logic;
		ram1_addr		: out std_logic_vector(17 downto 0);
		ram1_data		: inout std_logic_vector(15 downto 0);

		ram2_en			: out std_logic;
		ram2_oe			: out std_logic;
		ram2_we			: out std_logic;
		ram2_addr		: out std_logic_vector(17 downto 0);
		ram2_data		: inout std_logic_vector(15 downto 0)
		
	);
end IO;

architecture Behavioral of IO is
	signal state : std_logic_vector(2 downto 0) := "000";
	signal flag : std_logic :='0';
begin 
ram1_en<= '1';
ram1_oe<= '1';
ram1_we<= '1';
	process(clk, rst)
	begin
		if rst = '0' then
			state <= "000";
			ram2_en <= '1';
			ram2_oe <= '1';
			ram2_we <= '1';
		elsif clk'event and clk = '1' then
			
			

			case state is
				when "000" =>--取指�
					if (MemRead = '1') then
						rdn<= '1';
					ram1_data<="ZZZZZZZZZZZZZZZZ";
						
					elsif(MemWrite = '1') then
						
						
					end if ;
					ram2_en <= '0';
					
					wrn<='1';
					ram2_data <= "ZZZZZZZZZZZZZZZZ";
					ram2_we <= '1';
					ram2_oe <= '0';
					ram2_addr <= "00"&pcaddr;
					state <= "001";
				when "001" =>
					PC <= ram2_data;
					--if(pcaddr = x"0000") then
					--	PC<= x"6941";
					--elsif(pcaddr = x"0001") then
					--	PC<= x"6a01";
					--elsif(pcaddr = x"0002") then
					--	PC<= x"6bbf";
					--elsif(pcaddr = x"0003") then
					--	PC<= x"3360";
					--elsif(pcaddr = x"0004") then
					--	PC<= x"db20";
					--elsif(pcaddr = x"0005") then
					--	PC <= x"6c09";--x"e800";
					--else
					--	PC<= x"6c09";
					--end if;
					ram2_oe <='1';
					state <= "010";
				when "010" =>--读写内存
					if (MemRead = '1') then
						if(addr = x"BF01") then
							MemData(15 downto 2)<=(others => '0');
							MemData(1)<= data_ready;
							MemData(0)<= tsre and tbre;
							
						elsif(addr = x"BF00") then
							rdn<='0';
							
						else 
							ram2_data <= "ZZZZZZZZZZZZZZZZ";
							ram2_we <= '1';
							ram2_oe <= '0';
							ram2_addr <= "00"&addr;
							
						end if;
						
					elsif(MemWrite = '1') then
						if(addr = x"BF00")then
							ram1_data<= data;
							wrn<='0';
						
						else
							ram2_oe <= '1';
							ram2_data <= data;
							ram2_addr <= "00"&addr;
							ram2_we <= '0';
							
						end if;
						
					
					end if ;
						state<="011";
				when "011" =>
					if (MemRead = '1') then
						if(addr = x"BF01") then
							null;
							
						elsif(addr = x"BF00") then
								MemData(7 downto 0) <= ram1_data(7 downto 0);
								MemData(15 downto 8)<=(others=>'0');
						else 
							MemData <= ram2_data;
							ram2_oe <= '1';
							
						end if;
						
					elsif(MemWrite = '1') then
						if(addr = x"BF00")then
							wrn <= '1';
						
						else
							ram2_we <= '1';
							
						end if;
						
					
					end if ;
						state<="000";
					
				
				when others =>
					state <= "000";
			end case;
		end if;
	end process;
end Behavioral;