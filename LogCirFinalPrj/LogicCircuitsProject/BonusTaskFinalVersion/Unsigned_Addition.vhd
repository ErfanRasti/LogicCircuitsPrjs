LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Unsigned_Addition IS
	PORT (
		Input1, Input2 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		Cin : IN STD_LOGIC;
		Op : IN STD_LOGIC;
		Output1 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		Cout : OUT STD_LOGIC);
END Unsigned_Addition;

ARCHITECTURE Behavioral OF Unsigned_Addition IS

	-- Defining Signals
	SIGNAL Sum : STD_LOGIC_VECTOR (8 DOWNTO 0);
	SIGNAL C : STD_LOGIC;

BEGIN

	-- Unsigned Addition: Op = '0'
	-- Unsigned Addition with Carry: Op = '1'

	-- Determining C for Each Operation
	C <= Cin WHEN Op = '1' ELSE
		'0';

	-- Calculating the Summation
	Sum <= ('0' & Input1) + ('0' & Input2) + C;

	Output1 <= Sum(7 DOWNTO 0);

	-- Determining Cout
	Cout <= Sum(8);

END Behavioral;