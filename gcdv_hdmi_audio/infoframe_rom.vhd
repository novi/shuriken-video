-- auto-generated from infoframe_rom.txt and template-ifrom.vhd on Mon Aug 24 23:53:03 2015
----------------------------------------------------------------------------------
-- GCVideo DVI HDL
-- Copyright (C) 2014-2015, Ingo Korb <ingo@akana.de>
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
-- infoframe_rom.vhd: ROM holding all neccessary info frames
--   (auto-generated from infoframes.txt)
--
----------------------------------------------------------------------------------

library IEEE;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity infoframe_rom is
  port (
    Clock      : in  std_logic;
    ClockEnable: in  boolean;

    Address    : in  unsigned(9 downto 0);
    Data       : out std_logic_vector(8 downto 0)
  );
end infoframe_rom;

architecture Behavioral of infoframe_rom is
begin

process(Clock, ClockEnable)
begin
  if rising_edge(Clock) and ClockEnable then
    case to_integer(Address) is
      ---- Audio Clock Regeneration (x4)
      when    0 => Data <= "000000000";
      when    1 => Data <= "000000000";
      when    2 => Data <= "000000000";
      when    3 => Data <= "000000000";
      when    4 => Data <= "000000001";
      when    5 => Data <= "000000000";
      when    6 => Data <= "000000000";
      when    7 => Data <= "000000000";
      when    8 => Data <= "010101010";
      when    9 => Data <= "101010100";
      when   10 => Data <= "101010100";
      when   11 => Data <= "010101010";
      when   12 => Data <= "000000000";
      when   13 => Data <= "000000000";
      when   14 => Data <= "101010100";
      when   15 => Data <= "010101010";
      when   16 => Data <= "000000000";
      when   17 => Data <= "000000000";
      when   18 => Data <= "000000000";
      when   19 => Data <= "000000000";
      when   20 => Data <= "000000000";
      when   21 => Data <= "101010100";
      when   22 => Data <= "010101010";
      when   23 => Data <= "000000000";
      when   24 => Data <= "000000000";
      when   25 => Data <= "000000000";
      when   26 => Data <= "000000000";
      when   27 => Data <= "000000000";
      when   32 => Data <= "000000000";
      when   33 => Data <= "000000000";
      when   34 => Data <= "000000000";
      when   35 => Data <= "000000000";
      when   36 => Data <= "000000001";
      when   37 => Data <= "000000000";
      when   38 => Data <= "000000000";
      when   39 => Data <= "000000000";
      when   40 => Data <= "010101010";
      when   41 => Data <= "101010100";
      when   42 => Data <= "101010100";
      when   43 => Data <= "010101010";
      when   44 => Data <= "000000000";
      when   45 => Data <= "000000000";
      when   46 => Data <= "101010100";
      when   47 => Data <= "010101010";
      when   48 => Data <= "000000000";
      when   49 => Data <= "000000000";
      when   50 => Data <= "000000000";
      when   51 => Data <= "000000000";
      when   52 => Data <= "000000000";
      when   53 => Data <= "101010100";
      when   54 => Data <= "010101010";
      when   55 => Data <= "000000000";
      when   56 => Data <= "000000000";
      when   57 => Data <= "000000000";
      when   58 => Data <= "000000000";
      when   59 => Data <= "000000000";
      when   64 => Data <= "000000000";
      when   65 => Data <= "000000000";
      when   66 => Data <= "000000000";
      when   67 => Data <= "000000000";
      when   68 => Data <= "000000001";
      when   69 => Data <= "000000000";
      when   70 => Data <= "000000000";
      when   71 => Data <= "000000000";
      when   72 => Data <= "010101010";
      when   73 => Data <= "101010100";
      when   74 => Data <= "101010100";
      when   75 => Data <= "010101010";
      when   76 => Data <= "000000000";
      when   77 => Data <= "000000000";
      when   78 => Data <= "101010100";
      when   79 => Data <= "010101010";
      when   80 => Data <= "000000000";
      when   81 => Data <= "000000000";
      when   82 => Data <= "000000000";
      when   83 => Data <= "000000000";
      when   84 => Data <= "000000000";
      when   85 => Data <= "101010100";
      when   86 => Data <= "010101010";
      when   87 => Data <= "000000000";
      when   88 => Data <= "000000000";
      when   89 => Data <= "000000000";
      when   90 => Data <= "000000000";
      when   91 => Data <= "000000000";
      when   96 => Data <= "000000000";
      when   97 => Data <= "000000000";
      when   98 => Data <= "000000000";
      when   99 => Data <= "000000000";
      when  100 => Data <= "000000001";
      when  101 => Data <= "000000000";
      when  102 => Data <= "000000000";
      when  103 => Data <= "000000000";
      when  104 => Data <= "010101010";
      when  105 => Data <= "101010100";
      when  106 => Data <= "101010100";
      when  107 => Data <= "010101010";
      when  108 => Data <= "000000000";
      when  109 => Data <= "000000000";
      when  110 => Data <= "101010100";
      when  111 => Data <= "010101010";
      when  112 => Data <= "000000000";
      when  113 => Data <= "000000000";
      when  114 => Data <= "000000000";
      when  115 => Data <= "000000000";
      when  116 => Data <= "000000000";
      when  117 => Data <= "101010100";
      when  118 => Data <= "010101010";
      when  119 => Data <= "000000000";
      when  120 => Data <= "000000000";
      when  121 => Data <= "000000000";
      when  122 => Data <= "000000000";
      when  123 => Data <= "000000000";

      ---- 480p full
      when  256 => Data <= "000000110";
      when  257 => Data <= "000000100";
      when  258 => Data <= "000000000";
      when  259 => Data <= "000000010";
      when  260 => Data <= "000000010";
      when  261 => Data <= "000000001";
      when  262 => Data <= "000000010";
      when  263 => Data <= "000000000";
      when  264 => Data <= "000000010";
      when  265 => Data <= "000000100";
      when  266 => Data <= "000000010";
      when  267 => Data <= "000000011";
      when  268 => Data <= "000000000";
      when  269 => Data <= "000000101";
      when  270 => Data <= "000000000";
      when  271 => Data <= "000000100";
      when  272 => Data <= "000000100";
      when  273 => Data <= "000000000";
      when  274 => Data <= "000000000";
      when  275 => Data <= "000000000";
      when  276 => Data <= "000000001";
      when  277 => Data <= "000000000";
      when  278 => Data <= "000000111";
      when  279 => Data <= "000000001";
      when  280 => Data <= "000000000";
      when  281 => Data <= "000000000";
      when  282 => Data <= "000000000";
      when  283 => Data <= "000000000";
      -- Audio
      when  288 => Data <= "000000000";
      when  289 => Data <= "000000000";
      when  290 => Data <= "000000110";
      when  291 => Data <= "000000010";
      when  292 => Data <= "000000010";
      when  293 => Data <= "000000000";
      when  294 => Data <= "000000001";
      when  295 => Data <= "000000000";
      when  296 => Data <= "000000000";
      when  297 => Data <= "000000000";
      when  298 => Data <= "000000000";
      when  299 => Data <= "000000001";
      when  300 => Data <= "000000001";
      when  301 => Data <= "000000000";
      when  302 => Data <= "000000000";
      when  303 => Data <= "000000000";
      when  304 => Data <= "000000000";
      when  305 => Data <= "000000000";
      when  306 => Data <= "000000000";
      when  307 => Data <= "000000000";
      when  308 => Data <= "000000000";
      when  309 => Data <= "000000001";
      when  310 => Data <= "000000000";
      when  311 => Data <= "000000001";
      when  312 => Data <= "000000000";
      when  313 => Data <= "000000000";
      when  314 => Data <= "000000000";
      when  315 => Data <= "000000000";
      -- SPD
      when  320 => Data <= "010000100";
      when  321 => Data <= "001100000";
      when  322 => Data <= "101000010";
      when  323 => Data <= "000000010";
      when  324 => Data <= "000000001";
      when  325 => Data <= "000000011";
      when  326 => Data <= "001000010";
      when  327 => Data <= "000000010";
      when  328 => Data <= "001100010";
      when  329 => Data <= "000110010";
      when  330 => Data <= "000100100";
      when  331 => Data <= "000101011";
      when  332 => Data <= "001101111";
      when  333 => Data <= "001101000";
      when  334 => Data <= "001010110";
      when  335 => Data <= "000101010";
      when  336 => Data <= "001000000";
      when  337 => Data <= "100011010";
      when  338 => Data <= "001110110";
      when  339 => Data <= "000101010";
      when  340 => Data <= "000000001";
      when  341 => Data <= "001111000";
      when  342 => Data <= "001010000";
      when  343 => Data <= "000101001";
      when  344 => Data <= "000011001";
      when  345 => Data <= "000111000";
      when  346 => Data <= "001010000";
      when  347 => Data <= "000101000";

      ---- 576p full
      when  384 => Data <= "000000000";
      when  385 => Data <= "000000110";
      when  386 => Data <= "000000110";
      when  387 => Data <= "000000000";
      when  388 => Data <= "000000010";
      when  389 => Data <= "000000001";
      when  390 => Data <= "000000010";
      when  391 => Data <= "000000000";
      when  392 => Data <= "000000010";
      when  393 => Data <= "000000100";
      when  394 => Data <= "000000010";
      when  395 => Data <= "000000011";
      when  396 => Data <= "000000000";
      when  397 => Data <= "000000101";
      when  398 => Data <= "000000000";
      when  399 => Data <= "000000100";
      when  400 => Data <= "000000010";
      when  401 => Data <= "000000000";
      when  402 => Data <= "000000010";
      when  403 => Data <= "000000000";
      when  404 => Data <= "000000001";
      when  405 => Data <= "000000000";
      when  406 => Data <= "000000111";
      when  407 => Data <= "000000001";
      when  408 => Data <= "000000000";
      when  409 => Data <= "000000000";
      when  410 => Data <= "000000000";
      when  411 => Data <= "000000000";
      -- Audio
      when  416 => Data <= "000000000";
      when  417 => Data <= "000000000";
      when  418 => Data <= "000000110";
      when  419 => Data <= "000000010";
      when  420 => Data <= "000000010";
      when  421 => Data <= "000000000";
      when  422 => Data <= "000000001";
      when  423 => Data <= "000000000";
      when  424 => Data <= "000000000";
      when  425 => Data <= "000000000";
      when  426 => Data <= "000000000";
      when  427 => Data <= "000000001";
      when  428 => Data <= "000000001";
      when  429 => Data <= "000000000";
      when  430 => Data <= "000000000";
      when  431 => Data <= "000000000";
      when  432 => Data <= "000000000";
      when  433 => Data <= "000000000";
      when  434 => Data <= "000000000";
      when  435 => Data <= "000000000";
      when  436 => Data <= "000000000";
      when  437 => Data <= "000000001";
      when  438 => Data <= "000000000";
      when  439 => Data <= "000000001";
      when  440 => Data <= "000000000";
      when  441 => Data <= "000000000";
      when  442 => Data <= "000000000";
      when  443 => Data <= "000000000";
      -- SPD
      when  448 => Data <= "010000100";
      when  449 => Data <= "001100000";
      when  450 => Data <= "101000010";
      when  451 => Data <= "000000010";
      when  452 => Data <= "000000001";
      when  453 => Data <= "000000011";
      when  454 => Data <= "001000010";
      when  455 => Data <= "000000010";
      when  456 => Data <= "001100010";
      when  457 => Data <= "000110010";
      when  458 => Data <= "000100100";
      when  459 => Data <= "000101011";
      when  460 => Data <= "001101111";
      when  461 => Data <= "001101000";
      when  462 => Data <= "001010110";
      when  463 => Data <= "000101010";
      when  464 => Data <= "001000000";
      when  465 => Data <= "100011010";
      when  466 => Data <= "001110110";
      when  467 => Data <= "000101010";
      when  468 => Data <= "000000001";
      when  469 => Data <= "001111000";
      when  470 => Data <= "001010000";
      when  471 => Data <= "000101001";
      when  472 => Data <= "000011001";
      when  473 => Data <= "000111000";
      when  474 => Data <= "001010000";
      when  475 => Data <= "000101000";

      ---- 480i full
      when  512 => Data <= "000000100";
      when  513 => Data <= "000000010";
      when  514 => Data <= "000000000";
      when  515 => Data <= "000000010";
      when  516 => Data <= "000000010";
      when  517 => Data <= "000000001";
      when  518 => Data <= "000000010";
      when  519 => Data <= "000000000";
      when  520 => Data <= "000000010";
      when  521 => Data <= "000000100";
      when  522 => Data <= "000000010";
      when  523 => Data <= "000000011";
      when  524 => Data <= "000000000";
      when  525 => Data <= "000000101";
      when  526 => Data <= "000000000";
      when  527 => Data <= "000000100";
      when  528 => Data <= "000000100";
      when  529 => Data <= "000000010";
      when  530 => Data <= "000000000";
      when  531 => Data <= "000000000";
      when  532 => Data <= "000000011";
      when  533 => Data <= "000000000";
      when  534 => Data <= "000000111";
      when  535 => Data <= "000000001";
      when  536 => Data <= "000000000";
      when  537 => Data <= "000000000";
      when  538 => Data <= "000000000";
      when  539 => Data <= "000000000";
      -- Audio
      when  544 => Data <= "000000000";
      when  545 => Data <= "000000000";
      when  546 => Data <= "000000110";
      when  547 => Data <= "000000010";
      when  548 => Data <= "000000010";
      when  549 => Data <= "000000000";
      when  550 => Data <= "000000001";
      when  551 => Data <= "000000000";
      when  552 => Data <= "000000000";
      when  553 => Data <= "000000000";
      when  554 => Data <= "000000000";
      when  555 => Data <= "000000001";
      when  556 => Data <= "000000001";
      when  557 => Data <= "000000000";
      when  558 => Data <= "000000000";
      when  559 => Data <= "000000000";
      when  560 => Data <= "000000000";
      when  561 => Data <= "000000000";
      when  562 => Data <= "000000000";
      when  563 => Data <= "000000000";
      when  564 => Data <= "000000000";
      when  565 => Data <= "000000001";
      when  566 => Data <= "000000000";
      when  567 => Data <= "000000001";
      when  568 => Data <= "000000000";
      when  569 => Data <= "000000000";
      when  570 => Data <= "000000000";
      when  571 => Data <= "000000000";
      -- SPD
      when  576 => Data <= "010000100";
      when  577 => Data <= "001100000";
      when  578 => Data <= "101000010";
      when  579 => Data <= "000000010";
      when  580 => Data <= "000000001";
      when  581 => Data <= "000000011";
      when  582 => Data <= "001000010";
      when  583 => Data <= "000000010";
      when  584 => Data <= "001100010";
      when  585 => Data <= "000110010";
      when  586 => Data <= "000100100";
      when  587 => Data <= "000101011";
      when  588 => Data <= "001101111";
      when  589 => Data <= "001101000";
      when  590 => Data <= "001010110";
      when  591 => Data <= "000101010";
      when  592 => Data <= "001000000";
      when  593 => Data <= "100011010";
      when  594 => Data <= "001110110";
      when  595 => Data <= "000101010";
      when  596 => Data <= "000000001";
      when  597 => Data <= "001111000";
      when  598 => Data <= "001010000";
      when  599 => Data <= "000101001";
      when  600 => Data <= "000011001";
      when  601 => Data <= "000111000";
      when  602 => Data <= "001010000";
      when  603 => Data <= "000101000";

      ---- 576i full
      when  640 => Data <= "000000110";
      when  641 => Data <= "000000010";
      when  642 => Data <= "000000110";
      when  643 => Data <= "000000000";
      when  644 => Data <= "000000010";
      when  645 => Data <= "000000001";
      when  646 => Data <= "000000010";
      when  647 => Data <= "000000000";
      when  648 => Data <= "000000010";
      when  649 => Data <= "000000100";
      when  650 => Data <= "000000010";
      when  651 => Data <= "000000011";
      when  652 => Data <= "000000000";
      when  653 => Data <= "000000101";
      when  654 => Data <= "000000000";
      when  655 => Data <= "000000100";
      when  656 => Data <= "000000010";
      when  657 => Data <= "000000010";
      when  658 => Data <= "000000010";
      when  659 => Data <= "000000000";
      when  660 => Data <= "000000011";
      when  661 => Data <= "000000000";
      when  662 => Data <= "000000111";
      when  663 => Data <= "000000001";
      when  664 => Data <= "000000000";
      when  665 => Data <= "000000000";
      when  666 => Data <= "000000000";
      when  667 => Data <= "000000000";
      -- Audio
      when  672 => Data <= "000000000";
      when  673 => Data <= "000000000";
      when  674 => Data <= "000000110";
      when  675 => Data <= "000000010";
      when  676 => Data <= "000000010";
      when  677 => Data <= "000000000";
      when  678 => Data <= "000000001";
      when  679 => Data <= "000000000";
      when  680 => Data <= "000000000";
      when  681 => Data <= "000000000";
      when  682 => Data <= "000000000";
      when  683 => Data <= "000000001";
      when  684 => Data <= "000000001";
      when  685 => Data <= "000000000";
      when  686 => Data <= "000000000";
      when  687 => Data <= "000000000";
      when  688 => Data <= "000000000";
      when  689 => Data <= "000000000";
      when  690 => Data <= "000000000";
      when  691 => Data <= "000000000";
      when  692 => Data <= "000000000";
      when  693 => Data <= "000000001";
      when  694 => Data <= "000000000";
      when  695 => Data <= "000000001";
      when  696 => Data <= "000000000";
      when  697 => Data <= "000000000";
      when  698 => Data <= "000000000";
      when  699 => Data <= "000000000";
      -- SPD
      when  704 => Data <= "010000100";
      when  705 => Data <= "001100000";
      when  706 => Data <= "101000010";
      when  707 => Data <= "000000010";
      when  708 => Data <= "000000001";
      when  709 => Data <= "000000011";
      when  710 => Data <= "001000010";
      when  711 => Data <= "000000010";
      when  712 => Data <= "001100010";
      when  713 => Data <= "000110010";
      when  714 => Data <= "000100100";
      when  715 => Data <= "000101011";
      when  716 => Data <= "001101111";
      when  717 => Data <= "001101000";
      when  718 => Data <= "001010110";
      when  719 => Data <= "000101010";
      when  720 => Data <= "001000000";
      when  721 => Data <= "100011010";
      when  722 => Data <= "001110110";
      when  723 => Data <= "000101010";
      when  724 => Data <= "000000001";
      when  725 => Data <= "001111000";
      when  726 => Data <= "001010000";
      when  727 => Data <= "000101001";
      when  728 => Data <= "000011001";
      when  729 => Data <= "000111000";
      when  730 => Data <= "001010000";
      when  731 => Data <= "000101000";

      ---- 240p full
      when  768 => Data <= "000000000";
      when  769 => Data <= "000000010";
      when  770 => Data <= "000000000";
      when  771 => Data <= "000000010";
      when  772 => Data <= "000000010";
      when  773 => Data <= "000000001";
      when  774 => Data <= "000000010";
      when  775 => Data <= "000000000";
      when  776 => Data <= "000000010";
      when  777 => Data <= "000000100";
      when  778 => Data <= "000000010";
      when  779 => Data <= "000000011";
      when  780 => Data <= "000000000";
      when  781 => Data <= "000000101";
      when  782 => Data <= "000000000";
      when  783 => Data <= "000000100";
      when  784 => Data <= "000000000";
      when  785 => Data <= "000000100";
      when  786 => Data <= "000000000";
      when  787 => Data <= "000000000";
      when  788 => Data <= "000000011";
      when  789 => Data <= "000000000";
      when  790 => Data <= "000000111";
      when  791 => Data <= "000000001";
      when  792 => Data <= "000000000";
      when  793 => Data <= "000000000";
      when  794 => Data <= "000000000";
      when  795 => Data <= "000000000";
      -- Audio
      when  800 => Data <= "000000000";
      when  801 => Data <= "000000000";
      when  802 => Data <= "000000110";
      when  803 => Data <= "000000010";
      when  804 => Data <= "000000010";
      when  805 => Data <= "000000000";
      when  806 => Data <= "000000001";
      when  807 => Data <= "000000000";
      when  808 => Data <= "000000000";
      when  809 => Data <= "000000000";
      when  810 => Data <= "000000000";
      when  811 => Data <= "000000001";
      when  812 => Data <= "000000001";
      when  813 => Data <= "000000000";
      when  814 => Data <= "000000000";
      when  815 => Data <= "000000000";
      when  816 => Data <= "000000000";
      when  817 => Data <= "000000000";
      when  818 => Data <= "000000000";
      when  819 => Data <= "000000000";
      when  820 => Data <= "000000000";
      when  821 => Data <= "000000001";
      when  822 => Data <= "000000000";
      when  823 => Data <= "000000001";
      when  824 => Data <= "000000000";
      when  825 => Data <= "000000000";
      when  826 => Data <= "000000000";
      when  827 => Data <= "000000000";
      -- SPD
      when  832 => Data <= "010000100";
      when  833 => Data <= "001100000";
      when  834 => Data <= "101000010";
      when  835 => Data <= "000000010";
      when  836 => Data <= "000000001";
      when  837 => Data <= "000000011";
      when  838 => Data <= "001000010";
      when  839 => Data <= "000000010";
      when  840 => Data <= "001100010";
      when  841 => Data <= "000110010";
      when  842 => Data <= "000100100";
      when  843 => Data <= "000101011";
      when  844 => Data <= "001101111";
      when  845 => Data <= "001101000";
      when  846 => Data <= "001010110";
      when  847 => Data <= "000101010";
      when  848 => Data <= "001000000";
      when  849 => Data <= "100011010";
      when  850 => Data <= "001110110";
      when  851 => Data <= "000101010";
      when  852 => Data <= "000000001";
      when  853 => Data <= "001111000";
      when  854 => Data <= "001010000";
      when  855 => Data <= "000101001";
      when  856 => Data <= "000011001";
      when  857 => Data <= "000111000";
      when  858 => Data <= "001010000";
      when  859 => Data <= "000101000";

      ---- 288p full
      when  896 => Data <= "000000010";
      when  897 => Data <= "000000010";
      when  898 => Data <= "000000110";
      when  899 => Data <= "000000000";
      when  900 => Data <= "000000010";
      when  901 => Data <= "000000001";
      when  902 => Data <= "000000010";
      when  903 => Data <= "000000000";
      when  904 => Data <= "000000010";
      when  905 => Data <= "000000100";
      when  906 => Data <= "000000010";
      when  907 => Data <= "000000011";
      when  908 => Data <= "000000000";
      when  909 => Data <= "000000101";
      when  910 => Data <= "000000000";
      when  911 => Data <= "000000100";
      when  912 => Data <= "000000110";
      when  913 => Data <= "000000010";
      when  914 => Data <= "000000010";
      when  915 => Data <= "000000000";
      when  916 => Data <= "000000011";
      when  917 => Data <= "000000000";
      when  918 => Data <= "000000111";
      when  919 => Data <= "000000001";
      when  920 => Data <= "000000000";
      when  921 => Data <= "000000000";
      when  922 => Data <= "000000000";
      when  923 => Data <= "000000000";
      -- Audio
      when  928 => Data <= "000000000";
      when  929 => Data <= "000000000";
      when  930 => Data <= "000000110";
      when  931 => Data <= "000000010";
      when  932 => Data <= "000000010";
      when  933 => Data <= "000000000";
      when  934 => Data <= "000000001";
      when  935 => Data <= "000000000";
      when  936 => Data <= "000000000";
      when  937 => Data <= "000000000";
      when  938 => Data <= "000000000";
      when  939 => Data <= "000000001";
      when  940 => Data <= "000000001";
      when  941 => Data <= "000000000";
      when  942 => Data <= "000000000";
      when  943 => Data <= "000000000";
      when  944 => Data <= "000000000";
      when  945 => Data <= "000000000";
      when  946 => Data <= "000000000";
      when  947 => Data <= "000000000";
      when  948 => Data <= "000000000";
      when  949 => Data <= "000000001";
      when  950 => Data <= "000000000";
      when  951 => Data <= "000000001";
      when  952 => Data <= "000000000";
      when  953 => Data <= "000000000";
      when  954 => Data <= "000000000";
      when  955 => Data <= "000000000";
      -- SPD
      when  960 => Data <= "010000100";
      when  961 => Data <= "001100000";
      when  962 => Data <= "101000010";
      when  963 => Data <= "000000010";
      when  964 => Data <= "000000001";
      when  965 => Data <= "000000011";
      when  966 => Data <= "001000010";
      when  967 => Data <= "000000010";
      when  968 => Data <= "001100010";
      when  969 => Data <= "000110010";
      when  970 => Data <= "000100100";
      when  971 => Data <= "000101011";
      when  972 => Data <= "001101111";
      when  973 => Data <= "001101000";
      when  974 => Data <= "001010110";
      when  975 => Data <= "000101010";
      when  976 => Data <= "001000000";
      when  977 => Data <= "100011010";
      when  978 => Data <= "001110110";
      when  979 => Data <= "000101010";
      when  980 => Data <= "000000001";
      when  981 => Data <= "001111000";
      when  982 => Data <= "001010000";
      when  983 => Data <= "000101001";
      when  984 => Data <= "000011001";
      when  985 => Data <= "000111000";
      when  986 => Data <= "001010000";
      when  987 => Data <= "000101000";

      when others => Data <= (others => '0');
    end case;
  end if;
end process;

end Behavioral;
