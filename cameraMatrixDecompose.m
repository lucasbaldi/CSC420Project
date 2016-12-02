% Implementation of RQ decomposition.
% Found on 
% http://ksimek.github.io/2012/08/14/decompose/

function [K R] = cameraMatrixDecompose(M);
%
    [K R] = RQDecompose(M);
    %K = R;
    %R = Q;
   %k = K(:,2:4);
%     K = K(:,2:4);

    % make diagonal of K2 positive
    T = diag(sign(diag(K)));

    K = K * T;
    R = [T zeros(3,1);zeros(1,3) 1] * R; 
end    


% R is a triangular matrix (K)
% Q is an orthogonal matrix (R)

function [R Q] = RQDecompose(M);
    [Q,R] = qr(flipud(M)');
    R = flipud(R');
    R = fliplr(R);

    Q = Q';   
    Q = flipud(Q);
    
    % Need to invert 
    % according to
    % http://campar.in.tum.de/twiki/pub/Chair/TeachingWs09Cv2/3D_CV2_WS_2009_Reminder_Cameras.pdf
    % page 33
    %R = inv(R(:,2:4));
    R = R(:,2:4);
    %Q = inv(Q);
    
end