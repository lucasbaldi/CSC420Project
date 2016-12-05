function [haralick1 haralick2 haralick3 haralick4 haralick5] = haralick(glcm);

    %To compute the first 5 haralick features we need
        %p_x(i) p_y(i) (helper function below) - Marginal probabilities
        % mu_x, mu_y - act as mean values
        % mu - mean of mean values
        %sig_x sig_y - standard deviations of marginal probabilities
        
    %Haralick features expressed as functions
    %http://journals.tubitak.gov.tr/elektrik/issues/elk-11-19-1/elk-19-1-8-0906-27.pdf

    %Calculate mu_x and mu_y
    mu_x = 0;
    mu_y = 0;
    sig_x = 0;
    sig_y = 0;

    for i=1:size(glcm,1)
        mu_x = mu_x + i * px(i, glcm);
        mu_y = mu_y + i * py(i, glcm);
        sig_x = sig_x + (px(i, glcm) * (i-mu_x)^2);
        sig_y = sig_y + (py(i, glcm) * (i-mu_y)^2);
    end

    mu = (mu_x + mu_y)/2;
    sig_x = sqrt(sig_x);
    sig_y = sqrt(sig_y);

    %Angular second moment
    haralick1 = sum(glcm(:).^2);

    %Contrast
    haralick2 = 0;
    for n=0:(size(glcm,1)-1)
       inner = 0;
       for i=1:size(glcm,1)
           for j=1:size(glcm,1)
              if(abs(i-j) == n)
                  inner = glcm(i,j);
              end
           end
       end
       haralick2 = haralick2 + (n^2 * inner);
    end
    
    %Correlation
    haralick3 = 0;
    
    %Sum of squares: variance
    haralick4 = 0;
    
    %Inverse Difference Moment
    haralick5 = 0;

    for i=1:size(glcm,1)
        for j=1:size(glcm,1)

            h3inner = ((i-mu_x)*(i - mu_y)*glcm(i,j)) / (sig_x * sig_y);
            haralick3 = haralick3 + h3inner;
            
            haralick4 = haralick4 + ((i-mu)^2 * glcm(i,j));
            
            h5inner = (1/(1+(i-j)^2)) * glcm(i,j); 
            haralick5 = haralick5 + h5inner;  

        end
    end
end

% P_x and p_y represent the marginal probabilities of a value p(i)
function p_x = px(i, glcm);
    p_x = 0; 
    for j=1:size(glcm, 1)
       p_x = p_x + glcm(i,j);
    end
end

function p_y = py(j, glcm);
    p_y = 0; 
    for i=1:size(glcm, 1)
       p_y = p_y + glcm(i,j);
    end
end