library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MemWbRegisters is
	port(
			clk : in std_logic;
			rst : in std_logic;
			
			MemData : in std_logic_vector(15 downto 0);
			MemAluRes : in std_logic_vector(15 downto 0);
			MemRd : in std_logic_vector(3 downto 0);
			
			MemRegWrite : in std_logic;--控制信号
			MemtoReg : in std_logic;--控制信号，内部使用
			
			WBRd : out std_logic_vector(3 downto 0);
			RegWrite : out std_logic;
			WBData : out std_logic_vector(15 downto 0)
	);
end MemWbRegisters;

architecture Behavioral of MemWbRegisters is

begin
	process(clk, rst)
	begin
		if (rst = '0') then
			RegWrite <= '0';
			WBRd <= (others => '0');
			WBData <= (others => '0');
		elsif (clk'event and clk = '1') then
			WBRd <= MemRd;
			RegWrite <= MemRegWrite;
			
			if (MemtoReg = '1') then
				WBData <= MemData;
			else 
				WBData <= MemAluRes;
			end if;
		end if;
	end process;

end Behavioral;

--输出
--1、写回的数据
--2、寄存器堆写信号
--3、目的寄存器的地址