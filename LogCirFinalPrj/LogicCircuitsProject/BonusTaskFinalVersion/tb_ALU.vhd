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

	-- Stimuluation Process
	stim_proc : PROCESS

	BEGIN

		-- Determining Signal A
		A <= x"ac";

		-------------------------- Variable Rotation Left
		OPCODE <= x"a";
		Cin <= '0';

		B <= x"00";
		WAIT FOR 100 ns;
		B <= x"01";
		WAIT FOR 100 ns;
		B <= x"02";
		WAIT FOR 100 ns;
		B <= x"03";
		WAIT FOR 100 ns;
		B <= x"04";
		WAIT FOR 100 ns;
		B <= x"05";
		WAIT FOR 100 ns;
		B <= x"06";
		WAIT FOR 100 ns;
		B <= x"07";
		WAIT FOR 100 ns;
		B <= x"08";
		WAIT FOR 100 ns;
		B <= x"09";
		WAIT FOR 100 ns;

		-------------------------- Variable Rotation Left with Carry
		OPCODE <= x"b";
		Cin <= '1';

		B <= x"00";
		WAIT FOR 100 ns;
		B <= x"01";
		WAIT FOR 100 ns;
		B <= x"02";
		WAIT FOR 100 ns;
		B <= x"03";
		WAIT FOR 100 ns;
		B <= x"04";
		WAIT FOR 100 ns;
		B <= x"05";
		WAIT FOR 100 ns;
		B <= x"06";
		WAIT FOR 100 ns;
		B <= x"07";
		WAIT FOR 100 ns;
		B <= x"08";
		WAIT FOR 100 ns;
		B <= x"09";
		WAIT FOR 100 ns;
		B <= x"0a";
		WAIT FOR 100 ns;

		-------------------------- Variable Logic Shift Right
		OPCODE <= x"c";
		Cin <= '0';

		B <= x"00";
		WAIT FOR 100 ns;
		B <= x"01";
		WAIT FOR 100 ns;
		B <= x"02";
		WAIT FOR 100 ns;
		B <= x"03";
		WAIT FOR 100 ns;
		B <= x"04";
		WAIT FOR 100 ns;
		B <= x"05";
		WAIT FOR 100 ns;
		B <= x"06";
		WAIT FOR 100 ns;
		B <= x"07";
		WAIT FOR 100 ns;
		B <= x"08";
		WAIT FOR 100 ns;
		B <= x"09";
		WAIT FOR 100 ns;
		B <= x"0a";
		WAIT FOR 100 ns;

		-------------------------- Variable Arithmetic Shift Right with Rounding
		OPCODE <= x"d";

		B <= x"00";
		WAIT FOR 100 ns;
		B <= x"01";
		WAIT FOR 100 ns;
		B <= x"02";
		WAIT FOR 100 ns;
		B <= x"03";
		WAIT FOR 100 ns;
		B <= x"04";
		WAIT FOR 100 ns;
		B <= x"05";
		WAIT FOR 100 ns;
		B <= x"06";
		WAIT FOR 100 ns;
		B <= x"07";
		WAIT FOR 100 ns;
		B <= x"08";
		WAIT FOR 100 ns;
		B <= x"09";
		WAIT FOR 100 ns;
		B <= x"0a";
		WAIT FOR 100 ns;

		-------------------------- Variable Logic Shift Left
		OPCODE <= x"e";

		B <= x"00";
		WAIT FOR 100 ns;
		B <= x"01";
		WAIT FOR 100 ns;
		B <= x"02";
		WAIT FOR 100 ns;
		B <= x"03";
		WAIT FOR 100 ns;
		B <= x"04";
		WAIT FOR 100 ns;
		B <= x"05";
		WAIT FOR 100 ns;
		B <= x"06";
		WAIT FOR 100 ns;
		B <= x"07";
		WAIT FOR 100 ns;
		B <= x"08";
		WAIT FOR 100 ns;
		B <= x"09";
		WAIT FOR 100 ns;
		B <= x"0a";
		WAIT FOR 100 ns;

		-------------------------- Variable Arithmetic Shift Right with Rounding - Exceptional Cases
		OPCODE <= x"d";

		A <= x"ff";
		B <= x"01";
		WAIT FOR 100 ns;

		B <= x"02";
		WAIT FOR 100 ns;

		A <= x"fe";
		B <= x"01";
		WAIT FOR 100 ns;

		B <= x"02";
		WAIT FOR 100 ns;

		B <= x"03";
		WAIT FOR 100 ns;

		WAIT;

	END PROCESS;

END;