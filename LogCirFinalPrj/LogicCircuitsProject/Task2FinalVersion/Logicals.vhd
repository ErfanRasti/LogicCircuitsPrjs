LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Logicals IS
	PORT (
		Input1, Input2 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		Op : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		Output1 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END Logicals;

ARCHITECTURE Behavioral OF Logicals IS

BEGIN

	-- Calculating the result of logical operations
	-- 00 -> AND
	-- 01 -> OR
	-- 02 -> XOR
	-- 03 -> XNOR

	-- Determining Output1 for Each Operation
	WITH Op SELECT
		Output1 <= (Input1 AND Input2) WHEN "00",
		(Input1 OR Input2) WHEN "01",
		(Input1 XOR Input2) WHEN "10",
		(Input1 XNOR Input2) WHEN "11";

END Behavioral;