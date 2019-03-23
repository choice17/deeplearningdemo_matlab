# MATLAB simple deeplearning module for classification

Data  

It is cropped image set from Yale Extended Face set. Based on Vialo Jones Haar Cascade Detector.
There is 29 persons with total over 10000 images. 

 @Article{KCLee05, 
  author =  "K.C. Lee and J. Ho and D. Kriegman", 
  title =   "Acquiring Linear Subspaces for Face Recognition under Variable Lighting ", 
  journal = "IEEE Trans. Pattern Anal. Mach. Intelligence", 
  year =  2005, 
  volume = 27,
  number = 5, 
  pages= "684-698"
 } 
  

The data sets are all located in data.tar.gz
With training data and test data using stratified sampling.

A skin color tuning simple tool

`gray2color.py` helps to change skin color by tuning red channel.
It helps to turn gray scale to rgb channels.

Usage  

```
0. a Get "YaleFaceCrop.mat" by sending email to me to share the link to you,
   or   
0. b Untar the dataset files `tar -zxvf data.tar.gz` to setup to tx, ty, tstx, tsty. (tx: train set data, ty, train set label, tstx: test set data, tsty: test set lable)
1. setup config in main.m
2. run main.m
3. run test.m
```

```
Note
shuffleImg.m and vector_to_img.m are for testing usage
```
