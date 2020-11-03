function input_voltage(serial, val)
    value = uint16(12499 * abs(val));
    sgn = uint16(sign(val) == -1);
    buf = uint32(bitor(value, bitshift(sgn, 14)));
    buf = bitshift(buf, 32 - 18);
    for i = 1 : 3
        send_data(i) = uint8(bitshift(bitand(buf, 0xFC000000), -26));
        buf = bitshift(buf, 6);
    end
    send_data = send_data + 0x30;
    
    write(serial, 0x10, 'uint8');
    for i = 1 : 3
%         write(serial, 0x31, 'uint8');
        write(serial, send_data(i), 'uint8');
    end
    write(serial, 0x0a, 'uint8');
end