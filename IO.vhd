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
		ram1_addr		: out std_logic_vector(15 downto 0);
		ram1_data		: inout std_logic_vector(15 downto 0);

		ram2_en			: out std_logic;
		ram2_oe			: out std_logic;
		ram2_we			: out std_logic;
		ram2_addr		: out std_logic_vector(15 downto 0);
		ram2_data		: inout std_logic_vector(15 downto 0)
		
	);
end IO;

architecture Behavioral of IO is
	signal state : std_logic_vector(2 downto 0) := "00";
begin 
	process(clk, rst)
	begin
		if rst = '0' then
			state <= "000";
			ram2_en <= '1';
			ram1_en <= '1';
		elsif clk'event and clk = '1' then
			ram2_en <= '0';
			case state is
				when "000" =>--取指令
					ram2_data <= "ZZZZZZZZZZZZZZZZ";
					ram2_we <= '1';
					ram2_oe <= '0';
					ram2_addr <= pcaddr;
					state <= "001";
				when "001" =>
					PC <= ram2_data;
					ram2_oe <='1';
					state <= "010";
				when "010" =>--读写内存
					if (MemRead = '1') then
						ram2_data <= "ZZZZZZZZZZZZZZZZ";
						ram2_we <= '1';
						ram2_oe <= '0';
						ram2_addr <= addr;
						state <= "011";
					elsif(MemWrite = '1') then
						ram2_oe <= '1';
						ram2_data <= data;
						ram2_addr <= addr;
						ram2_we <= '0';
						state <= "100";
					else
						state <= "101";
					end if ;
				when "011" =>
					MemData <= ram2_data;
					ram2_oe <='1';
					state <= "000";
				when "100" =>
					ram2_we <= '1';
					state <= "000";
				when "101" =>
					state <= "000";
			end case;
		end if;
	end process;