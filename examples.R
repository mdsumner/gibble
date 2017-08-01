
#mapview() + mapview(minimal_mesh)
a <- topoedit.sf(minimal_mesh)


## a more involved example
north_carolina <- read_sf(system.file("shape/nc.shp", package="sf"))
## pick one and its neighbours
library(dplyr)
set.seed(1)
path <- sc::PATH(north_carolina)
sample_feature <- path$object %>% sample_n(1) %>% select(object_, FIPS)
## this is very convoluted, just used to pick the neighbours (by vertex)
## of our one selected feature, but also shows the simple relation
## between the PATH tables that link a single de-duplicated vertex pool
neighbours <- sample_feature %>%
  inner_join(path$path) %>% inner_join(path$path_link_vertex) %>%
  distinct(vertex_) %>% inner_join(path$path_link_vertex) %>%
  distinct(path_) %>% inner_join(path$path)  %>%
  distinct(object_) %>% inner_join(path$object) %>%
  select(FIPS) %>% inner_join(north_carolina) %>% sf::st_as_sf()
neighbours$sample <- neighbours$FIPS == sample_feature$FIPS
plot(neighbours[c("sample")])
plot(north_carolina, add = TRUE, colour = NA)


## here we only can edit points, and that's all we can see happening
## but the result is used to rebuild the features with those updates
## to the de-duplicated vertex pool
b <- topoedit.sf(neighbours)
plot(b["sample"])
plot(neighbours, add = TRUE, col = NA, lwd = 4)
