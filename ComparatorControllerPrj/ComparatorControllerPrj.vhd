----------------------------------------------------------------------------------
-- Engineer: Erfan Rasti 
-- Module Name:    mainFile - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mainFile is
  port (
    a, b, c, d : in std_logic_vector (3 downto 0);
    sel        : in std_logic;
    s1         : in std_logic;
    s2         : in std_logic;
    comp       : in std_logic_vector (4 downto 0);
    y          : out std_logic);
end mainFile;

architecture Behavioral of mainFile is

  signal x1        : std_logic_vector(3 downto 0);
  signal x2        : std_logic_vector(3 downto 0);
  signal x3        : std_logic_vector(4 downto 0);
  signal x4        : std_logic;
  signal compTemp	: std_logic_vector(4 downto 0);
  signal cout      : std_logic_vector(3 downto 0);
begin

  -- mux 1 with bus signal
  x1 <= a when (sel ='1') else b;
  -- mux 2 with bus signal
  x2 <= c when (sel ='1') else d;
  
  -- 4 bit full adder
  x3(0)   <= ('0' xor (x1(0) xor x2(0)));
  cout(0) <= (('0' and (a(0) xor b(0))) or (a(0) and b(0)));

  x3(1)   <= (cout(0) xor (x1(1) xor x2(1)));
  cout(1) <= ((cout(0) and (a(1) xor b(1))) or (a(1) and b(1)));

  x3(2)   <= (cout(1) xor (x1(2) xor x2(2)));
  cout(2) <= ((cout(1) and (a(2) xor b(2))) or (a(2) and b(2)));

  x3(3)   <= (cout(2) xor (x1(3) xor x2(3)));
  cout(3) <= ((cout(2) and (a(3) xor b(3))) or (a(3) and b(3)));
  x3(4)   <= cout(3);
  
	-- comparator
	compTemp <= x3 and comp;
	x4 <= compTemp(0) and compTemp(1) and compTemp(2) and compTemp(3) and compTemp(4);

  y <= (s1 and x4) or (s2 and (not x4));
end Behavioral;