FROM bioconductor/bioconductor_docker:devel

RUN mkdir -p /home/rstudio/sources
WORKDIR /home/rstudio/sources

RUN R -e "BiocManager::install(c('alabaster', 'chihaya'))"
RUN git clone https://github.com/ArtifactDB/zircon-R
RUN git clone https://github.com/CollaboratorDB/CollaboratorDB.schemas
RUN git clone https://github.com/CollaboratorDB/CollaboratorDB-R

# Trawling through their dependencies.
COPY install.R .
RUN R -f install.R

# Actually installing each one.
RUN R CMD INSTALL zircon-R
RUN R CMD INSTALL CollaboratorDB.schemas
RUN R CMD INSTALL CollaboratorDB-R

# Setting the working directory to the home.
WORKDIR /home/rstudio
