--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:33:27 12/11/2016
-- Design Name:   
-- Module Name:   C:/Users/admin/Documents/FPGA/NYU_6463_processor/testbench.vhd
-- Project Name:  NYU_6463_processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Processor
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_textio.all;
library std;
use std.textio.all;

--library textutil;
--use textutil.std_logic_textio.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testbench IS
END testbench;
 
ARCHITECTURE behavior OF testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Processor
    PORT(
         clk_100 : IN  std_logic;
         btnc : IN  std_logic;
         din : IN  std_logic_vector(63 downto 0);
         ukey : IN  std_logic_vector(127 downto 0);
         encin : IN  std_logic;
         dout : OUT  std_logic_vector(63 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_100 : std_logic := '0';
   signal btnc : std_logic := '0';
   signal din : std_logic_vector(63 downto 0) := (others => '1');
   signal ukey : std_logic_vector(127 downto 0) := (others => '1');
   signal encin : std_logic := '0';

 	--Outputs
   signal dout : std_logic_vector(63 downto 0);

   -- Clock period definitions
   constant clk_100_period : time := 100 ps;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Processor PORT MAP (
          clk_100 => clk_100,
          btnc => btnc,
          din => din,
          ukey => ukey,
          encin => encin,
          dout => dout
        );

   -- Clock process definitions
   clk_100_process :process
   begin
		clk_100 <= '0';
		wait for clk_100_period/2;
		clk_100 <= '1';
		wait for clk_100_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
	
	file test_file : text is in "test.txt";
	file output_file : text is out "output.txt";
	variable L : Line;
	variable good : boolean;
	
	variable input, output : std_logic_vector(63 downto 0);
	variable k : std_logic_vector(127 downto 0);
	variable e : std_logic;
	
   begin
		
	while not ( endfile(test_file)) loop

		-- hold reset state for 100 ns.
      btnc	<=	'1';
		wait for 400 ps;
		btnc 	<= '0';
		
		wait for 200ps;
		
		readline(test_file, L);
		read(L, input, good);
			assert good
				report "I/O error" severity ERROR;
		
		read(L, k, good);
			assert good report "I/O error" severity ERROR;
			
		read(L, e, good);
			assert good report "I/O error" severity ERROR;
		
		read(L, output, good);
			assert good report "I/O error" severity ERROR;
		
		din <= input;
		ukey <= k;
		encin <= e;
		
		wait for 1250 ns;
		
		assert (dout = output)
			report "Output does not match" severity ERROR;
			

		write(L, string'("dout  : "));
		write(L, dout);
		writeline(output_file, L);
		write(L, string'("output: "));
		write(L, output);
		writeline(output_file, L);
		write(L, string'(""));
		writeline(output_file, L);
		
		wait for 500 ns;
		
		end loop;
		
		wait;
   end process;

END;
