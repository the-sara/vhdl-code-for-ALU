library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity alu is 
port(
a,b :in std_logic_vector(7 downto 0);
alu_sel:in std_logic_vector(2 downto 0);--to select operation
result:out std_logic_vector(7 downto 0);
NZVC:out std_logic_vector(3 downto 0));--the flags 
end entity;

architecture logic of alu is 
signal carry_check:std_logic_vector(8 downto 0);
begin 
process(alu_sel)--operation selection 
begin
case alu_sel is 
	when "000"=>
		result<= a+b;
		carry_check<= ('0' & a )+('0' & b);--additional bit 
	when "001"=>
		result<= a-b;
		carry_check<= ('0' & a )-('0' & b);
	when "010"=>result<= a and b;
	when "011"=>result<= a + 1;
	when "100"=>result<= a - 1;
	when others =>result<= null;
end case;
end process;
process(alu_sel)
begin 
if alu_sel="000" then add_result<=result;
elsif alu_sel="001" then sub_result<=result;
end if;
end process;
process(alu_sel)--falgs 
begin 
-- the negative flag:
if result(7)='1' then n<='1';
else N<='0';
end if ;
--the zero flag
if result = x"00" then Z<='1';
else Z<='0';
end if ;
--the overflow flag:
if ((a(7) and b(7)) and not(add_result(7))) or ((not(a(7)) and not(b(7))) and (add_result(7)))='1' then V<='1';
end if ;
if ((a(7) nad not(b(7))) and not(sub_result(7))) or ((not(a(7)) and b(7) ) and sub_result(7))='1' then v<='1';
end if ;
end process;

end logic;