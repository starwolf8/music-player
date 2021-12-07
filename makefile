FILENAME = ser_rec_led
PORT = usb:J41800093954
DEVICE = atmega328p
PROGRAMMER = atmelice_isp
# BAUD = 115200
BAUD = 9600
COMPILE = avr-gcc -Wall -Os -mmcu=${DEVICE}

default: compile upload clean

compile:
	${COMPILE} -c ${FILENAME}.c -o ${FILENAME}.o
	${COMPILE} -o ${FILENAME}.elf ${FILENAME}.o
	avr-objcopy -j .text -j .data -O ihex ${FILENAME}.elf ${FILENAME}.hex
	avr-size --format=avr --mcu=${DEVICE} ${FILENAME}.elf

upload: 
	avrdude -v -p ${DEVICE} -c ${PROGRAMMER} -P ${PORT} -b ${BAUD} -U flash:w:${FILENAME}.hex:i

clean:
	rm ${FILENAME}.o 
	rm ${FILENAME}.elf 
	rm ${FILENAME}.hex