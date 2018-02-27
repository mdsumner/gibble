
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Build Status](http://badges.herokuapp.com/travis/mdsumner/gibble?branch=master&env=BUILD_NAME=trusty_release&label=ubuntu)](https://travis-ci.org/mdsumner/gibble) [![Build Status](http://badges.herokuapp.com/travis/mdsumner/gibble?branch=master&env=BUILD_NAME=osx_release&label=osx)](https://travis-ci.org/mdsumner/gibble) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/mdsumner/gibble?branch=master&svg=true)](https://ci.appveyor.com/project/mdsumner/gibble) [![Coverage Status](https://img.shields.io/codecov/c/github/mdsumner/gibble/master.svg)](https://codecov.io/github/mdsumner/gibble?branch=master)

gibble
======

The goal of gibble is to provide a straightforward map of path-based data structures. Paths are connected linear sequences of coordinates, otherwise known as *lines*. Structured spatial data includes *objects* composed of *paths*, which are islands, holes within island, lines, and points. Polygons require an extra grouping level *subobject* to ensure holes are nested within their island, but this is ignored for other types.

Sequential inear structures are not optimal for many operations when working with spatial data, and gibble provides a simple bridge between existing paths and tools to decompose them to primitives.

The original impetus for gibble was to illustrate how basic topological editing might be provided via the [mapedit package](https://CRAN.R-project.org/package=mapedit), and is used to consolidate the geometry decomposition tools in [silicate](https://github.com/hypertidy/silicate).

------------------------------------------------------------------------

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.
