LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Shift_Left IS
	PORT (
		Input1 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		Output1 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		Cout : OUT STD_LOGIC;
		N : OUT STD_LOGIC);
END Shift_Left;

ARCHITECTURE Behavioral OF Shift_Left IS

BEGIN

	Output1 <= Input1(6 DOWNTO 0) & '0';

	-- Determining N
	N <= Input1(6);

	-- Determining Cout
	Cout <= Input1(7);

END Behavioral;