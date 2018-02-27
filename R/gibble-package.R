#' gibble package
#'
#' Path-based geometry decomposition to data frame.
#'
#' The goal of gibble is to provide a straightforward map of path-based data
#' structures. Paths are connected linear sequences of coordinates, otherwise
#' known as *lines*. Structured spatial data includes *objects* composed of
#' *paths*, which are islands, holes within island, lines, and points. Polygons
#' require an extra grouping level *subobject* to ensure holes are nested
#' within their island, but this is ignored for other types.
#'
#' Sequential inear structures are not optimal for many operations when
#' working with spatial data, and gibble provides a simple bridge between
#' existing paths and tools to decompose them to primitives.
#' @name gibble-package
#' @docType package
NULL

#' minimal mesh
#'
#' A testing data set, `minimal_mesh` composed of two MULTIPOLYGONs sharing one edge.
#' Also available are `minimal_mesh_sp` and `minimal_mesh_sp_line` in
#' `SpatialPolygonsDataFrame`` and `SpatialLinesDataFrame`` form, respectively.
#' @name minimal_mesh
#' @aliases minimal_mesh_sp minimal_mesh_sp_line
#' @docType data
NULL

#' hsh, home sweet home
#'
#' A testing data set, a list of poly, line, points
#' @name hsh
#' @docType data
NULL
