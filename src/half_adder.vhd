library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity half_adder is
    Port ( A     : in  STD_LOGIC;
           B     : in  STD_LOGIC;
           Sum   : out STD_LOGIC;
           Carry : out STD_LOGIC);
end half_adder;

architecture Structural of half_adder is

    -- Component declaration for XOR gate (used for Sum)
    component xor_g
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Y : out STD_LOGIC);
    end component;

    -- Component declaration for AND gate (used for Carry)
    component and_g
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Y : out STD_LOGIC);
    end component;

begin

    -- Instantiate XOR gate for Sum
    HA_XOR: xor_g port map (
        A => A,
        B => B,
        Y => Sum
    );

    -- Instantiate AND gate for Carry
    HA_AND: and_g port map (
        A => A,
        B => B,
        Y => Carry
    );

end Structural;
