library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Use numeric_std for unsigned arithmetic

entity divider is
    Port (
        A      : in  STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit Dividend
        B      : in  STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit Divisor
        Q      : out STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit Quotient
        R      : out STD_LOGIC_VECTOR(3 downto 0)   -- 4-bit Remainder
    );
end divider;

architecture Behavioral of divider is
    signal quotient : STD_LOGIC_VECTOR(3 downto 0) := "0000";  -- Initial quotient is zero
    signal remainder : STD_LOGIC_VECTOR(3 downto 0) := "0000";  -- Initial remainder is zero
begin
    process(A, B)
        variable temp_quotient : STD_LOGIC_VECTOR(3 downto 0) := "0000";  -- Temporary quotient
        variable temp_remainder : STD_LOGIC_VECTOR(3 downto 0) := "0000";  -- Temporary remainder
    begin
        -- Initialize the remainder with the dividend
        temp_remainder := A;
        temp_quotient := "0000";  -- Reset quotient to 0000

        -- Perform the division using subtraction
        for i in 0 to 3 loop
            -- Shift the remainder left by 1 bit, effectively multiplying by 2
            temp_remainder := temp_remainder(2 downto 0) & '0';  -- Keep it 4 bits

            -- Compare the remainder to the divisor (after converting to unsigned)
            if (to_unsigned(to_integer(unsigned(temp_remainder)), 4) >= to_unsigned(to_integer(unsigned(B)), 4)) then
                -- Perform the subtraction
                temp_remainder := std_logic_vector(unsigned(temp_remainder) - unsigned(B)); 
                -- Set the quotient bit to 1
                temp_quotient(i) := '1';  
            else
                -- Set the quotient bit to 0
                temp_quotient(i) := '0';  
            end if;
        end loop;

        -- Assign the result to the output ports
        Q <= temp_quotient;  -- Output the quotient
        R <= temp_remainder(3 downto 0);  -- Output the remainder
    end process;
end Behavioral;
