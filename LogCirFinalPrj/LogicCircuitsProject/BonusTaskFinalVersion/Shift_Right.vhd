LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Shift_Right IS
	PORT (
		Input1, Input2 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		Op : IN STD_LOGIC;
		Output1 : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		Cout : OUT STD_LOGIC;
		N : OUT STD_LOGIC);
END Shift_Right;

ARCHITECTURE Behavioral OF Shift_Right IS

BEGIN

	-- Variable Logic Shift Right : Op = '0'
	-- Variable Arithmetic Shift Right with Rounding : Op = '1'

	-- Determining N for each Operation
	N <= Output1(7) WHEN Op = '1' ELSE
		'0';

	PROCESS (Input1, Input2, Op)

		-- NumofPos : Number of Position
		VARIABLE NumofPos : INTEGER;

		-- ZEROS : A Vector of Zeros
		VARIABLE ZEROS : STD_LOGIC_VECTOR(7 DOWNTO 0);

		-- S : A Vector of Sign Bit
		VARIABLE S : STD_LOGIC_VECTOR(7 DOWNTO 0);

	BEGIN

		NumofPos := CONV_INTEGER(Input2);

		ZEROS := x"00";

		S := (OTHERS => Input1(7));

		-- Determining Output1 and Cout for Each Operation
		IF Op = '0' THEN

			IF NumofPos = 0 THEN
				Output1 <= Input1;
				Cout <= '0';

			ELSIF NumofPos >= 1 AND 7 >= NumofPos THEN
				Output1 <= ZEROS(NumofPos - 1 DOWNTO 0) & Input1(7 DOWNTO NumofPos);
				Cout <= Input1(NumofPos - 1);

			ELSIF NumofPos = 8 THEN
				Output1 <= ZEROS;
				Cout <= Input1(7);

			ELSE
				Output1 <= ZEROS;
				Cout <= '0';

			END IF;

		ELSE

			IF NumofPos = 0 THEN
				Output1 <= Input1;
				Cout <= '0';

			ELSIF NumofPos >= 1 AND 7 >= NumofPos THEN
				Output1 <= (S(NumofPos - 1 DOWNTO 0) & Input1(7 DOWNTO NumofPos)) + Input1(NumofPos - 1);
				Cout <= Input1(NumofPos - 1);

			ELSIF NumofPos = 8 THEN
				Output1 <= S + Input1(7);
				Cout <= Input1(7);

			ELSE
				Output1 <= S;
				Cout <= '0';

			END IF;

		END IF;

	END PROCESS;

END Behavioral;