-- VHDL netlist generated by SCUBA Diamond_3.1_Production (93)
-- Module  Version: 5.5
--C:\lscc\diamond\3.1_x64\ispfpga\bin\nt64\scuba.exe -w -n RF_PLL -lang vhdl -synth synplify -arch xo2c00 -type pll -fin 50 -fclkop 20 -fclkop_tol 0.0 -fclkos 8 -fclkos_tol 0.0 -fclkos2 360 -fclkos2_tol 0.0 -fclkos3 10 -fclkos3_tol 10.0 -trimp 0 -phasep 0 -trimp_r -trims 0 -phases 0 -trims_r -phases2 0 -phases3 0 -phase_cntl STATIC -fb_mode 1 

-- Fri Oct 31 23:37:21 2014

library IEEE;
use IEEE.std_logic_1164.all;
-- synopsys translate_off
library MACHXO2;
use MACHXO2.components.all;
-- synopsys translate_on

entity RF_PLL is
    port (
        CLKI: in  std_logic; 
        CLKOP: out  std_logic; 
        CLKOS: out  std_logic; 
        CLKOS2: out  std_logic; 
        CLKOS3: out  std_logic);
 attribute dont_touch : boolean;
 attribute dont_touch of RF_PLL : entity is true;
end RF_PLL;

