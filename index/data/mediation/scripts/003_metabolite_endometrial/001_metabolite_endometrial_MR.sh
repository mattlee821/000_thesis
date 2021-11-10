###########################
#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -l walltime=300:00:00
#PBS -e log/
#PBS -o log/

# set environment arguments 
source ../../environment/environment.sh
# must also set a .Renviron file in the same location as the script

# working directory
cd ${directory_1}007_metabolites_outcomes/scripts

module add languages/R-4.0.3-gcc9.1.0

VAR1=001_metabolite_endometrial_MR.R

Rscript ${directory_1}007_metabolites_outcomes/scripts/003_metabolite_endometrial/${VAR1}
