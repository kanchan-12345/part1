library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Processor is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        
        -- Instruction Memory Interface
        instr_addr : out STD_LOGIC_VECTOR (7 downto 0);
        instr : in STD_LOGIC_VECTOR (31 downto 0);
        
        -- Data Memory Interface
        data_addr : out STD_LOGIC_VECTOR (7 downto 0);
        data_in : out STD_LOGIC_VECTOR (7 downto 0);
        data_out : in STD_LOGIC_VECTOR (7 downto 0);
        data_wr : out STD_LOGIC
    );
end Processor;

architecture Behavioral of Processor is
    -- Components
    component ALU
        Port (
            A : in STD_LOGIC_VECTOR (7 downto 0);
            B : in STD_LOGIC_VECTOR (7 downto 0);
            sel : in STD_LOGIC_VECTOR (2 downto 0);
            Result : out STD_LOGIC_VECTOR (7 downto 0);
            Zero : out STD_LOGIC
        );
    end component;

    -- Processor Signals
    signal PC : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal Inst_Reg : STD_LOGIC_VECTOR (31 downto 0);
    signal Reg_A, Reg_B : STD_LOGIC_VECTOR (7 downto 0);
    signal ALU_Res : STD_LOGIC_VECTOR (7 downto 0);
    signal ALU_Ctrl : STD_LOGIC_VECTOR (2 downto 0);
    signal Zero_Flag : STD_LOGIC;

begin
    -- Instruction Fetch
    instr_addr <= PC;
    Inst_Reg <= instr;

    -- Instruction Decode
    process(Inst_Reg)
    begin
        case Inst_Reg(31 downto 29) is
            when "000" => ALU_Ctrl <= "000"; -- ADD
            when "001" => ALU_Ctrl <= "001"; -- SUB
            when "010" => ALU_Ctrl <= "010"; -- AND
            when "011" => ALU_Ctrl <= "011"; -- OR
            when "100" => ALU_Ctrl <= "100"; -- XOR
            when "101" => ALU_Ctrl <= "101"; -- NOR
            when others => ALU_Ctrl <= "111"; -- Invalid
        end case;

        Reg_A <= Inst_Reg(23 downto 16);
        Reg_B <= Inst_Reg(15 downto 8);
    end process;

    -- ALU Execution
    ALU_Unit: ALU
        port map (
            A => Reg_A,
            B => Reg_B,
            sel => ALU_Ctrl,
            Result => ALU_Res,
            Zero => Zero_Flag
        );

    -- Memory Access
    data_addr <= ALU_Res(7 downto 0);
    data_in <= Reg_B;
    data_wr <= '1' when ALU_Ctrl = "000" else '0'; -- Write for ADD only

    -- Program Counter Update
    process(clk, reset)
    begin
        if reset = '1' then
            PC <= (others => '0');
        elsif rising_edge(clk) then
            PC <= std_logic_vector(unsigned(PC) + 1);
        end if;
    end process;

end Behavioral;