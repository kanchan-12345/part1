library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity divider is
    Port (
        A      : in  STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit Dividend
        B      : in  STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit Divisor
        Q      : out STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit Quotient
        R      : out STD_LOGIC_VECTOR(3 downto 0)   -- 4-bit Remainder
    );
end divider;

architecture Behavioral of divider is
    signal temp_quotient : unsigned(3 downto 0) := (others => '0');  -- Temporary quotient
    signal temp_remainder : unsigned(4 downto 0) := (others => '0');  -- 5-bit remainder for intermediate calculations
    signal divisor : unsigned(3 downto 0);
begin
    process(A, B)
    begin
        -- Convert inputs to unsigned for arithmetic operations
        temp_quotient <= (others => '0');
        temp_remainder <= (others => '0');
        divisor <= unsigned(B);

        -- Load the dividend into the remainder
        temp_remainder(3 downto 0) <= unsigned(A);

        -- Perform division through iterative subtraction
        for i in 3 downto 0 loop
            -- Shift remainder left by 1 bit
            temp_remainder <= temp_remainder(3 downto 0) & '0';

            -- Subtract divisor if remainder is greater than or equal to divisor
            if temp_remainder(4 downto 1) >= divisor then
                temp_remainder(4 downto 1) <= temp_remainder(4 downto 1) - divisor;
                temp_quotient(i) <= '1';  -- Set quotient bit
            else
                temp_quotient(i) <= '0';  -- Set quotient bit to 0
            end if;
        end loop;

        -- Assign final quotient and remainder
        Q <= std_logic_vector(temp_quotient);          -- Convert unsigned quotient to STD_LOGIC_VECTOR
        R <= std_logic_vector(temp_remainder(3 downto 0));  -- Extract final remainder
    end process;
end Behavioral;
