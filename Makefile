CFLAGS=-std=c11 -g -fno-common -Wall
SRCS=${wildcard *.c}
OBJS=${SRCS:.c=.o}

TEST_SRCS=$(wildcard test/*.c)
TEST=$(TEST_SRCS:.c=.exe)

chibicc: $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

$(OBJS) : ljcc.h

test/%.exe: chibicc test/%.c
	$(CC) -o- -E -P -C test/$*.c | ./chibicc -o test/$*.s -


clean:
	rm -f chibicc *.o *~ tmp*

.PHONY: test clean