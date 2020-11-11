%init_angle=�^���̃|�e���V���̒l
function arm_rad = armangle2rad(arm_angle, init_angle)

    ARM = 1024;
    
    %arm_0=�^��̃|�e���V���̒l
    arm_0 = double(init_angle) - 512;
    
    if arm_0 < 0
       
        arm_0 = arm_0 + 1024;
        
    end
    
    %�^���ȏ�ɐU��؂�Ă�����_�̊p�x�𕉂̒l�ɂ���
    if arm_angle > init_angle
        
        arm_rad = ( double(arm_angle) - (1024+arm_0) )*2*pi/ARM;
        
    else
        
        arm_rad = ( double(arm_angle) - arm_0 )*2*pi/ARM;
        
    end

end