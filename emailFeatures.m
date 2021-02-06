function x = emailFeatures(word_indices) 
  n = 1899; 
  x = zeros(n,1); 
  for i  = word_indices
    x(i) = 1; 
  endfor
