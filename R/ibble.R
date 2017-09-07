types <- c(POINT = 1L, MULTIPOINT = 2L, LINESTRING = 3L, MULTILINESTRING = 4L, POLYGON = 5L, MULTIPOLYGON = 6L)

#' ibble
#'
#' ibble is the matrix version of gibble, implemented low down for speed
#'
#' @inheritParams gibble
#' @return matrix summarizing the geometry map, see `Details`
#' @importFrom dplyr %>% mutate bind_rows
#' @importFrom tibble tibble
ibble <- function(x, ...) UseMethod("ibble")
#' @name ibble
#'
ibble.default <- function(x, ...) stop(sprintf("objects of type %s not supported", paste(class(x), collapse = ";")))
#' @name ibble
#'
ibble.POINT <- function(x, ...) cbind(nrow = 1, ncol = length(unclass(x)), type = 1L)
#' @name ibble
#'
ibble.MULTIPOINT <- function(x, ...) {dm <- dim(unclass(x)); cbind(nrow = dm[1], ncol = dm[2], type = 2L)}
#' @name ibble
#'
ibble.LINESTRING  <- function(x, ...) {dm <- dim(unclass(x)); cbind(nrow = dm[1], ncol = dm[2], type = 3L)}
#' @name ibble
#'
ibble.MULTILINESTRING <- function(x, ...) {
  out <- do.call(rbind, lapply(unclass(x), ibble.MULTIPOINT))
  out[, "type"] <- 4L
  out
}
#' @name ibble
#'
ibble.POLYGON <- function(x, ...) {
  out <- do.call(rbind, lapply(unclass(x), ibble.MULTIPOINT))
  out[, "type"] <- 5L
  out
}
ibble.POLYPART <- function(x, subobject = 1L, ...) {
 out <- do.call(rbind, lapply(x, ibble.MULTIPOINT))
 cbind(out, subobject = subobject)
}
#' @name ibble
#'
ibble.MULTIPOLYGON <- function(x, ...) {
  x <- unclass(x)
  out <- do.call(rbind, lapply(seq_along(x), function(a) ibble.POLYPART(x[[a]], subobject = a)))
  out[, "type"] <- 6L
  out
}
#' @name ibble
#'
ibble.sfc <- function(x, ...) {
  x <- unclass(x)
  out <- do.call(rbind,lapply(seq_along(x), function(gi) cbind(ibble(x[[gi]]), object = gi)))
  out
}
#' @name ibble
#'
ibble.sf <- function(x, ...) {
  ibble(x[[attr(x, "sf_column")]])
}
