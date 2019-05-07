MIGRATION FROM MATLAB to OCTAVE
---

The following are some comments when I try to replicate the outcomes
RawData_TO_TimeAlignedDataForSeparateActivities06_matlab_linux.m
RawData_TO_TimeAlignedDataForSeparateActivities07_octave_linux.m

1. The first error is that I cannot call the functions
error: 'cvs2arrays' undefined near line 33 column 63.
I only tab the function lines to make it work.
ANSWER: After a while I figure it out that functions within a m-script
should be created before they got called.

2. warning: the 'readtable' function is not yet implemented in Octave
Therefore, you can use importdata which takes a bit of time to read
only data for four sensors, then I use dlmread which accomplish the task
beautifully

3. mkdir and nested folder in octave
```
mkdir(p01_outcome_data_path);
system('mkdir -p foo/bar/baz')
mkdir(p01_outcome_data_path);
%NOT WORKING WITH NESTING mkdir(p01_outcome_data_path);
```
SOLUTION: change "strcat" TO "cstrcat"
```
if ~exist(p01_outcome_data_path,'dir');
  {
    myk =  cstrcat('system(',' ''mkdir', ' -p ',p01_outcome_data_path,''')');
    eval( sprintf(myk) );
  }
end
```

4.  repelems for repelem  
Built-in Function: repelems (X, R)  
  Construct a vector of repeated elements from X.  
  R is a 2xN integer matrix specifying which elements to repeat and  
  how often to repeat each element.  
```
    function [ns01, ns02, ns03, ns04] = sensors_timealignment(t1,t2,t3,t4,s1,s2,s3,s4)
    start_repstar = repelems(start_time_max_val,length(t1));
    start_repstar = repelems(start_time_max_val,[1;length(t1)]);
```
