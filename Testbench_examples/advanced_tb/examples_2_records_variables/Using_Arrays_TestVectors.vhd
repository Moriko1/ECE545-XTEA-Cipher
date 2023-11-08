LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY sevenSegmentTB IS
END sevenSegmentTB;

ARCHITECTURE testbench OF sevenSegmentTB IS

    COMPONENT sevenSegment
    PORT (
        bcdInputs : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        seven_seg_outputs : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
        );        
    end COMPONENT;

    CONSTANT PropDelay: time := 40 ns;
    CONSTANT SimLoopDelay: time := 10 ns;

    TYPE vector IS RECORD
        bcdStimulus: STD_LOGIC_VECTOR(3 DOWNTO 0);
        sevSegOut: STD_LOGIC_VECTOR(6 DOWNTO 0);
    END RECORD;

    CONSTANT NumVectors: INTEGER:= 10;

    TYPE vectorArray is ARRAY (0 TO NumVectors - 1) OF vector;

    CONSTANT vectorTable: vectorArray := (
    (bcdStimulus => "0000", sevSegOut => "0000001"),
    (bcdStimulus => "0001", sevSegOut => "1001111"),
    (bcdStimulus => "0010", sevSegOut => "0010010"),
    (bcdStimulus => "0011", sevSegOut => "0000110"),
    (bcdStimulus => "0100", sevSegOut => "1001100"),
    (bcdStimulus => "0101", sevSegOut => "0100100"),
    (bcdStimulus => "0110", sevSegOut => "0100000"),
    (bcdStimulus => "0111", sevSegOut => "0001111"),
    (bcdStimulus => "1000", sevSegOut => "0000000"),
    (bcdStimulus => "1001", sevSegOut => "0000100")
    );

    SIGNAL StimInputs: STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL CaptureOutputs: STD_LOGIC_VECTOR(6 DOWNTO 0);

BEGIN
    u1: sevenSegment PORT MAP (
    bcdInputs => StimInputs,
    seven_seg_outputs => CaptureOutputs
    );

    LoopStim: PROCESS
    BEGIN
        FOR i in 0 TO NumVectors-1 LOOP
            StimInputs <= vectorTable(i).bcdStimulus;
            WAIT FOR PropDelay;
            ASSERT CaptureOutputs = vectorTable(i).sevSegOut
                REPORT "Incorrect Output"
            SEVERITY error;
            WAIT FOR SimLoopDelay;
        END LOOP;

    WAIT;
    END PROCESS;

END testbench;