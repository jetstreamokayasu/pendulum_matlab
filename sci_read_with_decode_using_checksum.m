function sh2pc = sci_read_with_decode_using_checksum(serial)
    readSize = 0;
    lastwarn('');  %readの警告をキャッチするためにlastwarnをリセット
    while 1
        readBuf(readSize + 1) = read(serial, 1, 'uint8');
        [~, warnId] = lastwarn;
        if string(warnId) == "serialport:serialport:ReadWarning"
            disp("タイムアウト");
            return
        end
        readSize = readSize + 1;
        
        if uint8(readBuf(readSize)) == 0x0a
            break;
        end
        
    end
    
    %% チェックサムによる誤り検知
    
    if (bitand(uint8(mod(sum(readBuf(1:end-2)), 256)), 0x3f) + 0x30) ~= uint8(readBuf(end-1))
        disp('ビット誤りが検知されました');
        return;
    end
    
   %% データのデコード
    buf = readBuf(1:4);
    buf = int64(uint8(buf) - 0x30);
    sh2pc.TMStamp = bitor(bitshift(buf(1), 6 * 3), bitor(bitor(bitshift(buf(2), 6 * 2), bitshift(buf(3), 6 * 1)), buf(4)));
    
    buf = readBuf(5:7);
    buf = int64(uint8(buf) - 0x30);
    sh2pc.BaseAngle = bitor(bitor(bitshift(buf(1), 6 * 2), bitshift(buf(2), 6 * 1)), buf(3));
    
    buf = readBuf(8:9);
    buf = int64(uint8(buf) - 0x30);
    sh2pc.ArmAngle = bitor(bitshift(buf(1), 6 * 1), buf(2));
    
    buf = readBuf(10:12);
    buf = int64(uint8(buf) - 0x30);
    sh2pc.PwmDuty = bitor(bitor(bitshift(buf(1), 6 * 2), bitshift(buf(2), 6 * 1)), buf(3));
end
