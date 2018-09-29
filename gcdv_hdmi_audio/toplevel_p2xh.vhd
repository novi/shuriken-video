----------------------------------------------------------------------------------
-- GCVideo DVI HDL Version 1.0
-- Copyright (C) 2014, Ingo Korb <ingo@akana.de>
-- All rights reserved.
--
-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions are met:
--
-- 1. Redistributions of source code must retain the above copyright notice,
--    this list of conditions and the following disclaimer.
-- 2. Redistributions in binary form must reproduce the above copyright notice,
--    this list of conditions and the following disclaimer in the documentation
--    and/or other materials provided with the distribution.
--
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
-- IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
-- ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
-- LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
-- SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
-- INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
-- CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-- ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
-- THE POSSIBILITY OF SUCH DAMAGE.
--
-- toplevel_p2xh.vhd: top level module for the Pluto IIx HDMI board
--
-- Modified on:     7/4/2015
-- Targeted device: FPGA xc3S50a-4vq100
-- Author:          Steven Taffs (code port of work by Ingo Korb to xc3S50a target)
-- Description:     Modified code to run on shuriken video board.
--
-- Modified on:     24/6/2015
-- Description:     added SPDIF vhdl code from main source code branch

-- Modified on:     23/8/2015
-- Description:     added enhanced dvi support from main source code branch

----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

use work.Component_Defs.all;
use work.video_defs.all;

entity toplevel_p2xh is
  port (
    -- clocks
    VClockN  : in  std_logic;
    
    -- gamecube video signals
    VData       : in  std_logic_vector(7 downto 0);
    CSel        : in  std_logic; -- usually named ClkSel, but it's really a color select
	 CableDetect : out std_logic;
	 
	 -- audio in
	 I2S_LRClock : in std_logic; 
	 I2S_Data    : in std_logic; 
	 I2S_BClock  : in std_logic;

    -- audio out
    SPDIF_Out: out   std_logic;

    -- video out
    DVI_Clock: out   std_logic_vector(1 downto 0);
    DVI_Red  : out   std_logic_vector(1 downto 0);
    DVI_Green: out   std_logic_vector(1 downto 0);
    DVI_Blue : out   std_logic_vector(1 downto 0)
  );
end toplevel_p2xh;

architecture Behavioral of toplevel_p2xh is
  -- clocks
  signal Clock54M     : std_logic;
  signal DVIClockP    : std_logic;
  signal DVIClockN    : std_logic;
  signal ClockAudio   : std_logic;

  -- video pipeline signals
  signal video_422       : VideoY422;
  signal video_444       : VideoYCbCr;
  signal video_444_rb    : VideoYCbCr; -- reblanked
  signal video_rgb       : VideoRGB;

  signal video_out       : VideoRGB;

  signal pixel_clk_en    : boolean;
  signal pixel_clk_en_27 : boolean; -- used for DVI output, automatically results in pixel-doubling for 15k modes

  -- output disable logic
  signal prev_30khz      : boolean;
  signal prev_pal        : boolean;
  signal prev_progressive: boolean;
  signal prev_vsync      : boolean;
  signal disable_output  : natural range 0 to 3; -- number of VSyncs to disable

  -- internal 24 bit VGA signals
  signal VGA_Red  : std_logic_vector(7 downto 0);
  signal VGA_Green: std_logic_vector(7 downto 0);
  signal VGA_Blue : std_logic_vector(7 downto 0);
  signal VGA_HSync: std_logic;
  signal VGA_VSync: std_logic;
  signal VGA_Blank: std_logic;

  -- encoded DVI signals  
  signal red_enc     : std_logic;
  signal green_enc   : std_logic;
  signal blue_enc    : std_logic;
  signal clock_enc   : std_logic;
  
  -- audio
  signal audio: AudioData;

  -- misc
  signal clock_locked     : std_logic;
  signal obuf_oe          : std_logic;

