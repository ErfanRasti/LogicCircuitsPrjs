LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Rotation IS
	PORT (
		Input1, Input2 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		Cin : IN STD_LOGIC;
		Op : IN STD_LOGIC;
		Output1 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		Cout : OUT STD_LOGIC);
END Rotation;

ARCHITECTURE Behavioral OF Rotation IS

	-- Defining Signals

	-- Input1 with Carry
	SIGNAL Input1_C : STD_LOGIC_VECTOR (8 DOWNTO 0);

	-- Output1 with Carry
	SIGNAL Output1_C : STD_LOGIC_VECTOR (8 DOWNTO 0);

BEGIN

	Input1_C <= Cin & Input1;

	PROCESS (Input1, Input2, Op, Input1_C, Output1_C)

		-- NumofPosVRL : Number of Position of Variable Rotation Left
		VARIABLE NumofPosVRL : INTEGER;

		-- NumofPosVRL : Number of Position of Variable Rotation Left with Carry
		VARIABLE NumofPosVRLC : INTEGER;

	BEGIN

		-- Rotation is periodic with period 8.
		NumofPosVRL := CONV_INTEGER(Input2) REM 8;

		-- Rotation with carry is periodic with period 9.
		NumofPosVRLC := CONV_INTEGER(Input2) REM 9;

		-- Variable Rotation Left: Op = '0'
		-- Variable Rotation Left with Carry: Op = '1'

		-- Determining Output1 and Cout for Each Operation
		IF Op = '0' THEN

			IF NumofPosVRL = 0 THEN
				Output1 <= Input1;

			ELSE
				Output1 <= Input1(7 - NumofPosVRL DOWNTO 0) & Input1(7 DOWNTO 8 - NumofPosVRL);

			END IF;

			Cout <= '0';
			Output1_C <= (OTHERS => '0');

		ELSE

			IF NumofPosVRLC = 0 THEN
				Output1_C <= Input1_C;

			ELSE
				Output1_C <= Input1_C(8 - NumofPosVRLC DOWNTO 0) & Input1_C(8 DOWNTO 9 - NumofPosVRLC);

			END IF;

			Output1 <= Output1_C(7 DOWNTO 0);
			Cout <= Output1_C(8);

		END IF;

	END PROCESS;

END Behavioral;