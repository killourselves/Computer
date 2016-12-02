----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:13:48 11/29/2016 
-- Design Name: 
-- Module Name:    MEM - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEM is
    Port (	
        	clk : in STD_LOGIC;
			rst : in STD_LOGIC;
			
         
			-- 取指令
			MemWrite		: in std_logic;
			MemRead			: in std_logic;
			data		: in std_logic_vector(15 downto 0);--WriteData  IN
			addr		: in std_logic_vector(15 downto 0);--MemAddr IN
			pcaddr		: in std_logic_vector(15 downto 0);	
			MemData		: out std_logic_vector(15 downto 0);--MemData OUT
			PC			: out std_logic_vector(15 downto 0);--PC OUT

			-- RAM
			ram1_data : inout std_logic_vector(15 downto 0);
			ram1_addr : out std_logic_vector(17 downto 0);
			ram1_en   : out std_logic := '0';
			ram1_we   : out std_logic := '1';
			ram1_oe   : out std_logic := '1';
			
			-- 串口
			data_ready : in std_logic;
			tbre       : in std_logic;
			tsre       : in std_logic;
			rdn        : out std_logic := '1';
			wrn        : out std_logic := '1';

			ram2_en			: out std_logic;
			ram2_oe			: out std_logic;
			ram2_we			: out std_logic;
			ram2_addr		: out std_logic_vector(17 downto 0);
			ram2_data		: inout std_logic_vector(15 downto 0)
			
			
			  
				
			  );
end MEM;

architecture Behavioral of MEM is
	
	
	-- 暂存一些数据
	
	
	-- 本地的一些数据
	shared variable MEM_STATE : INTEGER range 0 to 3 := 0;	-- 访存状态机
	signal mem_type : std_logic_vector(2 downto 0) := "000";	-- 访存类型
	
begin
process(clk, rst)
	begin
		if rst = '0' then
			-- 初始化相关数据
			MEM_STATE := 0;
			PC <= (others => '0');
			-- 此时仍然置为1
		elsif clk'event and clk = '1' then
																-- Flash读取完成
				case MEM_STATE is
					when 0 =>												-- 取指令
						ram1_en <= '0';
						ram1_oe <= '0';
						ram1_we <= '1';
						rdn <= '1';
						wrn <= '1';
						ram1_addr(17 downto 16) <= "00";
						ram1_addr(15 downto 0) <= pcaddr;
						ram1_data <= "ZZZZZZZZZZZZZZZZ";
					when 1 =>
						PC <= ram1_data;							-- 取出指令
						ram1_en <= '0';
						ram1_oe <= '1';
						ram1_we <= '1';
						rdn <= '1';
						wrn <= '1';
					when 2 =>
						if MemRead = '1' then				-- 读取数据
							case addr is
								when "1011111100000000" =>
									ram1_en <= '1';
									ram1_oe <= '1';
									ram1_we <= '1';
									rdn <= '0';						-- 串口？
									wrn <= '1';
									ram1_data <= "ZZZZZZZZZZZZZZZZ";
									ram1_addr(17 downto 16) <= "00";
									ram1_addr(15 downto 0) <= addr;
									
									mem_type <= "001";
								when "1011111100000001" =>
									ram1_en <= '1';
									ram1_oe <= '1';
									ram1_we <= '1';
									rdn <= '1';						-- 串口
									wrn <= '1';
									ram1_data <= "ZZZZZZZZZZZZZZZZ";
									ram1_addr(17 downto 16) <= "00";
									ram1_addr(15 downto 0) <= addr;
									
									mem_type <= "010";
								when others =>
									ram1_en <= '0';
									ram1_oe <= '0';
									ram1_we <= '1';
									rdn <= '1';
									wrn <= '1';
									ram1_data <= "ZZZZZZZZZZZZZZZZ";
									ram1_addr(17 downto 16) <= "00";
									ram1_addr(15 downto 0) <= addr;
									
									mem_type <= "011";
							end case;
						elsif MemWrite = '1' then			-- 写数据
							
							ram1_data <= data;
							if addr = "1011111100000000" then
								ram1_en <= '1';							-- 写BF00
								ram1_oe <= '1';
								ram1_we <= '1';
								rdn <= '1';
								wrn <= '0';
								ram1_addr(17 downto 16) <= "00";
								ram1_addr(15 downto 0) <= addr;
									
								mem_type <= "100";
							else
								ram1_en <= '0';							-- 血普通
								ram1_oe <= '1';
								ram1_we <= '0';
								rdn <= '1';
								wrn <= '1';
								ram1_addr(17 downto 16) <= "00";
								ram1_addr(15 downto 0) <= addr;
								
								mem_type <= "101";
							end if;
						else
							mem_type <= "000";
						end if;
					when 3 =>
						case mem_type is						-- 内存读写类型
							when "001" =>						-- 低8位
								MemData <= "00000000" & ram1_data(7 downto 0);
								rdn <= '1';
							when "010" =>
								MemData <= "00000000000000" & (data_ready) & (tbre and tsre);
							when "011" =>						
								MemData <= ram1_data;
								ram1_oe <= '1';
							when "100" =>
								wrn <= '1';
							when "101" =>
								ram1_we <= '1';
								
							when others =>
						end case;
					when others =>
				end case;
				
				if MEM_STATE = 3 then
					MEM_STATE := 0;
				else
					MEM_STATE := MEM_STATE + 1;
				end if;
			end if;
	end process;

end Behavioral;

