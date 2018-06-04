----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:02:18 11/27/2016 
-- Design Name: 
-- Module Name:    decoder - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder is
port (
		instruction: in std_logic_vector (31 downto 0);
		isEq : in std_logic;
		isLess : in std_logic;
		isLoad : out std_logic;
		isStore : out std_logic;
		isIType : out std_logic;
		ALUOp : out std_logic_vector (2 downto 0);
		WrtEnable : out std_logic;
		nextPC : out std_logic_vector (1 downto 0)
		);
	
end decoder;

architecture Behavioral of decoder is

signal isRType : std_logic;
signal isHalt : std_logic;
signal isJType: std_logic;
signal isBranch: std_logic;
signal Store: std_logic;

begin
	-- Load
	with instruction (31 downto 26) select
		isLoad	<=	'1' when "000111",
						'0' when others;
			
	-- Store		
	with instruction (31 downto 26) select
		Store	<=	'1' when "001000",
					'0' when others;
					
	isStore <= Store;

	-- ALU
	with instruction (31 downto 26) select
		ALUOp	<=	"000" when "000111", -- Load
					"000" when "001000", -- Store
					instruction ( 2 downto 0) when "000000", -- R Type
					"000" when "000001", -- ADDI
					"001" when "000010", -- SUBI
					"010" when "000011", -- ANDI
					"011" when "000100", -- ORI
					instruction (28 downto 26) when others; -- SHL/R

	--Branch
	with instruction (31 downto 26) select
		isBranch	<=	'1' when "001001",
						'1' when "001010",
						'1' when "001011",
						'0' when others;

	--J Type
	with instruction (31 downto 26) select
		isJType	<=	'1' when "001100",
						'1' when "111111",
						'0' when others;

	--R Type
	with instruction (31 downto 26) select
		isRType	<=	'1' when "000000",
						'0' when others;

	--HALT
	with instruction (31 downto 26) select
		isHalt	<=	'1' when "111111",
						'0' when others;

	--I Type
	with not(isRType) and not (isJType) select
		isIType	<=	'1' when '1',
						'0' when others;
			
	-- WrtEnable
	with (isBranch or Store or isJType) select
		WrtEnable	<=	'0' when '1',
							'1' when others; 

	--Next PC					
	process(instruction,isBranch,isEq,isLess,isJType,isHalt)
	begin 
		if (instruction (31 downto 26) = "001010" and isEq='1') then 
			NextPC <= "10";
		elsif (instruction (31 downto 26) = "001001" and isLess='1') then 
			NextPC <= "10";
		elsif (instruction (31 downto 26) = "001011" and isEq='0' ) then 
			NextPC <= "10";
		elsif (isHalt='1') then 
			NextPC <= "11";
		elsif (isJType='1') then 
				NextPC <= "01";
		else NextPC <= "00";
		end if;
	end process;
end Behavioral;