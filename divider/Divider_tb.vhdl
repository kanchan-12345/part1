library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Divider_tb is
end Divider_tb;

architecture Behavioral of Divider_tb is
    -- Component declaration
    component Divider
        Port (
            dividend  : in  UNSIGNED(7 downto 0);
            divisor   : in  UNSIGNED(7 downto 0);
            quotient  : out UNSIGNED(7 downto 0);
            remainder : out UNSIGNED(7 downto 0)
        );
    end component;

    -- Signals to connect to the DUT
    signal dividend  : UNSIGNED(7 downto 0) := (others => '0');
    signal divisor   : UNSIGNED(7 downto 0) := (others => '0');
    signal quotient  : UNSIGNED(7 downto 0);
    signal remainder : UNSIGNED(7 downto 0);

begin
    -- Instantiate the Divider
    UUT: Divider
        Port map (
            dividend  => dividend,
            divisor   => divisor,
            quotient  => quotient,
            remainder => remainder
        );

    -- Stimulus process
    stimulus: process
    begin
        -- Test case 1: Divide 100 by 10
        dividend <= to_unsigned(100, 8);
        divisor  <= to_unsigned(10, 8);
        wait for 10 ns;

        -- Test case 2: Divide 255 by 15
        dividend <= to_unsigned(255, 8);
        divisor  <= to_unsigned(15, 8);
        wait for 10 ns;

        -- Test case 3: Divide 50 by 7
        dividend <= to_unsigned(50, 8);
        divisor  <= to_unsigned(7, 8);
        wait for 10 ns;

        -- Test case 4: Divide 10 by 0 (divide by zero scenario)
        dividend <= to_unsigned(10, 8);
        divisor  <= to_unsigned(0, 8);
        wait for 10 ns;

        -- Test case 5: Divide 0 by 5
        dividend <= to_unsigned(0, 8);
        divisor  <= to_unsigned(5, 8);
        wait for 10 ns;

        -- End simulation
        wait;
    end process;

end Behavioral;
