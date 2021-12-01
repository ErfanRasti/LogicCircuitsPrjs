LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY BCD2BIN IS
	PORT (
		Input1, Input2 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		Output1, Output2 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		Cout : OUT STD_LOGIC);
END BCD2BIN;

ARCHITECTURE Behavioral OF BCD2BIN IS

	-- Defining Signals
	SIGNAL Digit1Dec : INTEGER := 0;
	SIGNAL Digit2Dec : INTEGER := 0;
	SIGNAL Digit3Dec : INTEGER := 0;
	SIGNAL Digit4Dec : INTEGER := 0;
	SIGNAL DecNum : INTEGER := 0;
	SIGNAL BinNum : STD_LOGIC_VECTOR (15 DOWNTO 0);

BEGIN

	-- Extracting Each Digit
	Digit1Dec <= conv_integer(Input1(3 DOWNTO 0));
	Digit2Dec <= conv_integer(Input1(7 DOWNTO 4));
	Digit3Dec <= conv_integer(Input2(3 DOWNTO 0));
	Digit4Dec <= conv_integer(Input2(7 DOWNTO 4));

	-- Calculating Decimal Number
	DecNum <= Digit1Dec + (Digit2Dec * 10) + (Digit3Dec * 100) + (Digit4Dec * 1000);

	-- Converting Decimal Number to Binary Number
	BinNum <= STD_LOGIC_VECTOR(to_unsigned(DecNum, 16));

	-- Slicing the Binary Number to Output1 and Output 2
	Output1 <= BinNum(7 DOWNTO 0);
	Output2 <= BinNum(15 DOWNTO 8);

	-- Setting Cout with MSB
	Cout <= BinNum(15);

END Behavioral;