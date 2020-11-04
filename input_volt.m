function input_volt(serial)

    write(serial, 0x3f, 'uint8'); %1
    write(serial, 0xe0, 'uint8'); %2
    write(serial, 0x00, 'uint8'); %3
    write(serial, 0x00, 'uint8'); %4
    write(serial, 0x00, 'uint8'); %5
    write(serial, 0x00, 'uint8'); %6
    write(serial, 0x00, 'uint8'); %7
    write(serial, 0x00, 'uint8'); %8

end