begin

  -- static outputs
  CableDetect <= '1'; -- pull up to signal digital port in use
  
  -- DVI output
  Inst_DVI: dvid GENERIC MAP (
    Invert_Red   => true,
    Invert_Green => true,
    Invert_Blue  => true,
	 Invert_Clock => true
  ) PORT MAP (
    clk           => DVIClockP,
    clk_n         => DVIClockN,
    clk_pixel     => Clock54M,
    clk_pixel_en  => pixel_clk_en_27,
    red_p         => VGA_Red,
    green_p       => VGA_Green,
    blue_p        => VGA_Blue,
    blank         => VGA_Blank,
    hsync         => VGA_HSync,
    vsync         => VGA_VSync,
    IsProgressive => video_out.IsProgressive,
    IsPAL         => video_out.IsPAL,
    Is30kHz       => video_out.Is30kHz,
    Audio         => audio,
    -- outputs
    red_s        => red_enc,
    green_s      => green_enc,
    blue_s       => blue_enc,
    clock_s      => clock_enc
  );
  
  OBUFDS_red   : OBUFTDS port map ( O => DVI_Red(0),   OB => DVI_Red(1),   I => red_enc,   T => obuf_oe);
  OBUFDS_green : OBUFTDS port map ( O => DVI_Green(0), OB => DVI_Green(1), I => green_enc, T => obuf_oe);
  OBUFDS_blue  : OBUFTDS port map ( O => DVI_Blue(0),  OB => DVI_Blue(1),  I => blue_enc,  T => obuf_oe);
  OBUFDS_clock : OBUFTDS port map ( O => DVI_Clock(0), OB => DVI_Clock(1), I => clock_enc, T => obuf_oe);
  
  obuf_oe <= '1' when disable_output /= 0 else '0';

  -- DVI clock generator
  Inst_ClockGen: ClockGen
    PORT MAP (
      ClockIn       => VClockN,
      Reset         => '0',
      Clock54M      => Clock54M,
		ClockAudio    => ClockAudio,
      DVIClockP     => DVIClockP,
      DVIClockN     => DVIClockN,
      Locked        => clock_locked
    );
	 
  -- audio module
  Inst_Audio: Audio_SPDIF
    PORT MAP (
      Clock       => ClockAudio,
      I2S_BClock  => I2S_BClock,
      I2S_LRClock => I2S_LRClock,
      I2S_Data    => I2S_Data,
      SPDIF_Out   => SPDIF_Out,
		Audio       => audio
    );

  -- read gamecube video data
  Inst_GCVideo: GCDV_Decoder
    PORT MAP (
      VClockI            => Clock54M,
      VData              => VData,
      CSel               => CSel,

      PixelClockEnable   => pixel_clk_en,
      Video              => video_422
    );
	 
  -- interpolate 4:2:2 to 4:4:4
  Inst_422_to_444: Convert_422_to_444
    PORT MAP (
      PixelClock       => Clock54M,
      PixelClockEnable => pixel_clk_en,

      VideoIn          => video_422,
      VideoOut         => video_444
    );

  -- regenerate blanking signal
  Inst_Reblanking: Blanking_Regenerator_Fixed
    PORT MAP (
      PixelClock       => Clock54M,
      PixelClockEnable => pixel_clk_en,
      VideoIn          => video_444,
      VideoOut         => video_444_rb
    );

  -- convert YUV to RGB
  Inst_yuv_to_rgb: Convert_yuv_to_rgb
    PORT MAP (
      PixelClock         => Clock54M,
      PixelClockEnable   => pixel_clk_en,

      VideoIn            => video_444_rb,
      VideoOut           => video_rgb
    );	 

  -- create a fixed 27-MHz pixel clock
  process (Clock54M)
  begin
    if rising_edge(Clock54M) then
      if pixel_clk_en then
        pixel_clk_en_27 <= false; -- must be false because it's delayed one cycle
      else
        pixel_clk_en_27 <= not pixel_clk_en_27;
      end if;
    end if;
  end process;

  -- check for format changes to disable output for a short time
  -- avoids flickering and other issues on some displays
  process (Clock54M, pixel_clk_en)
  begin
    if rising_edge(Clock54M) and pixel_clk_en then
      prev_30khz       <= video_422.Is30kHz;
      prev_pal         <= video_422.IsPAL;
      prev_progressive <= video_422.IsProgressive;
      prev_vsync       <= video_422.VSync;
      
      if prev_30khz       /= video_422.Is30kHz or
         prev_pal         /= video_422.IsPAL   or
         prev_progressive /= video_422.IsProgressive then
        -- format changed, disable output for 3 frames or fields
        disable_output <= 3;
      elsif prev_vsync /= video_422.VSync and
            video_422.VSync               and
            disable_output /= 0 then
        disable_output <= disable_output - 1;
      end if;
    end if;
  end process;

  -- send video signals to output
  process (Clock54M, pixel_clk_en)
  begin
    if rising_edge(Clock54M) and pixel_clk_en then
      -- output sync signals
      if video_out.VSync then
        VGA_VSync <= '0';
      else
        VGA_VSync <= '1';
      end if;

      if video_out.HSync then
        VGA_HSync <= '0';
      else
        VGA_HSync <= '1';
      end if;

      -- output to VGA
      if video_out.Blanking then
        VGA_Red   <= (others => '0');
        VGA_Green <= (others => '0');
        VGA_Blue  <= (others => '0');
        VGA_Blank <= '1';
      else
        VGA_Red   <= std_logic_vector(video_out.PixelR);
        VGA_Green <= std_logic_vector(video_out.PixelG);
        VGA_Blue  <= std_logic_vector(video_out.PixelB);
        VGA_Blank <= '0';
      end if;
    end if;
  end process;
  
  -- select output signal
  video_out <= video_rgb;

end Behavioral;

