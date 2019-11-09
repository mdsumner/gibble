library(sf)
plot(silicate::sfzoo$multipolygon, reset= F, xlim = c(0, 10), ylim = c(0, 10))
bb <- st_bbox(silicate::inlandwaters[4, 1]$geom)

## punch a hole in kangaroo island
p <- st_polygon(list(cbind(c(5.92, 6.07)[c(1, 1, 2, 2, 1)], c(2.67, 2.58)[c(1, 2, 2, 1, 1)])))

mpoly <- st_sfc(silicate::sfzoo$multipolygon, st_difference((st_set_crs(silicate::inlandwaters[4, 1]$geom, NA)[[1]] - bb[c("xmin", "ymin")])/
         diff(bb[c("xmax", "ymax")]) + 1, p))

usethis::use_data(mpoly)
