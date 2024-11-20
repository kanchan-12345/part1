library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC
    );
end Top;

architecture Behavioral of Top is
    -- Component declarations
    component Processor is
        Port (
            clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            instr_addr : out STD_LOGIC_VECTOR(7 downto 0);
            instr : in STD_LOGIC_VECTOR(31 downto 0);
            data_addr : out STD_LOGIC_VECTOR(7 downto 0);
            data_in : out STD_LOGIC_VECTOR(7 downto 0);
            data_out : in STD_LOGIC_VECTOR(7 downto 0);
            data_wr : out STD_LOGIC
        );
    end component;

    component InstrMem is
        Port (
            clk : in STD_LOGIC;
            addr : in STD_LOGIC_VECTOR(7 downto 0);
            instr : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component DataMem is
        Port (
            clk : in STD_LOGIC;
            addr : in STD_LOGIC_VECTOR(7 downto 0);
            data_in : in STD_LOGIC_VECTOR(7 downto 0);
            data_out : out STD_LOGIC_VECTOR(7 downto 0);
            wr_en : in STD_LOGIC
        );
    end component;

    -- Internal signals
    signal instr_addr : STD_LOGIC_VECTOR(7 downto 0);
    signal instruction : STD_LOGIC_VECTOR(31 downto 0);
    signal data_addr : STD_LOGIC_VECTOR(7 downto 0);
    signal data_to_mem : STD_LOGIC_VECTOR(7 downto 0);
    signal data_from_mem : STD_LOGIC_VECTOR(7 downto 0);
    signal data_wr : STD_LOGIC;

begin
    -- Processor instantiation
    proc: Processor
        port map (
            clk => clk,
            reset => reset,
            instr_addr => instr_addr,
            instr => instruction,
            data_addr => data_addr,
            data_in => data_to_mem,
            data_out => data_from_mem,
            data_wr => data_wr
        );

    -- Instruction Memory instantiation
    imem: InstrMem
        port map (
            clk => clk,
            addr => instr_addr,
            instr => instruction
        );

    -- Data Memory instantiation
    dmem: DataMem
        port map (
            clk => clk,
            addr => data_addr,
            data_in => data_to_mem,
            data_out => data_from_mem,
            wr_en => data_wr
        );

end Behavioral;