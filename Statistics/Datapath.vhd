library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity Datapath is
     Generic ( n : INTEGER := 8;
               m : INTEGER := 4);
    Port (clk : in  STD_LOGIC;
          reset : in  STD_LOGIC;
          din : in  STD_LOGIC_VECTOR (n-1 downto 0);
          dout_mode : in  STD_LOGIC_VECTOR (1 downto 0);
          en1 : in  STD_LOGIC;
          en2 : in  STD_LOGIC;
          en3 : in  STD_LOGIC;
          esum : in  STD_LOGIC;
          enc : in  STD_LOGIC;
          s2 : in  STD_LOGIC;
          s3 : in  STD_LOGIC;
          gt1 : out  STD_LOGIC;
          gt2 : out  STD_LOGIC;
          gt3 : out  STD_LOGIC;
          zi : out  STD_LOGIC;
          dout : out  STD_LOGIC_VECTOR (n-1 downto 0));
end Datapath;

architecture Mixed of Datapath is

SIGNAL no_1 : STD_LOGIC_VECTOR(n-1 downto 0);
SIGNAL no_2 : STD_LOGIC_VECTOR(n-1 downto 0);
SIGNAL no_3 : STD_LOGIC_VECTOR(n-1 downto 0);
SIGNAL muxs2_out : STD_LOGIC_VECTOR(n-1 downto 0);
SIGNAL muxs3_out : STD_LOGIC_VECTOR(n-1 downto 0);
SIGNAL sum : STD_LOGIC_VECTOR(n+m-1 downto 0);

SIGNAL i : unsigned(m-1 downto 0);
CONSTANT countCheck : unsigned(m-1 downto 0) := (others => '1');


SIGNAL avr : STD_LOGIC_VECTOR(n-1 downto 0);

begin

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


end Mixed;
