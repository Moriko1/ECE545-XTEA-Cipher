-- VHDL 2008
library ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity Controller is
    port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        write_M : in STD_LOGIC;
        Zj : in STD_LOGIC;
        enV0 : out STD_LOGIC;
        enV1 : out STD_LOGIC;
        enSUM  : out STD_LOGIC;
        enj : out STD_LOGIC;
        enC : out STD_LOGIC;
        ldj : out STD_LOGIC;
        cyclenum : out STD_LOGIC;
        Done : out STD_LOGIC
    );
end Controller;

architecture behavioral of Controller is

type state is (S_Waiting, S_First_Half, S_Second_Half, S_Done);
signal Present_State, Next_State: state;
begin
    Mealy: process(clk, reset)
    begin
        if(reset = '1') then
            Present_State <= S_Waiting;
        elsif rising_edge(clk) then
            Present_State <= Next_State;
        end if;
    end process;

Next_State_Output: process(all)
    begin
        -- Default Values
        Next_State <= Present_State;
        --write_M <= '0';
        Done <= '0';
        --zj <= '0';
        enV0 <= '0';
        enV1 <= '0';
        enSUM <= '0';
        enj <= '0';
        enC <= '0';
        ldj <= '0';
        cyclenum <= '0';

        -- Logic
        case Present_State is
            when S_Waiting =>
            
                if write_M = '1' then
                    Next_State <= S_First_Half;
                    enSUM <= '1';
                    ldj <= '1';
                    enV0 <= '1';
                    enV1 <= '1';
                else
                    Next_State <= S_Waiting;
                end if;

            when S_First_Half =>
                
                Next_State <= S_Second_Half;
                enV0 <= '0';
                enSUM <= '0';
                cyclenum <= '0';
                
            when S_Second_Half =>
                
                enV1 <= '1';
                cyclenum <= '1';
                
                if Zj = '1' then
                    Next_State <= S_Done;
                    enC <= '1';
                else
                    Next_State <= S_First_Half;
                    enj <= '1';
                end if;
                
            when S_Done =>
            
                Done <= '1';
                Next_State <= S_Waiting;

        end CASE;
    end process;
end behavioral;