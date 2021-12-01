----------------------------------------------------------------------------------
-- Project Name: ALU
-- Engineers:
--			Seyed AhmadReza Mousavi
--          Arman Abbasi
--          Danial Gharibi
--			Erfan Rasti
-- professor : Dr. MohammadReza Pourfard
-- Create Date: 07/18/2021
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ALU IS
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
		F_active : OUT STD_LOGIC;
		X_bin_pal : OUT STD_LOGIC;
		X_prime : OUT STD_LOGIC;
		N : OUT STD_LOGIC);
END ALU;

ARCHITECTURE Structral OF ALU IS

	--------------------------Components--------------------------
	COMPONENT Logicals IS
		PORT (
			Input1, Input2 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			Op : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
			Output1 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
	END COMPONENT;

	COMPONENT Unsigned_Addition IS
		PORT (
			Input1, Input2 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			Cin : IN STD_LOGIC;
			Op : IN STD_LOGIC;
			Output1 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			Cout : OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT Signed_Addition IS
		PORT (
			Input1, Input2 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			Output1 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			N : OUT STD_LOGIC;
			V : OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT Multiplication IS
		PORT (
			Input1, Input2 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			Op : IN STD_LOGIC;
			Output1, Output2 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			N : OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT Unsigned_Subtraction IS
		PORT (
			Input1, Input2 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			Output1 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			Cout : OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT Rotation IS
		PORT (
			Input1 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			Op : IN STD_LOGIC;
			Cin : IN STD_LOGIC;
			Output1 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			Cout : OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT Shift_Right IS
		PORT (
			Input1 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			Op : IN STD_LOGIC;
			Output1 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			N : OUT STD_LOGIC;
			Cout : OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT Shift_Left IS
		PORT (
			Input1 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			Output1 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			N : OUT STD_LOGIC;
			Cout : OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT BCD2BIN IS
		PORT (
			Input1, Input2 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			Output1, Output2 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			Cout : OUT STD_LOGIC);
	END COMPONENT;

	---------------------------Signals---------------------------
	SIGNAL X_LOGICALS : STD_LOGIC_VECTOR (7 DOWNTO 0);

	SIGNAL X_UADD : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL Cout_UADD : STD_LOGIC;

	SIGNAL X_SADD : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL N_SADD : STD_LOGIC;
	SIGNAL V_SADD : STD_LOGIC;

	SIGNAL X_MULTI : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL Y_MULTI : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL N_MULTI : STD_LOGIC;

	SIGNAL X_USUB : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL Cout_USUB : STD_LOGIC;

	SIGNAL X_ROT : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL Cout_ROT : STD_LOGIC;

	SIGNAL X_SHR : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL N_SHR : STD_LOGIC;
	SIGNAL Cout_SHR : STD_LOGIC;

	SIGNAL X_SHL : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL N_SHL : STD_LOGIC;
	SIGNAL Cout_SHL : STD_LOGIC;

	SIGNAL X_BCD : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL Y_BCD : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL Cout_BCD : STD_LOGIC;

	SIGNAL PAL : STD_LOGIC_VECTOR(3 DOWNTO 0);
	------------------------------------------------------

BEGIN
	U1 : Logicals PORT MAP(
		Input1 => A, Input2 => B, Op => OPCODE(1 DOWNTO 0), Output1 => X_LOGICALS);

	U2 : Unsigned_Addition PORT MAP(
		Input1 => A, Input2 => B, Op => OPCODE(1), Cin => Cin, Output1 => X_UADD, Cout => Cout_UADD);

	U3 : Signed_Addition PORT MAP(
		Input1 => A, Input2 => B, Output1 => X_SADD, N => N_SADD, V => V_SADD);

	U4 : Multiplication PORT MAP(
		Input1 => A, Input2 => B, Op => OPCODE(3), Output1 => X_MULTI, Output2 => Y_MULTI, N => N_MULTI);

	U5 : Unsigned_Subtraction PORT MAP(
		Input1 => A, Input2 => B, Output1 => X_USUB, Cout => Cout_USUB);

	U6 : Rotation PORT MAP(
		Input1 => A, Op => OPCODE(0), Cin => Cin, Output1 => X_ROT, Cout => Cout_ROT);

	U7 : Shift_Right PORT MAP(
		Input1 => A, Op => OPCODE(0), Output1 => X_SHR, Cout => Cout_SHR, N => N_SHR);

	U8 : Shift_Left PORT MAP(
		Input1 => A, Output1 => X_SHL, Cout => Cout_SHL, N => N_SHL);

	U9 : BCD2BIN PORT MAP(
		Input1 => A, Input2 => B, Output1 => X_BCD, Output2 => Y_BCD, Cout => Cout_BCD);

	PROCESS (OPCODE, X_LOGICALS, X_UADD, Cout_UADD, X_SADD, V_SADD, N_SADD,
		X_MULTI, Y_MULTI, N_MULTI, X_USUB, Cout_USUB, X_ROT, Cout_ROT, X_SHR,
		N_SHR, Cout_SHR, X_SHL, N_SHL, Cout_SHL, X_BCD, Y_BCD, Cout_BCD)

	BEGIN
		-------Logicals--------
		IF OPCODE = x"0" OR OPCODE = x"1" OR OPCODE = x"2" OR OPCODE = x"3" THEN
			X <= X_LOGICALS;
			Y <= x"00";
			Cout <= '0';
			V <= '0';
			N <= '0';

			-------Unsigned_Addition--------
		ELSIF OPCODE = x"4" OR OPCODE = x"6" THEN
			X <= X_UADD;
			Y <= x"00";
			Cout <= Cout_UADD;
			V <= '0';
			N <= '0';

			-------Signed_Addition--------
		ELSIF OPCODE = x"5" THEN
			X <= X_SADD;
			Y <= x"00";
			N <= N_SADD;
			V <= V_SADD;
			Cout <= '0';

			-------Multiplication--------
		ELSIF OPCODE = x"7" OR OPCODE = x"8" THEN
			X <= X_MULTI;
			Y <= Y_MULTI;
			N <= N_MULTI;
			Cout <= '0';
			V <= '0';

			-------Unsigned_Subtraction--------
		ELSIF OPCODE = x"9" THEN
			X <= X_USUB;
			Y <= x"00";
			Cout <= Cout_USUB;
			V <= '0';
			N <= '0';

			-------Rotation--------
		ELSIF OPCODE = x"a" OR OPCODE = x"b" THEN
			X <= X_ROT;
			Y <= x"00";
			Cout <= Cout_ROT;
			V <= '0';
			N <= '0';

			-------Shift_Right--------
		ELSIF OPCODE = x"c" OR OPCODE = x"d" THEN
			X <= X_SHR;
			Y <= x"00";
			N <= N_SHR;
			Cout <= Cout_SHR;
			V <= '0';

			-------Shift_Left--------
		ELSIF OPCODE = x"e" THEN
			X <= X_SHL;
			Y <= x"00";
			N <= N_SHL;
			Cout <= Cout_SHL;
			V <= '0';

			-------BCD2BIN--------
		ELSE
			X <= X_BCD;
			Y <= Y_BCD;
			Cout <= Cout_BCD;
			V <= '0';
			N <= '0';
		END IF;
	END PROCESS;

	--------Z FLAG-------------
	Z <= '1' WHEN (X = x"00" AND Y = x"00" AND Cout = '0') ELSE
		'0';

	---------F_active------------
	F_active <= Z OR V OR Cout;

	---------X_bin_pal----------
	PAL(0) <= (X(0) XNOR X(7));
	PAL(1) <= (X(1) XNOR X(6));
	PAL(2) <= (X(2) XNOR X(5));
	PAL(3) <= (X(3) XNOR X(4));

	X_bin_pal <= '1' WHEN PAL = x"f" ELSE
		'0';

	--------X_prime-----------
	PROCESS (X)
		VARIABLE Number : INTEGER;
	BEGIN
		Number := conv_integer(X);

		IF (Number = 0 OR Number = 1) THEN
			X_prime <= '0';

		ELSIF (Number = 2 OR Number = 3 OR Number = 5 OR Number = 7 OR Number = 11 OR Number = 13) THEN
			X_prime <= '1';

		ELSIF (Number REM 2 = 0 OR
			Number REM 3 = 0 OR
			Number REM 5 = 0 OR
			Number REM 7 = 0 OR
			Number REM 11 = 0 OR
			Number REM 13 = 0) THEN
			X_prime <= '0';

		ELSE
			X_prime <= '1';

		END IF;
	END PROCESS;

END Structral;