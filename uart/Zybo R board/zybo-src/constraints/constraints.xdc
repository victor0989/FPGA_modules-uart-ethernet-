## This file is a general .xdc for the ZYBO Rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used signals according to the project

## Clock signal
set_property -dict { PACKAGE_PIN L16   IOSTANDARD LVCMOS33 } [get_ports { clk }]; #IO_L11P_T1_SRCC_35 Sch=sysclk
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { clk }];

## UART TX (corresponding to TXD from UART 1 on your board)
set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports { UART_TX }]; # Adjust to an available pin

## Reset (example, adjust if needed)
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { rst }]; # Adjust to an available pin

## Data Input (for 8 bits)
set_property -dict { PACKAGE_PIN G15   IOSTANDARD LVCMOS33 } [get_ports { tx_data[0] }]; # Adjust to an available pin
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { tx_data[1] }]; # Adjust to an available pin
set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports { tx_data[2] }]; # Adjust to an available pin
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { tx_data[3] }]; # Adjust to an available pin
set_property -dict { PACKAGE_PIN G15   IOSTANDARD LVCMOS33 } [get_ports { tx_data[4] }]; # Adjust to an available pin
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { tx_data[5] }]; # Adjust to an available pin
set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports { tx_data[6] }]; # Adjust to an available pin
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { tx_data[7] }]; # Adjust to an available pin

## Data Valid (example, adjust if needed)
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { tx_data_valid }]; # Adjust to an available pin
