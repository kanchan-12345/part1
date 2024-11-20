library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Use numeric_std for unsigned arithmetic

entity divider_tb is
end divider_tb;

architecture behavior of divider_tb is
    -- Component Declaration for the unit under test (UUT)
    component divider
        Port (
            A : in  STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit Dividend
            B : in  STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit Divisor
            Q : out STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit Quotient
            R : out STD_LOGIC_VECTOR(3 downto 0)   -- 4-bit Remainder
        );
    end component;

    -- Declare signals to connect to the UUT
    signal A : STD_LOGIC_VECTOR(3 downto 0) := "1010";  -- Dividend (example 10)
    signal B : STD_LOGIC_VECTOR(3 downto 0) := "0011";  -- Divisor (example 3)
    signal Q : STD_LOGIC_VECTOR(3 downto 0);  -- Quotient
    signal R : STD_LOGIC_VECTOR(3 downto 0);  -- Remainder

begin
    -- Instantiate the divider (UUT)
    uut: divider port map (
        A => A,
        B => B,
        Q => Q,
        R => R
    );

    -- Test process to apply inputs and check outputs
    process
    begin
        -- Test Case 1: 10 / 3
        A <= "1010";  -- 10 in binary
        B <= "0011";  -- 3 in binary
        wait for 10 ns;
        
        -- Test Case 2: 7 / 2
        A <= "0111";  -- 7 in binary
        B <= "0010";  -- 2 in binary
        wait for 10 ns;

        -- Test Case 3: 8 / 4
        A <= "1000";  -- 8 in binary
        B <= "0100";  -- 4 in binary
        wait for 10 ns;

        -- Test Case 4: 15 / 5
        A <= "1111";  -- 15 in binary
        B <= "0101";  -- 5 in binary
        wait for 10 ns;

        -- End of simulation
        wait;
    end process;
end behavior;
