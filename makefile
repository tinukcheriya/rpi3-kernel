CROSS_COMPILE = aarch64-linux-gnu-

CC = $(CROSS_COMPILE)gcc
AS = $(CROSS_COMPILE)as
LD = $(CROSS_COMPILE)ld
OBJCOPY = $(CROSS_COMPILE)objcopy

CFLAGS = -Wall -O0 -g -ffreestanding -nostdlib \
         -nostartfiles -fno-builtin \
         -mcpu=cortex-a53

ASFLAGS = -mcpu=cortex-a53

LDFLAGS = -T linker.ld

TARGET = kernel

OBJS = init/startup.o main/main.o


all: $(TARGET).img


init/startup.o: init/startup.s
	$(AS) $(ASFLAGS) $< -o $@


main/main.o: main/main.c
	$(CC) $(CFLAGS) -c $< -o $@


$(TARGET).elf: $(OBJS)
	$(LD) $(LDFLAGS) $^ -o $@


$(TARGET).img: $(TARGET).elf
	$(OBJCOPY) -O binary $< $@


clean:
	rm -f $(OBJS) $(TARGET).elf $(TARGET).img