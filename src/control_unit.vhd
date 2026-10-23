library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Decodes opcode = INSTR[11:8]. Any opcode outside Set 9 (incl. 0000) is a NOP.
entity control_unit is
    Port ( INSTR    : in  STD_LOGIC_VECTOR (11 downto 0);
           Z        : in  STD_LOGIC;                      -- current Z flag (used by JZ)
           ALU_OP   : out STD_LOGIC_VECTOR (1 downto 0);
           ACC_EN   : out STD_LOGIC;                      -- write ACC
           Z_EN     : out STD_LOGIC;                      -- update Z flag
           PC_LOAD  : out STD_LOGIC);                     -- 1 = jump (JZ taken)
end control_unit;

architecture Behavioral of control_unit is
    signal opcode : STD_LOGIC_VECTOR (3 downto 0);
begin
    opcode <= INSTR(11 downto 8);

    process (opcode, Z)
    begin
        ALU_OP  <= "00";
        ACC_EN  <= '0';
        Z_EN    <= '0';
        PC_LOAD <= '0';
        case opcode is
            when "0001" => ALU_OP <= "00"; ACC_EN <= '1'; Z_EN <= '1';   -- LDI
            when "0010" => ALU_OP <= "01"; ACC_EN <= '1'; Z_EN <= '1';   -- ADD
            when "0111" => ALU_OP <= "10"; ACC_EN <= '1'; Z_EN <= '1';   -- NOT
            when "1000" => ALU_OP <= "11"; ACC_EN <= '1'; Z_EN <= '1';   -- SHL
            when "1100" => PC_LOAD <= Z;                                 -- JZ
            when others => null;                                         -- NOP
        end case;
    end process;
end Behavioral;
