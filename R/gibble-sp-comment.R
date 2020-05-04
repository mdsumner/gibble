# m <- mpoly[1]
# plot(m, reset = F)
#
# draw_poly <- function(...) {
#   x <- do.call(cbind, locator())
#   sf::st_polygon(list(x[c(seq_len(nrow(x)), 1L), ]))
# }
# p <- draw_poly()
# m <- st_difference(m, p)
# #dput(m)

# m <- structure(list(structure(list(list(structure(c(0, 1, 2, 3, 1,
#                                                     0, 0, 4, 4, 2, 0, 0), .Dim = c(6L, 2L)), structure(c(1, 2, 1, 1, 1, 2, 2, 1),
#                       .Dim = c(4L, 2L)), structure(c(1.30767480085978, 1.28036414211658, 1.88119863446706,
#                                                      1.30767480085978, 3.03643949930459, 2.55850297129852, 2.49022632444051,
#                                                      3.03643949930459), .Dim = c(4L, 2L))),
#                       list(structure(c(3, 3, 4, 4, 3, 0, 1, 1, 0, 0), .Dim = c(5L, 2L)),
#                            structure(c(3.3, 3.8, 3.8, 3.3, 3.3, 0.3, 0.3, 0.8, 0.8, 0.3),
#                                      .Dim = c(5L, 2L))), list(structure(c(3, 4, 4, 3, 3, 3, 2, 3),
#                   .Dim = c(4L, 2L)))), class = c("XY", "MULTIPOLYGON", "sfg"))), n_empty = 0L,
#                crs = structure(list(epsg = NA_integer_,
#               proj4string = NA_character_), class = "crs"),
#                idx = structure(c(1, 1), .Dim = 1:2), class = c("sfc_MULTIPOLYGON", "sfc"),
#               precision = 0, bbox = structure(c(xmin = 0, ymin = 0, xmax = 4, ymax = 4), class = "bbox"))
#
#
# spm <- as(m, "Spatial")
# gibble_cmt(spm)

sp_cmt <- function(x, ...) {
  UseMethod("sp_cmt")
}
sp_cmt.Polygons <- function(x, ...) {
  comment(x)
}
sp_cmt.SpatialPolygons <- function(x, ...) {
  unlist(lapply(x@polygons, sp_cmt))
}

# the comment value in gibble form
gibble_cmt <- function(x, ...) {
  l <- strsplit(sp_cmt(x), "\\s+", perl = TRUE)
  as.integer(unlist(l))
}

## convert

## make polygons
# .x <- 0
# pts <- matrix(rnorm(1e3, .x), ncol = 2L)
# tri <- RTriangle::triangulate(RTriangle::pslg(P = pts))
# ## drop most triangles
# idx <- tri$T[sample(seq_len(nrow(tri$T)), 0.8 * nrow(tri$T)), c(1, 2, 3, 1)]
# d <- tibble::tibble(x = pts[t(idx),1L], y = pts[t(idx), 2L],
#                     polygon_id = rep(seq_len(nrow(idx)), each = 4L))
#
# p <- sf::st_union(sfheaders::sfc_polygon(d, x = "x", y = "y", polygon_id = "polygon_id"))
# plot(p, border = NA, col = "grey")
#
#
# g <- gibble(p)
# g$cmt <- gibble_cmt(as(p, "Spatial"))
