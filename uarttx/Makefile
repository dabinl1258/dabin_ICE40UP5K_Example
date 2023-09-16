build 	: 
		${call blink.json} 
		${call blink.asc} 
		${call blink.bin} 
blink.bin 	= 	icepack top.asc top.bin
blink.asc 	= 	nextpnr-ice40 --up5k --package sg48 --json top.json --pcf simple_uart_tx.pcf --asc top.asc --freq 48
blink.json 	=		yosys synth.ys
clean 	:
		del *.bin *asc *json 
