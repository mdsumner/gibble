types <- c(POINT = 1L, MULTIPOINT = 2L, LINESTRING = 3L, MULTILINESTRING = 4L, POLYGON = 5L, MULTIPOLYGON = 6L)

#' ibble
#'
#' ibble is the matrix version of gibble, implemented low down for speed
#'
#' A ibble is map of the geometry structure of an object. Each row of the ibble represents a
#' component element of the object's geometry and records the number of rows (i.e. how many coordinates) and
#' the number of columns (i.e. the number of axes in the geometric space). Another column `type` records the
#' class of the object, and `object` records an identifier for the entire object. A special case column
#' `parent` identifies the parent part within a MULTIPOLYGON. I.e. `part` is 1 unless that part is a hole.
#'
#' A ibble is not so helpful on its own, it is designed to work within a particular workflow such as
#' updating the coordinates of model object in a different context.
#'
#' A `ibble` is an improvement on the `sc_path` encoding of package `sc`, which is an improvement on the `map_table`
#' model of `spbabel` which is an improvement on the `sptable` model of spbabel which was an improvment on the `fortify` model
#' in `ggplot2`.
#' @param x geometry model
#' @param ... arguments reserved for methods, none currently
#' @return data frame summarizing the geometry map, see `Details`
#' @export
#' @importFrom dplyr %>% mutate bind_rows
#' @importFrom tibble tibble
#' @examples
#' ibble(minimal_mesh)
ibble <- function(x, ...) UseMethod("ibble")
#' @name ibble
#' @export
ibble.default <- function(x, ...) stop(sprintf("objects of type %s not supported", paste(class(x), collapse = ";")))
#' @name ibble
#' @export
ibble.POINT <- function(x, ...) cbind(nrow = 1, ncol = length(unclass(x)), type = 1L)
#' @name ibble
#' @export
ibble.MULTIPOINT <- function(x, ...) {dm <- dim(unclass(x)); cbind(nrow = dm[1], ncol = dm[2], type = 2L)}
#' @name ibble
#' @export
ibble.LINESTRING  <- function(x, ...) {dm <- dim(unclass(x)); cbind(nrow = dm[1], ncol = dm[2], type = 3L)}
#' @name ibble
#' @export
ibble.MULTILINESTRING <- function(x, ...) {
  out <- do.call(rbind, lapply(unclass(x), ibble.MULTIPOINT))
  out[, "type"] <- 4L
  out
}
#' @name ibble
#' @export
ibble.POLYGON <- function(x, ...) {
  out <- do.call(rbind, lapply(unclass(x), ibble.MULTIPOINT))
  out[, "type"] <- 5L
  out
}
ibble.POLYPART <- function(x, ...) {
 out <- do.call(rbind, lapply(x, ibble.MULTIPOINT))
 cbind(out, part = seq_len(nrow(out)))
}
#' @name ibble
#' @export
ibble.MULTIPOLYGON <- function(x, ...) {
  x <- unclass(x)
  out <- do.call(rbind, lapply(x, ibble.POLYPART))
  out[, "type"] <- 6L
  out
}
#' @name ibble
#' @export
ibble.sfc <- function(x, ...) {
  x <- unclass(x)
  out <- do.call(rbind,lapply(seq_along(x), function(gi) cbind(ibble(x[[gi]]), object = gi)))
  out
}
#' @name ibble
#' @export
ibble.sf <- function(x, ...) {
  ibble(x[[attr(x, "sf_column")]])
}
