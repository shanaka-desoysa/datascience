# R Cheatsheet
## Load a Package
Install if the package is not already installed. Load the package.
```R
pkg <- "PackageName"
loadPackage <- function(pkg) {
    if (!require(pkg, character.only = T)) {
        install.packages(pkg)
        require(pkg, character.only = T)
    }
}
```

## Create a Development Package
Create a skeleton for a Package. Add Documentation and Tests.
```R
utils::package.skeleton("PackageName")
setwd("PackageName")
devtools::document()
devtools::test()
```
