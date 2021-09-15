library(factoextra)
# library("factoextra")
data(decathlon2)
decathlon2.active <- decathlon2[1:23, 1:10]
View(decathlon2.active)
head(decathlon2.active[, 1:6])
dim(decathlon2)
# Compute PCA
res.pca <- prcomp(decathlon2.active, scale = TRUE)
# Visualize eigenvalues (scree plot). Show the percentage of variances explained by each principal component.
fviz_eig(res.pca)
# Graph of individuals. Individuals with a similar profile are grouped together.
fviz_pca_ind(res.pca,
    col.ind = "cos2", # Color by the quality of representation
    gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
    repel = TRUE # Avoid text overlapping
) # Graph of variables. Positive correlated variables point to the same side of the plot. Negative correlated variables point to opposite sides of the graph.
fviz_pca_var(res.pca,
    col.var = "contrib", # Color by contributions to the PC
    gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
    repel = TRUE # Avoid text overlapping
)
# Biplot of individuals and variables
fviz_pca_biplot(res.pca,
    repel = TRUE,
    col.var = "#2E9FDF", # Variables color
    col.ind = "#696969" # Individuals color
)
# Access to the PCA results
library(factoextra)
# Eigenvalues
eig.val <- get_eigenvalue(res.pca)
eig.val

# Results for Variables
res.var <- get_pca_var(res.pca)
res.var$coord # Coordinates
res.var$contrib # Contributions to the PCs
res.var$cos2 # Quality of representation
# Results for individuals
res.ind <- get_pca_ind(res.pca)
res.ind$coord # Coordinates
res.ind$contrib # Contributions to the PCs
res.ind$cos2 # Quality of representation
ind.sup <- decathlon2[24:27, 1:10]
ind.sup[, 1:6]
ind.sup.coord <- predict(res.pca, newdata = ind.sup)
ind.sup.coord[, 1:4]
# Graph of individuals including the supplementary individuals:
# Plot of active individuals
p <- fviz_pca_ind(res.pca, repel = TRUE)
# Add supplementary individuals
fviz_add(p, ind.sup.coord, color = "blue")
