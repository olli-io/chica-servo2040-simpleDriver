set(OUTPUT_NAME chica-servo2040)
add_executable(${OUTPUT_NAME} chica-servo2040.cpp)

target_link_libraries(${OUTPUT_NAME}
        pico_stdlib
        servo2040
        analogmux
        analog
        button
        )

# enable uart output on GP20/GP21 (see UART pin override below), disable usb
pico_enable_stdio_usb(${OUTPUT_NAME} 0)
pico_enable_stdio_uart(${OUTPUT_NAME} 1)

# Route stdio UART to UART1 on GP20/GP21 — the only RP2040 UART pin pair that
# does not collide with the Servo2040's servo outputs (GP0-GP17), LED (GP18),
# ADC mux/USER_SW (GP22-GP25), or analog inputs (GP26-GP29).
target_compile_definitions(${OUTPUT_NAME} PRIVATE
        PICO_DEFAULT_UART=1
        PICO_DEFAULT_UART_TX_PIN=20
        PICO_DEFAULT_UART_RX_PIN=21
        )

pico_add_extra_outputs(${OUTPUT_NAME})
