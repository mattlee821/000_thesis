metaboQC="/Users/ml16847/OneDrive - University of Bristol/001_projects/000_thesis/index/data/chapter4/5_metabolite_qc/"
cd "$metaboQC"
out="/Users/ml16847/OneDrive - University of Bristol/001_projects/000_thesis/index/data/chapter4/data/metabolomics/data_prep/final/"
Rscript run_MetaboQC_pipeline.R parameter_file_children.txt
mv "$out"MetaboQC_release* "$out"qc/children/MetaboQC_release
Rscript run_MetaboQC_pipeline.R parameter_file_adolescents.txt
mv "$out"MetaboQC_release* "$out"qc/adolescents/MetaboQC_release
Rscript run_MetaboQC_pipeline.R parameter_file_young_adults.txt
mv "$out"MetaboQC_release* "$out"qc/young_adults/MetaboQC_release
Rscript run_MetaboQC_pipeline.R parameter_file_adults.txt
mv "$out"MetaboQC_release* "$out"qc/adults/MetaboQC_release
