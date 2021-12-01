----------------------------------------------------------------------------------
-- Project Name: ALU_SEQUENTIAL
-- Engineers:
--			Erfan Rasti
--          Arman Abbasi
--          Danial Gharibi
--          Seyed AhmadReza Mousavi
-- professor : Dr. MohammadReza Pourfard
-- Create Date: 07/18/2021
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ALU_SEQ IS
	PORT (
		I : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		LOAD : IN STD_LOGIC;
		RESET : IN STD_LOGIC;
		SEL_IN : IN STD_LOGIC;
		SEL_OUT : IN STD_LOGIC;
		RUN : IN STD_LOGIC;
		CLK : IN STD_LOGIC;
		OPCODE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		Z : INOUT STD_LOGIC;
		Cout : INOUT STD_LOGIC;
		V : INOUT STD_LOGIC;
		N : INOUT STD_LOGIC;
		R : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		F_active : OUT STD_LOGIC;
		X_bin_pal : OUT STD_LOGIC;
		X_prime : OUT STD_LOGIC);
END ALU_SEQ;

ARCHITECTURE Structral OF ALU_SEQ IS

	-----------------Components--------------------
	COMPONENT ALU IS
		PORT (
			A : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			B : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			Cin : IN STD_LOGIC;
			OPCODE : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			X : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			Y : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			Z : INOUT STD_LOGIC;
			Cout : INOUT STD_LOGIC;
			V : INOUT STD_LOGIC;
			X_bin_pal : OUT STD_LOGIC;
			X_prime : OUT STD_LOGIC;
			N : OUT STD_LOGIC);
	END COMPONENT;

	-------------------Signals-----------------------
	SIGNAL A_ALU : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL B_ALU : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL X_ALU : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL Y_ALU : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL Z_ALU : STD_LOGIC;
	SIGNAL Cout_ALU : STD_LOGIC;
	SIGNAL V_ALU : STD_LOGIC;
	SIGNAL X_bin_pal_ALU : STD_LOGIC;
	SIGNAL X_prime_ALU : STD_LOGIC;
	SIGNAL N_ALU : STD_LOGIC;

	SIGNAL en_C, en_V, en_N : STD_LOGIC;
	-------------------------------------------------

BEGIN

	-- Input Registers Process
	PROCESS (SEL_IN, I, CLK, LOAD, RESET)
	BEGIN
		IF (RESET = '1') THEN
			A_ALU <= x"00";
			B_ALU <= x"00";

		ELSIF rising_edge(CLK) AND LOAD = '1' THEN
			IF (SEL_IN = '0') THEN
				A_ALU <= I;
			ELSIF (SEL_IN = '1') THEN
				B_ALU <= I;
			END IF;
		END IF;
	END PROCESS;

	Unit : ALU PORT MAP(
		A => A_ALU, B => B_ALU, Cin => Cout, OPCODE => OPCODE, X => X_ALU, Y => Y_ALU, Z => Z_ALU,
		Cout => Cout_ALU, V => V_ALU, X_bin_pal => X_bin_pal_ALU, X_prime => X_prime_ALU, N => N_ALU);

	PROCESS (RESET, CLK, OPCODE, RUN, SEL_OUT, Cout, V, Z, en_C, en_V, en_N, X_ALU, Y_ALU, Z_ALU,
		Cout_ALU, N_ALU, V_ALU, X_bin_pal_ALU, X_prime_ALU)

	BEGIN

		-- Output Registers Dependent on OPCODE and Reset
		IF (RESET = '1') THEN
			R <= (OTHERS => '0');
			Cout <= '0';
			Z <= '0';
			V <= '0';
			N <= '0';
			X_prime <= '0';
			X_bin_pal <= '0';

		ELSIF rising_edge(CLK) THEN

			IF OPCODE = x"0" OR OPCODE = x"1" OR OPCODE = x"2" OR OPCODE = x"3" THEN
				-- Logicals
				en_N <= '1';
				en_V <= '0';
				en_C <= '0';

			ELSIF OPCODE = x"4" OR OPCODE = x"6" THEN
				-- Unsigned_Addition
				en_N <= '1';
				en_V <= '0';
				en_C <= '1';

			ELSIF OPCODE = x"5" THEN
				-- Signed_Addition
				en_N <= '1';
				en_V <= '1';
				en_C <= '0';

			ELSIF OPCODE = x"7" OR OPCODE = x"8" THEN
				-- Multiplication
				en_N <= '1';
				en_V <= '0';
				en_C <= '0';

			ELSIF OPCODE = x"9" THEN
				-- Unsigned_Subtraction
				en_N <= '1';
				en_V <= '0';
				en_C <= '1';

			ELSIF OPCODE = x"a" THEN
				-- Rotation Left
				en_N <= '1';
				en_V <= '0';
				en_C <= '0';

			ELSIF OPCODE = x"b" OR OPCODE = x"c" OR OPCODE = x"d" OR OPCODE = x"e" THEN
				-- Rotation Left with Carry
				-- Logic Shift Right
				-- Arithmetic Shift Right
				-- Logic Shift Left
				en_N <= '1';
				en_V <= '0';
				en_C <= '1';

			ELSIF OPCODE = x"f" THEN
				-- BCD to Binary Conversion
				en_N <= '0';
				en_V <= '0';
				en_C <= '1';

			END IF;

			-- Flip-Flop for Activating Outputs via RUN
			IF RUN = '1' THEN
				Z <= Z_ALU;
				X_bin_pal <= X_bin_pal_ALU;
				X_prime <= X_prime_ALU;

				IF (SEL_OUT = '0') THEN
					R <= X_ALU;

				ELSIF (SEL_OUT = '1') THEN
					R <= Y_ALU;

				END IF;

			END IF;

			-- Flip-Flop for Activating Cout
			IF en_C = '1' THEN
				Cout <= Cout_ALU;
			END IF;

			-- Flip-Flop for Activating V
			IF en_V = '1' THEN
				V <= V_ALU;
			END IF;

			-- Flip-Flop for Activating N
			IF en_N = '1' THEN
				N <= N_ALU;
			END IF;

		END IF;

		-- F_Active
		F_Active <= Cout OR V OR Z;

	END PROCESS;

END Structral;