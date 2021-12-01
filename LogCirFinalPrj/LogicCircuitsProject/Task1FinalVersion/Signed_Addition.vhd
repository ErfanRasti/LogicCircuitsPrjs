LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Signed_Addition IS
	PORT (
		Input1, Input2 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		Output1 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		V : OUT STD_LOGIC;
		N : OUT STD_LOGIC);
END Signed_Addition;

ARCHITECTURE Behavioral OF Signed_Addition IS

	-- Defining Signals
	SIGNAL SignedAdd : SIGNED (8 DOWNTO 0);
	SIGNAL STDAns : STD_LOGIC_VECTOR (8 DOWNTO 0);

BEGIN

	-- Copying the Sign Bit to the left side of Input1 and Input2
	-- Converting datatype of Input1 and Input2 to SIGNED
	-- Calculating Signed Addition
	SignedAdd <= SIGNED(Input1(7) & Input1) + SIGNED(Input2(7) & Input2);

	-- Converting datatype of SignedAdd to Standard logic vector
	STDAns <= STD_LOGIC_VECTOR(SignedAdd);

	Output1 <= STDAns(7 DOWNTO 0);

	-- OverFlow Detection
	-- Cn = Cn-1 => Overflow = '0' => V = '0'
	-- Cn != Cn-1 => Overflow = '1' => V = '1'
	V <= '1' WHEN (SignedAdd(8) /= SignedAdd(7)) ELSE
		'0';

	-- Determining N
	N <= STDAns(8);

END Behavioral;