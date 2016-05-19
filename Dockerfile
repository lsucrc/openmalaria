#Version 1.1
#add the base image
FROM lsucrc/crcbase
RUN  yum install -y gsl-devel xsd xerces-c-devel zlib-devel boost-devel
USER crcuser
#download the delft3d package
WORKDIR /model
RUN git clone https://github.com/SwissTPH/openmalaria.git

#compile
WORKDIR openmalaria
RUN cmake -f CMakeLists.txt  
RUN make -j 4
#ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/model/delft3d-5.01.00.2163/src/lib
ENV PATH $PATH:/model/openmalaria

#run test case in parallel
WORKDIR /model/openmalaria/test
RUN python run.py

