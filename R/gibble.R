#' gibble
#'
#' Geometry map in a data frame
#'
#' A gibble is map of the geometry structure of an object. Each row of the gibble represents a
#' component element of the object's geometry and records the number of rows (i.e. how many coordinates) and
#' the number of columns (i.e. the number of axes in the geometric space). Another column `type` records the
#' class of the object, and `object` records an identifier for the entire object. A special case column
#' `parent` identifies the parent part within a MULTIPOLYGON. I.e. `part` is 1 unless that part is a hole.
#'
#' A gibble is not so helpful on its own, it is designed to work within a particular workflow such as
#' updating the coordinates of model object in a different context.
#'
#' A `gibble` is an improvement on the `sc_path` encoding of package `sc`, which is an improvement on the `map_table`
#' model of `spbabel` which is an improvement on the `sptable` model of spbabel which was an improvment on the `fortify` model
#' in `ggplot2`.
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
gibble.POINT <- function(x, ...) tibble::as_tibble(ibble(x)) %>% dplyr::mutate(type = names(types)[type])
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
gibble.POLYPART <- function(x, ...) {
  lapply(x, gibble.MULTIPOINT) %>% dplyr::bind_rows(.id = "part")
}
#' @name gibble
#' @export
gibble.MULTIPOLYGON <- function(x, ...) {
  x <- unclass(x)
  lapply(x, gibble.POLYPART) %>% dplyr::bind_rows() %>% dplyr::mutate(type = "MULTIPOLYGON")
}
#' @name gibble
#' @export
gibble.sfc <- function(x, ...) {
  tibble::as_tibble(ibble(x)) %>% dplyr::mutate(type = names(types)[type])
}
#' @name gibble
#' @export
gibble.sf <- function(x, ...) {
  gibble(x[[attr(x, "sf_column")]])
}
