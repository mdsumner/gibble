#' Basic Topological PATH Form
#'
#'
#' The PATH form is a simple normalization by vertex, it builds a common vertex pool
#' and provides the link tables (in order) to paths and objects.
#' @param x
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
btf_PATH <- function(x, ...) {
  ## copied from sc:::PATH.default
  o <- btf_object(x)
  o[["object_"]] <- btf_uid(nrow(o))
  b <- btf_path(x, ids = o[["object_"]])
  v <- btf_coord(x)
  V_names <- names(v)
  v <- dplyr::mutate(v, path_ = rep(b$path_, b$ncoords_))
  key_col <- "vertex_"
  maindata <- unjoin::unjoin_(v, V_names, key_col = key_col)
  dd <- maindata[["data"]]
  id <- btf_uid(n = nrow(dd))
  v <- dplyr::mutate(maindata[[key_col]], vertex_ = id[maindata[[key_col]][[key_col]]])
  bXv <- dplyr::mutate(maindata[["data"]], vertex_ = id[dd[[key_col]]])
  #join_ramp <- tabnames <- c("object", "path", "path_link_vertex",
  #                           "vertex")
  structure(list(object = o, path = b, vertex = v, path_link_vertex = bXv),
            class = c("PATH", "sc"))
}


build_sf <- function (x, ...)
{
  with(x, vertex %>% dplyr::inner_join(path_link_vertex) %>%
         dplyr::inner_join(path) %>%
         dplyr::inner_join(object)) %>% dplyr::rename(.vx0 = vertex_, branch_ = path_) %>%
    spbabel::sp()

}


btf_atom <- function(x, ...) tibble::tibble(ncoords_= nrow(x), path_ = btf_uid())
btf_list <- function(x) dplyr::bind_rows(lapply(x, btf_atom))
btf_path <- function(x, ...) UseMethod("btf_path")


.btf_get_geometry <- function(x) {
  x[[attr(x, "sf_column")]]
}
## infix sugar for if (is.null)
"%||%" <- function(a, b) {
  if (is.null(a)) b else a
}
btf_path <- function(x, ...) UseMethod("btf_path")
btf_path.sf <- function(x, ...) {
  btf_path(.btf_get_geometry(x), ...)
}
btf_path.sfc <- function(x, ids = NULL, ...) {
  x <- lapply(x, btf_path)
  if (!is.null(ids)) {
    stopifnot(length(ids) == length(x))
    x <- lapply(seq_along(x), function(a) dplyr::bind_cols(x[[a]], tibble::tibble(object_ = rep(ids[a], nrow(x[[a]])))))
  }
  dplyr::bind_rows(x)
}
btf_path.MULTIPOLYGON <- function(x, ...) {
  dplyr::bind_rows(lapply(x, btf_list), .id = "island_")
}
btf_path.POLYGON <- function(x, ...) {
  btf_list(x)
}
btf_path.LINESTRING <- btf_atom
btf_path.MULTILINESTRING <- btf_path.POLYGON
btf_path.POINT <- function(x, ...) btf_atom(matrix(x, nrow = 1L))
btf_path.MULTIPOINT <- function(x, ...) tibble::tibble(ncoords_ = 1, path_ = btf_uid(n = nrow(x)))

#sc_path.GEOMETRYCOLLECTION <- function(x, ...) dplyr::bind_rows(lapply(x, sc_path), .id = "collection_")

