library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor3 is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C : in STD_LOGIC;
           result : out STD_LOGIC);
end xor3;

architecture behavioral of xor3 is

begin
xor3_behave: PROCESS (A, B, C) 
    BEGIN
        IF ((A XOR B XOR C) = '1') THEN
            result <= '1';
        ELSE
            result <= '0';
        END IF;
    END PROCESS xor3_behave; 

end behavioral;
