%init_angle=真下のポテンショの値
function arm_rad = armangle2rad(arm_angle, init_angle)

    ARM = 1024;
    
    %arm_0=真上のポテンショの値
    arm_0 = double(init_angle) - 512;
    
    if arm_0 < 0
       
        arm_0 = arm_0 + 1024;
        
    end
    
    %真下以上に振り切れていたら棒の角度を負の値にする
    if arm_angle > init_angle
        
        arm_rad = ( double(arm_angle) - (1024+arm_0) )*2*pi/ARM;
        
    else
        
        arm_rad = ( double(arm_angle) - arm_0 )*2*pi/ARM;
        
    end

end