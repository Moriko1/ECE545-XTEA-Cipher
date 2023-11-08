library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Assert_Examples is
end Assert_Examples;

architecture Behavioral of Assert_Examples is

begin

stim_proc: process
    begin
        wait for 20 ns;
        assert false
            report "PASSED CHECKPOINT 1"
        severity note;
        wait for 10 ns;
        assert false
            report "PASSED CHECKPOINT 2"
        severity warning;
        wait for 10 ns;
        assert false
            report "PASSED CHECKPOINT 3"
        severity error;
        wait for 10 ns;
        assert false
            report "PASSED CHECKPOINT 4"
        severity failure;
        wait;
    end process;

end Behavioral;
