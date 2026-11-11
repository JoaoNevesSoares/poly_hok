ERL_ROOT := $(shell asdf where erlang)
ERL_INCLUDE := $(ERL_ROOT)/usr/include

all: priv/gpu_nifs.so 

priv/gpu_nifs.so: c_src/gpu_nifs.cu
	nvcc --shared -g -lcuda -lnvrtc -I$(ERL_INCLUDE) --compiler-options '-fPIC' -o priv/gpu_nifs.so c_src/gpu_nifs.cu

bmp: c_src/bmp_nifs.cu 
	nvcc --shared -g --compiler-options '-fPIC' -o priv/bmp_nifs.so c_src/bmp_nifs.cu -ccbin gcc-10

clean:
	rm priv/gpu_nifs.so
