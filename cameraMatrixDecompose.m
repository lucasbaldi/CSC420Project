% Implementation of RQ decomposition.
% Original found on 
% http://ksimek.github.io/2012/08/14/decompose/
% And modified by Lucas Baldi

function [K R] = cameraMatrixDecompose(M);
    [K R] = RQDecompose(M);

    % make diagonal of K2 positive
    T = diag(sign(diag(K)));

    K = K * T;
    R = [T zeros(3,1);zeros(1,3) 1] * R; 
end    


% R is a triangular matrix (K)
% Q is an orthogonal matrix (R)

function [R Q] = RQDecompose(M);

    %RQ Decomposition from QR Decomposition
    [Q,R] = qr(flipud(M)');
    
    R = flipud(R');
    R = fliplr(R);

    Q = Q';   
    Q = flipud(Q);
    
    R = R(:,2:4);
    
end