-------------------------------------------------------------------
-- System Generator version 2017.4 VHDL source file.
--
-- Copyright(C) 2017 by Xilinx, Inc.  All rights reserved.  This
-- text/file contains proprietary, confidential information of Xilinx,
-- Inc., is distributed under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms of a valid license
-- agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
-- this text/file solely for design, simulation, implementation and
-- creation of design files limited to Xilinx devices or technologies.
-- Use with non-Xilinx devices or technologies is expressly prohibited
-- and immediately terminates your license unless covered by a separate
-- agreement.
--
-- Xilinx is providing this design, code, or information "as is" solely
-- for use in developing programs and solutions for Xilinx devices.  By
-- providing this design, code, or information as one possible
-- implementation of this feature, application or standard, Xilinx is
-- making no representation that this implementation is free from any
-- claims of infringement.  You are responsible for obtaining any rights
-- you may require for your implementation.  Xilinx expressly disclaims
-- any warranty whatsoever with respect to the adequacy of the
-- implementation, including but not limited to warranties of
-- merchantability or fitness for a particular purpose.
--
-- Xilinx products are not intended for use in life support appliances,
-- devices, or systems.  Use in such applications is expressly prohibited.
--
-- Any modifications that are made to the source code are done at the user's
-- sole risk and will be unsupported.
--
-- This copyright and support notice must be retained as part of this
-- text at all times.  (c) Copyright 1995-2017 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------

library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.conv_pkg.all;


entity example_xlAsynRegister is

   generic (d_width          : integer := 5;          -- Width of d input
            init_value       : bit_vector := b"00");  -- Binary init value string

   port (d     : in std_logic_vector (d_width-1 downto 0);
         rst   : in std_logic_vector(0 downto 0) := "0";
         en    : in std_logic_vector(0 downto 0) := "1";
         d_ce  : in std_logic;
         d_clk : in std_logic;
         q_ce  : in std_logic;
         q_clk : in std_logic;
         q     : out std_logic_vector (d_width-1 downto 0));

end example_xlAsynRegister;

architecture behavior of example_xlAsynRegister is

   component synth_reg_w_init
      generic (width      : integer;
               init_index : integer;
               init_value : bit_vector;
               latency    : integer);
      port (i   : in std_logic_vector(width-1 downto 0);
            ce  : in std_logic;
            clr : in std_logic;
            clk : in std_logic;
            o   : out std_logic_vector(width-1 downto 0));
   end component; -- end synth_reg_w_init

   signal internal_d_clr      : std_logic;
   signal internal_d_ce       : std_logic;
   signal internal_q_clr      : std_logic;
   signal internal_q_ce       : std_logic;

   signal d1_net              : std_logic_vector (d_width-1 downto 0);
   signal d2_net              : std_logic_vector (d_width-1 downto 0);
   signal d3_net              : std_logic_vector (d_width-1 downto 0);

begin

   internal_d_clr <= rst(0) and d_ce;
   internal_d_ce  <= en(0) and d_ce;
   -- drive default values on enable and clear ports
   internal_q_clr <= '0' and q_ce;
   internal_q_ce  <= '1' and q_ce;

   -- Synthesizable behavioral model
   synth_reg_inst_0 : synth_reg_w_init
      generic map (width      => d_width,
                   init_index => 2,
                   init_value => init_value,
                   latency    => 1)
      port map (i   => d,
                ce  => internal_d_ce,
                clr => internal_d_clr,
                clk => d_clk,
                o   => d1_net);

   synth_reg_inst_1 : synth_reg_w_init
      generic map (width      => d_width,
                   init_index => 2,
                   init_value => init_value,
                   latency    => 1)
      port map (i   => d1_net,
                ce  => internal_q_ce,
                clr => internal_q_clr,
                clk => q_clk,
                o   => d2_net);

   synth_reg_inst_2 : synth_reg_w_init
      generic map (width      => d_width,
                   init_index => 2,
                   init_value => init_value,
                   latency    => 1)
      port map (i   => d2_net,
                ce  => internal_q_ce,
                clr => internal_q_clr,
                clk => q_clk,
                o   => d3_net);

   synth_reg_inst_3 : synth_reg_w_init
      generic map (width      => d_width,
                   init_index => 2,
                   init_value => init_value,
                   latency    => 1)
      port map (i   => d3_net,
                ce  => internal_q_ce,
                clr => internal_q_clr,
                clk => q_clk,
                o   => q);

end architecture behavior;


library work;
use work.conv_pkg.all;

---------------------------------------------------------------------
--
--  Filename      : xlregister.vhd
--
--  Description   : VHDL description of an arbitrary wide register.
--                  Unlike the delay block, an initial value is
--                  specified and is considered valid at the start
--                  of simulation.  The register is only one word
--                  deep.
--
--  Mod. History  : Removed valid bit logic from wrapper.
--                : Changed VHDL to use a bit_vector generic for its
--
---------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.conv_pkg.all;


entity example_xlregister is

   generic (d_width          : integer := 5;          -- Width of d input
            init_value       : bit_vector := b"00");  -- Binary init value string

   port (d   : in std_logic_vector (d_width-1 downto 0);
         rst : in std_logic_vector(0 downto 0) := "0";
         en  : in std_logic_vector(0 downto 0) := "1";
         ce  : in std_logic;
         clk : in std_logic;
         q   : out std_logic_vector (d_width-1 downto 0));

end example_xlregister;

architecture behavior of example_xlregister is

   component synth_reg_w_init
      generic (width      : integer;
               init_index : integer;
               init_value : bit_vector;
               latency    : integer);
      port (i   : in std_logic_vector(width-1 downto 0);
            ce  : in std_logic;
            clr : in std_logic;
            clk : in std_logic;
            o   : out std_logic_vector(width-1 downto 0));
   end component; -- end synth_reg_w_init

   -- synthesis translate_off
   signal real_d, real_q           : real;    -- For debugging info ports
   -- synthesis translate_on
   signal internal_clr             : std_logic;
   signal internal_ce              : std_logic;

begin

   internal_clr <= rst(0) and ce;
   internal_ce  <= en(0) and ce;

   -- Synthesizable behavioral model
   synth_reg_inst : synth_reg_w_init
      generic map (width      => d_width,
                   init_index => 2,
                   init_value => init_value,
                   latency    => 1)
      port map (i   => d,
                ce  => internal_ce,
                clr => internal_clr,
                clk => clk,
                o   => q);

end architecture behavior;


library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_0dde287d44 is
  port (
    op : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_0dde287d44;
architecture behavior of sysgen_constant_0dde287d44
is
begin
  op <= "00000000000000000000000000000001";
end behavior;

library work;
use work.conv_pkg.all;

---------------------------------------------------------------------
--
--  Filename      : xldsamp.vhd
--
--  Description   : VHDL description of a block that is inserted into the
--                  data path to down sample the data betwen two blocks
--                  where the period is different between two blocks.
--
--  Mod. History  : Changed clock timing on the down sampler.  The
--                  destination enable is delayed by one system clock
--                  cycle and held until the next consecutive source
--                  enable pulse.  This change allows downsampler data
--                  transitions to occur on the rising clock edge when
--                  the destination ce is asserted.
--                : Added optional latency is the downsampler.  Note, if
--                  the latency is greater than 0, no shutter is used.
--                : Removed valid bit logic from wrapper
--
--
---------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.conv_pkg.all;


-- synthesis translate_off
library unisim;
use unisim.vcomponents.all;
-- synthesis translate_on

entity example_xldsamp is
  generic (
    d_width: integer := 12;
    d_bin_pt: integer := 0;
    d_arith: integer := xlUnsigned;
    q_width: integer := 12;
    q_bin_pt: integer := 0;
    q_arith: integer := xlUnsigned;
    en_width: integer := 1;
    en_bin_pt: integer := 0;
    en_arith: integer := xlUnsigned;
    rst_width: integer := 1;
    rst_bin_pt: integer := 0;
    rst_arith: integer := xlUnsigned;
    ds_ratio: integer := 2;
    phase: integer := 0;
    latency: integer := 1
  );
  port (
    d: in std_logic_vector(d_width - 1 downto 0);
    src_clk: in std_logic;
    src_ce: in std_logic;
    src_clr: in std_logic;
    dest_clk: in std_logic;
    dest_ce: in std_logic;
    dest_clr: in std_logic;
    en: in std_logic_vector(en_width - 1 downto 0);
    rst: in std_logic_vector(rst_width - 1 downto 0);
    q: out std_logic_vector(q_width - 1 downto 0)
  );
end example_xldsamp;

architecture struct of example_xldsamp is
  component synth_reg
    generic (
      width: integer := 16;
      latency: integer := 5
    );
    port (
      i: in std_logic_vector(width - 1 downto 0);
      ce: in std_logic;
      clr: in std_logic;
      clk: in std_logic;
      o: out std_logic_vector(width - 1 downto 0)
    );
  end component; -- end synth_reg

  component synth_reg_reg
     generic (width       : integer;
              latency     : integer);
     port (i       : in std_logic_vector(width-1 downto 0);
           ce      : in std_logic;
           clr     : in std_logic;
           clk     : in std_logic;
           o       : out std_logic_vector(width-1 downto 0));
  end component;

  component fdse
    port (
      q: out   std_ulogic;
      d: in    std_ulogic;
      c: in    std_ulogic;
      s: in    std_ulogic;
      ce: in    std_ulogic
    );
  end component; -- end fdse
  attribute syn_black_box of fdse: component is true;
  attribute fpga_dont_touch of fdse: component is "true";

  signal adjusted_dest_ce: std_logic;
  signal adjusted_dest_ce_w_en: std_logic;
  signal dest_ce_w_en: std_logic;
  signal smpld_d: std_logic_vector(d_width-1 downto 0);
  signal sclr:std_logic;
begin
  -- An 'adjusted' destination clock enable signal must be generated for
  -- the zero latency and double registered down-sampler implementations.
  -- For both cases, it is necassary to adjust the timing of the clock
  -- enable so that it is asserted at the start of the sample period,
  -- instead of the end.  This is realized using an fdse prim. to register
  -- the destination clock enable.  The fdse itself is enabled with the
  -- source clock enable.  Enabling the fdse holds the adjusted CE high
  -- for the duration of the fast sample period and is needed to satisfy
  -- the multicycle constraint if the input data is running at a non-system
  -- rate.
  adjusted_ce_needed: if ((latency = 0) or (phase /= (ds_ratio - 1))) generate
    dest_ce_reg: fdse
      port map (
        q => adjusted_dest_ce,
        d => dest_ce,
        c => src_clk,
        s => sclr,
        ce => src_ce
      );
  end generate; -- adjusted_ce_needed

  -- A shutter (mux/reg pair) is used to implement a 0 latency downsampler.
  -- The shutter uses the adjusted destination clock enable to select between
  -- the current input and the sampled input.
  latency_eq_0: if (latency = 0) generate
    shutter_d_reg: synth_reg
      generic map (
        width => d_width,
        latency => 1
      )
      port map (
        i => d,
        ce => adjusted_dest_ce,
        clr => sclr,
        clk => src_clk,
        o => smpld_d
      );

    -- Mux selects current input value or register value.
    shutter_mux: process (adjusted_dest_ce, d, smpld_d)
    begin
	  if adjusted_dest_ce = '0' then
        q <= smpld_d;
      else
        q <= d;
      end if;
    end process; -- end select_mux
  end generate; -- end latency_eq_0

  -- A more efficient downsampler can be implemented if a latency > 0 is
  -- allowed.  There are two possible implementations, depending on the
  -- requested sampling phase.  A double register downsampler is needed
  -- for all cases except when the sample phase is the last input frame
  -- of the sample period.  In this case, only one register is needed.

  latency_gt_0: if (latency > 0) generate
    -- The first register in the double reg implementation is used to
    -- sample the correct frame (phase) of the input data.  Both the
    -- data and valid bit must be sampled.
    dbl_reg_test: if (phase /= (ds_ratio-1)) generate
        smpl_d_reg: synth_reg_reg
          generic map (
            width => d_width,
            latency => 1
          )
          port map (
            i => d,
            ce => adjusted_dest_ce_w_en,
            clr => sclr,
            clk => src_clk,
            o => smpld_d
          );
    end generate; -- end dbl_reg_test

    sngl_reg_test: if (phase = (ds_ratio -1)) generate
      smpld_d <= d;
    end generate; -- sngl_reg_test

    -- The latency pipe captures the sampled data and the END of the sample
    -- period.  Note that if the requested sample phase is the last input
    -- frame in the period, the first register (smpl_reg) is not needed.
    latency_pipe: synth_reg_reg
      generic map (
        width => d_width,
        latency => latency
      )
      port map (
        i => smpld_d,
        ce => dest_ce_w_en,
        clr => sclr,
        clk => dest_clk,
        o => q
      );
  end generate; -- end latency_gt_0

  -- Signal assignments
  dest_ce_w_en <= dest_ce and en(0);
  adjusted_dest_ce_w_en <= adjusted_dest_ce and en(0);
  sclr <= (src_clr or rst(0)) and dest_ce;
end architecture struct;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_abs_1b92676e73 is
  port (
    a : in std_logic_vector((19 - 1) downto 0);
    op : out std_logic_vector((20 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_abs_1b92676e73;
architecture behavior of sysgen_abs_1b92676e73
is
  signal a_16_25: signed((19 - 1) downto 0);
  type array_type_op_mem_48_20 is array (0 to (1 - 1)) of signed((20 - 1) downto 0);
  signal op_mem_48_20: array_type_op_mem_48_20 := (
    0 => "00000000000000000000");
  signal op_mem_48_20_front_din: signed((20 - 1) downto 0);
  signal op_mem_48_20_back: signed((20 - 1) downto 0);
  signal op_mem_48_20_push_front_pop_back_en: std_logic;
  signal cast_34_28: signed((20 - 1) downto 0);
  signal internal_ip_34_13_neg: signed((20 - 1) downto 0);
  signal rel_31_8: boolean;
  signal internal_ip_join_31_5: signed((20 - 1) downto 0);
  signal internal_ip_join_28_1: signed((20 - 1) downto 0);
begin
  a_16_25 <= std_logic_vector_to_signed(a);
  op_mem_48_20_back <= op_mem_48_20(0);
  proc_op_mem_48_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_48_20_push_front_pop_back_en = '1')) then
        op_mem_48_20(0) <= op_mem_48_20_front_din;
      end if;
    end if;
  end process proc_op_mem_48_20;
  cast_34_28 <= s2s_cast(a_16_25, 17, 20, 17);
  internal_ip_34_13_neg <=  -cast_34_28;
  rel_31_8 <= a_16_25 >= std_logic_vector_to_signed("0000000000000000000");
  proc_if_31_5: process (a_16_25, internal_ip_34_13_neg, rel_31_8)
  is
  begin
    if rel_31_8 then
      internal_ip_join_31_5 <= s2s_cast(a_16_25, 17, 20, 17);
    else 
      internal_ip_join_31_5 <= internal_ip_34_13_neg;
    end if;
  end process proc_if_31_5;
  proc_if_28_1: process (internal_ip_join_31_5)
  is
  begin
    if false then
      internal_ip_join_28_1 <= std_logic_vector_to_signed("00000000000000000000");
    else 
      internal_ip_join_28_1 <= internal_ip_join_31_5;
    end if;
  end process proc_if_28_1;
  op_mem_48_20_front_din <= internal_ip_join_28_1;
  op_mem_48_20_push_front_pop_back_en <= '1';
  op <= signed_to_std_logic_vector(op_mem_48_20_back);
end behavior;

library work;
use work.conv_pkg.all;

---------------------------------------------------------------------
--
--  Filename      : xlceprobe.vhd
--
--  Description   : VHDL description of system clock enable probe.
--                  This block assigns the clock enable signal to
--                  the output port.
--  Mod. History  : Added beffer so the the ce nets would not get renamed
--
---------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.conv_pkg.all;

-- synthesis translate_off
library unisim;
use unisim.vcomponents.all;
-- synthesis translate_on


entity example_xlceprobe is
    generic (d_width  : integer := 8;
             q_width  : integer := 1);
    port (d       : in std_logic_vector (d_width-1 downto 0);
          ce      : in std_logic;
          clk     : in std_logic;
          q       : out std_logic_vector (q_width-1 downto 0));
end example_xlceprobe;

architecture behavior of example_xlceprobe is
    component BUF
        port(
            O  :        out   STD_ULOGIC;
            I  :        in    STD_ULOGIC);
    end component;
    attribute syn_black_box of BUF : component is true;
    attribute fpga_dont_touch of BUF : component is "true";
    signal ce_vec : std_logic_vector(0 downto 0);
begin
    buf_comp : buf port map(i => ce, o => ce_vec(0));
     -- use the clock enable signal to drive the output port
    q <= ce_vec;
end architecture behavior;

library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_ebbc84a2b1 is
  port (
    op : out std_logic_vector((26 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_ebbc84a2b1;
architecture behavior of sysgen_constant_ebbc84a2b1
is
begin
  op <= "00000000000000000000000001";
end behavior;

library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_578d5a08da is
  port (
    op : out std_logic_vector((18 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_578d5a08da;
architecture behavior of sysgen_constant_578d5a08da
is
begin
  op <= "011111111111111111";
end behavior;

library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_a6ce73fb97 is
  port (
    op : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_a6ce73fb97;
architecture behavior of sysgen_constant_a6ce73fb97
is
begin
  op <= "00000000000000000000000001111110";
end behavior;

library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.conv_pkg.all;


entity example_xldelay is
   generic(width        : integer := -1;
           latency      : integer := -1;
           reg_retiming : integer :=  0;
           reset        : integer :=  0);
   port(d       : in std_logic_vector (width-1 downto 0);
        ce      : in std_logic;
        clk     : in std_logic;
        en      : in std_logic;
        rst     : in std_logic;
        q       : out std_logic_vector (width-1 downto 0));

end example_xldelay;

architecture behavior of example_xldelay is
   component synth_reg
      generic (width       : integer;
               latency     : integer);
      port (i       : in std_logic_vector(width-1 downto 0);
            ce      : in std_logic;
            clr     : in std_logic;
            clk     : in std_logic;
            o       : out std_logic_vector(width-1 downto 0));
   end component; -- end component synth_reg

   component synth_reg_reg
      generic (width       : integer;
               latency     : integer);
      port (i       : in std_logic_vector(width-1 downto 0);
            ce      : in std_logic;
            clr     : in std_logic;
            clk     : in std_logic;
            o       : out std_logic_vector(width-1 downto 0));
   end component;

   signal internal_ce  : std_logic;

begin
   internal_ce  <= ce and en;

   srl_delay: if ((reg_retiming = 0) and (reset = 0)) or (latency < 1) generate
     synth_reg_srl_inst : synth_reg
       generic map (
         width   => width,
         latency => latency)
       port map (
         i   => d,
         ce  => internal_ce,
         clr => '0',
         clk => clk,
         o   => q);
   end generate srl_delay;

   reg_delay: if ((reg_retiming = 1) or (reset = 1)) and (latency >= 1) generate
     synth_reg_reg_inst : synth_reg_reg
       generic map (
         width   => width,
         latency => latency)
       port map (
         i   => d,
         ce  => internal_ce,
         clr => rst,
         clk => clk,
         o   => q);
   end generate reg_delay;
end architecture behavior;

library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_589172b339 is
  port (
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_589172b339;
architecture behavior of sysgen_constant_589172b339
is
begin
  op <= "1";
end behavior;

library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_ff2f539dd4 is
  port (
    op : out std_logic_vector((4 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_ff2f539dd4;
architecture behavior of sysgen_constant_ff2f539dd4
is
begin
  op <= "1011";
end behavior;

library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_relational_e6d9f3f14a is
  port (
    a : in std_logic_vector((4 - 1) downto 0);
    b : in std_logic_vector((4 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_relational_e6d9f3f14a;
architecture behavior of sysgen_relational_e6d9f3f14a
is
  signal a_1_31: unsigned((4 - 1) downto 0);
  signal b_1_34: unsigned((4 - 1) downto 0);
  type array_type_op_mem_37_22 is array (0 to (1 - 1)) of boolean;
  signal op_mem_37_22: array_type_op_mem_37_22 := (
    0 => false);
  signal op_mem_37_22_front_din: boolean;
  signal op_mem_37_22_back: boolean;
  signal op_mem_37_22_push_front_pop_back_en: std_logic;
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  op_mem_37_22_back <= op_mem_37_22(0);
  proc_op_mem_37_22: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_37_22_push_front_pop_back_en = '1')) then
        op_mem_37_22(0) <= op_mem_37_22_front_din;
      end if;
    end if;
  end process proc_op_mem_37_22;
  result_12_3_rel <= a_1_31 = b_1_34;
  op_mem_37_22_front_din <= result_12_3_rel;
  op_mem_37_22_push_front_pop_back_en <= '1';
  op <= boolean_to_vector(op_mem_37_22_back);
end behavior;

library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity axi_lite_axi_lite_interface is 
    port(
        scratchpad : out std_logic_vector(31 downto 0);
        status_0 : in std_logic_vector(31 downto 0);
        cav1_p1_amp_out : in std_logic_vector(17 downto 0);
        cav1_p1_comparison_i : in std_logic_vector(17 downto 0);
        cav1_p1_comparison_phase : in std_logic_vector(17 downto 0);
        cav1_p1_comparison_q : in std_logic_vector(17 downto 0);
        cav1_p1_dc_freq : in std_logic_vector(25 downto 0);
        cav1_p1_dc_img : in std_logic_vector(28 downto 0);
        cav1_p1_dc_real : in std_logic_vector(28 downto 0);
        cav1_p1_if_amp : in std_logic_vector(17 downto 0);
        cav1_p1_if_i : in std_logic_vector(17 downto 0);
        cav1_p1_if_phase : in std_logic_vector(17 downto 0);
        cav1_p1_if_q : in std_logic_vector(17 downto 0);
        cav1_p1_integrated_i : in std_logic_vector(17 downto 0);
        cav1_p1_integrated_q : in std_logic_vector(17 downto 0);
        cav1_p1_phase_out : in std_logic_vector(17 downto 0);
        axi_lite_clk : out std_logic;
        axi_lite_aclk : in std_logic;
        axi_lite_aresetn : in std_logic;
        axi_lite_s_axi_awaddr : in std_logic_vector(12-1 downto 0);
        axi_lite_s_axi_awvalid : in std_logic;
        axi_lite_s_axi_awready : out std_logic;
        axi_lite_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        axi_lite_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        axi_lite_s_axi_wvalid : in std_logic;
        axi_lite_s_axi_wready : out std_logic;
        axi_lite_s_axi_bresp : out std_logic_vector(1 downto 0);
        axi_lite_s_axi_bvalid : out std_logic;
        axi_lite_s_axi_bready : in std_logic;
        axi_lite_s_axi_araddr : in std_logic_vector(12-1 downto 0);
        axi_lite_s_axi_arvalid : in std_logic;
        axi_lite_s_axi_arready : out std_logic;
        axi_lite_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        axi_lite_s_axi_rresp : out std_logic_vector(1 downto 0);
        axi_lite_s_axi_rvalid : out std_logic;
        axi_lite_s_axi_rready : in std_logic
    );
end axi_lite_axi_lite_interface;
architecture structural of axi_lite_axi_lite_interface is 
component axi_lite_axi_lite_interface_verilog is
    port(
        scratchpad : out std_logic_vector(31 downto 0);
        status_0 : in std_logic_vector(31 downto 0);
        cav1_p1_amp_out : in std_logic_vector(17 downto 0);
        cav1_p1_comparison_i : in std_logic_vector(17 downto 0);
        cav1_p1_comparison_phase : in std_logic_vector(17 downto 0);
        cav1_p1_comparison_q : in std_logic_vector(17 downto 0);
        cav1_p1_dc_freq : in std_logic_vector(25 downto 0);
        cav1_p1_dc_img : in std_logic_vector(28 downto 0);
        cav1_p1_dc_real : in std_logic_vector(28 downto 0);
        cav1_p1_if_amp : in std_logic_vector(17 downto 0);
        cav1_p1_if_i : in std_logic_vector(17 downto 0);
        cav1_p1_if_phase : in std_logic_vector(17 downto 0);
        cav1_p1_if_q : in std_logic_vector(17 downto 0);
        cav1_p1_integrated_i : in std_logic_vector(17 downto 0);
        cav1_p1_integrated_q : in std_logic_vector(17 downto 0);
        cav1_p1_phase_out : in std_logic_vector(17 downto 0);
        axi_lite_clk : out std_logic;
        axi_lite_aclk : in std_logic;
        axi_lite_aresetn : in std_logic;
        axi_lite_s_axi_awaddr : in std_logic_vector(12-1 downto 0);
        axi_lite_s_axi_awvalid : in std_logic;
        axi_lite_s_axi_awready : out std_logic;
        axi_lite_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        axi_lite_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        axi_lite_s_axi_wvalid : in std_logic;
        axi_lite_s_axi_wready : out std_logic;
        axi_lite_s_axi_bresp : out std_logic_vector(1 downto 0);
        axi_lite_s_axi_bvalid : out std_logic;
        axi_lite_s_axi_bready : in std_logic;
        axi_lite_s_axi_araddr : in std_logic_vector(12-1 downto 0);
        axi_lite_s_axi_arvalid : in std_logic;
        axi_lite_s_axi_arready : out std_logic;
        axi_lite_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        axi_lite_s_axi_rresp : out std_logic_vector(1 downto 0);
        axi_lite_s_axi_rvalid : out std_logic;
        axi_lite_s_axi_rready : in std_logic
    );
end component;
begin
inst : axi_lite_axi_lite_interface_verilog
    port map(
    scratchpad => scratchpad,
    status_0 => status_0,
    cav1_p1_amp_out => cav1_p1_amp_out,
    cav1_p1_comparison_i => cav1_p1_comparison_i,
    cav1_p1_comparison_phase => cav1_p1_comparison_phase,
    cav1_p1_comparison_q => cav1_p1_comparison_q,
    cav1_p1_dc_freq => cav1_p1_dc_freq,
    cav1_p1_dc_img => cav1_p1_dc_img,
    cav1_p1_dc_real => cav1_p1_dc_real,
    cav1_p1_if_amp => cav1_p1_if_amp,
    cav1_p1_if_i => cav1_p1_if_i,
    cav1_p1_if_phase => cav1_p1_if_phase,
    cav1_p1_if_q => cav1_p1_if_q,
    cav1_p1_integrated_i => cav1_p1_integrated_i,
    cav1_p1_integrated_q => cav1_p1_integrated_q,
    cav1_p1_phase_out => cav1_p1_phase_out,
    axi_lite_clk => axi_lite_clk,
    axi_lite_aclk => axi_lite_aclk,
    axi_lite_aresetn => axi_lite_aresetn,
    axi_lite_s_axi_awaddr => axi_lite_s_axi_awaddr,
    axi_lite_s_axi_awvalid => axi_lite_s_axi_awvalid,
    axi_lite_s_axi_awready => axi_lite_s_axi_awready,
    axi_lite_s_axi_wdata => axi_lite_s_axi_wdata,
    axi_lite_s_axi_wstrb => axi_lite_s_axi_wstrb,
    axi_lite_s_axi_wvalid => axi_lite_s_axi_wvalid,
    axi_lite_s_axi_wready => axi_lite_s_axi_wready,
    axi_lite_s_axi_bresp => axi_lite_s_axi_bresp,
    axi_lite_s_axi_bvalid => axi_lite_s_axi_bvalid,
    axi_lite_s_axi_bready => axi_lite_s_axi_bready,
    axi_lite_s_axi_araddr => axi_lite_s_axi_araddr,
    axi_lite_s_axi_arvalid => axi_lite_s_axi_arvalid,
    axi_lite_s_axi_arready => axi_lite_s_axi_arready,
    axi_lite_s_axi_rdata => axi_lite_s_axi_rdata,
    axi_lite_s_axi_rresp => axi_lite_s_axi_rresp,
    axi_lite_s_axi_rvalid => axi_lite_s_axi_rvalid,
    axi_lite_s_axi_rready => axi_lite_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav1_nco_phase_adj_axi_lite_interface is 
    port(
        cav2_nco_phase_adj : out std_logic_vector(28 downto 0);
        cav1_nco_phase_adj : out std_logic_vector(28 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_nco_phase_adj_aclk : in std_logic;
        dsp_cav1_nco_phase_adj_aresetn : in std_logic;
        dsp_cav1_nco_phase_adj_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav1_nco_phase_adj_s_axi_awvalid : in std_logic;
        dsp_cav1_nco_phase_adj_s_axi_awready : out std_logic;
        dsp_cav1_nco_phase_adj_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_nco_phase_adj_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_nco_phase_adj_s_axi_wvalid : in std_logic;
        dsp_cav1_nco_phase_adj_s_axi_wready : out std_logic;
        dsp_cav1_nco_phase_adj_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_nco_phase_adj_s_axi_bvalid : out std_logic;
        dsp_cav1_nco_phase_adj_s_axi_bready : in std_logic;
        dsp_cav1_nco_phase_adj_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav1_nco_phase_adj_s_axi_arvalid : in std_logic;
        dsp_cav1_nco_phase_adj_s_axi_arready : out std_logic;
        dsp_cav1_nco_phase_adj_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_nco_phase_adj_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_nco_phase_adj_s_axi_rvalid : out std_logic;
        dsp_cav1_nco_phase_adj_s_axi_rready : in std_logic
    );
end dsp_cav1_nco_phase_adj_axi_lite_interface;
architecture structural of dsp_cav1_nco_phase_adj_axi_lite_interface is 
component dsp_cav1_nco_phase_adj_axi_lite_interface_verilog is
    port(
        cav2_nco_phase_adj : out std_logic_vector(28 downto 0);
        cav1_nco_phase_adj : out std_logic_vector(28 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_nco_phase_adj_aclk : in std_logic;
        dsp_cav1_nco_phase_adj_aresetn : in std_logic;
        dsp_cav1_nco_phase_adj_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav1_nco_phase_adj_s_axi_awvalid : in std_logic;
        dsp_cav1_nco_phase_adj_s_axi_awready : out std_logic;
        dsp_cav1_nco_phase_adj_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_nco_phase_adj_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_nco_phase_adj_s_axi_wvalid : in std_logic;
        dsp_cav1_nco_phase_adj_s_axi_wready : out std_logic;
        dsp_cav1_nco_phase_adj_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_nco_phase_adj_s_axi_bvalid : out std_logic;
        dsp_cav1_nco_phase_adj_s_axi_bready : in std_logic;
        dsp_cav1_nco_phase_adj_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav1_nco_phase_adj_s_axi_arvalid : in std_logic;
        dsp_cav1_nco_phase_adj_s_axi_arready : out std_logic;
        dsp_cav1_nco_phase_adj_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_nco_phase_adj_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_nco_phase_adj_s_axi_rvalid : out std_logic;
        dsp_cav1_nco_phase_adj_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav1_nco_phase_adj_axi_lite_interface_verilog
    port map(
    cav2_nco_phase_adj => cav2_nco_phase_adj,
    cav1_nco_phase_adj => cav1_nco_phase_adj,
    dsp_clk => dsp_clk,
    dsp_cav1_nco_phase_adj_aclk => dsp_cav1_nco_phase_adj_aclk,
    dsp_cav1_nco_phase_adj_aresetn => dsp_cav1_nco_phase_adj_aresetn,
    dsp_cav1_nco_phase_adj_s_axi_awaddr => dsp_cav1_nco_phase_adj_s_axi_awaddr,
    dsp_cav1_nco_phase_adj_s_axi_awvalid => dsp_cav1_nco_phase_adj_s_axi_awvalid,
    dsp_cav1_nco_phase_adj_s_axi_awready => dsp_cav1_nco_phase_adj_s_axi_awready,
    dsp_cav1_nco_phase_adj_s_axi_wdata => dsp_cav1_nco_phase_adj_s_axi_wdata,
    dsp_cav1_nco_phase_adj_s_axi_wstrb => dsp_cav1_nco_phase_adj_s_axi_wstrb,
    dsp_cav1_nco_phase_adj_s_axi_wvalid => dsp_cav1_nco_phase_adj_s_axi_wvalid,
    dsp_cav1_nco_phase_adj_s_axi_wready => dsp_cav1_nco_phase_adj_s_axi_wready,
    dsp_cav1_nco_phase_adj_s_axi_bresp => dsp_cav1_nco_phase_adj_s_axi_bresp,
    dsp_cav1_nco_phase_adj_s_axi_bvalid => dsp_cav1_nco_phase_adj_s_axi_bvalid,
    dsp_cav1_nco_phase_adj_s_axi_bready => dsp_cav1_nco_phase_adj_s_axi_bready,
    dsp_cav1_nco_phase_adj_s_axi_araddr => dsp_cav1_nco_phase_adj_s_axi_araddr,
    dsp_cav1_nco_phase_adj_s_axi_arvalid => dsp_cav1_nco_phase_adj_s_axi_arvalid,
    dsp_cav1_nco_phase_adj_s_axi_arready => dsp_cav1_nco_phase_adj_s_axi_arready,
    dsp_cav1_nco_phase_adj_s_axi_rdata => dsp_cav1_nco_phase_adj_s_axi_rdata,
    dsp_cav1_nco_phase_adj_s_axi_rresp => dsp_cav1_nco_phase_adj_s_axi_rresp,
    dsp_cav1_nco_phase_adj_s_axi_rvalid => dsp_cav1_nco_phase_adj_s_axi_rvalid,
    dsp_cav1_nco_phase_adj_s_axi_rready => dsp_cav1_nco_phase_adj_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav1_nco_phase_reset_axi_lite_interface is 
    port(
        cav2_nco_phase_reset : out std_logic_vector(0 downto 0);
        cav1_nco_phase_reset : out std_logic_vector(0 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_nco_phase_reset_aclk : in std_logic;
        dsp_cav1_nco_phase_reset_aresetn : in std_logic;
        dsp_cav1_nco_phase_reset_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav1_nco_phase_reset_s_axi_awvalid : in std_logic;
        dsp_cav1_nco_phase_reset_s_axi_awready : out std_logic;
        dsp_cav1_nco_phase_reset_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_nco_phase_reset_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_nco_phase_reset_s_axi_wvalid : in std_logic;
        dsp_cav1_nco_phase_reset_s_axi_wready : out std_logic;
        dsp_cav1_nco_phase_reset_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_nco_phase_reset_s_axi_bvalid : out std_logic;
        dsp_cav1_nco_phase_reset_s_axi_bready : in std_logic;
        dsp_cav1_nco_phase_reset_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav1_nco_phase_reset_s_axi_arvalid : in std_logic;
        dsp_cav1_nco_phase_reset_s_axi_arready : out std_logic;
        dsp_cav1_nco_phase_reset_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_nco_phase_reset_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_nco_phase_reset_s_axi_rvalid : out std_logic;
        dsp_cav1_nco_phase_reset_s_axi_rready : in std_logic
    );
end dsp_cav1_nco_phase_reset_axi_lite_interface;
architecture structural of dsp_cav1_nco_phase_reset_axi_lite_interface is 
component dsp_cav1_nco_phase_reset_axi_lite_interface_verilog is
    port(
        cav2_nco_phase_reset : out std_logic_vector(0 downto 0);
        cav1_nco_phase_reset : out std_logic_vector(0 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_nco_phase_reset_aclk : in std_logic;
        dsp_cav1_nco_phase_reset_aresetn : in std_logic;
        dsp_cav1_nco_phase_reset_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav1_nco_phase_reset_s_axi_awvalid : in std_logic;
        dsp_cav1_nco_phase_reset_s_axi_awready : out std_logic;
        dsp_cav1_nco_phase_reset_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_nco_phase_reset_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_nco_phase_reset_s_axi_wvalid : in std_logic;
        dsp_cav1_nco_phase_reset_s_axi_wready : out std_logic;
        dsp_cav1_nco_phase_reset_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_nco_phase_reset_s_axi_bvalid : out std_logic;
        dsp_cav1_nco_phase_reset_s_axi_bready : in std_logic;
        dsp_cav1_nco_phase_reset_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav1_nco_phase_reset_s_axi_arvalid : in std_logic;
        dsp_cav1_nco_phase_reset_s_axi_arready : out std_logic;
        dsp_cav1_nco_phase_reset_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_nco_phase_reset_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_nco_phase_reset_s_axi_rvalid : out std_logic;
        dsp_cav1_nco_phase_reset_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav1_nco_phase_reset_axi_lite_interface_verilog
    port map(
    cav2_nco_phase_reset => cav2_nco_phase_reset,
    cav1_nco_phase_reset => cav1_nco_phase_reset,
    dsp_clk => dsp_clk,
    dsp_cav1_nco_phase_reset_aclk => dsp_cav1_nco_phase_reset_aclk,
    dsp_cav1_nco_phase_reset_aresetn => dsp_cav1_nco_phase_reset_aresetn,
    dsp_cav1_nco_phase_reset_s_axi_awaddr => dsp_cav1_nco_phase_reset_s_axi_awaddr,
    dsp_cav1_nco_phase_reset_s_axi_awvalid => dsp_cav1_nco_phase_reset_s_axi_awvalid,
    dsp_cav1_nco_phase_reset_s_axi_awready => dsp_cav1_nco_phase_reset_s_axi_awready,
    dsp_cav1_nco_phase_reset_s_axi_wdata => dsp_cav1_nco_phase_reset_s_axi_wdata,
    dsp_cav1_nco_phase_reset_s_axi_wstrb => dsp_cav1_nco_phase_reset_s_axi_wstrb,
    dsp_cav1_nco_phase_reset_s_axi_wvalid => dsp_cav1_nco_phase_reset_s_axi_wvalid,
    dsp_cav1_nco_phase_reset_s_axi_wready => dsp_cav1_nco_phase_reset_s_axi_wready,
    dsp_cav1_nco_phase_reset_s_axi_bresp => dsp_cav1_nco_phase_reset_s_axi_bresp,
    dsp_cav1_nco_phase_reset_s_axi_bvalid => dsp_cav1_nco_phase_reset_s_axi_bvalid,
    dsp_cav1_nco_phase_reset_s_axi_bready => dsp_cav1_nco_phase_reset_s_axi_bready,
    dsp_cav1_nco_phase_reset_s_axi_araddr => dsp_cav1_nco_phase_reset_s_axi_araddr,
    dsp_cav1_nco_phase_reset_s_axi_arvalid => dsp_cav1_nco_phase_reset_s_axi_arvalid,
    dsp_cav1_nco_phase_reset_s_axi_arready => dsp_cav1_nco_phase_reset_s_axi_arready,
    dsp_cav1_nco_phase_reset_s_axi_rdata => dsp_cav1_nco_phase_reset_s_axi_rdata,
    dsp_cav1_nco_phase_reset_s_axi_rresp => dsp_cav1_nco_phase_reset_s_axi_rresp,
    dsp_cav1_nco_phase_reset_s_axi_rvalid => dsp_cav1_nco_phase_reset_s_axi_rvalid,
    dsp_cav1_nco_phase_reset_s_axi_rready => dsp_cav1_nco_phase_reset_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav1_p1_chan_sel_axi_lite_interface is 
    port(
        cav1_p1_chan_sel : out std_logic_vector(3 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p1_chan_sel_aclk : in std_logic;
        dsp_cav1_p1_chan_sel_aresetn : in std_logic;
        dsp_cav1_p1_chan_sel_s_axi_awaddr : in std_logic_vector(8-1 downto 0);
        dsp_cav1_p1_chan_sel_s_axi_awvalid : in std_logic;
        dsp_cav1_p1_chan_sel_s_axi_awready : out std_logic;
        dsp_cav1_p1_chan_sel_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p1_chan_sel_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p1_chan_sel_s_axi_wvalid : in std_logic;
        dsp_cav1_p1_chan_sel_s_axi_wready : out std_logic;
        dsp_cav1_p1_chan_sel_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p1_chan_sel_s_axi_bvalid : out std_logic;
        dsp_cav1_p1_chan_sel_s_axi_bready : in std_logic;
        dsp_cav1_p1_chan_sel_s_axi_araddr : in std_logic_vector(8-1 downto 0);
        dsp_cav1_p1_chan_sel_s_axi_arvalid : in std_logic;
        dsp_cav1_p1_chan_sel_s_axi_arready : out std_logic;
        dsp_cav1_p1_chan_sel_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p1_chan_sel_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p1_chan_sel_s_axi_rvalid : out std_logic;
        dsp_cav1_p1_chan_sel_s_axi_rready : in std_logic
    );
end dsp_cav1_p1_chan_sel_axi_lite_interface;
architecture structural of dsp_cav1_p1_chan_sel_axi_lite_interface is 
component dsp_cav1_p1_chan_sel_axi_lite_interface_verilog is
    port(
        cav1_p1_chan_sel : out std_logic_vector(3 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p1_chan_sel_aclk : in std_logic;
        dsp_cav1_p1_chan_sel_aresetn : in std_logic;
        dsp_cav1_p1_chan_sel_s_axi_awaddr : in std_logic_vector(8-1 downto 0);
        dsp_cav1_p1_chan_sel_s_axi_awvalid : in std_logic;
        dsp_cav1_p1_chan_sel_s_axi_awready : out std_logic;
        dsp_cav1_p1_chan_sel_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p1_chan_sel_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p1_chan_sel_s_axi_wvalid : in std_logic;
        dsp_cav1_p1_chan_sel_s_axi_wready : out std_logic;
        dsp_cav1_p1_chan_sel_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p1_chan_sel_s_axi_bvalid : out std_logic;
        dsp_cav1_p1_chan_sel_s_axi_bready : in std_logic;
        dsp_cav1_p1_chan_sel_s_axi_araddr : in std_logic_vector(8-1 downto 0);
        dsp_cav1_p1_chan_sel_s_axi_arvalid : in std_logic;
        dsp_cav1_p1_chan_sel_s_axi_arready : out std_logic;
        dsp_cav1_p1_chan_sel_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p1_chan_sel_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p1_chan_sel_s_axi_rvalid : out std_logic;
        dsp_cav1_p1_chan_sel_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav1_p1_chan_sel_axi_lite_interface_verilog
    port map(
    cav1_p1_chan_sel => cav1_p1_chan_sel,
    dsp_clk => dsp_clk,
    dsp_cav1_p1_chan_sel_aclk => dsp_cav1_p1_chan_sel_aclk,
    dsp_cav1_p1_chan_sel_aresetn => dsp_cav1_p1_chan_sel_aresetn,
    dsp_cav1_p1_chan_sel_s_axi_awaddr => dsp_cav1_p1_chan_sel_s_axi_awaddr,
    dsp_cav1_p1_chan_sel_s_axi_awvalid => dsp_cav1_p1_chan_sel_s_axi_awvalid,
    dsp_cav1_p1_chan_sel_s_axi_awready => dsp_cav1_p1_chan_sel_s_axi_awready,
    dsp_cav1_p1_chan_sel_s_axi_wdata => dsp_cav1_p1_chan_sel_s_axi_wdata,
    dsp_cav1_p1_chan_sel_s_axi_wstrb => dsp_cav1_p1_chan_sel_s_axi_wstrb,
    dsp_cav1_p1_chan_sel_s_axi_wvalid => dsp_cav1_p1_chan_sel_s_axi_wvalid,
    dsp_cav1_p1_chan_sel_s_axi_wready => dsp_cav1_p1_chan_sel_s_axi_wready,
    dsp_cav1_p1_chan_sel_s_axi_bresp => dsp_cav1_p1_chan_sel_s_axi_bresp,
    dsp_cav1_p1_chan_sel_s_axi_bvalid => dsp_cav1_p1_chan_sel_s_axi_bvalid,
    dsp_cav1_p1_chan_sel_s_axi_bready => dsp_cav1_p1_chan_sel_s_axi_bready,
    dsp_cav1_p1_chan_sel_s_axi_araddr => dsp_cav1_p1_chan_sel_s_axi_araddr,
    dsp_cav1_p1_chan_sel_s_axi_arvalid => dsp_cav1_p1_chan_sel_s_axi_arvalid,
    dsp_cav1_p1_chan_sel_s_axi_arready => dsp_cav1_p1_chan_sel_s_axi_arready,
    dsp_cav1_p1_chan_sel_s_axi_rdata => dsp_cav1_p1_chan_sel_s_axi_rdata,
    dsp_cav1_p1_chan_sel_s_axi_rresp => dsp_cav1_p1_chan_sel_s_axi_rresp,
    dsp_cav1_p1_chan_sel_s_axi_rvalid => dsp_cav1_p1_chan_sel_s_axi_rvalid,
    dsp_cav1_p1_chan_sel_s_axi_rready => dsp_cav1_p1_chan_sel_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav1_p1_window_start_axi_lite_interface is 
    port(
        cav1_p1_window_start : out std_logic_vector(15 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p1_window_start_aclk : in std_logic;
        dsp_cav1_p1_window_start_aresetn : in std_logic;
        dsp_cav1_p1_window_start_s_axi_awaddr : in std_logic_vector(8-1 downto 0);
        dsp_cav1_p1_window_start_s_axi_awvalid : in std_logic;
        dsp_cav1_p1_window_start_s_axi_awready : out std_logic;
        dsp_cav1_p1_window_start_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p1_window_start_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p1_window_start_s_axi_wvalid : in std_logic;
        dsp_cav1_p1_window_start_s_axi_wready : out std_logic;
        dsp_cav1_p1_window_start_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p1_window_start_s_axi_bvalid : out std_logic;
        dsp_cav1_p1_window_start_s_axi_bready : in std_logic;
        dsp_cav1_p1_window_start_s_axi_araddr : in std_logic_vector(8-1 downto 0);
        dsp_cav1_p1_window_start_s_axi_arvalid : in std_logic;
        dsp_cav1_p1_window_start_s_axi_arready : out std_logic;
        dsp_cav1_p1_window_start_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p1_window_start_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p1_window_start_s_axi_rvalid : out std_logic;
        dsp_cav1_p1_window_start_s_axi_rready : in std_logic
    );
end dsp_cav1_p1_window_start_axi_lite_interface;
architecture structural of dsp_cav1_p1_window_start_axi_lite_interface is 
component dsp_cav1_p1_window_start_axi_lite_interface_verilog is
    port(
        cav1_p1_window_start : out std_logic_vector(15 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p1_window_start_aclk : in std_logic;
        dsp_cav1_p1_window_start_aresetn : in std_logic;
        dsp_cav1_p1_window_start_s_axi_awaddr : in std_logic_vector(8-1 downto 0);
        dsp_cav1_p1_window_start_s_axi_awvalid : in std_logic;
        dsp_cav1_p1_window_start_s_axi_awready : out std_logic;
        dsp_cav1_p1_window_start_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p1_window_start_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p1_window_start_s_axi_wvalid : in std_logic;
        dsp_cav1_p1_window_start_s_axi_wready : out std_logic;
        dsp_cav1_p1_window_start_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p1_window_start_s_axi_bvalid : out std_logic;
        dsp_cav1_p1_window_start_s_axi_bready : in std_logic;
        dsp_cav1_p1_window_start_s_axi_araddr : in std_logic_vector(8-1 downto 0);
        dsp_cav1_p1_window_start_s_axi_arvalid : in std_logic;
        dsp_cav1_p1_window_start_s_axi_arready : out std_logic;
        dsp_cav1_p1_window_start_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p1_window_start_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p1_window_start_s_axi_rvalid : out std_logic;
        dsp_cav1_p1_window_start_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav1_p1_window_start_axi_lite_interface_verilog
    port map(
    cav1_p1_window_start => cav1_p1_window_start,
    dsp_clk => dsp_clk,
    dsp_cav1_p1_window_start_aclk => dsp_cav1_p1_window_start_aclk,
    dsp_cav1_p1_window_start_aresetn => dsp_cav1_p1_window_start_aresetn,
    dsp_cav1_p1_window_start_s_axi_awaddr => dsp_cav1_p1_window_start_s_axi_awaddr,
    dsp_cav1_p1_window_start_s_axi_awvalid => dsp_cav1_p1_window_start_s_axi_awvalid,
    dsp_cav1_p1_window_start_s_axi_awready => dsp_cav1_p1_window_start_s_axi_awready,
    dsp_cav1_p1_window_start_s_axi_wdata => dsp_cav1_p1_window_start_s_axi_wdata,
    dsp_cav1_p1_window_start_s_axi_wstrb => dsp_cav1_p1_window_start_s_axi_wstrb,
    dsp_cav1_p1_window_start_s_axi_wvalid => dsp_cav1_p1_window_start_s_axi_wvalid,
    dsp_cav1_p1_window_start_s_axi_wready => dsp_cav1_p1_window_start_s_axi_wready,
    dsp_cav1_p1_window_start_s_axi_bresp => dsp_cav1_p1_window_start_s_axi_bresp,
    dsp_cav1_p1_window_start_s_axi_bvalid => dsp_cav1_p1_window_start_s_axi_bvalid,
    dsp_cav1_p1_window_start_s_axi_bready => dsp_cav1_p1_window_start_s_axi_bready,
    dsp_cav1_p1_window_start_s_axi_araddr => dsp_cav1_p1_window_start_s_axi_araddr,
    dsp_cav1_p1_window_start_s_axi_arvalid => dsp_cav1_p1_window_start_s_axi_arvalid,
    dsp_cav1_p1_window_start_s_axi_arready => dsp_cav1_p1_window_start_s_axi_arready,
    dsp_cav1_p1_window_start_s_axi_rdata => dsp_cav1_p1_window_start_s_axi_rdata,
    dsp_cav1_p1_window_start_s_axi_rresp => dsp_cav1_p1_window_start_s_axi_rresp,
    dsp_cav1_p1_window_start_s_axi_rvalid => dsp_cav1_p1_window_start_s_axi_rvalid,
    dsp_cav1_p1_window_start_s_axi_rready => dsp_cav1_p1_window_start_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav1_p1_window_stop_axi_lite_interface is 
    port(
        cav1_p1_window_stop : out std_logic_vector(15 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p1_window_stop_aclk : in std_logic;
        dsp_cav1_p1_window_stop_aresetn : in std_logic;
        dsp_cav1_p1_window_stop_s_axi_awaddr : in std_logic_vector(8-1 downto 0);
        dsp_cav1_p1_window_stop_s_axi_awvalid : in std_logic;
        dsp_cav1_p1_window_stop_s_axi_awready : out std_logic;
        dsp_cav1_p1_window_stop_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p1_window_stop_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p1_window_stop_s_axi_wvalid : in std_logic;
        dsp_cav1_p1_window_stop_s_axi_wready : out std_logic;
        dsp_cav1_p1_window_stop_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p1_window_stop_s_axi_bvalid : out std_logic;
        dsp_cav1_p1_window_stop_s_axi_bready : in std_logic;
        dsp_cav1_p1_window_stop_s_axi_araddr : in std_logic_vector(8-1 downto 0);
        dsp_cav1_p1_window_stop_s_axi_arvalid : in std_logic;
        dsp_cav1_p1_window_stop_s_axi_arready : out std_logic;
        dsp_cav1_p1_window_stop_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p1_window_stop_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p1_window_stop_s_axi_rvalid : out std_logic;
        dsp_cav1_p1_window_stop_s_axi_rready : in std_logic
    );
end dsp_cav1_p1_window_stop_axi_lite_interface;
architecture structural of dsp_cav1_p1_window_stop_axi_lite_interface is 
component dsp_cav1_p1_window_stop_axi_lite_interface_verilog is
    port(
        cav1_p1_window_stop : out std_logic_vector(15 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p1_window_stop_aclk : in std_logic;
        dsp_cav1_p1_window_stop_aresetn : in std_logic;
        dsp_cav1_p1_window_stop_s_axi_awaddr : in std_logic_vector(8-1 downto 0);
        dsp_cav1_p1_window_stop_s_axi_awvalid : in std_logic;
        dsp_cav1_p1_window_stop_s_axi_awready : out std_logic;
        dsp_cav1_p1_window_stop_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p1_window_stop_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p1_window_stop_s_axi_wvalid : in std_logic;
        dsp_cav1_p1_window_stop_s_axi_wready : out std_logic;
        dsp_cav1_p1_window_stop_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p1_window_stop_s_axi_bvalid : out std_logic;
        dsp_cav1_p1_window_stop_s_axi_bready : in std_logic;
        dsp_cav1_p1_window_stop_s_axi_araddr : in std_logic_vector(8-1 downto 0);
        dsp_cav1_p1_window_stop_s_axi_arvalid : in std_logic;
        dsp_cav1_p1_window_stop_s_axi_arready : out std_logic;
        dsp_cav1_p1_window_stop_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p1_window_stop_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p1_window_stop_s_axi_rvalid : out std_logic;
        dsp_cav1_p1_window_stop_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav1_p1_window_stop_axi_lite_interface_verilog
    port map(
    cav1_p1_window_stop => cav1_p1_window_stop,
    dsp_clk => dsp_clk,
    dsp_cav1_p1_window_stop_aclk => dsp_cav1_p1_window_stop_aclk,
    dsp_cav1_p1_window_stop_aresetn => dsp_cav1_p1_window_stop_aresetn,
    dsp_cav1_p1_window_stop_s_axi_awaddr => dsp_cav1_p1_window_stop_s_axi_awaddr,
    dsp_cav1_p1_window_stop_s_axi_awvalid => dsp_cav1_p1_window_stop_s_axi_awvalid,
    dsp_cav1_p1_window_stop_s_axi_awready => dsp_cav1_p1_window_stop_s_axi_awready,
    dsp_cav1_p1_window_stop_s_axi_wdata => dsp_cav1_p1_window_stop_s_axi_wdata,
    dsp_cav1_p1_window_stop_s_axi_wstrb => dsp_cav1_p1_window_stop_s_axi_wstrb,
    dsp_cav1_p1_window_stop_s_axi_wvalid => dsp_cav1_p1_window_stop_s_axi_wvalid,
    dsp_cav1_p1_window_stop_s_axi_wready => dsp_cav1_p1_window_stop_s_axi_wready,
    dsp_cav1_p1_window_stop_s_axi_bresp => dsp_cav1_p1_window_stop_s_axi_bresp,
    dsp_cav1_p1_window_stop_s_axi_bvalid => dsp_cav1_p1_window_stop_s_axi_bvalid,
    dsp_cav1_p1_window_stop_s_axi_bready => dsp_cav1_p1_window_stop_s_axi_bready,
    dsp_cav1_p1_window_stop_s_axi_araddr => dsp_cav1_p1_window_stop_s_axi_araddr,
    dsp_cav1_p1_window_stop_s_axi_arvalid => dsp_cav1_p1_window_stop_s_axi_arvalid,
    dsp_cav1_p1_window_stop_s_axi_arready => dsp_cav1_p1_window_stop_s_axi_arready,
    dsp_cav1_p1_window_stop_s_axi_rdata => dsp_cav1_p1_window_stop_s_axi_rdata,
    dsp_cav1_p1_window_stop_s_axi_rresp => dsp_cav1_p1_window_stop_s_axi_rresp,
    dsp_cav1_p1_window_stop_s_axi_rvalid => dsp_cav1_p1_window_stop_s_axi_rvalid,
    dsp_cav1_p1_window_stop_s_axi_rready => dsp_cav1_p1_window_stop_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav1_p2_amp_out_axi_lite_interface is 
    port(
        cav1_p2_amp_out : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_amp_out_aclk : in std_logic;
        dsp_cav1_p2_amp_out_aresetn : in std_logic;
        dsp_cav1_p2_amp_out_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_amp_out_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_amp_out_s_axi_awready : out std_logic;
        dsp_cav1_p2_amp_out_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_amp_out_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_amp_out_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_amp_out_s_axi_wready : out std_logic;
        dsp_cav1_p2_amp_out_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_amp_out_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_amp_out_s_axi_bready : in std_logic;
        dsp_cav1_p2_amp_out_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_amp_out_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_amp_out_s_axi_arready : out std_logic;
        dsp_cav1_p2_amp_out_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_amp_out_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_amp_out_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_amp_out_s_axi_rready : in std_logic
    );
end dsp_cav1_p2_amp_out_axi_lite_interface;
architecture structural of dsp_cav1_p2_amp_out_axi_lite_interface is 
component dsp_cav1_p2_amp_out_axi_lite_interface_verilog is
    port(
        cav1_p2_amp_out : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_amp_out_aclk : in std_logic;
        dsp_cav1_p2_amp_out_aresetn : in std_logic;
        dsp_cav1_p2_amp_out_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_amp_out_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_amp_out_s_axi_awready : out std_logic;
        dsp_cav1_p2_amp_out_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_amp_out_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_amp_out_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_amp_out_s_axi_wready : out std_logic;
        dsp_cav1_p2_amp_out_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_amp_out_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_amp_out_s_axi_bready : in std_logic;
        dsp_cav1_p2_amp_out_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_amp_out_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_amp_out_s_axi_arready : out std_logic;
        dsp_cav1_p2_amp_out_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_amp_out_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_amp_out_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_amp_out_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav1_p2_amp_out_axi_lite_interface_verilog
    port map(
    cav1_p2_amp_out => cav1_p2_amp_out,
    dsp_clk => dsp_clk,
    dsp_cav1_p2_amp_out_aclk => dsp_cav1_p2_amp_out_aclk,
    dsp_cav1_p2_amp_out_aresetn => dsp_cav1_p2_amp_out_aresetn,
    dsp_cav1_p2_amp_out_s_axi_awaddr => dsp_cav1_p2_amp_out_s_axi_awaddr,
    dsp_cav1_p2_amp_out_s_axi_awvalid => dsp_cav1_p2_amp_out_s_axi_awvalid,
    dsp_cav1_p2_amp_out_s_axi_awready => dsp_cav1_p2_amp_out_s_axi_awready,
    dsp_cav1_p2_amp_out_s_axi_wdata => dsp_cav1_p2_amp_out_s_axi_wdata,
    dsp_cav1_p2_amp_out_s_axi_wstrb => dsp_cav1_p2_amp_out_s_axi_wstrb,
    dsp_cav1_p2_amp_out_s_axi_wvalid => dsp_cav1_p2_amp_out_s_axi_wvalid,
    dsp_cav1_p2_amp_out_s_axi_wready => dsp_cav1_p2_amp_out_s_axi_wready,
    dsp_cav1_p2_amp_out_s_axi_bresp => dsp_cav1_p2_amp_out_s_axi_bresp,
    dsp_cav1_p2_amp_out_s_axi_bvalid => dsp_cav1_p2_amp_out_s_axi_bvalid,
    dsp_cav1_p2_amp_out_s_axi_bready => dsp_cav1_p2_amp_out_s_axi_bready,
    dsp_cav1_p2_amp_out_s_axi_araddr => dsp_cav1_p2_amp_out_s_axi_araddr,
    dsp_cav1_p2_amp_out_s_axi_arvalid => dsp_cav1_p2_amp_out_s_axi_arvalid,
    dsp_cav1_p2_amp_out_s_axi_arready => dsp_cav1_p2_amp_out_s_axi_arready,
    dsp_cav1_p2_amp_out_s_axi_rdata => dsp_cav1_p2_amp_out_s_axi_rdata,
    dsp_cav1_p2_amp_out_s_axi_rresp => dsp_cav1_p2_amp_out_s_axi_rresp,
    dsp_cav1_p2_amp_out_s_axi_rvalid => dsp_cav1_p2_amp_out_s_axi_rvalid,
    dsp_cav1_p2_amp_out_s_axi_rready => dsp_cav1_p2_amp_out_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav1_p2_chan_sel_axi_lite_interface is 
    port(
        cav1_p2_chan_sel : out std_logic_vector(3 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_chan_sel_aclk : in std_logic;
        dsp_cav1_p2_chan_sel_aresetn : in std_logic;
        dsp_cav1_p2_chan_sel_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_chan_sel_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_chan_sel_s_axi_awready : out std_logic;
        dsp_cav1_p2_chan_sel_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_chan_sel_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_chan_sel_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_chan_sel_s_axi_wready : out std_logic;
        dsp_cav1_p2_chan_sel_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_chan_sel_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_chan_sel_s_axi_bready : in std_logic;
        dsp_cav1_p2_chan_sel_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_chan_sel_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_chan_sel_s_axi_arready : out std_logic;
        dsp_cav1_p2_chan_sel_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_chan_sel_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_chan_sel_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_chan_sel_s_axi_rready : in std_logic
    );
end dsp_cav1_p2_chan_sel_axi_lite_interface;
architecture structural of dsp_cav1_p2_chan_sel_axi_lite_interface is 
component dsp_cav1_p2_chan_sel_axi_lite_interface_verilog is
    port(
        cav1_p2_chan_sel : out std_logic_vector(3 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_chan_sel_aclk : in std_logic;
        dsp_cav1_p2_chan_sel_aresetn : in std_logic;
        dsp_cav1_p2_chan_sel_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_chan_sel_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_chan_sel_s_axi_awready : out std_logic;
        dsp_cav1_p2_chan_sel_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_chan_sel_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_chan_sel_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_chan_sel_s_axi_wready : out std_logic;
        dsp_cav1_p2_chan_sel_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_chan_sel_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_chan_sel_s_axi_bready : in std_logic;
        dsp_cav1_p2_chan_sel_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_chan_sel_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_chan_sel_s_axi_arready : out std_logic;
        dsp_cav1_p2_chan_sel_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_chan_sel_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_chan_sel_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_chan_sel_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav1_p2_chan_sel_axi_lite_interface_verilog
    port map(
    cav1_p2_chan_sel => cav1_p2_chan_sel,
    dsp_clk => dsp_clk,
    dsp_cav1_p2_chan_sel_aclk => dsp_cav1_p2_chan_sel_aclk,
    dsp_cav1_p2_chan_sel_aresetn => dsp_cav1_p2_chan_sel_aresetn,
    dsp_cav1_p2_chan_sel_s_axi_awaddr => dsp_cav1_p2_chan_sel_s_axi_awaddr,
    dsp_cav1_p2_chan_sel_s_axi_awvalid => dsp_cav1_p2_chan_sel_s_axi_awvalid,
    dsp_cav1_p2_chan_sel_s_axi_awready => dsp_cav1_p2_chan_sel_s_axi_awready,
    dsp_cav1_p2_chan_sel_s_axi_wdata => dsp_cav1_p2_chan_sel_s_axi_wdata,
    dsp_cav1_p2_chan_sel_s_axi_wstrb => dsp_cav1_p2_chan_sel_s_axi_wstrb,
    dsp_cav1_p2_chan_sel_s_axi_wvalid => dsp_cav1_p2_chan_sel_s_axi_wvalid,
    dsp_cav1_p2_chan_sel_s_axi_wready => dsp_cav1_p2_chan_sel_s_axi_wready,
    dsp_cav1_p2_chan_sel_s_axi_bresp => dsp_cav1_p2_chan_sel_s_axi_bresp,
    dsp_cav1_p2_chan_sel_s_axi_bvalid => dsp_cav1_p2_chan_sel_s_axi_bvalid,
    dsp_cav1_p2_chan_sel_s_axi_bready => dsp_cav1_p2_chan_sel_s_axi_bready,
    dsp_cav1_p2_chan_sel_s_axi_araddr => dsp_cav1_p2_chan_sel_s_axi_araddr,
    dsp_cav1_p2_chan_sel_s_axi_arvalid => dsp_cav1_p2_chan_sel_s_axi_arvalid,
    dsp_cav1_p2_chan_sel_s_axi_arready => dsp_cav1_p2_chan_sel_s_axi_arready,
    dsp_cav1_p2_chan_sel_s_axi_rdata => dsp_cav1_p2_chan_sel_s_axi_rdata,
    dsp_cav1_p2_chan_sel_s_axi_rresp => dsp_cav1_p2_chan_sel_s_axi_rresp,
    dsp_cav1_p2_chan_sel_s_axi_rvalid => dsp_cav1_p2_chan_sel_s_axi_rvalid,
    dsp_cav1_p2_chan_sel_s_axi_rready => dsp_cav1_p2_chan_sel_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav1_p2_comparison_i_axi_lite_interface is 
    port(
        cav1_p2_comparison_i : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_comparison_i_aclk : in std_logic;
        dsp_cav1_p2_comparison_i_aresetn : in std_logic;
        dsp_cav1_p2_comparison_i_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_comparison_i_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_comparison_i_s_axi_awready : out std_logic;
        dsp_cav1_p2_comparison_i_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_comparison_i_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_comparison_i_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_comparison_i_s_axi_wready : out std_logic;
        dsp_cav1_p2_comparison_i_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_comparison_i_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_comparison_i_s_axi_bready : in std_logic;
        dsp_cav1_p2_comparison_i_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_comparison_i_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_comparison_i_s_axi_arready : out std_logic;
        dsp_cav1_p2_comparison_i_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_comparison_i_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_comparison_i_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_comparison_i_s_axi_rready : in std_logic
    );
end dsp_cav1_p2_comparison_i_axi_lite_interface;
architecture structural of dsp_cav1_p2_comparison_i_axi_lite_interface is 
component dsp_cav1_p2_comparison_i_axi_lite_interface_verilog is
    port(
        cav1_p2_comparison_i : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_comparison_i_aclk : in std_logic;
        dsp_cav1_p2_comparison_i_aresetn : in std_logic;
        dsp_cav1_p2_comparison_i_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_comparison_i_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_comparison_i_s_axi_awready : out std_logic;
        dsp_cav1_p2_comparison_i_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_comparison_i_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_comparison_i_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_comparison_i_s_axi_wready : out std_logic;
        dsp_cav1_p2_comparison_i_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_comparison_i_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_comparison_i_s_axi_bready : in std_logic;
        dsp_cav1_p2_comparison_i_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_comparison_i_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_comparison_i_s_axi_arready : out std_logic;
        dsp_cav1_p2_comparison_i_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_comparison_i_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_comparison_i_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_comparison_i_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav1_p2_comparison_i_axi_lite_interface_verilog
    port map(
    cav1_p2_comparison_i => cav1_p2_comparison_i,
    dsp_clk => dsp_clk,
    dsp_cav1_p2_comparison_i_aclk => dsp_cav1_p2_comparison_i_aclk,
    dsp_cav1_p2_comparison_i_aresetn => dsp_cav1_p2_comparison_i_aresetn,
    dsp_cav1_p2_comparison_i_s_axi_awaddr => dsp_cav1_p2_comparison_i_s_axi_awaddr,
    dsp_cav1_p2_comparison_i_s_axi_awvalid => dsp_cav1_p2_comparison_i_s_axi_awvalid,
    dsp_cav1_p2_comparison_i_s_axi_awready => dsp_cav1_p2_comparison_i_s_axi_awready,
    dsp_cav1_p2_comparison_i_s_axi_wdata => dsp_cav1_p2_comparison_i_s_axi_wdata,
    dsp_cav1_p2_comparison_i_s_axi_wstrb => dsp_cav1_p2_comparison_i_s_axi_wstrb,
    dsp_cav1_p2_comparison_i_s_axi_wvalid => dsp_cav1_p2_comparison_i_s_axi_wvalid,
    dsp_cav1_p2_comparison_i_s_axi_wready => dsp_cav1_p2_comparison_i_s_axi_wready,
    dsp_cav1_p2_comparison_i_s_axi_bresp => dsp_cav1_p2_comparison_i_s_axi_bresp,
    dsp_cav1_p2_comparison_i_s_axi_bvalid => dsp_cav1_p2_comparison_i_s_axi_bvalid,
    dsp_cav1_p2_comparison_i_s_axi_bready => dsp_cav1_p2_comparison_i_s_axi_bready,
    dsp_cav1_p2_comparison_i_s_axi_araddr => dsp_cav1_p2_comparison_i_s_axi_araddr,
    dsp_cav1_p2_comparison_i_s_axi_arvalid => dsp_cav1_p2_comparison_i_s_axi_arvalid,
    dsp_cav1_p2_comparison_i_s_axi_arready => dsp_cav1_p2_comparison_i_s_axi_arready,
    dsp_cav1_p2_comparison_i_s_axi_rdata => dsp_cav1_p2_comparison_i_s_axi_rdata,
    dsp_cav1_p2_comparison_i_s_axi_rresp => dsp_cav1_p2_comparison_i_s_axi_rresp,
    dsp_cav1_p2_comparison_i_s_axi_rvalid => dsp_cav1_p2_comparison_i_s_axi_rvalid,
    dsp_cav1_p2_comparison_i_s_axi_rready => dsp_cav1_p2_comparison_i_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav1_p2_comparison_phase_axi_lite_interface is 
    port(
        cav1_p2_comparison_phase : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_comparison_phase_aclk : in std_logic;
        dsp_cav1_p2_comparison_phase_aresetn : in std_logic;
        dsp_cav1_p2_comparison_phase_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_comparison_phase_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_comparison_phase_s_axi_awready : out std_logic;
        dsp_cav1_p2_comparison_phase_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_comparison_phase_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_comparison_phase_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_comparison_phase_s_axi_wready : out std_logic;
        dsp_cav1_p2_comparison_phase_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_comparison_phase_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_comparison_phase_s_axi_bready : in std_logic;
        dsp_cav1_p2_comparison_phase_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_comparison_phase_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_comparison_phase_s_axi_arready : out std_logic;
        dsp_cav1_p2_comparison_phase_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_comparison_phase_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_comparison_phase_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_comparison_phase_s_axi_rready : in std_logic
    );
end dsp_cav1_p2_comparison_phase_axi_lite_interface;
architecture structural of dsp_cav1_p2_comparison_phase_axi_lite_interface is 
component dsp_cav1_p2_comparison_phase_axi_lite_interface_verilog is
    port(
        cav1_p2_comparison_phase : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_comparison_phase_aclk : in std_logic;
        dsp_cav1_p2_comparison_phase_aresetn : in std_logic;
        dsp_cav1_p2_comparison_phase_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_comparison_phase_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_comparison_phase_s_axi_awready : out std_logic;
        dsp_cav1_p2_comparison_phase_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_comparison_phase_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_comparison_phase_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_comparison_phase_s_axi_wready : out std_logic;
        dsp_cav1_p2_comparison_phase_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_comparison_phase_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_comparison_phase_s_axi_bready : in std_logic;
        dsp_cav1_p2_comparison_phase_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_comparison_phase_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_comparison_phase_s_axi_arready : out std_logic;
        dsp_cav1_p2_comparison_phase_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_comparison_phase_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_comparison_phase_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_comparison_phase_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav1_p2_comparison_phase_axi_lite_interface_verilog
    port map(
    cav1_p2_comparison_phase => cav1_p2_comparison_phase,
    dsp_clk => dsp_clk,
    dsp_cav1_p2_comparison_phase_aclk => dsp_cav1_p2_comparison_phase_aclk,
    dsp_cav1_p2_comparison_phase_aresetn => dsp_cav1_p2_comparison_phase_aresetn,
    dsp_cav1_p2_comparison_phase_s_axi_awaddr => dsp_cav1_p2_comparison_phase_s_axi_awaddr,
    dsp_cav1_p2_comparison_phase_s_axi_awvalid => dsp_cav1_p2_comparison_phase_s_axi_awvalid,
    dsp_cav1_p2_comparison_phase_s_axi_awready => dsp_cav1_p2_comparison_phase_s_axi_awready,
    dsp_cav1_p2_comparison_phase_s_axi_wdata => dsp_cav1_p2_comparison_phase_s_axi_wdata,
    dsp_cav1_p2_comparison_phase_s_axi_wstrb => dsp_cav1_p2_comparison_phase_s_axi_wstrb,
    dsp_cav1_p2_comparison_phase_s_axi_wvalid => dsp_cav1_p2_comparison_phase_s_axi_wvalid,
    dsp_cav1_p2_comparison_phase_s_axi_wready => dsp_cav1_p2_comparison_phase_s_axi_wready,
    dsp_cav1_p2_comparison_phase_s_axi_bresp => dsp_cav1_p2_comparison_phase_s_axi_bresp,
    dsp_cav1_p2_comparison_phase_s_axi_bvalid => dsp_cav1_p2_comparison_phase_s_axi_bvalid,
    dsp_cav1_p2_comparison_phase_s_axi_bready => dsp_cav1_p2_comparison_phase_s_axi_bready,
    dsp_cav1_p2_comparison_phase_s_axi_araddr => dsp_cav1_p2_comparison_phase_s_axi_araddr,
    dsp_cav1_p2_comparison_phase_s_axi_arvalid => dsp_cav1_p2_comparison_phase_s_axi_arvalid,
    dsp_cav1_p2_comparison_phase_s_axi_arready => dsp_cav1_p2_comparison_phase_s_axi_arready,
    dsp_cav1_p2_comparison_phase_s_axi_rdata => dsp_cav1_p2_comparison_phase_s_axi_rdata,
    dsp_cav1_p2_comparison_phase_s_axi_rresp => dsp_cav1_p2_comparison_phase_s_axi_rresp,
    dsp_cav1_p2_comparison_phase_s_axi_rvalid => dsp_cav1_p2_comparison_phase_s_axi_rvalid,
    dsp_cav1_p2_comparison_phase_s_axi_rready => dsp_cav1_p2_comparison_phase_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav1_p2_comparison_q_axi_lite_interface is 
    port(
        cav1_p2_comparison_q : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_comparison_q_aclk : in std_logic;
        dsp_cav1_p2_comparison_q_aresetn : in std_logic;
        dsp_cav1_p2_comparison_q_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_comparison_q_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_comparison_q_s_axi_awready : out std_logic;
        dsp_cav1_p2_comparison_q_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_comparison_q_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_comparison_q_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_comparison_q_s_axi_wready : out std_logic;
        dsp_cav1_p2_comparison_q_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_comparison_q_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_comparison_q_s_axi_bready : in std_logic;
        dsp_cav1_p2_comparison_q_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_comparison_q_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_comparison_q_s_axi_arready : out std_logic;
        dsp_cav1_p2_comparison_q_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_comparison_q_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_comparison_q_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_comparison_q_s_axi_rready : in std_logic
    );
end dsp_cav1_p2_comparison_q_axi_lite_interface;
architecture structural of dsp_cav1_p2_comparison_q_axi_lite_interface is 
component dsp_cav1_p2_comparison_q_axi_lite_interface_verilog is
    port(
        cav1_p2_comparison_q : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_comparison_q_aclk : in std_logic;
        dsp_cav1_p2_comparison_q_aresetn : in std_logic;
        dsp_cav1_p2_comparison_q_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_comparison_q_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_comparison_q_s_axi_awready : out std_logic;
        dsp_cav1_p2_comparison_q_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_comparison_q_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_comparison_q_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_comparison_q_s_axi_wready : out std_logic;
        dsp_cav1_p2_comparison_q_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_comparison_q_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_comparison_q_s_axi_bready : in std_logic;
        dsp_cav1_p2_comparison_q_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_comparison_q_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_comparison_q_s_axi_arready : out std_logic;
        dsp_cav1_p2_comparison_q_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_comparison_q_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_comparison_q_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_comparison_q_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav1_p2_comparison_q_axi_lite_interface_verilog
    port map(
    cav1_p2_comparison_q => cav1_p2_comparison_q,
    dsp_clk => dsp_clk,
    dsp_cav1_p2_comparison_q_aclk => dsp_cav1_p2_comparison_q_aclk,
    dsp_cav1_p2_comparison_q_aresetn => dsp_cav1_p2_comparison_q_aresetn,
    dsp_cav1_p2_comparison_q_s_axi_awaddr => dsp_cav1_p2_comparison_q_s_axi_awaddr,
    dsp_cav1_p2_comparison_q_s_axi_awvalid => dsp_cav1_p2_comparison_q_s_axi_awvalid,
    dsp_cav1_p2_comparison_q_s_axi_awready => dsp_cav1_p2_comparison_q_s_axi_awready,
    dsp_cav1_p2_comparison_q_s_axi_wdata => dsp_cav1_p2_comparison_q_s_axi_wdata,
    dsp_cav1_p2_comparison_q_s_axi_wstrb => dsp_cav1_p2_comparison_q_s_axi_wstrb,
    dsp_cav1_p2_comparison_q_s_axi_wvalid => dsp_cav1_p2_comparison_q_s_axi_wvalid,
    dsp_cav1_p2_comparison_q_s_axi_wready => dsp_cav1_p2_comparison_q_s_axi_wready,
    dsp_cav1_p2_comparison_q_s_axi_bresp => dsp_cav1_p2_comparison_q_s_axi_bresp,
    dsp_cav1_p2_comparison_q_s_axi_bvalid => dsp_cav1_p2_comparison_q_s_axi_bvalid,
    dsp_cav1_p2_comparison_q_s_axi_bready => dsp_cav1_p2_comparison_q_s_axi_bready,
    dsp_cav1_p2_comparison_q_s_axi_araddr => dsp_cav1_p2_comparison_q_s_axi_araddr,
    dsp_cav1_p2_comparison_q_s_axi_arvalid => dsp_cav1_p2_comparison_q_s_axi_arvalid,
    dsp_cav1_p2_comparison_q_s_axi_arready => dsp_cav1_p2_comparison_q_s_axi_arready,
    dsp_cav1_p2_comparison_q_s_axi_rdata => dsp_cav1_p2_comparison_q_s_axi_rdata,
    dsp_cav1_p2_comparison_q_s_axi_rresp => dsp_cav1_p2_comparison_q_s_axi_rresp,
    dsp_cav1_p2_comparison_q_s_axi_rvalid => dsp_cav1_p2_comparison_q_s_axi_rvalid,
    dsp_cav1_p2_comparison_q_s_axi_rready => dsp_cav1_p2_comparison_q_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav1_p2_dc_freq_axi_lite_interface is 
    port(
        cav1_p2_dc_freq : in std_logic_vector(25 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_dc_freq_aclk : in std_logic;
        dsp_cav1_p2_dc_freq_aresetn : in std_logic;
        dsp_cav1_p2_dc_freq_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_dc_freq_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_dc_freq_s_axi_awready : out std_logic;
        dsp_cav1_p2_dc_freq_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_dc_freq_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_dc_freq_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_dc_freq_s_axi_wready : out std_logic;
        dsp_cav1_p2_dc_freq_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_dc_freq_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_dc_freq_s_axi_bready : in std_logic;
        dsp_cav1_p2_dc_freq_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_dc_freq_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_dc_freq_s_axi_arready : out std_logic;
        dsp_cav1_p2_dc_freq_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_dc_freq_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_dc_freq_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_dc_freq_s_axi_rready : in std_logic
    );
end dsp_cav1_p2_dc_freq_axi_lite_interface;
architecture structural of dsp_cav1_p2_dc_freq_axi_lite_interface is 
component dsp_cav1_p2_dc_freq_axi_lite_interface_verilog is
    port(
        cav1_p2_dc_freq : in std_logic_vector(25 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_dc_freq_aclk : in std_logic;
        dsp_cav1_p2_dc_freq_aresetn : in std_logic;
        dsp_cav1_p2_dc_freq_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_dc_freq_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_dc_freq_s_axi_awready : out std_logic;
        dsp_cav1_p2_dc_freq_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_dc_freq_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_dc_freq_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_dc_freq_s_axi_wready : out std_logic;
        dsp_cav1_p2_dc_freq_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_dc_freq_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_dc_freq_s_axi_bready : in std_logic;
        dsp_cav1_p2_dc_freq_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_dc_freq_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_dc_freq_s_axi_arready : out std_logic;
        dsp_cav1_p2_dc_freq_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_dc_freq_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_dc_freq_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_dc_freq_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav1_p2_dc_freq_axi_lite_interface_verilog
    port map(
    cav1_p2_dc_freq => cav1_p2_dc_freq,
    dsp_clk => dsp_clk,
    dsp_cav1_p2_dc_freq_aclk => dsp_cav1_p2_dc_freq_aclk,
    dsp_cav1_p2_dc_freq_aresetn => dsp_cav1_p2_dc_freq_aresetn,
    dsp_cav1_p2_dc_freq_s_axi_awaddr => dsp_cav1_p2_dc_freq_s_axi_awaddr,
    dsp_cav1_p2_dc_freq_s_axi_awvalid => dsp_cav1_p2_dc_freq_s_axi_awvalid,
    dsp_cav1_p2_dc_freq_s_axi_awready => dsp_cav1_p2_dc_freq_s_axi_awready,
    dsp_cav1_p2_dc_freq_s_axi_wdata => dsp_cav1_p2_dc_freq_s_axi_wdata,
    dsp_cav1_p2_dc_freq_s_axi_wstrb => dsp_cav1_p2_dc_freq_s_axi_wstrb,
    dsp_cav1_p2_dc_freq_s_axi_wvalid => dsp_cav1_p2_dc_freq_s_axi_wvalid,
    dsp_cav1_p2_dc_freq_s_axi_wready => dsp_cav1_p2_dc_freq_s_axi_wready,
    dsp_cav1_p2_dc_freq_s_axi_bresp => dsp_cav1_p2_dc_freq_s_axi_bresp,
    dsp_cav1_p2_dc_freq_s_axi_bvalid => dsp_cav1_p2_dc_freq_s_axi_bvalid,
    dsp_cav1_p2_dc_freq_s_axi_bready => dsp_cav1_p2_dc_freq_s_axi_bready,
    dsp_cav1_p2_dc_freq_s_axi_araddr => dsp_cav1_p2_dc_freq_s_axi_araddr,
    dsp_cav1_p2_dc_freq_s_axi_arvalid => dsp_cav1_p2_dc_freq_s_axi_arvalid,
    dsp_cav1_p2_dc_freq_s_axi_arready => dsp_cav1_p2_dc_freq_s_axi_arready,
    dsp_cav1_p2_dc_freq_s_axi_rdata => dsp_cav1_p2_dc_freq_s_axi_rdata,
    dsp_cav1_p2_dc_freq_s_axi_rresp => dsp_cav1_p2_dc_freq_s_axi_rresp,
    dsp_cav1_p2_dc_freq_s_axi_rvalid => dsp_cav1_p2_dc_freq_s_axi_rvalid,
    dsp_cav1_p2_dc_freq_s_axi_rready => dsp_cav1_p2_dc_freq_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav1_p2_dc_img_axi_lite_interface is 
    port(
        cav1_p2_dc_img : in std_logic_vector(28 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_dc_img_aclk : in std_logic;
        dsp_cav1_p2_dc_img_aresetn : in std_logic;
        dsp_cav1_p2_dc_img_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_dc_img_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_dc_img_s_axi_awready : out std_logic;
        dsp_cav1_p2_dc_img_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_dc_img_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_dc_img_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_dc_img_s_axi_wready : out std_logic;
        dsp_cav1_p2_dc_img_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_dc_img_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_dc_img_s_axi_bready : in std_logic;
        dsp_cav1_p2_dc_img_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_dc_img_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_dc_img_s_axi_arready : out std_logic;
        dsp_cav1_p2_dc_img_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_dc_img_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_dc_img_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_dc_img_s_axi_rready : in std_logic
    );
end dsp_cav1_p2_dc_img_axi_lite_interface;
architecture structural of dsp_cav1_p2_dc_img_axi_lite_interface is 
component dsp_cav1_p2_dc_img_axi_lite_interface_verilog is
    port(
        cav1_p2_dc_img : in std_logic_vector(28 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_dc_img_aclk : in std_logic;
        dsp_cav1_p2_dc_img_aresetn : in std_logic;
        dsp_cav1_p2_dc_img_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_dc_img_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_dc_img_s_axi_awready : out std_logic;
        dsp_cav1_p2_dc_img_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_dc_img_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_dc_img_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_dc_img_s_axi_wready : out std_logic;
        dsp_cav1_p2_dc_img_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_dc_img_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_dc_img_s_axi_bready : in std_logic;
        dsp_cav1_p2_dc_img_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_dc_img_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_dc_img_s_axi_arready : out std_logic;
        dsp_cav1_p2_dc_img_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_dc_img_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_dc_img_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_dc_img_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav1_p2_dc_img_axi_lite_interface_verilog
    port map(
    cav1_p2_dc_img => cav1_p2_dc_img,
    dsp_clk => dsp_clk,
    dsp_cav1_p2_dc_img_aclk => dsp_cav1_p2_dc_img_aclk,
    dsp_cav1_p2_dc_img_aresetn => dsp_cav1_p2_dc_img_aresetn,
    dsp_cav1_p2_dc_img_s_axi_awaddr => dsp_cav1_p2_dc_img_s_axi_awaddr,
    dsp_cav1_p2_dc_img_s_axi_awvalid => dsp_cav1_p2_dc_img_s_axi_awvalid,
    dsp_cav1_p2_dc_img_s_axi_awready => dsp_cav1_p2_dc_img_s_axi_awready,
    dsp_cav1_p2_dc_img_s_axi_wdata => dsp_cav1_p2_dc_img_s_axi_wdata,
    dsp_cav1_p2_dc_img_s_axi_wstrb => dsp_cav1_p2_dc_img_s_axi_wstrb,
    dsp_cav1_p2_dc_img_s_axi_wvalid => dsp_cav1_p2_dc_img_s_axi_wvalid,
    dsp_cav1_p2_dc_img_s_axi_wready => dsp_cav1_p2_dc_img_s_axi_wready,
    dsp_cav1_p2_dc_img_s_axi_bresp => dsp_cav1_p2_dc_img_s_axi_bresp,
    dsp_cav1_p2_dc_img_s_axi_bvalid => dsp_cav1_p2_dc_img_s_axi_bvalid,
    dsp_cav1_p2_dc_img_s_axi_bready => dsp_cav1_p2_dc_img_s_axi_bready,
    dsp_cav1_p2_dc_img_s_axi_araddr => dsp_cav1_p2_dc_img_s_axi_araddr,
    dsp_cav1_p2_dc_img_s_axi_arvalid => dsp_cav1_p2_dc_img_s_axi_arvalid,
    dsp_cav1_p2_dc_img_s_axi_arready => dsp_cav1_p2_dc_img_s_axi_arready,
    dsp_cav1_p2_dc_img_s_axi_rdata => dsp_cav1_p2_dc_img_s_axi_rdata,
    dsp_cav1_p2_dc_img_s_axi_rresp => dsp_cav1_p2_dc_img_s_axi_rresp,
    dsp_cav1_p2_dc_img_s_axi_rvalid => dsp_cav1_p2_dc_img_s_axi_rvalid,
    dsp_cav1_p2_dc_img_s_axi_rready => dsp_cav1_p2_dc_img_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav1_p2_dc_real_axi_lite_interface is 
    port(
        cav1_p2_dc_real : in std_logic_vector(28 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_dc_real_aclk : in std_logic;
        dsp_cav1_p2_dc_real_aresetn : in std_logic;
        dsp_cav1_p2_dc_real_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_dc_real_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_dc_real_s_axi_awready : out std_logic;
        dsp_cav1_p2_dc_real_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_dc_real_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_dc_real_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_dc_real_s_axi_wready : out std_logic;
        dsp_cav1_p2_dc_real_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_dc_real_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_dc_real_s_axi_bready : in std_logic;
        dsp_cav1_p2_dc_real_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_dc_real_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_dc_real_s_axi_arready : out std_logic;
        dsp_cav1_p2_dc_real_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_dc_real_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_dc_real_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_dc_real_s_axi_rready : in std_logic
    );
end dsp_cav1_p2_dc_real_axi_lite_interface;
architecture structural of dsp_cav1_p2_dc_real_axi_lite_interface is 
component dsp_cav1_p2_dc_real_axi_lite_interface_verilog is
    port(
        cav1_p2_dc_real : in std_logic_vector(28 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_dc_real_aclk : in std_logic;
        dsp_cav1_p2_dc_real_aresetn : in std_logic;
        dsp_cav1_p2_dc_real_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_dc_real_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_dc_real_s_axi_awready : out std_logic;
        dsp_cav1_p2_dc_real_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_dc_real_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_dc_real_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_dc_real_s_axi_wready : out std_logic;
        dsp_cav1_p2_dc_real_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_dc_real_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_dc_real_s_axi_bready : in std_logic;
        dsp_cav1_p2_dc_real_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_dc_real_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_dc_real_s_axi_arready : out std_logic;
        dsp_cav1_p2_dc_real_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_dc_real_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_dc_real_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_dc_real_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav1_p2_dc_real_axi_lite_interface_verilog
    port map(
    cav1_p2_dc_real => cav1_p2_dc_real,
    dsp_clk => dsp_clk,
    dsp_cav1_p2_dc_real_aclk => dsp_cav1_p2_dc_real_aclk,
    dsp_cav1_p2_dc_real_aresetn => dsp_cav1_p2_dc_real_aresetn,
    dsp_cav1_p2_dc_real_s_axi_awaddr => dsp_cav1_p2_dc_real_s_axi_awaddr,
    dsp_cav1_p2_dc_real_s_axi_awvalid => dsp_cav1_p2_dc_real_s_axi_awvalid,
    dsp_cav1_p2_dc_real_s_axi_awready => dsp_cav1_p2_dc_real_s_axi_awready,
    dsp_cav1_p2_dc_real_s_axi_wdata => dsp_cav1_p2_dc_real_s_axi_wdata,
    dsp_cav1_p2_dc_real_s_axi_wstrb => dsp_cav1_p2_dc_real_s_axi_wstrb,
    dsp_cav1_p2_dc_real_s_axi_wvalid => dsp_cav1_p2_dc_real_s_axi_wvalid,
    dsp_cav1_p2_dc_real_s_axi_wready => dsp_cav1_p2_dc_real_s_axi_wready,
    dsp_cav1_p2_dc_real_s_axi_bresp => dsp_cav1_p2_dc_real_s_axi_bresp,
    dsp_cav1_p2_dc_real_s_axi_bvalid => dsp_cav1_p2_dc_real_s_axi_bvalid,
    dsp_cav1_p2_dc_real_s_axi_bready => dsp_cav1_p2_dc_real_s_axi_bready,
    dsp_cav1_p2_dc_real_s_axi_araddr => dsp_cav1_p2_dc_real_s_axi_araddr,
    dsp_cav1_p2_dc_real_s_axi_arvalid => dsp_cav1_p2_dc_real_s_axi_arvalid,
    dsp_cav1_p2_dc_real_s_axi_arready => dsp_cav1_p2_dc_real_s_axi_arready,
    dsp_cav1_p2_dc_real_s_axi_rdata => dsp_cav1_p2_dc_real_s_axi_rdata,
    dsp_cav1_p2_dc_real_s_axi_rresp => dsp_cav1_p2_dc_real_s_axi_rresp,
    dsp_cav1_p2_dc_real_s_axi_rvalid => dsp_cav1_p2_dc_real_s_axi_rvalid,
    dsp_cav1_p2_dc_real_s_axi_rready => dsp_cav1_p2_dc_real_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav1_p2_if_amp_axi_lite_interface is 
    port(
        cav1_p2_if_amp : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_if_amp_aclk : in std_logic;
        dsp_cav1_p2_if_amp_aresetn : in std_logic;
        dsp_cav1_p2_if_amp_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_if_amp_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_if_amp_s_axi_awready : out std_logic;
        dsp_cav1_p2_if_amp_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_if_amp_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_if_amp_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_if_amp_s_axi_wready : out std_logic;
        dsp_cav1_p2_if_amp_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_if_amp_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_if_amp_s_axi_bready : in std_logic;
        dsp_cav1_p2_if_amp_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_if_amp_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_if_amp_s_axi_arready : out std_logic;
        dsp_cav1_p2_if_amp_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_if_amp_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_if_amp_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_if_amp_s_axi_rready : in std_logic
    );
end dsp_cav1_p2_if_amp_axi_lite_interface;
architecture structural of dsp_cav1_p2_if_amp_axi_lite_interface is 
component dsp_cav1_p2_if_amp_axi_lite_interface_verilog is
    port(
        cav1_p2_if_amp : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_if_amp_aclk : in std_logic;
        dsp_cav1_p2_if_amp_aresetn : in std_logic;
        dsp_cav1_p2_if_amp_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_if_amp_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_if_amp_s_axi_awready : out std_logic;
        dsp_cav1_p2_if_amp_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_if_amp_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_if_amp_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_if_amp_s_axi_wready : out std_logic;
        dsp_cav1_p2_if_amp_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_if_amp_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_if_amp_s_axi_bready : in std_logic;
        dsp_cav1_p2_if_amp_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_if_amp_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_if_amp_s_axi_arready : out std_logic;
        dsp_cav1_p2_if_amp_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_if_amp_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_if_amp_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_if_amp_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav1_p2_if_amp_axi_lite_interface_verilog
    port map(
    cav1_p2_if_amp => cav1_p2_if_amp,
    dsp_clk => dsp_clk,
    dsp_cav1_p2_if_amp_aclk => dsp_cav1_p2_if_amp_aclk,
    dsp_cav1_p2_if_amp_aresetn => dsp_cav1_p2_if_amp_aresetn,
    dsp_cav1_p2_if_amp_s_axi_awaddr => dsp_cav1_p2_if_amp_s_axi_awaddr,
    dsp_cav1_p2_if_amp_s_axi_awvalid => dsp_cav1_p2_if_amp_s_axi_awvalid,
    dsp_cav1_p2_if_amp_s_axi_awready => dsp_cav1_p2_if_amp_s_axi_awready,
    dsp_cav1_p2_if_amp_s_axi_wdata => dsp_cav1_p2_if_amp_s_axi_wdata,
    dsp_cav1_p2_if_amp_s_axi_wstrb => dsp_cav1_p2_if_amp_s_axi_wstrb,
    dsp_cav1_p2_if_amp_s_axi_wvalid => dsp_cav1_p2_if_amp_s_axi_wvalid,
    dsp_cav1_p2_if_amp_s_axi_wready => dsp_cav1_p2_if_amp_s_axi_wready,
    dsp_cav1_p2_if_amp_s_axi_bresp => dsp_cav1_p2_if_amp_s_axi_bresp,
    dsp_cav1_p2_if_amp_s_axi_bvalid => dsp_cav1_p2_if_amp_s_axi_bvalid,
    dsp_cav1_p2_if_amp_s_axi_bready => dsp_cav1_p2_if_amp_s_axi_bready,
    dsp_cav1_p2_if_amp_s_axi_araddr => dsp_cav1_p2_if_amp_s_axi_araddr,
    dsp_cav1_p2_if_amp_s_axi_arvalid => dsp_cav1_p2_if_amp_s_axi_arvalid,
    dsp_cav1_p2_if_amp_s_axi_arready => dsp_cav1_p2_if_amp_s_axi_arready,
    dsp_cav1_p2_if_amp_s_axi_rdata => dsp_cav1_p2_if_amp_s_axi_rdata,
    dsp_cav1_p2_if_amp_s_axi_rresp => dsp_cav1_p2_if_amp_s_axi_rresp,
    dsp_cav1_p2_if_amp_s_axi_rvalid => dsp_cav1_p2_if_amp_s_axi_rvalid,
    dsp_cav1_p2_if_amp_s_axi_rready => dsp_cav1_p2_if_amp_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav1_p2_if_i_axi_lite_interface is 
    port(
        cav1_p2_if_i : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_if_i_aclk : in std_logic;
        dsp_cav1_p2_if_i_aresetn : in std_logic;
        dsp_cav1_p2_if_i_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_if_i_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_if_i_s_axi_awready : out std_logic;
        dsp_cav1_p2_if_i_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_if_i_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_if_i_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_if_i_s_axi_wready : out std_logic;
        dsp_cav1_p2_if_i_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_if_i_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_if_i_s_axi_bready : in std_logic;
        dsp_cav1_p2_if_i_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_if_i_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_if_i_s_axi_arready : out std_logic;
        dsp_cav1_p2_if_i_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_if_i_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_if_i_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_if_i_s_axi_rready : in std_logic
    );
end dsp_cav1_p2_if_i_axi_lite_interface;
architecture structural of dsp_cav1_p2_if_i_axi_lite_interface is 
component dsp_cav1_p2_if_i_axi_lite_interface_verilog is
    port(
        cav1_p2_if_i : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_if_i_aclk : in std_logic;
        dsp_cav1_p2_if_i_aresetn : in std_logic;
        dsp_cav1_p2_if_i_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_if_i_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_if_i_s_axi_awready : out std_logic;
        dsp_cav1_p2_if_i_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_if_i_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_if_i_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_if_i_s_axi_wready : out std_logic;
        dsp_cav1_p2_if_i_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_if_i_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_if_i_s_axi_bready : in std_logic;
        dsp_cav1_p2_if_i_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_if_i_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_if_i_s_axi_arready : out std_logic;
        dsp_cav1_p2_if_i_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_if_i_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_if_i_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_if_i_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav1_p2_if_i_axi_lite_interface_verilog
    port map(
    cav1_p2_if_i => cav1_p2_if_i,
    dsp_clk => dsp_clk,
    dsp_cav1_p2_if_i_aclk => dsp_cav1_p2_if_i_aclk,
    dsp_cav1_p2_if_i_aresetn => dsp_cav1_p2_if_i_aresetn,
    dsp_cav1_p2_if_i_s_axi_awaddr => dsp_cav1_p2_if_i_s_axi_awaddr,
    dsp_cav1_p2_if_i_s_axi_awvalid => dsp_cav1_p2_if_i_s_axi_awvalid,
    dsp_cav1_p2_if_i_s_axi_awready => dsp_cav1_p2_if_i_s_axi_awready,
    dsp_cav1_p2_if_i_s_axi_wdata => dsp_cav1_p2_if_i_s_axi_wdata,
    dsp_cav1_p2_if_i_s_axi_wstrb => dsp_cav1_p2_if_i_s_axi_wstrb,
    dsp_cav1_p2_if_i_s_axi_wvalid => dsp_cav1_p2_if_i_s_axi_wvalid,
    dsp_cav1_p2_if_i_s_axi_wready => dsp_cav1_p2_if_i_s_axi_wready,
    dsp_cav1_p2_if_i_s_axi_bresp => dsp_cav1_p2_if_i_s_axi_bresp,
    dsp_cav1_p2_if_i_s_axi_bvalid => dsp_cav1_p2_if_i_s_axi_bvalid,
    dsp_cav1_p2_if_i_s_axi_bready => dsp_cav1_p2_if_i_s_axi_bready,
    dsp_cav1_p2_if_i_s_axi_araddr => dsp_cav1_p2_if_i_s_axi_araddr,
    dsp_cav1_p2_if_i_s_axi_arvalid => dsp_cav1_p2_if_i_s_axi_arvalid,
    dsp_cav1_p2_if_i_s_axi_arready => dsp_cav1_p2_if_i_s_axi_arready,
    dsp_cav1_p2_if_i_s_axi_rdata => dsp_cav1_p2_if_i_s_axi_rdata,
    dsp_cav1_p2_if_i_s_axi_rresp => dsp_cav1_p2_if_i_s_axi_rresp,
    dsp_cav1_p2_if_i_s_axi_rvalid => dsp_cav1_p2_if_i_s_axi_rvalid,
    dsp_cav1_p2_if_i_s_axi_rready => dsp_cav1_p2_if_i_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav1_p2_if_phase_axi_lite_interface is 
    port(
        cav1_p2_if_phase : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_if_phase_aclk : in std_logic;
        dsp_cav1_p2_if_phase_aresetn : in std_logic;
        dsp_cav1_p2_if_phase_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_if_phase_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_if_phase_s_axi_awready : out std_logic;
        dsp_cav1_p2_if_phase_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_if_phase_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_if_phase_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_if_phase_s_axi_wready : out std_logic;
        dsp_cav1_p2_if_phase_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_if_phase_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_if_phase_s_axi_bready : in std_logic;
        dsp_cav1_p2_if_phase_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_if_phase_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_if_phase_s_axi_arready : out std_logic;
        dsp_cav1_p2_if_phase_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_if_phase_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_if_phase_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_if_phase_s_axi_rready : in std_logic
    );
end dsp_cav1_p2_if_phase_axi_lite_interface;
architecture structural of dsp_cav1_p2_if_phase_axi_lite_interface is 
component dsp_cav1_p2_if_phase_axi_lite_interface_verilog is
    port(
        cav1_p2_if_phase : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_if_phase_aclk : in std_logic;
        dsp_cav1_p2_if_phase_aresetn : in std_logic;
        dsp_cav1_p2_if_phase_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_if_phase_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_if_phase_s_axi_awready : out std_logic;
        dsp_cav1_p2_if_phase_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_if_phase_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_if_phase_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_if_phase_s_axi_wready : out std_logic;
        dsp_cav1_p2_if_phase_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_if_phase_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_if_phase_s_axi_bready : in std_logic;
        dsp_cav1_p2_if_phase_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_if_phase_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_if_phase_s_axi_arready : out std_logic;
        dsp_cav1_p2_if_phase_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_if_phase_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_if_phase_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_if_phase_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav1_p2_if_phase_axi_lite_interface_verilog
    port map(
    cav1_p2_if_phase => cav1_p2_if_phase,
    dsp_clk => dsp_clk,
    dsp_cav1_p2_if_phase_aclk => dsp_cav1_p2_if_phase_aclk,
    dsp_cav1_p2_if_phase_aresetn => dsp_cav1_p2_if_phase_aresetn,
    dsp_cav1_p2_if_phase_s_axi_awaddr => dsp_cav1_p2_if_phase_s_axi_awaddr,
    dsp_cav1_p2_if_phase_s_axi_awvalid => dsp_cav1_p2_if_phase_s_axi_awvalid,
    dsp_cav1_p2_if_phase_s_axi_awready => dsp_cav1_p2_if_phase_s_axi_awready,
    dsp_cav1_p2_if_phase_s_axi_wdata => dsp_cav1_p2_if_phase_s_axi_wdata,
    dsp_cav1_p2_if_phase_s_axi_wstrb => dsp_cav1_p2_if_phase_s_axi_wstrb,
    dsp_cav1_p2_if_phase_s_axi_wvalid => dsp_cav1_p2_if_phase_s_axi_wvalid,
    dsp_cav1_p2_if_phase_s_axi_wready => dsp_cav1_p2_if_phase_s_axi_wready,
    dsp_cav1_p2_if_phase_s_axi_bresp => dsp_cav1_p2_if_phase_s_axi_bresp,
    dsp_cav1_p2_if_phase_s_axi_bvalid => dsp_cav1_p2_if_phase_s_axi_bvalid,
    dsp_cav1_p2_if_phase_s_axi_bready => dsp_cav1_p2_if_phase_s_axi_bready,
    dsp_cav1_p2_if_phase_s_axi_araddr => dsp_cav1_p2_if_phase_s_axi_araddr,
    dsp_cav1_p2_if_phase_s_axi_arvalid => dsp_cav1_p2_if_phase_s_axi_arvalid,
    dsp_cav1_p2_if_phase_s_axi_arready => dsp_cav1_p2_if_phase_s_axi_arready,
    dsp_cav1_p2_if_phase_s_axi_rdata => dsp_cav1_p2_if_phase_s_axi_rdata,
    dsp_cav1_p2_if_phase_s_axi_rresp => dsp_cav1_p2_if_phase_s_axi_rresp,
    dsp_cav1_p2_if_phase_s_axi_rvalid => dsp_cav1_p2_if_phase_s_axi_rvalid,
    dsp_cav1_p2_if_phase_s_axi_rready => dsp_cav1_p2_if_phase_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav1_p2_if_q_axi_lite_interface is 
    port(
        cav1_p2_if_q : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_if_q_aclk : in std_logic;
        dsp_cav1_p2_if_q_aresetn : in std_logic;
        dsp_cav1_p2_if_q_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_if_q_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_if_q_s_axi_awready : out std_logic;
        dsp_cav1_p2_if_q_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_if_q_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_if_q_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_if_q_s_axi_wready : out std_logic;
        dsp_cav1_p2_if_q_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_if_q_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_if_q_s_axi_bready : in std_logic;
        dsp_cav1_p2_if_q_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_if_q_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_if_q_s_axi_arready : out std_logic;
        dsp_cav1_p2_if_q_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_if_q_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_if_q_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_if_q_s_axi_rready : in std_logic
    );
end dsp_cav1_p2_if_q_axi_lite_interface;
architecture structural of dsp_cav1_p2_if_q_axi_lite_interface is 
component dsp_cav1_p2_if_q_axi_lite_interface_verilog is
    port(
        cav1_p2_if_q : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_if_q_aclk : in std_logic;
        dsp_cav1_p2_if_q_aresetn : in std_logic;
        dsp_cav1_p2_if_q_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_if_q_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_if_q_s_axi_awready : out std_logic;
        dsp_cav1_p2_if_q_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_if_q_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_if_q_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_if_q_s_axi_wready : out std_logic;
        dsp_cav1_p2_if_q_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_if_q_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_if_q_s_axi_bready : in std_logic;
        dsp_cav1_p2_if_q_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_if_q_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_if_q_s_axi_arready : out std_logic;
        dsp_cav1_p2_if_q_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_if_q_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_if_q_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_if_q_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav1_p2_if_q_axi_lite_interface_verilog
    port map(
    cav1_p2_if_q => cav1_p2_if_q,
    dsp_clk => dsp_clk,
    dsp_cav1_p2_if_q_aclk => dsp_cav1_p2_if_q_aclk,
    dsp_cav1_p2_if_q_aresetn => dsp_cav1_p2_if_q_aresetn,
    dsp_cav1_p2_if_q_s_axi_awaddr => dsp_cav1_p2_if_q_s_axi_awaddr,
    dsp_cav1_p2_if_q_s_axi_awvalid => dsp_cav1_p2_if_q_s_axi_awvalid,
    dsp_cav1_p2_if_q_s_axi_awready => dsp_cav1_p2_if_q_s_axi_awready,
    dsp_cav1_p2_if_q_s_axi_wdata => dsp_cav1_p2_if_q_s_axi_wdata,
    dsp_cav1_p2_if_q_s_axi_wstrb => dsp_cav1_p2_if_q_s_axi_wstrb,
    dsp_cav1_p2_if_q_s_axi_wvalid => dsp_cav1_p2_if_q_s_axi_wvalid,
    dsp_cav1_p2_if_q_s_axi_wready => dsp_cav1_p2_if_q_s_axi_wready,
    dsp_cav1_p2_if_q_s_axi_bresp => dsp_cav1_p2_if_q_s_axi_bresp,
    dsp_cav1_p2_if_q_s_axi_bvalid => dsp_cav1_p2_if_q_s_axi_bvalid,
    dsp_cav1_p2_if_q_s_axi_bready => dsp_cav1_p2_if_q_s_axi_bready,
    dsp_cav1_p2_if_q_s_axi_araddr => dsp_cav1_p2_if_q_s_axi_araddr,
    dsp_cav1_p2_if_q_s_axi_arvalid => dsp_cav1_p2_if_q_s_axi_arvalid,
    dsp_cav1_p2_if_q_s_axi_arready => dsp_cav1_p2_if_q_s_axi_arready,
    dsp_cav1_p2_if_q_s_axi_rdata => dsp_cav1_p2_if_q_s_axi_rdata,
    dsp_cav1_p2_if_q_s_axi_rresp => dsp_cav1_p2_if_q_s_axi_rresp,
    dsp_cav1_p2_if_q_s_axi_rvalid => dsp_cav1_p2_if_q_s_axi_rvalid,
    dsp_cav1_p2_if_q_s_axi_rready => dsp_cav1_p2_if_q_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav1_p2_integrated_i_axi_lite_interface is 
    port(
        cav1_p2_integrated_i : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_integrated_i_aclk : in std_logic;
        dsp_cav1_p2_integrated_i_aresetn : in std_logic;
        dsp_cav1_p2_integrated_i_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_integrated_i_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_integrated_i_s_axi_awready : out std_logic;
        dsp_cav1_p2_integrated_i_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_integrated_i_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_integrated_i_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_integrated_i_s_axi_wready : out std_logic;
        dsp_cav1_p2_integrated_i_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_integrated_i_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_integrated_i_s_axi_bready : in std_logic;
        dsp_cav1_p2_integrated_i_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_integrated_i_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_integrated_i_s_axi_arready : out std_logic;
        dsp_cav1_p2_integrated_i_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_integrated_i_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_integrated_i_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_integrated_i_s_axi_rready : in std_logic
    );
end dsp_cav1_p2_integrated_i_axi_lite_interface;
architecture structural of dsp_cav1_p2_integrated_i_axi_lite_interface is 
component dsp_cav1_p2_integrated_i_axi_lite_interface_verilog is
    port(
        cav1_p2_integrated_i : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_integrated_i_aclk : in std_logic;
        dsp_cav1_p2_integrated_i_aresetn : in std_logic;
        dsp_cav1_p2_integrated_i_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_integrated_i_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_integrated_i_s_axi_awready : out std_logic;
        dsp_cav1_p2_integrated_i_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_integrated_i_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_integrated_i_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_integrated_i_s_axi_wready : out std_logic;
        dsp_cav1_p2_integrated_i_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_integrated_i_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_integrated_i_s_axi_bready : in std_logic;
        dsp_cav1_p2_integrated_i_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_integrated_i_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_integrated_i_s_axi_arready : out std_logic;
        dsp_cav1_p2_integrated_i_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_integrated_i_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_integrated_i_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_integrated_i_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav1_p2_integrated_i_axi_lite_interface_verilog
    port map(
    cav1_p2_integrated_i => cav1_p2_integrated_i,
    dsp_clk => dsp_clk,
    dsp_cav1_p2_integrated_i_aclk => dsp_cav1_p2_integrated_i_aclk,
    dsp_cav1_p2_integrated_i_aresetn => dsp_cav1_p2_integrated_i_aresetn,
    dsp_cav1_p2_integrated_i_s_axi_awaddr => dsp_cav1_p2_integrated_i_s_axi_awaddr,
    dsp_cav1_p2_integrated_i_s_axi_awvalid => dsp_cav1_p2_integrated_i_s_axi_awvalid,
    dsp_cav1_p2_integrated_i_s_axi_awready => dsp_cav1_p2_integrated_i_s_axi_awready,
    dsp_cav1_p2_integrated_i_s_axi_wdata => dsp_cav1_p2_integrated_i_s_axi_wdata,
    dsp_cav1_p2_integrated_i_s_axi_wstrb => dsp_cav1_p2_integrated_i_s_axi_wstrb,
    dsp_cav1_p2_integrated_i_s_axi_wvalid => dsp_cav1_p2_integrated_i_s_axi_wvalid,
    dsp_cav1_p2_integrated_i_s_axi_wready => dsp_cav1_p2_integrated_i_s_axi_wready,
    dsp_cav1_p2_integrated_i_s_axi_bresp => dsp_cav1_p2_integrated_i_s_axi_bresp,
    dsp_cav1_p2_integrated_i_s_axi_bvalid => dsp_cav1_p2_integrated_i_s_axi_bvalid,
    dsp_cav1_p2_integrated_i_s_axi_bready => dsp_cav1_p2_integrated_i_s_axi_bready,
    dsp_cav1_p2_integrated_i_s_axi_araddr => dsp_cav1_p2_integrated_i_s_axi_araddr,
    dsp_cav1_p2_integrated_i_s_axi_arvalid => dsp_cav1_p2_integrated_i_s_axi_arvalid,
    dsp_cav1_p2_integrated_i_s_axi_arready => dsp_cav1_p2_integrated_i_s_axi_arready,
    dsp_cav1_p2_integrated_i_s_axi_rdata => dsp_cav1_p2_integrated_i_s_axi_rdata,
    dsp_cav1_p2_integrated_i_s_axi_rresp => dsp_cav1_p2_integrated_i_s_axi_rresp,
    dsp_cav1_p2_integrated_i_s_axi_rvalid => dsp_cav1_p2_integrated_i_s_axi_rvalid,
    dsp_cav1_p2_integrated_i_s_axi_rready => dsp_cav1_p2_integrated_i_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav1_p2_integrated_q_axi_lite_interface is 
    port(
        cav1_p2_integrated_q : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_integrated_q_aclk : in std_logic;
        dsp_cav1_p2_integrated_q_aresetn : in std_logic;
        dsp_cav1_p2_integrated_q_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_integrated_q_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_integrated_q_s_axi_awready : out std_logic;
        dsp_cav1_p2_integrated_q_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_integrated_q_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_integrated_q_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_integrated_q_s_axi_wready : out std_logic;
        dsp_cav1_p2_integrated_q_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_integrated_q_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_integrated_q_s_axi_bready : in std_logic;
        dsp_cav1_p2_integrated_q_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_integrated_q_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_integrated_q_s_axi_arready : out std_logic;
        dsp_cav1_p2_integrated_q_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_integrated_q_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_integrated_q_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_integrated_q_s_axi_rready : in std_logic
    );
end dsp_cav1_p2_integrated_q_axi_lite_interface;
architecture structural of dsp_cav1_p2_integrated_q_axi_lite_interface is 
component dsp_cav1_p2_integrated_q_axi_lite_interface_verilog is
    port(
        cav1_p2_integrated_q : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_integrated_q_aclk : in std_logic;
        dsp_cav1_p2_integrated_q_aresetn : in std_logic;
        dsp_cav1_p2_integrated_q_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_integrated_q_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_integrated_q_s_axi_awready : out std_logic;
        dsp_cav1_p2_integrated_q_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_integrated_q_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_integrated_q_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_integrated_q_s_axi_wready : out std_logic;
        dsp_cav1_p2_integrated_q_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_integrated_q_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_integrated_q_s_axi_bready : in std_logic;
        dsp_cav1_p2_integrated_q_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_integrated_q_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_integrated_q_s_axi_arready : out std_logic;
        dsp_cav1_p2_integrated_q_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_integrated_q_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_integrated_q_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_integrated_q_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav1_p2_integrated_q_axi_lite_interface_verilog
    port map(
    cav1_p2_integrated_q => cav1_p2_integrated_q,
    dsp_clk => dsp_clk,
    dsp_cav1_p2_integrated_q_aclk => dsp_cav1_p2_integrated_q_aclk,
    dsp_cav1_p2_integrated_q_aresetn => dsp_cav1_p2_integrated_q_aresetn,
    dsp_cav1_p2_integrated_q_s_axi_awaddr => dsp_cav1_p2_integrated_q_s_axi_awaddr,
    dsp_cav1_p2_integrated_q_s_axi_awvalid => dsp_cav1_p2_integrated_q_s_axi_awvalid,
    dsp_cav1_p2_integrated_q_s_axi_awready => dsp_cav1_p2_integrated_q_s_axi_awready,
    dsp_cav1_p2_integrated_q_s_axi_wdata => dsp_cav1_p2_integrated_q_s_axi_wdata,
    dsp_cav1_p2_integrated_q_s_axi_wstrb => dsp_cav1_p2_integrated_q_s_axi_wstrb,
    dsp_cav1_p2_integrated_q_s_axi_wvalid => dsp_cav1_p2_integrated_q_s_axi_wvalid,
    dsp_cav1_p2_integrated_q_s_axi_wready => dsp_cav1_p2_integrated_q_s_axi_wready,
    dsp_cav1_p2_integrated_q_s_axi_bresp => dsp_cav1_p2_integrated_q_s_axi_bresp,
    dsp_cav1_p2_integrated_q_s_axi_bvalid => dsp_cav1_p2_integrated_q_s_axi_bvalid,
    dsp_cav1_p2_integrated_q_s_axi_bready => dsp_cav1_p2_integrated_q_s_axi_bready,
    dsp_cav1_p2_integrated_q_s_axi_araddr => dsp_cav1_p2_integrated_q_s_axi_araddr,
    dsp_cav1_p2_integrated_q_s_axi_arvalid => dsp_cav1_p2_integrated_q_s_axi_arvalid,
    dsp_cav1_p2_integrated_q_s_axi_arready => dsp_cav1_p2_integrated_q_s_axi_arready,
    dsp_cav1_p2_integrated_q_s_axi_rdata => dsp_cav1_p2_integrated_q_s_axi_rdata,
    dsp_cav1_p2_integrated_q_s_axi_rresp => dsp_cav1_p2_integrated_q_s_axi_rresp,
    dsp_cav1_p2_integrated_q_s_axi_rvalid => dsp_cav1_p2_integrated_q_s_axi_rvalid,
    dsp_cav1_p2_integrated_q_s_axi_rready => dsp_cav1_p2_integrated_q_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav1_p2_phase_out_axi_lite_interface is 
    port(
        cav1_p2_phase_out : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_phase_out_aclk : in std_logic;
        dsp_cav1_p2_phase_out_aresetn : in std_logic;
        dsp_cav1_p2_phase_out_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_phase_out_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_phase_out_s_axi_awready : out std_logic;
        dsp_cav1_p2_phase_out_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_phase_out_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_phase_out_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_phase_out_s_axi_wready : out std_logic;
        dsp_cav1_p2_phase_out_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_phase_out_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_phase_out_s_axi_bready : in std_logic;
        dsp_cav1_p2_phase_out_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_phase_out_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_phase_out_s_axi_arready : out std_logic;
        dsp_cav1_p2_phase_out_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_phase_out_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_phase_out_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_phase_out_s_axi_rready : in std_logic
    );
end dsp_cav1_p2_phase_out_axi_lite_interface;
architecture structural of dsp_cav1_p2_phase_out_axi_lite_interface is 
component dsp_cav1_p2_phase_out_axi_lite_interface_verilog is
    port(
        cav1_p2_phase_out : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_phase_out_aclk : in std_logic;
        dsp_cav1_p2_phase_out_aresetn : in std_logic;
        dsp_cav1_p2_phase_out_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_phase_out_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_phase_out_s_axi_awready : out std_logic;
        dsp_cav1_p2_phase_out_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_phase_out_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_phase_out_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_phase_out_s_axi_wready : out std_logic;
        dsp_cav1_p2_phase_out_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_phase_out_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_phase_out_s_axi_bready : in std_logic;
        dsp_cav1_p2_phase_out_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_phase_out_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_phase_out_s_axi_arready : out std_logic;
        dsp_cav1_p2_phase_out_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_phase_out_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_phase_out_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_phase_out_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav1_p2_phase_out_axi_lite_interface_verilog
    port map(
    cav1_p2_phase_out => cav1_p2_phase_out,
    dsp_clk => dsp_clk,
    dsp_cav1_p2_phase_out_aclk => dsp_cav1_p2_phase_out_aclk,
    dsp_cav1_p2_phase_out_aresetn => dsp_cav1_p2_phase_out_aresetn,
    dsp_cav1_p2_phase_out_s_axi_awaddr => dsp_cav1_p2_phase_out_s_axi_awaddr,
    dsp_cav1_p2_phase_out_s_axi_awvalid => dsp_cav1_p2_phase_out_s_axi_awvalid,
    dsp_cav1_p2_phase_out_s_axi_awready => dsp_cav1_p2_phase_out_s_axi_awready,
    dsp_cav1_p2_phase_out_s_axi_wdata => dsp_cav1_p2_phase_out_s_axi_wdata,
    dsp_cav1_p2_phase_out_s_axi_wstrb => dsp_cav1_p2_phase_out_s_axi_wstrb,
    dsp_cav1_p2_phase_out_s_axi_wvalid => dsp_cav1_p2_phase_out_s_axi_wvalid,
    dsp_cav1_p2_phase_out_s_axi_wready => dsp_cav1_p2_phase_out_s_axi_wready,
    dsp_cav1_p2_phase_out_s_axi_bresp => dsp_cav1_p2_phase_out_s_axi_bresp,
    dsp_cav1_p2_phase_out_s_axi_bvalid => dsp_cav1_p2_phase_out_s_axi_bvalid,
    dsp_cav1_p2_phase_out_s_axi_bready => dsp_cav1_p2_phase_out_s_axi_bready,
    dsp_cav1_p2_phase_out_s_axi_araddr => dsp_cav1_p2_phase_out_s_axi_araddr,
    dsp_cav1_p2_phase_out_s_axi_arvalid => dsp_cav1_p2_phase_out_s_axi_arvalid,
    dsp_cav1_p2_phase_out_s_axi_arready => dsp_cav1_p2_phase_out_s_axi_arready,
    dsp_cav1_p2_phase_out_s_axi_rdata => dsp_cav1_p2_phase_out_s_axi_rdata,
    dsp_cav1_p2_phase_out_s_axi_rresp => dsp_cav1_p2_phase_out_s_axi_rresp,
    dsp_cav1_p2_phase_out_s_axi_rvalid => dsp_cav1_p2_phase_out_s_axi_rvalid,
    dsp_cav1_p2_phase_out_s_axi_rready => dsp_cav1_p2_phase_out_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav1_p2_window_start_axi_lite_interface is 
    port(
        cav1_p2_window_start : out std_logic_vector(15 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_window_start_aclk : in std_logic;
        dsp_cav1_p2_window_start_aresetn : in std_logic;
        dsp_cav1_p2_window_start_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_window_start_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_window_start_s_axi_awready : out std_logic;
        dsp_cav1_p2_window_start_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_window_start_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_window_start_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_window_start_s_axi_wready : out std_logic;
        dsp_cav1_p2_window_start_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_window_start_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_window_start_s_axi_bready : in std_logic;
        dsp_cav1_p2_window_start_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_window_start_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_window_start_s_axi_arready : out std_logic;
        dsp_cav1_p2_window_start_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_window_start_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_window_start_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_window_start_s_axi_rready : in std_logic
    );
end dsp_cav1_p2_window_start_axi_lite_interface;
architecture structural of dsp_cav1_p2_window_start_axi_lite_interface is 
component dsp_cav1_p2_window_start_axi_lite_interface_verilog is
    port(
        cav1_p2_window_start : out std_logic_vector(15 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_window_start_aclk : in std_logic;
        dsp_cav1_p2_window_start_aresetn : in std_logic;
        dsp_cav1_p2_window_start_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_window_start_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_window_start_s_axi_awready : out std_logic;
        dsp_cav1_p2_window_start_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_window_start_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_window_start_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_window_start_s_axi_wready : out std_logic;
        dsp_cav1_p2_window_start_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_window_start_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_window_start_s_axi_bready : in std_logic;
        dsp_cav1_p2_window_start_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_window_start_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_window_start_s_axi_arready : out std_logic;
        dsp_cav1_p2_window_start_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_window_start_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_window_start_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_window_start_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav1_p2_window_start_axi_lite_interface_verilog
    port map(
    cav1_p2_window_start => cav1_p2_window_start,
    dsp_clk => dsp_clk,
    dsp_cav1_p2_window_start_aclk => dsp_cav1_p2_window_start_aclk,
    dsp_cav1_p2_window_start_aresetn => dsp_cav1_p2_window_start_aresetn,
    dsp_cav1_p2_window_start_s_axi_awaddr => dsp_cav1_p2_window_start_s_axi_awaddr,
    dsp_cav1_p2_window_start_s_axi_awvalid => dsp_cav1_p2_window_start_s_axi_awvalid,
    dsp_cav1_p2_window_start_s_axi_awready => dsp_cav1_p2_window_start_s_axi_awready,
    dsp_cav1_p2_window_start_s_axi_wdata => dsp_cav1_p2_window_start_s_axi_wdata,
    dsp_cav1_p2_window_start_s_axi_wstrb => dsp_cav1_p2_window_start_s_axi_wstrb,
    dsp_cav1_p2_window_start_s_axi_wvalid => dsp_cav1_p2_window_start_s_axi_wvalid,
    dsp_cav1_p2_window_start_s_axi_wready => dsp_cav1_p2_window_start_s_axi_wready,
    dsp_cav1_p2_window_start_s_axi_bresp => dsp_cav1_p2_window_start_s_axi_bresp,
    dsp_cav1_p2_window_start_s_axi_bvalid => dsp_cav1_p2_window_start_s_axi_bvalid,
    dsp_cav1_p2_window_start_s_axi_bready => dsp_cav1_p2_window_start_s_axi_bready,
    dsp_cav1_p2_window_start_s_axi_araddr => dsp_cav1_p2_window_start_s_axi_araddr,
    dsp_cav1_p2_window_start_s_axi_arvalid => dsp_cav1_p2_window_start_s_axi_arvalid,
    dsp_cav1_p2_window_start_s_axi_arready => dsp_cav1_p2_window_start_s_axi_arready,
    dsp_cav1_p2_window_start_s_axi_rdata => dsp_cav1_p2_window_start_s_axi_rdata,
    dsp_cav1_p2_window_start_s_axi_rresp => dsp_cav1_p2_window_start_s_axi_rresp,
    dsp_cav1_p2_window_start_s_axi_rvalid => dsp_cav1_p2_window_start_s_axi_rvalid,
    dsp_cav1_p2_window_start_s_axi_rready => dsp_cav1_p2_window_start_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav1_p2_window_stop_axi_lite_interface is 
    port(
        cav1_p2_window_stop : out std_logic_vector(15 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_window_stop_aclk : in std_logic;
        dsp_cav1_p2_window_stop_aresetn : in std_logic;
        dsp_cav1_p2_window_stop_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_window_stop_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_window_stop_s_axi_awready : out std_logic;
        dsp_cav1_p2_window_stop_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_window_stop_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_window_stop_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_window_stop_s_axi_wready : out std_logic;
        dsp_cav1_p2_window_stop_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_window_stop_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_window_stop_s_axi_bready : in std_logic;
        dsp_cav1_p2_window_stop_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_window_stop_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_window_stop_s_axi_arready : out std_logic;
        dsp_cav1_p2_window_stop_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_window_stop_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_window_stop_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_window_stop_s_axi_rready : in std_logic
    );
end dsp_cav1_p2_window_stop_axi_lite_interface;
architecture structural of dsp_cav1_p2_window_stop_axi_lite_interface is 
component dsp_cav1_p2_window_stop_axi_lite_interface_verilog is
    port(
        cav1_p2_window_stop : out std_logic_vector(15 downto 0);
        dsp_clk : out std_logic;
        dsp_cav1_p2_window_stop_aclk : in std_logic;
        dsp_cav1_p2_window_stop_aresetn : in std_logic;
        dsp_cav1_p2_window_stop_s_axi_awaddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_window_stop_s_axi_awvalid : in std_logic;
        dsp_cav1_p2_window_stop_s_axi_awready : out std_logic;
        dsp_cav1_p2_window_stop_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_window_stop_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav1_p2_window_stop_s_axi_wvalid : in std_logic;
        dsp_cav1_p2_window_stop_s_axi_wready : out std_logic;
        dsp_cav1_p2_window_stop_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_window_stop_s_axi_bvalid : out std_logic;
        dsp_cav1_p2_window_stop_s_axi_bready : in std_logic;
        dsp_cav1_p2_window_stop_s_axi_araddr : in std_logic_vector(9-1 downto 0);
        dsp_cav1_p2_window_stop_s_axi_arvalid : in std_logic;
        dsp_cav1_p2_window_stop_s_axi_arready : out std_logic;
        dsp_cav1_p2_window_stop_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav1_p2_window_stop_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav1_p2_window_stop_s_axi_rvalid : out std_logic;
        dsp_cav1_p2_window_stop_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav1_p2_window_stop_axi_lite_interface_verilog
    port map(
    cav1_p2_window_stop => cav1_p2_window_stop,
    dsp_clk => dsp_clk,
    dsp_cav1_p2_window_stop_aclk => dsp_cav1_p2_window_stop_aclk,
    dsp_cav1_p2_window_stop_aresetn => dsp_cav1_p2_window_stop_aresetn,
    dsp_cav1_p2_window_stop_s_axi_awaddr => dsp_cav1_p2_window_stop_s_axi_awaddr,
    dsp_cav1_p2_window_stop_s_axi_awvalid => dsp_cav1_p2_window_stop_s_axi_awvalid,
    dsp_cav1_p2_window_stop_s_axi_awready => dsp_cav1_p2_window_stop_s_axi_awready,
    dsp_cav1_p2_window_stop_s_axi_wdata => dsp_cav1_p2_window_stop_s_axi_wdata,
    dsp_cav1_p2_window_stop_s_axi_wstrb => dsp_cav1_p2_window_stop_s_axi_wstrb,
    dsp_cav1_p2_window_stop_s_axi_wvalid => dsp_cav1_p2_window_stop_s_axi_wvalid,
    dsp_cav1_p2_window_stop_s_axi_wready => dsp_cav1_p2_window_stop_s_axi_wready,
    dsp_cav1_p2_window_stop_s_axi_bresp => dsp_cav1_p2_window_stop_s_axi_bresp,
    dsp_cav1_p2_window_stop_s_axi_bvalid => dsp_cav1_p2_window_stop_s_axi_bvalid,
    dsp_cav1_p2_window_stop_s_axi_bready => dsp_cav1_p2_window_stop_s_axi_bready,
    dsp_cav1_p2_window_stop_s_axi_araddr => dsp_cav1_p2_window_stop_s_axi_araddr,
    dsp_cav1_p2_window_stop_s_axi_arvalid => dsp_cav1_p2_window_stop_s_axi_arvalid,
    dsp_cav1_p2_window_stop_s_axi_arready => dsp_cav1_p2_window_stop_s_axi_arready,
    dsp_cav1_p2_window_stop_s_axi_rdata => dsp_cav1_p2_window_stop_s_axi_rdata,
    dsp_cav1_p2_window_stop_s_axi_rresp => dsp_cav1_p2_window_stop_s_axi_rresp,
    dsp_cav1_p2_window_stop_s_axi_rvalid => dsp_cav1_p2_window_stop_s_axi_rvalid,
    dsp_cav1_p2_window_stop_s_axi_rready => dsp_cav1_p2_window_stop_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p1_amp_out_axi_lite_interface is 
    port(
        cav2_p1_amp_out : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_amp_out_aclk : in std_logic;
        dsp_cav2_p1_amp_out_aresetn : in std_logic;
        dsp_cav2_p1_amp_out_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_amp_out_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_amp_out_s_axi_awready : out std_logic;
        dsp_cav2_p1_amp_out_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_amp_out_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_amp_out_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_amp_out_s_axi_wready : out std_logic;
        dsp_cav2_p1_amp_out_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_amp_out_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_amp_out_s_axi_bready : in std_logic;
        dsp_cav2_p1_amp_out_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_amp_out_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_amp_out_s_axi_arready : out std_logic;
        dsp_cav2_p1_amp_out_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_amp_out_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_amp_out_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_amp_out_s_axi_rready : in std_logic
    );
end dsp_cav2_p1_amp_out_axi_lite_interface;
architecture structural of dsp_cav2_p1_amp_out_axi_lite_interface is 
component dsp_cav2_p1_amp_out_axi_lite_interface_verilog is
    port(
        cav2_p1_amp_out : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_amp_out_aclk : in std_logic;
        dsp_cav2_p1_amp_out_aresetn : in std_logic;
        dsp_cav2_p1_amp_out_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_amp_out_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_amp_out_s_axi_awready : out std_logic;
        dsp_cav2_p1_amp_out_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_amp_out_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_amp_out_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_amp_out_s_axi_wready : out std_logic;
        dsp_cav2_p1_amp_out_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_amp_out_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_amp_out_s_axi_bready : in std_logic;
        dsp_cav2_p1_amp_out_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_amp_out_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_amp_out_s_axi_arready : out std_logic;
        dsp_cav2_p1_amp_out_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_amp_out_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_amp_out_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_amp_out_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p1_amp_out_axi_lite_interface_verilog
    port map(
    cav2_p1_amp_out => cav2_p1_amp_out,
    dsp_clk => dsp_clk,
    dsp_cav2_p1_amp_out_aclk => dsp_cav2_p1_amp_out_aclk,
    dsp_cav2_p1_amp_out_aresetn => dsp_cav2_p1_amp_out_aresetn,
    dsp_cav2_p1_amp_out_s_axi_awaddr => dsp_cav2_p1_amp_out_s_axi_awaddr,
    dsp_cav2_p1_amp_out_s_axi_awvalid => dsp_cav2_p1_amp_out_s_axi_awvalid,
    dsp_cav2_p1_amp_out_s_axi_awready => dsp_cav2_p1_amp_out_s_axi_awready,
    dsp_cav2_p1_amp_out_s_axi_wdata => dsp_cav2_p1_amp_out_s_axi_wdata,
    dsp_cav2_p1_amp_out_s_axi_wstrb => dsp_cav2_p1_amp_out_s_axi_wstrb,
    dsp_cav2_p1_amp_out_s_axi_wvalid => dsp_cav2_p1_amp_out_s_axi_wvalid,
    dsp_cav2_p1_amp_out_s_axi_wready => dsp_cav2_p1_amp_out_s_axi_wready,
    dsp_cav2_p1_amp_out_s_axi_bresp => dsp_cav2_p1_amp_out_s_axi_bresp,
    dsp_cav2_p1_amp_out_s_axi_bvalid => dsp_cav2_p1_amp_out_s_axi_bvalid,
    dsp_cav2_p1_amp_out_s_axi_bready => dsp_cav2_p1_amp_out_s_axi_bready,
    dsp_cav2_p1_amp_out_s_axi_araddr => dsp_cav2_p1_amp_out_s_axi_araddr,
    dsp_cav2_p1_amp_out_s_axi_arvalid => dsp_cav2_p1_amp_out_s_axi_arvalid,
    dsp_cav2_p1_amp_out_s_axi_arready => dsp_cav2_p1_amp_out_s_axi_arready,
    dsp_cav2_p1_amp_out_s_axi_rdata => dsp_cav2_p1_amp_out_s_axi_rdata,
    dsp_cav2_p1_amp_out_s_axi_rresp => dsp_cav2_p1_amp_out_s_axi_rresp,
    dsp_cav2_p1_amp_out_s_axi_rvalid => dsp_cav2_p1_amp_out_s_axi_rvalid,
    dsp_cav2_p1_amp_out_s_axi_rready => dsp_cav2_p1_amp_out_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p1_chan_sel_axi_lite_interface is 
    port(
        cav2_p1_chan_sel : out std_logic_vector(3 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_chan_sel_aclk : in std_logic;
        dsp_cav2_p1_chan_sel_aresetn : in std_logic;
        dsp_cav2_p1_chan_sel_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_chan_sel_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_chan_sel_s_axi_awready : out std_logic;
        dsp_cav2_p1_chan_sel_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_chan_sel_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_chan_sel_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_chan_sel_s_axi_wready : out std_logic;
        dsp_cav2_p1_chan_sel_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_chan_sel_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_chan_sel_s_axi_bready : in std_logic;
        dsp_cav2_p1_chan_sel_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_chan_sel_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_chan_sel_s_axi_arready : out std_logic;
        dsp_cav2_p1_chan_sel_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_chan_sel_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_chan_sel_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_chan_sel_s_axi_rready : in std_logic
    );
end dsp_cav2_p1_chan_sel_axi_lite_interface;
architecture structural of dsp_cav2_p1_chan_sel_axi_lite_interface is 
component dsp_cav2_p1_chan_sel_axi_lite_interface_verilog is
    port(
        cav2_p1_chan_sel : out std_logic_vector(3 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_chan_sel_aclk : in std_logic;
        dsp_cav2_p1_chan_sel_aresetn : in std_logic;
        dsp_cav2_p1_chan_sel_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_chan_sel_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_chan_sel_s_axi_awready : out std_logic;
        dsp_cav2_p1_chan_sel_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_chan_sel_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_chan_sel_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_chan_sel_s_axi_wready : out std_logic;
        dsp_cav2_p1_chan_sel_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_chan_sel_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_chan_sel_s_axi_bready : in std_logic;
        dsp_cav2_p1_chan_sel_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_chan_sel_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_chan_sel_s_axi_arready : out std_logic;
        dsp_cav2_p1_chan_sel_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_chan_sel_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_chan_sel_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_chan_sel_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p1_chan_sel_axi_lite_interface_verilog
    port map(
    cav2_p1_chan_sel => cav2_p1_chan_sel,
    dsp_clk => dsp_clk,
    dsp_cav2_p1_chan_sel_aclk => dsp_cav2_p1_chan_sel_aclk,
    dsp_cav2_p1_chan_sel_aresetn => dsp_cav2_p1_chan_sel_aresetn,
    dsp_cav2_p1_chan_sel_s_axi_awaddr => dsp_cav2_p1_chan_sel_s_axi_awaddr,
    dsp_cav2_p1_chan_sel_s_axi_awvalid => dsp_cav2_p1_chan_sel_s_axi_awvalid,
    dsp_cav2_p1_chan_sel_s_axi_awready => dsp_cav2_p1_chan_sel_s_axi_awready,
    dsp_cav2_p1_chan_sel_s_axi_wdata => dsp_cav2_p1_chan_sel_s_axi_wdata,
    dsp_cav2_p1_chan_sel_s_axi_wstrb => dsp_cav2_p1_chan_sel_s_axi_wstrb,
    dsp_cav2_p1_chan_sel_s_axi_wvalid => dsp_cav2_p1_chan_sel_s_axi_wvalid,
    dsp_cav2_p1_chan_sel_s_axi_wready => dsp_cav2_p1_chan_sel_s_axi_wready,
    dsp_cav2_p1_chan_sel_s_axi_bresp => dsp_cav2_p1_chan_sel_s_axi_bresp,
    dsp_cav2_p1_chan_sel_s_axi_bvalid => dsp_cav2_p1_chan_sel_s_axi_bvalid,
    dsp_cav2_p1_chan_sel_s_axi_bready => dsp_cav2_p1_chan_sel_s_axi_bready,
    dsp_cav2_p1_chan_sel_s_axi_araddr => dsp_cav2_p1_chan_sel_s_axi_araddr,
    dsp_cav2_p1_chan_sel_s_axi_arvalid => dsp_cav2_p1_chan_sel_s_axi_arvalid,
    dsp_cav2_p1_chan_sel_s_axi_arready => dsp_cav2_p1_chan_sel_s_axi_arready,
    dsp_cav2_p1_chan_sel_s_axi_rdata => dsp_cav2_p1_chan_sel_s_axi_rdata,
    dsp_cav2_p1_chan_sel_s_axi_rresp => dsp_cav2_p1_chan_sel_s_axi_rresp,
    dsp_cav2_p1_chan_sel_s_axi_rvalid => dsp_cav2_p1_chan_sel_s_axi_rvalid,
    dsp_cav2_p1_chan_sel_s_axi_rready => dsp_cav2_p1_chan_sel_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p1_comparison_i_axi_lite_interface is 
    port(
        cav2_p1_comparison_i : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_comparison_i_aclk : in std_logic;
        dsp_cav2_p1_comparison_i_aresetn : in std_logic;
        dsp_cav2_p1_comparison_i_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_comparison_i_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_comparison_i_s_axi_awready : out std_logic;
        dsp_cav2_p1_comparison_i_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_comparison_i_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_comparison_i_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_comparison_i_s_axi_wready : out std_logic;
        dsp_cav2_p1_comparison_i_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_comparison_i_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_comparison_i_s_axi_bready : in std_logic;
        dsp_cav2_p1_comparison_i_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_comparison_i_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_comparison_i_s_axi_arready : out std_logic;
        dsp_cav2_p1_comparison_i_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_comparison_i_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_comparison_i_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_comparison_i_s_axi_rready : in std_logic
    );
end dsp_cav2_p1_comparison_i_axi_lite_interface;
architecture structural of dsp_cav2_p1_comparison_i_axi_lite_interface is 
component dsp_cav2_p1_comparison_i_axi_lite_interface_verilog is
    port(
        cav2_p1_comparison_i : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_comparison_i_aclk : in std_logic;
        dsp_cav2_p1_comparison_i_aresetn : in std_logic;
        dsp_cav2_p1_comparison_i_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_comparison_i_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_comparison_i_s_axi_awready : out std_logic;
        dsp_cav2_p1_comparison_i_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_comparison_i_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_comparison_i_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_comparison_i_s_axi_wready : out std_logic;
        dsp_cav2_p1_comparison_i_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_comparison_i_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_comparison_i_s_axi_bready : in std_logic;
        dsp_cav2_p1_comparison_i_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_comparison_i_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_comparison_i_s_axi_arready : out std_logic;
        dsp_cav2_p1_comparison_i_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_comparison_i_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_comparison_i_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_comparison_i_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p1_comparison_i_axi_lite_interface_verilog
    port map(
    cav2_p1_comparison_i => cav2_p1_comparison_i,
    dsp_clk => dsp_clk,
    dsp_cav2_p1_comparison_i_aclk => dsp_cav2_p1_comparison_i_aclk,
    dsp_cav2_p1_comparison_i_aresetn => dsp_cav2_p1_comparison_i_aresetn,
    dsp_cav2_p1_comparison_i_s_axi_awaddr => dsp_cav2_p1_comparison_i_s_axi_awaddr,
    dsp_cav2_p1_comparison_i_s_axi_awvalid => dsp_cav2_p1_comparison_i_s_axi_awvalid,
    dsp_cav2_p1_comparison_i_s_axi_awready => dsp_cav2_p1_comparison_i_s_axi_awready,
    dsp_cav2_p1_comparison_i_s_axi_wdata => dsp_cav2_p1_comparison_i_s_axi_wdata,
    dsp_cav2_p1_comparison_i_s_axi_wstrb => dsp_cav2_p1_comparison_i_s_axi_wstrb,
    dsp_cav2_p1_comparison_i_s_axi_wvalid => dsp_cav2_p1_comparison_i_s_axi_wvalid,
    dsp_cav2_p1_comparison_i_s_axi_wready => dsp_cav2_p1_comparison_i_s_axi_wready,
    dsp_cav2_p1_comparison_i_s_axi_bresp => dsp_cav2_p1_comparison_i_s_axi_bresp,
    dsp_cav2_p1_comparison_i_s_axi_bvalid => dsp_cav2_p1_comparison_i_s_axi_bvalid,
    dsp_cav2_p1_comparison_i_s_axi_bready => dsp_cav2_p1_comparison_i_s_axi_bready,
    dsp_cav2_p1_comparison_i_s_axi_araddr => dsp_cav2_p1_comparison_i_s_axi_araddr,
    dsp_cav2_p1_comparison_i_s_axi_arvalid => dsp_cav2_p1_comparison_i_s_axi_arvalid,
    dsp_cav2_p1_comparison_i_s_axi_arready => dsp_cav2_p1_comparison_i_s_axi_arready,
    dsp_cav2_p1_comparison_i_s_axi_rdata => dsp_cav2_p1_comparison_i_s_axi_rdata,
    dsp_cav2_p1_comparison_i_s_axi_rresp => dsp_cav2_p1_comparison_i_s_axi_rresp,
    dsp_cav2_p1_comparison_i_s_axi_rvalid => dsp_cav2_p1_comparison_i_s_axi_rvalid,
    dsp_cav2_p1_comparison_i_s_axi_rready => dsp_cav2_p1_comparison_i_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p1_dc_freq_axi_lite_interface is 
    port(
        cav2_p1_dc_freq : in std_logic_vector(25 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_dc_freq_aclk : in std_logic;
        dsp_cav2_p1_dc_freq_aresetn : in std_logic;
        dsp_cav2_p1_dc_freq_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_dc_freq_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_dc_freq_s_axi_awready : out std_logic;
        dsp_cav2_p1_dc_freq_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_dc_freq_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_dc_freq_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_dc_freq_s_axi_wready : out std_logic;
        dsp_cav2_p1_dc_freq_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_dc_freq_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_dc_freq_s_axi_bready : in std_logic;
        dsp_cav2_p1_dc_freq_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_dc_freq_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_dc_freq_s_axi_arready : out std_logic;
        dsp_cav2_p1_dc_freq_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_dc_freq_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_dc_freq_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_dc_freq_s_axi_rready : in std_logic
    );
end dsp_cav2_p1_dc_freq_axi_lite_interface;
architecture structural of dsp_cav2_p1_dc_freq_axi_lite_interface is 
component dsp_cav2_p1_dc_freq_axi_lite_interface_verilog is
    port(
        cav2_p1_dc_freq : in std_logic_vector(25 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_dc_freq_aclk : in std_logic;
        dsp_cav2_p1_dc_freq_aresetn : in std_logic;
        dsp_cav2_p1_dc_freq_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_dc_freq_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_dc_freq_s_axi_awready : out std_logic;
        dsp_cav2_p1_dc_freq_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_dc_freq_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_dc_freq_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_dc_freq_s_axi_wready : out std_logic;
        dsp_cav2_p1_dc_freq_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_dc_freq_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_dc_freq_s_axi_bready : in std_logic;
        dsp_cav2_p1_dc_freq_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_dc_freq_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_dc_freq_s_axi_arready : out std_logic;
        dsp_cav2_p1_dc_freq_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_dc_freq_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_dc_freq_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_dc_freq_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p1_dc_freq_axi_lite_interface_verilog
    port map(
    cav2_p1_dc_freq => cav2_p1_dc_freq,
    dsp_clk => dsp_clk,
    dsp_cav2_p1_dc_freq_aclk => dsp_cav2_p1_dc_freq_aclk,
    dsp_cav2_p1_dc_freq_aresetn => dsp_cav2_p1_dc_freq_aresetn,
    dsp_cav2_p1_dc_freq_s_axi_awaddr => dsp_cav2_p1_dc_freq_s_axi_awaddr,
    dsp_cav2_p1_dc_freq_s_axi_awvalid => dsp_cav2_p1_dc_freq_s_axi_awvalid,
    dsp_cav2_p1_dc_freq_s_axi_awready => dsp_cav2_p1_dc_freq_s_axi_awready,
    dsp_cav2_p1_dc_freq_s_axi_wdata => dsp_cav2_p1_dc_freq_s_axi_wdata,
    dsp_cav2_p1_dc_freq_s_axi_wstrb => dsp_cav2_p1_dc_freq_s_axi_wstrb,
    dsp_cav2_p1_dc_freq_s_axi_wvalid => dsp_cav2_p1_dc_freq_s_axi_wvalid,
    dsp_cav2_p1_dc_freq_s_axi_wready => dsp_cav2_p1_dc_freq_s_axi_wready,
    dsp_cav2_p1_dc_freq_s_axi_bresp => dsp_cav2_p1_dc_freq_s_axi_bresp,
    dsp_cav2_p1_dc_freq_s_axi_bvalid => dsp_cav2_p1_dc_freq_s_axi_bvalid,
    dsp_cav2_p1_dc_freq_s_axi_bready => dsp_cav2_p1_dc_freq_s_axi_bready,
    dsp_cav2_p1_dc_freq_s_axi_araddr => dsp_cav2_p1_dc_freq_s_axi_araddr,
    dsp_cav2_p1_dc_freq_s_axi_arvalid => dsp_cav2_p1_dc_freq_s_axi_arvalid,
    dsp_cav2_p1_dc_freq_s_axi_arready => dsp_cav2_p1_dc_freq_s_axi_arready,
    dsp_cav2_p1_dc_freq_s_axi_rdata => dsp_cav2_p1_dc_freq_s_axi_rdata,
    dsp_cav2_p1_dc_freq_s_axi_rresp => dsp_cav2_p1_dc_freq_s_axi_rresp,
    dsp_cav2_p1_dc_freq_s_axi_rvalid => dsp_cav2_p1_dc_freq_s_axi_rvalid,
    dsp_cav2_p1_dc_freq_s_axi_rready => dsp_cav2_p1_dc_freq_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p1_dc_img_axi_lite_interface is 
    port(
        cav2_p1_dc_img : in std_logic_vector(28 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_dc_img_aclk : in std_logic;
        dsp_cav2_p1_dc_img_aresetn : in std_logic;
        dsp_cav2_p1_dc_img_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_dc_img_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_dc_img_s_axi_awready : out std_logic;
        dsp_cav2_p1_dc_img_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_dc_img_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_dc_img_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_dc_img_s_axi_wready : out std_logic;
        dsp_cav2_p1_dc_img_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_dc_img_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_dc_img_s_axi_bready : in std_logic;
        dsp_cav2_p1_dc_img_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_dc_img_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_dc_img_s_axi_arready : out std_logic;
        dsp_cav2_p1_dc_img_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_dc_img_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_dc_img_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_dc_img_s_axi_rready : in std_logic
    );
end dsp_cav2_p1_dc_img_axi_lite_interface;
architecture structural of dsp_cav2_p1_dc_img_axi_lite_interface is 
component dsp_cav2_p1_dc_img_axi_lite_interface_verilog is
    port(
        cav2_p1_dc_img : in std_logic_vector(28 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_dc_img_aclk : in std_logic;
        dsp_cav2_p1_dc_img_aresetn : in std_logic;
        dsp_cav2_p1_dc_img_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_dc_img_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_dc_img_s_axi_awready : out std_logic;
        dsp_cav2_p1_dc_img_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_dc_img_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_dc_img_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_dc_img_s_axi_wready : out std_logic;
        dsp_cav2_p1_dc_img_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_dc_img_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_dc_img_s_axi_bready : in std_logic;
        dsp_cav2_p1_dc_img_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_dc_img_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_dc_img_s_axi_arready : out std_logic;
        dsp_cav2_p1_dc_img_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_dc_img_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_dc_img_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_dc_img_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p1_dc_img_axi_lite_interface_verilog
    port map(
    cav2_p1_dc_img => cav2_p1_dc_img,
    dsp_clk => dsp_clk,
    dsp_cav2_p1_dc_img_aclk => dsp_cav2_p1_dc_img_aclk,
    dsp_cav2_p1_dc_img_aresetn => dsp_cav2_p1_dc_img_aresetn,
    dsp_cav2_p1_dc_img_s_axi_awaddr => dsp_cav2_p1_dc_img_s_axi_awaddr,
    dsp_cav2_p1_dc_img_s_axi_awvalid => dsp_cav2_p1_dc_img_s_axi_awvalid,
    dsp_cav2_p1_dc_img_s_axi_awready => dsp_cav2_p1_dc_img_s_axi_awready,
    dsp_cav2_p1_dc_img_s_axi_wdata => dsp_cav2_p1_dc_img_s_axi_wdata,
    dsp_cav2_p1_dc_img_s_axi_wstrb => dsp_cav2_p1_dc_img_s_axi_wstrb,
    dsp_cav2_p1_dc_img_s_axi_wvalid => dsp_cav2_p1_dc_img_s_axi_wvalid,
    dsp_cav2_p1_dc_img_s_axi_wready => dsp_cav2_p1_dc_img_s_axi_wready,
    dsp_cav2_p1_dc_img_s_axi_bresp => dsp_cav2_p1_dc_img_s_axi_bresp,
    dsp_cav2_p1_dc_img_s_axi_bvalid => dsp_cav2_p1_dc_img_s_axi_bvalid,
    dsp_cav2_p1_dc_img_s_axi_bready => dsp_cav2_p1_dc_img_s_axi_bready,
    dsp_cav2_p1_dc_img_s_axi_araddr => dsp_cav2_p1_dc_img_s_axi_araddr,
    dsp_cav2_p1_dc_img_s_axi_arvalid => dsp_cav2_p1_dc_img_s_axi_arvalid,
    dsp_cav2_p1_dc_img_s_axi_arready => dsp_cav2_p1_dc_img_s_axi_arready,
    dsp_cav2_p1_dc_img_s_axi_rdata => dsp_cav2_p1_dc_img_s_axi_rdata,
    dsp_cav2_p1_dc_img_s_axi_rresp => dsp_cav2_p1_dc_img_s_axi_rresp,
    dsp_cav2_p1_dc_img_s_axi_rvalid => dsp_cav2_p1_dc_img_s_axi_rvalid,
    dsp_cav2_p1_dc_img_s_axi_rready => dsp_cav2_p1_dc_img_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p1_dc_real_axi_lite_interface is 
    port(
        cav2_p1_dc_real : in std_logic_vector(28 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_dc_real_aclk : in std_logic;
        dsp_cav2_p1_dc_real_aresetn : in std_logic;
        dsp_cav2_p1_dc_real_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_dc_real_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_dc_real_s_axi_awready : out std_logic;
        dsp_cav2_p1_dc_real_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_dc_real_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_dc_real_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_dc_real_s_axi_wready : out std_logic;
        dsp_cav2_p1_dc_real_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_dc_real_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_dc_real_s_axi_bready : in std_logic;
        dsp_cav2_p1_dc_real_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_dc_real_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_dc_real_s_axi_arready : out std_logic;
        dsp_cav2_p1_dc_real_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_dc_real_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_dc_real_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_dc_real_s_axi_rready : in std_logic
    );
end dsp_cav2_p1_dc_real_axi_lite_interface;
architecture structural of dsp_cav2_p1_dc_real_axi_lite_interface is 
component dsp_cav2_p1_dc_real_axi_lite_interface_verilog is
    port(
        cav2_p1_dc_real : in std_logic_vector(28 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_dc_real_aclk : in std_logic;
        dsp_cav2_p1_dc_real_aresetn : in std_logic;
        dsp_cav2_p1_dc_real_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_dc_real_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_dc_real_s_axi_awready : out std_logic;
        dsp_cav2_p1_dc_real_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_dc_real_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_dc_real_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_dc_real_s_axi_wready : out std_logic;
        dsp_cav2_p1_dc_real_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_dc_real_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_dc_real_s_axi_bready : in std_logic;
        dsp_cav2_p1_dc_real_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_dc_real_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_dc_real_s_axi_arready : out std_logic;
        dsp_cav2_p1_dc_real_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_dc_real_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_dc_real_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_dc_real_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p1_dc_real_axi_lite_interface_verilog
    port map(
    cav2_p1_dc_real => cav2_p1_dc_real,
    dsp_clk => dsp_clk,
    dsp_cav2_p1_dc_real_aclk => dsp_cav2_p1_dc_real_aclk,
    dsp_cav2_p1_dc_real_aresetn => dsp_cav2_p1_dc_real_aresetn,
    dsp_cav2_p1_dc_real_s_axi_awaddr => dsp_cav2_p1_dc_real_s_axi_awaddr,
    dsp_cav2_p1_dc_real_s_axi_awvalid => dsp_cav2_p1_dc_real_s_axi_awvalid,
    dsp_cav2_p1_dc_real_s_axi_awready => dsp_cav2_p1_dc_real_s_axi_awready,
    dsp_cav2_p1_dc_real_s_axi_wdata => dsp_cav2_p1_dc_real_s_axi_wdata,
    dsp_cav2_p1_dc_real_s_axi_wstrb => dsp_cav2_p1_dc_real_s_axi_wstrb,
    dsp_cav2_p1_dc_real_s_axi_wvalid => dsp_cav2_p1_dc_real_s_axi_wvalid,
    dsp_cav2_p1_dc_real_s_axi_wready => dsp_cav2_p1_dc_real_s_axi_wready,
    dsp_cav2_p1_dc_real_s_axi_bresp => dsp_cav2_p1_dc_real_s_axi_bresp,
    dsp_cav2_p1_dc_real_s_axi_bvalid => dsp_cav2_p1_dc_real_s_axi_bvalid,
    dsp_cav2_p1_dc_real_s_axi_bready => dsp_cav2_p1_dc_real_s_axi_bready,
    dsp_cav2_p1_dc_real_s_axi_araddr => dsp_cav2_p1_dc_real_s_axi_araddr,
    dsp_cav2_p1_dc_real_s_axi_arvalid => dsp_cav2_p1_dc_real_s_axi_arvalid,
    dsp_cav2_p1_dc_real_s_axi_arready => dsp_cav2_p1_dc_real_s_axi_arready,
    dsp_cav2_p1_dc_real_s_axi_rdata => dsp_cav2_p1_dc_real_s_axi_rdata,
    dsp_cav2_p1_dc_real_s_axi_rresp => dsp_cav2_p1_dc_real_s_axi_rresp,
    dsp_cav2_p1_dc_real_s_axi_rvalid => dsp_cav2_p1_dc_real_s_axi_rvalid,
    dsp_cav2_p1_dc_real_s_axi_rready => dsp_cav2_p1_dc_real_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p1_if_amp_axi_lite_interface is 
    port(
        cav2_p1_if_amp : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_if_amp_aclk : in std_logic;
        dsp_cav2_p1_if_amp_aresetn : in std_logic;
        dsp_cav2_p1_if_amp_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_if_amp_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_if_amp_s_axi_awready : out std_logic;
        dsp_cav2_p1_if_amp_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_if_amp_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_if_amp_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_if_amp_s_axi_wready : out std_logic;
        dsp_cav2_p1_if_amp_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_if_amp_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_if_amp_s_axi_bready : in std_logic;
        dsp_cav2_p1_if_amp_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_if_amp_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_if_amp_s_axi_arready : out std_logic;
        dsp_cav2_p1_if_amp_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_if_amp_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_if_amp_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_if_amp_s_axi_rready : in std_logic
    );
end dsp_cav2_p1_if_amp_axi_lite_interface;
architecture structural of dsp_cav2_p1_if_amp_axi_lite_interface is 
component dsp_cav2_p1_if_amp_axi_lite_interface_verilog is
    port(
        cav2_p1_if_amp : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_if_amp_aclk : in std_logic;
        dsp_cav2_p1_if_amp_aresetn : in std_logic;
        dsp_cav2_p1_if_amp_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_if_amp_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_if_amp_s_axi_awready : out std_logic;
        dsp_cav2_p1_if_amp_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_if_amp_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_if_amp_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_if_amp_s_axi_wready : out std_logic;
        dsp_cav2_p1_if_amp_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_if_amp_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_if_amp_s_axi_bready : in std_logic;
        dsp_cav2_p1_if_amp_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_if_amp_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_if_amp_s_axi_arready : out std_logic;
        dsp_cav2_p1_if_amp_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_if_amp_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_if_amp_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_if_amp_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p1_if_amp_axi_lite_interface_verilog
    port map(
    cav2_p1_if_amp => cav2_p1_if_amp,
    dsp_clk => dsp_clk,
    dsp_cav2_p1_if_amp_aclk => dsp_cav2_p1_if_amp_aclk,
    dsp_cav2_p1_if_amp_aresetn => dsp_cav2_p1_if_amp_aresetn,
    dsp_cav2_p1_if_amp_s_axi_awaddr => dsp_cav2_p1_if_amp_s_axi_awaddr,
    dsp_cav2_p1_if_amp_s_axi_awvalid => dsp_cav2_p1_if_amp_s_axi_awvalid,
    dsp_cav2_p1_if_amp_s_axi_awready => dsp_cav2_p1_if_amp_s_axi_awready,
    dsp_cav2_p1_if_amp_s_axi_wdata => dsp_cav2_p1_if_amp_s_axi_wdata,
    dsp_cav2_p1_if_amp_s_axi_wstrb => dsp_cav2_p1_if_amp_s_axi_wstrb,
    dsp_cav2_p1_if_amp_s_axi_wvalid => dsp_cav2_p1_if_amp_s_axi_wvalid,
    dsp_cav2_p1_if_amp_s_axi_wready => dsp_cav2_p1_if_amp_s_axi_wready,
    dsp_cav2_p1_if_amp_s_axi_bresp => dsp_cav2_p1_if_amp_s_axi_bresp,
    dsp_cav2_p1_if_amp_s_axi_bvalid => dsp_cav2_p1_if_amp_s_axi_bvalid,
    dsp_cav2_p1_if_amp_s_axi_bready => dsp_cav2_p1_if_amp_s_axi_bready,
    dsp_cav2_p1_if_amp_s_axi_araddr => dsp_cav2_p1_if_amp_s_axi_araddr,
    dsp_cav2_p1_if_amp_s_axi_arvalid => dsp_cav2_p1_if_amp_s_axi_arvalid,
    dsp_cav2_p1_if_amp_s_axi_arready => dsp_cav2_p1_if_amp_s_axi_arready,
    dsp_cav2_p1_if_amp_s_axi_rdata => dsp_cav2_p1_if_amp_s_axi_rdata,
    dsp_cav2_p1_if_amp_s_axi_rresp => dsp_cav2_p1_if_amp_s_axi_rresp,
    dsp_cav2_p1_if_amp_s_axi_rvalid => dsp_cav2_p1_if_amp_s_axi_rvalid,
    dsp_cav2_p1_if_amp_s_axi_rready => dsp_cav2_p1_if_amp_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p1_if_i_axi_lite_interface is 
    port(
        cav2_p1_if_i : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_if_i_aclk : in std_logic;
        dsp_cav2_p1_if_i_aresetn : in std_logic;
        dsp_cav2_p1_if_i_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_if_i_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_if_i_s_axi_awready : out std_logic;
        dsp_cav2_p1_if_i_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_if_i_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_if_i_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_if_i_s_axi_wready : out std_logic;
        dsp_cav2_p1_if_i_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_if_i_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_if_i_s_axi_bready : in std_logic;
        dsp_cav2_p1_if_i_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_if_i_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_if_i_s_axi_arready : out std_logic;
        dsp_cav2_p1_if_i_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_if_i_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_if_i_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_if_i_s_axi_rready : in std_logic
    );
end dsp_cav2_p1_if_i_axi_lite_interface;
architecture structural of dsp_cav2_p1_if_i_axi_lite_interface is 
component dsp_cav2_p1_if_i_axi_lite_interface_verilog is
    port(
        cav2_p1_if_i : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_if_i_aclk : in std_logic;
        dsp_cav2_p1_if_i_aresetn : in std_logic;
        dsp_cav2_p1_if_i_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_if_i_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_if_i_s_axi_awready : out std_logic;
        dsp_cav2_p1_if_i_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_if_i_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_if_i_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_if_i_s_axi_wready : out std_logic;
        dsp_cav2_p1_if_i_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_if_i_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_if_i_s_axi_bready : in std_logic;
        dsp_cav2_p1_if_i_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_if_i_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_if_i_s_axi_arready : out std_logic;
        dsp_cav2_p1_if_i_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_if_i_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_if_i_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_if_i_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p1_if_i_axi_lite_interface_verilog
    port map(
    cav2_p1_if_i => cav2_p1_if_i,
    dsp_clk => dsp_clk,
    dsp_cav2_p1_if_i_aclk => dsp_cav2_p1_if_i_aclk,
    dsp_cav2_p1_if_i_aresetn => dsp_cav2_p1_if_i_aresetn,
    dsp_cav2_p1_if_i_s_axi_awaddr => dsp_cav2_p1_if_i_s_axi_awaddr,
    dsp_cav2_p1_if_i_s_axi_awvalid => dsp_cav2_p1_if_i_s_axi_awvalid,
    dsp_cav2_p1_if_i_s_axi_awready => dsp_cav2_p1_if_i_s_axi_awready,
    dsp_cav2_p1_if_i_s_axi_wdata => dsp_cav2_p1_if_i_s_axi_wdata,
    dsp_cav2_p1_if_i_s_axi_wstrb => dsp_cav2_p1_if_i_s_axi_wstrb,
    dsp_cav2_p1_if_i_s_axi_wvalid => dsp_cav2_p1_if_i_s_axi_wvalid,
    dsp_cav2_p1_if_i_s_axi_wready => dsp_cav2_p1_if_i_s_axi_wready,
    dsp_cav2_p1_if_i_s_axi_bresp => dsp_cav2_p1_if_i_s_axi_bresp,
    dsp_cav2_p1_if_i_s_axi_bvalid => dsp_cav2_p1_if_i_s_axi_bvalid,
    dsp_cav2_p1_if_i_s_axi_bready => dsp_cav2_p1_if_i_s_axi_bready,
    dsp_cav2_p1_if_i_s_axi_araddr => dsp_cav2_p1_if_i_s_axi_araddr,
    dsp_cav2_p1_if_i_s_axi_arvalid => dsp_cav2_p1_if_i_s_axi_arvalid,
    dsp_cav2_p1_if_i_s_axi_arready => dsp_cav2_p1_if_i_s_axi_arready,
    dsp_cav2_p1_if_i_s_axi_rdata => dsp_cav2_p1_if_i_s_axi_rdata,
    dsp_cav2_p1_if_i_s_axi_rresp => dsp_cav2_p1_if_i_s_axi_rresp,
    dsp_cav2_p1_if_i_s_axi_rvalid => dsp_cav2_p1_if_i_s_axi_rvalid,
    dsp_cav2_p1_if_i_s_axi_rready => dsp_cav2_p1_if_i_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p1_if_phase_axi_lite_interface is 
    port(
        cav2_p1_if_phase : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_if_phase_aclk : in std_logic;
        dsp_cav2_p1_if_phase_aresetn : in std_logic;
        dsp_cav2_p1_if_phase_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_if_phase_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_if_phase_s_axi_awready : out std_logic;
        dsp_cav2_p1_if_phase_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_if_phase_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_if_phase_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_if_phase_s_axi_wready : out std_logic;
        dsp_cav2_p1_if_phase_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_if_phase_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_if_phase_s_axi_bready : in std_logic;
        dsp_cav2_p1_if_phase_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_if_phase_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_if_phase_s_axi_arready : out std_logic;
        dsp_cav2_p1_if_phase_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_if_phase_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_if_phase_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_if_phase_s_axi_rready : in std_logic
    );
end dsp_cav2_p1_if_phase_axi_lite_interface;
architecture structural of dsp_cav2_p1_if_phase_axi_lite_interface is 
component dsp_cav2_p1_if_phase_axi_lite_interface_verilog is
    port(
        cav2_p1_if_phase : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_if_phase_aclk : in std_logic;
        dsp_cav2_p1_if_phase_aresetn : in std_logic;
        dsp_cav2_p1_if_phase_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_if_phase_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_if_phase_s_axi_awready : out std_logic;
        dsp_cav2_p1_if_phase_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_if_phase_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_if_phase_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_if_phase_s_axi_wready : out std_logic;
        dsp_cav2_p1_if_phase_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_if_phase_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_if_phase_s_axi_bready : in std_logic;
        dsp_cav2_p1_if_phase_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_if_phase_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_if_phase_s_axi_arready : out std_logic;
        dsp_cav2_p1_if_phase_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_if_phase_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_if_phase_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_if_phase_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p1_if_phase_axi_lite_interface_verilog
    port map(
    cav2_p1_if_phase => cav2_p1_if_phase,
    dsp_clk => dsp_clk,
    dsp_cav2_p1_if_phase_aclk => dsp_cav2_p1_if_phase_aclk,
    dsp_cav2_p1_if_phase_aresetn => dsp_cav2_p1_if_phase_aresetn,
    dsp_cav2_p1_if_phase_s_axi_awaddr => dsp_cav2_p1_if_phase_s_axi_awaddr,
    dsp_cav2_p1_if_phase_s_axi_awvalid => dsp_cav2_p1_if_phase_s_axi_awvalid,
    dsp_cav2_p1_if_phase_s_axi_awready => dsp_cav2_p1_if_phase_s_axi_awready,
    dsp_cav2_p1_if_phase_s_axi_wdata => dsp_cav2_p1_if_phase_s_axi_wdata,
    dsp_cav2_p1_if_phase_s_axi_wstrb => dsp_cav2_p1_if_phase_s_axi_wstrb,
    dsp_cav2_p1_if_phase_s_axi_wvalid => dsp_cav2_p1_if_phase_s_axi_wvalid,
    dsp_cav2_p1_if_phase_s_axi_wready => dsp_cav2_p1_if_phase_s_axi_wready,
    dsp_cav2_p1_if_phase_s_axi_bresp => dsp_cav2_p1_if_phase_s_axi_bresp,
    dsp_cav2_p1_if_phase_s_axi_bvalid => dsp_cav2_p1_if_phase_s_axi_bvalid,
    dsp_cav2_p1_if_phase_s_axi_bready => dsp_cav2_p1_if_phase_s_axi_bready,
    dsp_cav2_p1_if_phase_s_axi_araddr => dsp_cav2_p1_if_phase_s_axi_araddr,
    dsp_cav2_p1_if_phase_s_axi_arvalid => dsp_cav2_p1_if_phase_s_axi_arvalid,
    dsp_cav2_p1_if_phase_s_axi_arready => dsp_cav2_p1_if_phase_s_axi_arready,
    dsp_cav2_p1_if_phase_s_axi_rdata => dsp_cav2_p1_if_phase_s_axi_rdata,
    dsp_cav2_p1_if_phase_s_axi_rresp => dsp_cav2_p1_if_phase_s_axi_rresp,
    dsp_cav2_p1_if_phase_s_axi_rvalid => dsp_cav2_p1_if_phase_s_axi_rvalid,
    dsp_cav2_p1_if_phase_s_axi_rready => dsp_cav2_p1_if_phase_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p1_if_q_axi_lite_interface is 
    port(
        cav2_p1_if_q : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_if_q_aclk : in std_logic;
        dsp_cav2_p1_if_q_aresetn : in std_logic;
        dsp_cav2_p1_if_q_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_if_q_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_if_q_s_axi_awready : out std_logic;
        dsp_cav2_p1_if_q_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_if_q_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_if_q_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_if_q_s_axi_wready : out std_logic;
        dsp_cav2_p1_if_q_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_if_q_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_if_q_s_axi_bready : in std_logic;
        dsp_cav2_p1_if_q_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_if_q_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_if_q_s_axi_arready : out std_logic;
        dsp_cav2_p1_if_q_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_if_q_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_if_q_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_if_q_s_axi_rready : in std_logic
    );
end dsp_cav2_p1_if_q_axi_lite_interface;
architecture structural of dsp_cav2_p1_if_q_axi_lite_interface is 
component dsp_cav2_p1_if_q_axi_lite_interface_verilog is
    port(
        cav2_p1_if_q : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_if_q_aclk : in std_logic;
        dsp_cav2_p1_if_q_aresetn : in std_logic;
        dsp_cav2_p1_if_q_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_if_q_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_if_q_s_axi_awready : out std_logic;
        dsp_cav2_p1_if_q_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_if_q_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_if_q_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_if_q_s_axi_wready : out std_logic;
        dsp_cav2_p1_if_q_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_if_q_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_if_q_s_axi_bready : in std_logic;
        dsp_cav2_p1_if_q_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_if_q_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_if_q_s_axi_arready : out std_logic;
        dsp_cav2_p1_if_q_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_if_q_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_if_q_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_if_q_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p1_if_q_axi_lite_interface_verilog
    port map(
    cav2_p1_if_q => cav2_p1_if_q,
    dsp_clk => dsp_clk,
    dsp_cav2_p1_if_q_aclk => dsp_cav2_p1_if_q_aclk,
    dsp_cav2_p1_if_q_aresetn => dsp_cav2_p1_if_q_aresetn,
    dsp_cav2_p1_if_q_s_axi_awaddr => dsp_cav2_p1_if_q_s_axi_awaddr,
    dsp_cav2_p1_if_q_s_axi_awvalid => dsp_cav2_p1_if_q_s_axi_awvalid,
    dsp_cav2_p1_if_q_s_axi_awready => dsp_cav2_p1_if_q_s_axi_awready,
    dsp_cav2_p1_if_q_s_axi_wdata => dsp_cav2_p1_if_q_s_axi_wdata,
    dsp_cav2_p1_if_q_s_axi_wstrb => dsp_cav2_p1_if_q_s_axi_wstrb,
    dsp_cav2_p1_if_q_s_axi_wvalid => dsp_cav2_p1_if_q_s_axi_wvalid,
    dsp_cav2_p1_if_q_s_axi_wready => dsp_cav2_p1_if_q_s_axi_wready,
    dsp_cav2_p1_if_q_s_axi_bresp => dsp_cav2_p1_if_q_s_axi_bresp,
    dsp_cav2_p1_if_q_s_axi_bvalid => dsp_cav2_p1_if_q_s_axi_bvalid,
    dsp_cav2_p1_if_q_s_axi_bready => dsp_cav2_p1_if_q_s_axi_bready,
    dsp_cav2_p1_if_q_s_axi_araddr => dsp_cav2_p1_if_q_s_axi_araddr,
    dsp_cav2_p1_if_q_s_axi_arvalid => dsp_cav2_p1_if_q_s_axi_arvalid,
    dsp_cav2_p1_if_q_s_axi_arready => dsp_cav2_p1_if_q_s_axi_arready,
    dsp_cav2_p1_if_q_s_axi_rdata => dsp_cav2_p1_if_q_s_axi_rdata,
    dsp_cav2_p1_if_q_s_axi_rresp => dsp_cav2_p1_if_q_s_axi_rresp,
    dsp_cav2_p1_if_q_s_axi_rvalid => dsp_cav2_p1_if_q_s_axi_rvalid,
    dsp_cav2_p1_if_q_s_axi_rready => dsp_cav2_p1_if_q_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p1_integrated_i_axi_lite_interface is 
    port(
        cav2_p1_integrated_i : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_integrated_i_aclk : in std_logic;
        dsp_cav2_p1_integrated_i_aresetn : in std_logic;
        dsp_cav2_p1_integrated_i_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_integrated_i_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_integrated_i_s_axi_awready : out std_logic;
        dsp_cav2_p1_integrated_i_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_integrated_i_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_integrated_i_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_integrated_i_s_axi_wready : out std_logic;
        dsp_cav2_p1_integrated_i_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_integrated_i_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_integrated_i_s_axi_bready : in std_logic;
        dsp_cav2_p1_integrated_i_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_integrated_i_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_integrated_i_s_axi_arready : out std_logic;
        dsp_cav2_p1_integrated_i_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_integrated_i_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_integrated_i_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_integrated_i_s_axi_rready : in std_logic
    );
end dsp_cav2_p1_integrated_i_axi_lite_interface;
architecture structural of dsp_cav2_p1_integrated_i_axi_lite_interface is 
component dsp_cav2_p1_integrated_i_axi_lite_interface_verilog is
    port(
        cav2_p1_integrated_i : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_integrated_i_aclk : in std_logic;
        dsp_cav2_p1_integrated_i_aresetn : in std_logic;
        dsp_cav2_p1_integrated_i_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_integrated_i_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_integrated_i_s_axi_awready : out std_logic;
        dsp_cav2_p1_integrated_i_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_integrated_i_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_integrated_i_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_integrated_i_s_axi_wready : out std_logic;
        dsp_cav2_p1_integrated_i_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_integrated_i_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_integrated_i_s_axi_bready : in std_logic;
        dsp_cav2_p1_integrated_i_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_integrated_i_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_integrated_i_s_axi_arready : out std_logic;
        dsp_cav2_p1_integrated_i_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_integrated_i_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_integrated_i_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_integrated_i_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p1_integrated_i_axi_lite_interface_verilog
    port map(
    cav2_p1_integrated_i => cav2_p1_integrated_i,
    dsp_clk => dsp_clk,
    dsp_cav2_p1_integrated_i_aclk => dsp_cav2_p1_integrated_i_aclk,
    dsp_cav2_p1_integrated_i_aresetn => dsp_cav2_p1_integrated_i_aresetn,
    dsp_cav2_p1_integrated_i_s_axi_awaddr => dsp_cav2_p1_integrated_i_s_axi_awaddr,
    dsp_cav2_p1_integrated_i_s_axi_awvalid => dsp_cav2_p1_integrated_i_s_axi_awvalid,
    dsp_cav2_p1_integrated_i_s_axi_awready => dsp_cav2_p1_integrated_i_s_axi_awready,
    dsp_cav2_p1_integrated_i_s_axi_wdata => dsp_cav2_p1_integrated_i_s_axi_wdata,
    dsp_cav2_p1_integrated_i_s_axi_wstrb => dsp_cav2_p1_integrated_i_s_axi_wstrb,
    dsp_cav2_p1_integrated_i_s_axi_wvalid => dsp_cav2_p1_integrated_i_s_axi_wvalid,
    dsp_cav2_p1_integrated_i_s_axi_wready => dsp_cav2_p1_integrated_i_s_axi_wready,
    dsp_cav2_p1_integrated_i_s_axi_bresp => dsp_cav2_p1_integrated_i_s_axi_bresp,
    dsp_cav2_p1_integrated_i_s_axi_bvalid => dsp_cav2_p1_integrated_i_s_axi_bvalid,
    dsp_cav2_p1_integrated_i_s_axi_bready => dsp_cav2_p1_integrated_i_s_axi_bready,
    dsp_cav2_p1_integrated_i_s_axi_araddr => dsp_cav2_p1_integrated_i_s_axi_araddr,
    dsp_cav2_p1_integrated_i_s_axi_arvalid => dsp_cav2_p1_integrated_i_s_axi_arvalid,
    dsp_cav2_p1_integrated_i_s_axi_arready => dsp_cav2_p1_integrated_i_s_axi_arready,
    dsp_cav2_p1_integrated_i_s_axi_rdata => dsp_cav2_p1_integrated_i_s_axi_rdata,
    dsp_cav2_p1_integrated_i_s_axi_rresp => dsp_cav2_p1_integrated_i_s_axi_rresp,
    dsp_cav2_p1_integrated_i_s_axi_rvalid => dsp_cav2_p1_integrated_i_s_axi_rvalid,
    dsp_cav2_p1_integrated_i_s_axi_rready => dsp_cav2_p1_integrated_i_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p1_integrated_q_axi_lite_interface is 
    port(
        cav2_p1_integrated_q : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_integrated_q_aclk : in std_logic;
        dsp_cav2_p1_integrated_q_aresetn : in std_logic;
        dsp_cav2_p1_integrated_q_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_integrated_q_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_integrated_q_s_axi_awready : out std_logic;
        dsp_cav2_p1_integrated_q_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_integrated_q_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_integrated_q_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_integrated_q_s_axi_wready : out std_logic;
        dsp_cav2_p1_integrated_q_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_integrated_q_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_integrated_q_s_axi_bready : in std_logic;
        dsp_cav2_p1_integrated_q_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_integrated_q_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_integrated_q_s_axi_arready : out std_logic;
        dsp_cav2_p1_integrated_q_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_integrated_q_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_integrated_q_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_integrated_q_s_axi_rready : in std_logic
    );
end dsp_cav2_p1_integrated_q_axi_lite_interface;
architecture structural of dsp_cav2_p1_integrated_q_axi_lite_interface is 
component dsp_cav2_p1_integrated_q_axi_lite_interface_verilog is
    port(
        cav2_p1_integrated_q : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_integrated_q_aclk : in std_logic;
        dsp_cav2_p1_integrated_q_aresetn : in std_logic;
        dsp_cav2_p1_integrated_q_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_integrated_q_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_integrated_q_s_axi_awready : out std_logic;
        dsp_cav2_p1_integrated_q_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_integrated_q_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_integrated_q_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_integrated_q_s_axi_wready : out std_logic;
        dsp_cav2_p1_integrated_q_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_integrated_q_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_integrated_q_s_axi_bready : in std_logic;
        dsp_cav2_p1_integrated_q_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_integrated_q_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_integrated_q_s_axi_arready : out std_logic;
        dsp_cav2_p1_integrated_q_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_integrated_q_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_integrated_q_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_integrated_q_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p1_integrated_q_axi_lite_interface_verilog
    port map(
    cav2_p1_integrated_q => cav2_p1_integrated_q,
    dsp_clk => dsp_clk,
    dsp_cav2_p1_integrated_q_aclk => dsp_cav2_p1_integrated_q_aclk,
    dsp_cav2_p1_integrated_q_aresetn => dsp_cav2_p1_integrated_q_aresetn,
    dsp_cav2_p1_integrated_q_s_axi_awaddr => dsp_cav2_p1_integrated_q_s_axi_awaddr,
    dsp_cav2_p1_integrated_q_s_axi_awvalid => dsp_cav2_p1_integrated_q_s_axi_awvalid,
    dsp_cav2_p1_integrated_q_s_axi_awready => dsp_cav2_p1_integrated_q_s_axi_awready,
    dsp_cav2_p1_integrated_q_s_axi_wdata => dsp_cav2_p1_integrated_q_s_axi_wdata,
    dsp_cav2_p1_integrated_q_s_axi_wstrb => dsp_cav2_p1_integrated_q_s_axi_wstrb,
    dsp_cav2_p1_integrated_q_s_axi_wvalid => dsp_cav2_p1_integrated_q_s_axi_wvalid,
    dsp_cav2_p1_integrated_q_s_axi_wready => dsp_cav2_p1_integrated_q_s_axi_wready,
    dsp_cav2_p1_integrated_q_s_axi_bresp => dsp_cav2_p1_integrated_q_s_axi_bresp,
    dsp_cav2_p1_integrated_q_s_axi_bvalid => dsp_cav2_p1_integrated_q_s_axi_bvalid,
    dsp_cav2_p1_integrated_q_s_axi_bready => dsp_cav2_p1_integrated_q_s_axi_bready,
    dsp_cav2_p1_integrated_q_s_axi_araddr => dsp_cav2_p1_integrated_q_s_axi_araddr,
    dsp_cav2_p1_integrated_q_s_axi_arvalid => dsp_cav2_p1_integrated_q_s_axi_arvalid,
    dsp_cav2_p1_integrated_q_s_axi_arready => dsp_cav2_p1_integrated_q_s_axi_arready,
    dsp_cav2_p1_integrated_q_s_axi_rdata => dsp_cav2_p1_integrated_q_s_axi_rdata,
    dsp_cav2_p1_integrated_q_s_axi_rresp => dsp_cav2_p1_integrated_q_s_axi_rresp,
    dsp_cav2_p1_integrated_q_s_axi_rvalid => dsp_cav2_p1_integrated_q_s_axi_rvalid,
    dsp_cav2_p1_integrated_q_s_axi_rready => dsp_cav2_p1_integrated_q_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p1_phase_out_axi_lite_interface is 
    port(
        cav2_p1_phase_out : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_phase_out_aclk : in std_logic;
        dsp_cav2_p1_phase_out_aresetn : in std_logic;
        dsp_cav2_p1_phase_out_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_phase_out_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_phase_out_s_axi_awready : out std_logic;
        dsp_cav2_p1_phase_out_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_phase_out_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_phase_out_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_phase_out_s_axi_wready : out std_logic;
        dsp_cav2_p1_phase_out_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_phase_out_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_phase_out_s_axi_bready : in std_logic;
        dsp_cav2_p1_phase_out_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_phase_out_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_phase_out_s_axi_arready : out std_logic;
        dsp_cav2_p1_phase_out_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_phase_out_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_phase_out_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_phase_out_s_axi_rready : in std_logic
    );
end dsp_cav2_p1_phase_out_axi_lite_interface;
architecture structural of dsp_cav2_p1_phase_out_axi_lite_interface is 
component dsp_cav2_p1_phase_out_axi_lite_interface_verilog is
    port(
        cav2_p1_phase_out : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_phase_out_aclk : in std_logic;
        dsp_cav2_p1_phase_out_aresetn : in std_logic;
        dsp_cav2_p1_phase_out_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_phase_out_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_phase_out_s_axi_awready : out std_logic;
        dsp_cav2_p1_phase_out_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_phase_out_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_phase_out_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_phase_out_s_axi_wready : out std_logic;
        dsp_cav2_p1_phase_out_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_phase_out_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_phase_out_s_axi_bready : in std_logic;
        dsp_cav2_p1_phase_out_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_phase_out_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_phase_out_s_axi_arready : out std_logic;
        dsp_cav2_p1_phase_out_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_phase_out_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_phase_out_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_phase_out_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p1_phase_out_axi_lite_interface_verilog
    port map(
    cav2_p1_phase_out => cav2_p1_phase_out,
    dsp_clk => dsp_clk,
    dsp_cav2_p1_phase_out_aclk => dsp_cav2_p1_phase_out_aclk,
    dsp_cav2_p1_phase_out_aresetn => dsp_cav2_p1_phase_out_aresetn,
    dsp_cav2_p1_phase_out_s_axi_awaddr => dsp_cav2_p1_phase_out_s_axi_awaddr,
    dsp_cav2_p1_phase_out_s_axi_awvalid => dsp_cav2_p1_phase_out_s_axi_awvalid,
    dsp_cav2_p1_phase_out_s_axi_awready => dsp_cav2_p1_phase_out_s_axi_awready,
    dsp_cav2_p1_phase_out_s_axi_wdata => dsp_cav2_p1_phase_out_s_axi_wdata,
    dsp_cav2_p1_phase_out_s_axi_wstrb => dsp_cav2_p1_phase_out_s_axi_wstrb,
    dsp_cav2_p1_phase_out_s_axi_wvalid => dsp_cav2_p1_phase_out_s_axi_wvalid,
    dsp_cav2_p1_phase_out_s_axi_wready => dsp_cav2_p1_phase_out_s_axi_wready,
    dsp_cav2_p1_phase_out_s_axi_bresp => dsp_cav2_p1_phase_out_s_axi_bresp,
    dsp_cav2_p1_phase_out_s_axi_bvalid => dsp_cav2_p1_phase_out_s_axi_bvalid,
    dsp_cav2_p1_phase_out_s_axi_bready => dsp_cav2_p1_phase_out_s_axi_bready,
    dsp_cav2_p1_phase_out_s_axi_araddr => dsp_cav2_p1_phase_out_s_axi_araddr,
    dsp_cav2_p1_phase_out_s_axi_arvalid => dsp_cav2_p1_phase_out_s_axi_arvalid,
    dsp_cav2_p1_phase_out_s_axi_arready => dsp_cav2_p1_phase_out_s_axi_arready,
    dsp_cav2_p1_phase_out_s_axi_rdata => dsp_cav2_p1_phase_out_s_axi_rdata,
    dsp_cav2_p1_phase_out_s_axi_rresp => dsp_cav2_p1_phase_out_s_axi_rresp,
    dsp_cav2_p1_phase_out_s_axi_rvalid => dsp_cav2_p1_phase_out_s_axi_rvalid,
    dsp_cav2_p1_phase_out_s_axi_rready => dsp_cav2_p1_phase_out_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p1_window_start_axi_lite_interface is 
    port(
        cav2_p1_window_start : out std_logic_vector(15 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_window_start_aclk : in std_logic;
        dsp_cav2_p1_window_start_aresetn : in std_logic;
        dsp_cav2_p1_window_start_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_window_start_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_window_start_s_axi_awready : out std_logic;
        dsp_cav2_p1_window_start_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_window_start_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_window_start_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_window_start_s_axi_wready : out std_logic;
        dsp_cav2_p1_window_start_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_window_start_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_window_start_s_axi_bready : in std_logic;
        dsp_cav2_p1_window_start_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_window_start_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_window_start_s_axi_arready : out std_logic;
        dsp_cav2_p1_window_start_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_window_start_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_window_start_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_window_start_s_axi_rready : in std_logic
    );
end dsp_cav2_p1_window_start_axi_lite_interface;
architecture structural of dsp_cav2_p1_window_start_axi_lite_interface is 
component dsp_cav2_p1_window_start_axi_lite_interface_verilog is
    port(
        cav2_p1_window_start : out std_logic_vector(15 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_window_start_aclk : in std_logic;
        dsp_cav2_p1_window_start_aresetn : in std_logic;
        dsp_cav2_p1_window_start_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_window_start_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_window_start_s_axi_awready : out std_logic;
        dsp_cav2_p1_window_start_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_window_start_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_window_start_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_window_start_s_axi_wready : out std_logic;
        dsp_cav2_p1_window_start_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_window_start_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_window_start_s_axi_bready : in std_logic;
        dsp_cav2_p1_window_start_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_window_start_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_window_start_s_axi_arready : out std_logic;
        dsp_cav2_p1_window_start_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_window_start_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_window_start_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_window_start_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p1_window_start_axi_lite_interface_verilog
    port map(
    cav2_p1_window_start => cav2_p1_window_start,
    dsp_clk => dsp_clk,
    dsp_cav2_p1_window_start_aclk => dsp_cav2_p1_window_start_aclk,
    dsp_cav2_p1_window_start_aresetn => dsp_cav2_p1_window_start_aresetn,
    dsp_cav2_p1_window_start_s_axi_awaddr => dsp_cav2_p1_window_start_s_axi_awaddr,
    dsp_cav2_p1_window_start_s_axi_awvalid => dsp_cav2_p1_window_start_s_axi_awvalid,
    dsp_cav2_p1_window_start_s_axi_awready => dsp_cav2_p1_window_start_s_axi_awready,
    dsp_cav2_p1_window_start_s_axi_wdata => dsp_cav2_p1_window_start_s_axi_wdata,
    dsp_cav2_p1_window_start_s_axi_wstrb => dsp_cav2_p1_window_start_s_axi_wstrb,
    dsp_cav2_p1_window_start_s_axi_wvalid => dsp_cav2_p1_window_start_s_axi_wvalid,
    dsp_cav2_p1_window_start_s_axi_wready => dsp_cav2_p1_window_start_s_axi_wready,
    dsp_cav2_p1_window_start_s_axi_bresp => dsp_cav2_p1_window_start_s_axi_bresp,
    dsp_cav2_p1_window_start_s_axi_bvalid => dsp_cav2_p1_window_start_s_axi_bvalid,
    dsp_cav2_p1_window_start_s_axi_bready => dsp_cav2_p1_window_start_s_axi_bready,
    dsp_cav2_p1_window_start_s_axi_araddr => dsp_cav2_p1_window_start_s_axi_araddr,
    dsp_cav2_p1_window_start_s_axi_arvalid => dsp_cav2_p1_window_start_s_axi_arvalid,
    dsp_cav2_p1_window_start_s_axi_arready => dsp_cav2_p1_window_start_s_axi_arready,
    dsp_cav2_p1_window_start_s_axi_rdata => dsp_cav2_p1_window_start_s_axi_rdata,
    dsp_cav2_p1_window_start_s_axi_rresp => dsp_cav2_p1_window_start_s_axi_rresp,
    dsp_cav2_p1_window_start_s_axi_rvalid => dsp_cav2_p1_window_start_s_axi_rvalid,
    dsp_cav2_p1_window_start_s_axi_rready => dsp_cav2_p1_window_start_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p1_window_stop_axi_lite_interface is 
    port(
        cav2_p1_window_stop : out std_logic_vector(15 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_window_stop_aclk : in std_logic;
        dsp_cav2_p1_window_stop_aresetn : in std_logic;
        dsp_cav2_p1_window_stop_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_window_stop_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_window_stop_s_axi_awready : out std_logic;
        dsp_cav2_p1_window_stop_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_window_stop_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_window_stop_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_window_stop_s_axi_wready : out std_logic;
        dsp_cav2_p1_window_stop_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_window_stop_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_window_stop_s_axi_bready : in std_logic;
        dsp_cav2_p1_window_stop_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_window_stop_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_window_stop_s_axi_arready : out std_logic;
        dsp_cav2_p1_window_stop_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_window_stop_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_window_stop_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_window_stop_s_axi_rready : in std_logic
    );
end dsp_cav2_p1_window_stop_axi_lite_interface;
architecture structural of dsp_cav2_p1_window_stop_axi_lite_interface is 
component dsp_cav2_p1_window_stop_axi_lite_interface_verilog is
    port(
        cav2_p1_window_stop : out std_logic_vector(15 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_window_stop_aclk : in std_logic;
        dsp_cav2_p1_window_stop_aresetn : in std_logic;
        dsp_cav2_p1_window_stop_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_window_stop_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_window_stop_s_axi_awready : out std_logic;
        dsp_cav2_p1_window_stop_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_window_stop_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_window_stop_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_window_stop_s_axi_wready : out std_logic;
        dsp_cav2_p1_window_stop_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_window_stop_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_window_stop_s_axi_bready : in std_logic;
        dsp_cav2_p1_window_stop_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_window_stop_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_window_stop_s_axi_arready : out std_logic;
        dsp_cav2_p1_window_stop_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_window_stop_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_window_stop_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_window_stop_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p1_window_stop_axi_lite_interface_verilog
    port map(
    cav2_p1_window_stop => cav2_p1_window_stop,
    dsp_clk => dsp_clk,
    dsp_cav2_p1_window_stop_aclk => dsp_cav2_p1_window_stop_aclk,
    dsp_cav2_p1_window_stop_aresetn => dsp_cav2_p1_window_stop_aresetn,
    dsp_cav2_p1_window_stop_s_axi_awaddr => dsp_cav2_p1_window_stop_s_axi_awaddr,
    dsp_cav2_p1_window_stop_s_axi_awvalid => dsp_cav2_p1_window_stop_s_axi_awvalid,
    dsp_cav2_p1_window_stop_s_axi_awready => dsp_cav2_p1_window_stop_s_axi_awready,
    dsp_cav2_p1_window_stop_s_axi_wdata => dsp_cav2_p1_window_stop_s_axi_wdata,
    dsp_cav2_p1_window_stop_s_axi_wstrb => dsp_cav2_p1_window_stop_s_axi_wstrb,
    dsp_cav2_p1_window_stop_s_axi_wvalid => dsp_cav2_p1_window_stop_s_axi_wvalid,
    dsp_cav2_p1_window_stop_s_axi_wready => dsp_cav2_p1_window_stop_s_axi_wready,
    dsp_cav2_p1_window_stop_s_axi_bresp => dsp_cav2_p1_window_stop_s_axi_bresp,
    dsp_cav2_p1_window_stop_s_axi_bvalid => dsp_cav2_p1_window_stop_s_axi_bvalid,
    dsp_cav2_p1_window_stop_s_axi_bready => dsp_cav2_p1_window_stop_s_axi_bready,
    dsp_cav2_p1_window_stop_s_axi_araddr => dsp_cav2_p1_window_stop_s_axi_araddr,
    dsp_cav2_p1_window_stop_s_axi_arvalid => dsp_cav2_p1_window_stop_s_axi_arvalid,
    dsp_cav2_p1_window_stop_s_axi_arready => dsp_cav2_p1_window_stop_s_axi_arready,
    dsp_cav2_p1_window_stop_s_axi_rdata => dsp_cav2_p1_window_stop_s_axi_rdata,
    dsp_cav2_p1_window_stop_s_axi_rresp => dsp_cav2_p1_window_stop_s_axi_rresp,
    dsp_cav2_p1_window_stop_s_axi_rvalid => dsp_cav2_p1_window_stop_s_axi_rvalid,
    dsp_cav2_p1_window_stop_s_axi_rready => dsp_cav2_p1_window_stop_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p2_amp_out_axi_lite_interface is 
    port(
        cav2_p2_amp_out : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_amp_out_aclk : in std_logic;
        dsp_cav2_p2_amp_out_aresetn : in std_logic;
        dsp_cav2_p2_amp_out_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_amp_out_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_amp_out_s_axi_awready : out std_logic;
        dsp_cav2_p2_amp_out_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_amp_out_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_amp_out_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_amp_out_s_axi_wready : out std_logic;
        dsp_cav2_p2_amp_out_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_amp_out_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_amp_out_s_axi_bready : in std_logic;
        dsp_cav2_p2_amp_out_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_amp_out_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_amp_out_s_axi_arready : out std_logic;
        dsp_cav2_p2_amp_out_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_amp_out_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_amp_out_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_amp_out_s_axi_rready : in std_logic
    );
end dsp_cav2_p2_amp_out_axi_lite_interface;
architecture structural of dsp_cav2_p2_amp_out_axi_lite_interface is 
component dsp_cav2_p2_amp_out_axi_lite_interface_verilog is
    port(
        cav2_p2_amp_out : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_amp_out_aclk : in std_logic;
        dsp_cav2_p2_amp_out_aresetn : in std_logic;
        dsp_cav2_p2_amp_out_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_amp_out_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_amp_out_s_axi_awready : out std_logic;
        dsp_cav2_p2_amp_out_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_amp_out_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_amp_out_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_amp_out_s_axi_wready : out std_logic;
        dsp_cav2_p2_amp_out_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_amp_out_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_amp_out_s_axi_bready : in std_logic;
        dsp_cav2_p2_amp_out_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_amp_out_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_amp_out_s_axi_arready : out std_logic;
        dsp_cav2_p2_amp_out_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_amp_out_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_amp_out_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_amp_out_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p2_amp_out_axi_lite_interface_verilog
    port map(
    cav2_p2_amp_out => cav2_p2_amp_out,
    dsp_clk => dsp_clk,
    dsp_cav2_p2_amp_out_aclk => dsp_cav2_p2_amp_out_aclk,
    dsp_cav2_p2_amp_out_aresetn => dsp_cav2_p2_amp_out_aresetn,
    dsp_cav2_p2_amp_out_s_axi_awaddr => dsp_cav2_p2_amp_out_s_axi_awaddr,
    dsp_cav2_p2_amp_out_s_axi_awvalid => dsp_cav2_p2_amp_out_s_axi_awvalid,
    dsp_cav2_p2_amp_out_s_axi_awready => dsp_cav2_p2_amp_out_s_axi_awready,
    dsp_cav2_p2_amp_out_s_axi_wdata => dsp_cav2_p2_amp_out_s_axi_wdata,
    dsp_cav2_p2_amp_out_s_axi_wstrb => dsp_cav2_p2_amp_out_s_axi_wstrb,
    dsp_cav2_p2_amp_out_s_axi_wvalid => dsp_cav2_p2_amp_out_s_axi_wvalid,
    dsp_cav2_p2_amp_out_s_axi_wready => dsp_cav2_p2_amp_out_s_axi_wready,
    dsp_cav2_p2_amp_out_s_axi_bresp => dsp_cav2_p2_amp_out_s_axi_bresp,
    dsp_cav2_p2_amp_out_s_axi_bvalid => dsp_cav2_p2_amp_out_s_axi_bvalid,
    dsp_cav2_p2_amp_out_s_axi_bready => dsp_cav2_p2_amp_out_s_axi_bready,
    dsp_cav2_p2_amp_out_s_axi_araddr => dsp_cav2_p2_amp_out_s_axi_araddr,
    dsp_cav2_p2_amp_out_s_axi_arvalid => dsp_cav2_p2_amp_out_s_axi_arvalid,
    dsp_cav2_p2_amp_out_s_axi_arready => dsp_cav2_p2_amp_out_s_axi_arready,
    dsp_cav2_p2_amp_out_s_axi_rdata => dsp_cav2_p2_amp_out_s_axi_rdata,
    dsp_cav2_p2_amp_out_s_axi_rresp => dsp_cav2_p2_amp_out_s_axi_rresp,
    dsp_cav2_p2_amp_out_s_axi_rvalid => dsp_cav2_p2_amp_out_s_axi_rvalid,
    dsp_cav2_p2_amp_out_s_axi_rready => dsp_cav2_p2_amp_out_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p2_chan_sel_axi_lite_interface is 
    port(
        cav2_p2_chan_sel : out std_logic_vector(3 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_chan_sel_aclk : in std_logic;
        dsp_cav2_p2_chan_sel_aresetn : in std_logic;
        dsp_cav2_p2_chan_sel_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_chan_sel_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_chan_sel_s_axi_awready : out std_logic;
        dsp_cav2_p2_chan_sel_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_chan_sel_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_chan_sel_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_chan_sel_s_axi_wready : out std_logic;
        dsp_cav2_p2_chan_sel_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_chan_sel_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_chan_sel_s_axi_bready : in std_logic;
        dsp_cav2_p2_chan_sel_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_chan_sel_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_chan_sel_s_axi_arready : out std_logic;
        dsp_cav2_p2_chan_sel_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_chan_sel_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_chan_sel_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_chan_sel_s_axi_rready : in std_logic
    );
end dsp_cav2_p2_chan_sel_axi_lite_interface;
architecture structural of dsp_cav2_p2_chan_sel_axi_lite_interface is 
component dsp_cav2_p2_chan_sel_axi_lite_interface_verilog is
    port(
        cav2_p2_chan_sel : out std_logic_vector(3 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_chan_sel_aclk : in std_logic;
        dsp_cav2_p2_chan_sel_aresetn : in std_logic;
        dsp_cav2_p2_chan_sel_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_chan_sel_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_chan_sel_s_axi_awready : out std_logic;
        dsp_cav2_p2_chan_sel_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_chan_sel_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_chan_sel_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_chan_sel_s_axi_wready : out std_logic;
        dsp_cav2_p2_chan_sel_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_chan_sel_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_chan_sel_s_axi_bready : in std_logic;
        dsp_cav2_p2_chan_sel_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_chan_sel_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_chan_sel_s_axi_arready : out std_logic;
        dsp_cav2_p2_chan_sel_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_chan_sel_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_chan_sel_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_chan_sel_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p2_chan_sel_axi_lite_interface_verilog
    port map(
    cav2_p2_chan_sel => cav2_p2_chan_sel,
    dsp_clk => dsp_clk,
    dsp_cav2_p2_chan_sel_aclk => dsp_cav2_p2_chan_sel_aclk,
    dsp_cav2_p2_chan_sel_aresetn => dsp_cav2_p2_chan_sel_aresetn,
    dsp_cav2_p2_chan_sel_s_axi_awaddr => dsp_cav2_p2_chan_sel_s_axi_awaddr,
    dsp_cav2_p2_chan_sel_s_axi_awvalid => dsp_cav2_p2_chan_sel_s_axi_awvalid,
    dsp_cav2_p2_chan_sel_s_axi_awready => dsp_cav2_p2_chan_sel_s_axi_awready,
    dsp_cav2_p2_chan_sel_s_axi_wdata => dsp_cav2_p2_chan_sel_s_axi_wdata,
    dsp_cav2_p2_chan_sel_s_axi_wstrb => dsp_cav2_p2_chan_sel_s_axi_wstrb,
    dsp_cav2_p2_chan_sel_s_axi_wvalid => dsp_cav2_p2_chan_sel_s_axi_wvalid,
    dsp_cav2_p2_chan_sel_s_axi_wready => dsp_cav2_p2_chan_sel_s_axi_wready,
    dsp_cav2_p2_chan_sel_s_axi_bresp => dsp_cav2_p2_chan_sel_s_axi_bresp,
    dsp_cav2_p2_chan_sel_s_axi_bvalid => dsp_cav2_p2_chan_sel_s_axi_bvalid,
    dsp_cav2_p2_chan_sel_s_axi_bready => dsp_cav2_p2_chan_sel_s_axi_bready,
    dsp_cav2_p2_chan_sel_s_axi_araddr => dsp_cav2_p2_chan_sel_s_axi_araddr,
    dsp_cav2_p2_chan_sel_s_axi_arvalid => dsp_cav2_p2_chan_sel_s_axi_arvalid,
    dsp_cav2_p2_chan_sel_s_axi_arready => dsp_cav2_p2_chan_sel_s_axi_arready,
    dsp_cav2_p2_chan_sel_s_axi_rdata => dsp_cav2_p2_chan_sel_s_axi_rdata,
    dsp_cav2_p2_chan_sel_s_axi_rresp => dsp_cav2_p2_chan_sel_s_axi_rresp,
    dsp_cav2_p2_chan_sel_s_axi_rvalid => dsp_cav2_p2_chan_sel_s_axi_rvalid,
    dsp_cav2_p2_chan_sel_s_axi_rready => dsp_cav2_p2_chan_sel_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p2_comparison_i_axi_lite_interface is 
    port(
        cav2_p2_comparison_i : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_comparison_i_aclk : in std_logic;
        dsp_cav2_p2_comparison_i_aresetn : in std_logic;
        dsp_cav2_p2_comparison_i_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_comparison_i_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_comparison_i_s_axi_awready : out std_logic;
        dsp_cav2_p2_comparison_i_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_comparison_i_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_comparison_i_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_comparison_i_s_axi_wready : out std_logic;
        dsp_cav2_p2_comparison_i_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_comparison_i_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_comparison_i_s_axi_bready : in std_logic;
        dsp_cav2_p2_comparison_i_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_comparison_i_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_comparison_i_s_axi_arready : out std_logic;
        dsp_cav2_p2_comparison_i_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_comparison_i_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_comparison_i_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_comparison_i_s_axi_rready : in std_logic
    );
end dsp_cav2_p2_comparison_i_axi_lite_interface;
architecture structural of dsp_cav2_p2_comparison_i_axi_lite_interface is 
component dsp_cav2_p2_comparison_i_axi_lite_interface_verilog is
    port(
        cav2_p2_comparison_i : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_comparison_i_aclk : in std_logic;
        dsp_cav2_p2_comparison_i_aresetn : in std_logic;
        dsp_cav2_p2_comparison_i_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_comparison_i_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_comparison_i_s_axi_awready : out std_logic;
        dsp_cav2_p2_comparison_i_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_comparison_i_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_comparison_i_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_comparison_i_s_axi_wready : out std_logic;
        dsp_cav2_p2_comparison_i_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_comparison_i_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_comparison_i_s_axi_bready : in std_logic;
        dsp_cav2_p2_comparison_i_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_comparison_i_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_comparison_i_s_axi_arready : out std_logic;
        dsp_cav2_p2_comparison_i_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_comparison_i_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_comparison_i_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_comparison_i_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p2_comparison_i_axi_lite_interface_verilog
    port map(
    cav2_p2_comparison_i => cav2_p2_comparison_i,
    dsp_clk => dsp_clk,
    dsp_cav2_p2_comparison_i_aclk => dsp_cav2_p2_comparison_i_aclk,
    dsp_cav2_p2_comparison_i_aresetn => dsp_cav2_p2_comparison_i_aresetn,
    dsp_cav2_p2_comparison_i_s_axi_awaddr => dsp_cav2_p2_comparison_i_s_axi_awaddr,
    dsp_cav2_p2_comparison_i_s_axi_awvalid => dsp_cav2_p2_comparison_i_s_axi_awvalid,
    dsp_cav2_p2_comparison_i_s_axi_awready => dsp_cav2_p2_comparison_i_s_axi_awready,
    dsp_cav2_p2_comparison_i_s_axi_wdata => dsp_cav2_p2_comparison_i_s_axi_wdata,
    dsp_cav2_p2_comparison_i_s_axi_wstrb => dsp_cav2_p2_comparison_i_s_axi_wstrb,
    dsp_cav2_p2_comparison_i_s_axi_wvalid => dsp_cav2_p2_comparison_i_s_axi_wvalid,
    dsp_cav2_p2_comparison_i_s_axi_wready => dsp_cav2_p2_comparison_i_s_axi_wready,
    dsp_cav2_p2_comparison_i_s_axi_bresp => dsp_cav2_p2_comparison_i_s_axi_bresp,
    dsp_cav2_p2_comparison_i_s_axi_bvalid => dsp_cav2_p2_comparison_i_s_axi_bvalid,
    dsp_cav2_p2_comparison_i_s_axi_bready => dsp_cav2_p2_comparison_i_s_axi_bready,
    dsp_cav2_p2_comparison_i_s_axi_araddr => dsp_cav2_p2_comparison_i_s_axi_araddr,
    dsp_cav2_p2_comparison_i_s_axi_arvalid => dsp_cav2_p2_comparison_i_s_axi_arvalid,
    dsp_cav2_p2_comparison_i_s_axi_arready => dsp_cav2_p2_comparison_i_s_axi_arready,
    dsp_cav2_p2_comparison_i_s_axi_rdata => dsp_cav2_p2_comparison_i_s_axi_rdata,
    dsp_cav2_p2_comparison_i_s_axi_rresp => dsp_cav2_p2_comparison_i_s_axi_rresp,
    dsp_cav2_p2_comparison_i_s_axi_rvalid => dsp_cav2_p2_comparison_i_s_axi_rvalid,
    dsp_cav2_p2_comparison_i_s_axi_rready => dsp_cav2_p2_comparison_i_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p2_comparison_phase_axi_lite_interface is 
    port(
        cav2_p2_comparison_phase : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_comparison_phase_aclk : in std_logic;
        dsp_cav2_p2_comparison_phase_aresetn : in std_logic;
        dsp_cav2_p2_comparison_phase_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_comparison_phase_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_comparison_phase_s_axi_awready : out std_logic;
        dsp_cav2_p2_comparison_phase_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_comparison_phase_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_comparison_phase_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_comparison_phase_s_axi_wready : out std_logic;
        dsp_cav2_p2_comparison_phase_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_comparison_phase_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_comparison_phase_s_axi_bready : in std_logic;
        dsp_cav2_p2_comparison_phase_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_comparison_phase_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_comparison_phase_s_axi_arready : out std_logic;
        dsp_cav2_p2_comparison_phase_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_comparison_phase_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_comparison_phase_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_comparison_phase_s_axi_rready : in std_logic
    );
end dsp_cav2_p2_comparison_phase_axi_lite_interface;
architecture structural of dsp_cav2_p2_comparison_phase_axi_lite_interface is 
component dsp_cav2_p2_comparison_phase_axi_lite_interface_verilog is
    port(
        cav2_p2_comparison_phase : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_comparison_phase_aclk : in std_logic;
        dsp_cav2_p2_comparison_phase_aresetn : in std_logic;
        dsp_cav2_p2_comparison_phase_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_comparison_phase_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_comparison_phase_s_axi_awready : out std_logic;
        dsp_cav2_p2_comparison_phase_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_comparison_phase_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_comparison_phase_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_comparison_phase_s_axi_wready : out std_logic;
        dsp_cav2_p2_comparison_phase_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_comparison_phase_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_comparison_phase_s_axi_bready : in std_logic;
        dsp_cav2_p2_comparison_phase_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_comparison_phase_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_comparison_phase_s_axi_arready : out std_logic;
        dsp_cav2_p2_comparison_phase_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_comparison_phase_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_comparison_phase_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_comparison_phase_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p2_comparison_phase_axi_lite_interface_verilog
    port map(
    cav2_p2_comparison_phase => cav2_p2_comparison_phase,
    dsp_clk => dsp_clk,
    dsp_cav2_p2_comparison_phase_aclk => dsp_cav2_p2_comparison_phase_aclk,
    dsp_cav2_p2_comparison_phase_aresetn => dsp_cav2_p2_comparison_phase_aresetn,
    dsp_cav2_p2_comparison_phase_s_axi_awaddr => dsp_cav2_p2_comparison_phase_s_axi_awaddr,
    dsp_cav2_p2_comparison_phase_s_axi_awvalid => dsp_cav2_p2_comparison_phase_s_axi_awvalid,
    dsp_cav2_p2_comparison_phase_s_axi_awready => dsp_cav2_p2_comparison_phase_s_axi_awready,
    dsp_cav2_p2_comparison_phase_s_axi_wdata => dsp_cav2_p2_comparison_phase_s_axi_wdata,
    dsp_cav2_p2_comparison_phase_s_axi_wstrb => dsp_cav2_p2_comparison_phase_s_axi_wstrb,
    dsp_cav2_p2_comparison_phase_s_axi_wvalid => dsp_cav2_p2_comparison_phase_s_axi_wvalid,
    dsp_cav2_p2_comparison_phase_s_axi_wready => dsp_cav2_p2_comparison_phase_s_axi_wready,
    dsp_cav2_p2_comparison_phase_s_axi_bresp => dsp_cav2_p2_comparison_phase_s_axi_bresp,
    dsp_cav2_p2_comparison_phase_s_axi_bvalid => dsp_cav2_p2_comparison_phase_s_axi_bvalid,
    dsp_cav2_p2_comparison_phase_s_axi_bready => dsp_cav2_p2_comparison_phase_s_axi_bready,
    dsp_cav2_p2_comparison_phase_s_axi_araddr => dsp_cav2_p2_comparison_phase_s_axi_araddr,
    dsp_cav2_p2_comparison_phase_s_axi_arvalid => dsp_cav2_p2_comparison_phase_s_axi_arvalid,
    dsp_cav2_p2_comparison_phase_s_axi_arready => dsp_cav2_p2_comparison_phase_s_axi_arready,
    dsp_cav2_p2_comparison_phase_s_axi_rdata => dsp_cav2_p2_comparison_phase_s_axi_rdata,
    dsp_cav2_p2_comparison_phase_s_axi_rresp => dsp_cav2_p2_comparison_phase_s_axi_rresp,
    dsp_cav2_p2_comparison_phase_s_axi_rvalid => dsp_cav2_p2_comparison_phase_s_axi_rvalid,
    dsp_cav2_p2_comparison_phase_s_axi_rready => dsp_cav2_p2_comparison_phase_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p2_comparison_q_axi_lite_interface is 
    port(
        cav2_p2_comparison_q : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_comparison_q_aclk : in std_logic;
        dsp_cav2_p2_comparison_q_aresetn : in std_logic;
        dsp_cav2_p2_comparison_q_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_comparison_q_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_comparison_q_s_axi_awready : out std_logic;
        dsp_cav2_p2_comparison_q_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_comparison_q_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_comparison_q_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_comparison_q_s_axi_wready : out std_logic;
        dsp_cav2_p2_comparison_q_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_comparison_q_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_comparison_q_s_axi_bready : in std_logic;
        dsp_cav2_p2_comparison_q_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_comparison_q_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_comparison_q_s_axi_arready : out std_logic;
        dsp_cav2_p2_comparison_q_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_comparison_q_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_comparison_q_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_comparison_q_s_axi_rready : in std_logic
    );
end dsp_cav2_p2_comparison_q_axi_lite_interface;
architecture structural of dsp_cav2_p2_comparison_q_axi_lite_interface is 
component dsp_cav2_p2_comparison_q_axi_lite_interface_verilog is
    port(
        cav2_p2_comparison_q : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_comparison_q_aclk : in std_logic;
        dsp_cav2_p2_comparison_q_aresetn : in std_logic;
        dsp_cav2_p2_comparison_q_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_comparison_q_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_comparison_q_s_axi_awready : out std_logic;
        dsp_cav2_p2_comparison_q_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_comparison_q_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_comparison_q_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_comparison_q_s_axi_wready : out std_logic;
        dsp_cav2_p2_comparison_q_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_comparison_q_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_comparison_q_s_axi_bready : in std_logic;
        dsp_cav2_p2_comparison_q_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_comparison_q_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_comparison_q_s_axi_arready : out std_logic;
        dsp_cav2_p2_comparison_q_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_comparison_q_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_comparison_q_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_comparison_q_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p2_comparison_q_axi_lite_interface_verilog
    port map(
    cav2_p2_comparison_q => cav2_p2_comparison_q,
    dsp_clk => dsp_clk,
    dsp_cav2_p2_comparison_q_aclk => dsp_cav2_p2_comparison_q_aclk,
    dsp_cav2_p2_comparison_q_aresetn => dsp_cav2_p2_comparison_q_aresetn,
    dsp_cav2_p2_comparison_q_s_axi_awaddr => dsp_cav2_p2_comparison_q_s_axi_awaddr,
    dsp_cav2_p2_comparison_q_s_axi_awvalid => dsp_cav2_p2_comparison_q_s_axi_awvalid,
    dsp_cav2_p2_comparison_q_s_axi_awready => dsp_cav2_p2_comparison_q_s_axi_awready,
    dsp_cav2_p2_comparison_q_s_axi_wdata => dsp_cav2_p2_comparison_q_s_axi_wdata,
    dsp_cav2_p2_comparison_q_s_axi_wstrb => dsp_cav2_p2_comparison_q_s_axi_wstrb,
    dsp_cav2_p2_comparison_q_s_axi_wvalid => dsp_cav2_p2_comparison_q_s_axi_wvalid,
    dsp_cav2_p2_comparison_q_s_axi_wready => dsp_cav2_p2_comparison_q_s_axi_wready,
    dsp_cav2_p2_comparison_q_s_axi_bresp => dsp_cav2_p2_comparison_q_s_axi_bresp,
    dsp_cav2_p2_comparison_q_s_axi_bvalid => dsp_cav2_p2_comparison_q_s_axi_bvalid,
    dsp_cav2_p2_comparison_q_s_axi_bready => dsp_cav2_p2_comparison_q_s_axi_bready,
    dsp_cav2_p2_comparison_q_s_axi_araddr => dsp_cav2_p2_comparison_q_s_axi_araddr,
    dsp_cav2_p2_comparison_q_s_axi_arvalid => dsp_cav2_p2_comparison_q_s_axi_arvalid,
    dsp_cav2_p2_comparison_q_s_axi_arready => dsp_cav2_p2_comparison_q_s_axi_arready,
    dsp_cav2_p2_comparison_q_s_axi_rdata => dsp_cav2_p2_comparison_q_s_axi_rdata,
    dsp_cav2_p2_comparison_q_s_axi_rresp => dsp_cav2_p2_comparison_q_s_axi_rresp,
    dsp_cav2_p2_comparison_q_s_axi_rvalid => dsp_cav2_p2_comparison_q_s_axi_rvalid,
    dsp_cav2_p2_comparison_q_s_axi_rready => dsp_cav2_p2_comparison_q_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p2_dc_freq_axi_lite_interface is 
    port(
        cav2_p2_dc_freq : in std_logic_vector(25 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_dc_freq_aclk : in std_logic;
        dsp_cav2_p2_dc_freq_aresetn : in std_logic;
        dsp_cav2_p2_dc_freq_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_dc_freq_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_dc_freq_s_axi_awready : out std_logic;
        dsp_cav2_p2_dc_freq_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_dc_freq_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_dc_freq_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_dc_freq_s_axi_wready : out std_logic;
        dsp_cav2_p2_dc_freq_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_dc_freq_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_dc_freq_s_axi_bready : in std_logic;
        dsp_cav2_p2_dc_freq_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_dc_freq_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_dc_freq_s_axi_arready : out std_logic;
        dsp_cav2_p2_dc_freq_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_dc_freq_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_dc_freq_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_dc_freq_s_axi_rready : in std_logic
    );
end dsp_cav2_p2_dc_freq_axi_lite_interface;
architecture structural of dsp_cav2_p2_dc_freq_axi_lite_interface is 
component dsp_cav2_p2_dc_freq_axi_lite_interface_verilog is
    port(
        cav2_p2_dc_freq : in std_logic_vector(25 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_dc_freq_aclk : in std_logic;
        dsp_cav2_p2_dc_freq_aresetn : in std_logic;
        dsp_cav2_p2_dc_freq_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_dc_freq_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_dc_freq_s_axi_awready : out std_logic;
        dsp_cav2_p2_dc_freq_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_dc_freq_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_dc_freq_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_dc_freq_s_axi_wready : out std_logic;
        dsp_cav2_p2_dc_freq_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_dc_freq_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_dc_freq_s_axi_bready : in std_logic;
        dsp_cav2_p2_dc_freq_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_dc_freq_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_dc_freq_s_axi_arready : out std_logic;
        dsp_cav2_p2_dc_freq_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_dc_freq_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_dc_freq_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_dc_freq_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p2_dc_freq_axi_lite_interface_verilog
    port map(
    cav2_p2_dc_freq => cav2_p2_dc_freq,
    dsp_clk => dsp_clk,
    dsp_cav2_p2_dc_freq_aclk => dsp_cav2_p2_dc_freq_aclk,
    dsp_cav2_p2_dc_freq_aresetn => dsp_cav2_p2_dc_freq_aresetn,
    dsp_cav2_p2_dc_freq_s_axi_awaddr => dsp_cav2_p2_dc_freq_s_axi_awaddr,
    dsp_cav2_p2_dc_freq_s_axi_awvalid => dsp_cav2_p2_dc_freq_s_axi_awvalid,
    dsp_cav2_p2_dc_freq_s_axi_awready => dsp_cav2_p2_dc_freq_s_axi_awready,
    dsp_cav2_p2_dc_freq_s_axi_wdata => dsp_cav2_p2_dc_freq_s_axi_wdata,
    dsp_cav2_p2_dc_freq_s_axi_wstrb => dsp_cav2_p2_dc_freq_s_axi_wstrb,
    dsp_cav2_p2_dc_freq_s_axi_wvalid => dsp_cav2_p2_dc_freq_s_axi_wvalid,
    dsp_cav2_p2_dc_freq_s_axi_wready => dsp_cav2_p2_dc_freq_s_axi_wready,
    dsp_cav2_p2_dc_freq_s_axi_bresp => dsp_cav2_p2_dc_freq_s_axi_bresp,
    dsp_cav2_p2_dc_freq_s_axi_bvalid => dsp_cav2_p2_dc_freq_s_axi_bvalid,
    dsp_cav2_p2_dc_freq_s_axi_bready => dsp_cav2_p2_dc_freq_s_axi_bready,
    dsp_cav2_p2_dc_freq_s_axi_araddr => dsp_cav2_p2_dc_freq_s_axi_araddr,
    dsp_cav2_p2_dc_freq_s_axi_arvalid => dsp_cav2_p2_dc_freq_s_axi_arvalid,
    dsp_cav2_p2_dc_freq_s_axi_arready => dsp_cav2_p2_dc_freq_s_axi_arready,
    dsp_cav2_p2_dc_freq_s_axi_rdata => dsp_cav2_p2_dc_freq_s_axi_rdata,
    dsp_cav2_p2_dc_freq_s_axi_rresp => dsp_cav2_p2_dc_freq_s_axi_rresp,
    dsp_cav2_p2_dc_freq_s_axi_rvalid => dsp_cav2_p2_dc_freq_s_axi_rvalid,
    dsp_cav2_p2_dc_freq_s_axi_rready => dsp_cav2_p2_dc_freq_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p2_dc_img_axi_lite_interface is 
    port(
        cav2_p2_dc_img : in std_logic_vector(28 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_dc_img_aclk : in std_logic;
        dsp_cav2_p2_dc_img_aresetn : in std_logic;
        dsp_cav2_p2_dc_img_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_dc_img_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_dc_img_s_axi_awready : out std_logic;
        dsp_cav2_p2_dc_img_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_dc_img_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_dc_img_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_dc_img_s_axi_wready : out std_logic;
        dsp_cav2_p2_dc_img_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_dc_img_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_dc_img_s_axi_bready : in std_logic;
        dsp_cav2_p2_dc_img_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_dc_img_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_dc_img_s_axi_arready : out std_logic;
        dsp_cav2_p2_dc_img_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_dc_img_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_dc_img_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_dc_img_s_axi_rready : in std_logic
    );
end dsp_cav2_p2_dc_img_axi_lite_interface;
architecture structural of dsp_cav2_p2_dc_img_axi_lite_interface is 
component dsp_cav2_p2_dc_img_axi_lite_interface_verilog is
    port(
        cav2_p2_dc_img : in std_logic_vector(28 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_dc_img_aclk : in std_logic;
        dsp_cav2_p2_dc_img_aresetn : in std_logic;
        dsp_cav2_p2_dc_img_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_dc_img_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_dc_img_s_axi_awready : out std_logic;
        dsp_cav2_p2_dc_img_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_dc_img_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_dc_img_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_dc_img_s_axi_wready : out std_logic;
        dsp_cav2_p2_dc_img_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_dc_img_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_dc_img_s_axi_bready : in std_logic;
        dsp_cav2_p2_dc_img_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_dc_img_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_dc_img_s_axi_arready : out std_logic;
        dsp_cav2_p2_dc_img_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_dc_img_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_dc_img_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_dc_img_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p2_dc_img_axi_lite_interface_verilog
    port map(
    cav2_p2_dc_img => cav2_p2_dc_img,
    dsp_clk => dsp_clk,
    dsp_cav2_p2_dc_img_aclk => dsp_cav2_p2_dc_img_aclk,
    dsp_cav2_p2_dc_img_aresetn => dsp_cav2_p2_dc_img_aresetn,
    dsp_cav2_p2_dc_img_s_axi_awaddr => dsp_cav2_p2_dc_img_s_axi_awaddr,
    dsp_cav2_p2_dc_img_s_axi_awvalid => dsp_cav2_p2_dc_img_s_axi_awvalid,
    dsp_cav2_p2_dc_img_s_axi_awready => dsp_cav2_p2_dc_img_s_axi_awready,
    dsp_cav2_p2_dc_img_s_axi_wdata => dsp_cav2_p2_dc_img_s_axi_wdata,
    dsp_cav2_p2_dc_img_s_axi_wstrb => dsp_cav2_p2_dc_img_s_axi_wstrb,
    dsp_cav2_p2_dc_img_s_axi_wvalid => dsp_cav2_p2_dc_img_s_axi_wvalid,
    dsp_cav2_p2_dc_img_s_axi_wready => dsp_cav2_p2_dc_img_s_axi_wready,
    dsp_cav2_p2_dc_img_s_axi_bresp => dsp_cav2_p2_dc_img_s_axi_bresp,
    dsp_cav2_p2_dc_img_s_axi_bvalid => dsp_cav2_p2_dc_img_s_axi_bvalid,
    dsp_cav2_p2_dc_img_s_axi_bready => dsp_cav2_p2_dc_img_s_axi_bready,
    dsp_cav2_p2_dc_img_s_axi_araddr => dsp_cav2_p2_dc_img_s_axi_araddr,
    dsp_cav2_p2_dc_img_s_axi_arvalid => dsp_cav2_p2_dc_img_s_axi_arvalid,
    dsp_cav2_p2_dc_img_s_axi_arready => dsp_cav2_p2_dc_img_s_axi_arready,
    dsp_cav2_p2_dc_img_s_axi_rdata => dsp_cav2_p2_dc_img_s_axi_rdata,
    dsp_cav2_p2_dc_img_s_axi_rresp => dsp_cav2_p2_dc_img_s_axi_rresp,
    dsp_cav2_p2_dc_img_s_axi_rvalid => dsp_cav2_p2_dc_img_s_axi_rvalid,
    dsp_cav2_p2_dc_img_s_axi_rready => dsp_cav2_p2_dc_img_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p2_dc_real_axi_lite_interface is 
    port(
        cav2_p2_dc_real : in std_logic_vector(28 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_dc_real_aclk : in std_logic;
        dsp_cav2_p2_dc_real_aresetn : in std_logic;
        dsp_cav2_p2_dc_real_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_dc_real_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_dc_real_s_axi_awready : out std_logic;
        dsp_cav2_p2_dc_real_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_dc_real_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_dc_real_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_dc_real_s_axi_wready : out std_logic;
        dsp_cav2_p2_dc_real_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_dc_real_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_dc_real_s_axi_bready : in std_logic;
        dsp_cav2_p2_dc_real_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_dc_real_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_dc_real_s_axi_arready : out std_logic;
        dsp_cav2_p2_dc_real_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_dc_real_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_dc_real_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_dc_real_s_axi_rready : in std_logic
    );
end dsp_cav2_p2_dc_real_axi_lite_interface;
architecture structural of dsp_cav2_p2_dc_real_axi_lite_interface is 
component dsp_cav2_p2_dc_real_axi_lite_interface_verilog is
    port(
        cav2_p2_dc_real : in std_logic_vector(28 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_dc_real_aclk : in std_logic;
        dsp_cav2_p2_dc_real_aresetn : in std_logic;
        dsp_cav2_p2_dc_real_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_dc_real_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_dc_real_s_axi_awready : out std_logic;
        dsp_cav2_p2_dc_real_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_dc_real_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_dc_real_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_dc_real_s_axi_wready : out std_logic;
        dsp_cav2_p2_dc_real_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_dc_real_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_dc_real_s_axi_bready : in std_logic;
        dsp_cav2_p2_dc_real_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_dc_real_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_dc_real_s_axi_arready : out std_logic;
        dsp_cav2_p2_dc_real_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_dc_real_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_dc_real_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_dc_real_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p2_dc_real_axi_lite_interface_verilog
    port map(
    cav2_p2_dc_real => cav2_p2_dc_real,
    dsp_clk => dsp_clk,
    dsp_cav2_p2_dc_real_aclk => dsp_cav2_p2_dc_real_aclk,
    dsp_cav2_p2_dc_real_aresetn => dsp_cav2_p2_dc_real_aresetn,
    dsp_cav2_p2_dc_real_s_axi_awaddr => dsp_cav2_p2_dc_real_s_axi_awaddr,
    dsp_cav2_p2_dc_real_s_axi_awvalid => dsp_cav2_p2_dc_real_s_axi_awvalid,
    dsp_cav2_p2_dc_real_s_axi_awready => dsp_cav2_p2_dc_real_s_axi_awready,
    dsp_cav2_p2_dc_real_s_axi_wdata => dsp_cav2_p2_dc_real_s_axi_wdata,
    dsp_cav2_p2_dc_real_s_axi_wstrb => dsp_cav2_p2_dc_real_s_axi_wstrb,
    dsp_cav2_p2_dc_real_s_axi_wvalid => dsp_cav2_p2_dc_real_s_axi_wvalid,
    dsp_cav2_p2_dc_real_s_axi_wready => dsp_cav2_p2_dc_real_s_axi_wready,
    dsp_cav2_p2_dc_real_s_axi_bresp => dsp_cav2_p2_dc_real_s_axi_bresp,
    dsp_cav2_p2_dc_real_s_axi_bvalid => dsp_cav2_p2_dc_real_s_axi_bvalid,
    dsp_cav2_p2_dc_real_s_axi_bready => dsp_cav2_p2_dc_real_s_axi_bready,
    dsp_cav2_p2_dc_real_s_axi_araddr => dsp_cav2_p2_dc_real_s_axi_araddr,
    dsp_cav2_p2_dc_real_s_axi_arvalid => dsp_cav2_p2_dc_real_s_axi_arvalid,
    dsp_cav2_p2_dc_real_s_axi_arready => dsp_cav2_p2_dc_real_s_axi_arready,
    dsp_cav2_p2_dc_real_s_axi_rdata => dsp_cav2_p2_dc_real_s_axi_rdata,
    dsp_cav2_p2_dc_real_s_axi_rresp => dsp_cav2_p2_dc_real_s_axi_rresp,
    dsp_cav2_p2_dc_real_s_axi_rvalid => dsp_cav2_p2_dc_real_s_axi_rvalid,
    dsp_cav2_p2_dc_real_s_axi_rready => dsp_cav2_p2_dc_real_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p2_if_amp_axi_lite_interface is 
    port(
        cav2_p2_if_amp : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_if_amp_aclk : in std_logic;
        dsp_cav2_p2_if_amp_aresetn : in std_logic;
        dsp_cav2_p2_if_amp_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_if_amp_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_if_amp_s_axi_awready : out std_logic;
        dsp_cav2_p2_if_amp_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_if_amp_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_if_amp_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_if_amp_s_axi_wready : out std_logic;
        dsp_cav2_p2_if_amp_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_if_amp_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_if_amp_s_axi_bready : in std_logic;
        dsp_cav2_p2_if_amp_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_if_amp_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_if_amp_s_axi_arready : out std_logic;
        dsp_cav2_p2_if_amp_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_if_amp_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_if_amp_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_if_amp_s_axi_rready : in std_logic
    );
end dsp_cav2_p2_if_amp_axi_lite_interface;
architecture structural of dsp_cav2_p2_if_amp_axi_lite_interface is 
component dsp_cav2_p2_if_amp_axi_lite_interface_verilog is
    port(
        cav2_p2_if_amp : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_if_amp_aclk : in std_logic;
        dsp_cav2_p2_if_amp_aresetn : in std_logic;
        dsp_cav2_p2_if_amp_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_if_amp_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_if_amp_s_axi_awready : out std_logic;
        dsp_cav2_p2_if_amp_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_if_amp_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_if_amp_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_if_amp_s_axi_wready : out std_logic;
        dsp_cav2_p2_if_amp_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_if_amp_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_if_amp_s_axi_bready : in std_logic;
        dsp_cav2_p2_if_amp_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_if_amp_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_if_amp_s_axi_arready : out std_logic;
        dsp_cav2_p2_if_amp_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_if_amp_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_if_amp_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_if_amp_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p2_if_amp_axi_lite_interface_verilog
    port map(
    cav2_p2_if_amp => cav2_p2_if_amp,
    dsp_clk => dsp_clk,
    dsp_cav2_p2_if_amp_aclk => dsp_cav2_p2_if_amp_aclk,
    dsp_cav2_p2_if_amp_aresetn => dsp_cav2_p2_if_amp_aresetn,
    dsp_cav2_p2_if_amp_s_axi_awaddr => dsp_cav2_p2_if_amp_s_axi_awaddr,
    dsp_cav2_p2_if_amp_s_axi_awvalid => dsp_cav2_p2_if_amp_s_axi_awvalid,
    dsp_cav2_p2_if_amp_s_axi_awready => dsp_cav2_p2_if_amp_s_axi_awready,
    dsp_cav2_p2_if_amp_s_axi_wdata => dsp_cav2_p2_if_amp_s_axi_wdata,
    dsp_cav2_p2_if_amp_s_axi_wstrb => dsp_cav2_p2_if_amp_s_axi_wstrb,
    dsp_cav2_p2_if_amp_s_axi_wvalid => dsp_cav2_p2_if_amp_s_axi_wvalid,
    dsp_cav2_p2_if_amp_s_axi_wready => dsp_cav2_p2_if_amp_s_axi_wready,
    dsp_cav2_p2_if_amp_s_axi_bresp => dsp_cav2_p2_if_amp_s_axi_bresp,
    dsp_cav2_p2_if_amp_s_axi_bvalid => dsp_cav2_p2_if_amp_s_axi_bvalid,
    dsp_cav2_p2_if_amp_s_axi_bready => dsp_cav2_p2_if_amp_s_axi_bready,
    dsp_cav2_p2_if_amp_s_axi_araddr => dsp_cav2_p2_if_amp_s_axi_araddr,
    dsp_cav2_p2_if_amp_s_axi_arvalid => dsp_cav2_p2_if_amp_s_axi_arvalid,
    dsp_cav2_p2_if_amp_s_axi_arready => dsp_cav2_p2_if_amp_s_axi_arready,
    dsp_cav2_p2_if_amp_s_axi_rdata => dsp_cav2_p2_if_amp_s_axi_rdata,
    dsp_cav2_p2_if_amp_s_axi_rresp => dsp_cav2_p2_if_amp_s_axi_rresp,
    dsp_cav2_p2_if_amp_s_axi_rvalid => dsp_cav2_p2_if_amp_s_axi_rvalid,
    dsp_cav2_p2_if_amp_s_axi_rready => dsp_cav2_p2_if_amp_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p2_if_i_axi_lite_interface is 
    port(
        cav2_p2_if_i : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_if_i_aclk : in std_logic;
        dsp_cav2_p2_if_i_aresetn : in std_logic;
        dsp_cav2_p2_if_i_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_if_i_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_if_i_s_axi_awready : out std_logic;
        dsp_cav2_p2_if_i_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_if_i_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_if_i_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_if_i_s_axi_wready : out std_logic;
        dsp_cav2_p2_if_i_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_if_i_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_if_i_s_axi_bready : in std_logic;
        dsp_cav2_p2_if_i_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_if_i_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_if_i_s_axi_arready : out std_logic;
        dsp_cav2_p2_if_i_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_if_i_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_if_i_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_if_i_s_axi_rready : in std_logic
    );
end dsp_cav2_p2_if_i_axi_lite_interface;
architecture structural of dsp_cav2_p2_if_i_axi_lite_interface is 
component dsp_cav2_p2_if_i_axi_lite_interface_verilog is
    port(
        cav2_p2_if_i : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_if_i_aclk : in std_logic;
        dsp_cav2_p2_if_i_aresetn : in std_logic;
        dsp_cav2_p2_if_i_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_if_i_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_if_i_s_axi_awready : out std_logic;
        dsp_cav2_p2_if_i_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_if_i_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_if_i_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_if_i_s_axi_wready : out std_logic;
        dsp_cav2_p2_if_i_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_if_i_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_if_i_s_axi_bready : in std_logic;
        dsp_cav2_p2_if_i_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_if_i_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_if_i_s_axi_arready : out std_logic;
        dsp_cav2_p2_if_i_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_if_i_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_if_i_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_if_i_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p2_if_i_axi_lite_interface_verilog
    port map(
    cav2_p2_if_i => cav2_p2_if_i,
    dsp_clk => dsp_clk,
    dsp_cav2_p2_if_i_aclk => dsp_cav2_p2_if_i_aclk,
    dsp_cav2_p2_if_i_aresetn => dsp_cav2_p2_if_i_aresetn,
    dsp_cav2_p2_if_i_s_axi_awaddr => dsp_cav2_p2_if_i_s_axi_awaddr,
    dsp_cav2_p2_if_i_s_axi_awvalid => dsp_cav2_p2_if_i_s_axi_awvalid,
    dsp_cav2_p2_if_i_s_axi_awready => dsp_cav2_p2_if_i_s_axi_awready,
    dsp_cav2_p2_if_i_s_axi_wdata => dsp_cav2_p2_if_i_s_axi_wdata,
    dsp_cav2_p2_if_i_s_axi_wstrb => dsp_cav2_p2_if_i_s_axi_wstrb,
    dsp_cav2_p2_if_i_s_axi_wvalid => dsp_cav2_p2_if_i_s_axi_wvalid,
    dsp_cav2_p2_if_i_s_axi_wready => dsp_cav2_p2_if_i_s_axi_wready,
    dsp_cav2_p2_if_i_s_axi_bresp => dsp_cav2_p2_if_i_s_axi_bresp,
    dsp_cav2_p2_if_i_s_axi_bvalid => dsp_cav2_p2_if_i_s_axi_bvalid,
    dsp_cav2_p2_if_i_s_axi_bready => dsp_cav2_p2_if_i_s_axi_bready,
    dsp_cav2_p2_if_i_s_axi_araddr => dsp_cav2_p2_if_i_s_axi_araddr,
    dsp_cav2_p2_if_i_s_axi_arvalid => dsp_cav2_p2_if_i_s_axi_arvalid,
    dsp_cav2_p2_if_i_s_axi_arready => dsp_cav2_p2_if_i_s_axi_arready,
    dsp_cav2_p2_if_i_s_axi_rdata => dsp_cav2_p2_if_i_s_axi_rdata,
    dsp_cav2_p2_if_i_s_axi_rresp => dsp_cav2_p2_if_i_s_axi_rresp,
    dsp_cav2_p2_if_i_s_axi_rvalid => dsp_cav2_p2_if_i_s_axi_rvalid,
    dsp_cav2_p2_if_i_s_axi_rready => dsp_cav2_p2_if_i_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p2_if_phase_axi_lite_interface is 
    port(
        cav2_p2_if_phase : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_if_phase_aclk : in std_logic;
        dsp_cav2_p2_if_phase_aresetn : in std_logic;
        dsp_cav2_p2_if_phase_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_if_phase_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_if_phase_s_axi_awready : out std_logic;
        dsp_cav2_p2_if_phase_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_if_phase_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_if_phase_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_if_phase_s_axi_wready : out std_logic;
        dsp_cav2_p2_if_phase_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_if_phase_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_if_phase_s_axi_bready : in std_logic;
        dsp_cav2_p2_if_phase_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_if_phase_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_if_phase_s_axi_arready : out std_logic;
        dsp_cav2_p2_if_phase_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_if_phase_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_if_phase_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_if_phase_s_axi_rready : in std_logic
    );
end dsp_cav2_p2_if_phase_axi_lite_interface;
architecture structural of dsp_cav2_p2_if_phase_axi_lite_interface is 
component dsp_cav2_p2_if_phase_axi_lite_interface_verilog is
    port(
        cav2_p2_if_phase : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_if_phase_aclk : in std_logic;
        dsp_cav2_p2_if_phase_aresetn : in std_logic;
        dsp_cav2_p2_if_phase_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_if_phase_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_if_phase_s_axi_awready : out std_logic;
        dsp_cav2_p2_if_phase_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_if_phase_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_if_phase_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_if_phase_s_axi_wready : out std_logic;
        dsp_cav2_p2_if_phase_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_if_phase_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_if_phase_s_axi_bready : in std_logic;
        dsp_cav2_p2_if_phase_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_if_phase_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_if_phase_s_axi_arready : out std_logic;
        dsp_cav2_p2_if_phase_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_if_phase_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_if_phase_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_if_phase_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p2_if_phase_axi_lite_interface_verilog
    port map(
    cav2_p2_if_phase => cav2_p2_if_phase,
    dsp_clk => dsp_clk,
    dsp_cav2_p2_if_phase_aclk => dsp_cav2_p2_if_phase_aclk,
    dsp_cav2_p2_if_phase_aresetn => dsp_cav2_p2_if_phase_aresetn,
    dsp_cav2_p2_if_phase_s_axi_awaddr => dsp_cav2_p2_if_phase_s_axi_awaddr,
    dsp_cav2_p2_if_phase_s_axi_awvalid => dsp_cav2_p2_if_phase_s_axi_awvalid,
    dsp_cav2_p2_if_phase_s_axi_awready => dsp_cav2_p2_if_phase_s_axi_awready,
    dsp_cav2_p2_if_phase_s_axi_wdata => dsp_cav2_p2_if_phase_s_axi_wdata,
    dsp_cav2_p2_if_phase_s_axi_wstrb => dsp_cav2_p2_if_phase_s_axi_wstrb,
    dsp_cav2_p2_if_phase_s_axi_wvalid => dsp_cav2_p2_if_phase_s_axi_wvalid,
    dsp_cav2_p2_if_phase_s_axi_wready => dsp_cav2_p2_if_phase_s_axi_wready,
    dsp_cav2_p2_if_phase_s_axi_bresp => dsp_cav2_p2_if_phase_s_axi_bresp,
    dsp_cav2_p2_if_phase_s_axi_bvalid => dsp_cav2_p2_if_phase_s_axi_bvalid,
    dsp_cav2_p2_if_phase_s_axi_bready => dsp_cav2_p2_if_phase_s_axi_bready,
    dsp_cav2_p2_if_phase_s_axi_araddr => dsp_cav2_p2_if_phase_s_axi_araddr,
    dsp_cav2_p2_if_phase_s_axi_arvalid => dsp_cav2_p2_if_phase_s_axi_arvalid,
    dsp_cav2_p2_if_phase_s_axi_arready => dsp_cav2_p2_if_phase_s_axi_arready,
    dsp_cav2_p2_if_phase_s_axi_rdata => dsp_cav2_p2_if_phase_s_axi_rdata,
    dsp_cav2_p2_if_phase_s_axi_rresp => dsp_cav2_p2_if_phase_s_axi_rresp,
    dsp_cav2_p2_if_phase_s_axi_rvalid => dsp_cav2_p2_if_phase_s_axi_rvalid,
    dsp_cav2_p2_if_phase_s_axi_rready => dsp_cav2_p2_if_phase_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p1_comparison_phase_axi_lite_interface is 
    port(
        cav2_p1_comparison_phase : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_comparison_phase_aclk : in std_logic;
        dsp_cav2_p1_comparison_phase_aresetn : in std_logic;
        dsp_cav2_p1_comparison_phase_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_comparison_phase_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_comparison_phase_s_axi_awready : out std_logic;
        dsp_cav2_p1_comparison_phase_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_comparison_phase_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_comparison_phase_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_comparison_phase_s_axi_wready : out std_logic;
        dsp_cav2_p1_comparison_phase_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_comparison_phase_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_comparison_phase_s_axi_bready : in std_logic;
        dsp_cav2_p1_comparison_phase_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_comparison_phase_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_comparison_phase_s_axi_arready : out std_logic;
        dsp_cav2_p1_comparison_phase_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_comparison_phase_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_comparison_phase_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_comparison_phase_s_axi_rready : in std_logic
    );
end dsp_cav2_p1_comparison_phase_axi_lite_interface;
architecture structural of dsp_cav2_p1_comparison_phase_axi_lite_interface is 
component dsp_cav2_p1_comparison_phase_axi_lite_interface_verilog is
    port(
        cav2_p1_comparison_phase : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_comparison_phase_aclk : in std_logic;
        dsp_cav2_p1_comparison_phase_aresetn : in std_logic;
        dsp_cav2_p1_comparison_phase_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_comparison_phase_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_comparison_phase_s_axi_awready : out std_logic;
        dsp_cav2_p1_comparison_phase_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_comparison_phase_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_comparison_phase_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_comparison_phase_s_axi_wready : out std_logic;
        dsp_cav2_p1_comparison_phase_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_comparison_phase_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_comparison_phase_s_axi_bready : in std_logic;
        dsp_cav2_p1_comparison_phase_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_comparison_phase_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_comparison_phase_s_axi_arready : out std_logic;
        dsp_cav2_p1_comparison_phase_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_comparison_phase_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_comparison_phase_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_comparison_phase_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p1_comparison_phase_axi_lite_interface_verilog
    port map(
    cav2_p1_comparison_phase => cav2_p1_comparison_phase,
    dsp_clk => dsp_clk,
    dsp_cav2_p1_comparison_phase_aclk => dsp_cav2_p1_comparison_phase_aclk,
    dsp_cav2_p1_comparison_phase_aresetn => dsp_cav2_p1_comparison_phase_aresetn,
    dsp_cav2_p1_comparison_phase_s_axi_awaddr => dsp_cav2_p1_comparison_phase_s_axi_awaddr,
    dsp_cav2_p1_comparison_phase_s_axi_awvalid => dsp_cav2_p1_comparison_phase_s_axi_awvalid,
    dsp_cav2_p1_comparison_phase_s_axi_awready => dsp_cav2_p1_comparison_phase_s_axi_awready,
    dsp_cav2_p1_comparison_phase_s_axi_wdata => dsp_cav2_p1_comparison_phase_s_axi_wdata,
    dsp_cav2_p1_comparison_phase_s_axi_wstrb => dsp_cav2_p1_comparison_phase_s_axi_wstrb,
    dsp_cav2_p1_comparison_phase_s_axi_wvalid => dsp_cav2_p1_comparison_phase_s_axi_wvalid,
    dsp_cav2_p1_comparison_phase_s_axi_wready => dsp_cav2_p1_comparison_phase_s_axi_wready,
    dsp_cav2_p1_comparison_phase_s_axi_bresp => dsp_cav2_p1_comparison_phase_s_axi_bresp,
    dsp_cav2_p1_comparison_phase_s_axi_bvalid => dsp_cav2_p1_comparison_phase_s_axi_bvalid,
    dsp_cav2_p1_comparison_phase_s_axi_bready => dsp_cav2_p1_comparison_phase_s_axi_bready,
    dsp_cav2_p1_comparison_phase_s_axi_araddr => dsp_cav2_p1_comparison_phase_s_axi_araddr,
    dsp_cav2_p1_comparison_phase_s_axi_arvalid => dsp_cav2_p1_comparison_phase_s_axi_arvalid,
    dsp_cav2_p1_comparison_phase_s_axi_arready => dsp_cav2_p1_comparison_phase_s_axi_arready,
    dsp_cav2_p1_comparison_phase_s_axi_rdata => dsp_cav2_p1_comparison_phase_s_axi_rdata,
    dsp_cav2_p1_comparison_phase_s_axi_rresp => dsp_cav2_p1_comparison_phase_s_axi_rresp,
    dsp_cav2_p1_comparison_phase_s_axi_rvalid => dsp_cav2_p1_comparison_phase_s_axi_rvalid,
    dsp_cav2_p1_comparison_phase_s_axi_rready => dsp_cav2_p1_comparison_phase_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p1_comparison_q_axi_lite_interface is 
    port(
        cav1_p1_comparison_q_x0 : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_comparison_q_aclk : in std_logic;
        dsp_cav2_p1_comparison_q_aresetn : in std_logic;
        dsp_cav2_p1_comparison_q_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_comparison_q_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_comparison_q_s_axi_awready : out std_logic;
        dsp_cav2_p1_comparison_q_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_comparison_q_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_comparison_q_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_comparison_q_s_axi_wready : out std_logic;
        dsp_cav2_p1_comparison_q_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_comparison_q_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_comparison_q_s_axi_bready : in std_logic;
        dsp_cav2_p1_comparison_q_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_comparison_q_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_comparison_q_s_axi_arready : out std_logic;
        dsp_cav2_p1_comparison_q_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_comparison_q_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_comparison_q_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_comparison_q_s_axi_rready : in std_logic
    );
end dsp_cav2_p1_comparison_q_axi_lite_interface;
architecture structural of dsp_cav2_p1_comparison_q_axi_lite_interface is 
component dsp_cav2_p1_comparison_q_axi_lite_interface_verilog is
    port(
        cav1_p1_comparison_q_x0 : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p1_comparison_q_aclk : in std_logic;
        dsp_cav2_p1_comparison_q_aresetn : in std_logic;
        dsp_cav2_p1_comparison_q_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_comparison_q_s_axi_awvalid : in std_logic;
        dsp_cav2_p1_comparison_q_s_axi_awready : out std_logic;
        dsp_cav2_p1_comparison_q_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_comparison_q_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p1_comparison_q_s_axi_wvalid : in std_logic;
        dsp_cav2_p1_comparison_q_s_axi_wready : out std_logic;
        dsp_cav2_p1_comparison_q_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_comparison_q_s_axi_bvalid : out std_logic;
        dsp_cav2_p1_comparison_q_s_axi_bready : in std_logic;
        dsp_cav2_p1_comparison_q_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p1_comparison_q_s_axi_arvalid : in std_logic;
        dsp_cav2_p1_comparison_q_s_axi_arready : out std_logic;
        dsp_cav2_p1_comparison_q_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p1_comparison_q_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p1_comparison_q_s_axi_rvalid : out std_logic;
        dsp_cav2_p1_comparison_q_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p1_comparison_q_axi_lite_interface_verilog
    port map(
    cav1_p1_comparison_q_x0 => cav1_p1_comparison_q_x0,
    dsp_clk => dsp_clk,
    dsp_cav2_p1_comparison_q_aclk => dsp_cav2_p1_comparison_q_aclk,
    dsp_cav2_p1_comparison_q_aresetn => dsp_cav2_p1_comparison_q_aresetn,
    dsp_cav2_p1_comparison_q_s_axi_awaddr => dsp_cav2_p1_comparison_q_s_axi_awaddr,
    dsp_cav2_p1_comparison_q_s_axi_awvalid => dsp_cav2_p1_comparison_q_s_axi_awvalid,
    dsp_cav2_p1_comparison_q_s_axi_awready => dsp_cav2_p1_comparison_q_s_axi_awready,
    dsp_cav2_p1_comparison_q_s_axi_wdata => dsp_cav2_p1_comparison_q_s_axi_wdata,
    dsp_cav2_p1_comparison_q_s_axi_wstrb => dsp_cav2_p1_comparison_q_s_axi_wstrb,
    dsp_cav2_p1_comparison_q_s_axi_wvalid => dsp_cav2_p1_comparison_q_s_axi_wvalid,
    dsp_cav2_p1_comparison_q_s_axi_wready => dsp_cav2_p1_comparison_q_s_axi_wready,
    dsp_cav2_p1_comparison_q_s_axi_bresp => dsp_cav2_p1_comparison_q_s_axi_bresp,
    dsp_cav2_p1_comparison_q_s_axi_bvalid => dsp_cav2_p1_comparison_q_s_axi_bvalid,
    dsp_cav2_p1_comparison_q_s_axi_bready => dsp_cav2_p1_comparison_q_s_axi_bready,
    dsp_cav2_p1_comparison_q_s_axi_araddr => dsp_cav2_p1_comparison_q_s_axi_araddr,
    dsp_cav2_p1_comparison_q_s_axi_arvalid => dsp_cav2_p1_comparison_q_s_axi_arvalid,
    dsp_cav2_p1_comparison_q_s_axi_arready => dsp_cav2_p1_comparison_q_s_axi_arready,
    dsp_cav2_p1_comparison_q_s_axi_rdata => dsp_cav2_p1_comparison_q_s_axi_rdata,
    dsp_cav2_p1_comparison_q_s_axi_rresp => dsp_cav2_p1_comparison_q_s_axi_rresp,
    dsp_cav2_p1_comparison_q_s_axi_rvalid => dsp_cav2_p1_comparison_q_s_axi_rvalid,
    dsp_cav2_p1_comparison_q_s_axi_rready => dsp_cav2_p1_comparison_q_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p2_if_q_axi_lite_interface is 
    port(
        cav2_p2_if_q : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_if_q_aclk : in std_logic;
        dsp_cav2_p2_if_q_aresetn : in std_logic;
        dsp_cav2_p2_if_q_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_if_q_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_if_q_s_axi_awready : out std_logic;
        dsp_cav2_p2_if_q_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_if_q_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_if_q_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_if_q_s_axi_wready : out std_logic;
        dsp_cav2_p2_if_q_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_if_q_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_if_q_s_axi_bready : in std_logic;
        dsp_cav2_p2_if_q_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_if_q_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_if_q_s_axi_arready : out std_logic;
        dsp_cav2_p2_if_q_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_if_q_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_if_q_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_if_q_s_axi_rready : in std_logic
    );
end dsp_cav2_p2_if_q_axi_lite_interface;
architecture structural of dsp_cav2_p2_if_q_axi_lite_interface is 
component dsp_cav2_p2_if_q_axi_lite_interface_verilog is
    port(
        cav2_p2_if_q : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_if_q_aclk : in std_logic;
        dsp_cav2_p2_if_q_aresetn : in std_logic;
        dsp_cav2_p2_if_q_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_if_q_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_if_q_s_axi_awready : out std_logic;
        dsp_cav2_p2_if_q_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_if_q_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_if_q_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_if_q_s_axi_wready : out std_logic;
        dsp_cav2_p2_if_q_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_if_q_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_if_q_s_axi_bready : in std_logic;
        dsp_cav2_p2_if_q_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_if_q_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_if_q_s_axi_arready : out std_logic;
        dsp_cav2_p2_if_q_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_if_q_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_if_q_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_if_q_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p2_if_q_axi_lite_interface_verilog
    port map(
    cav2_p2_if_q => cav2_p2_if_q,
    dsp_clk => dsp_clk,
    dsp_cav2_p2_if_q_aclk => dsp_cav2_p2_if_q_aclk,
    dsp_cav2_p2_if_q_aresetn => dsp_cav2_p2_if_q_aresetn,
    dsp_cav2_p2_if_q_s_axi_awaddr => dsp_cav2_p2_if_q_s_axi_awaddr,
    dsp_cav2_p2_if_q_s_axi_awvalid => dsp_cav2_p2_if_q_s_axi_awvalid,
    dsp_cav2_p2_if_q_s_axi_awready => dsp_cav2_p2_if_q_s_axi_awready,
    dsp_cav2_p2_if_q_s_axi_wdata => dsp_cav2_p2_if_q_s_axi_wdata,
    dsp_cav2_p2_if_q_s_axi_wstrb => dsp_cav2_p2_if_q_s_axi_wstrb,
    dsp_cav2_p2_if_q_s_axi_wvalid => dsp_cav2_p2_if_q_s_axi_wvalid,
    dsp_cav2_p2_if_q_s_axi_wready => dsp_cav2_p2_if_q_s_axi_wready,
    dsp_cav2_p2_if_q_s_axi_bresp => dsp_cav2_p2_if_q_s_axi_bresp,
    dsp_cav2_p2_if_q_s_axi_bvalid => dsp_cav2_p2_if_q_s_axi_bvalid,
    dsp_cav2_p2_if_q_s_axi_bready => dsp_cav2_p2_if_q_s_axi_bready,
    dsp_cav2_p2_if_q_s_axi_araddr => dsp_cav2_p2_if_q_s_axi_araddr,
    dsp_cav2_p2_if_q_s_axi_arvalid => dsp_cav2_p2_if_q_s_axi_arvalid,
    dsp_cav2_p2_if_q_s_axi_arready => dsp_cav2_p2_if_q_s_axi_arready,
    dsp_cav2_p2_if_q_s_axi_rdata => dsp_cav2_p2_if_q_s_axi_rdata,
    dsp_cav2_p2_if_q_s_axi_rresp => dsp_cav2_p2_if_q_s_axi_rresp,
    dsp_cav2_p2_if_q_s_axi_rvalid => dsp_cav2_p2_if_q_s_axi_rvalid,
    dsp_cav2_p2_if_q_s_axi_rready => dsp_cav2_p2_if_q_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p2_integrated_i_axi_lite_interface is 
    port(
        cav2_p2_integrated_i : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_integrated_i_aclk : in std_logic;
        dsp_cav2_p2_integrated_i_aresetn : in std_logic;
        dsp_cav2_p2_integrated_i_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_integrated_i_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_integrated_i_s_axi_awready : out std_logic;
        dsp_cav2_p2_integrated_i_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_integrated_i_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_integrated_i_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_integrated_i_s_axi_wready : out std_logic;
        dsp_cav2_p2_integrated_i_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_integrated_i_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_integrated_i_s_axi_bready : in std_logic;
        dsp_cav2_p2_integrated_i_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_integrated_i_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_integrated_i_s_axi_arready : out std_logic;
        dsp_cav2_p2_integrated_i_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_integrated_i_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_integrated_i_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_integrated_i_s_axi_rready : in std_logic
    );
end dsp_cav2_p2_integrated_i_axi_lite_interface;
architecture structural of dsp_cav2_p2_integrated_i_axi_lite_interface is 
component dsp_cav2_p2_integrated_i_axi_lite_interface_verilog is
    port(
        cav2_p2_integrated_i : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_integrated_i_aclk : in std_logic;
        dsp_cav2_p2_integrated_i_aresetn : in std_logic;
        dsp_cav2_p2_integrated_i_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_integrated_i_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_integrated_i_s_axi_awready : out std_logic;
        dsp_cav2_p2_integrated_i_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_integrated_i_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_integrated_i_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_integrated_i_s_axi_wready : out std_logic;
        dsp_cav2_p2_integrated_i_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_integrated_i_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_integrated_i_s_axi_bready : in std_logic;
        dsp_cav2_p2_integrated_i_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_integrated_i_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_integrated_i_s_axi_arready : out std_logic;
        dsp_cav2_p2_integrated_i_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_integrated_i_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_integrated_i_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_integrated_i_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p2_integrated_i_axi_lite_interface_verilog
    port map(
    cav2_p2_integrated_i => cav2_p2_integrated_i,
    dsp_clk => dsp_clk,
    dsp_cav2_p2_integrated_i_aclk => dsp_cav2_p2_integrated_i_aclk,
    dsp_cav2_p2_integrated_i_aresetn => dsp_cav2_p2_integrated_i_aresetn,
    dsp_cav2_p2_integrated_i_s_axi_awaddr => dsp_cav2_p2_integrated_i_s_axi_awaddr,
    dsp_cav2_p2_integrated_i_s_axi_awvalid => dsp_cav2_p2_integrated_i_s_axi_awvalid,
    dsp_cav2_p2_integrated_i_s_axi_awready => dsp_cav2_p2_integrated_i_s_axi_awready,
    dsp_cav2_p2_integrated_i_s_axi_wdata => dsp_cav2_p2_integrated_i_s_axi_wdata,
    dsp_cav2_p2_integrated_i_s_axi_wstrb => dsp_cav2_p2_integrated_i_s_axi_wstrb,
    dsp_cav2_p2_integrated_i_s_axi_wvalid => dsp_cav2_p2_integrated_i_s_axi_wvalid,
    dsp_cav2_p2_integrated_i_s_axi_wready => dsp_cav2_p2_integrated_i_s_axi_wready,
    dsp_cav2_p2_integrated_i_s_axi_bresp => dsp_cav2_p2_integrated_i_s_axi_bresp,
    dsp_cav2_p2_integrated_i_s_axi_bvalid => dsp_cav2_p2_integrated_i_s_axi_bvalid,
    dsp_cav2_p2_integrated_i_s_axi_bready => dsp_cav2_p2_integrated_i_s_axi_bready,
    dsp_cav2_p2_integrated_i_s_axi_araddr => dsp_cav2_p2_integrated_i_s_axi_araddr,
    dsp_cav2_p2_integrated_i_s_axi_arvalid => dsp_cav2_p2_integrated_i_s_axi_arvalid,
    dsp_cav2_p2_integrated_i_s_axi_arready => dsp_cav2_p2_integrated_i_s_axi_arready,
    dsp_cav2_p2_integrated_i_s_axi_rdata => dsp_cav2_p2_integrated_i_s_axi_rdata,
    dsp_cav2_p2_integrated_i_s_axi_rresp => dsp_cav2_p2_integrated_i_s_axi_rresp,
    dsp_cav2_p2_integrated_i_s_axi_rvalid => dsp_cav2_p2_integrated_i_s_axi_rvalid,
    dsp_cav2_p2_integrated_i_s_axi_rready => dsp_cav2_p2_integrated_i_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p2_integrated_q_axi_lite_interface is 
    port(
        cav2_p2_integrated_q : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_integrated_q_aclk : in std_logic;
        dsp_cav2_p2_integrated_q_aresetn : in std_logic;
        dsp_cav2_p2_integrated_q_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_integrated_q_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_integrated_q_s_axi_awready : out std_logic;
        dsp_cav2_p2_integrated_q_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_integrated_q_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_integrated_q_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_integrated_q_s_axi_wready : out std_logic;
        dsp_cav2_p2_integrated_q_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_integrated_q_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_integrated_q_s_axi_bready : in std_logic;
        dsp_cav2_p2_integrated_q_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_integrated_q_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_integrated_q_s_axi_arready : out std_logic;
        dsp_cav2_p2_integrated_q_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_integrated_q_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_integrated_q_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_integrated_q_s_axi_rready : in std_logic
    );
end dsp_cav2_p2_integrated_q_axi_lite_interface;
architecture structural of dsp_cav2_p2_integrated_q_axi_lite_interface is 
component dsp_cav2_p2_integrated_q_axi_lite_interface_verilog is
    port(
        cav2_p2_integrated_q : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_integrated_q_aclk : in std_logic;
        dsp_cav2_p2_integrated_q_aresetn : in std_logic;
        dsp_cav2_p2_integrated_q_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_integrated_q_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_integrated_q_s_axi_awready : out std_logic;
        dsp_cav2_p2_integrated_q_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_integrated_q_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_integrated_q_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_integrated_q_s_axi_wready : out std_logic;
        dsp_cav2_p2_integrated_q_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_integrated_q_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_integrated_q_s_axi_bready : in std_logic;
        dsp_cav2_p2_integrated_q_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_integrated_q_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_integrated_q_s_axi_arready : out std_logic;
        dsp_cav2_p2_integrated_q_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_integrated_q_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_integrated_q_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_integrated_q_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p2_integrated_q_axi_lite_interface_verilog
    port map(
    cav2_p2_integrated_q => cav2_p2_integrated_q,
    dsp_clk => dsp_clk,
    dsp_cav2_p2_integrated_q_aclk => dsp_cav2_p2_integrated_q_aclk,
    dsp_cav2_p2_integrated_q_aresetn => dsp_cav2_p2_integrated_q_aresetn,
    dsp_cav2_p2_integrated_q_s_axi_awaddr => dsp_cav2_p2_integrated_q_s_axi_awaddr,
    dsp_cav2_p2_integrated_q_s_axi_awvalid => dsp_cav2_p2_integrated_q_s_axi_awvalid,
    dsp_cav2_p2_integrated_q_s_axi_awready => dsp_cav2_p2_integrated_q_s_axi_awready,
    dsp_cav2_p2_integrated_q_s_axi_wdata => dsp_cav2_p2_integrated_q_s_axi_wdata,
    dsp_cav2_p2_integrated_q_s_axi_wstrb => dsp_cav2_p2_integrated_q_s_axi_wstrb,
    dsp_cav2_p2_integrated_q_s_axi_wvalid => dsp_cav2_p2_integrated_q_s_axi_wvalid,
    dsp_cav2_p2_integrated_q_s_axi_wready => dsp_cav2_p2_integrated_q_s_axi_wready,
    dsp_cav2_p2_integrated_q_s_axi_bresp => dsp_cav2_p2_integrated_q_s_axi_bresp,
    dsp_cav2_p2_integrated_q_s_axi_bvalid => dsp_cav2_p2_integrated_q_s_axi_bvalid,
    dsp_cav2_p2_integrated_q_s_axi_bready => dsp_cav2_p2_integrated_q_s_axi_bready,
    dsp_cav2_p2_integrated_q_s_axi_araddr => dsp_cav2_p2_integrated_q_s_axi_araddr,
    dsp_cav2_p2_integrated_q_s_axi_arvalid => dsp_cav2_p2_integrated_q_s_axi_arvalid,
    dsp_cav2_p2_integrated_q_s_axi_arready => dsp_cav2_p2_integrated_q_s_axi_arready,
    dsp_cav2_p2_integrated_q_s_axi_rdata => dsp_cav2_p2_integrated_q_s_axi_rdata,
    dsp_cav2_p2_integrated_q_s_axi_rresp => dsp_cav2_p2_integrated_q_s_axi_rresp,
    dsp_cav2_p2_integrated_q_s_axi_rvalid => dsp_cav2_p2_integrated_q_s_axi_rvalid,
    dsp_cav2_p2_integrated_q_s_axi_rready => dsp_cav2_p2_integrated_q_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p2_phase_out_axi_lite_interface is 
    port(
        cav2_p2_phase_out : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_phase_out_aclk : in std_logic;
        dsp_cav2_p2_phase_out_aresetn : in std_logic;
        dsp_cav2_p2_phase_out_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_phase_out_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_phase_out_s_axi_awready : out std_logic;
        dsp_cav2_p2_phase_out_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_phase_out_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_phase_out_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_phase_out_s_axi_wready : out std_logic;
        dsp_cav2_p2_phase_out_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_phase_out_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_phase_out_s_axi_bready : in std_logic;
        dsp_cav2_p2_phase_out_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_phase_out_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_phase_out_s_axi_arready : out std_logic;
        dsp_cav2_p2_phase_out_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_phase_out_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_phase_out_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_phase_out_s_axi_rready : in std_logic
    );
end dsp_cav2_p2_phase_out_axi_lite_interface;
architecture structural of dsp_cav2_p2_phase_out_axi_lite_interface is 
component dsp_cav2_p2_phase_out_axi_lite_interface_verilog is
    port(
        cav2_p2_phase_out : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_phase_out_aclk : in std_logic;
        dsp_cav2_p2_phase_out_aresetn : in std_logic;
        dsp_cav2_p2_phase_out_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_phase_out_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_phase_out_s_axi_awready : out std_logic;
        dsp_cav2_p2_phase_out_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_phase_out_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_phase_out_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_phase_out_s_axi_wready : out std_logic;
        dsp_cav2_p2_phase_out_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_phase_out_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_phase_out_s_axi_bready : in std_logic;
        dsp_cav2_p2_phase_out_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_phase_out_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_phase_out_s_axi_arready : out std_logic;
        dsp_cav2_p2_phase_out_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_phase_out_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_phase_out_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_phase_out_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p2_phase_out_axi_lite_interface_verilog
    port map(
    cav2_p2_phase_out => cav2_p2_phase_out,
    dsp_clk => dsp_clk,
    dsp_cav2_p2_phase_out_aclk => dsp_cav2_p2_phase_out_aclk,
    dsp_cav2_p2_phase_out_aresetn => dsp_cav2_p2_phase_out_aresetn,
    dsp_cav2_p2_phase_out_s_axi_awaddr => dsp_cav2_p2_phase_out_s_axi_awaddr,
    dsp_cav2_p2_phase_out_s_axi_awvalid => dsp_cav2_p2_phase_out_s_axi_awvalid,
    dsp_cav2_p2_phase_out_s_axi_awready => dsp_cav2_p2_phase_out_s_axi_awready,
    dsp_cav2_p2_phase_out_s_axi_wdata => dsp_cav2_p2_phase_out_s_axi_wdata,
    dsp_cav2_p2_phase_out_s_axi_wstrb => dsp_cav2_p2_phase_out_s_axi_wstrb,
    dsp_cav2_p2_phase_out_s_axi_wvalid => dsp_cav2_p2_phase_out_s_axi_wvalid,
    dsp_cav2_p2_phase_out_s_axi_wready => dsp_cav2_p2_phase_out_s_axi_wready,
    dsp_cav2_p2_phase_out_s_axi_bresp => dsp_cav2_p2_phase_out_s_axi_bresp,
    dsp_cav2_p2_phase_out_s_axi_bvalid => dsp_cav2_p2_phase_out_s_axi_bvalid,
    dsp_cav2_p2_phase_out_s_axi_bready => dsp_cav2_p2_phase_out_s_axi_bready,
    dsp_cav2_p2_phase_out_s_axi_araddr => dsp_cav2_p2_phase_out_s_axi_araddr,
    dsp_cav2_p2_phase_out_s_axi_arvalid => dsp_cav2_p2_phase_out_s_axi_arvalid,
    dsp_cav2_p2_phase_out_s_axi_arready => dsp_cav2_p2_phase_out_s_axi_arready,
    dsp_cav2_p2_phase_out_s_axi_rdata => dsp_cav2_p2_phase_out_s_axi_rdata,
    dsp_cav2_p2_phase_out_s_axi_rresp => dsp_cav2_p2_phase_out_s_axi_rresp,
    dsp_cav2_p2_phase_out_s_axi_rvalid => dsp_cav2_p2_phase_out_s_axi_rvalid,
    dsp_cav2_p2_phase_out_s_axi_rready => dsp_cav2_p2_phase_out_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p2_window_start_axi_lite_interface is 
    port(
        cav2_p2_window_start : out std_logic_vector(15 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_window_start_aclk : in std_logic;
        dsp_cav2_p2_window_start_aresetn : in std_logic;
        dsp_cav2_p2_window_start_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_window_start_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_window_start_s_axi_awready : out std_logic;
        dsp_cav2_p2_window_start_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_window_start_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_window_start_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_window_start_s_axi_wready : out std_logic;
        dsp_cav2_p2_window_start_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_window_start_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_window_start_s_axi_bready : in std_logic;
        dsp_cav2_p2_window_start_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_window_start_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_window_start_s_axi_arready : out std_logic;
        dsp_cav2_p2_window_start_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_window_start_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_window_start_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_window_start_s_axi_rready : in std_logic
    );
end dsp_cav2_p2_window_start_axi_lite_interface;
architecture structural of dsp_cav2_p2_window_start_axi_lite_interface is 
component dsp_cav2_p2_window_start_axi_lite_interface_verilog is
    port(
        cav2_p2_window_start : out std_logic_vector(15 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_window_start_aclk : in std_logic;
        dsp_cav2_p2_window_start_aresetn : in std_logic;
        dsp_cav2_p2_window_start_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_window_start_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_window_start_s_axi_awready : out std_logic;
        dsp_cav2_p2_window_start_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_window_start_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_window_start_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_window_start_s_axi_wready : out std_logic;
        dsp_cav2_p2_window_start_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_window_start_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_window_start_s_axi_bready : in std_logic;
        dsp_cav2_p2_window_start_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_window_start_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_window_start_s_axi_arready : out std_logic;
        dsp_cav2_p2_window_start_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_window_start_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_window_start_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_window_start_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p2_window_start_axi_lite_interface_verilog
    port map(
    cav2_p2_window_start => cav2_p2_window_start,
    dsp_clk => dsp_clk,
    dsp_cav2_p2_window_start_aclk => dsp_cav2_p2_window_start_aclk,
    dsp_cav2_p2_window_start_aresetn => dsp_cav2_p2_window_start_aresetn,
    dsp_cav2_p2_window_start_s_axi_awaddr => dsp_cav2_p2_window_start_s_axi_awaddr,
    dsp_cav2_p2_window_start_s_axi_awvalid => dsp_cav2_p2_window_start_s_axi_awvalid,
    dsp_cav2_p2_window_start_s_axi_awready => dsp_cav2_p2_window_start_s_axi_awready,
    dsp_cav2_p2_window_start_s_axi_wdata => dsp_cav2_p2_window_start_s_axi_wdata,
    dsp_cav2_p2_window_start_s_axi_wstrb => dsp_cav2_p2_window_start_s_axi_wstrb,
    dsp_cav2_p2_window_start_s_axi_wvalid => dsp_cav2_p2_window_start_s_axi_wvalid,
    dsp_cav2_p2_window_start_s_axi_wready => dsp_cav2_p2_window_start_s_axi_wready,
    dsp_cav2_p2_window_start_s_axi_bresp => dsp_cav2_p2_window_start_s_axi_bresp,
    dsp_cav2_p2_window_start_s_axi_bvalid => dsp_cav2_p2_window_start_s_axi_bvalid,
    dsp_cav2_p2_window_start_s_axi_bready => dsp_cav2_p2_window_start_s_axi_bready,
    dsp_cav2_p2_window_start_s_axi_araddr => dsp_cav2_p2_window_start_s_axi_araddr,
    dsp_cav2_p2_window_start_s_axi_arvalid => dsp_cav2_p2_window_start_s_axi_arvalid,
    dsp_cav2_p2_window_start_s_axi_arready => dsp_cav2_p2_window_start_s_axi_arready,
    dsp_cav2_p2_window_start_s_axi_rdata => dsp_cav2_p2_window_start_s_axi_rdata,
    dsp_cav2_p2_window_start_s_axi_rresp => dsp_cav2_p2_window_start_s_axi_rresp,
    dsp_cav2_p2_window_start_s_axi_rvalid => dsp_cav2_p2_window_start_s_axi_rvalid,
    dsp_cav2_p2_window_start_s_axi_rready => dsp_cav2_p2_window_start_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_cav2_p2_window_stop_axi_lite_interface is 
    port(
        cav2_p2_window_stop : out std_logic_vector(15 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_window_stop_aclk : in std_logic;
        dsp_cav2_p2_window_stop_aresetn : in std_logic;
        dsp_cav2_p2_window_stop_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_window_stop_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_window_stop_s_axi_awready : out std_logic;
        dsp_cav2_p2_window_stop_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_window_stop_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_window_stop_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_window_stop_s_axi_wready : out std_logic;
        dsp_cav2_p2_window_stop_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_window_stop_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_window_stop_s_axi_bready : in std_logic;
        dsp_cav2_p2_window_stop_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_window_stop_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_window_stop_s_axi_arready : out std_logic;
        dsp_cav2_p2_window_stop_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_window_stop_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_window_stop_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_window_stop_s_axi_rready : in std_logic
    );
end dsp_cav2_p2_window_stop_axi_lite_interface;
architecture structural of dsp_cav2_p2_window_stop_axi_lite_interface is 
component dsp_cav2_p2_window_stop_axi_lite_interface_verilog is
    port(
        cav2_p2_window_stop : out std_logic_vector(15 downto 0);
        dsp_clk : out std_logic;
        dsp_cav2_p2_window_stop_aclk : in std_logic;
        dsp_cav2_p2_window_stop_aresetn : in std_logic;
        dsp_cav2_p2_window_stop_s_axi_awaddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_window_stop_s_axi_awvalid : in std_logic;
        dsp_cav2_p2_window_stop_s_axi_awready : out std_logic;
        dsp_cav2_p2_window_stop_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_window_stop_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_cav2_p2_window_stop_s_axi_wvalid : in std_logic;
        dsp_cav2_p2_window_stop_s_axi_wready : out std_logic;
        dsp_cav2_p2_window_stop_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_window_stop_s_axi_bvalid : out std_logic;
        dsp_cav2_p2_window_stop_s_axi_bready : in std_logic;
        dsp_cav2_p2_window_stop_s_axi_araddr : in std_logic_vector(10-1 downto 0);
        dsp_cav2_p2_window_stop_s_axi_arvalid : in std_logic;
        dsp_cav2_p2_window_stop_s_axi_arready : out std_logic;
        dsp_cav2_p2_window_stop_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_cav2_p2_window_stop_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_cav2_p2_window_stop_s_axi_rvalid : out std_logic;
        dsp_cav2_p2_window_stop_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_cav2_p2_window_stop_axi_lite_interface_verilog
    port map(
    cav2_p2_window_stop => cav2_p2_window_stop,
    dsp_clk => dsp_clk,
    dsp_cav2_p2_window_stop_aclk => dsp_cav2_p2_window_stop_aclk,
    dsp_cav2_p2_window_stop_aresetn => dsp_cav2_p2_window_stop_aresetn,
    dsp_cav2_p2_window_stop_s_axi_awaddr => dsp_cav2_p2_window_stop_s_axi_awaddr,
    dsp_cav2_p2_window_stop_s_axi_awvalid => dsp_cav2_p2_window_stop_s_axi_awvalid,
    dsp_cav2_p2_window_stop_s_axi_awready => dsp_cav2_p2_window_stop_s_axi_awready,
    dsp_cav2_p2_window_stop_s_axi_wdata => dsp_cav2_p2_window_stop_s_axi_wdata,
    dsp_cav2_p2_window_stop_s_axi_wstrb => dsp_cav2_p2_window_stop_s_axi_wstrb,
    dsp_cav2_p2_window_stop_s_axi_wvalid => dsp_cav2_p2_window_stop_s_axi_wvalid,
    dsp_cav2_p2_window_stop_s_axi_wready => dsp_cav2_p2_window_stop_s_axi_wready,
    dsp_cav2_p2_window_stop_s_axi_bresp => dsp_cav2_p2_window_stop_s_axi_bresp,
    dsp_cav2_p2_window_stop_s_axi_bvalid => dsp_cav2_p2_window_stop_s_axi_bvalid,
    dsp_cav2_p2_window_stop_s_axi_bready => dsp_cav2_p2_window_stop_s_axi_bready,
    dsp_cav2_p2_window_stop_s_axi_araddr => dsp_cav2_p2_window_stop_s_axi_araddr,
    dsp_cav2_p2_window_stop_s_axi_arvalid => dsp_cav2_p2_window_stop_s_axi_arvalid,
    dsp_cav2_p2_window_stop_s_axi_arready => dsp_cav2_p2_window_stop_s_axi_arready,
    dsp_cav2_p2_window_stop_s_axi_rdata => dsp_cav2_p2_window_stop_s_axi_rdata,
    dsp_cav2_p2_window_stop_s_axi_rresp => dsp_cav2_p2_window_stop_s_axi_rresp,
    dsp_cav2_p2_window_stop_s_axi_rvalid => dsp_cav2_p2_window_stop_s_axi_rvalid,
    dsp_cav2_p2_window_stop_s_axi_rready => dsp_cav2_p2_window_stop_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_ref_window_start_axi_lite_interface is 
    port(
        ref_window_start : out std_logic_vector(15 downto 0);
        dsp_clk : out std_logic;
        dsp_ref_window_start_aclk : in std_logic;
        dsp_ref_window_start_aresetn : in std_logic;
        dsp_ref_window_start_s_axi_awaddr : in std_logic_vector(5-1 downto 0);
        dsp_ref_window_start_s_axi_awvalid : in std_logic;
        dsp_ref_window_start_s_axi_awready : out std_logic;
        dsp_ref_window_start_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_ref_window_start_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_ref_window_start_s_axi_wvalid : in std_logic;
        dsp_ref_window_start_s_axi_wready : out std_logic;
        dsp_ref_window_start_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_ref_window_start_s_axi_bvalid : out std_logic;
        dsp_ref_window_start_s_axi_bready : in std_logic;
        dsp_ref_window_start_s_axi_araddr : in std_logic_vector(5-1 downto 0);
        dsp_ref_window_start_s_axi_arvalid : in std_logic;
        dsp_ref_window_start_s_axi_arready : out std_logic;
        dsp_ref_window_start_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_ref_window_start_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_ref_window_start_s_axi_rvalid : out std_logic;
        dsp_ref_window_start_s_axi_rready : in std_logic
    );
end dsp_ref_window_start_axi_lite_interface;
architecture structural of dsp_ref_window_start_axi_lite_interface is 
component dsp_ref_window_start_axi_lite_interface_verilog is
    port(
        ref_window_start : out std_logic_vector(15 downto 0);
        dsp_clk : out std_logic;
        dsp_ref_window_start_aclk : in std_logic;
        dsp_ref_window_start_aresetn : in std_logic;
        dsp_ref_window_start_s_axi_awaddr : in std_logic_vector(5-1 downto 0);
        dsp_ref_window_start_s_axi_awvalid : in std_logic;
        dsp_ref_window_start_s_axi_awready : out std_logic;
        dsp_ref_window_start_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_ref_window_start_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_ref_window_start_s_axi_wvalid : in std_logic;
        dsp_ref_window_start_s_axi_wready : out std_logic;
        dsp_ref_window_start_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_ref_window_start_s_axi_bvalid : out std_logic;
        dsp_ref_window_start_s_axi_bready : in std_logic;
        dsp_ref_window_start_s_axi_araddr : in std_logic_vector(5-1 downto 0);
        dsp_ref_window_start_s_axi_arvalid : in std_logic;
        dsp_ref_window_start_s_axi_arready : out std_logic;
        dsp_ref_window_start_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_ref_window_start_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_ref_window_start_s_axi_rvalid : out std_logic;
        dsp_ref_window_start_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_ref_window_start_axi_lite_interface_verilog
    port map(
    ref_window_start => ref_window_start,
    dsp_clk => dsp_clk,
    dsp_ref_window_start_aclk => dsp_ref_window_start_aclk,
    dsp_ref_window_start_aresetn => dsp_ref_window_start_aresetn,
    dsp_ref_window_start_s_axi_awaddr => dsp_ref_window_start_s_axi_awaddr,
    dsp_ref_window_start_s_axi_awvalid => dsp_ref_window_start_s_axi_awvalid,
    dsp_ref_window_start_s_axi_awready => dsp_ref_window_start_s_axi_awready,
    dsp_ref_window_start_s_axi_wdata => dsp_ref_window_start_s_axi_wdata,
    dsp_ref_window_start_s_axi_wstrb => dsp_ref_window_start_s_axi_wstrb,
    dsp_ref_window_start_s_axi_wvalid => dsp_ref_window_start_s_axi_wvalid,
    dsp_ref_window_start_s_axi_wready => dsp_ref_window_start_s_axi_wready,
    dsp_ref_window_start_s_axi_bresp => dsp_ref_window_start_s_axi_bresp,
    dsp_ref_window_start_s_axi_bvalid => dsp_ref_window_start_s_axi_bvalid,
    dsp_ref_window_start_s_axi_bready => dsp_ref_window_start_s_axi_bready,
    dsp_ref_window_start_s_axi_araddr => dsp_ref_window_start_s_axi_araddr,
    dsp_ref_window_start_s_axi_arvalid => dsp_ref_window_start_s_axi_arvalid,
    dsp_ref_window_start_s_axi_arready => dsp_ref_window_start_s_axi_arready,
    dsp_ref_window_start_s_axi_rdata => dsp_ref_window_start_s_axi_rdata,
    dsp_ref_window_start_s_axi_rresp => dsp_ref_window_start_s_axi_rresp,
    dsp_ref_window_start_s_axi_rvalid => dsp_ref_window_start_s_axi_rvalid,
    dsp_ref_window_start_s_axi_rready => dsp_ref_window_start_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_ref_window_stop_axi_lite_interface is 
    port(
        ref_window_stop : out std_logic_vector(15 downto 0);
        dsp_clk : out std_logic;
        dsp_ref_window_stop_aclk : in std_logic;
        dsp_ref_window_stop_aresetn : in std_logic;
        dsp_ref_window_stop_s_axi_awaddr : in std_logic_vector(5-1 downto 0);
        dsp_ref_window_stop_s_axi_awvalid : in std_logic;
        dsp_ref_window_stop_s_axi_awready : out std_logic;
        dsp_ref_window_stop_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_ref_window_stop_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_ref_window_stop_s_axi_wvalid : in std_logic;
        dsp_ref_window_stop_s_axi_wready : out std_logic;
        dsp_ref_window_stop_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_ref_window_stop_s_axi_bvalid : out std_logic;
        dsp_ref_window_stop_s_axi_bready : in std_logic;
        dsp_ref_window_stop_s_axi_araddr : in std_logic_vector(5-1 downto 0);
        dsp_ref_window_stop_s_axi_arvalid : in std_logic;
        dsp_ref_window_stop_s_axi_arready : out std_logic;
        dsp_ref_window_stop_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_ref_window_stop_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_ref_window_stop_s_axi_rvalid : out std_logic;
        dsp_ref_window_stop_s_axi_rready : in std_logic
    );
end dsp_ref_window_stop_axi_lite_interface;
architecture structural of dsp_ref_window_stop_axi_lite_interface is 
component dsp_ref_window_stop_axi_lite_interface_verilog is
    port(
        ref_window_stop : out std_logic_vector(15 downto 0);
        dsp_clk : out std_logic;
        dsp_ref_window_stop_aclk : in std_logic;
        dsp_ref_window_stop_aresetn : in std_logic;
        dsp_ref_window_stop_s_axi_awaddr : in std_logic_vector(5-1 downto 0);
        dsp_ref_window_stop_s_axi_awvalid : in std_logic;
        dsp_ref_window_stop_s_axi_awready : out std_logic;
        dsp_ref_window_stop_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_ref_window_stop_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_ref_window_stop_s_axi_wvalid : in std_logic;
        dsp_ref_window_stop_s_axi_wready : out std_logic;
        dsp_ref_window_stop_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_ref_window_stop_s_axi_bvalid : out std_logic;
        dsp_ref_window_stop_s_axi_bready : in std_logic;
        dsp_ref_window_stop_s_axi_araddr : in std_logic_vector(5-1 downto 0);
        dsp_ref_window_stop_s_axi_arvalid : in std_logic;
        dsp_ref_window_stop_s_axi_arready : out std_logic;
        dsp_ref_window_stop_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_ref_window_stop_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_ref_window_stop_s_axi_rvalid : out std_logic;
        dsp_ref_window_stop_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_ref_window_stop_axi_lite_interface_verilog
    port map(
    ref_window_stop => ref_window_stop,
    dsp_clk => dsp_clk,
    dsp_ref_window_stop_aclk => dsp_ref_window_stop_aclk,
    dsp_ref_window_stop_aresetn => dsp_ref_window_stop_aresetn,
    dsp_ref_window_stop_s_axi_awaddr => dsp_ref_window_stop_s_axi_awaddr,
    dsp_ref_window_stop_s_axi_awvalid => dsp_ref_window_stop_s_axi_awvalid,
    dsp_ref_window_stop_s_axi_awready => dsp_ref_window_stop_s_axi_awready,
    dsp_ref_window_stop_s_axi_wdata => dsp_ref_window_stop_s_axi_wdata,
    dsp_ref_window_stop_s_axi_wstrb => dsp_ref_window_stop_s_axi_wstrb,
    dsp_ref_window_stop_s_axi_wvalid => dsp_ref_window_stop_s_axi_wvalid,
    dsp_ref_window_stop_s_axi_wready => dsp_ref_window_stop_s_axi_wready,
    dsp_ref_window_stop_s_axi_bresp => dsp_ref_window_stop_s_axi_bresp,
    dsp_ref_window_stop_s_axi_bvalid => dsp_ref_window_stop_s_axi_bvalid,
    dsp_ref_window_stop_s_axi_bready => dsp_ref_window_stop_s_axi_bready,
    dsp_ref_window_stop_s_axi_araddr => dsp_ref_window_stop_s_axi_araddr,
    dsp_ref_window_stop_s_axi_arvalid => dsp_ref_window_stop_s_axi_arvalid,
    dsp_ref_window_stop_s_axi_arready => dsp_ref_window_stop_s_axi_arready,
    dsp_ref_window_stop_s_axi_rdata => dsp_ref_window_stop_s_axi_rdata,
    dsp_ref_window_stop_s_axi_rresp => dsp_ref_window_stop_s_axi_rresp,
    dsp_ref_window_stop_s_axi_rvalid => dsp_ref_window_stop_s_axi_rvalid,
    dsp_ref_window_stop_s_axi_rready => dsp_ref_window_stop_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_rf_ref_amp_axi_lite_interface is 
    port(
        rf_ref_amp : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_rf_ref_amp_aclk : in std_logic;
        dsp_rf_ref_amp_aresetn : in std_logic;
        dsp_rf_ref_amp_s_axi_awaddr : in std_logic;
        dsp_rf_ref_amp_s_axi_awvalid : in std_logic;
        dsp_rf_ref_amp_s_axi_awready : out std_logic;
        dsp_rf_ref_amp_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_rf_ref_amp_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_rf_ref_amp_s_axi_wvalid : in std_logic;
        dsp_rf_ref_amp_s_axi_wready : out std_logic;
        dsp_rf_ref_amp_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_rf_ref_amp_s_axi_bvalid : out std_logic;
        dsp_rf_ref_amp_s_axi_bready : in std_logic;
        dsp_rf_ref_amp_s_axi_araddr : in std_logic;
        dsp_rf_ref_amp_s_axi_arvalid : in std_logic;
        dsp_rf_ref_amp_s_axi_arready : out std_logic;
        dsp_rf_ref_amp_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_rf_ref_amp_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_rf_ref_amp_s_axi_rvalid : out std_logic;
        dsp_rf_ref_amp_s_axi_rready : in std_logic
    );
end dsp_rf_ref_amp_axi_lite_interface;
architecture structural of dsp_rf_ref_amp_axi_lite_interface is 
component dsp_rf_ref_amp_axi_lite_interface_verilog is
    port(
        rf_ref_amp : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_rf_ref_amp_aclk : in std_logic;
        dsp_rf_ref_amp_aresetn : in std_logic;
        dsp_rf_ref_amp_s_axi_awaddr : in std_logic;
        dsp_rf_ref_amp_s_axi_awvalid : in std_logic;
        dsp_rf_ref_amp_s_axi_awready : out std_logic;
        dsp_rf_ref_amp_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_rf_ref_amp_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_rf_ref_amp_s_axi_wvalid : in std_logic;
        dsp_rf_ref_amp_s_axi_wready : out std_logic;
        dsp_rf_ref_amp_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_rf_ref_amp_s_axi_bvalid : out std_logic;
        dsp_rf_ref_amp_s_axi_bready : in std_logic;
        dsp_rf_ref_amp_s_axi_araddr : in std_logic;
        dsp_rf_ref_amp_s_axi_arvalid : in std_logic;
        dsp_rf_ref_amp_s_axi_arready : out std_logic;
        dsp_rf_ref_amp_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_rf_ref_amp_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_rf_ref_amp_s_axi_rvalid : out std_logic;
        dsp_rf_ref_amp_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_rf_ref_amp_axi_lite_interface_verilog
    port map(
    rf_ref_amp => rf_ref_amp,
    dsp_clk => dsp_clk,
    dsp_rf_ref_amp_aclk => dsp_rf_ref_amp_aclk,
    dsp_rf_ref_amp_aresetn => dsp_rf_ref_amp_aresetn,
    dsp_rf_ref_amp_s_axi_awaddr => dsp_rf_ref_amp_s_axi_awaddr,
    dsp_rf_ref_amp_s_axi_awvalid => dsp_rf_ref_amp_s_axi_awvalid,
    dsp_rf_ref_amp_s_axi_awready => dsp_rf_ref_amp_s_axi_awready,
    dsp_rf_ref_amp_s_axi_wdata => dsp_rf_ref_amp_s_axi_wdata,
    dsp_rf_ref_amp_s_axi_wstrb => dsp_rf_ref_amp_s_axi_wstrb,
    dsp_rf_ref_amp_s_axi_wvalid => dsp_rf_ref_amp_s_axi_wvalid,
    dsp_rf_ref_amp_s_axi_wready => dsp_rf_ref_amp_s_axi_wready,
    dsp_rf_ref_amp_s_axi_bresp => dsp_rf_ref_amp_s_axi_bresp,
    dsp_rf_ref_amp_s_axi_bvalid => dsp_rf_ref_amp_s_axi_bvalid,
    dsp_rf_ref_amp_s_axi_bready => dsp_rf_ref_amp_s_axi_bready,
    dsp_rf_ref_amp_s_axi_araddr => dsp_rf_ref_amp_s_axi_araddr,
    dsp_rf_ref_amp_s_axi_arvalid => dsp_rf_ref_amp_s_axi_arvalid,
    dsp_rf_ref_amp_s_axi_arready => dsp_rf_ref_amp_s_axi_arready,
    dsp_rf_ref_amp_s_axi_rdata => dsp_rf_ref_amp_s_axi_rdata,
    dsp_rf_ref_amp_s_axi_rresp => dsp_rf_ref_amp_s_axi_rresp,
    dsp_rf_ref_amp_s_axi_rvalid => dsp_rf_ref_amp_s_axi_rvalid,
    dsp_rf_ref_amp_s_axi_rready => dsp_rf_ref_amp_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_rf_ref_chan_sel_axi_lite_interface is 
    port(
        rf_ref_chan_sel : out std_logic_vector(3 downto 0);
        dsp_clk : out std_logic;
        dsp_rf_ref_chan_sel_aclk : in std_logic;
        dsp_rf_ref_chan_sel_aresetn : in std_logic;
        dsp_rf_ref_chan_sel_s_axi_awaddr : in std_logic_vector(5-1 downto 0);
        dsp_rf_ref_chan_sel_s_axi_awvalid : in std_logic;
        dsp_rf_ref_chan_sel_s_axi_awready : out std_logic;
        dsp_rf_ref_chan_sel_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_rf_ref_chan_sel_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_rf_ref_chan_sel_s_axi_wvalid : in std_logic;
        dsp_rf_ref_chan_sel_s_axi_wready : out std_logic;
        dsp_rf_ref_chan_sel_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_rf_ref_chan_sel_s_axi_bvalid : out std_logic;
        dsp_rf_ref_chan_sel_s_axi_bready : in std_logic;
        dsp_rf_ref_chan_sel_s_axi_araddr : in std_logic_vector(5-1 downto 0);
        dsp_rf_ref_chan_sel_s_axi_arvalid : in std_logic;
        dsp_rf_ref_chan_sel_s_axi_arready : out std_logic;
        dsp_rf_ref_chan_sel_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_rf_ref_chan_sel_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_rf_ref_chan_sel_s_axi_rvalid : out std_logic;
        dsp_rf_ref_chan_sel_s_axi_rready : in std_logic
    );
end dsp_rf_ref_chan_sel_axi_lite_interface;
architecture structural of dsp_rf_ref_chan_sel_axi_lite_interface is 
component dsp_rf_ref_chan_sel_axi_lite_interface_verilog is
    port(
        rf_ref_chan_sel : out std_logic_vector(3 downto 0);
        dsp_clk : out std_logic;
        dsp_rf_ref_chan_sel_aclk : in std_logic;
        dsp_rf_ref_chan_sel_aresetn : in std_logic;
        dsp_rf_ref_chan_sel_s_axi_awaddr : in std_logic_vector(5-1 downto 0);
        dsp_rf_ref_chan_sel_s_axi_awvalid : in std_logic;
        dsp_rf_ref_chan_sel_s_axi_awready : out std_logic;
        dsp_rf_ref_chan_sel_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_rf_ref_chan_sel_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_rf_ref_chan_sel_s_axi_wvalid : in std_logic;
        dsp_rf_ref_chan_sel_s_axi_wready : out std_logic;
        dsp_rf_ref_chan_sel_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_rf_ref_chan_sel_s_axi_bvalid : out std_logic;
        dsp_rf_ref_chan_sel_s_axi_bready : in std_logic;
        dsp_rf_ref_chan_sel_s_axi_araddr : in std_logic_vector(5-1 downto 0);
        dsp_rf_ref_chan_sel_s_axi_arvalid : in std_logic;
        dsp_rf_ref_chan_sel_s_axi_arready : out std_logic;
        dsp_rf_ref_chan_sel_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_rf_ref_chan_sel_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_rf_ref_chan_sel_s_axi_rvalid : out std_logic;
        dsp_rf_ref_chan_sel_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_rf_ref_chan_sel_axi_lite_interface_verilog
    port map(
    rf_ref_chan_sel => rf_ref_chan_sel,
    dsp_clk => dsp_clk,
    dsp_rf_ref_chan_sel_aclk => dsp_rf_ref_chan_sel_aclk,
    dsp_rf_ref_chan_sel_aresetn => dsp_rf_ref_chan_sel_aresetn,
    dsp_rf_ref_chan_sel_s_axi_awaddr => dsp_rf_ref_chan_sel_s_axi_awaddr,
    dsp_rf_ref_chan_sel_s_axi_awvalid => dsp_rf_ref_chan_sel_s_axi_awvalid,
    dsp_rf_ref_chan_sel_s_axi_awready => dsp_rf_ref_chan_sel_s_axi_awready,
    dsp_rf_ref_chan_sel_s_axi_wdata => dsp_rf_ref_chan_sel_s_axi_wdata,
    dsp_rf_ref_chan_sel_s_axi_wstrb => dsp_rf_ref_chan_sel_s_axi_wstrb,
    dsp_rf_ref_chan_sel_s_axi_wvalid => dsp_rf_ref_chan_sel_s_axi_wvalid,
    dsp_rf_ref_chan_sel_s_axi_wready => dsp_rf_ref_chan_sel_s_axi_wready,
    dsp_rf_ref_chan_sel_s_axi_bresp => dsp_rf_ref_chan_sel_s_axi_bresp,
    dsp_rf_ref_chan_sel_s_axi_bvalid => dsp_rf_ref_chan_sel_s_axi_bvalid,
    dsp_rf_ref_chan_sel_s_axi_bready => dsp_rf_ref_chan_sel_s_axi_bready,
    dsp_rf_ref_chan_sel_s_axi_araddr => dsp_rf_ref_chan_sel_s_axi_araddr,
    dsp_rf_ref_chan_sel_s_axi_arvalid => dsp_rf_ref_chan_sel_s_axi_arvalid,
    dsp_rf_ref_chan_sel_s_axi_arready => dsp_rf_ref_chan_sel_s_axi_arready,
    dsp_rf_ref_chan_sel_s_axi_rdata => dsp_rf_ref_chan_sel_s_axi_rdata,
    dsp_rf_ref_chan_sel_s_axi_rresp => dsp_rf_ref_chan_sel_s_axi_rresp,
    dsp_rf_ref_chan_sel_s_axi_rvalid => dsp_rf_ref_chan_sel_s_axi_rvalid,
    dsp_rf_ref_chan_sel_s_axi_rready => dsp_rf_ref_chan_sel_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_rf_ref_i_axi_lite_interface is 
    port(
        rf_ref_i : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_rf_ref_i_aclk : in std_logic;
        dsp_rf_ref_i_aresetn : in std_logic;
        dsp_rf_ref_i_s_axi_awaddr : in std_logic_vector(4-1 downto 0);
        dsp_rf_ref_i_s_axi_awvalid : in std_logic;
        dsp_rf_ref_i_s_axi_awready : out std_logic;
        dsp_rf_ref_i_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_rf_ref_i_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_rf_ref_i_s_axi_wvalid : in std_logic;
        dsp_rf_ref_i_s_axi_wready : out std_logic;
        dsp_rf_ref_i_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_rf_ref_i_s_axi_bvalid : out std_logic;
        dsp_rf_ref_i_s_axi_bready : in std_logic;
        dsp_rf_ref_i_s_axi_araddr : in std_logic_vector(4-1 downto 0);
        dsp_rf_ref_i_s_axi_arvalid : in std_logic;
        dsp_rf_ref_i_s_axi_arready : out std_logic;
        dsp_rf_ref_i_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_rf_ref_i_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_rf_ref_i_s_axi_rvalid : out std_logic;
        dsp_rf_ref_i_s_axi_rready : in std_logic
    );
end dsp_rf_ref_i_axi_lite_interface;
architecture structural of dsp_rf_ref_i_axi_lite_interface is 
component dsp_rf_ref_i_axi_lite_interface_verilog is
    port(
        rf_ref_i : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_rf_ref_i_aclk : in std_logic;
        dsp_rf_ref_i_aresetn : in std_logic;
        dsp_rf_ref_i_s_axi_awaddr : in std_logic_vector(4-1 downto 0);
        dsp_rf_ref_i_s_axi_awvalid : in std_logic;
        dsp_rf_ref_i_s_axi_awready : out std_logic;
        dsp_rf_ref_i_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_rf_ref_i_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_rf_ref_i_s_axi_wvalid : in std_logic;
        dsp_rf_ref_i_s_axi_wready : out std_logic;
        dsp_rf_ref_i_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_rf_ref_i_s_axi_bvalid : out std_logic;
        dsp_rf_ref_i_s_axi_bready : in std_logic;
        dsp_rf_ref_i_s_axi_araddr : in std_logic_vector(4-1 downto 0);
        dsp_rf_ref_i_s_axi_arvalid : in std_logic;
        dsp_rf_ref_i_s_axi_arready : out std_logic;
        dsp_rf_ref_i_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_rf_ref_i_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_rf_ref_i_s_axi_rvalid : out std_logic;
        dsp_rf_ref_i_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_rf_ref_i_axi_lite_interface_verilog
    port map(
    rf_ref_i => rf_ref_i,
    dsp_clk => dsp_clk,
    dsp_rf_ref_i_aclk => dsp_rf_ref_i_aclk,
    dsp_rf_ref_i_aresetn => dsp_rf_ref_i_aresetn,
    dsp_rf_ref_i_s_axi_awaddr => dsp_rf_ref_i_s_axi_awaddr,
    dsp_rf_ref_i_s_axi_awvalid => dsp_rf_ref_i_s_axi_awvalid,
    dsp_rf_ref_i_s_axi_awready => dsp_rf_ref_i_s_axi_awready,
    dsp_rf_ref_i_s_axi_wdata => dsp_rf_ref_i_s_axi_wdata,
    dsp_rf_ref_i_s_axi_wstrb => dsp_rf_ref_i_s_axi_wstrb,
    dsp_rf_ref_i_s_axi_wvalid => dsp_rf_ref_i_s_axi_wvalid,
    dsp_rf_ref_i_s_axi_wready => dsp_rf_ref_i_s_axi_wready,
    dsp_rf_ref_i_s_axi_bresp => dsp_rf_ref_i_s_axi_bresp,
    dsp_rf_ref_i_s_axi_bvalid => dsp_rf_ref_i_s_axi_bvalid,
    dsp_rf_ref_i_s_axi_bready => dsp_rf_ref_i_s_axi_bready,
    dsp_rf_ref_i_s_axi_araddr => dsp_rf_ref_i_s_axi_araddr,
    dsp_rf_ref_i_s_axi_arvalid => dsp_rf_ref_i_s_axi_arvalid,
    dsp_rf_ref_i_s_axi_arready => dsp_rf_ref_i_s_axi_arready,
    dsp_rf_ref_i_s_axi_rdata => dsp_rf_ref_i_s_axi_rdata,
    dsp_rf_ref_i_s_axi_rresp => dsp_rf_ref_i_s_axi_rresp,
    dsp_rf_ref_i_s_axi_rvalid => dsp_rf_ref_i_s_axi_rvalid,
    dsp_rf_ref_i_s_axi_rready => dsp_rf_ref_i_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_rf_ref_phase_axi_lite_interface is 
    port(
        rf_ref_phase : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_rf_ref_phase_aclk : in std_logic;
        dsp_rf_ref_phase_aresetn : in std_logic;
        dsp_rf_ref_phase_s_axi_awaddr : in std_logic_vector(3-1 downto 0);
        dsp_rf_ref_phase_s_axi_awvalid : in std_logic;
        dsp_rf_ref_phase_s_axi_awready : out std_logic;
        dsp_rf_ref_phase_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_rf_ref_phase_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_rf_ref_phase_s_axi_wvalid : in std_logic;
        dsp_rf_ref_phase_s_axi_wready : out std_logic;
        dsp_rf_ref_phase_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_rf_ref_phase_s_axi_bvalid : out std_logic;
        dsp_rf_ref_phase_s_axi_bready : in std_logic;
        dsp_rf_ref_phase_s_axi_araddr : in std_logic_vector(3-1 downto 0);
        dsp_rf_ref_phase_s_axi_arvalid : in std_logic;
        dsp_rf_ref_phase_s_axi_arready : out std_logic;
        dsp_rf_ref_phase_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_rf_ref_phase_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_rf_ref_phase_s_axi_rvalid : out std_logic;
        dsp_rf_ref_phase_s_axi_rready : in std_logic
    );
end dsp_rf_ref_phase_axi_lite_interface;
architecture structural of dsp_rf_ref_phase_axi_lite_interface is 
component dsp_rf_ref_phase_axi_lite_interface_verilog is
    port(
        rf_ref_phase : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_rf_ref_phase_aclk : in std_logic;
        dsp_rf_ref_phase_aresetn : in std_logic;
        dsp_rf_ref_phase_s_axi_awaddr : in std_logic_vector(3-1 downto 0);
        dsp_rf_ref_phase_s_axi_awvalid : in std_logic;
        dsp_rf_ref_phase_s_axi_awready : out std_logic;
        dsp_rf_ref_phase_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_rf_ref_phase_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_rf_ref_phase_s_axi_wvalid : in std_logic;
        dsp_rf_ref_phase_s_axi_wready : out std_logic;
        dsp_rf_ref_phase_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_rf_ref_phase_s_axi_bvalid : out std_logic;
        dsp_rf_ref_phase_s_axi_bready : in std_logic;
        dsp_rf_ref_phase_s_axi_araddr : in std_logic_vector(3-1 downto 0);
        dsp_rf_ref_phase_s_axi_arvalid : in std_logic;
        dsp_rf_ref_phase_s_axi_arready : out std_logic;
        dsp_rf_ref_phase_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_rf_ref_phase_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_rf_ref_phase_s_axi_rvalid : out std_logic;
        dsp_rf_ref_phase_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_rf_ref_phase_axi_lite_interface_verilog
    port map(
    rf_ref_phase => rf_ref_phase,
    dsp_clk => dsp_clk,
    dsp_rf_ref_phase_aclk => dsp_rf_ref_phase_aclk,
    dsp_rf_ref_phase_aresetn => dsp_rf_ref_phase_aresetn,
    dsp_rf_ref_phase_s_axi_awaddr => dsp_rf_ref_phase_s_axi_awaddr,
    dsp_rf_ref_phase_s_axi_awvalid => dsp_rf_ref_phase_s_axi_awvalid,
    dsp_rf_ref_phase_s_axi_awready => dsp_rf_ref_phase_s_axi_awready,
    dsp_rf_ref_phase_s_axi_wdata => dsp_rf_ref_phase_s_axi_wdata,
    dsp_rf_ref_phase_s_axi_wstrb => dsp_rf_ref_phase_s_axi_wstrb,
    dsp_rf_ref_phase_s_axi_wvalid => dsp_rf_ref_phase_s_axi_wvalid,
    dsp_rf_ref_phase_s_axi_wready => dsp_rf_ref_phase_s_axi_wready,
    dsp_rf_ref_phase_s_axi_bresp => dsp_rf_ref_phase_s_axi_bresp,
    dsp_rf_ref_phase_s_axi_bvalid => dsp_rf_ref_phase_s_axi_bvalid,
    dsp_rf_ref_phase_s_axi_bready => dsp_rf_ref_phase_s_axi_bready,
    dsp_rf_ref_phase_s_axi_araddr => dsp_rf_ref_phase_s_axi_araddr,
    dsp_rf_ref_phase_s_axi_arvalid => dsp_rf_ref_phase_s_axi_arvalid,
    dsp_rf_ref_phase_s_axi_arready => dsp_rf_ref_phase_s_axi_arready,
    dsp_rf_ref_phase_s_axi_rdata => dsp_rf_ref_phase_s_axi_rdata,
    dsp_rf_ref_phase_s_axi_rresp => dsp_rf_ref_phase_s_axi_rresp,
    dsp_rf_ref_phase_s_axi_rvalid => dsp_rf_ref_phase_s_axi_rvalid,
    dsp_rf_ref_phase_s_axi_rready => dsp_rf_ref_phase_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dsp_rf_ref_q_axi_lite_interface is 
    port(
        rf_ref_q : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_rf_ref_q_aclk : in std_logic;
        dsp_rf_ref_q_aresetn : in std_logic;
        dsp_rf_ref_q_s_axi_awaddr : in std_logic_vector(4-1 downto 0);
        dsp_rf_ref_q_s_axi_awvalid : in std_logic;
        dsp_rf_ref_q_s_axi_awready : out std_logic;
        dsp_rf_ref_q_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_rf_ref_q_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_rf_ref_q_s_axi_wvalid : in std_logic;
        dsp_rf_ref_q_s_axi_wready : out std_logic;
        dsp_rf_ref_q_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_rf_ref_q_s_axi_bvalid : out std_logic;
        dsp_rf_ref_q_s_axi_bready : in std_logic;
        dsp_rf_ref_q_s_axi_araddr : in std_logic_vector(4-1 downto 0);
        dsp_rf_ref_q_s_axi_arvalid : in std_logic;
        dsp_rf_ref_q_s_axi_arready : out std_logic;
        dsp_rf_ref_q_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_rf_ref_q_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_rf_ref_q_s_axi_rvalid : out std_logic;
        dsp_rf_ref_q_s_axi_rready : in std_logic
    );
end dsp_rf_ref_q_axi_lite_interface;
architecture structural of dsp_rf_ref_q_axi_lite_interface is 
component dsp_rf_ref_q_axi_lite_interface_verilog is
    port(
        rf_ref_q : in std_logic_vector(17 downto 0);
        dsp_clk : out std_logic;
        dsp_rf_ref_q_aclk : in std_logic;
        dsp_rf_ref_q_aresetn : in std_logic;
        dsp_rf_ref_q_s_axi_awaddr : in std_logic_vector(4-1 downto 0);
        dsp_rf_ref_q_s_axi_awvalid : in std_logic;
        dsp_rf_ref_q_s_axi_awready : out std_logic;
        dsp_rf_ref_q_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        dsp_rf_ref_q_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        dsp_rf_ref_q_s_axi_wvalid : in std_logic;
        dsp_rf_ref_q_s_axi_wready : out std_logic;
        dsp_rf_ref_q_s_axi_bresp : out std_logic_vector(1 downto 0);
        dsp_rf_ref_q_s_axi_bvalid : out std_logic;
        dsp_rf_ref_q_s_axi_bready : in std_logic;
        dsp_rf_ref_q_s_axi_araddr : in std_logic_vector(4-1 downto 0);
        dsp_rf_ref_q_s_axi_arvalid : in std_logic;
        dsp_rf_ref_q_s_axi_arready : out std_logic;
        dsp_rf_ref_q_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        dsp_rf_ref_q_s_axi_rresp : out std_logic_vector(1 downto 0);
        dsp_rf_ref_q_s_axi_rvalid : out std_logic;
        dsp_rf_ref_q_s_axi_rready : in std_logic
    );
end component;
begin
inst : dsp_rf_ref_q_axi_lite_interface_verilog
    port map(
    rf_ref_q => rf_ref_q,
    dsp_clk => dsp_clk,
    dsp_rf_ref_q_aclk => dsp_rf_ref_q_aclk,
    dsp_rf_ref_q_aresetn => dsp_rf_ref_q_aresetn,
    dsp_rf_ref_q_s_axi_awaddr => dsp_rf_ref_q_s_axi_awaddr,
    dsp_rf_ref_q_s_axi_awvalid => dsp_rf_ref_q_s_axi_awvalid,
    dsp_rf_ref_q_s_axi_awready => dsp_rf_ref_q_s_axi_awready,
    dsp_rf_ref_q_s_axi_wdata => dsp_rf_ref_q_s_axi_wdata,
    dsp_rf_ref_q_s_axi_wstrb => dsp_rf_ref_q_s_axi_wstrb,
    dsp_rf_ref_q_s_axi_wvalid => dsp_rf_ref_q_s_axi_wvalid,
    dsp_rf_ref_q_s_axi_wready => dsp_rf_ref_q_s_axi_wready,
    dsp_rf_ref_q_s_axi_bresp => dsp_rf_ref_q_s_axi_bresp,
    dsp_rf_ref_q_s_axi_bvalid => dsp_rf_ref_q_s_axi_bvalid,
    dsp_rf_ref_q_s_axi_bready => dsp_rf_ref_q_s_axi_bready,
    dsp_rf_ref_q_s_axi_araddr => dsp_rf_ref_q_s_axi_araddr,
    dsp_rf_ref_q_s_axi_arvalid => dsp_rf_ref_q_s_axi_arvalid,
    dsp_rf_ref_q_s_axi_arready => dsp_rf_ref_q_s_axi_arready,
    dsp_rf_ref_q_s_axi_rdata => dsp_rf_ref_q_s_axi_rdata,
    dsp_rf_ref_q_s_axi_rresp => dsp_rf_ref_q_s_axi_rresp,
    dsp_rf_ref_q_s_axi_rvalid => dsp_rf_ref_q_s_axi_rvalid,
    dsp_rf_ref_q_s_axi_rready => dsp_rf_ref_q_s_axi_rready
);
end structural;
library work;
use work.conv_pkg.all;

-------------------------------------------------------------------
 -- System Generator version 11.1 VHDL source file.
 --
 -- Copyright(C) 2009 by Xilinx, Inc.  All rights reserved.  This
 -- text/file contains proprietary, confidential information of Xilinx,
 -- Inc., is distributed under license from Xilinx, Inc., and may be used,
 -- copied and/or disclosed only pursuant to the terms of a valid license
 -- agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
 -- this text/file solely for design, simulation, implementation and
 -- creation of design files limited to Xilinx devices or technologies.
 -- Use with non-Xilinx devices or technologies is expressly prohibited
 -- and immediately terminates your license unless covered by a separate
 -- agreement.
 --
 -- Xilinx is providing this design, code, or information "as is" solely
 -- for use in developing programs and solutions for Xilinx devices.  By
 -- providing this design, code, or information as one possible
 -- implementation of this feature, application or standard, Xilinx is
 -- making no representation that this implementation is free from any
 -- claims of infringement.  You are responsible for obtaining any rights
 -- you may require for your implementation.  Xilinx expressly disclaims
 -- any warranty whatsoever with respect to the adequacy of the
 -- implementation, including but not limited to warranties of
 -- merchantability or fitness for a particular purpose.
 --
 -- Xilinx products are not intended for use in life support appliances,
 -- devices, or systems.  Use in such applications is expressly prohibited.
 --
 -- Any modifications that are made to the source code are done at the user's
 -- sole risk and will be unsupported.
 --
 -- This copyright and support notice must be retained as part of this
 -- text at all times.  (c) Copyright 1995-2009 Xilinx, Inc.  All rights
 -- reserved.
 -------------------------------------------------------------------
 library IEEE;
 use IEEE.std_logic_1164.all;
 use IEEE.std_logic_arith.all;

entity example_xladdsub is 
   generic (
     core_name0: string := "";
     a_width: integer := 16;
     a_bin_pt: integer := 4;
     a_arith: integer := xlUnsigned;
     c_in_width: integer := 16;
     c_in_bin_pt: integer := 4;
     c_in_arith: integer := xlUnsigned;
     c_out_width: integer := 16;
     c_out_bin_pt: integer := 4;
     c_out_arith: integer := xlUnsigned;
     b_width: integer := 8;
     b_bin_pt: integer := 2;
     b_arith: integer := xlUnsigned;
     s_width: integer := 17;
     s_bin_pt: integer := 4;
     s_arith: integer := xlUnsigned;
     rst_width: integer := 1;
     rst_bin_pt: integer := 0;
     rst_arith: integer := xlUnsigned;
     en_width: integer := 1;
     en_bin_pt: integer := 0;
     en_arith: integer := xlUnsigned;
     full_s_width: integer := 17;
     full_s_arith: integer := xlUnsigned;
     mode: integer := xlAddMode;
     extra_registers: integer := 0;
     latency: integer := 0;
     quantization: integer := xlTruncate;
     overflow: integer := xlWrap;
     c_latency: integer := 0;
     c_output_width: integer := 17;
     c_has_c_in : integer := 0;
     c_has_c_out : integer := 0
   );
   port (
     a: in std_logic_vector(a_width - 1 downto 0);
     b: in std_logic_vector(b_width - 1 downto 0);
     c_in : in std_logic_vector (0 downto 0) := "0";
     ce: in std_logic;
     clr: in std_logic := '0';
     clk: in std_logic;
     rst: in std_logic_vector(rst_width - 1 downto 0) := "0";
     en: in std_logic_vector(en_width - 1 downto 0) := "1";
     c_out : out std_logic_vector (0 downto 0);
     s: out std_logic_vector(s_width - 1 downto 0)
   );
 end example_xladdsub;
 
 architecture behavior of example_xladdsub is 
 component synth_reg
 generic (
 width: integer := 16;
 latency: integer := 5
 );
 port (
 i: in std_logic_vector(width - 1 downto 0);
 ce: in std_logic;
 clr: in std_logic;
 clk: in std_logic;
 o: out std_logic_vector(width - 1 downto 0)
 );
 end component;
 
 function format_input(inp: std_logic_vector; old_width, delta, new_arith,
 new_width: integer)
 return std_logic_vector
 is
 variable vec: std_logic_vector(old_width-1 downto 0);
 variable padded_inp: std_logic_vector((old_width + delta)-1 downto 0);
 variable result: std_logic_vector(new_width-1 downto 0);
 begin
 vec := inp;
 if (delta > 0) then
 padded_inp := pad_LSB(vec, old_width+delta);
 result := extend_MSB(padded_inp, new_width, new_arith);
 else
 result := extend_MSB(vec, new_width, new_arith);
 end if;
 return result;
 end;
 
 constant full_s_bin_pt: integer := fractional_bits(a_bin_pt, b_bin_pt);
 constant full_a_width: integer := full_s_width;
 constant full_b_width: integer := full_s_width;
 
 signal full_a: std_logic_vector(full_a_width - 1 downto 0);
 signal full_b: std_logic_vector(full_b_width - 1 downto 0);
 signal core_s: std_logic_vector(full_s_width - 1 downto 0);
 signal conv_s: std_logic_vector(s_width - 1 downto 0);
 signal temp_cout : std_logic;
 signal internal_clr: std_logic;
 signal internal_ce: std_logic;
 signal extra_reg_ce: std_logic;
 signal override: std_logic;
 signal logic1: std_logic_vector(0 downto 0);


 component example_c_addsub_v12_0_i0
    port ( 
    a: in std_logic_vector(19 - 1 downto 0);
    clk: in std_logic:= '0';
    ce: in std_logic:= '0';
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(19 - 1 downto 0) 
 		  ); 
 end component;

begin
 internal_clr <= (clr or (rst(0))) and ce;
 internal_ce <= ce and en(0);
 logic1(0) <= '1';
 addsub_process: process (a, b, core_s)
 begin
 full_a <= format_input (a, a_width, b_bin_pt - a_bin_pt, a_arith,
 full_a_width);
 full_b <= format_input (b, b_width, a_bin_pt - b_bin_pt, b_arith,
 full_b_width);
 conv_s <= convert_type (core_s, full_s_width, full_s_bin_pt, full_s_arith,
 s_width, s_bin_pt, s_arith, quantization, overflow);
 end process addsub_process;


 comp0: if ((core_name0 = "example_c_addsub_v12_0_i0")) generate 
  core_instance0:example_c_addsub_v12_0_i0
   port map ( 
         a => full_a,
         clk => clk,
         ce => internal_ce,
         s => core_s,
         b => full_b
  ); 
   end generate;

latency_test: if (extra_registers > 0) generate
 override_test: if (c_latency > 1) generate
 override_pipe: synth_reg
 generic map (
 width => 1,
 latency => c_latency
 )
 port map (
 i => logic1,
 ce => internal_ce,
 clr => internal_clr,
 clk => clk,
 o(0) => override);
 extra_reg_ce <= ce and en(0) and override;
 end generate override_test;
 no_override: if ((c_latency = 0) or (c_latency = 1)) generate
 extra_reg_ce <= ce and en(0);
 end generate no_override;
 extra_reg: synth_reg
 generic map (
 width => s_width,
 latency => extra_registers
 )
 port map (
 i => conv_s,
 ce => extra_reg_ce,
 clr => internal_clr,
 clk => clk,
 o => s
 );
 cout_test: if (c_has_c_out = 1) generate
 c_out_extra_reg: synth_reg
 generic map (
 width => 1,
 latency => extra_registers
 )
 port map (
 i(0) => temp_cout,
 ce => extra_reg_ce,
 clr => internal_clr,
 clk => clk,
 o => c_out
 );
 end generate cout_test;
 end generate;
 
 latency_s: if ((latency = 0) or (extra_registers = 0)) generate
 s <= conv_s;
 end generate latency_s;
 latency0: if (((latency = 0) or (extra_registers = 0)) and
 (c_has_c_out = 1)) generate
 c_out(0) <= temp_cout;
 end generate latency0;
 tie_dangling_cout: if (c_has_c_out = 0) generate
 c_out <= "0";
 end generate tie_dangling_cout;
 end architecture behavior;

library work;
use work.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.conv_pkg.all;

entity xlcomplex_multiplier_2db568568678b52ae60ddabdbca6b4fb is 
  port(
    ce:in std_logic;
    clk:in std_logic;
    m_axis_dout_tdata_imag:out std_logic_vector(28 downto 0);
    m_axis_dout_tdata_real:out std_logic_vector(28 downto 0);
    m_axis_dout_tvalid:out std_logic;
    s_axis_a_tdata_imag:in std_logic_vector(17 downto 0);
    s_axis_a_tdata_real:in std_logic_vector(17 downto 0);
    s_axis_a_tvalid:in std_logic;
    s_axis_b_tdata_imag:in std_logic_vector(9 downto 0);
    s_axis_b_tdata_real:in std_logic_vector(9 downto 0);
    s_axis_b_tvalid:in std_logic
  );
end xlcomplex_multiplier_2db568568678b52ae60ddabdbca6b4fb; 

architecture behavior of xlcomplex_multiplier_2db568568678b52ae60ddabdbca6b4fb  is
  component example_cmpy_v6_0_i0
    port(
      aclk:in std_logic;
      aclken:in std_logic;
      m_axis_dout_tdata:out std_logic_vector(63 downto 0);
      m_axis_dout_tvalid:out std_logic;
      s_axis_a_tdata:in std_logic_vector(47 downto 0);
      s_axis_a_tvalid:in std_logic;
      s_axis_b_tdata:in std_logic_vector(31 downto 0);
      s_axis_b_tvalid:in std_logic
    );
end component;
signal m_axis_dout_tdata_net: std_logic_vector(63 downto 0) := (others=>'0');
signal s_axis_a_tdata_net: std_logic_vector(47 downto 0) := (others=>'0');
signal s_axis_b_tdata_net: std_logic_vector(31 downto 0) := (others=>'0');
begin
  m_axis_dout_tdata_imag <= m_axis_dout_tdata_net(60 downto 32);
  m_axis_dout_tdata_real <= m_axis_dout_tdata_net(28 downto 0);
  s_axis_a_tdata_net(41 downto 24) <= s_axis_a_tdata_imag;
  s_axis_a_tdata_net(17 downto 0) <= s_axis_a_tdata_real;
  s_axis_b_tdata_net(25 downto 16) <= s_axis_b_tdata_imag;
  s_axis_b_tdata_net(9 downto 0) <= s_axis_b_tdata_real;
  example_cmpy_v6_0_i0_instance : example_cmpy_v6_0_i0
    port map(
      aclk=>clk,
      aclken=>ce,
      m_axis_dout_tdata=>m_axis_dout_tdata_net,
      m_axis_dout_tvalid=>m_axis_dout_tvalid,
      s_axis_a_tdata=>s_axis_a_tdata_net,
      s_axis_a_tvalid=>s_axis_a_tvalid,
      s_axis_b_tdata=>s_axis_b_tdata_net,
      s_axis_b_tvalid=>s_axis_b_tvalid
    );
end behavior;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.conv_pkg.all;

entity xldivider_generator_e35a46ae6e5a9c0e9015371bc278efea is 
  port(
    a:in std_logic_vector(19 downto 0);
    a_tvalid:in std_logic;
    b:in std_logic_vector(31 downto 0);
    b_tvalid:in std_logic;
    ce:in std_logic;
    clk:in std_logic;
    op:out std_logic_vector(31 downto 0)
  );
end xldivider_generator_e35a46ae6e5a9c0e9015371bc278efea; 

architecture behavior of xldivider_generator_e35a46ae6e5a9c0e9015371bc278efea  is
  component example_div_gen_v5_1_i0
    port(
      aclk:in std_logic;
      m_axis_dout_tdata:out std_logic_vector(47 downto 0);
      m_axis_dout_tvalid:out std_logic;
      s_axis_dividend_tdata:in std_logic_vector(23 downto 0);
      s_axis_dividend_tvalid:in std_logic;
      s_axis_divisor_tdata:in std_logic_vector(31 downto 0);
      s_axis_divisor_tvalid:in std_logic
    );
end component;
signal m_axis_dout_tdata_net: std_logic_vector(47 downto 0) := (others=>'0');
signal m_axis_dout_tdata_shift_in_net: std_logic_vector(45 downto 0) := (others=>'0');
signal m_axis_dout_tdata_shift_out_net: std_logic_vector(31 downto 0) := (others=>'0');
signal result_tvalid: std_logic := '0';
signal s_axis_dividend_tdata_net: std_logic_vector(23 downto 0) := (others=>'0');
signal s_axis_divisor_tdata_net: std_logic_vector(31 downto 0) := (others=>'0');
begin
  m_axis_dout_tdata_shift_in_net <= m_axis_dout_tdata_net(45 downto 0);
  op <= m_axis_dout_tdata_shift_out_net;
  s_axis_dividend_tdata_net(19 downto 0) <= a;
  s_axis_divisor_tdata_net(31 downto 0) <= b;
  m_axis_dout_tdata_shift_out_net <= shift_op(m_axis_dout_tdata_shift_in_net, 32, 14, 1);
  example_div_gen_v5_1_i0_instance : example_div_gen_v5_1_i0
    port map(
      aclk=>clk,
      m_axis_dout_tdata=>m_axis_dout_tdata_net,
      m_axis_dout_tvalid=>result_tvalid,
      s_axis_dividend_tdata=>s_axis_dividend_tdata_net,
      s_axis_dividend_tvalid=>a_tvalid,
      s_axis_divisor_tdata=>s_axis_divisor_tdata_net,
      s_axis_divisor_tvalid=>b_tvalid
    );
end behavior;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.conv_pkg.all;

entity xldds_compiler_0cbab40bd53bfcdc412118bfa95a86d6 is 
  port(
    ce:in std_logic;
    clk:in std_logic;
    m_axis_data_tdata_cosine:out std_logic_vector(9 downto 0);
    m_axis_data_tdata_sine:out std_logic_vector(9 downto 0);
    m_axis_data_tready:in std_logic;
    m_axis_data_tvalid:out std_logic;
    s_axis_phase_tdata_pinc:in std_logic_vector(28 downto 0);
    s_axis_phase_tdata_resync:in std_logic_vector(0 downto 0);
    s_axis_phase_tready:out std_logic;
    s_axis_phase_tvalid:in std_logic
  );
end xldds_compiler_0cbab40bd53bfcdc412118bfa95a86d6; 

architecture behavior of xldds_compiler_0cbab40bd53bfcdc412118bfa95a86d6  is
  component example_dds_compiler_v6_0_i0
    port(
      aclk:in std_logic;
      aclken:in std_logic;
      m_axis_data_tdata:out std_logic_vector(31 downto 0);
      m_axis_data_tready:in std_logic;
      m_axis_data_tvalid:out std_logic;
      s_axis_phase_tdata:in std_logic_vector(39 downto 0);
      s_axis_phase_tready:out std_logic;
      s_axis_phase_tvalid:in std_logic
    );
end component;
signal m_axis_data_tdata_net: std_logic_vector(31 downto 0) := (others=>'0');
signal s_axis_phase_tdata_net: std_logic_vector(39 downto 0) := (others=>'0');
begin
  m_axis_data_tdata_sine <= m_axis_data_tdata_net(25 downto 16);
  m_axis_data_tdata_cosine <= m_axis_data_tdata_net(9 downto 0);
  s_axis_phase_tdata_net(32 downto 32) <= s_axis_phase_tdata_resync;
  s_axis_phase_tdata_net(28 downto 0) <= s_axis_phase_tdata_pinc;
  example_dds_compiler_v6_0_i0_instance : example_dds_compiler_v6_0_i0
    port map(
      aclk=>clk,
      aclken=>ce,
      m_axis_data_tdata=>m_axis_data_tdata_net,
      m_axis_data_tready=>m_axis_data_tready,
      m_axis_data_tvalid=>m_axis_data_tvalid,
      s_axis_phase_tdata=>s_axis_phase_tdata_net,
      s_axis_phase_tready=>s_axis_phase_tready,
      s_axis_phase_tvalid=>s_axis_phase_tvalid
    );
end behavior;



