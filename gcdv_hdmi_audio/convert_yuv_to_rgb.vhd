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
-- convert_yuv_to_rgb: YCbCr 444 to RGB converter, inferred multiplier version
--
-- Modified on:     7/4/2015
-- Targeted device: FPGA xc3S50a-4vq100
-- Author:          Steven Taffs (code port of work by Ingo Korb to xc3S50a target)
-- Description:     Modified code to run on shuriken video board.

-- Modified on:     23/8/2015
-- Description:     added non-processed signals from main source code branch
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

use work.component_defs.all;
use work.video_defs.all;

entity convert_yuv_to_rgb is
  port (
    PixelClock      : in  std_logic;
    PixelClockEnable: in  boolean;

    -- input video
    VideoIn         : in  VideoYCbCr;

    -- output video
    VideoOut        : out VideoRGB
  );
end convert_yuv_to_rgb;

architecture Behavioral of convert_yuv_to_rgb is

  -- delay in (enabled) clock cycles for untouched signals
  constant Delayticks: Natural := 4;

  signal ystore: signed(18 downto 0) := (others => '0');
  signal rtemp : signed(18 downto 0) := (others => '0'); -- Cr for R
  signal gtempr: signed(18 downto 0) := (others => '0'); -- Cr for G
  signal gtempb: signed(18 downto 0) := (others => '0'); -- Cb for G
  signal btemp : signed(18 downto 0) := (others => '0'); -- Cb for B

  -- FIXME: Do a careful value analysis to reduce the size of some of these registers?
  signal rsum    : signed(18 downto 0) := (others => '0'); -- (Y + rtemp) / 256
  signal gsum    : signed(18 downto 0) := (others => '0'); -- (Y - gtemp1 - gtemp2) / 256
  signal bsum    : signed(18 downto 0) := (others => '0'); -- (Y + btemp) / 256
  signal gsumtemp: signed(18 downto 0) := (others => '0');

  signal yscale : signed(10 downto 0) := to_signed(298, 11);
  signal yshift : signed( 5 downto 0) := to_signed( 16,  6);
  signal rscale : signed(10 downto 0) := to_signed(409, 11);
  signal grscale: signed(10 downto 0) := to_signed(208, 11);
  signal gbscale: signed(10 downto 0) := to_signed(100, 11);
  signal bscale : signed(10 downto 0) := to_signed(517, 11);
  
  signal rout   : unsigned(7 downto 0);
  signal bout   : unsigned(7 downto 0);
  
  -- 8 bit unsigned to 8 bit signed, removing the 0x80 offset
  function mksigned_offset(a: unsigned)
    return signed is
  begin
    return signed(not a(7) & a(6 downto 0));
  end function;
  
  -- 8 bit unsigned to 9 bit signed, no modifications
  function mksigned(a: unsigned)
    return signed is
  begin
    return signed("0" & a);
  end function;

  -- clip value to 8 bit range
  function clip(v: signed)
    return unsigned is
  begin
    if v < 0 then
      return x"00";
    elsif v > 255 then
      return x"ff";
    else
      return resize(unsigned(v), 8);
    end if;
  end function;

begin
  
  -- capture and interpolate colors
  process (PixelClock, PixelClockEnable)
    variable cr_s: signed(7 downto 0);
    variable cb_s: signed(7 downto 0);
  begin
    if rising_edge(PixelClock) and PixelClockEnable then
    
      -- pipeline stage 1: convert inputs to signed values and calculate the scaled color values
      cr_s := mksigned_offset(VideoIn.PixelCr);
      cb_s := mksigned_offset(VideoIn.PixelCb);

        -- FIXME: Expression from S6, not optimal for S3A architecture
      ystore <= resize((mksigned(VideoIn.PixelY) - yshift) * yscale, 19)
              + to_signed(128, 19); -- add 0.5 to get a rounded result
      rtemp  <= rscale  * cr_s;
      gtempr <= grscale * cr_s;
      gtempb <= gbscale * cb_s;
      btemp  <= bscale  * cb_s;
      
      -- pipeline stage 2: add/subtract
      rsum     <= (ystore + rtemp) / 256;
      gsumtemp <= ystore - gtempr;
      bsum     <= (ystore + btemp) / 256;

      -- pipeline stage 3: clipping r/b, subtract g
      rout <= clip(rsum);
      gsum <= (gsumtemp - gtempb) / 256;
      bout <= clip(bsum);
      
      -- pipeline stage 4: clip g, output
      VideoOut.PixelR <= rout;
      VideoOut.PixelG <= clip(gsum);
      VideoOut.PixelB <= bout;
    end if;
  end process;

  -- generate delayed signals
  Inst_HSyncDelay: delayline_bool
    generic map (
      Delayticks => Delayticks
    )
    port map (
      Clock       => PixelClock,
      ClockEnable => PixelClockEnable,
      Input       => VideoIn.HSync,
      Output      => VideoOut.HSync
    );

  Inst_VSyncDelay: delayline_bool
    generic map (
      Delayticks => Delayticks
    )
    port map (
      Clock       => PixelClock,
      ClockEnable => PixelClockEnable,
      Input       => VideoIn.VSync,
      Output      => VideoOut.VSync
    );
	 
  Inst_CSyncDelay: delayline_bool
    generic map (
      Delayticks => Delayticks
    )
    port map (
      Clock       => PixelClock,
      ClockEnable => PixelClockEnable,
      Input       => VideoIn.CSync,
      Output      => VideoOut.CSync
    ); 

  Inst_BlankingDelay: delayline_bool
    generic map (
      Delayticks => Delayticks
    )
    port map (
      Clock       => PixelClock,
      ClockEnable => PixelClockEnable,
      Input       => VideoIn.Blanking,
      Output      => VideoOut.Blanking
    );
	 
  Inst_FieldDelay: delayline_bool
    generic map (
      Delayticks => Delayticks
    )
    port map (
      Clock       => PixelClock,
      ClockEnable => PixelClockEnable,
      Input       => VideoIn.IsEvenField,
      Output      => VideoOut.IsEvenField
    );	 
	 
	-- copy non-delayed, non-processed signals
  VideoOut.IsProgressive <= VideoIn.IsProgressive;
  VideoOut.IsPAL         <= VideoIn.IsPAL;
  VideoOut.Is30kHz       <= VideoIn.Is30kHz; 

end Behavioral;

