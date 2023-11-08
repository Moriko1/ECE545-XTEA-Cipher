library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity record_example is
end record_example;

architecture Behavioral of record_example is

    TYPE test_vector IS RECORD
        operation : STD_LOGIC_VECTOR(1 DOWNTO 0);
        a : STD_LOGIC;
        b: STD_LOGIC;
        y : STD_LOGIC;
    END RECORD;
    
    CONSTANT num_vectors : INTEGER := 16;
    
    TYPE test_vectors IS ARRAY (0 TO num_vectors-1) OF test_vector;
    
    CONSTANT and_op : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
    CONSTANT or_op : STD_LOGIC_VECTOR(1 DOWNTO 0) := "01";
    CONSTANT xor_op : STD_LOGIC_VECTOR(1 DOWNTO 0) := "10";
    CONSTANT xnor_op : STD_LOGIC_VECTOR(1 DOWNTO 0) := "11";
    
    CONSTANT test_vector_table: test_vectors :=(
    (operation => AND_OP, a=>'0', b=>'0', y=>'0'),
    (operation => AND_OP, a=>'0', b=>'1', y=>'0'),
    (operation => AND_OP, a=>'1', b=>'0', y=>'0'),
    (operation => AND_OP, a=>'1', b=>'1', y=>'1'),
    (operation => OR_OP, a=>'0', b=>'0', y=>'0'),
    (operation => OR_OP, a=>'0', b=>'1', y=>'1'),
    (operation => OR_OP, a=>'1', b=>'0', y=>'1'),
    (operation => OR_OP, a=>'1', b=>'1', y=>'1'),
    (operation => XOR_OP, a=>'0', b=>'0', y=>'0'),
    (operation => XOR_OP, a=>'0', b=>'1', y=>'1'),
    (operation => XOR_OP, a=>'1', b=>'0', y=>'1'),
    (operation => XOR_OP, a=>'1', b=>'1', y=>'0'),
    (operation => XNOR_OP, a=>'0', b=>'0', y=>'1'),
    (operation => XNOR_OP, a=>'0', b=>'1', y=>'0'),
    (operation => XNOR_OP, a=>'1', b=>'0', y=>'0'),
    (operation => XNOR_OP, a=>'1', b=>'1', y=>'1')
    );
    
    
    SIGNAL test_operation : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL test_a : STD_LOGIC;
	SIGNAL test_b : STD_LOGIC;
	SIGNAL test_y : STD_LOGIC;


begin

	DUT: entity work.ALU(dataflow)
                    PORT MAP (operation => test_operation,
							a => test_a,
							b => test_b,
							y  => test_y);
								
	testing: PROCESS

	VARIABLE error_cnt: INTEGER := 0;

	BEGIN
	FOR i IN 0 to num_vectors-1 LOOP
			test_operation <= test_vector_table(i).operation;
			test_a <= test_vector_table(i).a;
			test_b <= test_vector_table(i).b;
			WAIT FOR 10 ns;
			IF test_y /= test_vector_table(i).y THEN
				error_cnt := error_cnt + 1;
			END IF;
		END LOOP;
	END PROCESS testing;

end Behavioral;
