#!/bin/bash
# Check for recent enough version of bash.
if [ "${BASH_VERSINFO[0]}" -gt 4 ] || [ "${BASH_VERSINFO[0]}" -eq 4 -a "${BASH_VERSINFO[1]}" -ge 2 ]; then
    #For Vivado & Vitis
    if [ -z "$XILINX_SETUP_DONE" ] && mountpoint -q /eda; then 
        source /tools/Xilinx/2025.1/Vivado/settings64.sh
        source /tools/Xilinx/2025.1/Vitis/settings64.sh
        export XILINX_SETUP_DONE="true"
    fi
fi
