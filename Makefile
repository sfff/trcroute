
ASFLAGS += --32
LDFLAGS += -s -m elf_i386

trcroute:	trcroute.o
		ld ${LDFLAGS} $^ -o $@

clean:
		rm -f trcroute *.o *.out

