VCD :=0

#defines
DEFINE+=$(defmacro)DATA_W=32 $(defmacro)ADDR_W=32

ifeq ($(VCD),1)
DEFINE+=$(defmacro)VCD
endif

include $(CACHE_DIR)/hardware/hardware.mk

#includes
INCLUDE+=$(incdir)$(CACHE_TB_DIR)

#headers
VHDR+=$(CACHE_TB_DIR)/iob-cache_tb.vh

#sources
#testbench
VSRC+=$(TB)

#axi memory
include $(AXI_DIR)/hardware/axiram/hardware.mk

waves:
	gtkwave uut.vcd

test: clean-testlog test1
	diff -q test.log test.expected

test1: clean
	make run VCD=0 TEST_LOG=">> test.log"

#clean test log only when tests begin
clean-testlog:
	@rm -f test.log

clean-all: clean-testlog clean
	@rm -rf *.vcd

.PHONY: waves \
	test test1 \
	clean-testlog clean clean-all
