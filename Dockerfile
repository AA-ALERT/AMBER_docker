# Use NVIDIA Docker image
FROM nvidia/cuda

# Install all necessary system packages
WORKDIR /
RUN apt-get -qq -y update && apt-get -qq -y install \
    build-essential \
    git \
    cmake \
    libgtest-dev \
    opencl-headers
RUN apt-get clean

# Install Google Test
WORKDIR /usr/src/gtest/build
RUN cmake .. && make
RUN cp *.a /usr/lib

# Install AMBER
WORKDIR /opt/amber
RUN git clone https://github.com/AA-ALERT/AMBER_setup.git -b development
ENV SOURCE_ROOT="/opt/amber/src"
ENV INSTALL_ROOT="/opt/amber/build"
WORKDIR /opt/amber/AMBER_setup
RUN ./amber.sh install development
