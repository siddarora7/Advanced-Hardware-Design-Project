----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:37:31 12/04/2016 
-- Design Name: 
-- Module Name:    Processor - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Processor is
	port (		clk_100: in	STD_LOGIC;
					btnc : in STD_LOGIC;
					din	:	in std_logic_vector(63 downto 0);
					ukey	:	in std_logic_vector(127 downto 0);
					encin	:	in std_logic;
					dout	:	out	std_logic_vector(63 downto 0)
		);
end Processor;

architecture Behavioral of Processor is
	--Instruction Memory signals
	type instruction_ram is array (0 to 1024) of STD_LOGIC_VECTOR(31 downto 0);
	signal instructions : instruction_ram:=instruction_ram'(x"00000011",
	x"04000010",
	x"00210811",
	x"04210004",
	x"00421011",
	x"04420004",
	x"03FFF811",
	x"00631811",
	x"1FE30000",
	x"23E30007",
	x"1FE30001",
	x"23E30006",
	x"1FE30002",
	x"23E30005",
	x"1FE30003",
	x"23E30004",
	x"00631811",
	x"04630019",
	x"1FE40008",
	x"23E4000A",
	x"1FE40009",
	x"00A52811",
	x"1CA6000A",
	x"00C43010",
	x"04A50001",
	x"20A6000A",
	x"2C65FFFB",
	x"00A52811",
	x"00C63011",
	x"00E73811",
	x"01084011",
	x"03DEF011",
	x"03BDE811",
	x"07BD004E",
	x"039CE011",
	x"079C001A",
	x"1CA9000A",
	x"01075010",
	x"012A3810",
	x"18E9001D",
	x"14E70003",
	x"00E93810",
	x"20A7000A",
	x"1CC90004",
	x"01075010",
	x"012A4010",
	x"154A001B",
	x"194A001B",
	x"03FFF811",
	x"295F003F",
	x"07FF0001",
	x"295F0046",
	x"07FF0001",
	x"295F0047",
	x"07FF0001",
	x"295F0048",
	x"07FF0001",
	x"295F0049",
	x"07FF0001",
	x"295F004A",
	x"07FF0001",
	x"295F004B",
	x"07FF0001",
	x"295F004C",
	x"07FF0001",
	x"295F004D",
	x"07FF0001",
	x"295F004E",
	x"07FF0001",
	x"295F004F",
	x"07FF0001",
	x"295F0050",
	x"07FF0001",
	x"295F0051",
	x"07FF0001",
	x"295F0052",
	x"07FF0001",
	x"295F0053",
	x"07FF0001",
	x"295F0054",
	x"07FF0001",
	x"295F0055",
	x"07FF0001",
	x"295F0056",
	x"07FF0001",
	x"295F0057",
	x"07FF0001",
	x"295F0058",
	x"07FF0001",
	x"295F0059",
	x"07FF0001",
	x"295F005A",
	x"07FF0001",
	x"295F005B",
	x"07FF0001",
	x"295F005C",
	x"07FF0001",
	x"295F005D",
	x"07FF0001",
	x"295F005E",
	x"07FF0001",
	x"295F005F",
	x"07FF0001",
	x"295F0060",
	x"07FF0001",
	x"295F0061",
	x"07FF0001",
	x"295F0062",
	x"07FF0001",
	x"295F0063",
	x"07FF0001",
	x"295F0064",
	x"01094010",
	x"20C80004",
	x"04A50001",
	x"2B850063",
	x"04C60001",
	x"14C6001E",
	x"18C6001E",
	x"07DE0001",
	x"2FBEFFAB",
	x"2BDE005F",
	x"1909001F",
	x"15080001",
	x"2908FFF3",
	x"1909001E",
	x"15080002",
	x"2908FFF0",
	x"1909001D",
	x"15080003",
	x"2908FFED",
	x"1909001C",
	x"15080004",
	x"2908FFEA",
	x"1909001B",
	x"15080005",
	x"2908FFE7",
	x"1909001A",
	x"15080006",
	x"2908FFE4",
	x"19090019",
	x"15080007",
	x"2908FFE1",
	x"19090018",
	x"15080008",
	x"2908FFDE",
	x"19090017",
	x"15080009",
	x"2908FFDB",
	x"19090016",
	x"1508000A",
	x"2908FFD8",
	x"19090015",
	x"1508000B",
	x"2908FFD5",
	x"19090014",
	x"1508000C",
	x"2908FFD2",
	x"19090013",
	x"1508000D",
	x"2908FFCF",
	x"19090012",
	x"1508000E",
	x"2908FFCC",
	x"19090011",
	x"1508000F",
	x"2908FFC9",
	x"19090010",
	x"15080010",
	x"2908FFC6",
	x"1909000F",
	x"15080011",
	x"2908FFC3",
	x"1909000E",
	x"15080012",
	x"2908FFC0",
	x"1909000D",
	x"15080013",
	x"2908FFBD",
	x"1909000C",
	x"15080014",
	x"2908FFBA",
	x"1909000B",
	x"15080015",
	x"2908FFB7",
	x"1909000A",
	x"15080016",
	x"2908FFB4",
	x"19090009",
	x"15080017",
	x"2908FFB1",
	x"19090008",
	x"15080018",
	x"2908FFAE",
	x"19090007",
	x"15080019",
	x"2908FFAB",
	x"19090006",
	x"1508001A",
	x"2908FFA8",
	x"19090005",
	x"1508001B",
	x"2908FFA5",
	x"19090004",
	x"1508001C",
	x"2908FFA2",
	x"19090003",
	x"1508001D",
	x"2908FF9F",
	x"19090002",
	x"1508001E",
	x"2908FF9C",
	x"19090001",
	x"1508001F",
	x"2908FF99",
	x"00A52811",
	x"28A5FF9B",
	x"03FFF811",
	x"1FE00028",
	x"2BE00160",
	x"00000011",
	x"03FFF811",
	x"1FE00024",
	x"00210811",
	x"1FE1000A",
	x"00010010",
	x"00210811",
	x"1FE10025",
	x"00421011",
	x"1FE2000B",
	x"00220810",
	x"03BDE811",
	x"07BD000C",
	x"00421011",
	x"04420001",
	x"00201812",
	x"00202014",
	x"00830014",
	x"1423001B",
	x"1863001B",
	x"03FFF811",
	x"2BE3003F",
	x"07FF0001",
	x"2BE3008E",
	x"07FF0001",
	x"2BE3008F",
	x"07FF0001",
	x"2BE30090",
	x"07FF0001",
	x"2BE30091",
	x"07FF0001",
	x"2BE30092",
	x"07FF0001",
	x"2BE30093",
	x"07FF0001",
	x"2BE30094",
	x"07FF0001",
	x"2BE30095",
	x"07FF0001",
	x"2BE30096",
	x"07FF0001",
	x"2BE30097",
	x"07FF0001",
	x"2BE30098",
	x"07FF0001",
	x"2BE30099",
	x"07FF0001",
	x"2BE3009A",
	x"07FF0001",
	x"2BE3009B",
	x"07FF0001",
	x"2BE3009C",
	x"07FF0001",
	x"2BE3009D",
	x"07FF0001",
	x"2BE3009E",
	x"07FF0001",
	x"2BE3009F",
	x"07FF0001",
	x"2BE300A0",
	x"07FF0001",
	x"2BE300A1",
	x"07FF0001",
	x"2BE300A2",
	x"07FF0001",
	x"2BE300A3",
	x"07FF0001",
	x"2BE300A4",
	x"07FF0001",
	x"2BE300A5",
	x"07FF0001",
	x"2BE300A6",
	x"07FF0001",
	x"2BE300A7",
	x"07FF0001",
	x"2BE300A8",
	x"07FF0001",
	x"2BE300A9",
	x"07FF0001",
	x"2BE300AA",
	x"07FF0001",
	x"2BE300AB",
	x"07FF0001",
	x"2BE300AC",
	x"00040010",
	x"0042F010",
	x"1FC3000A",
	x"00600010",
	x"00201812",
	x"00202014",
	x"00830814",
	x"1403001B",
	x"1863001B",
	x"03FFF811",
	x"2BE3003F",
	x"07FF0001",
	x"2BE300A2",
	x"07FF0001",
	x"2BE300A3",
	x"07FF0001",
	x"2BE300A4",
	x"07FF0001",
	x"2BE300A5",
	x"07FF0001",
	x"2BE300A6",
	x"07FF0001",
	x"2BE300A7",
	x"07FF0001",
	x"2BE300A8",
	x"07FF0001",
	x"2BE300A9",
	x"07FF0001",
	x"2BE300AA",
	x"07FF0001",
	x"2BE300AB",
	x"07FF0001",
	x"2BE300AC",
	x"07FF0001",
	x"2BE300AD",
	x"07FF0001",
	x"2BE300AE",
	x"07FF0001",
	x"2BE300AF",
	x"07FF0001",
	x"2BE300B0",
	x"07FF0001",
	x"2BE300B1",
	x"07FF0001",
	x"2BE300B2",
	x"07FF0001",
	x"2BE300B3",
	x"07FF0001",
	x"2BE300B4",
	x"07FF0001",
	x"2BE300B5",
	x"07FF0001",
	x"2BE300B6",
	x"07FF0001",
	x"2BE300B7",
	x"07FF0001",
	x"2BE300B8",
	x"07FF0001",
	x"2BE300B9",
	x"07FF0001",
	x"2BE300BA",
	x"07FF0001",
	x"2BE300BB",
	x"07FF0001",
	x"2BE300BC",
	x"07FF0001",
	x"2BE300BD",
	x"07FF0001",
	x"2BE300BE",
	x"07FF0001",
	x"2BE300BF",
	x"07FF0001",
	x"2BE300C0",
	x"00240810",
	x"07DE0001",
	x"1FC3000A",
	x"00610810",
	x"2FA2FF6C",
	x"03FFF811",
	x"23E00026",
	x"23E10027",
	x"FC000000",
	x"1804001F",
	x"14000001",
	x"2800FFAB",
	x"1804001E",
	x"14000002",
	x"2800FFA8",
	x"1804001D",
	x"14000003",
	x"2800FFA5",
	x"1804001C",
	x"14000004",
	x"2800FFA2",
	x"1804001B",
	x"14000005",
	x"2800FF9F",
	x"1804001A",
	x"14000006",
	x"2800FF9C",
	x"18040019",
	x"14000007",
	x"2800FF99",
	x"18040018",
	x"14000008",
	x"2800FF96",
	x"18040017",
	x"14000009",
	x"2800FF93",
	x"18040016",
	x"1400000A",
	x"2800FF90",
	x"18040015",
	x"1400000B",
	x"2800FF8D",
	x"18040014",
	x"1400000C",
	x"2800FF8A",
	x"18040013",
	x"1400000D",
	x"2800FF87",
	x"18040012",
	x"1400000E",
	x"2800FF84",
	x"18040011",
	x"1400000F",
	x"2800FF81",
	x"18040010",
	x"14000010",
	x"2800FF7E",
	x"1804000F",
	x"14000011",
	x"2800FF7B",
	x"1804000E",
	x"14000012",
	x"2800FF78",
	x"1804000D",
	x"14000013",
	x"2800FF75",
	x"1804000C",
	x"14000014",
	x"2800FF72",
	x"1804000B",
	x"14000015",
	x"2800FF6F",
	x"1804000A",
	x"14000016",
	x"2800FF6C",
	x"18040009",
	x"14000017",
	x"2800FF69",
	x"18040008",
	x"14000018",
	x"2800FF66",
	x"18040007",
	x"14000019",
	x"2800FF63",
	x"18040006",
	x"1400001A",
	x"2800FF60",
	x"18040005",
	x"1400001B",
	x"2800FF5D",
	x"18040004",
	x"1400001C",
	x"2800FF5A",
	x"18040003",
	x"1400001D",
	x"2800FF57",
	x"18040002",
	x"1400001E",
	x"2800FF54",
	x"18040001",
	x"1400001F",
	x"2800FF51",
	x"1824001F",
	x"14210001",
	x"2821FF97",
	x"1824001E",
	x"14210002",
	x"2821FF94",
	x"1824001D",
	x"14210003",
	x"2821FF91",
	x"1824001C",
	x"14210004",
	x"2821FF8E",
	x"1824001B",
	x"14210005",
	x"2821FF8B",
	x"1824001A",
	x"14210006",
	x"2821FF88",
	x"18240019",
	x"14210007",
	x"2821FF85",
	x"18240018",
	x"14210008",
	x"2821FF82",
	x"18240017",
	x"14210009",
	x"2821FF7F",
	x"18240016",
	x"1421000A",
	x"2821FF7C",
	x"18240015",
	x"1421000B",
	x"2821FF79",
	x"18240014",
	x"1421000C",
	x"2821FF76",
	x"18240013",
	x"1421000D",
	x"2821FF73",
	x"18240012",
	x"1421000E",
	x"2821FF70",
	x"18240011",
	x"1421000F",
	x"2821FF6D",
	x"18240010",
	x"14210010",
	x"2821FF6A",
	x"1824000F",
	x"14210011",
	x"2821FF67",
	x"1824000E",
	x"14210012",
	x"2821FF64",
	x"1824000D",
	x"14210013",
	x"2821FF61",
	x"1824000C",
	x"14210014",
	x"2821FF5E",
	x"1824000B",
	x"14210015",
	x"2821FF5B",
	x"1824000A",
	x"14210016",
	x"2821FF58",
	x"18240009",
	x"14210017",
	x"2821FF55",
	x"18240008",
	x"14210018",
	x"2821FF52",
	x"18240007",
	x"14210019",
	x"2821FF4F",
	x"18240006",
	x"1421001A",
	x"2821FF4C",
	x"18240005",
	x"1421001B",
	x"2821FF49",
	x"18240004",
	x"1421001C",
	x"2821FF46",
	x"18240003",
	x"1421001D",
	x"2821FF43",
	x"18240002",
	x"1421001E",
	x"2821FF40",
	x"18240001",
	x"1421001F",
	x"2821FF3D",
	x"00000011",
	x"03FFF811",
	x"1FE00024",
	x"00210811",
	x"1FE10025",
	x"03BDE811",
	x"07BD0001",
	x"00421011",
	x"0442000D",
	x"08420001",
	x"0042F010",
	x"07DE0001",
	x"1FC3000A",
	x"00230811",
	x"1403001B",
	x"1863001B",
	x"03FFF811",
	x"2BE3003F",
	x"07FF0001",
	x"2BE30092",
	x"07FF0001",
	x"2BE30093",
	x"07FF0001",
	x"2BE30094",
	x"07FF0001",
	x"2BE30095",
	x"07FF0001",
	x"2BE30096",
	x"07FF0001",
	x"2BE30097",
	x"07FF0001",
	x"2BE30098",
	x"07FF0001",
	x"2BE30099",
	x"07FF0001",
	x"2BE3009A",
	x"07FF0001",
	x"2BE3009B",
	x"07FF0001",
	x"2BE3009C",
	x"07FF0001",
	x"2BE3009D",
	x"07FF0001",
	x"2BE3009E",
	x"07FF0001",
	x"2BE3009F",
	x"07FF0001",
	x"2BE300A0",
	x"07FF0001",
	x"2BE300A1",
	x"07FF0001",
	x"2BE300A2",
	x"07FF0001",
	x"2BE300A3",
	x"07FF0001",
	x"2BE300A4",
	x"07FF0001",
	x"2BE300A5",
	x"07FF0001",
	x"2BE300A6",
	x"07FF0001",
	x"2BE300A7",
	x"07FF0001",
	x"2BE300A8",
	x"07FF0001",
	x"2BE300A9",
	x"07FF0001",
	x"2BE300AA",
	x"07FF0001",
	x"2BE300AB",
	x"07FF0001",
	x"2BE300AC",
	x"07FF0001",
	x"2BE300AD",
	x"07FF0001",
	x"2BE300AE",
	x"07FF0001",
	x"2BE300AF",
	x"07FF0001",
	x"2BE300B0",
	x"00240810",
	x"00201812",
	x"00202014",
	x"00830814",
	x"0042F010",
	x"1FC3000A",
	x"00030011",
	x"1423001B",
	x"1863001B",
	x"03FFF811",
	x"2BE3003F",
	x"07FF0001",
	x"2BE300A6",
	x"07FF0001",
	x"2BE300A7",
	x"07FF0001",
	x"2BE300A8",
	x"07FF0001",
	x"2BE300A9",
	x"07FF0001",
	x"2BE300AA",
	x"07FF0001",
	x"2BE300AB",
	x"07FF0001",
	x"2BE300AC",
	x"07FF0001",
	x"2BE300AD",
	x"07FF0001",
	x"2BE300AE",
	x"07FF0001",
	x"2BE300AF",
	x"07FF0001",
	x"2BE300B0",
	x"07FF0001",
	x"2BE300B1",
	x"07FF0001",
	x"2BE300B2",
	x"07FF0001",
	x"2BE300B3",
	x"07FF0001",
	x"2BE300B4",
	x"07FF0001",
	x"2BE300B5",
	x"07FF0001",
	x"2BE300B6",
	x"07FF0001",
	x"2BE300B7",
	x"07FF0001",
	x"2BE300B8",
	x"07FF0001",
	x"2BE300B9",
	x"07FF0001",
	x"2BE300BA",
	x"07FF0001",
	x"2BE300BB",
	x"07FF0001",
	x"2BE300BC",
	x"07FF0001",
	x"2BE300BD",
	x"07FF0001",
	x"2BE300BE",
	x"07FF0001",
	x"2BE300BF",
	x"07FF0001",
	x"2BE300C0",
	x"07FF0001",
	x"2BE300C1",
	x"07FF0001",
	x"2BE300C2",
	x"07FF0001",
	x"2BE300C3",
	x"07FF0001",
	x"2BE300C4",
	x"00040010",
	x"00201812",
	x"00202014",
	x"00830014",
	x"2FA2FF6B",
	x"03FFF811",
	x"1FE2000B",
	x"00220811",
	x"1FE2000A",
	x"00020011",
	x"23E10027",
	x"23E00026",
	x"FC000000",
	x"1424001F",
	x"18210001",
	x"2821FFA7",
	x"1424001E",
	x"18210002",
	x"2821FFA4",
	x"1424001D",
	x"18210003",
	x"2821FFA1",
	x"1424001C",
	x"18210004",
	x"2821FF9E",
	x"1424001B",
	x"18210005",
	x"2821FF9B",
	x"1424001A",
	x"18210006",
	x"2821FF98",
	x"14240019",
	x"18210007",
	x"2821FF95",
	x"14240018",
	x"18210008",
	x"2821FF92",
	x"14240017",
	x"18210009",
	x"2821FF8F",
	x"14240016",
	x"1821000A",
	x"2821FF8C",
	x"14240015",
	x"1821000B",
	x"2821FF89",
	x"14240014",
	x"1821000C",
	x"2821FF86",
	x"14240013",
	x"1821000D",
	x"2821FF83",
	x"14240012",
	x"1821000E",
	x"2821FF80",
	x"14240011",
	x"1821000F",
	x"2821FF7D",
	x"14240010",
	x"18210010",
	x"2821FF7A",
	x"1424000F",
	x"18210011",
	x"2821FF77",
	x"1424000E",
	x"18210012",
	x"2821FF74",
	x"1424000D",
	x"18210013",
	x"2821FF71",
	x"1424000C",
	x"18210014",
	x"2821FF6E",
	x"1424000B",
	x"18210015",
	x"2821FF6B",
	x"1424000A",
	x"18210016",
	x"2821FF68",
	x"14240009",
	x"18210017",
	x"2821FF65",
	x"14240008",
	x"18210018",
	x"2821FF62",
	x"14240007",
	x"18210019",
	x"2821FF5F",
	x"14240006",
	x"1821001A",
	x"2821FF5C",
	x"14240005",
	x"1821001B",
	x"2821FF59",
	x"14240004",
	x"1821001C",
	x"2821FF56",
	x"14240003",
	x"1821001D",
	x"2821FF53",
	x"14240002",
	x"1821001E",
	x"2821FF50",
	x"14240001",
	x"1821001F",
	x"2821FF4D",
	x"1404001F",
	x"18000001",
	x"2800FF93",
	x"1404001E",
	x"18000002",
	x"2800FF90",
	x"1404001D",
	x"18000003",
	x"2800FF8D",
	x"1404001C",
	x"18000004",
	x"2800FF8A",
	x"1404001B",
	x"18000005",
	x"2800FF87",
	x"1404001A",
	x"18000006",
	x"2800FF84",
	x"14040019",
	x"18000007",
	x"2800FF81",
	x"14040018",
	x"18000008",
	x"2800FF7E",
	x"14040017",
	x"18000009",
	x"2800FF7B",
	x"14040016",
	x"1800000A",
	x"2800FF78",
	x"14040015",
	x"1800000B",
	x"2800FF75",
	x"14040014",
	x"1800000C",
	x"2800FF72",
	x"14040013",
	x"1800000D",
	x"2800FF6F",
	x"14040012",
	x"1800000E",
	x"2800FF6C",
	x"14040011",
	x"1800000F",
	x"2800FF69",
	x"14040010",
	x"18000010",
	x"2800FF66",
	x"1404000F",
	x"18000011",
	x"2800FF63",
	x"1404000E",
	x"18000012",
	x"2800FF60",
	x"1404000D",
	x"18000013",
	x"2800FF5D",
	x"1404000C",
	x"18000014",
	x"2800FF5A",
	x"1404000B",
	x"18000015",
	x"2800FF57",
	x"1404000A",
	x"18000016",
	x"2800FF54",
	x"14040009",
	x"18000017",
	x"2800FF51",
	x"14040008",
	x"18000018",
	x"2800FF4E",
	x"14040007",
	x"18000019",
	x"2800FF4B",
	x"14040006",
	x"1800001A",
	x"2800FF48",
	x"14040005",
	x"1800001B",
	x"2800FF45",
	x"14040004",
	x"1800001C",
	x"2800FF42",
	x"14040003",
	x"1800001D",
	x"2800FF3F",
	x"14040002",
	x"1800001E",
	x"2800FF3C",
	x"14040001",
	x"1800001F",
	x"2800FF39",
	others => (x"ffffffff"));

	signal instruction : STD_LOGIC_VECTOR(31 downto 0);
	
	signal clr :std_logic;
	signal clk : std_logic:='1';
	
	--PC
	signal pc_reg : std_logic_vector(31 downto 0) := x"00000000";
	signal next_pc : std_logic_vector(31 downto 0);
	signal pcplus : std_logic_vector(31 downto 0);
	
	--Register signals
	signal rr_1 : STD_LOGIC_VECTOR(4 downto 0);
	signal rr_2 : STD_LOGIC_VECTOR(4 downto 0);
	signal wrt_reg : STD_LOGIC_VECTOR(4 downto 0);
	signal wrt_data : STD_LOGIC_VECTOR(31 downto 0);
	signal wrt_enable : std_logic;
	
	--For display purposes
	signal peek_reg : std_logic_vector(4 downto 0) := "00000";
	signal show_reg : std_logic_vector(31 downto 0);
	----------------------
	
	signal r_val_1 : STD_LOGIC_VECTOR(31 downto 0);
	signal r_val_2 : STD_LOGIC_VECTOR(31 downto 0);
	
	signal signext : std_logic_vector(31 downto 0);
	
	--Decoder signals
	signal alu_op : STD_LOGIC_VECTOR(2 downto 0);
	signal is_load : STD_LOGIC;
	signal is_store : STD_LOGIC;
	signal i_type : STD_LOGIC;
	signal pc_ctrl : STD_LOGIC_VECTOR(1 downto 0);
	
	signal is_eq : STD_LOGIC;
	signal is_less : STD_LOGIC;
	
	--ALU signals
	signal val_2 : STD_LOGIC_VECTOR(31 downto 0);
	signal result : STD_LOGIC_VECTOR(31 downto 0);
	
	--Data Mem signals
	signal rdata : std_logic_vector(31 downto 0);
	
	--For display purposes
	signal peek_mem : std_logic_vector(6 downto 0) := "0000000";
	signal show_mem : std_logic_vector(31 downto 0);
	----------------------
	
	-- 7-Segment signals
	signal reg_num: STD_LOGIC_VECTOR(4 downto 0):="00000";
	signal out_val : STD_LOGIC_VECTOR(31 downto 0);
	signal disp_sel : STD_LOGIC_VECTOR(1 downto 0);
	
	signal seg_clk : STD_LOGIC:='0';
	signal clk_cntr :integer :=0;
	signal seg_cntr : STD_LOGIC_VECTOR(2 downto 0):="000";
	
	signal output_val : STD_LOGIC_VECTOR(3 downto 0);
	
	signal enc : std_logic_vector(31 downto 0);

	
	--Step State machine signals
	signal sw_state : STD_Logic:='0';
	
	type  StateType is (ST_EXEC,
	                    ST_STEP);

	signal  state:   StateType;


