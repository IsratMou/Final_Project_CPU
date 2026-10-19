library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_g is
    Port ( A     : in  STD_LOGIC;
           B     : in  STD_LOGIC;
           Cin   : in  STD_LOGIC;
           Sum   : out STD_LOGIC;
           Cout  : out STD_LOGIC);
end full_adder_g;
architecture Structural of full_adder_g is

    -- Component declaration for Half Adder
    component half_adder
    Port ( A     : in  STD_LOGIC;
           B     : in  STD_LOGIC;
           Sum   : out STD_LOGIC;
           Carry : out STD_LOGIC);
    end component;
    -- Component declaration for OR gate
    component or_g
    Port ( A     : in  STD_LOGIC;
           B     : in  STD_LOGIC;
           Y     : out STD_LOGIC);
    end component;

    signal ha1_sum   : STD_LOGIC;
    signal ha1_carry : STD_LOGIC;
    signal ha2_carry : STD_LOGIC;

begin

    HA1: half_adder port map (
        A     => A,
        B     => B,
        Sum   => ha1_sum,
        Carry => ha1_carry
    );

    HA2: half_adder port map (
        A     => ha1_sum,
        B     => Cin,
        Sum   => Sum,
        Carry => ha2_carry
    );

    OR_Cout: or_g port map (
        A     => ha1_carry,
        B     => ha2_carry,
        Y     => Cout
    );

end Structural;
