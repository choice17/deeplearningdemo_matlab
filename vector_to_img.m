% retrieve data
function main()
clear; clc; close all;

filepath = "{local_path}/"
dataName = "YaleFaceCrop.mat";
load( [filepath + dataName]);

fprintf('size of the data set is %i x %i \n',size(x))
%% reshape data from row to image format
ratio = 0.66;
[tx,ty,tstx,tsty,~,~] = shuffleImg(x,y,ratio);

reshapeX = reshape(tx,64,64,1,[]);
%trainX = permute(reshapeX,[3 1 2]);
reshapeTX = reshape(tstx,64,64,1,[]);

%% config

data_folder ='data';
mkdir(char(data_folder));
train_img_path = [data_folder + "\train_data\images\"];
test_img_path = [data_folder + "\test_data\images\"];
train_label_path = [data_folder + "\train_data\"];

test_label_path = [data_folder + "\test_data\"];

%% for training data
img_num = zeros(length(unique(ty)),1);
train_label_file = fopen(train_label_path+'labels.txt','w');
try
    for i = 1:size(tx,2)
        %path initialize
        person_idx = ty(i)+1;
        img_num(person_idx) = img_num(person_idx)+1;
        person_path = train_img_path + 'person' + num2str(person_idx,'%03i');
        mkdir(char(person_path));
        img_path = person_path + '\' +num2str(img_num(person_idx))+'.jpg';

        img = uint8(reshapeX(:,:,:,i));
        %img = img - min(img(:));
        %img = img./max(img(:));

        %output training file
        
        imwrite(img,char(img_path));
        fprintf(train_label_file,'%s %i\n', img_path,person_idx);
        disp(i)
    end
fclose(train_label_file);
catch
    pause();
end
%% for tesing data
img_num = zeros(length(unique(tsty)),1);
test_label_file = fopen(test_label_path+'labels.txt','w');
try
    for i = 1:size(tstx,2)
        %path initialize
        person_idx = tsty(i)+1;
        img_num(person_idx) = img_num(person_idx)+1;
        person_path = test_img_path + 'person' + num2str(person_idx,'%03i');
        mkdir(char(person_path));
        img_path = person_path + '\' +num2str(img_num(person_idx))+'.jpg';

        img = uint8(reshapeX(:,:,:,i));
        %img = img - min(img(:));
        %img = img./max(img(:));

        %output training file
        imwrite(img,char(img_path));
        fprintf(test_label_file,'%s %i\n', img_path,person_idx);
        disp(i)
    end
fclose(test_label_file);
catch
    pause();
end
end


