library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity report_example is
end report_example;

architecture behavioral of report_example is
    signal clk : std_logic := '0';

begin

    clk <= not clk after 100 ns;
    
    process
        begin
            wait for 1000 ns;
            report "Initialization complete";
            report "Current time = " & time'image(now);
            wait for 1000 ns;
            report "SIMULATION COMPLETED" severity failure;
    end process;
    
end behavioral;