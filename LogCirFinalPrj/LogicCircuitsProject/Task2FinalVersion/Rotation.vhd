LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Rotation IS
	PORT (
		Input1 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		Op : IN STD_LOGIC;
		Cin : IN STD_LOGIC;
		Output1 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		Cout : OUT STD_LOGIC);
END Rotation;

ARCHITECTURE Behavioral OF Rotation IS

	-- Defining Signals
	SIGNAL LSB : STD_LOGIC;

BEGIN

	-- Rotation Left: Op = '0'
	-- Rotation Left with Carry: Op = '1'

	-- Determining LSB for Each Operation
	LSB <= Input1(7) WHEN Op = '0' ELSE
		Cin;

	Output1 <= Input1(6 DOWNTO 0) & LSB;

	-- Determining Cout for Each Operation
	Cout <= '0' WHEN Op = '0' ELSE
		Input1(7);

END Behavioral;