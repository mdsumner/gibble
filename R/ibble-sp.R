
ibble.Polygon <- function(x, ...) cbind(nrow = slot(x, "coords"), ncol = 2L, type = 7L)
ibble.Polygons <- function(x, ...) do.call(rbind, lapply(slot(x, "Polygons"), ibble))
ibble.Line <- function(x, ...) cbind(nrow = slot(x, "coords"), ncol = 2L, type = 8L)
ibble.Lines <- function(x, ...) do.call(rbind, lapply(slot(x, "Lines"), ibble))

#' @importFrom methods slot
ibble.SpatialPolygons <- function(x, ...) do.call(rbind, lapply(slot(x, "polygons"), ibble))
ibble.SpatialLines <- function(x, ...) do.call(rbind, lapply(slot(x, "lines"), ibble))
ibble.SpatialPoints <- function(x, ...) cbind(nrow = rep(1L, nrow(slot(x, "coords"))), ncol = 2L, type = 9L)
ibble.SpatialMultiPoints <- function(x, ...) do.call(rbind, lapply(slot(x, "coords"), function(a) cbind(nrow = nrow(a), ncol = 2L, type = 10L)))



#' @export
gibble.Polygon <- function(x, ...) {
  out <- tibble::as_tibble(ibble(x, ...))
  out[["type"]] <- names(types)[out[["type"]]]
  out
}
#' @export
gibble.Polygons <- gibble.Polygon
#' @export
gibble.SpatialPolygons <- gibble.Polygon
#' @export
gibble.Line <- gibble.Polygon
#' @export
gibble.Lines <- gibble.Polygon
#' @export
gibble.SpatialLines <- gibble.Polygon
#' @export
gibble.SpatialMultiPoints <- gibble.Polygon
#' @export
gibble.SpatialPoints <- gibble.Polygon
#' @export
gibble.Spatial <- gibble.Polygon
