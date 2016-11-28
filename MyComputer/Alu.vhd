library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL ;
use IEEE.STD_LOGIC_UNSIGNED.ALL ;

entity Alu is
    Port ( Op1 : in  STD_LOGIC_VECTOR (15 downto 0);
           Op2 : in  STD_LOGIC_VECTOR (15 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           result : out  STD_LOGIC_VECTOR (15 downto 0));
end Alu;

architecture Behavioral of Alu is
	
begin
	
	process
	variable tempANS : std_logic_vector(16 downto 0) := "00000000000000000" ;
	variable tempresult : std_logic_vector(15 downto 0) := "0000000000000000" ;
	variable tempB : std_logic_vector(3 downto 0) := "0000" ;
	
	begin
		case Op is
			when "0000" => 
				tempANS := ('0'&Op1)+('0'&Op2) ;
				tempresult := tempANS(15 downto 0) ;
			when "0001" =>
				tempANS := ('0'&Op1)-('0'&Op2) ;
				tempresult := tempANS(15 downto 0) ;
			when "0010" => tempresult := (Op1 AND Op2) ;
			when "0011" => tempresult := (Op1 OR Op2) ;
			when "0100" => tempresult := (Op1 XOR Op2) ;
			when "0101" => tempresult := NOT Op1 ;
			when "0110" => 
				tempB := Op2(3 downto 0) ;
				tempresult := to_stdlogicvector(to_bitvector(Op1) SLL conv_integer(Op2)) ;
			when "0111" => 
				tempB := Op2(3 downto 0) ;
				tempresult := to_stdlogicvector(to_bitvector(Op1) SRL conv_integer(Op2)) ;
			when "1000" => 
				tempB := Op2(3 downto 0) ;
				tempresult := to_stdlogicvector(to_bitvector(Op1) SRA conv_integer(Op2)) ;
			when "1001" => 
				tempB := Op2(3 downto 0) ;
				tempresult := to_stdlogicvector(to_bitvector(Op1) ROL conv_integer(Op2)) ;
			when others => tempresult := "0000000000000000" ;
		end case ;
		result <= tempresult ;
	end process ;

end Behavioral;


















