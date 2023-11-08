library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Statistics is
	 Generic ( n : INTEGER := 8;
			  m : INTEGER := 4);
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (n-1 downto 0);
           go  : in  STD_LOGIC;
           dout_mode : in  STD_LOGIC_VECTOR (1 downto 0);
           done : out  STD_LOGIC;
           dout : out  STD_LOGIC_VECTOR (n-1 downto 0));
end Statistics;

architecture Structure of Statistics is

SIGNAL gt1 : STD_LOGIC;
SIGNAL gt2 : STD_LOGIC;
SIGNAL gt3 : STD_LOGIC;
SIGNAL zi  : STD_LOGIC;
SIGNAL en1 : STD_LOGIC;
SIGNAL en2 : STD_LOGIC;
SIGNAL en3 : STD_LOGIC;
SIGNAL esum : STD_LOGIC;
SIGNAL enc : STD_LOGIC;
SIGNAL s2  : STD_LOGIC;
SIGNAL s3  : STD_LOGIC;

begin

	cont : entity work.Controller(Behavioral)
    PORT MAP(
        clk   => clk,
        reset => reset,
        go    => go,
        gt1   => gt1,
        gt2   => gt2,
        gt3   => gt3,
        zi    => zi,
        en1   => en1,
        en2   => en2,
        en3   => en3,
        esum  => esum,
        enc   => enc,
        s2    => s2,
        s3    => s3,
        done  => done
    );

	dp : entity work.Datapath(Mixed)
    GENERIC MAP(n=>n, m=>m)
    PORT MAP(
        clk   => clk,
        reset => reset,
        din   => din,
        dout_mode => dout_mode,
        gt1   => gt1,
        gt2   => gt2,
        gt3   => gt3,
        zi    => zi,
        en1   => en1,
        en2   => en2,
        en3   => en3,
        esum  => esum,
        enc   => enc,
        s2    => s2,
        s3    => s3,
        dout  => dout
    );

end Structure;
