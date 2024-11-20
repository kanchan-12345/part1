library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplier_tb is
end multiplier_tb;

architecture Behavioral of multiplier_tb is
    -- Component declaration
    component multiplier
        Port (
            A : in  STD_LOGIC_VECTOR(3 downto 0);
            B : in  STD_LOGIC_VECTOR(3 downto 0);
            P : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Signals for simulation
    signal A, B : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal P    : STD_LOGIC_VECTOR(7 downto 0);

begin
    -- Instantiate the multiplier component
    UUT: multiplier
        Port map (
            A => A,
            B => B,
            P => P
        );

    -- Stimulus process
    process
    begin
        -- Test Case 1
        A <= "0001"; B <= "0010";  -- A = 1, B = 2
        wait for 10 ns;

        -- Test Case 2
        A <= "0110"; B <= "0101";  -- A = 6, B = 5
        wait for 10 ns;

        -- Test Case 3
        A <= "1111"; B <= "1111";  -- A = 15, B = 15
        wait for 10 ns;

        -- Test Case 4
        A <= "1010"; B <= "1100";  -- A = 10, B = 12
        wait for 10 ns;

        -- Test Case 5
        A <= "0000"; B <= "0000";  -- A = 0, B = 0
        wait for 10 ns;

        wait;
    end process;
end Behavioral;
