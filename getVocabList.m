function vocabList = getVocabList()
  fid = fopen('vocab.txt'); 
  n = 1899 %total vocab number in vocab.txt
  vocabList = cell(n,1); 
  for i = 1:n
    fscanf(fid, '%d' , 1); 
    vocabList{i} = fscanf(fid, '%s' , 1);
  endfor
  fclose(fid); 
endfunction
