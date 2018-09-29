library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity aux_ecc2 is
  port (
    Clock      : in  std_logic;
    ClockEnable: in  boolean;
    DataIn     : in  std_logic_vector(1 downto 0);
    DataOut    : out std_logic_vector(1 downto 0);
    SendECC    : in  boolean
  );
end aux_ecc2;

architecture Behavioral of aux_ecc2 is
  signal reg: std_logic_vector(7 downto 0);
begin

  process(Clock, ClockEnable)
    variable feedback1, feedback2: std_logic;
    variable reg_temp: std_logic_vector(7 downto 0);
  begin
    if rising_edge(Clock) and ClockEnable then
      if SendECC then
        reg(7 downto 2) <= reg(5 downto 0);
        reg(1 downto 0) <= "00";
        DataOut         <= reg(6) & reg(7);
      else
        feedback1            := reg(7) xor DataIn(0);
        reg_temp(7)          := reg(6) xor feedback1;
        reg_temp(6)          := reg(5) xor feedback1;
        reg_temp(5 downto 1) := reg(4 downto 0);
        reg_temp(0)          := feedback1;

        feedback2       := reg_temp(7) xor DataIn(1);
        reg(7)          <= reg_temp(6) xor feedback2;
        reg(6)          <= reg_temp(5) xor feedback2;
        reg(5 downto 1) <= reg_temp(4 downto 0);
        reg(0)          <= feedback2;
        DataOut         <= DataIn;
      end if;
    end if;
  end process;

end Behavioral;