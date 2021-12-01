LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY tb_ALU IS
END tb_ALU;

ARCHITECTURE behavior OF tb_ALU IS

	COMPONENT ALU
		PORT (
			A : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			Cin : IN STD_LOGIC;
			OPCODE : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			X : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			Y : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			Z : INOUT STD_LOGIC;
			Cout : INOUT STD_LOGIC;
			V : INOUT STD_LOGIC;
			F_active : OUT STD_LOGIC;
			X_bin_pal : OUT STD_LOGIC;
			X_prime : OUT STD_LOGIC;
			N : OUT STD_LOGIC
		);
	END COMPONENT;

	-- Defining Signals
	SIGNAL A : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL B : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL Cin : STD_LOGIC := '0';
	SIGNAL OPCODE : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	SIGNAL Z : STD_LOGIC;
	SIGNAL Cout : STD_LOGIC;
	SIGNAL V : STD_LOGIC;
	SIGNAL X : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL Y : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL F_active : STD_LOGIC;
	SIGNAL X_bin_pal : STD_LOGIC;
	SIGNAL X_prime : STD_LOGIC;
	SIGNAL N : STD_LOGIC;

BEGIN

	-- Assigning ALU PORTs to the Relatd Signals
	UUT : ALU PORT MAP(
		A => A,
		B => B,
		Cin => Cin,
		OPCODE => OPCODE,
		X => X,
		Y => Y,
		Z => Z,
		Cout => Cout,
		V => V,
		F_active => F_active,
		X_bin_pal => X_bin_pal,
		X_prime => X_prime,
		N => N
	);

	-- Activating Stimulation Process
	stim_proc : PROCESS
	BEGIN
		--OPCODE1 : AND
		opcode <= x"0";
		A <= x"d4";
		B <= x"72";
		Cin <= '0';
		WAIT FOR 1 us;

		-- OPCODE2:  OR
		opcode <= x"1";
		A <= x"d4";
		B <= x"72";
		Cin <= '0';
		WAIT FOR 1 us;

		-- OPCODE3: XOR
		opcode <= x"2";
		A <= x"d4";
		B <= x"72";
		Cin <= '0';
		WAIT FOR 1 us;

		-- OPCODE4 : XNOR
		opcode <= x"3";
		A <= x"d4";
		B <= x"72";
		Cin <= '0';
		WAIT FOR 1 us;

		-- OPCODE5 : Unsigned Addition (Cout = '1')
		opcode <= x"4";
		A <= x"d4";
		B <= x"a2";
		Cin <= '0';
		WAIT FOR 1 us;

		-- OPCODE5 : Unsigned Addition (Cout = '0')
		A <= x"3e";
		B <= x"58";
		WAIT FOR 1 us;

		-- OPCODE6 : Signed Addition (Both Positive)
		opcode <= x"5";
		A <= x"15";
		B <= x"79";
		Cin <= '0';
		WAIT FOR 1 us;

		-- OPCODE6 : Signed Addition (Both Negative)
		A <= x"97";
		B <= x"c1";
		WAIT FOR 1 us;

		-- OPCODE6 : Signed Addition (Negative And Positive)
		A <= x"87";
		B <= x"63";
		WAIT FOR 1 us;

		-- OPCODE6 : Signed Addition (Positive And Negative)
		A <= x"25";
		B <= x"fb";
		WAIT FOR 1 us;

		-- OPCODE7 : Unsigned Addition with Carry (Cin = '0')
		opcode <= x"6";
		A <= x"d4";
		B <= x"79";
		Cin <= '0';
		WAIT FOR 1 us;

		-- OPCODE7 : Unsigned Addition with Carry (Cin = '1')
		Cin <= '1';
		WAIT FOR 1 us;

		-- OPCODE8 : Signed Multiplication (Both Positive)
		opcode <= x"7";
		A <= x"36";
		B <= x"4b";
		Cin <= '0';
		WAIT FOR 1 us;

		-- OPCODE8 : Signed Multiplication (Both Negatvie)
		A <= x"8e";
		B <= x"af";
		WAIT FOR 1 us;

		-- OPCODE8 : Signed Multiplication (Negative And Positive)
		A <= x"af";
		B <= x"36";
		WAIT FOR 1 us;

		-- OPCODE8 : Signed Multiplication (Positive And Negative)
		A <= x"4b";
		B <= x"8e";
		WAIT FOR 1 us;

		-- OPCODE9 : Unsigned Multiplication
		opcode <= x"8";
		A <= x"c4";
		B <= x"49";
		Cin <= '0';
		WAIT FOR 1 us;

		-- OPCODE10 : Unsigned Subtraction (Positive Answer)
		opcode <= x"9";
		A <= x"b0";
		B <= x"14";
		Cin <= '0';
		WAIT FOR 1 us;

		-- OPCODE10 : Unsigned Subtraction (Negative Answer)
		A <= x"14";
		B <= x"b0";
		WAIT FOR 1 us;

		-- OPCODE11: Rotation Left
		opcode <= x"a";
		A <= x"55";
		B <= x"00";
		Cin <= '0';
		WAIT FOR 1 us;

		-- OPCODE12 : Rotation Left with Carry (Cin = '0')
		opcode <= x"b";
		A <= x"aa";
		B <= x"00";
		Cin <= '0';
		WAIT FOR 1 us;

		-- OPCODE12 : Rotation Left with Carry (Cin = '1')
		Cin <= '1';
		WAIT FOR 1 us;

		-- OPCODE13 : Logical Shift Right
		opcode <= x"c";
		A <= x"f5";
		B <= x"00";
		Cin <= '0';
		WAIT FOR 1 us;

		-- OPCODE14 : Arithmetic Shift Right
		opcode <= x"d";
		A <= x"b3";
		B <= x"00";
		WAIT FOR 1 us;

		-- OPCODE15 : Logical Shift Left
		opcode <= x"e";
		A <= x"a8";
		B <= x"00";
		WAIT FOR 1 us;

		-- OPCODE16 : BCD to Binary Conversion
		opcode <= x"f";
		A <= x"79";
		B <= x"13";
		Cin <= '0';
		WAIT FOR 1 us;

		-- OPCODE16 : BCD to Binary Conversion (Maximum Value)
		opcode <= x"f";
		A <= x"99";
		B <= x"99";
		Cin <= '0';
		WAIT FOR 1 us;

		-- OPCODE16 : BCD to Binary Conversion (X_bin_pal)
		opcode <= x"f";
		A <= x"85";
		B <= x"03";
		Cin <= '0';
		WAIT FOR 1 us;

		-- OPCODE16 : BCD to Binary Conversion (Zero)
		opcode <= x"f";
		A <= x"00";
		B <= x"00";
		Cin <= '0';
		WAIT FOR 1 us;

		-- Testing Z Flag
		opcode <= x"0";
		A <= x"aa";
		B <= x"55";
		Cin <= '0';
		WAIT FOR 1 us;

		-- Testing X_bin_pal
		opcode <= x"0";
		A <= x"42";
		B <= x"ff";
		Cin <= '0';
		WAIT FOR 1 us;

		-- Testing X_prime
		opcode <= x"0";
		A <= x"f9";
		B <= x"eb";
		Cin <= '0';
		WAIT FOR 1 us;

		WAIT;
	END PROCESS;

END;