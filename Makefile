CFLAGS=-std=c11 -g -fno-common -Wall
SRCS=${wildcard *.c}
OBJS=${SRCS:.c=.o}

chibicc: $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

$(OBJS) : ljcc.h

test: chibicc
	./test.sh


clean:
	rm -f chibicc *.o *~ tmp*

.PHONY: test clean