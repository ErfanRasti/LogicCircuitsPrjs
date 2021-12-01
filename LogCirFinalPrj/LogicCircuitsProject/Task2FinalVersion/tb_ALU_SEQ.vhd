LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY tb_ALU_SEQ IS
END tb_ALU_SEQ;

ARCHITECTURE Structral OF tb_ALU_SEQ IS

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT ALU_SEQ
		PORT (
			I : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			LOAD : IN STD_LOGIC;
			RESET : IN STD_LOGIC;
			SEL_IN : IN STD_LOGIC;
			SEL_OUT : IN STD_LOGIC;
			RUN : IN STD_LOGIC;
			CLK : IN STD_LOGIC;
			OPCODE : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			Z : INOUT STD_LOGIC;
			Cout : INOUT STD_LOGIC;
			V : INOUT STD_LOGIC;
			N : INOUT STD_LOGIC;
			R : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			F_active : OUT STD_LOGIC;
			X_bin_pal : OUT STD_LOGIC;
			X_prime : OUT STD_LOGIC
		);
	END COMPONENT;

	-- Defining Input Signals
	SIGNAL I : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL LOAD : STD_LOGIC := '0';
	SIGNAL RESET : STD_LOGIC := '0';
	SIGNAL SEL_IN : STD_LOGIC := '0';
	SIGNAL SEL_OUT : STD_LOGIC := '0';
	SIGNAL RUN : STD_LOGIC := '0';
	SIGNAL CLK : STD_LOGIC := '0';
	SIGNAL OPCODE : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');

	-- Bidirectional Buses
	SIGNAL Z : STD_LOGIC;
	SIGNAL Cout : STD_LOGIC;
	SIGNAL V : STD_LOGIC;
	SIGNAL N : STD_LOGIC;

	-- Defining Output Signals
	SIGNAL R : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL F_active : STD_LOGIC;
	SIGNAL X_bin_pal : STD_LOGIC;
	SIGNAL X_prime : STD_LOGIC;

	-- Clock Period Definitions
	CONSTANT CLK_period : TIME := 10 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	UUT : ALU_SEQ PORT MAP(
		I => I,
		LOAD => LOAD,
		RESET => RESET,
		SEL_IN => SEL_IN,
		SEL_OUT => SEL_OUT,
		RUN => RUN,
		Clk => Clk,
		OPCODE => OPCODE,
		R => R,
		Z => Z,
		Cout => Cout,
		V => V,
		F_active => F_active,
		X_bin_pal => X_bin_pal,
		X_prime => X_prime,
		N => N
	);

	-- Clock process definitions
	CLK_process : PROCESS
	BEGIN
		CLK <= '0';
		WAIT FOR CLK_period/2;
		CLK <= '1';
		WAIT FOR CLK_period/2;
	END PROCESS;

	-- Stimulation Process
	stim_proc : PROCESS
	BEGIN

		------------------- Time: 0 - 100ns
		-- Initial Rest
		Reset <= '1';
		WAIT FOR 100 ns;

		------------------- Time: 100 - 200ns
		-- Enabling
		Reset <= '0';
		Load <= '1';
		Run <= '1';

		-------------------------------------- U1 : AND
		OPCODE <= x"0";

		I <= x"a3";
		-- Selecting A   
		sel_in <= '0';
		WAIT FOR 100 ns;

		------------------- Time: 200 - 300ns
		I <= x"26";
		-- Selecting B
		sel_in <= '1';

		-- Selecting X
		sel_out <= '0';
		WAIT FOR 100 ns;

		-- Reseting to clear the input values
		--		Reset <= '1';
		--		wait for 25 ns;
		--		reset <= '0';
		--		wait for 25 ns;

		-------------------------------------- U2 : OR

		------------------- Time: 300 - 400ns
		OPCODE <= x"1";

		I <= x"b2";
		-- Selecting A
		sel_in <= '0';
		WAIT FOR 100 ns;

		------------------- Time: 400 - 500ns
		I <= x"66";
		-- Selecting B
		sel_in <= '1';

		-- Selecting X
		sel_out <= '0';
		WAIT FOR 100 ns;

		-------------------------------------- U3 : XOR

		------------------- Time: 500 - 600ns
		OPCODE <= x"2";

		I <= x"1c";
		-- Selecting A
		sel_in <= '0';
		WAIT FOR 100 ns;

		------------------- Time: 600 - 700ns
		I <= x"b5";
		-- Selecting B
		sel_in <= '1';

		-- Selecting X
		sel_out <= '0';
		WAIT FOR 100 ns;

		-------------------------------------- U4 : XNOR

		------------------- Time: 700 - 800ns
		OPCODE <= x"3";

		I <= x"6d";
		-- Selecting A
		sel_in <= '0';
		WAIT FOR 100 ns;

		------------------- Time: 800 - 900ns
		I <= x"a1";
		-- Selecting B
		sel_in <= '1';

		-- Selecting X
		sel_out <= '0';
		WAIT FOR 100 ns;

		-------------------------------------- U5 : Unsigned Addition

		------------------- Time: 900 - 1000ns
		OPCODE <= x"4";

		I <= x"c4";
		-- Selecting A
		sel_in <= '0';
		WAIT FOR 100 ns;

		------------------- Time: 1000 - 1100ns
		I <= x"85";
		-- Selecting B
		sel_in <= '1';

		-- Selecting X
		sel_out <= '0';
		WAIT FOR 100 ns;

		-------------------------------------- U6 : Signed Addition

		------------------- Time: 1100 - 1200ns
		OPCODE <= x"5";

		I <= x"7c";
		-- Selecting A
		sel_in <= '0';
		WAIT FOR 100 ns;

		------------------- Time: 1200 - 1300ns
		I <= x"b1";
		-- Selecting B
		sel_in <= '1';

		-- Selecting X
		sel_out <= '0';
		WAIT FOR 100 ns;

		------------------- Time: 1300 - 1400ns
		--- This time overflow is 1.
		I <= x"9b";
		-- Selecting A
		sel_in <= '0';
		WAIT FOR 100 ns;

		------------------- Time: 1400 - 1500ns
		I <= x"a4";
		-- Selecting B
		sel_in <= '1';
		WAIT FOR 100 ns;

		-------------------------------------- U7 : Unsigned Addition with Carry

		------------------- Time: 1500 - 1600ns
		OPCODE <= x"6";

		I <= x"66";
		-- Selecting A
		sel_in <= '0';
		WAIT FOR 100 ns;

		------------------- Time: 1600 - 1700ns
		I <= x"2f";
		-- Selecting B
		sel_in <= '1';

		-- Selecting X
		sel_out <= '0';
		WAIT FOR 100 ns;

		-------------------------------------- U8 : Signed Multiplication

		------------------- Time: 1700 - 1800ns
		OPCODE <= x"7";

		I <= x"d3";
		-- Selecting A
		sel_in <= '0';
		WAIT FOR 100 ns;

		------------------- Time: 1800 - 1900ns
		I <= x"79";
		-- Selecting B
		sel_in <= '1';

		-- Selecting X
		sel_out <= '0';
		WAIT FOR 100 ns;

		------------------- Time: 1900 - 2000ns
		-- Selecting Y
		sel_out <= '1';
		WAIT FOR 100 ns;

		-------------------------------------- U9 : Unsigned Multiplication

		------------------- Time: 2000 - 2100ns
		OPCODE <= x"8";

		I <= x"b2";
		-- Selecting A
		sel_in <= '0';
		WAIT FOR 100 ns;

		------------------- Time: 2100 - 2200ns
		I <= x"39";
		-- Selecting B
		sel_in <= '1';

		-- Selecting X
		sel_out <= '0';
		WAIT FOR 100 ns;

		------------------- Time: 2200 - 2300ns
		-- Selecting Y
		sel_out <= '1';
		WAIT FOR 100 ns;

		-------------------------------------- U10 : Unsigned Subtraction

		------------------- Time: 2300 - 2400ns
		OPCODE <= x"9";

		I <= x"5e";
		-- Selecting A 
		sel_in <= '0';
		WAIT FOR 100 ns;

		------------------- Time: 2400 - 2500ns
		I <= x"8b";
		-- Selecting B
		sel_in <= '1';

		-- Selecting X
		sel_out <= '0';
		WAIT FOR 100 ns;

		-------------------------------------- U11 : Rotation Left

		------------------- Time: 2500 - 2600ns
		OPCODE <= x"a";

		I <= x"a5";
		-- Selecting A
		sel_in <= '0';

		-- Selecting X
		sel_out <= '0';
		WAIT FOR 100 ns;

		-------------------------------------- U12 : Rotation Left with Carry

		------------------- Time: 2600 - 2700ns
		OPCODE <= x"b";

		I <= x"33";
		-- Selecting A
		sel_in <= '0';

		-- Selecting X
		sel_out <= '0';
		WAIT FOR 100 ns;

		-------------------------------------- U13 : Logic Shift Right

		------------------- Time: 2700 - 2800ns
		OPCODE <= x"c";

		I <= x"c6";
		-- Selecting A
		sel_in <= '0';

		-- Selecting X
		sel_out <= '0';
		WAIT FOR 100 ns;

		-------------------------------------- U14 : Arithmetic Shift Right

		------------------- Time: 2800 - 2900ns
		OPCODE <= x"d";

		I <= x"8d";
		-- Selecting A
		sel_in <= '0';

		-- Selecting X
		sel_out <= '0';
		WAIT FOR 100 ns;

		-------------------------------------- U15 : Logic Shift Left

		------------------- Time: 2900 - 3000ns
		OPCODE <= x"e";

		I <= x"36";
		-- Selecting A
		sel_in <= '0';

		-- Selecting X
		sel_out <= '0';
		WAIT FOR 100 ns;
		-------------------------------------- U16 : BCD to Binary Conversion

		------------------- Time: 3000 - 3100ns
		OPCODE <= x"f";

		I <= x"28";
		-- Selecting A
		sel_in <= '0';
		WAIT FOR 100 ns;

		------------------- Time: 3100 - 3200ns
		I <= x"75";
		-- Selecting B
		sel_in <= '1';

		-- Selecting X
		sel_out <= '0';
		WAIT FOR 100 ns;

		------------------- Time: 3200 - 3300ns
		-- Selecting Y
		sel_out <= '1';
		WAIT FOR 100 ns;

		-------------------------------------- Testing Load

		------------------- Time: 3300 - 3400ns
		Load <= '0';
		OPCODE <= x"0";
		I <= x"ff";
		WAIT FOR 100 ns;

		------------------- Time: 3400 - 3500ns
		-- Selecting B
		sel_in <= '1';
		I <= x"aa";
		WAIT FOR 100 ns;

		------------------- Time: 3500 - 3600ns
		Load <= '1';

		-------------------------------------- Testing Run
		Run <= '0';
		OPCODE <= x"1";

		-- Selecting Y
		sel_out <= '1';
		WAIT FOR 100 ns;

		-------------------------------------- Testing Reset

		------------------- Time: 3600 - 3700ns
		Reset <= '1';
		WAIT FOR 100 ns;

		WAIT;

	END PROCESS;
END;