----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:03:59 11/22/2016 
-- Design Name: 
-- Module Name:    RF - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RF is
	port (r1, r2, wr : in std_logic_vector(4 downto 0);
			data : in std_logic_vector(31 downto 0);
			wrt_en, clk, clr : in std_logic;
			check_reg : in std_logic_vector(4 downto 0);
			disp_reg : out std_logic_vector(31 downto 0);
			r1_out, r2_out : out std_logic_vector(31 downto 0)
			);
end RF;

architecture Behavioral of RF is

type ram is array (0 to 31) of std_logic_vector(31 downto 0); --32 32-bit registers
signal registers : ram := ram '(others => (others => '0')); --Initiate all to 0
begin

	--Write data to RF if write enabled
	process (clk, clr) begin
		if (clk'event and clk = '1') then
			if (clr = '0') then
				registers <= (others => (others => '0'));
			elsif (wrt_en = '1') then
				registers(conv_integer(wr)) <= data;
			end if;
		end if;
	end process;
	
	--Read from register file
	r1_out <= registers(conv_integer(r1));
	r2_out <= registers(conv_integer(r2));
	
	disp_reg <= registers(conv_integer(check_reg));
end Behavioral;

