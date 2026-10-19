library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_8bit_g is
    Port ( A     : in  STD_LOGIC_VECTOR (7 downto 0);
           B     : in  STD_LOGIC_VECTOR (7 downto 0);
           Cin   : in  STD_LOGIC;
           Sum   : out STD_LOGIC_VECTOR (7 downto 0);
           Cout  : out STD_LOGIC);
end full_adder_8bit_g;

architecture Structural of full_adder_8bit_g is
-- Component declaration for 1-bit full_adder_g
    component full_adder_g
    Port ( A     : in  STD_LOGIC;
           B     : in  STD_LOGIC;
           Cin   : in  STD_LOGIC;
           Sum   : out STD_LOGIC;
           Cout  : out STD_LOGIC);
    end component;

    -- Internal carry vector for 8-bit chain
    signal carry_chain : STD_LOGIC_VECTOR (8 downto 0);
begin

    -- Assign initial Cin to the start of the carry chain
    carry_chain(0) <= Cin;
    
    -- Assign final carry-out from the end of the chain
    Cout <= carry_chain(8);
	 -- Generate loop for 8-bit ripple carry adder
    GEN_ADDERS: for i in 0 to 7 generate
        FA_i: full_adder_g
        PORT MAP (
            A     => A(i),
            B     => B(i),
            Cin   => carry_chain(i),
            Sum   => Sum(i),
            Cout  => carry_chain(i+1)
        );
    end generate;

end Structural;