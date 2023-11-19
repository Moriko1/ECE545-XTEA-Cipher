library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity KRAM is
  generic 
	(
w: integer := 8; --word size
k: integer := 2 -- number of address bits
);
port (
  DINA, DINB: in std_logic_vector(w-1 downto 0);
  DOUTA, DOUTB: out std_logic_vector(w-1 downto 0);
  ADDRA, ADDRB: in std_logic_vector(k-1 downto 0);
  WEA, WEB: in std_logic;
  CLK: in std_logic
);
end KRAM;

architecture behavioral of KRAM is

type ram_type is array (0 to 2**k-1) of std_logic_vector(w-1 downto 0);
shared variable RAM: ram_type := (others =>(others=>'0'));

begin

APORT: process(CLK)
begin
if rising_edge(CLK) then
    DOUTA <= RAM(to_integer(unsigned(ADDRA)));
    if WEA = '1' then
        RAM(to_integer(unsigned(ADDRA))) := DINA;
    end if;
end if;
end process;

BPORT: process(CLK)
begin
if rising_edge(CLK) then
    DOUTB <= RAM(to_integer(unsigned(ADDRB)));
    if WEB = '1' then
        RAM(to_integer(unsigned(ADDRB))) := DINB;
    end if;
end if;
end process;

end behavioral;
