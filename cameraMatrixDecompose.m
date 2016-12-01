% Implementation of RQ decomposition.
% Found on 
% http://ksimek.github.io/2012/08/14/decompose/

% R is a triangular matrix (K)
% Q is an orthogonal matrix (R)

function [K R] = cameraMatrixDecompose(M);
%
    [R Q] = RQDecompose(M)
    K = R;
    R = Q;
   %k = K(:,2:4);
%     K = K(:,2:4);

    % make diagonal of K2 positive
    T = diag(sign(diag(K)));

    K = K * T;
    R = [T zeros(3,1);zeros(1,3) 1] * R; 
end    

function [R Q] = RQDecompose(M);
    [Q,R] = qr(flipud(M)');
    R = flipud(R');
    R = fliplr(R);

    Q = Q';   
    Q = flipud(Q);
    
    R = inv(R(:,2:4))
    Q = inv(Q)
    
end