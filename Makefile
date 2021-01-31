	CC=gcc

# server
OUT=httpserver
SRC=src
BIN=bin
SOURCES=$(wildcard $(SRC)/*.c)
OBJECTS=$(patsubst $(SRC)/%.c, $(BIN)/%.o, $(SOURCES))

# release
RELEASE_DIR=./release
RELEASE_DIR=$(RELEASE_DIR)/server
RELEASE_DIR=$(RELEASE_DIR)/client
RELEASE_DATA=./data

# COMPILER FLAGS HERE
INC_FLAGS=
CFLAGS=-g $(INC_FLAGS)

# create httpserver
all: $(OUT)

# create release
release: server
	mkdir -p $(RELEASE_DIR)
	cp -r $(RELEASE_DATA)/server/* $(RELEASE_DIR)
	cp $(OUT) $(RELEASE_DIR)

# httpserver
$(OUT): $(OBJECTS)
	$(CC) -o $@ $^
$(BIN)/%.o: $(SRC)/%.c
	mkdir -p $(BIN)
	$(CC) -c -o $@ $< $(CFLAGS)

#################  UNIT TEST CODE FROM HERE DOWN  ############

TEST_DIR=./test

# test server
TEST_DIR=test
TEST_OUT=$(TEST_DIR)/$(OUT)test
TEST_SRC=$(TEST_DIR)/src
TEST_BIN=$(TEST_DIR)/bin
TEST_SOURCES=$(wildcard $(TEST_SRC)/*.c)
TEST_OBJECTS= $(patsubst $(TEST_SRC)/%.c, $(TEST_BIN)/%.o, $(TEST_SOURCES))

# CuTest plugin for test
CUTEST_DIR=$(TEST_DIR)/cutest
CUTEST_SRC=$(CUTEST_DIR)/src
CUTEST_BIN=$(CUTEST_DIR)/bin
CUTEST_SOURCES=$(wildcard $(CUTEST_SRC)/*.c)
CUTEST_OBJECTS+=$(patsubst $(CUTEST_SRC)/%.c, $(CUTEST_BIN)/%.o, $(CUTEST_SOURCES))

# test compiler options here
TEST_CFLAGS=$(CFLAGS) -I$(CUTEST_SRC)

# create tests
test: $(TEST_OUT)

# test server
$(TEST_OUT): $(TEST_OBJECTS) $(CUTEST_OBJECTS)
	$(CC) -g -o $@ $^
$(TEST_BIN)/%.o: $(TEST_SRC)/%.c
	mkdir -p $(TEST_BIN)
	$(CC) -c -o $@ $^ $(TEST_CFLAGS) -I$(SRC)

# CuTest
$(CUTEST_BIN)/%.o: $(CUTEST_SRC)/%.c
	mkdir -p $(CUTEST_BIN)
	$(CC) -c -o $@ $<

#################  UNIT TEST CODE FROM HERE UP  ##############

debug:
	@echo SOURCES: $(SOURCES)
	@echo OBJECTS: $(OBJECTS)

	@echo TEST_SOURCES: $(TEST_SOURCES)
	@echo TEST_OBJECTS: $(TEST_OBJECTS)
	@echo CUTEST_SOURCES: $(CUTEST_SOURCES)
	@echo CUTEST_OBJECTS: $(CUTEST_OBJECTS)

.PHONY: clean
clean:
	rm -f -r $(OUT) $(RELEASE_DIR)
	rm -f -r $(BIN)
	rm -f -r $(TEST_OUT)
	rm -f -r $(TEST_BIN) $(UTEST_BIN) $(CUTEST_BIN)
ifeq ($(OS),Windows_NT)
	rm -f $(OUT).exe $(OUT)Test.exe
else
	rm -f $(OUT) $(OUT)Test
endif
