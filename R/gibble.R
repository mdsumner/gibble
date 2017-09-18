#'Path-based geometry decomposition
#'
#'A gibble is a geometry map, a summary of the structure of each path within a
#'simple planar shape. The generic function `gibble()` will summarize all paths
#'within a complex type with a data frame row for each. Each row of the gibble
#'summary represents a component element of the object's geometry and records
#'the number of rows (i.e. how many coordinates) and the number of columns (i.e.
#'the number of axes in the geometric space). Another column `type` records the
#'class of the object, and `object` records an identifier for the entire object.
#'A special case column `subobject` identifies the component POLYGON part within
#'a MULTIPOLYGON. I.e. `subobject` is 1 unless that part is a hole. All
#'identifiers are sequential within the higher level groupings.
#'
#'Methods are provided for the `sf` classes. There is an internal version that
#'is designed to work fast on sets of structures, by delaying conversion to list
#'or data frame for as late as possible.
#'
#'A geometry map is not so helpful on its own, and so does not have a formal
#'class. It is designed for use within other workflows such as updating the
#'coordinates of model object  or translating between superficially different
#'formats.
#'
#'Gibble is a distillation of the `sc_path` encoding of package
#'[silicate](https://github.com/hypertidy/silicate), which came from the
#'`map_table` decompositions of spbabel, as an improvement on the single-table
#'`fortify` model used in `ggplot2`.
#'@param x geometry model
#'@param ... arguments reserved for methods, none currently
#'@return data frame summarizing the geometry map, see `Details`
#'@export
#'@importFrom dplyr %>% mutate bind_rows
#'@importFrom tibble tibble
#' @examples
#' gibble(minimal_mesh)
gibble <- function(x, ...) UseMethod("gibble")

#' @export
gibble.default <- function(x, ...) stop(sprintf("objects of type %s not supported", paste(class(x), collapse = ";")))
