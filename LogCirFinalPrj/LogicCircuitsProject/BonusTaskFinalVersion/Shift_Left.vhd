LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Shift_Left IS
	PORT (
		Input1, Input2 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		Output1 : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		Cout : OUT STD_LOGIC;
		N : OUT STD_LOGIC);
END Shift_Left;

ARCHITECTURE Behavioral OF Shift_Left IS

BEGIN

	-- Determining N
	N <= Output1(7);

	PROCESS (Input1, Input2)

		-- NumofPos : Number of Position
		VARIABLE NumofPos : INTEGER;

		-- ZEROS : A Vector of Zeros
		VARIABLE ZEROS : STD_LOGIC_VECTOR(7 DOWNTO 0);

	BEGIN

		NumofPos := CONV_INTEGER(Input2);

		ZEROS := x"00";

		IF NumofPos = 0 THEN
			Output1 <= Input1;
			Cout <= '0';

		ELSIF NumofPos >= 1 AND NumofPos <= 7 THEN
			Output1 <= Input1(7 - NumofPos DOWNTO 0) & ZEROS(NumofPos - 1 DOWNTO 0);
			Cout <= Input1(8 - NumofPos);

		ELSIF NumofPos = 8 THEN
			Output1 <= x"00";
			Cout <= Input1(0);

		ELSE
			Output1 <= x"00";
			Cout <= '0';

		END IF;

	END PROCESS;

END Behavioral;