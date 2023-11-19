-- VHDL 2008
library ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

--Start of main cipher
library ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.DK_pkg.all;

entity Cipher is
    Generic ( 
        r : integer := rval;
        w : integer := wval;
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
        Done : out STD_LOGIC
    );
end Cipher;
architecture Structure of Cipher is

SIGNAL Zj : STD_LOGIC;
SIGNAL enV0 : STD_LOGIC;
SIGNAL enV1 : STD_LOGIC;
SIGNAL enSUM  : STD_LOGIC;
SIGNAL enj : STD_LOGIC;
SIGNAL enC : STD_LOGIC;
SIGNAL ldj : STD_LOGIC;
SIGNAL cyclenum : STD_LOGIC;
begin

	Cipher_Controller : entity work.Controller(Behavioral)
    PORT MAP(
        clk => clk,
        reset => reset,
        write_M => write_M,
        zj => zj,
        enV0 => enV0,
        enV1 => enV1,
        enSUM => enSUM,
        enj => enj,
        enC => enC,
        ldj => ldj,
        cyclenum => cyclenum,
        Done => Done
    );
    
	Cipher_Datapath : entity work.Datapath(mixed)
    GENERIC MAP(
        r=>r,
        w=>w,
        DELTA=>DELTA,
        K=>K
        )
    PORT MAP(
        clk => clk,
        reset => reset,
        M => M,
        write_M => write_M,
        Ki => Ki,
        write_Ki => write_Ki,
        i => i,
        C => C,
        
        enV0 => enV0,
        enV1 => enV1,
        enSUM => enSUM,
        enj => enj,
        enC => enC,
        ldj => ldj,
        cyclenum => cyclenum,
        zj => zj
    );
    
end Structure;