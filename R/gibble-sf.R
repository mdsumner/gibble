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
gibble.list <- function(x, ...) {
  ## this is a bit heinous, but basically we've been given an unclassed list
  ## and it *might* be a sfc, and some time in the future we will need a more
  ## nuanced approach to list-cols, because note that not only do we
  ## not have have other ibble class-methods, we are not dispatching on sfc here ...
  out <- try(ibble.sfc(x), silent = TRUE)
  if (inherits(out, "try-error")) stop("we tried to interpret as an sf/sfc list-column but failed")
  dplyr::mutate(tibble::as_tibble(out), type = names(types)[out[, "type", drop = TRUE]])
}
#' @name gibble
#' @export
gibble.sfc <- function(x, ...) {

  xout <- tibble::as_tibble(ibble(x))

   ## handle unknown type, which we presume is GEOMETRYCOLLECTION
  if (xout[["type"]][1L] == 11L) {
    classes <- unlist(lapply(x, function(xa) lapply(xa, function(xb) rev(class(xb))[2L])))
    if (length(classes) == dim(xout)[1L]) {
      xout[["type"]] <- classes
    }
  }

  if (is.numeric(x[["type"]][1L])) {
    xout[["type"]] <- names(types)[xout[["type"]]]
  }

  xout
}
#' @name gibble
#' @export
gibble.sf <- function(x, ...) {
  gibble(x[[attr(x, "sf_column")]])
}

