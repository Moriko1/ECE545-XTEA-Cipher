LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_textio.all;

LIBRARY std;
USE std.textio.all;

ENTITY loadCnt_hex_TB IS
END loadCnt_hex_TB;

ARCHITECTURE testbench OF loadCnt_hex_TB IS

    COMPONENT loadCnt
        PORT (
            data: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            load: IN STD_LOGIC;
            clk: IN STD_LOGIC;
            rst: IN STD_LOGIC;
            q: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
            );
    END COMPONENT;
     
    FILE vectorFile: TEXT OPEN READ_MODE is "vectorfile_hex.txt";
    SIGNAL Data: STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Load: STD_LOGIC;
    SIGNAL Rst: STD_LOGIC;
    SIGNAL Qout: STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Qexpected: STD_LOGIC_VECTOR(7 DOWNTO 0);
    
    SIGNAL TestClk: STD_LOGIC := '0';
    CONSTANT ClkPeriod: TIME := 100 ns;
    
    BEGIN
    -- Free running test clock
    TestClk <= NOT TestClk AFTER ClkPeriod/2;
    
    -- Instance of design being tested
    u1: loadCnt PORT MAP (Data => Data,
                          load => Load,
                          clk => TestClk,
                          rst => Rst, 
                          q => Qout
                          );
                          
-- File reading and stimulus application
    readVec: PROCESS
        VARIABLE VectorLine: LINE;
        VARIABLE VectorValid: BOOLEAN;
        VARIABLE vRst: STD_LOGIC;
        VARIABLE vLoad: STD_LOGIC;
        VARIABLE vData: STD_LOGIC_VECTOR(7 DOWNTO 0);
        VARIABLE vQ: STD_LOGIC_VECTOR(7 DOWNTO 0);
        VARIABLE space: CHARACTER;                
        
        BEGIN
            WHILE NOT ENDFILE (vectorFile) LOOP
                readline(vectorFile, VectorLine); -- put file data into line
                
                read(VectorLine, vRst, good => VectorValid);
                NEXT WHEN NOT VectorValid;
                read(VectorLine, space);
                read(VectorLine, vLoad);
                read(VectorLine, space);
                hread(VectorLine, vData);
                read(VectorLine, space);
                hread(VectorLine, vQ);
                
                WAIT FOR ClkPeriod/4;
                Rst <= vRst;
                Load <= vLoad;
                Data <= vData;
                Qexpected <= vQ;
                
                WAIT FOR (ClkPeriod/4) * 3;
            END LOOP;
            
            ASSERT FALSE
            REPORT "Simulation complete"
            SEVERITY NOTE;
            
            WAIT;
        END PROCESS;
        
-- Process to verify outputs
    verify: PROCESS (TestClk)
        variable ErrorMsg: LINE;
        BEGIN
            IF (TestClk'event AND TestClk = '0') THEN
                IF Qout /= Qexpected THEN
                    write(ErrorMsg, STRING'("Vector failed "));
                    write(ErrorMsg, now);
                    writeline(output, ErrorMsg);
                END IF;
            END IF;
        END PROCESS;

END testbench;                              