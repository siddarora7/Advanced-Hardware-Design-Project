----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:37:58 12/06/2016 
-- Design Name: 
-- Module Name:    datamem - Behavioral 
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

entity datamem is
	port (clk, clr : in std_logic;
			address, WriteData : in std_logic_vector(31 downto 0);
			isStore : in std_logic;
			check_mem : in std_logic_vector(6 downto 0);
			enc	:	in std_logic_vector(31 downto 0);
			disp_mem : out std_logic_vector(31 downto 0);
			ReadData : out std_logic_vector(31 downto 0);
			a : in std_logic_vector(31 downto 0);
			b : in std_logic_vector(31 downto 0);
			u0 : in std_logic_vector(31 downto 0);
			u1 : in std_logic_vector(31 downto 0);
			u2 : in std_logic_vector(31 downto 0);
			u3 : in std_logic_vector(31 downto 0);
			aout : out std_logic_vector(31 downto 0);
			bout : out std_logic_vector(31 downto 0));
end datamem;

architecture Behavioral of datamem is

type mem is array (0 to 127) of std_logic_vector(31 downto 0);
signal dmem : mem ;

begin
	ReadData <= dmem(conv_integer(address(6 downto 0)));
	disp_mem <= dmem(conv_integer(check_mem));
	aout	<=	dmem(38);
	bout	<=	dmem(39);
	
	process (clk) begin
		if (clk'event and clk = '1') then
			dmem(40) <= enc;
			dmem(0)	<= u3;
			dmem(1)	<= u2;
			dmem(2)	<=	u1;
			dmem(3)	<=	u0;
			dmem(36)	<=	a;
			dmem(37)	<= b;
			if (clr = '0') then
				dmem <= (x"00000000",x"00000000",x"00000000",x"00000000",-- User key
							x"00000000",x"00000000",x"00000000",x"00000000", -- L array
							x"B7E15163", -- Pw
							x"9E3779B9", -- Qw
							x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",-- skey
							x"00000000",x"00000000", -- A/B
							x"00000000",x"00000000", -- A'/B'
							x"00000000", -- Enc
							others => (others => '0'));
			elsif (isStore = '1') then
				dmem(conv_integer(address(6 downto 0))) <= WriteData;
			end if;
		end if;
	end process;
end Behavioral;

