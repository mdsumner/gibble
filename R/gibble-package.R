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

#' mpoly
#'
#' A testing data set, composed of two MULTIPOLYGONs, one is the manually constructed
#' example from sf (and silicate::sfzoo$multipolygon), the second is South Australia, with
#' many lake-islands in the main polygon, and one artifical hole in the Kangaroo Island polygon.
#'
#' @name mpoly
#' @docType data
NULL

#' minimal mesh
#'
#' A testing data set, `minimal_mesh` composed of two MULTIPOLYGONs sharing one edge.
#' @name minimal_mesh
#' @docType data
NULL

#' hsh, home sweet home
#'
#' A testing data set, a list of poly, line, points. The relationships
#' between the objects cover many interesting cases. There are multi-island
#' objects with holes and other objects that fall inside those holes. All paths
#' share vertices with a neighbour. There is topological intersection
#' along a diagonal line where two objects meet and are joined by
#' shared vertices that were inserted deliberately.
#'
#'  `hsh_sf` is the holey home in sf format.
#' @name hsh_sf
#' @docType data
NULL
