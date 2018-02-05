
#' @export
gibble.POINT <- function(x, ...) {x <- tibble::as_tibble(ibble(x)); dplyr::mutate(x, type = names(types)[x$type])}

#' @export
gibble.MULTIPOINT <- function(x, ...) {dm <- dim(unclass(x)); tibble::tibble(nrow = dm[1], ncol = dm[2])} %>% dplyr::mutate(type = "MULTIPOINT")

#' @export
gibble.LINESTRING  <- function(x, ...) {dm <- dim(unclass(x)); tibble::tibble(nrow = dm[1], ncol = dm[2])} %>% dplyr::mutate(type = "LINESTRING")

#' @export
gibble.MULTILINESTRING <- function(x, ...) lapply(unclass(x), gibble.MULTIPOINT) %>% dplyr::bind_rows() %>% dplyr::mutate(type = "MULTILINESTRING")

#' @export
gibble.POLYGON <- function(x, ...) lapply(unclass(x), gibble.MULTIPOINT) %>% dplyr::bind_rows() %>% dplyr::mutate(type = "POLYGON")
gibble.POLYPART <- function(x, subobject = 1L, ...) {
  lapply(x, gibble.MULTIPOINT) %>%
    dplyr::bind_rows() %>%
    dplyr::mutate(subobject = subobject)
}

#' @export
gibble.MULTIPOLYGON <- function(x, ...) {
  x <- unclass(x)
  lapply(seq_along(x), function(a) gibble.POLYPART(x[[a]], subobject = a)) %>%
    dplyr::bind_rows() %>%
    dplyr::mutate(type = "MULTIPOLYGON")
}

#' @export
gibble.list <- function(x, ...) {
  ## this is a bit heinous, but basically we've been given an unclassed list
  ## and it *might* be a sfc, and some time in the future we will need a more
  ## nuanced approach to list-cols, because note that not only do we
  ## not have have other ibble class-methods, we are not dispatching on sfc here ...
  out <- try(ibble.sfc(x), silent = TRUE)
  if (inherits(out, "try-error")) stop("we tried to interpret as an sf/sfc list-column but failed")
  dplyr::mutate(tibble::as_tibble(out), type = names(types)[out[, "type", drop = TRUE]])
}
#' @export
gibble.sfc <- function(x, ...) {
  x <- tibble::as_tibble(ibble(x))
  dplyr::mutate(x, type = names(types)[x$type])
}

#' @export
gibble.sf <- function(x, ...) {
  gibble(x[[attr(x, "sf_column")]])
}
