##' build sf
##'
##' @param gm a gibble, geom map
##' @param vertex_pool the vertices to use, described by the gibble geom map `gm``
build_sf <- function(gm, coords_in, crs = NULL) {
  glist <- vector("list", length(unique(gm$object)))
  coords_in <- gm %>% dplyr::select(-type, -ncol, -nrow) %>%
    dplyr::slice(rep(seq_len(nrow(gm)), gm$nrow)) %>% dplyr::bind_cols(coords_in)
  ufeature <- unique(gm$object)
  for (ifeature in seq_along(ufeature)) {
    gm0 <- gm %>% dplyr::filter(object == ufeature[ifeature])
    type <- gm0$type[1]
    coord0 <- coords_in %>% dplyr::filter(object == ifeature)
    ## object becomes sub-feature element (not a hole, that is "part")
    coord0$object <- rep(seq_len(nrow(gm0)), gm0$nrow)
    glist[[ifeature]] <- switch(type,
                                POINT = sf::st_point(unlist(coord0 %>% dplyr::select(x_, y_))),
                                MULTIPOINT = sf::st_multipoint(as.matrix(coord0 %>% dplyr::select(x_, y_))),
                                LINESTRING = sf::st_linestring(as.matrix(coord0 %>% dplyr::select(x_, y_))),
                                MULTILINESTRTING = sf::st_multilinestring(lapply(split(coord0 %>% dplyr::select(x_, y_), coord0$object), as.matrix)),
                                POLYGON = sf::st_polygon(lapply(split(coord0 %>% dplyr::select(x_, y_), coord0$object), as.matrix)),
                                MULTIPOLYGON = sf::st_multipolygon(lapply(split(coord0 %>% dplyr::select(x_, y_, part), coord0$object),
                                                                          function(part) lapply(split(part %>% select(x_, y_), part$part), as.matrix)))
    )
  }
 # if (is.null(crs)) crs <- NA_crs_
  #out <-   st_sfc(glist, crs = crs)
  out
}



topoedit_sf <- function(x, map = NULL) {
  map <- NULL
  gm <- gibble(x)
  crs <- sf::st_crs(x)
  paste_ <- function(...) paste(..., sep = "-")
  coords <- st_coordinates(x) %>% tibble::as_tibble() %>% dplyr::transmute(x_ = X, y_ = Y) %>%
    dplyr::mutate(vertex = as.integer(forcats::as_factor(do.call(paste_, .))))
  vertex_pool <- distinct(coords, vertex, .keep_all = TRUE)
  ## create point-versions we can identify
  sf_points <- sf::st_as_sf(vertex_pool, coords = c("x_", "y_"),
                          crs = sf::st_crs(x))
  if (is.null(map)) map <- mapview::mapview()
  map <- map + mapview::mapview(x) + mapview::mapview(sf_points)
  edited <- mapedit::editFeatures(sf_points, map = map)
  library(scsf)
  library(sc)
  vertex_pool <- sf::st_set_geometry(edited, NULL) %>%
    dplyr::select(vertex) %>%
    dplyr::bind_cols(sf::st_coordinates(edited) %>%
                       tibble::as_tibble() %>%
                       dplyr::transmute(x_ = X, y_ = Y))

  coords_in <- vertex_pool %>% select(-vertex) %>%  slice(coords$vertex)
  st_geometry(x) <- build_sf(gm, coords_in)
  #if (is.na(crs)) x else sf::st_transform(x, crs)
  x
}



library(dplyr)
library(sf)


r <- spex::polygonize(raster::raster(matrix(1:12, 3)))
r2 <- topoedit_sf(r)
plot(r2)


pt <- st_cast(minimal_mesh, "POINT")
p2 <- topoedit_sf(pt)


face <- st_as_sf(rbgm::faceSpatial(rbgm::bgmfile(bgmfiles::bgmfiles("antarctica_28"))))


face2 <- topoedit_sf(face)
