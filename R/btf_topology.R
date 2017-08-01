
btf_uid <- function (n = 1L)
{
  ids::random_id(n, bytes = 4)
}
btf_object <- function (x, ...)
{
  tibble::as_tibble(.btf_set_geometry(x))
}

## a basic function to work around sf stickiness
.btf_set_geometry <- function(x, value = NULL) {
    x[[attr(x, "sf_column")]] <- NULL
    tibble::as_tibble(as.data.frame(x))

}
