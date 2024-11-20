library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplier_tb is
end entity multiplier_tb;

architecture tb of multiplier_tb is
    -- Component declaration
    component multiplier is
        port (
            a, b : in signed(7 downto 0);
            result : out signed(15 downto 0)
        );
    end component;

    -- Signals for stimulus and response
    signal a_tb, b_tb : signed(7 downto 0);
    signal result_tb : signed(15 downto 0);

begin
    -- Instantiate the multiplier component
    uut : multiplier
        port map (
            a => a_tb,
            b => b_tb,
            result => result_tb
        );

    -- Testbench process
    process
    begin
        -- Test positive numbers
        a_tb <= "00001010"; -- 10
        b_tb <= "00001100"; -- 12
        wait for 10 ns;

        -- Test negative numbers
        a_tb <= "11110110"; -- -10
        b_tb <= "11110100"; -- -12
        wait for 10 ns;

        -- Test zero
        a_tb <= "00000000"; -- 0
        b_tb <= "00000000"; -- 0
        wait for 10 ns;

        -- Test max positive
        a_tb <= "01111111"; -- 127
        b_tb <= "01111111"; -- 127
        wait for 10 ns;

        -- Test max negative
        a_tb <= "10000000"; -- -128
        b_tb <= "10000000"; -- -128
        wait for 10 ns;
        
        wait;
    end process;
end architecture tb;