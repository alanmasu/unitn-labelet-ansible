# Check for recent enough version of bash.
if [ "${BASH_VERSINFO[0]}" -gt 4 ] || [ "${BASH_VERSINFO[0]}" -eq 4 -a "${BASH_VERSINFO[1]}" -ge 2 ]; then
	# Cadence stuff
	if [[ -z "$CADENCE_SETUP_DONE" ]] && mountpoint -q /eda; then
		echo "Activated Cadence Suite"
		LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/eda/cadence/2024-25/RHELx86/IC_23.10.070/tools/lib/64bit/RHEL/RHEL9"
		source /eda/cadence/2024-25/scripts/SPECTRE_24.10.078_RHELx86.sh
		source /eda/cadence/2024-25/scripts/XCELIUM_24.03.004_RHELx86.sh
		source /eda/cadence/2024-25/scripts/CONFRML_24.10.100_RHELx86.sh
		source /eda/cadence/2024-25/scripts/DDIEXPORT_23.33.000_RHELx86.sh
		source /eda/cadence/2024-25/scripts/SSV_23.11.000_RHELx86.sh
		source /eda/cadence/2024-25/scripts/PEGASUS_24.10.000_RHELx86.sh
		source /eda/cadence/2024-25/scripts/QUANTUS_23.11.000_RHELx86.sh
		source /eda/cadence/2024-25/scripts/IC_23.10.070_RHELx86.sh
		source /eda/cadence/2024-25/scripts/ASSURA_04.17.001_231_RHELx86.sh
		source /eda/cadence/2024-25/scripts/PVS_24.10.000_RHELx86.sh
		export CDSHOME=/eda/cadence/2024-25/RHELx86/IC_23.10.070
		# License file for Cadence licenses
		export LM_LICENSE_FILE=5280@jabba.disi.unitn.it
		# Alias for easy pdk dir creation
		alias lfoundry_pdk_dircreate='/eda/libraries/lfoundry_lf11is/PDK_LF11ISi_V1_3_2/tools/installation/workarea.PDK_LF11ISi_V1_3_2'
		alias lfoundry_pdk_python='source /eda/libraries/lfoundry_lf11is/PDK_LF11ISi_V1_3_2/tools/plugins/virtuoso_fix.sh'
		export CADENCE_SETUP_DONE="true"
	fi
fi
