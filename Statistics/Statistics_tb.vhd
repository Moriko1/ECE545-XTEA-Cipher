LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;

ENTITY Statistics_tb IS
END Statistics_tb;

ARCHITECTURE behavior OF Statistics_tb IS
   --constants
   constant n: integer:= 8;
   constant m: integer := 4;
  
   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal din : std_logic_vector(n-1 downto 0) := (others => '0');
   signal go : std_logic := '0';
   signal dout_mode : std_logic_vector(1 downto 0) := (others => '0');
   type arrays is array(0 to 2**m-1) of std_logic_vector(n - 1 downto 0);
   constant d_in_array: arrays := (x"C4", x"FF", x"1A", x"43", x"27", x"71", x"89", x"95", x"57", x"78", x"8B", x"CD", x"E6", x"92", x"EE", x"AA");
    
 	--Outputs
   signal done : std_logic;
   signal dout : std_logic_vector(n-1 downto 0);

   -- Clock period and initial delay definitions
   constant clk_period : time := 10 ns;
   
   -- Uncomment the initial_delay for Post Synthesis Timing Simulation and Post Implementation Timing simulation
   -- Comment out otherwise
   -- constant initial_delay: time:= 100 ns;

BEGIN

	-- Instantiate the Design Under Test (DUT)
   dut: ENTITY work.Statistics(Structure)
   -- Comment out the GENERIC MAP for Post-Synthesis and Post-Implementation Simulation
   -- Uncomment the GENERIC MAP for Behavioral Simulation
   GENERIC MAP(n => n, m=> m)
   PORT MAP (
          clk   => clk,
          reset => reset,
          din   => din,
          go    => go,
          dout_mode => dout_mode,
          done => done,
          dout => dout
        );

   -- Clock process definitions
clk <= not clk after clk_period/2;

-- Uncomment the below code for Behavioral Simulation, Post-Synthesis Functional Simulation and Post-Implementation Functional Simulation
-- Comment out otherwise
  reset <= '1', '0' after clk_period;
  go <= '1' after clk_period, '0' after 2*clk_period;

-- Uncomment the below code for Post-Synthesis Timing Simulation and Post-Implementation Timing Simulation
-- Comment out otherwise
-- reset <= '1' after initial_delay, '0' after initial_delay + clk_period;
-- go <= '1' after initial_delay + clk_period, '0' after initial_delay + 2*clk_period;

   -- Stimulus process
   stim_proc: process
   begin
       --Uncomment the below line for Post-Synthesis Timing Simulation and Post-Implementation Timing simulation
--        wait for initial_delay;
        wait for 2*clk_period;
		for i in 0 to 2**m-1 loop
		    din <= d_in_array(i);
		    wait for clk_period;
		end loop;

		wait until (done = '1') and falling_edge(clk);
        dout_mode <= "01";
        wait for clk_period;
        dout_mode <= "10";
        wait for clk_period;
        dout_mode <= "11";
		wait;
   end process;
   
END behavior;