architecture Structure of RF_PLL is

    -- internal signal declarations
    signal LOCK: std_logic;
    signal CLKOS3_t: std_logic;
    signal CLKOS2_t: std_logic;
    signal CLKOS_t: std_logic;
    signal CLKOP_t: std_logic;
    signal scuba_vlo: std_logic;

    -- local component declarations
    component VLO
        port (Z: out  std_logic);
    end component;
    component EHXPLLJ
        generic (INTFB_WAKE : in String; DDRST_ENA : in String; 
                DCRST_ENA : in String; MRST_ENA : in String; 
                PLLRST_ENA : in String; DPHASE_SOURCE : in String; 
                STDBY_ENABLE : in String; OUTDIVIDER_MUXD2 : in String; 
                OUTDIVIDER_MUXC2 : in String; 
                OUTDIVIDER_MUXB2 : in String; 
                OUTDIVIDER_MUXA2 : in String; 
                PREDIVIDER_MUXD1 : in Integer; 
                PREDIVIDER_MUXC1 : in Integer; 
                PREDIVIDER_MUXB1 : in Integer; 
                PREDIVIDER_MUXA1 : in Integer; PLL_USE_WB : in String; 
                PLL_LOCK_MODE : in Integer; 
                CLKOS_TRIM_DELAY : in Integer; 
                CLKOS_TRIM_POL : in String; 
                CLKOP_TRIM_DELAY : in Integer; 
                CLKOP_TRIM_POL : in String; FRACN_DIV : in Integer; 
                FRACN_ENABLE : in String; FEEDBK_PATH : in String; 
                CLKOS3_FPHASE : in Integer; CLKOS2_FPHASE : in Integer; 
                CLKOS_FPHASE : in Integer; CLKOP_FPHASE : in Integer; 
                CLKOS3_CPHASE : in Integer; CLKOS2_CPHASE : in Integer; 
                CLKOS_CPHASE : in Integer; CLKOP_CPHASE : in Integer; 
                VCO_BYPASS_D0 : in String; VCO_BYPASS_C0 : in String; 
                VCO_BYPASS_B0 : in String; VCO_BYPASS_A0 : in String; 
                CLKOS3_ENABLE : in String; CLKOS2_ENABLE : in String; 
                CLKOS_ENABLE : in String; CLKOP_ENABLE : in String; 
                CLKOS3_DIV : in Integer; CLKOS2_DIV : in Integer; 
                CLKOS_DIV : in Integer; CLKOP_DIV : in Integer; 
                CLKFB_DIV : in Integer; CLKI_DIV : in Integer);
        port (CLKI: in  std_logic; CLKFB: in  std_logic; 
            PHASESEL1: in  std_logic; PHASESEL0: in  std_logic; 
            PHASEDIR: in  std_logic; PHASESTEP: in  std_logic; 
            LOADREG: in  std_logic; STDBY: in  std_logic; 
            PLLWAKESYNC: in  std_logic; RST: in  std_logic; 
            RESETM: in  std_logic; RESETC: in  std_logic; 
            RESETD: in  std_logic; ENCLKOP: in  std_logic; 
            ENCLKOS: in  std_logic; ENCLKOS2: in  std_logic; 
            ENCLKOS3: in  std_logic; PLLCLK: in  std_logic; 
            PLLRST: in  std_logic; PLLSTB: in  std_logic; 
            PLLWE: in  std_logic; PLLADDR4: in  std_logic; 
            PLLADDR3: in  std_logic; PLLADDR2: in  std_logic; 
            PLLADDR1: in  std_logic; PLLADDR0: in  std_logic; 
            PLLDATI7: in  std_logic; PLLDATI6: in  std_logic; 
            PLLDATI5: in  std_logic; PLLDATI4: in  std_logic; 
            PLLDATI3: in  std_logic; PLLDATI2: in  std_logic; 
            PLLDATI1: in  std_logic; PLLDATI0: in  std_logic; 
            CLKOP: out  std_logic; CLKOS: out  std_logic; 
            CLKOS2: out  std_logic; CLKOS3: out  std_logic; 
            LOCK: out  std_logic; INTLOCK: out  std_logic; 
            REFCLK: out  std_logic; CLKINTFB: out  std_logic; 
            DPHSRC: out  std_logic; PLLACK: out  std_logic; 
            PLLDATO7: out  std_logic; PLLDATO6: out  std_logic; 
            PLLDATO5: out  std_logic; PLLDATO4: out  std_logic; 
            PLLDATO3: out  std_logic; PLLDATO2: out  std_logic; 
            PLLDATO1: out  std_logic; PLLDATO0: out  std_logic);
    end component;
    attribute FREQUENCY_PIN_CLKOS3 : string; 
    attribute FREQUENCY_PIN_CLKOS2 : string; 
    attribute FREQUENCY_PIN_CLKOS : string; 
    attribute FREQUENCY_PIN_CLKOP : string; 
    attribute FREQUENCY_PIN_CLKI : string; 
    attribute ICP_CURRENT : string; 
    attribute LPF_RESISTOR : string; 
    attribute FREQUENCY_PIN_CLKOS3 of PLLInst_0 : label is "10.000000";
    attribute FREQUENCY_PIN_CLKOS2 of PLLInst_0 : label is "360.000000";
    attribute FREQUENCY_PIN_CLKOS of PLLInst_0 : label is "8.000000";
    attribute FREQUENCY_PIN_CLKOP of PLLInst_0 : label is "20.000000";
    attribute FREQUENCY_PIN_CLKI of PLLInst_0 : label is "50.000000";
    attribute ICP_CURRENT of PLLInst_0 : label is "6";
    attribute LPF_RESISTOR of PLLInst_0 : label is "72";
    attribute syn_keep : boolean;
    attribute syn_noprune : boolean;
    attribute syn_noprune of Structure : architecture is true;
    attribute NGD_DRC_MASK : integer;
    attribute NGD_DRC_MASK of Structure : architecture is 1;

