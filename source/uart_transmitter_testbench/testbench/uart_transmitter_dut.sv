module uart_transmitter_dut(uart_transmitter_interface system_interface);

	clock_generator clock_generator(
		.clock (system_interface.clock)
	);

    UART_TRANSMITTER uart_transmitter(
		.clock_i                  (system_interface.clock),
		.reset_n_i                (system_interface.reset),
		.data_i                   (system_interface.data),
		.data_write_i             (system_interface.write_enable),
		.data_buffer_full_tresh_i (system_interface.buffer_full_threshold),
		.baudrate_select_i        (system_interface.baudrate_select),
		.data_buffer_full_o       (system_interface.buffer_full),
		.uart_tx_o                (system_interface.data_out)
	);


endmodule: uart_transmitter_dut