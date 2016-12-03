function [haralick1 haralick2 haralick3 haralick4 haralick5] = haralick(glcm);

    %To compute the first 5 haralick features we need
        %p_x(i) p_y(i) (helper function below)
        %mu, mu_x, mu_y
        %sig_x sig_y
        
    %Haralick features expressed as functions
    %http://journals.tubitak.gov.tr/elektrik/issues/elk-11-19-1/elk-19-1-8-0906-27.pdf


    mu_x = 0;
    for i=1:size(glcm,1)
        mu_x = mu_x + i * px(i, glcm);
    end

    mu_y = 0;
    for i=1:size(glcm,1)
        mu_y = mu_y + i * py(i, glcm);
    end

    mu = (mu_x + mu_y)/2;

    sig_x = 0;
    for i=1:size(glcm,1)
        sig_x = sig_x + (px(i, glcm) * (i-mu_x)^2);
    end
    sig_x = sqrt(sig_x);

    sig_y = 0;
    for i=1:size(glcm,1)
        sig_y = sig_y + (py(i, glcm) * (i-mu_y)^2);
    end
    sig_y = sqrt(sig_y);
    
    haralick1 = sum(glcm(:).^2);

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

    haralick3 = 0;

    for i=1:size(glcm,1)
        for j=1:size(glcm,1)

            inner = ((i-mu_x)*(i - mu_y)*glcm(i,j)) / (sig_x * sig_y);
            haralick3 = haralick3 + inner;
        end
    end

    haralick4 = 0;
    for i=1:size(glcm,1)
        for j=1:size(glcm,1)
            haralick4 = haralick4 + ((i-mu)^2 * glcm(i,j));
        end
    end

    haralick5 = 0;
    for i=1:size(glcm,1)
        for j=1:size(glcm,1)
            inner = (1/(1+(i-j)^2)) * glcm(i,j); 
            haralick5 = haralick5 + inner;     
        end
    end
    
end

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