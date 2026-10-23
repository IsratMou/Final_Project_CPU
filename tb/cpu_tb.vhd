library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Checks the Appendix B (Set 9) table: ACC, Z and next-PC after every rising edge.
entity cpu_tb is
end cpu_tb;

architecture sim of cpu_tb is
    signal CLK, RESET, Z : STD_LOGIC := '0';
    signal Q      : STD_LOGIC_VECTOR (7 downto 0);
    signal PC_OUT : STD_LOGIC_VECTOR (3 downto 0);
    signal done   : boolean := false;
    constant T : time := 10 ns;

    type slv8_arr is array (0 to 7) of STD_LOGIC_VECTOR (7 downto 0);
    type slv4_arr is array (0 to 7) of STD_LOGIC_VECTOR (3 downto 0);
    type sl_arr   is array (0 to 7) of STD_LOGIC;

    --                          reset  LDI    NOT    JZ(t)  ADD    SHL    JZ(nt) SHL
    constant EXP_ACC : slv8_arr := (x"00", x"FF", x"00", x"00", x"11", x"22", x"22", x"44");
    constant EXP_Z   : sl_arr   := ('1',   '0',   '1',   '1',   '0',   '0',   '0',   '0');
    constant EXP_PC  : slv4_arr := (x"0",  x"1",  x"2",  x"5",  x"6",  x"7",  x"8",  x"9");
begin
    uut: entity work.cpu_top port map (CLK, RESET, Q, Z, PC_OUT);

    clk_proc: process
    begin
        while not done loop
            CLK <= '0'; wait for T/2;
            CLK <= '1'; wait for T/2;
        end loop;
        wait;
    end process;

    stim: process
        variable errors : integer := 0;
    begin
        RESET <= '1';                              -- cycle 0: one rising edge with RESET
        for i in 0 to 7 loop
            wait until rising_edge(CLK);
            wait for 1 ns;                         -- let outputs settle
            if i = 0 then RESET <= '0'; end if;    -- release after the reset edge
            if Q /= EXP_ACC(i) or Z /= EXP_Z(i) or PC_OUT /= EXP_PC(i) then
                errors := errors + 1;
                report "FAIL at cycle " & integer'image(i) &
                       " ACC=" & integer'image(to_integer(unsigned(Q))) &
                       " Z=" & STD_LOGIC'image(Z) &
                       " PC=" & integer'image(to_integer(unsigned(PC_OUT))) severity error;
            else
                report "PASS cycle " & integer'image(i) &
                       " ACC=" & integer'image(to_integer(unsigned(Q))) &
                       " Z=" & STD_LOGIC'image(Z) &
                       " PC=" & integer'image(to_integer(unsigned(PC_OUT))) severity note;
            end if;
        end loop;
        if errors = 0 then
            report "ALL 8 CYCLES MATCH APPENDIX B (SET 9)" severity note;
        else
            report integer'image(errors) & " MISMATCH(ES)" severity failure;
        end if;
        done <= true;
        wait;
    end process;
end sim;
