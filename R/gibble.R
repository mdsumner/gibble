#' Path-based geometry decomposition
#'
#' Geometry map in a data frame. A generic function to summarize the available paths within a
#' complex type. Methods are provided for the `sf` classes. There is an internal version that
#' is designed to work fast on sets of structures, delaying conversion to list or data frame as late as possible.
#'
#' A gibble is map of the geometry structure of an object. Each row of the gibble represents a
#' component element of the object's geometry and records the number of rows (i.e. how many coordinates) and
#' the number of columns (i.e. the number of axes in the geometric space). Another column `type` records the
#' class of the object, and `object` records an identifier for the entire object. A special case column
#' `subobject` identifies the component POLYGON part within a MULTIPOLYGON.
#' I.e. `subobject` is 1 unless that part is a hole. All identifiers are sequential within implicit groups.
#'
#' A gibble is not so helpful on its own, it is designed to work within other workflows such as
#' updating the coordinates of model object in a different context or translating between superfically
#' different formats.
#'
#' A `gibble` is a distillation of the `sc_path` encoding of package `silicate`. That in turn came
#' from the  `map_table` and `sptable` decompositions of spbabel, which improve on the
#' single-table `fortify` model used in `ggplot2`.
#' @param x geometry model
#' @param ... arguments reserved for methods, none currently
#' @return data frame summarizing the geometry map, see `Details`
#' @export
#' @importFrom dplyr %>% mutate bind_rows
#' @importFrom tibble tibble
#' @examples
#' gibble(minimal_mesh)
gibble <- function(x, ...) UseMethod("gibble")
#' @name gibble
#' @export
gibble.default <- function(x, ...) stop(sprintf("objects of type %s not supported", paste(class(x), collapse = ";")))
#' @name gibble
#' @export
gibble.POINT <- function(x, ...) {x <- tibble::as_tibble(ibble(x)); dplyr::mutate(x, type = names(types)[x$type])}
#' @name gibble
#' @export
gibble.MULTIPOINT <- function(x, ...) {dm <- dim(unclass(x)); tibble::tibble(nrow = dm[1], ncol = dm[2])} %>% dplyr::mutate(type = "MULTIPOINT")
#' @name gibble
#' @export
gibble.LINESTRING  <- function(x, ...) {dm <- dim(unclass(x)); tibble::tibble(nrow = dm[1], ncol = dm[2])} %>% dplyr::mutate(type = "LINESTRING")
#' @name gibble
#' @export
gibble.MULTILINESTRING <- function(x, ...) lapply(unclass(x), gibble.MULTIPOINT) %>% dplyr::bind_rows() %>% dplyr::mutate(type = "MULTILINESTRING")
#' @name gibble
#' @export
gibble.POLYGON <- function(x, ...) lapply(unclass(x), gibble.MULTIPOINT) %>% dplyr::bind_rows() %>% dplyr::mutate(type = "POLYGON")
gibble.POLYPART <- function(x, subobject = 1L, ...) {
  lapply(x, gibble.MULTIPOINT) %>%
    dplyr::bind_rows() %>%
    dplyr::mutate(subobject = subobject)
}
#' @name gibble
#' @export
gibble.MULTIPOLYGON <- function(x, ...) {
  x <- unclass(x)
  lapply(seq_along(x), function(a) gibble.POLYPART(x[[a]], subobject = a)) %>%
    dplyr::bind_rows() %>%
    dplyr::mutate(type = "MULTIPOLYGON")
}
#' @name gibble
#' @export
gibble.sfc <- function(x, ...) {
  x <- tibble::as_tibble(ibble(x))
  dplyr::mutate(x, type = names(types)[x$type])
}
#' @name gibble
#' @export
gibble.sf <- function(x, ...) {
  gibble(x[[attr(x, "sf_column")]])
}
