library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sevenSegment is
    Port ( bcdInputs : in STD_LOGIC_VECTOR (3 downto 0);
           seven_seg_outputs : out STD_LOGIC_VECTOR (6 downto 0)
           );
end sevenSegment;

architecture Behavioral of sevenSegment is

begin

    with bcdInputs select
        seven_seg_outputs <=
            "0000001" when "0000",
            "1001111" when "0001",
            "0010010" when "0010",
            "0000110" when "0011",
            "1001100" when "0100",
            "0100100" when "0101",
            "0100000" when "0110",
            "0001111" when "0111",
            "0000000" when "1000",
            "0000100" when "1001",
            "0000001" when others;

end Behavioral;
