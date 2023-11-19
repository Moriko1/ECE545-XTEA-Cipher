-- VHDL 2008
library ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

-- Package declaration (as stand-in for external RAM)
package DK_pkg is
    constant rval : INTEGER := 3;
    constant wval : INTEGER := 16;
    subtype Dval is STD_LOGIC_VECTOR (wval-1 downto 0);
    type KRAM is array (0 to 3) of std_logic_vector(wval-1 downto 0);
end package DK_pkg;