library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Generating_all_possible_values_of_two_inputs is
end Generating_all_possible_values_of_two_inputs;

architecture Behavioral of Generating_all_possible_values_of_two_inputs is

SIGNAL test_ab : STD_LOGIC_VECTOR(1 downto 0);
SIGNAL test_sel : STD_LOGIC_VECTOR(1 downto 0);

begin

double_loop: PROCESS
BEGIN
 test_ab <="00";
 test_sel <="00";
 for I in 0 to 3 loop
    for J in 0 to 3 loop
        wait for 10 ns;
        test_ab <= std_logic_vector(unsigned(test_ab) + 1);
    end loop;
    test_sel <= std_logic_vector(unsigned(test_sel) + 1);
 end loop;
END PROCESS;

end Behavioral;
