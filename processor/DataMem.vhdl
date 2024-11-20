library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DataMem is
    Port (
        clk : in STD_LOGIC;
        addr : in STD_LOGIC_VECTOR(7 downto 0);
        data_in : in STD_LOGIC_VECTOR(7 downto 0);
        data_out : out STD_LOGIC_VECTOR(7 downto 0);
        wr_en : in STD_LOGIC
    );
end DataMem;

architecture Behavioral of DataMem is
    type mem_type is array (0 to 255) of STD_LOGIC_VECTOR(7 downto 0);
    signal memory : mem_type := (others => (others => '0'));
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if wr_en = '1' then
                memory(to_integer(unsigned(addr))) <= data_in;
            end if;
            data_out <= memory(to_integer(unsigned(addr)));
        end if;
    end process;
end Behavioral;