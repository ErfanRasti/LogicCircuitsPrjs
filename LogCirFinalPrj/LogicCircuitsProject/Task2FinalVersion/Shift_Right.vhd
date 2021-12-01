LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Shift_Right IS
	PORT (
		Input1 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		Op : IN STD_LOGIC;
		Output1 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		Cout : OUT STD_LOGIC;
		N : OUT STD_LOGIC);
END Shift_Right;

ARCHITECTURE Behavioral OF Shift_Right IS
	-- Defining Signals
	SIGNAL MSB : STD_LOGIC;

BEGIN

	-- Logic Shift Right: Op = '0'
	-- Arithmetic Shift Right: Op = '1'

	-- Determining MSB for Each Operation
	MSB <= '0' WHEN Op = '0' ELSE
		Input1(7);

	Output1 <= MSB & Input1(7 DOWNTO 1);
	N <= MSB;

	-- Determining Cout
	Cout <= Input1(0);

END Behavioral;