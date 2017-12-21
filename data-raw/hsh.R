data("holey", package = "spbabel")
x <- spbabel::sp(holey, attr_tab = data.frame(a = 1:3))
hsh <- list(poly = as(x, "SpatialPolygons"), line = as(x, "SpatialLines"),
     point = as(as(x, "SpatialLines"), "SpatialMultiPoints"))

usethis::use_data(hsh)
