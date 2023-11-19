-- VHDL 2008
library ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.DK_pkg.all;

entity Datapath is
generic(
        r : INTEGER := 3;
        w : INTEGER := 16;
       DELTA : Dval := x"800A";
       K : KRAM := (x"ABCD", x"CCCC", x"6666", x"FEDC")
    );
    Port ( 
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        M : in STD_LOGIC_VECTOR (w+w-1 downto 0);
        write_M : in STD_LOGIC;
        Ki : in STD_LOGIC_VECTOR (w-1 downto 0);
        write_Ki : in STD_LOGIC;
        i : in STD_LOGIC_VECTOR (1 downto 0);
        C : out STD_LOGIC_VECTOR (w+w-1 downto 0);
        
        enV0 : in STD_LOGIC;
        enV1 : in STD_LOGIC;
        enSUM  : in STD_LOGIC;
        enj : in STD_LOGIC;
        enC : in STD_LOGIC;
        ldj : in STD_LOGIC;
        cyclenum : in STD_LOGIC;
        Zj : out STD_LOGIC
    );
end Datapath;

---------------------------


architecture Mixed of Datapath is

SIGNAL V0 : STD_LOGIC_VECTOR (w-1 downto 0);
SIGNAL V1: STD_LOGIC_VECTOR (w-1 downto 0);
SIGNAL V0_new : STD_LOGIC_VECTOR (w-1 downto 0);
SIGNAL V1_new : STD_LOGIC_VECTOR (w-1 downto 0);
SIGNAL W00 : STD_LOGIC_VECTOR (w-1 downto 0);
SIGNAL W01 : STD_LOGIC_VECTOR (w-1 downto 0);
SIGNAL W10 : STD_LOGIC_VECTOR (w-1 downto 0);
SIGNAL W11 : STD_LOGIC_VECTOR (w-1 downto 0);
SIGNAL T0 : STD_LOGIC_VECTOR (w-1 downto 0);
SIGNAL T1 : STD_LOGIC_VECTOR (w-1 downto 0);
SIGNAL SUM : STD_LOGIC_VECTOR (w-1 downto 0);
SIGNAL SUM_new : STD_LOGIC_VECTOR (w-1 downto 0);

begin











/*
    --REG 1 
    REG1 : PROCESS(clk,reset)
    BEGIN
        if reset = '1' then
            no_1 <= (others => '0');
        elsif rising_edge(clk) then
            if en1 = '1' then
                no_1 <= din;
            end if;
        end if;
    end process;

    --Mux s2 select
    muxs2_out <= no_1 when s2 = '0' else
                     din;

    --REG 2
    REG2 : PROCESS(clk,reset)
    BEGIN
        if reset = '1' then
            no_2 <= (others => '0');
        elsif rising_edge(clk) then
            if en2 = '1' then
                no_2 <= muxs2_out;
            end if;
        end if;
    end process;

    --Mux s3 select
    muxs3_out <= no_2 when s3 = '0' else
                     din;


    --REG 3 
    REG3 : PROCESS(clk,reset)
    BEGIN
        if reset = '1' then
            no_3 <= (others => '0');
        elsif rising_edge(clk) then
            if en3 = '1' then
                no_3 <= muxs3_out;
            end if;
        end if;
    end process;

    --gt1 comparator
    gt1 <= '1' when din > no_1 else
             '0';
    --gt2 comparator
    gt2 <= '1' when din > no_2 else
             '0';
    --gt3 comparator
    gt3 <= '1' when din > no_3 else
             '0';


    --REG 4 SUM 
    REG4 : PROCESS(clk,reset)
    BEGIN
        if reset = '1' then
            sum <= (others => '0');
        elsif rising_edge(clk) then
            if esum = '1' then
                sum <= std_logic_vector(unsigned(din) + unsigned(sum));
            end if;
        end if;
    end process;

    --shifter
    avr <= sum(n+m-1 downto m);

    --Counter
    upcount: PROCESS(clk,reset)
    BEGIN
        if reset = '1' then
            i <= (others => '0');
        elsif rising_edge(clk) then
            if enc = '1' then
                i <= i + 1;
            end if;
        end if;
    end process;
    zi <= '1' when (i = countCheck) else
            '0';

    --dout block
    with dout_mode select
        dout <= avr when "00",
                    no_1 when "01",
                    no_2 when "10",
                    no_3 when others;
*/

end Mixed;
