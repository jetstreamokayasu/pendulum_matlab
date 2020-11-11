function rad = baseangle2rad(base_angle) 

    BASE = double(0x3FFFF);

    if base_angle >= ( BASE / 2)
        
        rad = 2*pi*(double(base_angle) - BASE) / BASE;
        
    else
        
        rad = 2*pi*double(base_angle) / BASE;
        
    end

end

