-- VHDL 1993
LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity Controller is
port (
    clk : in std_logic ;
    reset : in std_logic ;
    go  : in std_logic ;
    gt1 : in std_logic ;
    gt2 : in std_logic ;
    gt3 : in std_logic ;
    zi  : in std_logic ;
    esum : out std_logic;
    s2  : out std_logic;
    s3  : out std_logic;
    en1 : out std_logic;
    en2 : out std_logic;
    en3 : out std_logic;
    enc : out std_logic;
    done : out std_logic
    );
end Controller;

architecture behavioral of Controller is

type state is (S_Waiting, S_Calculating, S_Done);
signal Present_State, Next_State: state;

begin

    U_Mealy: process(clk, reset)
    begin
        if(reset = '1') then
            Present_State <= S_Waiting;
        elsif rising_edge(clk) then
            Present_State <= Next_State;
        end if;
    end process;


Next_State_Output:
    process(Present_State, go, gt1, gt2, gt3, zi)
    BEGIN

        -- default values
        Next_State <= Present_State;
        esum <= '0';
        s2   <= '-';
        s3   <= '-';
        en1  <= '0';
        en2  <= '0';
        en3  <= '0';
        enc  <= '0';
        done <= '0';

        case Present_State is
            when S_Waiting =>
                if go = '1' then
                    Next_State <= S_Calculating;
                else
                    Next_State <= S_Waiting;
                end if;

            when S_Calculating =>
                
                esum <= '1';
                
                if gt1 = '1' then
                    en1 <= '1';
                    en2 <= '1';
                    en3 <= '1';
                    s2  <= '0';
                    s3  <= '0';
                elsif gt2 = '1' then
                    en2 <= '1';
                    en3 <= '1';
                    s2  <= '1';
                    s3  <= '0';
                elsif gt3 = '1' then
                    en3 <= '1';
                    s3  <= '1';
                end if;
                if zi = '1' then
                    Next_State <= S_Done;
                else
                    enc <= '1';
                    Next_State <= S_Calculating;
                end if;
            when S_Done =>
                done <= '1';
                Next_State <= S_Done;

        end CASE;

    end process;
end behavioral;

