library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EqualityComparator4Bit_tb is
end EqualityComparator4Bit_tb;

architecture Behavioral of EqualityComparator4Bit_tb is
    -- Component declaration
    component EqualityComparator4Bit
        Port (
            A     : in  STD_LOGIC_VECTOR(3 downto 0);
            B     : in  STD_LOGIC_VECTOR(3 downto 0);
            Equal : out STD_LOGIC
        );
    end component;

    -- Signals for testbench
    signal A     : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal B     : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal Equal : STD_LOGIC;

begin
    -- Instantiate the comparator
    uut: EqualityComparator4Bit
        Port map (
            A     => A,
            B     => B,
            Equal => Equal
        );

    -- Test process
    process
    begin
        A <= "0001"; B <= "0001"; wait for 10 ns;  -- Equal inputs
        A <= "0010"; B <= "0011"; wait for 10 ns;  -- Unequal inputs
        A <= "1010"; B <= "1010"; wait for 10 ns;  -- Equal inputs
        A <= "1111"; B <= "0000"; wait for 10 ns;  -- Unequal inputs
        wait;  -- Stop simulation
    end process;

end Behavioral;
