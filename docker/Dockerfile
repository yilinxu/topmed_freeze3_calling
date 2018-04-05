FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
    git \
    python-pip \
    python \
    wget \
    curl \
    unzip \
    zlib1g-dev \
    libncurses5-dev \
    libncursesw5-dev \
    vim

LABEL maintainer="jshands@ucsc.edu"

WORKDIR root

#using this will create a smaller image than git clone since it does not include the .git dir
#however the resulting directory to cd into is variable and I don't know how
#to set the working dir to that dir using WORKDIR
#RUN wget -O top_med_freeze3_calling.zip https://github.com/statgen/topmed_freeze3_calling/archive/b48632197d558ad23eae56eb2a695755918c425f.zip
#RUN unzip top_med_freeze3_calling.zip

#RUN git clone https://github.com/statgen/topmed_freeze3_calling.git
RUN git clone https://github.com/BD2KGenomics/topmed_freeze3_calling.git

WORKDIR topmed_freeze3_calling

RUN git checkout feature/dockerize-workflow

# Remove the .git folder which is quite large to reduce the size of the image
RUN rm -rf .git

RUN make SHELL=/bin/bash

