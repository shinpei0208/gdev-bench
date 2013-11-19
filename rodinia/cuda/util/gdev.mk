ifeq ($(CC),)
	CC = gcc
endif
NVCC = nvcc

NVCCFLAGS += -O3 \
	-use_fast_math \
	-arch sm_20 \
	-cubin 

CFLAGS += -I$(CUDA_TOP_DIR)/util \
	-I/usr/local/gdev/include \
	-L/usr/local/gdev/lib64 \
	-lucuda -lgdev \
	-O3 \
	-Wall \

CCFILES += $(CUDA_TOP_DIR)/util/util.c

.PHONY: all clean
all:
	$(NVCC) -o $(EXECUTABLE).cubin $(NVCCFLAGS) $(CUFILES)
	$(CC) -o $(EXECUTABLE) $(CCFILES) $(CFLAGS)

clean:
	rm -f $(EXECUTABLE) $(EXECUTABLE).cubin *~
