#' @name gibble
#' @export
#' @importFrom rlang .data
gibble.PATH0 <- function(x, ...) {
  do.call(rbind, x$object$path_) %>%
    dplyr::rename(object = .data$object_, subobject = .data$subobject_, path = .data$path_) %>%
    dplyr::group_by(.data$object, .data$subobject, .data$path) %>%
    dplyr::summarize(nrow = dplyr::n()) %>%
    dplyr::ungroup() %>%
   ## FIXME  need to find geometric dimension from $vertex
   dplyr::mutate(ncol = 2L)  ## what about type? set to unknown if not present?
}
#' @name gibble
#' @export
gibble.PATH <- function(x, ...) {
  path <- x[["path"]]
  if (is.null(path[["ncol"]])) path$ncol <- 2
  if (is.null(path[["type"]])) path$type <- "PATH"
  if (is.null(path[["subobject"]])) {
     path$subobject <- if (!is.null(path[["subobject_"]])) path$subobject_ else 1L
  }
  if (is.null(path[["object"]])) {
    path$object <- if (!is.null(path[["object_"]])) as.integer(factor(path$object_)) else 1:nrow(path)
  }
  if (is.null(path[["nrow"]])) {
    path$nrow <- if (!is.null(path[["ncoords_"]])) path$ncoords_ else NA_integer_
  }

## object_ path_ subobject_ ncoords_
  path[c("nrow", "ncol", "type", "subobject", "object")]
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
