#' @importFrom methods slot

## subobject doesn't make sense at this level
## it's the sequential sum of this that correctly groups polygons within
## multipolygons in SF
ibble.Polygon <- function(x, ...) cbind(nrow = nrow(slot(x, "coords")), ncol = 2L, type = 7L, subobject = slot(x, "hole") == 0L)
ibble.Line <- function(x, ...) cbind(nrow = nrow(slot(x, "coords")), ncol = 2L, type = 8L)

ibble.Polygons <- function(x, ...) ibble_Polygons(x, object = 1L, ...)
ibble_Polygons <- function(x, object,  ...) {
  ## see here how we need to call the S3 method directly, not sure ... 2017-12-21
  out <- do.call(rbind, lapply(slot(x, "Polygons"), ibble.Polygon))
  ## subobject is assumed to increment between holes
  ## as it does for sf, any further work needs SPcomment or geometric tests
  ## (or, just convert to sf ...)
  out[, "subobject"] <- cumsum(out[, "subobject"])
  cbind(out, object = object)
}

ibble.SpatialPolygons <- function(x, ...) {
  gi <- seq_along(x)
  gx <- slot(x, "polygons")
  cbind(do.call(rbind, lapply(gi, function(a) ibble_Polygons(gx[[a]], gi[a]))))
}
ibble.Lines <- function(x, ...) {
  out <- do.call(rbind, lapply(slot(x, "Lines"), ibble.Line))
  cbind(out, subobject = seq_len(nrow(out)))
}

## see here how we need to call the S3 method directly, not sure ... 2017-12-21
ibble.SpatialLines <- function(x, ...) {
  out <- do.call(rbind, lapply(slot(x, "lines"), ibble.Lines))
  cbind(out, object = seq_along(slot(x, "lines")))
}
ibble.SpatialPoints <- function(x, ...) cbind(nrow = rep(1L, nrow(slot(x, "coords"))), ncol = 2L, type = 9L)
ibble.SpatialMultiPoints <- function(x, ...) do.call(rbind, lapply(slot(x, "coords"), function(a) cbind(nrow = nrow(a), ncol = 2L, type = 10L)))


ibble.trip <- function(x, ...) {
  ## treat this like multipoint
  tor <- slot(x, "TOR.columns")
  trip_ids <- x[[tor[2L]]]
  cbind(nrow = tapply(trip_ids, trip_ids, length),
        ncol = 3L, type = NA_integer_, object = seq_along(unique(trip_ids)))
}
