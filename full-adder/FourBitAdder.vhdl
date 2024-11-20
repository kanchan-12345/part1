library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Use the standard package for arithmetic

entity FourBitAdder is
    Port (
        A      : in  STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit input A
        B      : in  STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit input B
        Cin    : in  STD_LOGIC;                      -- Carry input
        Sum    : out STD_LOGIC_VECTOR(3 downto 0);   -- 4-bit Sum output
        Cout   : out STD_LOGIC                        -- Carry output
    );
end FourBitAdder;

architecture Behavioral of FourBitAdder is
    signal A_int, B_int : UNSIGNED(3 downto 0);  -- Internal unsigned versions of A and B
    signal TempSum      : UNSIGNED(4 downto 0);  -- Internal signal for the sum
    signal Cin_int      : UNSIGNED(0 downto 0);  -- Internal signal for Cin converted to UNSIGNED
begin
    -- Convert STD_LOGIC_VECTOR to UNSIGNED
    A_int <= UNSIGNED(A);
    B_int <= UNSIGNED(B);

    -- Convert Cin (STD_LOGIC) to UNSIGNED(1) by directly assigning it to the signal
    Cin_int <= (others => Cin);  -- Set Cin_int to '1' or '0' based on Cin value

    -- Perform addition
    TempSum <= ('0' & A_int) + ('0' & B_int) + Cin_int; -- Now Cin_int is properly added as UNSIGNED

    -- Assign outputs
    Sum  <= STD_LOGIC_VECTOR(TempSum(3 downto 0));  -- Convert back to STD_LOGIC_VECTOR
    Cout <= TempSum(4);                             -- Carry out
end Behavioral;
