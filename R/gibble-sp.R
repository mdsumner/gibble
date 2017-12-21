
gibble_sp <- function(x, ...) {
  out <- tibble::as_tibble(ibble(x, ...))
  out[["type"]] <- names(types)[out[["type"]]]
  out
}

#' @name gibble
#' @export
gibble.trip <- function(x, ...) {
  out <- tibble::as_tibble(ibble(x, ...))
  out[["type"]] <- "trip"
  out
}
#' @name gibble.Polygon
#' @rdname gibble
#' @export
gibble.Polygon <- function(x, ...) gibble_sp(x, ...)
#' @name gibble
#' @export
gibble.Polygons <- function(x, ...) gibble_sp(x, ...)
#' @name gibble
#' @export
gibble.SpatialPolygons <- function(x, ...) gibble_sp(x, ...)
#' @name gibble
#' @export
gibble.Line <- function(x, ...) gibble_sp(x, ...)
#' @name gibble
#' @export
gibble.Lines <- function(x, ...) gibble_sp(x, ...)
#' @name gibble
#' @export
gibble.SpatialLines <- function(x, ...) gibble_sp(x, ...)
#' @name gibble
#' @export
gibble.SpatialMultiPoints <- function(x, ...) gibble_sp(x, ...)
#' @name gibble
#' @export
gibble.SpatialPoints <- function(x, ...) gibble_sp(x, ...)
#' @name gibble
#' @export
gibble.Spatial <- function(x, ...) gibble_sp(x, ...)
