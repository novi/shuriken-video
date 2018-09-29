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
-- component_defs.vhd: Component definitions
--
-- Modified on:     7/4/2015
-- Targeted device: FPGA xc3S50a-4vq100
-- Author:          Steven Taffs (code port of work by Ingo Korb to xc3S50a target)
-- Description:     Modified code to run on shuriken video board.

-- Modified on:     24/6/2015
-- Description:     Added audio components

-- Modified on:     23/8/2015
-- Description:     added dvi /audio components from main source code branch

----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;

use work.video_defs.all;

package component_defs is

  component delayline_unsigned is
    generic (
      Delayticks: Natural := 4;
      Width     : Natural := 1
    );
    port (
      Clock      : in  std_logic;
      ClockEnable: in  boolean;
      Input      : in  unsigned(Width - 1 downto 0);
      Output     : out unsigned(Width - 1 downto 0)
    );
  end component;

  component delayline_bool is
    generic (
      Delayticks: Natural := 4
    );
    port (
      Clock      : in  std_logic;
      ClockEnable: in  boolean;
      Input      : in  boolean;
      Output     : out boolean
    );
  end component;

  component gcdv_decoder is
    port (
      VClockI           : in  std_logic; -- 54 MHz clock, pin 2
      VData             : in  std_logic_vector(7 downto 0);
      CSel              : in  std_logic; -- "ClkSel" signal, pin 3

      -- output clock enables
      PixelClockEnable  : out boolean; -- CE relative to input clock for complete pixels

      -- video output
      Video             : out VideoY422
    );
  end component;

  component convert_422_to_444 is
    port (
      PixelClock      : in  std_logic;
      PixelClockEnable: in  boolean;
      
      -- input video
      VideoIn         : in  VideoY422;

      -- output video
      VideoOut        : out VideoYCbCr
    );
  end component;

  component convert_yuv_to_rgb is
    port (
      PixelClock      : in  std_logic;
      PixelClockEnable: in  boolean;

      -- input video
      VideoIn         : in  VideoYCbCr;

      -- output video
      VideoOut        : out VideoRGB
    );
  end component;

  component Blanking_Regenerator_Fixed is
    port (
      PixelClock      : in  std_logic;
      PixelClockEnable: in  boolean;
      VideoIn         : in  VideoYCbCr;
      VideoOut        : out VideoYCbCr
    );
  end component;

  COMPONENT dvid
  GENERIC (
    Invert_Red  : Boolean := false;
    Invert_Green: Boolean := false;
    Invert_Blue : Boolean := false;
	 Invert_Clock : Boolean := false
  );
  PORT(
      clk           : in  std_logic;
      clk_n         : in  std_logic;
      clk_pixel     : in  std_logic;
      clk_pixel_en  : in  boolean;
      red_p         : in  std_logic_vector(7 downto 0);
      green_p       : in  std_logic_vector(7 downto 0);
      blue_p        : in  std_logic_vector(7 downto 0);
      blank         : in  std_logic;
      hsync         : in  std_logic;
      vsync         : in  std_logic;
      IsProgressive : in  boolean;
      IsPAL         : in  boolean;
      Is30kHz       : in  boolean;
      Audio         : in  AudioData;
      red_s         : out std_logic;
      green_s       : out std_logic;
      blue_s        : out std_logic;
      clock_s       : out std_logic
    );
  END COMPONENT;

  component ClockGen is
    PORT (
      ClockIn   : in  std_logic;
      Reset     : in  std_logic;
      Clock54M  : out std_logic;
      ClockAudio: out std_logic;
      DVIClockP : out std_logic;
      DVIClockN : out std_logic;
      Locked    : out std_logic
    );
  end component;
  
  component audio_spdif is
    port (
      Clock      : in  std_logic; -- 3*54 MHz

      I2S_BClock : in  std_logic;
      I2S_LRClock: in  std_logic;
      I2S_Data   : in  std_logic;

      SPDIF_Out  : out std_logic;
      Audio      : out AudioData
    );
  end component;
  
  component Deglitcher is
    generic (
      SyncBits   : natural range 0 to 10;
      CompareBits: natural range 2 to 10
    );
    port (
      Clock      : in  std_logic;
      ClockEnable: in  boolean;
      Input      : in  std_logic;
      Output     : out std_logic
    );
  end component;
  
  component i2s_decoder is
    port (
      -- Internal clock
      Clock      : in  std_logic;
      ClockEnable: in  boolean;

      -- I2S signals
      I2S_BClock : in  std_logic;
      I2S_LRClock: in  std_logic;
      I2S_Data   : in  std_logic;

      -- sample output
      Left        : out signed(15 downto 0);
      Right       : out signed(15 downto 0);
      LeftEnable  : out boolean;
      RightEnable : out boolean
    );
  end component;
  
  component SPDIF_Encoder is
    port (
      Clock      : in  std_logic;
      ClockEnable: in  boolean;
      AudioLeft  : in  signed(15 downto 0);
      AudioRight : in  signed(15 downto 0);
      EnableLeft : in  boolean;
      SPDIF      : out std_logic
    );
  end component;

end component_defs;

package body component_defs is
end component_defs;
