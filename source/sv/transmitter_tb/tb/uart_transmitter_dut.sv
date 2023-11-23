module uart_transmitter_dut(sys_itf sys_if);

    UART_TRANSMITTER uart_transmitter(
		.clock_i                  (clock),
		.reset_n_i                (sys_if.reset_n_i),
		.data_i                   (sys_if.data_i),
		.data_write_i             (sys_if.data_write_i),
		.data_buffer_full_tresh_i (sys_if.data_buffer_full_tresh_i),
		.baudrate_select_i        (sys_if.baudrate_select_i),
		.data_buffer_full_o       (sys_if.data_buffer_full_o),
		.uart_tx_o                (sys_if.uart_tx_o)
	);


endmodule