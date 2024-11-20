library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EqualityComparator4Bit is
    Port (
        A     : in  STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit input A
        B     : in  STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit input B
        Equal : out STD_LOGIC                      -- Output signal
    );
end EqualityComparator4Bit;

architecture Behavioral of EqualityComparator4Bit is
begin
    process (A, B)
    begin
        if (A = B) then
            Equal <= '1';  -- Set output to 1 if A equals B
        else
            Equal <= '0';  -- Otherwise, set output to 0
        end if;
    end process;
end Behavioral;
