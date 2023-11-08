library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY loadCnt IS

PORT (
    data: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    load: IN STD_LOGIC;
    clk: IN STD_LOGIC;
    rst: IN STD_LOGIC;
    q: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
);

END loadCnt;

architecture rtl of loadCnt is

SIGNAL cnt: STD_LOGIC_VECTOR (7 DOWNTO 0);

begin

    counter: PROCESS (clk, rst)
    BEGIN
        IF (rst = '1') THEN
            cnt <= (OTHERS => '0');
        ELSIF (clk'event AND clk = '1') THEN
            IF (load = '1') THEN
                cnt <= data;
            ELSE
                cnt <= std_logic_vector(unsigned(cnt) + 1);
            END IF;
        END IF;
    END PROCESS;

    q <= cnt;

end rtl;
