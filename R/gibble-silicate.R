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
  path <- x[["path"]]
  if (is.null(path[["ncol_"]])) path$ncol_ <- 2
  if (is.null(path[["type"]])) path$type <- "PATH"
  path %>%
    dplyr::transmute(ncol = .data$ncol_,
                     type = .data$type,
                     subobject = .data$subobject_,
                     object = .data$object_,
                     path = .data$path_,
                     nrow = .data$ncoords_)
}
# gibble.PATH <- function(x, ...) {
#   p <- x[["path"]]
#   out <- tibble::tibble(nrow = p[["ncoords_"]],
#                         ncol = p[["ncol"]],
#                         type = p[["type"]],
#                         #subobject = p[["subobject"]],
#                         object = p[["object"]])
#   if ("subobject" %in% names(p)) out[["subobject"]] <- p[["subobject"]]
#   out
# }
