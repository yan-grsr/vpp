# ==============================
# Makefile for my_app
# ==============================

# ---- User settings (EDIT THESE IF NEEDED) ----

# Name of the final executable
APP_NAME = VintagePhone

# ==============================
# Architecture selection
# ==============================

ARCH ?= x86

ifeq ($(ARCH),arm)
    CROSS_COMPILE = arm-linux-gnueabihf-
    PJDIR = /home/amartins/PJSIP/pjproject-2.16-arm
else
    CROSS_COMPILE =
    PJDIR = /home/amartins/PJSIP/pjproject-2.16-x86
endif


# ---- Compiler settings ----

include $(PJDIR)/build.mak
CC = $(CROSS_COMPILE)gcc

# Where source files are
SRC_DIR = src
INC_DIR = inc
BUILD_DIR = build/$(ARCH)

# All .c files inside src/
SRCS = $(wildcard $(SRC_DIR)/*.c)

# Convert src/main.c → build/main.o
OBJS = $(SRCS:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)

# ---- Include & Library paths ----

#CFLAGS = -Iinc $(shell pkg-config --cflags libpjsua)
#LDFLAGS = $(shell pkg-config --libs libpjsua)

# ==============================
# Build rules
# ==============================

# Default target
all: $(BUILD_DIR) $(APP_NAME)

# Create build directory if it doesn't exist
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Link executable
$(APP_NAME): $(OBJS)
	$(CC) $(OBJS) -o $(BUILD_DIR)/$(APP_NAME) $(PJ_LDFLAGS) $(PJ_LDLIBS)

# Compile source files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(PJ_CFLAGS) -c $< -o $@

# Clean build files
clean:
	rm -rf $(BUILD_DIR)

# Rebuild everything
rebuild: clean all
