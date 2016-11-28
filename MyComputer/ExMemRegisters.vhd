library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ExMemRegisters is
	port(
			clk : in std_logic;
			rst : in std_logic;
			
			ExData : in std_logic_vector(15 downto 0);
			ExRd : in std_logic_vector(3 downto 0);
			AluRes : in std_logic_vector(15 downto 0);
			
			ExRegWrite : in std_logic;
			ExMemRead : in std_logic;
			ExMemWrite : in std_logic;
			ExMemtoReg : in std_logic;

			Addr : out std_logic_vector(15 downto 0);
			Data : out std_logic_vector(15 downto 0);
			MemRd : out std_logic_vector(3 downto 0);
			MemAluRes : out std_logic_vector(15 downto 0);

			
			MemWrite : out std_logic;
			MemRead : out std_logic;
			MemtoReg : out std_logic
	);
end ExMemRegisters;

architecture Behavioral of ExMemRegisters is

begin
	process(rst,clk)
	begin
		if (rst = '0') then
			MemRd <= (others => '0');
			MemAluRes <= (others => '0');
			MemWrite <= '0';
			MemRead <= '0';
			MemtoReg <= '0';
			Addr <= (others => '0');
			Data <= (others => '0');
		elsif (clk'event and clk = '1') then
			MemRd <= ExRd;
			MemAluRes <= AluRes;
		
			MemRead <= ExMemRead;
			MemWrite <= ExMemWrite;
			MemtoReg <= ExMemtoReg;
			
			Addr <= AluRes;
			Data <= ExData;
		end if;
	end process;
			

end Behavioral;
--输出
--1、MemWrite，MemRead；
--2、MemtoReg
--3、Addr,Data,MemRd,MemAluRes;
