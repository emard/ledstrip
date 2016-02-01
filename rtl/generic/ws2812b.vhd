library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ws2812b is
  generic
  (
    clk_Hz: integer := 25000000; -- Hz
    striplen: integer := 3; -- number of LED pixels in the strip
    -- timing setup by datasheet (unequal 0/1)
    --  t0h 350+-150 ns, t0l 800+-150 ns  ----_________
    --  t1h 700+-150 ns, t1l 600+-150 ns  --------_____
    --  tres > 50 us
    -- simplified timing within tolerance (equal 0/1)
    t0h: integer := 350; -- ns
    t1h: integer := 700; -- ns
    tbit: integer := 1250; -- ns
    tres: integer := 51; -- us
    bpp: integer := 24 -- bits per LED pixel (don't touch)
  );
  port
  (
    clk: in STD_Logic;
    dout: out  STD_LOGIC;
    ctrl: in std_logic_vector(2 downto 0)
  );
end ws2812b;

architecture Behavioral of ws2812b is

  -- constants to convert nanoseconds, microseconds
  constant ns: integer := 1000000000;
  constant us: integer := 1000000;

  -- function to apply same color to the whole strip
  --impure function all_color(color: std_logic_vector)
  --  return std_logic_vector is
  --    variable i: integer := 0;
  --    variable allbits: std_logic_vector(bpp*striplen-1 downto 0) := (others => '0');
  --begin
  --  while (i < striplen) loop
  --    allbits := allbits(allbits'length-color'length-1 downto 0) & color;
  --    i := i + 1;
  --  end loop;
  --  return allbits;
  --end function;

  constant sequence_len: integer := 8;
  type T_sequence_rom is array(0 to sequence_len*striplen*(bpp/8)-1) of std_logic_vector(7 downto 0);
  constant sequence_rom: T_sequence_rom := 
  (
    -- blue LED is somewhat weaker when running at 3.3V
    -- so we power it with FF while others with 55
    -- except white, where all must be FF to appear white
    x"00",x"00",x"00", x"00",x"00",x"00", x"00",x"00",x"00", -- 0: black
    x"00",x"55",x"00", x"00",x"55",x"00", x"00",x"55",x"00", -- 1: red
    x"55",x"00",x"00", x"55",x"00",x"00", x"55",x"00",x"00", -- 2: green
    x"55",x"55",x"00", x"55",x"55",x"00", x"55",x"55",x"00", -- 3: yellow
    x"00",x"00",x"FF", x"00",x"00",x"FF", x"00",x"00",x"FF", -- 4: blue
    x"00",x"55",x"FF", x"00",x"55",x"FF", x"00",x"55",x"FF", -- 5: magenta
    x"55",x"00",x"FF", x"55",x"00",x"FF", x"55",x"00",x"FF", -- 6: cyan
    x"FF",x"FF",x"FF", x"FF",x"FF",x"FF", x"FF",x"FF",x"FF", -- 7: white
    others => (others => '0')
  );

  signal rom_addr      : integer range 0 to sequence_len*striplen*(bpp/8)-1;
  signal count         : integer range 0 to clk_Hz*tres/us; -- protocol timer
  signal data          : std_logic_vector(7 downto 0);
  signal bit_count     : integer range 0 to bpp*striplen-1;
  signal byte_bit      : unsigned(2 downto 0);
  signal state         : integer range 0 to 2; -- protocol state
begin
  process(clk)
  begin
    if rising_edge(clk) then
      count <= count+1;
      if count = clk_Hz*t0h/ns then
        if byte_bit = "000" then
          data <= sequence_rom(rom_addr);
          rom_addr <= rom_addr+1;
        end if;
        -- state = 0, dout = 1
        -- prepare to send bit
        state <= 1;  -- jump to send bit
      elsif count = clk_Hz*t1h/ns then
        -- state = 1, dout = bit
        -- sends the bit
        state <= 2; -- jump to shift or load
      elsif count = clk_Hz*tbit/ns then
        -- state = 2, dout = 0
        -- send finished, any more bits to send?
        if bit_count /= 0 then
          -- yes, shift data (new bit)
          data <= data(6 downto 0) & '0';
          bit_count <= bit_count - 1;
          byte_bit <= byte_bit+1;
          -- restart protocol
          count <= 0;
          state <= 0;
        end if;
      elsif count = clk_Hz*tres/us then
        -- state = 2, dout = 0
        -- long dout=0 resets the protocol
        -- set address from where to load new data
        rom_addr <= to_integer(unsigned(ctrl))*striplen*(bpp/8); -- start from n-th sequence
        bit_count <= bpp*striplen-1;
        byte_bit <= (others => '0');
        count <= 0;
        state <= 0;
      end if;
    end if;
  end process;

  dout <= '1'    when state = 0
    else data(7) when state = 1
    else '0';

end Behavioral;
