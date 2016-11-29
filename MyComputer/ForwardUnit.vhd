----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:45:59 11/19/2015 
-- Design Name: 
-- Module Name:    ForwardUnit - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ForwardUnit is
	port(
			MemRd : in std_logic_vector(3 downto 0);
			WBRd : in std_logic_vector(3 downto 0);
			ExRx : in std_logic_vector(3 downto 0);
			ExRy : in std_logic_vector(3 downto 0);
			
			MemRegWrite : in std_logic;
			WBRegWrite : in std_logic;
			
			
			Forward1 : out std_logic_vector(1 downto 0);
			Forward2 : out std_logic_vector(1 downto 0)
	);
end ForwardUnit;

architecture Behavioral of ForwardUnit is
begin
	process(MemRd, WBRd, MemRegWrite, WBRegWrite, ExRx, ExRy)
	begin
		
		if (MemRegWrite = '1'  and MemRd = ExRx) then--Rx与Mem阶段目的寄存器相�
			Forward1 <= "10";--� MemData
		elsif (WBRegWrite = '1' and WBRd = ExRx ) then--Rx与WB阶段的目的寄存器相同
			Forward1 <= "01";--� WBData
		--可以加特殊寄存器的转发处�
		else
			Forward1 <="00";
		end if;
		
		
		if (MemRegWrite = '1' and MemRd = ExRy) then--Ry与Mem阶段目的寄存器相�
			Forward2 <= "10";--� MemData
		elsif (WBRegWrite = '1' and WBRd = ExRy) then--Ry与WB阶段的目的寄存器相同
			Forward2 <= "01";--� WBData
		else 
			Forward2 <= "00";
		end if;
	end process;


end Behavioral;

