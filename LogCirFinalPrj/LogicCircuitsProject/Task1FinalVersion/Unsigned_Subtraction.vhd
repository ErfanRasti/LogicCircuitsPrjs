LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Unsigned_Subtraction IS
	PORT (
		Input1, Input2 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		Output1 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		Cout : OUT STD_LOGIC);
END Unsigned_Subtraction;

ARCHITECTURE Behavioral OF Unsigned_Subtraction IS

	SIGNAL Sum : STD_LOGIC_VECTOR (8 DOWNTO 0);

BEGIN

	Sum <= ('0' & Input1) + ('0' & NOT(Input2));

	-- If Input1 >= Input2  => Sum(8) = '1' => Answer is positive.(Cout = '0')
	-- 			 => End Carry => This end carry should be ignored.

	-- If Input1 < Input2   => Sum(8) = '0' => Answer is negative.(Cout = '1')
	-- 			 => Ans = 1's Complement of Sum with a minus sign

	PROCESS (Sum(8), Sum)
	BEGIN
		IF (Sum(8) = '1') THEN
			Output1 <= Sum(7 DOWNTO 0) + x"01";
			Cout <= '0';
		ELSE
			Output1 <= NOT (Sum(7 DOWNTO 0));
			Cout <= '1';
		END IF;
	END PROCESS;

END Behavioral;