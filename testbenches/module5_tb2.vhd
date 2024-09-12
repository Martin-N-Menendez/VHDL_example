library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity module5_tb2 is
end module5_tb2;

architecture Behavioral of module5_tb2 is
    signal A, B : STD_LOGIC_VECTOR(3 downto 0);
    signal SUM : STD_LOGIC_VECTOR(3 downto 0);
begin
    uut: entity module5
        port map (
            A => A,
            B => B,
            SUM => SUM
        );
    
    process
    begin
        A <= "0111"; B <= "1000"; wait for 10 ns;  -- A = 7, B = 8
        A <= "1001"; B <= "1010"; wait for 10 ns;  -- A = 9, B = 10
        A <= "1011"; B <= "1100"; wait for 10 ns;  -- A = 11, B = 12
        wait;
    end process;
end Behavioral;
