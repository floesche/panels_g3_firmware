help:
	@echo 'Help details:'
	@echo 'hex: compile hex file'
	@echo 'flash: install hex file'
	@echo 'program: compile hex and install'
	
hex:
	avr-gcc -Os -mmcu=atmega168 -std=gnu99 -c *.c 
	avr-gcc -mmcu=atmega168 -o panel.elf *.o 
	avr-objcopy -j .eeprom --set-section-flags=.eeprom="alloc,load" --change-section-lma .eeprom=0 --no-change-warnings -O ihex  panel.elf panel.eep
	avr-objcopy -R .eeprom -O ihex panel.elf panel.hex
	
flash:
	avrdude -c avrispmkII -p m168 -U flash:w:panel.hex -U eeprom:w:panel.eep

clean:
	rm -f *.o
	rm -f *.elf
	rm -f *.hex
	rm -f *.eep
