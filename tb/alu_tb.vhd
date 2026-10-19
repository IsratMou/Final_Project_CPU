library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_tb is
end alu_tb;

architecture sim of alu_tb is
    signal ACC, OPERAND, RESULT : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal ALU_OP : STD_LOGIC_VECTOR (1 downto 0) := "00";
    signal ZERO : STD_LOGIC;
begin
    uut: entity work.alu port map (ACC, OPERAND, ALU_OP, RESULT, ZERO);

    process
        procedure check(a, o : STD_LOGIC_VECTOR(7 downto 0); op : STD_LOGIC_VECTOR(1 downto 0);
                        exp : STD_LOGIC_VECTOR(7 downto 0); expz : STD_LOGIC; name : string) is
        begin
            ACC <= a; OPERAND <= o; ALU_OP <= op;
            wait for 10 ns;
            assert RESULT = exp and ZERO = expz report "FAIL: " & name severity error;
        end procedure;
    begin
        check(x"00", x"3C", "00", x"3C", '0', "LDI");
        check(x"00", x"00", "00", x"00", '1', "LDI zero");
        check(x"11", x"22", "01", x"33", '0', "ADD");
        check(x"FF", x"01", "01", x"00", '1', "ADD overflow -> 0, Z=1");
        check(x"FF", x"00", "10", x"00", '1', "NOT FF");
        check(x"55", x"00", "10", x"AA", '0', "NOT 55");
        check(x"11", x"00", "11", x"22", '0', "SHL");
        check(x"80", x"00", "11", x"00", '1', "SHL MSB lost, Z=1");
        report "ALU testbench finished" severity note;
        wait;
    end process;
end sim;
