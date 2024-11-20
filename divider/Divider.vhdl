library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Divider is
    Port (
        dividend  : in  UNSIGNED(7 downto 0); -- 8-bit dividend
        divisor   : in  UNSIGNED(7 downto 0); -- 8-bit divisor
        quotient  : out UNSIGNED(7 downto 0); -- 8-bit quotient
        remainder : out UNSIGNED(7 downto 0)  -- 8-bit remainder
    );
end Divider;

architecture Behavioral of Divider is
begin
    process(dividend, divisor)
    begin
        if divisor /= 0 then
            quotient  <= dividend / divisor;
            remainder <= dividend mod divisor;
        else
            quotient  <= (others => '0');  -- Handle divide by zero
            remainder <= dividend;        -- Remainder equals dividend
        end if;
    end process;
end Behavioral;
