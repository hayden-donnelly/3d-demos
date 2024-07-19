CC = gcc
AR = ar
RM = rm -f
MKDIR = mkdir -p

CFLAGS = -I./external/glad/include
LDFLAGS = -L./build -lglad -lglfw

SRC_DIR = src
BUILD_DIR = build
GLAD_DIR = external/glad

GLAD_SRC = $(GLAD_DIR)/src/gl.c
GLAD_LIB = $(BUILD_DIR)/libglad.a

SDF1_SRCS = $(SRC_DIR)/common/fragctx.c $(SRC_DIR)/sdf1.c
SDF1_OBJS = $(SDF1_SRCS:.c=.o)
SDF1_TARGET = $(BUILD_DIR)/sdf1

.PHONY: all clean run

all: $(GLAD_LIB) $(SDF1_TARGET)

$(GLAD_LIB): $(GLAD_SRC)
	$(MKDIR) $(BUILD_DIR)
	$(CC) -c $< -I $(GLAD_DIR)/include
	$(AR) rcs $@ gl.o
	$(RM) gl.o

$(SDF1_TARGET): $(SDF1_OBJS) $(GLAD_LIB)
	$(MKDIR) $(BUILD_DIR)
	bash ./scripts/shaders_to_header.sh
	$(CC) $(CFLAGS) -o $@ $(SDF1_OBJS) $(LDFLAGS)
	$(RM) $(SDF1_OBJS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

run: $(SDF1_TARGET)
	./$(SDF1_TARGET)

clean:
	$(RM) $(GLAD_LIB) $(SDF1_TARGET) $(SDF1_OBJS)
	$(RM) -r $(BUILD_DIR)
