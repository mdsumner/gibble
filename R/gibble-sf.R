
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
gibble.sfc <- function(x, ...) {
  x <- tibble::as_tibble(ibble(x))
  dplyr::mutate(x, type = names(types)[x$type])
}

#' @export
gibble.sf <- function(x, ...) {
  gibble(x[[attr(x, "sf_column")]])
}
