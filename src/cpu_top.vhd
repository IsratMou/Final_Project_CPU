library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cpu_top is
    Port ( CLK    : in  STD_LOGIC;
           RESET  : in  STD_LOGIC;
           Q      : out STD_LOGIC_VECTOR (7 downto 0);   -- ACC
           Z      : out STD_LOGIC;
           PC_OUT : out STD_LOGIC_VECTOR (3 downto 0));
end cpu_top;

architecture Structural of cpu_top is
    component pc_reg
        Port ( CLK, RESET, LOAD : in STD_LOGIC;
               LOAD_ADDR : in STD_LOGIC_VECTOR (3 downto 0);
               PC : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    component program_rom
        Port ( PC : in STD_LOGIC_VECTOR (3 downto 0);
               INSTR : out STD_LOGIC_VECTOR (11 downto 0));
    end component;
    component control_unit
        Port ( INSTR : in STD_LOGIC_VECTOR (11 downto 0);
               Z : in STD_LOGIC;
               ALU_OP : out STD_LOGIC_VECTOR (1 downto 0);
               ACC_EN, Z_EN, PC_LOAD : out STD_LOGIC);
    end component;
    component alu
        Port ( ACC, OPERAND : in STD_LOGIC_VECTOR (7 downto 0);
               ALU_OP : in STD_LOGIC_VECTOR (1 downto 0);
               RESULT : out STD_LOGIC_VECTOR (7 downto 0);
               ZERO : out STD_LOGIC);
    end component;
    component acc_reg
        Port ( CLK, RESET, EN : in STD_LOGIC;
               D : in STD_LOGIC_VECTOR (7 downto 0);
               Q : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    component z_flag
        Port ( CLK, RESET, EN, D : in STD_LOGIC;
               Z : out STD_LOGIC);
    end component;

    signal pc_s      : STD_LOGIC_VECTOR (3 downto 0);
    signal instr_s   : STD_LOGIC_VECTOR (11 downto 0);
    signal acc_s     : STD_LOGIC_VECTOR (7 downto 0);
    signal alu_res_s : STD_LOGIC_VECTOR (7 downto 0);
    signal alu_op_s  : STD_LOGIC_VECTOR (1 downto 0);
    signal alu_zero_s, z_s : STD_LOGIC;
    signal acc_en_s, z_en_s, pc_load_s : STD_LOGIC;
begin
    U_PC  : pc_reg       port map (CLK, RESET, pc_load_s, instr_s(3 downto 0), pc_s);
    U_ROM : program_rom  port map (pc_s, instr_s);
    U_CU  : control_unit port map (instr_s, z_s, alu_op_s, acc_en_s, z_en_s, pc_load_s);
    U_ALU : alu          port map (acc_s, instr_s(7 downto 0), alu_op_s, alu_res_s, alu_zero_s);
    U_ACC : acc_reg      port map (CLK, RESET, acc_en_s, alu_res_s, acc_s);
    U_Z   : z_flag       port map (CLK, RESET, z_en_s, alu_zero_s, z_s);

    Q      <= acc_s;
    Z      <= z_s;
    PC_OUT <= pc_s;
end Structural;
