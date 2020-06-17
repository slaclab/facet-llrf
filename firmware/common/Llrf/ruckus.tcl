# Load RUCKUS library
source -quiet $::env(RUCKUS_DIR)/vivado_proc.tcl

# Load Source Code
loadSource -dir  "$::DIR_PATH/rtl/"

loadIpCore -path "$::DIR_PATH/coregen/ila_0.xci"

if { $::env(AMC_TYPE_BAY1) == "AmcMrLlrfGen2UpConvert" } {
    loadRuckusTcl "$::DIR_PATH/yamlConfigGen2"
} elseif { $::env(AMC_TYPE_BAY1) == "AmcMrLlrfUpConvert" } {
    loadRuckusTcl "$::DIR_PATH/yamlConfigGen1"
}

## Synthesis options
set_property strategy Performance_ExplorePostRoutePhysOpt [get_runs impl_1]

set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY rebuilt [get_runs synth_1]
set_property STEPS.SYNTH_DESIGN.ARGS.RETIMING on [get_runs synth_1]
