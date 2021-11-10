###########################
#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -l walltime=300:00:00
#PBS -e log/
#PBS -o log/

# set environment arguments 
source ../../../environment/environment.sh
# must also set a .Renviron file in the same location as the script

# working directory
cd ${directory_1}002_adiposity_metabolites/scripts

module add languages/R-3.5.1-ATLAS-gcc-6.1

VAR1=Locke_BMI_77_clump.R

Rscript ${directory_1}002_adiposity_metabolites/scripts/step1/1_extract_outcomes_perform_analysis_seperately/${VAR1}
