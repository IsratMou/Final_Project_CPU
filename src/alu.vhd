library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Combinational ALU for Set 9: LDI, ADD, NOT, SHL  (JZ needs no ALU operation).
-- ADD reuses the gate-level 8-bit ripple-carry adder from the earlier labs.
entity alu is
    Port ( ACC     : in  STD_LOGIC_VECTOR (7 downto 0);
           OPERAND : in  STD_LOGIC_VECTOR (7 downto 0);
           ALU_OP  : in  STD_LOGIC_VECTOR (1 downto 0);  -- 00 LDI, 01 ADD, 10 NOT, 11 SHL
           RESULT  : out STD_LOGIC_VECTOR (7 downto 0);
           ZERO    : out STD_LOGIC);
end alu;

architecture Structural of alu is
    component full_adder_8bit_g
        Port ( A    : in  STD_LOGIC_VECTOR (7 downto 0);
               B    : in  STD_LOGIC_VECTOR (7 downto 0);
               Cin  : in  STD_LOGIC;
               Sum  : out STD_LOGIC_VECTOR (7 downto 0);
               Cout : out STD_LOGIC);
    end component;

    signal add_res : STD_LOGIC_VECTOR (7 downto 0);
    signal res     : STD_LOGIC_VECTOR (7 downto 0);
begin
    -- ACC + OPERAND, carry-out discarded
    U_ADD: full_adder_8bit_g
        port map (A => ACC, B => OPERAND, Cin => '0', Sum => add_res, Cout => open);

    with ALU_OP select
        res <= OPERAND                  when "00",   -- LDI
               add_res                  when "01",   -- ADD
               not ACC                  when "10",   -- NOT
               ACC(6 downto 0) & '0'    when others; -- SHL

    RESULT <= res;
    ZERO   <= '1' when res = "00000000" else '0';
end Structural;
