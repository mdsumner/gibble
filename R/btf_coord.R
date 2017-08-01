geometry_dimension <- function(x) rev(class(x))[3L]
sf_geom_names <- function(x) unlist(strsplit(geometry_dimension(x), ""))
btf_geom_names <- function(gnames) {
  gnames <- gsub("^X$", "x_", gnames)
  gnames <- gsub("^Y$", "y_", gnames)
  gnames <- gsub("^Z$", "z_", gnames)
  gnames <- gsub("^M$", "m_", gnames)
  gnames <- gsub("^type$", "type_", gnames)
  gnames
}
sfcoords <- function(x, ...) tibble::as_tibble(m_v(x))

m_v <- function(x) {
  x <- unclass(x)
  x <- if (is.null(dim(x))) t(x) else x
  x
}
#' Coordinate decomposition
#'
#' Collect all coordinates in one table, the path_link_vertex table
#' has the information about the original grouping.
#'
btf_coord <- function(x, ...)  UseMethod("btf_coord")
btf_coord.sf <- function(x, ...) {
  btf_coord(.btf_get_geometry(x), ...)
}
btf_coord.sfc <- function(x,  ...) {
  x <- lapply(x, btf_coord)
  dplyr::bind_rows(x)
}
btf_coord.MULTIPOLYGON <- function(x, ...) {
  colnames <- btf_geom_names(sf_geom_names(x))
  setNames(dplyr::bind_rows(lapply(x, function(y) dplyr::bind_rows(lapply(y, sfcoords)))), colnames)
}
btf_coord.POLYGON <- function(x, ...) {
  colnames <- btf_geom_names(sf_geom_names(x))
  setNames(dplyr::bind_rows(lapply(x, sfcoords)), colnames)
}
btf_coord.MULTILINESTRING <- btf_coord.POLYGON
btf_coord.LINESTRING <- function(x, ...) {
  colnames <- btf_geom_names(sf_geom_names(x))
  setNames(sfcoords(x), colnames)
}
btf_coord.MULTIPOINT <- btf_coord.LINESTRING
btf_coord.POINT <- btf_coord.LINESTRING
