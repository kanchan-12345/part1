library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Use numeric_std for unsigned arithmetic

entity multiplier is
    Port (
        A      : in  STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit input A
        B      : in  STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit input B
        P      : out STD_LOGIC_VECTOR(7 downto 0)   -- 8-bit product output
    );
end multiplier;

architecture Behavioral of multiplier is
begin
    process(A, B)
        variable temp: STD_LOGIC_VECTOR(7 downto 0); -- Temporary storage for the result
    begin
        temp := (others => '0'); -- Initialize to zero
        -- Partial product 0
        temp(0) := A(0) and B(0);
        temp(1) := (A(1) and B(0)) or (A(0) and B(1));
        temp(2) := (A(2) and B(0)) or (A(1) and B(1)) or (A(0) and B(2));
        temp(3) := (A(3) and B(0)) or (A(2) and B(1)) or (A(1) and B(2)) or (A(0) and B(3));
        -- Assign the product to output
        P <= temp;
    end process;
end Behavioral;
