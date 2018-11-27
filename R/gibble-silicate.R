#' @name gibble
#' @export
gibble.PATH0 <- function(x, ...) {
  do.call(rbind, x$object$path_) %>%
    dplyr::rename(object = .data$object_, subobject = .data$subobject_, path = .data$path_) %>%
    dplyr::group_by(object, subobject, path) %>%
    dplyr::summarize(nrow = dplyr::n()) %>%
    dplyr::ungroup() %>%
   ## FIXME  need to find geometric dimension from $vertex
   dplyr::mutate(ncol = 2L)  ## what about type? set to unknown if not present?
}
#' @name gibble
#' @export
gibble.PATH <- function(x, ...) {
  x[["path"]] %>%
    dplyr::transmute(ncol = .data$ncol_,
                     type = .data$type,
                     subobject = .data$subobject_,
                     object = .data$object_,
                     path = .data$path_,
                     nrow = .data$ncoords_)
}
