library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IDExRegisters is
	port(
			clk : in std_logic;
			rst : in std_logic;

			RxAddr : in std_logic_vector(3 downto 0);
			RyAddr : in std_logic_vector(3 downto 0);
			Rx : in std_logic_vector(15 downto 0);
			Ry : in std_logic_vector(15 downto 0);
			imme : in std_logic_vector(15 downto 0);
IDPCAddimme : in std_logic_vector(15 downto 0);
			IDControl : in std_logic_vector(4 downto 0) ;
			-- RegWrite(4) ALUSrc(3) MemRead(2)MemWrite(1)MemtoReg(0)

			Command : in std_logic_vector(15 downto 0);
			IDAluOp : in std_logic_vector(3 downto 0);
IDBJOp : in std_logic_vector(2 downto 0);
			IDRd : in std_logic_vector(3 downto 0);

			ExRd : out std_logic_vector(3 downto 0);
			Eximme : out std_logic_vector(15 downto 0);
			ExRxAddr : out std_logic_vector(3 downto 0);
			ExRyAddr : out std_logic_vector(3 downto 0);
			ExRx : out std_logic_vector(15 downto 0);
			ExRy : out std_logic_vector(15 downto 0);
			AluOp : out std_logic_vector(3 downto 0);
ExBJOp : out std_logic_vector(2 downto 0);
ExPCAddimme : out std_logic_vector(15 downto 0);

			AluSrc : out std_logic;
			EXMemWrite : out std_logic;
			ExMemRead : out std_logic;
			ExMemtoReg : out std_logic;
			ExRegWrite : out std_logic
	);
end IDExRegisters;

architecture Behavioral of IDExRegisters is
		signal repcaddimme : std_logic_vector(15 downto 0);
begin
	ExPCAddimme<= repcaddimme;
	process(rst,clk)
	begin
		if (rst = '0') then
			ExRd <= (others => '1');
			Eximme <= (others => '0');
			ExRxAddr <= (others => '0');
			ExRyAddr <= (others => '0');
			ExRx <= (others => '0');
			ExRy <= (others => '0');
			AluOp <= (others => '1');
			ExBJOp <= "101";
			repcaddimme <= (others => '0');
			AluSrc <= '0';
			ExMemRead <= '0';
			ExMemWrite <= '0';
			ExMemtoReg <= '0';
			ExRegWrite <= '0';

		elsif (clk'event and clk = '1') then
				ExRd <= IDRd;
				Eximme <= imme;
				ExRxAddr <= RxAddr;
				ExRyAddr <= RyAddr;
				ExRx <= Rx;
				ExRy <= Ry;
				AluOp <= IDAluOp;
				ExBJOp <= IDBJOp;
				repcaddimme <= IDPCAddimme;

				AluSrc <= IDControl(3);
				ExMemRead <= IDControl(2);
				ExMemWrite <= IDControl(1);
				ExMemtoReg <= IDControl(0);
				ExRegWrite <= IDControl(4);
		
		end if;
	end process;
			

end Behavioral;
--输出

