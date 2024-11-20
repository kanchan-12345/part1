library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstrMem is
    Port (
        clk : in STD_LOGIC;
        addr : in STD_LOGIC_VECTOR(7 downto 0);
        instr : out STD_LOGIC_VECTOR(31 downto 0)
    );
end InstrMem;

architecture Behavioral of InstrMem is
    type mem_type is array (0 to 255) of STD_LOGIC_VECTOR(31 downto 0);
    signal memory : mem_type := (
        -- Example program
        0 => "00000000000000110000001000000000",  -- ADD R3, R2
        1 => "00100000000001000000001100000000",  -- SUB R4, R3
        2 => "01000000000001010000010000000000",  -- AND R5, R4
        3 => "01100000000001100000010100000000",  -- OR  R6, R5
        4 => "10000000000001110000011000000000",  -- XOR R7, R6
        5 => "10100000000010000000011100000000",  -- NOR R8, R7
        others => (others => '0')
    );
begin
    process(clk)
    begin
        if rising_edge(clk) then
            instr <= memory(to_integer(unsigned(addr)));
        end if;
    end process;
end Behavioral;