component RF
	port(r1, r2, wr : in std_logic_vector(4 downto 0);
			data : in std_logic_vector(31 downto 0);
			wrt_en, clk, clr : in std_logic;
			check_reg : in std_logic_vector(4 downto 0);
			disp_reg : out std_logic_vector(31 downto 0);
			r1_out, r2_out : out std_logic_vector(31 downto 0));
end component;

component decoder
	port (instruction : in std_logic_vector(31 downto 0);
			isEq, isLess : in std_logic;
			isLoad, isStore, isIType : out std_logic;
			ALUOp : out std_logic_vector(2 downto 0);
			WrtEnable : out std_logic;
			nextPC : out std_logic_vector(1 downto 0));
end component;

component alu
	port(data1, data2 : in std_logic_vector(31 downto 0);
			ALUOp : in std_logic_vector(2 downto 0);
			output : out std_logic_vector(31 downto 0));
end component;

component datamem
	port(clk, clr : in std_logic;
			address, WriteData : in std_logic_vector(31 downto 0);
			isStore : in std_logic;
			check_mem : in std_logic_vector(6 downto 0);
			enc	:	in	std_logic_vector(31 downto 0);
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
end component;

signal 	a 	: std_logic_vector(31 downto 0);
signal	b 	: std_logic_vector(31 downto 0);
signal	u0 :  std_logic_vector(31 downto 0);
signal	u1 :  std_logic_vector(31 downto 0);
signal	u2 :  std_logic_vector(31 downto 0);
signal	u3 : std_logic_vector(31 downto 0);
signal aout : std_logic_vector(31 downto 0);
signal bout : std_logic_vector(31 downto 0);

begin
	a	<=	din(63 downto 32);
	b	<=	din(31 downto 0);
	u0	<=	ukey(31 downto 0);
	u1	<=	ukey(63 downto 32);
	u2	<=	ukey(95 downto 64);
	u3	<=	ukey(127 downto 96);
	
	dout(63 downto 32)	<= aout;
	dout(31 downto 0)	<=	bout;
	

--Components
	U11: RF port map (r1 => rr_1, r2 => rr_2, wr => wrt_reg, data => wrt_data, wrt_en => wrt_enable, clk => clk, clr => clr, check_reg => peek_reg,
							disp_reg => show_reg, r1_out => r_val_1, r2_out => r_val_2);
	U21: decoder port map (instruction => instruction, isEq => is_eq, isLess => is_less, isLoad => is_load, isStore => is_store, isIType => i_type,
									ALUOp => alu_op, WrtEnable => wrt_enable, nextPC => pc_ctrl);
	U31: ALU port map (data1 => r_val_1, data2 => val_2, ALUOP => alu_op, output => result);
	U41: datamem port map (clk => clk, clr => clr, address => result, WriteData => r_val_2, isStore => is_store, check_mem => peek_mem, enc => enc,
								disp_mem => show_mem, ReadData => rdata, a => a, b => b, u0 => u0, u1 => u1,  u2 => u2, u3 => u3, aout => aout, bout => bout);
	clr<=not btnc;

	--with sw(9) select
	with encin select
		enc	<=	(others=>'0') when '0',
					x"00000001" when others;

	-- PC
	process (clk, clr) begin
		if (clk'event and clk = '1') then
			if (clr = '0') then
				pc_reg <= (others => '0');
			else
				pc_reg <= next_pc;
			end if;
		end if;
	end process;
	
	pcplus <= pc_reg + '1';
	
	-- PC mux
	next_pc <= pcplus when pc_ctrl = "00" else
				  pcplus + signext when pc_ctrl = "10" else
				  pcplus(31 downto 26) & instruction(25 downto 0) when pc_ctrl = "01" else 
				  pc_reg when pc_ctrl = "11" or clr = '0';
	
	-- IMEM
	instruction <= instructions(conv_integer(unsigned(pc_reg)));
	
	-- RF
	rr_1<=instruction(25 downto 21);
	rr_2<=instruction(20 downto 16);
	wrt_reg <= instruction(15 downto 11) when i_type = '0' else instruction(20 downto 16); --Choose write register
	wrt_data <= result when is_load = '0' else --Select output from ALU or Dmem
					rdata when is_load = '1';
	
	signext <= sxt(instruction(15 downto 0), 32);
	is_eq <= '1' when r_val_1 = r_val_2 else '0';
	is_less <= '1' when r_val_1 < r_val_2 else '0';
	
	-- ALU
	val_2 <= signext when i_type = '1' else r_val_2; --Select from sign extend or RF

	-- Clk Process
	clk_process : process (clk_100) begin
		case state is
			when ST_EXEC =>
				if (clk_100'event and clk_100 = '1') then
					clk <= not(clk);
				end if;
			when ST_STEP	=>
		end case;
	end process clk_process;
	
	

	state<=ST_EXEC;
end Behavioral;

