#' function to illustrate topological editing of simple features
#'
#' Note that this uses the sc and scsf packages which have a much
#' grander goal than de-duplicating vertices and re-composing simple
#' features. The logic used can be trivially isolated into a small set
#' of functions for use in mapedit, or perhaps a separate package.
#'
#' Limited to pure edit of the points with no live redraw.
#' @param x simple features object, supported by scsf/sc::PATH
#' @param map mapview object
#' @export
#' @importFrom dplyr %>% select bind_cols
#' @importFrom mapview mapview
#' @importFrom mapedit editFeatures
#' @importFrom sf st_as_sf st_crs
#' @examples
#' x <- minimal_mesh
topoedit_sf <- function(x, map = NULL) {
  ##devtools::install_github("mdsumner/sc")
  ##devtools::install_github("mdsumner/scsf")
  require(scsf)
  require(sc)
  ## build the topological version
  ## all we really get are shared vertices for now
  prim <- btf_PATH(x)

  ## create point-versions we can identify
  sf_points <- sf::st_as_sf(prim$vertex, coords = c("x_", "y_"), crs = sf::st_crs(x))
  if (is.null(map)) map <- mapview::mapview()
  map <- map + mapview::mapview(x) + mapview::mapview(sf_points)
  edited <- mapedit::editFeatures(sf_points, map = map)
  prim$vertex <- edited %>% dplyr::select(vertex_) %>% dplyr::bind_cols(sc_coord(edited))
  scsf::sf(prim)
}
