data('minimal_mesh', package = 'silicate')
usethis::use_data(minimal_mesh)

library(sf)
# minimal_mesh_sp <- as(minimal_mesh, "Spatial")
# minimal_mesh_sp_line <- as(minimal_mesh_sp, "SpatialLinesDataFrame")
# usethis::use_data(minimal_mesh_sp)
# usethis::use_data(minimal_mesh_sp_line)


library(sf)
dir.create("man/figures")
png("man/figures/minimal_mesh.png")
plot(minimal_mesh)
dev.off()

