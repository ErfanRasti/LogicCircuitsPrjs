LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Multiplication IS
	PORT (
		Input1, Input2 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		Op : IN STD_LOGIC;
		Output1, Output2 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		N : OUT STD_LOGIC);
END Multiplication;

ARCHITECTURE Behavioral OF Multiplication IS

	-- Defining Signals
	SIGNAL SignedMult : SIGNED (15 DOWNTO 0);
	SIGNAL MultAns : STD_LOGIC_VECTOR (15 DOWNTO 0);

BEGIN

	SignedMult <= SIGNED(Input1) * SIGNED(Input2);

	-- Unsigned Multiplication: Op --> '1'
	-- Signed Multiplication: Op --> '0'

	-- Determining MultAns for Each Operation
	MultAns <= Input1 * Input2 WHEN Op = '1' ELSE
		STD_LOGIC_VECTOR(SignedMult);

	-- Slicing MultAns to Output1 And Output2
	Output1 <= MultAns(7 DOWNTO 0);
	Output2 <= MultAns(15 DOWNTO 8);

	-- N = '0' for Unsigned Multiplication
	-- N = MultAns(15) for Signed Multiplication

	-- Determining N for Each Operation
	N <= MultAns(15) WHEN Op = '0' ELSE
		'0';

END Behavioral;