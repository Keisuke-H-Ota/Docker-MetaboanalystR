FROM ubuntu:20.04

RUN apt-get update
RUN apt-get install -y lsb-release
RUN apt-get install -y software-properties-common
RUN apt-get install -y gnupg2
RUN apt-get install -y libcairo2-dev
RUN apt-get install -y libnetcdf-dev
RUN apt-get install -y libxml2
RUN apt-get install -y libxt-dev
RUN apt-get install -y libssl-dev
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
RUN apt-get install -y --no-install-recommends r-base
RUN apt-get install -y build-essential
RUN apt-get install -y libxml2-dev
RUN apt-get install -y r-base-dev
CMD ["/bin/sh", "-c", "while :; do sleep 10; done"]