LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY BehavioralVHDLCode IS
    PORT (
        key, reset, clock, data_clock, unlock, si : IN STD_LOGIC;
        y : OUT STD_LOGIC
    );
END BehavioralVHDLCode;

ARCHITECTURE Behavioral OF BehavioralVHDLCode IS
    SIGNAL res : STD_LOGIC;
    SIGNAL q : STD_LOGIC_VECTOR(23 DOWNTO 0);
    SIGNAL x : STD_LOGIC_VECTOR(1 DOWNTO 0);

    SIGNAL clockOfC2 : STD_LOGIC;
    SIGNAL inputOfD : STD_LOGIC;
    SIGNAL outputOfD : STD_LOGIC;

    SIGNAL outputOfComp : STD_LOGIC;
    SIGNAL resetOfC16 : STD_LOGIC;
    SIGNAL outputOfC16 : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL outputOfSIPO1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL outputOfSIPO2 : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL resetOfT : STD_LOGIC;

    SIGNAL outputOfMUX4 : STD_LOGIC;
    SIGNAL outputOfMUX2 : STD_LOGIC;
    SIGNAL ti : STD_LOGIC;
    SIGNAL k : STD_LOGIC;
    SIGNAL T : STD_LOGIC := '1';
BEGIN
    ti <= NOT(unlock);
    res <= NOT(reset);
    y <= k;
    clockOfC2 <= (inputOfD AND NOT(outputOfD));
    inputOfD <= outputOfSIPO1(0) AND outputOfSIPO1(1) AND outputOfSIPO1(2) AND outputOfSIPO1(3) AND outputOfSIPO1(4) AND outputOfSIPO1(5) AND outputOfSIPO1(6) AND outputOfSIPO1(7);
    resetOfC16 <= res OR outputOfComp;
    resetOfT <= (ti OR res);

    -- Counter (24-Bit)
    PROCESS (clock, res)
    BEGIN

        IF (res = '1') THEN
            q <= (OTHERS => '0');
        ELSIF (clock' event AND clock = '1') THEN
            q <= q + 1;
        END IF;

    END PROCESS;

    -- Counter (2-Bit)
    PROCESS (clockOfC2, res)
    BEGIN

        IF (res = '1') THEN
            x <= (OTHERS => '0');
        ELSIF (clockOfC2' event AND clockOfC2 = '1') THEN
            x <= x + 1;
        END IF;

    END PROCESS;

    -- Counter (16-Bit)
    PROCESS (outputOfMUX2, resetOfC16)
    BEGIN

        IF (resetOfC16 = '1') THEN
            outputOfC16 <= (OTHERS => '0');
        ELSIF (outputOfMUX2' event AND outputOfMUX2 = '1') THEN
            outputOfC16 <= outputOfC16 + 1;
        END IF;

    END PROCESS;

    -- D Flip-Flop
    PROCESS (q(15), res)
    BEGIN
        IF (res = '1') THEN
            outputOfD <= '0';
        ELSIF (rising_edge(q(15))) THEN
            outputOfD <= inputOfD;
        END IF;
    END PROCESS;


    -- T Flip-Flop
    PROCESS (outputOfComp, resetOfT)
    BEGIN

        IF (resetOfT = '1') THEN
            k <= '0';
        ELSIF (outputOfComp' event AND outputOfComp = '1') THEN
            IF (T = '1') THEN
                k <= NOT k;
            ELSE
                k <= k;
            END IF;
        END IF;

    END PROCESS;

    -- Serial In Parallel Out Shift Register - 1
    PROCESS (q(15), res)
    BEGIN
        IF (res = '1') THEN
            outputOfSIPO1 <= (OTHERS => '0');
        ELSIF (q(15)' event AND q(15) = '1') THEN
            outputOfSIPO1 <= key & outputOfSIPO1(7 DOWNTO 1);
        END IF;
    END PROCESS;

    -- Serial In Parallel Out Shift Register - 2
    PROCESS (data_clock, res)
    BEGIN

        IF (res = '1') THEN
            outputOfSIPO2 <= (OTHERS => '0');
        ELSIF (data_clock'event AND data_clock = '1') THEN
            outputOfSIPO2 <= si & outputOfSIPO2(15 DOWNTO 1);
        END IF;

    END PROCESS;

    -- MUX-4
    outputOfMUX4 <= q(10) WHEN x = "00" ELSE
        q(12) WHEN x = "01" ELSE
        q(14) WHEN x = "10" ELSE
        q(16) WHEN x = "11";

    -- MUX-2
    outputOfMUX2 <= outputOfMUX4 WHEN k = '0' ELSE
        '0' WHEN k = '1';

    -- Comparator
    outputOfComp <= '1' WHEN (outputOfSIPO2 = outputOfC16) ELSE
        '0';

END Behavioral;