begin
    -- component instantiation statements
    scuba_vlo_inst: VLO
        port map (Z=>scuba_vlo);

    PLLInst_0: EHXPLLJ
        generic map (DDRST_ENA=> "DISABLED", DCRST_ENA=> "DISABLED", 
        MRST_ENA=> "DISABLED", PLLRST_ENA=> "DISABLED", INTFB_WAKE=> "DISABLED", 
        STDBY_ENABLE=> "DISABLED", DPHASE_SOURCE=> "DISABLED", 
        PLL_USE_WB=> "DISABLED", CLKOS3_FPHASE=>  0, CLKOS3_CPHASE=>  35, 
        CLKOS2_FPHASE=>  0, CLKOS2_CPHASE=>  0, CLKOS_FPHASE=>  0, 
        CLKOS_CPHASE=>  44, CLKOP_FPHASE=>  0, CLKOP_CPHASE=>  17, 
        PLL_LOCK_MODE=>  0, CLKOS_TRIM_DELAY=>  0, CLKOS_TRIM_POL=> "RISING", 
        CLKOP_TRIM_DELAY=>  0, CLKOP_TRIM_POL=> "RISING", FRACN_DIV=>  0, 
        FRACN_ENABLE=> "DISABLED", OUTDIVIDER_MUXD2=> "DIVD", 
        PREDIVIDER_MUXD1=>  0, VCO_BYPASS_D0=> "DISABLED", CLKOS3_ENABLE=> "ENABLED", 
        OUTDIVIDER_MUXC2=> "DIVC", PREDIVIDER_MUXC1=>  0, VCO_BYPASS_C0=> "DISABLED", 
        CLKOS2_ENABLE=> "ENABLED", OUTDIVIDER_MUXB2=> "DIVB", 
        PREDIVIDER_MUXB1=>  0, VCO_BYPASS_B0=> "DISABLED", CLKOS_ENABLE=> "ENABLED", 
        OUTDIVIDER_MUXA2=> "DIVA", PREDIVIDER_MUXA1=>  0, VCO_BYPASS_A0=> "DISABLED", 
        CLKOP_ENABLE=> "ENABLED", CLKOS3_DIV=>  36, CLKOS2_DIV=>  1, 
        CLKOS_DIV=>  45, CLKOP_DIV=>  18, CLKFB_DIV=>  2, CLKI_DIV=>  5, 
        FEEDBK_PATH=> "CLKOP")
        port map (CLKI=>CLKI, CLKFB=>CLKOP_t, PHASESEL1=>scuba_vlo, 
            PHASESEL0=>scuba_vlo, PHASEDIR=>scuba_vlo, 
            PHASESTEP=>scuba_vlo, LOADREG=>scuba_vlo, STDBY=>scuba_vlo, 
            PLLWAKESYNC=>scuba_vlo, RST=>scuba_vlo, RESETM=>scuba_vlo, 
            RESETC=>scuba_vlo, RESETD=>scuba_vlo, ENCLKOP=>scuba_vlo, 
            ENCLKOS=>scuba_vlo, ENCLKOS2=>scuba_vlo, ENCLKOS3=>scuba_vlo, 
            PLLCLK=>scuba_vlo, PLLRST=>scuba_vlo, PLLSTB=>scuba_vlo, 
            PLLWE=>scuba_vlo, PLLADDR4=>scuba_vlo, PLLADDR3=>scuba_vlo, 
            PLLADDR2=>scuba_vlo, PLLADDR1=>scuba_vlo, 
            PLLADDR0=>scuba_vlo, PLLDATI7=>scuba_vlo, 
            PLLDATI6=>scuba_vlo, PLLDATI5=>scuba_vlo, 
            PLLDATI4=>scuba_vlo, PLLDATI3=>scuba_vlo, 
            PLLDATI2=>scuba_vlo, PLLDATI1=>scuba_vlo, 
            PLLDATI0=>scuba_vlo, CLKOP=>CLKOP_t, CLKOS=>CLKOS_t, 
            CLKOS2=>CLKOS2_t, CLKOS3=>CLKOS3_t, LOCK=>LOCK, 
            INTLOCK=>open, REFCLK=>open, CLKINTFB=>open, DPHSRC=>open, 
            PLLACK=>open, PLLDATO7=>open, PLLDATO6=>open, PLLDATO5=>open, 
            PLLDATO4=>open, PLLDATO3=>open, PLLDATO2=>open, 
            PLLDATO1=>open, PLLDATO0=>open);

    CLKOS3 <= CLKOS3_t;
    CLKOS2 <= CLKOS2_t;
    CLKOS <= CLKOS_t;
    CLKOP <= CLKOP_t;
end Structure;

-- synopsys translate_off
library MACHXO2;
configuration Structure_CON of RF_PLL is
    for Structure
        for all:VLO use entity MACHXO2.VLO(V); end for;
        for all:EHXPLLJ use entity MACHXO2.EHXPLLJ(V); end for;
    end for;
end Structure_CON;

-- synopsys translate_on
