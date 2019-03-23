function test(ty,train_label_path,tx,train_img_path,reshapeX)
img_num = zeros(length(unique(ty)),1);
train_label_file = fopen(train_label_path+'labels.txt','w');

for i = 1:size(tx,2)
    %path initialize
    person_idx = ty(i);
    img_num(person_idx) = img_num(person_idx)+1;
    person_path = train_img_path + 'person' + num2str(person_idx,'%03i');
    mkdir(char(person_path));
    img_path = person_path + '\' +num2str(img_num(person_idx))+'.jpg';
    
    img = reshapeX(:,:,:,i);
    img = img - min(img(:));
    img = img./max(img(:));
    
    %output training file
    imwrite(img,char(img_path));
    fprintf(train_label_file,'%s %i\n', img_path,person_idx);
end
fclose(train_label_file);
end