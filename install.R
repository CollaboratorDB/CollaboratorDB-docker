# Loops through all source directories here and installs their dependencies.
all.sources <- list.files()

collected <- list()
for (y in all.sources) {
    if (!file.info(y)$isdir) {
        next
    }

    X <- read.dcf(file.path(y, "DESCRIPTION"))
    req <- intersect(c("Imports", "Suggests", "Depends", "LinkingTo"), colnames(X))
    collected[[X[1,"Package"]]] <- as.character(unlist(strsplit(X[1,req], ",?\n"), use.names=FALSE))
}

all.deps <- unique(unlist(collected, use.names=FALSE))
leftovers <- setdiff(all.deps, names(collected))
BiocManager::install(leftovers)
