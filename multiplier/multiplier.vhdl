library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplier is
    port (
        a, b : in signed(7 downto 0);
        result : out signed(15 downto 0)
    );
end entity multiplier;

architecture rtl of multiplier is
begin
    process(a, b)
    begin
        result <= a * b;
    end process;
end architecture rtl;