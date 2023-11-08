library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor3_tb is
end xor3_tb;

architecture Behavioral of xor3_tb is

SIGNAL test_vector: STD_LOGIC_VECTOR(2 DOWNTO 0);
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
        test_vector <= "000";
        WAIT FOR 10 ns;
        test_vector <= "001";
        WAIT FOR 10 ns;
        test_vector <= "010";
        WAIT FOR 10 ns;
        test_vector <= "011";
        WAIT FOR 10 ns;
        test_vector <= "100";
        WAIT FOR 10 ns;
        test_vector <= "101";
        WAIT FOR 10 ns;
        test_vector <= "110";
        WAIT FOR 10 ns;
        test_vector <= "111";
        WAIT FOR 10 ns;
    END PROCESS;

end Behavioral;
