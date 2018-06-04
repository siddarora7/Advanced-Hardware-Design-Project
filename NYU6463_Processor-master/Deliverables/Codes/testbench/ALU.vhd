

-- This block performs operations such as addition, subtraction, comparison, etc.
-- It uses the control signals generated by the Decode Unit, as well as the data
-- from the registers or from the instruction directly. It computes data that can
-- be written into one of the registers (including PC).

-- The ALU is responsible only for arithmetic and logic operations
-- ADD, SUB, AND, OR, NOR, SHL, SHR

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
	port(
			data1: in std_logic_vector(31 downto 0);
			data2: in std_logic_vector(31 downto 0);
			ALUOp: in std_logic_vector(2 downto 0);
			output: out std_logic_vector(31 downto 0)
		);
end ALU;

architecture Behavioral of ALU is
begin

	process (data1, data2, ALUOp) begin
		case ALUOp is
			when "000" => output <= data1 + data2;		-- ADD
			when "001" => output <= data1 - data2;		-- SUB
			when "010" => output <= data1 AND data2;	-- AND
			when "011" => output <= data1 OR data2; 	-- OR
			when "100" => output <= data1 NOR data2;	-- NOR
			when "101" => 								-- SHL
				case data2 (4 downto 0) is
						when "00000" => output <= data1(31 downto 0);
						when "00001" => output <= data1(30 downto 0) & "0";
						when "00010" => output <= data1(29 downto 0) & "00";
						when "00011" => output <= data1(28 downto 0) & "000";
						when "00100" => output <= data1(27 downto 0) & "0000";
						when "00101" => output <= data1(26 downto 0) & "00000";
						when "00110" => output <= data1(25 downto 0) & "000000";
						when "00111" => output <= data1(24 downto 0) & "0000000";
						when "01000" => output <= data1(23 downto 0) & "00000000";
						when "01001" => output <= data1(22 downto 0) & "000000000";
						when "01010" => output <= data1(21 downto 0) & "0000000000";
						when "01011" => output <= data1(20 downto 0) & "00000000000";
						when "01100" => output <= data1(19 downto 0) & "000000000000";
						when "01101" => output <= data1(18 downto 0) & "0000000000000";
						when "01110" => output <= data1(17 downto 0) & "00000000000000";
						when "01111" => output <= data1(16 downto 0) & "000000000000000";
						when "10000" => output <= data1(15 downto 0) & "0000000000000000";
						when "10001" => output <= data1(14 downto 0) & "00000000000000000";
						when "10010" => output <= data1(13 downto 0) & "000000000000000000";
						when "10011" => output <= data1(12 downto 0) & "0000000000000000000";
						when "10100" => output <= data1(11 downto 0) & "00000000000000000000";
						when "10101" => output <= data1(10 downto 0) & "000000000000000000000";
						when "10110" => output <= data1(9 downto 0) & "0000000000000000000000";
						when "10111" => output <= data1(8 downto 0) & "00000000000000000000000";
						when "11000" => output <= data1(7 downto 0) & "000000000000000000000000";
						when "11001" => output <= data1(6 downto 0) & "0000000000000000000000000";
						when "11010" => output <= data1(5 downto 0) & "00000000000000000000000000";
						when "11011" => output <= data1(4 downto 0) & "000000000000000000000000000";
						when "11100" => output <= data1(3 downto 0) & "0000000000000000000000000000";
						when "11101" => output <= data1(2 downto 0) & "00000000000000000000000000000";
						when "11110" => output <= data1(1 downto 0) & "000000000000000000000000000000";
						when "11111" => output <= data1(0) & "0000000000000000000000000000000";
						when others  => output <= x"00000000";
				end case;
			when "110" => 								-- SHR
				case data2 (4 downto 0) is
					when "00000" => output <= data1(31 downto 0);
					when "00001" => output <= "0" & data1(31 downto 1);
					when "00010" => output <= "00" & data1(31 downto 2);
					when "00011" => output <= "000" & data1(31 downto 3);
					when "00100" => output <= "0000" & data1(31 downto 4);
					when "00101" => output <= "00000" & data1(31 downto 5);
					when "00110" => output <= "000000" & data1(31 downto 6);
					when "00111" => output <= "0000000" & data1(31 downto 7);
					when "01000" => output <= "00000000" & data1(31 downto 8);
					when "01001" => output <= "000000000" & data1(31 downto 9);
					when "01010" => output <= "0000000000" & data1(31 downto 10);
					when "01011" => output <= "00000000000" & data1(31 downto 11);
					when "01100" => output <= "000000000000" & data1(31 downto 12);
					when "01101" => output <= "0000000000000" & data1(31 downto 13);
					when "01110" => output <= "00000000000000" & data1(31 downto 14);
					when "01111" => output <= "000000000000000" & data1(31 downto 15);
					when "10000" => output <= "0000000000000000" & data1(31 downto 16);
					when "10001" => output <= "00000000000000000" & data1(31 downto 17);
					when "10010" => output <= "000000000000000000" & data1(31 downto 18);
					when "10011" => output <= "0000000000000000000" & data1(31 downto 19);
					when "10100" => output <= "00000000000000000000" & data1(31 downto 20);
					when "10101" => output <= "000000000000000000000" & data1(31 downto 21);
					when "10110" => output <= "0000000000000000000000" & data1(31 downto 22);
					when "10111" => output <= "00000000000000000000000" & data1(31 downto 23);
					when "11000" => output <= "000000000000000000000000" & data1(31 downto 24);
					when "11001" => output <= "0000000000000000000000000" & data1(31 downto 25);
					when "11010" => output <= "00000000000000000000000000" & data1(31 downto 26);
					when "11011" => output <= "000000000000000000000000000" & data1(31 downto 27);
					when "11100" => output <= "0000000000000000000000000000" & data1(31 downto 28);
					when "11101" => output <= "00000000000000000000000000000" & data1(31 downto 29);
					when "11110" => output <= "000000000000000000000000000000" & data1(31 downto 30);
					when "11111" => output <= "0000000000000000000000000000000" & data1(31);
					when others =>  output <= x"00000000";
				end case;
			when others => output <= x"00000000";
		end case;
	end process;
end Behavioral;
