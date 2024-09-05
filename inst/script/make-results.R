library(SpatialExperiment)
library(dplyr)
library(spacexr)
library(tibble)
data_path <- "~/Desktop/EuroBioc2024_STWorkflow/intermediate_data"
result_path <- "~/Desktop/EuroBioc2024_STWorkflow/data/computation_results"

# Baye result
sce <- readRDS(file.path(data_path, "vis_qcd_dimred_sce_bayesspace.rds"))
bayesspace_cluster <- as.data.frame(colData(sce)) %>%
  select(spatial.cluster)

write.csv(bayesspace_cluster, file.path(result_path, "BayesSpace_spot_clusters.csv"))


# RCTD result
rctd <- readRDS(file.path(data_path, "vis_RCTD.rds"))
norm_weights <- normalize_weights(rctd@results$weights)
RCTD_results <- data.frame(as(norm_weights, "matrix"))
write.csv(RCTD_results, here::here("./data/computation_results/RCTD_spot_decon.csv"))


# SingleR result
xe_predictions <- readRDS(file.path(data_path, "xe_SingleRpred.rds"))
SingleR_results <- data.frame(SingleR.labels = xe_predictions$labels)
rownames(SingleR_results) <- rownames(xe_predictions)

write.csv(SingleR_results, here::here("./data/computation_results/SingleR_cell_annotations.csv"))       












