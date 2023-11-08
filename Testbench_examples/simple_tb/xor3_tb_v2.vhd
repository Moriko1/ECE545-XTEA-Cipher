library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity xor3_tb_v2 is
end xor3_tb_v2;

architecture Behavioral of xor3_tb_v2 is

SIGNAL test_vector: STD_LOGIC_VECTOR(3 DOWNTO 0):="0000";
SIGNAL test_result : STD_LOGIC; 

begin

UUT : entity work.xor3(behavioral)
    PORT MAP (
            A => test_vector(2),
            B => test_vector(1),
            C => test_vector(0),
            result => test_result);
 
 Testing: PROCESS
    BEGIN
        WAIT FOR 10 ns;
        test_vector <= std_logic_vector(unsigned(test_vector) + 1); 
    END PROCESS;

end Behavioral;