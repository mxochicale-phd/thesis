%
% octave --no-gui
% hii_rawData_TO_TimeAlignedDataForSeparateActivities_p01_to_p22_octave_linux



format long;
clear; % Clear all variables and functions from memory

m_scripts_path = pwd;

source("MyFunctions_octave_linux.m");
% two cd.. to go the main path

cd ..;
cd ..;
main_path = pwd;
cd ..;
cd ..;
cd ..;
cd ..;
user_path = pwd;


data_path='/data_raw_p01-p22';
datapath=strcat(main_path, data_path);

tmpdatapath='/tmp/phdtmpdata';
outcomes_path = strcat(user_path, tmpdatapath, '/hii_time_aligned_timeseries','/');

outcomes_path_char= char(outcomes_path);
if ~exist(outcomes_path_char,'dir');
  {
    myk =  cstrcat('system(',' ''mkdir', ' -p ',outcomes_path_char,''')');
    eval( sprintf(myk) );
  }
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Using Labels
%%%%%% Description of labels.txt
% Column 1 experiment number ID
% Column 2 user number ID
% Column 3 activity number ID
% Column 4 Label start sample (number of sample in the original file)
% Column 5 Label stop sample (number of sample in the original file)


%%%%%% activity_labels.txt
% 1 horizontal_arm_movement_at_normal_speed (without beat)
% 2 vertical_arm_movement_at_normal_speed   (without beat)
% 3 horizontal_arm_movement_at_faster_speed (without beat)
% 4 vertical_arm movement_at_faster_speed   (without beat)

% 5 horizontal_arm_movement_at_normal_speed (with beat)
% 6 vertical_arm_movement_at_normal_speed   (with beat)
% 7 horizontal_arm_movement_at_faster_speed (with beat)
% 8 vertical_arm movement_at_faster_speed   (with beat)

path_filename = fullfile(m_scripts_path,'/labels_p01-p22_HII.txt');
labels = importdata(path_filename);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  --  p01 -- %%%%%%%%%%%%%%%%%%%%%



p01_data_path = strcat(datapath,'/p01/p01-HII/');
[p01_s01m, p01_s02m, p01_s03m, p01_s04m, p01_max_length_sensors] = cvs2arrays(p01_data_path);
p01_labels = labels(1:8,:);


p01_windowframe_a1 = p01_labels(1,4):p01_labels(1,5);
p01_windowframe_a2 = p01_labels(2,4):p01_labels(2,5);
p01_windowframe_a3 = p01_labels(3,4):p01_labels(3,5);
p01_windowframe_a4 = p01_labels(4,4):p01_labels(4,5);
p01_windowframe_a5 = p01_labels(5,4):p01_labels(5,5);
p01_windowframe_a6 = p01_labels(6,4):p01_labels(6,5);
p01_windowframe_a7 = p01_labels(7,4):p01_labels(7,5);
%p01_windowframe_a8 HERE IS USED THE MAX LENGTH OF THE TIMESERIES


% CREATE PATH TO SAVE DATA
p01_split_path = strsplit(p01_data_path,'/');
p01_outcome_data_path = strcat(outcomes_path, p01_split_path(09),'/',p01_split_path(10),'/');
p01_outcome_data_path= char(p01_outcome_data_path);
if ~exist(p01_outcome_data_path,'dir');
  {
    myk =  cstrcat('system(',' ''mkdir', ' -p ',p01_outcome_data_path,''')');
    eval( sprintf(myk) );
  }
end




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p01   TIME ALIGNMENT  FOR ACTIVITY _a1   %%%%%%%%%%%%%%%%
windowframe = p01_windowframe_a1;
t1_p01_a1 = p01_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p01_a1 = p01_s02m(windowframe,2);
t3_p01_a1 = p01_s03m(windowframe,2);
t4_p01_a1 = p01_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p01_a1 = p01_s01m(windowframe,3:15);
s2_p01_a1 = p01_s02m(windowframe,3:15);
s3_p01_a1 = p01_s03m(windowframe,3:15);
s4_p01_a1 = p01_s04m(windowframe,3:15);

[ns01_p01_a1, ns02_p01_a1, ns03_p01_a1, ns04_p01_a1] = sensors_timealignment_different_length(t1_p01_a1,t2_p01_a1,t3_p01_a1,t4_p01_a1, s1_p01_a1,s2_p01_a1,s3_p01_a1,s4_p01_a1);

%plottingFOURsensors(ns01_p01_a1, ns02_p01_a1, ns03_p01_a1, ns04_p01_a1, 2)

dlmwrite([p01_outcome_data_path 'a01_s01_p01'], ns01_p01_a1 ,'delimiter',',','precision',15);
dlmwrite([p01_outcome_data_path 'a01_s02_p01'], ns02_p01_a1 ,'delimiter',',','precision',15);
dlmwrite([p01_outcome_data_path 'a01_s03_p01'], ns03_p01_a1 ,'delimiter',',','precision',15);
dlmwrite([p01_outcome_data_path 'a01_s04_p01'], ns04_p01_a1 ,'delimiter',',','precision',15);



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p01   TIME ALIGNMENT  FOR ACTIVITY _a2   %%%%%%%%%%%%%%%%
windowframe = p01_windowframe_a2;
t1_p01_a2 = p01_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p01_a2 = p01_s02m(windowframe,2);
t3_p01_a2 = p01_s03m(windowframe,2);
t4_p01_a2 = p01_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p01_a2 = p01_s01m(windowframe,3:15);
s2_p01_a2 = p01_s02m(windowframe,3:15);
s3_p01_a2 = p01_s03m(windowframe,3:15);
s4_p01_a2 = p01_s04m(windowframe,3:15);

[ns01_p01_a2, ns02_p01_a2, ns03_p01_a2, ns04_p01_a2] = sensors_timealignment_different_length(t1_p01_a2,t2_p01_a2,t3_p01_a2,t4_p01_a2, s1_p01_a2,s2_p01_a2,s3_p01_a2,s4_p01_a2);


%plottingFOURsensors(ns01_p01_a2, ns02_p01_a2, ns03_p01_a2, ns04_p01_a2, 2)

dlmwrite([p01_outcome_data_path 'a02_s01_p01'], ns01_p01_a2 ,'delimiter',',','precision',15);
dlmwrite([p01_outcome_data_path 'a02_s02_p01'], ns02_p01_a2 ,'delimiter',',','precision',15);
dlmwrite([p01_outcome_data_path 'a02_s03_p01'], ns03_p01_a2 ,'delimiter',',','precision',15);
dlmwrite([p01_outcome_data_path 'a02_s04_p01'], ns04_p01_a2 ,'delimiter',',','precision',15);






% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p01   TIME ALIGNMENT  FOR ACTIVITY _a3   %%%%%%%%%%%%%%%%
windowframe = p01_windowframe_a3;
t1_p01_a3 = p01_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p01_a3 = p01_s02m(windowframe,2);
t3_p01_a3 = p01_s03m(windowframe,2);
t4_p01_a3 = p01_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p01_a3 = p01_s01m(windowframe,3:15);
s2_p01_a3 = p01_s02m(windowframe,3:15);
s3_p01_a3 = p01_s03m(windowframe,3:15);
s4_p01_a3 = p01_s04m(windowframe,3:15);

[ns01_p01_a3, ns02_p01_a3, ns03_p01_a3, ns04_p01_a3] = sensors_timealignment_different_length(t1_p01_a3,t2_p01_a3,t3_p01_a3,t4_p01_a3, s1_p01_a3,s2_p01_a3,s3_p01_a3,s4_p01_a3);

%plottingFOURsensors(ns01_p01_a3, ns02_p01_a3, ns03_p01_a3, ns04_p01_a3, 2)

dlmwrite([p01_outcome_data_path 'a03_s01_p01'], ns01_p01_a3 ,'delimiter',',','precision',15);
dlmwrite([p01_outcome_data_path 'a03_s02_p01'], ns02_p01_a3 ,'delimiter',',','precision',15);
dlmwrite([p01_outcome_data_path 'a03_s03_p01'], ns03_p01_a3 ,'delimiter',',','precision',15);
dlmwrite([p01_outcome_data_path 'a03_s04_p01'], ns04_p01_a3 ,'delimiter',',','precision',15);



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p01   TIME ALIGNMENT  FOR ACTIVITY _a4   %%%%%%%%%%%%%%%%
windowframe = p01_windowframe_a4;
t1_p01_a4 = p01_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p01_a4 = p01_s02m(windowframe,2);
t3_p01_a4 = p01_s03m(windowframe,2);
t4_p01_a4 = p01_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p01_a4 = p01_s01m(windowframe,3:15);
s2_p01_a4 = p01_s02m(windowframe,3:15);
s3_p01_a4 = p01_s03m(windowframe,3:15);
s4_p01_a4 = p01_s04m(windowframe,3:15);

[ns01_p01_a4, ns02_p01_a4, ns03_p01_a4, ns04_p01_a4] = sensors_timealignment_different_length(t1_p01_a4,t2_p01_a4,t3_p01_a4,t4_p01_a4, s1_p01_a4,s2_p01_a4,s3_p01_a4,s4_p01_a4);

%plottingFOURsensors(ns01_p01_a4, ns02_p01_a4, ns03_p01_a4, ns04_p01_a4, 2)

dlmwrite([p01_outcome_data_path 'a04_s01_p01'], ns01_p01_a4 ,'delimiter',',','precision',15);
dlmwrite([p01_outcome_data_path 'a04_s02_p01'], ns02_p01_a4 ,'delimiter',',','precision',15);
dlmwrite([p01_outcome_data_path 'a04_s03_p01'], ns03_p01_a4 ,'delimiter',',','precision',15);
dlmwrite([p01_outcome_data_path 'a04_s04_p01'], ns04_p01_a4 ,'delimiter',',','precision',15);




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p01   TIME ALIGNMENT  FOR ACTIVITY _a5   %%%%%%%%%%%%%%%%
windowframe = p01_windowframe_a5;
t1_p01_a5 = p01_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p01_a5 = p01_s02m(windowframe,2);
t3_p01_a5 = p01_s03m(windowframe,2);
t4_p01_a5 = p01_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p01_a5 = p01_s01m(windowframe,3:15);
s2_p01_a5 = p01_s02m(windowframe,3:15);
s3_p01_a5 = p01_s03m(windowframe,3:15);
s4_p01_a5 = p01_s04m(windowframe,3:15);

[ns01_p01_a5, ns02_p01_a5, ns03_p01_a5, ns04_p01_a5] = sensors_timealignment_different_length(t1_p01_a5,t2_p01_a5,t3_p01_a5,t4_p01_a5, s1_p01_a5,s2_p01_a5,s3_p01_a5,s4_p01_a5);

%plottingFOURsensors(ns01_p01_a5, ns02_p01_a5, ns03_p01_a5, ns04_p01_a5, 2)

dlmwrite([p01_outcome_data_path 'a05_s01_p01'], ns01_p01_a5 ,'delimiter',',','precision',15);
dlmwrite([p01_outcome_data_path 'a05_s02_p01'], ns02_p01_a5 ,'delimiter',',','precision',15);
dlmwrite([p01_outcome_data_path 'a05_s03_p01'], ns03_p01_a5 ,'delimiter',',','precision',15);
dlmwrite([p01_outcome_data_path 'a05_s04_p01'], ns04_p01_a5 ,'delimiter',',','precision',15);




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p01   TIME ALIGNMENT  FOR ACTIVITY _a6   %%%%%%%%%%%%%%%%
windowframe = p01_windowframe_a6;
t1_p01_a6 = p01_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p01_a6 = p01_s02m(windowframe,2);
t3_p01_a6 = p01_s03m(windowframe,2);
t4_p01_a6 = p01_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p01_a6 = p01_s01m(windowframe,3:15);
s2_p01_a6 = p01_s02m(windowframe,3:15);
s3_p01_a6 = p01_s03m(windowframe,3:15);
s4_p01_a6 = p01_s04m(windowframe,3:15);

[ns01_p01_a6, ns02_p01_a6, ns03_p01_a6, ns04_p01_a6] = sensors_timealignment_different_length(t1_p01_a6,t2_p01_a6,t3_p01_a6,t4_p01_a6, s1_p01_a6,s2_p01_a6,s3_p01_a6,s4_p01_a6);

%plottingFOURsensors(ns01_p01_a6, ns02_p01_a6, ns03_p01_a6, ns04_p01_a6, 2)

dlmwrite([p01_outcome_data_path 'a06_s01_p01'], ns01_p01_a6 ,'delimiter',',','precision',15);
dlmwrite([p01_outcome_data_path 'a06_s02_p01'], ns02_p01_a6 ,'delimiter',',','precision',15);
dlmwrite([p01_outcome_data_path 'a06_s03_p01'], ns03_p01_a6 ,'delimiter',',','precision',15);
dlmwrite([p01_outcome_data_path 'a06_s04_p01'], ns04_p01_a6 ,'delimiter',',','precision',15);







% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p01   TIME ALIGNMENT  FOR ACTIVITY _a7   %%%%%%%%%%%%%%%%
windowframe = p01_windowframe_a7;
t1_p01_a7 = p01_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p01_a7 = p01_s02m(windowframe,2);
t3_p01_a7 = p01_s03m(windowframe,2);
t4_p01_a7 = p01_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p01_a7 = p01_s01m(windowframe,3:15);
s2_p01_a7 = p01_s02m(windowframe,3:15);
s3_p01_a7 = p01_s03m(windowframe,3:15);
s4_p01_a7 = p01_s04m(windowframe,3:15);

[ns01_p01_a7, ns02_p01_a7, ns03_p01_a7, ns04_p01_a7] = sensors_timealignment_different_length(t1_p01_a7,t2_p01_a7,t3_p01_a7,t4_p01_a7, s1_p01_a7,s2_p01_a7,s3_p01_a7,s4_p01_a7);

%plottingFOURsensors(ns01_p01_a7, ns02_p01_a7, ns03_p01_a7, ns04_p01_a7, 2)

dlmwrite([p01_outcome_data_path 'a07_s01_p01'], ns01_p01_a7 ,'delimiter',',','precision',15);
dlmwrite([p01_outcome_data_path 'a07_s02_p01'], ns02_p01_a7 ,'delimiter',',','precision',15);
dlmwrite([p01_outcome_data_path 'a07_s03_p01'], ns03_p01_a7 ,'delimiter',',','precision',15);
dlmwrite([p01_outcome_data_path 'a07_s04_p01'], ns04_p01_a7 ,'delimiter',',','precision',15);







% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p01   TIME ALIGNMENT  FOR ACTIVITY _a8   %%%%%%%%%%%%%%%%
t1_p01_a8 = p01_s01m(p01_labels(8,4):p01_max_length_sensors(1),2);   %TimestampTx
t2_p01_a8 = p01_s02m(p01_labels(8,4):p01_max_length_sensors(2),2);
t3_p01_a8 = p01_s03m(p01_labels(8,4):p01_max_length_sensors(3),2);
t4_p01_a8 = p01_s04m(p01_labels(8,4):p01_max_length_sensors(4),2);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p01_a8 = p01_s01m(windowframe,3:15);
s2_p01_a8 = p01_s02m(windowframe,3:15);
s3_p01_a8 = p01_s03m(windowframe,3:15);
s4_p01_a8 = p01_s04m(windowframe,3:15);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p01_a8 = p01_s01m(p01_labels(8,4):p01_max_length_sensors(1),3:15);
s2_p01_a8 = p01_s02m(p01_labels(8,4):p01_max_length_sensors(2),3:15);
s3_p01_a8 = p01_s03m(p01_labels(8,4):p01_max_length_sensors(3),3:15);
s4_p01_a8 = p01_s04m(p01_labels(8,4):p01_max_length_sensors(4),3:15);

[ns01_p01_a8, ns02_p01_a8, ns03_p01_a8, ns04_p01_a8] = sensors_timealignment_different_length(t1_p01_a8,t2_p01_a8,t3_p01_a8,t4_p01_a8, s1_p01_a8,s2_p01_a8,s3_p01_a8,s4_p01_a8);

%plottingFOURsensors(ns01_p01_a8, ns02_p01_a8, ns03_p01_a8, ns04_p01_a8, 2)

dlmwrite([p01_outcome_data_path 'a08_s01_p01'], ns01_p01_a8 ,'delimiter',',','precision',15);
dlmwrite([p01_outcome_data_path 'a08_s02_p01'], ns02_p01_a8 ,'delimiter',',','precision',15);
dlmwrite([p01_outcome_data_path 'a08_s03_p01'], ns03_p01_a8 ,'delimiter',',','precision',15);
dlmwrite([p01_outcome_data_path 'a08_s04_p01'], ns04_p01_a8 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  --  p02 -- %%%%%%%%%%%%%%%%%%%%%


p02_data_path = strcat(datapath,'/p02/p02-HII/');
[p02_s01m, p02_s02m, p02_s03m, p02_s04m, p02_max_length_sensors] = cvs2arrays(p02_data_path);
p02_labels = labels(9:16,:);

p02_windowframe_a1 = p02_labels(1,4):p02_labels(1,5);
p02_windowframe_a2 = p02_labels(2,4):p02_labels(2,5);
p02_windowframe_a3 = p02_labels(3,4):p02_labels(3,5);
p02_windowframe_a4 = p02_labels(4,4):p02_labels(4,5);
p02_windowframe_a5 = p02_labels(5,4):p02_labels(5,5);
p02_windowframe_a6 = p02_labels(6,4):p02_labels(6,5);
p02_windowframe_a7 = p02_labels(7,4):p02_labels(7,5);
%p02_windowframe_a8 HERE IS USED THE MAX LENGTH OF THE TIMESERIES

% CREATE PATH TO SAVE DATA
p02_split_path = strsplit(p02_data_path,'/');
p02_outcome_data_path = strcat(outcomes_path, p02_split_path(09),'/',p02_split_path(10),'/');
p02_outcome_data_path= char(p02_outcome_data_path);
if ~exist(p02_outcome_data_path,'dir');
  {
    myk =  cstrcat('system(',' ''mkdir', ' -p ',p02_outcome_data_path,''')');
    eval( sprintf(myk) );
  }
end




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p02   TIME ALIGNMENT  FOR ACTIVITY _a1   %%%%%%%%%%%%%%%%
windowframe = p02_windowframe_a1;
t1_p02_a1 = p02_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p02_a1 = p02_s02m(windowframe,2);
t3_p02_a1 = p02_s03m(windowframe,2);
t4_p02_a1 = p02_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p02_a1 = p02_s01m(windowframe,3:15);
s2_p02_a1 = p02_s02m(windowframe,3:15);
s3_p02_a1 = p02_s03m(windowframe,3:15);
s4_p02_a1 = p02_s04m(windowframe,3:15);

[ns01_p02_a1, ns02_p02_a1, ns03_p02_a1, ns04_p02_a1] = sensors_timealignment_different_length(t1_p02_a1,t2_p02_a1,t3_p02_a1,t4_p02_a1, s1_p02_a1,s2_p02_a1,s3_p02_a1,s4_p02_a1);

%plottingFOURsensors(ns01_p02_a1, ns02_p02_a1, ns03_p02_a1, ns04_p02_a1, 2)

dlmwrite([p02_outcome_data_path 'a01_s01_p02'], ns01_p02_a1 ,'delimiter',',','precision',15);
dlmwrite([p02_outcome_data_path 'a01_s02_p02'], ns02_p02_a1 ,'delimiter',',','precision',15);
dlmwrite([p02_outcome_data_path 'a01_s03_p02'], ns03_p02_a1 ,'delimiter',',','precision',15);
dlmwrite([p02_outcome_data_path 'a01_s04_p02'], ns04_p02_a1 ,'delimiter',',','precision',15);



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p02   TIME ALIGNMENT  FOR ACTIVITY _a2   %%%%%%%%%%%%%%%%
windowframe = p02_windowframe_a2;
t1_p02_a2 = p02_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p02_a2 = p02_s02m(windowframe,2);
t3_p02_a2 = p02_s03m(windowframe,2);
t4_p02_a2 = p02_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p02_a2 = p02_s01m(windowframe,3:15);
s2_p02_a2 = p02_s02m(windowframe,3:15);
s3_p02_a2 = p02_s03m(windowframe,3:15);
s4_p02_a2 = p02_s04m(windowframe,3:15);

[ns01_p02_a2, ns02_p02_a2, ns03_p02_a2, ns04_p02_a2] = sensors_timealignment_different_length(t1_p02_a2,t2_p02_a2,t3_p02_a2,t4_p02_a2, s1_p02_a2,s2_p02_a2,s3_p02_a2,s4_p02_a2);


%plottingFOURsensors(ns01_p02_a2, ns02_p02_a2, ns03_p02_a2, ns04_p02_a2, 2)

dlmwrite([p02_outcome_data_path 'a02_s01_p02'], ns01_p02_a2 ,'delimiter',',','precision',15);
dlmwrite([p02_outcome_data_path 'a02_s02_p02'], ns02_p02_a2 ,'delimiter',',','precision',15);
dlmwrite([p02_outcome_data_path 'a02_s03_p02'], ns03_p02_a2 ,'delimiter',',','precision',15);
dlmwrite([p02_outcome_data_path 'a02_s04_p02'], ns04_p02_a2 ,'delimiter',',','precision',15);






% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p02   TIME ALIGNMENT  FOR ACTIVITY _a3   %%%%%%%%%%%%%%%%
windowframe = p02_windowframe_a3;
t1_p02_a3 = p02_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p02_a3 = p02_s02m(windowframe,2);
t3_p02_a3 = p02_s03m(windowframe,2);
t4_p02_a3 = p02_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p02_a3 = p02_s01m(windowframe,3:15);
s2_p02_a3 = p02_s02m(windowframe,3:15);
s3_p02_a3 = p02_s03m(windowframe,3:15);
s4_p02_a3 = p02_s04m(windowframe,3:15);

[ns01_p02_a3, ns02_p02_a3, ns03_p02_a3, ns04_p02_a3] = sensors_timealignment_different_length(t1_p02_a3,t2_p02_a3,t3_p02_a3,t4_p02_a3, s1_p02_a3,s2_p02_a3,s3_p02_a3,s4_p02_a3);

%plottingFOURsensors(ns01_p02_a3, ns02_p02_a3, ns03_p02_a3, ns04_p02_a3, 2)

dlmwrite([p02_outcome_data_path 'a03_s01_p02'], ns01_p02_a3 ,'delimiter',',','precision',15);
dlmwrite([p02_outcome_data_path 'a03_s02_p02'], ns02_p02_a3 ,'delimiter',',','precision',15);
dlmwrite([p02_outcome_data_path 'a03_s03_p02'], ns03_p02_a3 ,'delimiter',',','precision',15);
dlmwrite([p02_outcome_data_path 'a03_s04_p02'], ns04_p02_a3 ,'delimiter',',','precision',15);




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p02   TIME ALIGNMENT  FOR ACTIVITY _a4   %%%%%%%%%%%%%%%%
windowframe = p02_windowframe_a4;
t1_p02_a4 = p02_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p02_a4 = p02_s02m(windowframe,2);
t3_p02_a4 = p02_s03m(windowframe,2);
t4_p02_a4 = p02_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p02_a4 = p02_s01m(windowframe,3:15);
s2_p02_a4 = p02_s02m(windowframe,3:15);
s3_p02_a4 = p02_s03m(windowframe,3:15);
s4_p02_a4 = p02_s04m(windowframe,3:15);

[ns01_p02_a4, ns02_p02_a4, ns03_p02_a4, ns04_p02_a4] = sensors_timealignment_different_length(t1_p02_a4,t2_p02_a4,t3_p02_a4,t4_p02_a4, s1_p02_a4,s2_p02_a4,s3_p02_a4,s4_p02_a4);

%plottingFOURsensors(ns01_p02_a4, ns02_p02_a4, ns03_p02_a4, ns04_p02_a4, 2)

dlmwrite([p02_outcome_data_path 'a04_s01_p02'], ns01_p02_a4 ,'delimiter',',','precision',15);
dlmwrite([p02_outcome_data_path 'a04_s02_p02'], ns02_p02_a4 ,'delimiter',',','precision',15);
dlmwrite([p02_outcome_data_path 'a04_s03_p02'], ns03_p02_a4 ,'delimiter',',','precision',15);
dlmwrite([p02_outcome_data_path 'a04_s04_p02'], ns04_p02_a4 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p02   TIME ALIGNMENT  FOR ACTIVITY _a5   %%%%%%%%%%%%%%%%
windowframe = p02_windowframe_a5;
t1_p02_a5 = p02_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p02_a5 = p02_s02m(windowframe,2);
t3_p02_a5 = p02_s03m(windowframe,2);
t4_p02_a5 = p02_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p02_a5 = p02_s01m(windowframe,3:15);
s2_p02_a5 = p02_s02m(windowframe,3:15);
s3_p02_a5 = p02_s03m(windowframe,3:15);
s4_p02_a5 = p02_s04m(windowframe,3:15);

[ns01_p02_a5, ns02_p02_a5, ns03_p02_a5, ns04_p02_a5] = sensors_timealignment_different_length(t1_p02_a5,t2_p02_a5,t3_p02_a5,t4_p02_a5, s1_p02_a5,s2_p02_a5,s3_p02_a5,s4_p02_a5);

%plottingFOURsensors(ns01_p02_a5, ns02_p02_a5, ns03_p02_a5, ns04_p02_a5, 2)

dlmwrite([p02_outcome_data_path 'a05_s01_p02'], ns01_p02_a5 ,'delimiter',',','precision',15);
dlmwrite([p02_outcome_data_path 'a05_s02_p02'], ns02_p02_a5 ,'delimiter',',','precision',15);
dlmwrite([p02_outcome_data_path 'a05_s03_p02'], ns03_p02_a5 ,'delimiter',',','precision',15);
dlmwrite([p02_outcome_data_path 'a05_s04_p02'], ns04_p02_a5 ,'delimiter',',','precision',15);




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p02   TIME ALIGNMENT  FOR ACTIVITY _a6   %%%%%%%%%%%%%%%%
windowframe = p02_windowframe_a6;
t1_p02_a6 = p02_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p02_a6 = p02_s02m(windowframe,2);
t3_p02_a6 = p02_s03m(windowframe,2);
t4_p02_a6 = p02_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p02_a6 = p02_s01m(windowframe,3:15);
s2_p02_a6 = p02_s02m(windowframe,3:15);
s3_p02_a6 = p02_s03m(windowframe,3:15);
s4_p02_a6 = p02_s04m(windowframe,3:15);

[ns01_p02_a6, ns02_p02_a6, ns03_p02_a6, ns04_p02_a6] = sensors_timealignment_different_length(t1_p02_a6,t2_p02_a6,t3_p02_a6,t4_p02_a6, s1_p02_a6,s2_p02_a6,s3_p02_a6,s4_p02_a6);

%plottingFOURsensors(ns01_p02_a6, ns02_p02_a6, ns03_p02_a6, ns04_p02_a6, 2)

dlmwrite([p02_outcome_data_path 'a06_s01_p02'], ns01_p02_a6 ,'delimiter',',','precision',15);
dlmwrite([p02_outcome_data_path 'a06_s02_p02'], ns02_p02_a6 ,'delimiter',',','precision',15);
dlmwrite([p02_outcome_data_path 'a06_s03_p02'], ns03_p02_a6 ,'delimiter',',','precision',15);
dlmwrite([p02_outcome_data_path 'a06_s04_p02'], ns04_p02_a6 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p02   TIME ALIGNMENT  FOR ACTIVITY _a7   %%%%%%%%%%%%%%%%
windowframe = p02_windowframe_a7;
t1_p02_a7 = p02_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p02_a7 = p02_s02m(windowframe,2);
t3_p02_a7 = p02_s03m(windowframe,2);
t4_p02_a7 = p02_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p02_a7 = p02_s01m(windowframe,3:15);
s2_p02_a7 = p02_s02m(windowframe,3:15);
s3_p02_a7 = p02_s03m(windowframe,3:15);
s4_p02_a7 = p02_s04m(windowframe,3:15);

[ns01_p02_a7, ns02_p02_a7, ns03_p02_a7, ns04_p02_a7] = sensors_timealignment_different_length(t1_p02_a7,t2_p02_a7,t3_p02_a7,t4_p02_a7, s1_p02_a7,s2_p02_a7,s3_p02_a7,s4_p02_a7);

%plottingFOURsensors(ns01_p02_a7, ns02_p02_a7, ns03_p02_a7, ns04_p02_a7, 2)

dlmwrite([p02_outcome_data_path 'a07_s01_p02'], ns01_p02_a7 ,'delimiter',',','precision',15);
dlmwrite([p02_outcome_data_path 'a07_s02_p02'], ns02_p02_a7 ,'delimiter',',','precision',15);
dlmwrite([p02_outcome_data_path 'a07_s03_p02'], ns03_p02_a7 ,'delimiter',',','precision',15);
dlmwrite([p02_outcome_data_path 'a07_s04_p02'], ns04_p02_a7 ,'delimiter',',','precision',15);









% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p02   TIME ALIGNMENT  FOR ACTIVITY _a8   %%%%%%%%%%%%%%%%
t1_p02_a8 = p02_s01m(p02_labels(8,4):p02_max_length_sensors(1),2);   %TimestampTx
t2_p02_a8 = p02_s02m(p02_labels(8,4):p02_max_length_sensors(2),2);
t3_p02_a8 = p02_s03m(p02_labels(8,4):p02_max_length_sensors(3),2);
t4_p02_a8 = p02_s04m(p02_labels(8,4):p02_max_length_sensors(4),2);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p02_a8 = p02_s01m(windowframe,3:15);
s2_p02_a8 = p02_s02m(windowframe,3:15);
s3_p02_a8 = p02_s03m(windowframe,3:15);
s4_p02_a8 = p02_s04m(windowframe,3:15);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p02_a8 = p02_s01m(p02_labels(8,4):p02_max_length_sensors(1),3:15);
s2_p02_a8 = p02_s02m(p02_labels(8,4):p02_max_length_sensors(2),3:15);
s3_p02_a8 = p02_s03m(p02_labels(8,4):p02_max_length_sensors(3),3:15);
s4_p02_a8 = p02_s04m(p02_labels(8,4):p02_max_length_sensors(4),3:15);

[ns01_p02_a8, ns02_p02_a8, ns03_p02_a8, ns04_p02_a8] = sensors_timealignment_different_length(t1_p02_a8,t2_p02_a8,t3_p02_a8,t4_p02_a8, s1_p02_a8,s2_p02_a8,s3_p02_a8,s4_p02_a8);

%plottingFOURsensors(ns01_p02_a8, ns02_p02_a8, ns03_p02_a8, ns04_p02_a8, 2)

dlmwrite([p02_outcome_data_path 'a08_s01_p02'], ns01_p02_a8 ,'delimiter',',','precision',15);
dlmwrite([p02_outcome_data_path 'a08_s02_p02'], ns02_p02_a8 ,'delimiter',',','precision',15);
dlmwrite([p02_outcome_data_path 'a08_s03_p02'], ns03_p02_a8 ,'delimiter',',','precision',15);
dlmwrite([p02_outcome_data_path 'a08_s04_p02'], ns04_p02_a8 ,'delimiter',',','precision',15);







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  --  p06 -- %%%%%%%%%%%%%%%%%%%%%



p06_data_path = strcat(datapath,'/p06/p06-HII/');
[p06_s01m, p06_s02m, p06_s03m, p06_s04m, p06_max_length_sensors] = cvs2arrays(p06_data_path);
p06_labels = labels(41:48,:);



p06_windowframe_a1 = p06_labels(1,4):p06_labels(1,5);
p06_windowframe_a2 = p06_labels(2,4):p06_labels(2,5);
p06_windowframe_a3 = p06_labels(3,4):p06_labels(3,5);
p06_windowframe_a4 = p06_labels(4,4):p06_labels(4,5);
p06_windowframe_a5 = p06_labels(5,4):p06_labels(5,5);
p06_windowframe_a6 = p06_labels(6,4):p06_labels(6,5);
p06_windowframe_a7 = p06_labels(7,4):p06_labels(7,5);
%p06_windowframe_a8 HERE IS USED THE MAX LENGTH OF THE TIMESERIES

% CREATE PATH TO SAVE DATA
p06_split_path = strsplit(p06_data_path,'/');
p06_outcome_data_path = strcat(outcomes_path, p06_split_path(09),'/',p06_split_path(10),'/');
p06_outcome_data_path= char(p06_outcome_data_path);
if ~exist(p06_outcome_data_path,'dir');
  {
    myk =  cstrcat('system(',' ''mkdir', ' -p ',p06_outcome_data_path,''')');
    eval( sprintf(myk) );
  }
end



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p06   TIME ALIGNMENT  FOR ACTIVITY _a1   %%%%%%%%%%%%%%%%
windowframe = p06_windowframe_a1;
t1_p06_a1 = p06_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p06_a1 = p06_s02m(windowframe,2);
t3_p06_a1 = p06_s03m(windowframe,2);
t4_p06_a1 = p06_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p06_a1 = p06_s01m(windowframe,3:15);
s2_p06_a1 = p06_s02m(windowframe,3:15);
s3_p06_a1 = p06_s03m(windowframe,3:15);
s4_p06_a1 = p06_s04m(windowframe,3:15);

[ns01_p06_a1, ns02_p06_a1, ns03_p06_a1, ns04_p06_a1] = sensors_timealignment_different_length_inverted_maxmin_vectors(
							t1_p06_a1,t2_p06_a1,t3_p06_a1,t4_p06_a1, 
							s1_p06_a1,s2_p06_a1,s3_p06_a1,s4_p06_a1);

%plottingFOURsensors(ns01_p06_a1, ns02_p06_a1, ns03_p06_a1, ns04_p06_a1, 2)

dlmwrite([p06_outcome_data_path 'a01_s01_p06'], ns01_p06_a1 ,'delimiter',',','precision',15);
dlmwrite([p06_outcome_data_path 'a01_s02_p06'], ns02_p06_a1 ,'delimiter',',','precision',15);
dlmwrite([p06_outcome_data_path 'a01_s03_p06'], ns03_p06_a1 ,'delimiter',',','precision',15);
dlmwrite([p06_outcome_data_path 'a01_s04_p06'], ns04_p06_a1 ,'delimiter',',','precision',15);




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p06   TIME ALIGNMENT  FOR ACTIVITY _a2   %%%%%%%%%%%%%%%%
windowframe = p06_windowframe_a2;
t1_p06_a2 = p06_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p06_a2 = p06_s02m(windowframe,2);
t3_p06_a2 = p06_s03m(windowframe,2);
t4_p06_a2 = p06_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p06_a2 = p06_s01m(windowframe,3:15);
s2_p06_a2 = p06_s02m(windowframe,3:15);
s3_p06_a2 = p06_s03m(windowframe,3:15);
s4_p06_a2 = p06_s04m(windowframe,3:15);

[ns01_p06_a2, ns02_p06_a2, ns03_p06_a2, ns04_p06_a2] = sensors_timealignment_different_length_inverted_maxmin_vectors(
							t1_p06_a2,t2_p06_a2,t3_p06_a2,t4_p06_a2, 
							s1_p06_a2,s2_p06_a2,s3_p06_a2,s4_p06_a2);


%plottingFOURsensors(ns01_p06_a2, ns02_p06_a2, ns03_p06_a2, ns04_p06_a2, 2)

dlmwrite([p06_outcome_data_path 'a02_s01_p06'], ns01_p06_a2 ,'delimiter',',','precision',15);
dlmwrite([p06_outcome_data_path 'a02_s02_p06'], ns02_p06_a2 ,'delimiter',',','precision',15);
dlmwrite([p06_outcome_data_path 'a02_s03_p06'], ns03_p06_a2 ,'delimiter',',','precision',15);
dlmwrite([p06_outcome_data_path 'a02_s04_p06'], ns04_p06_a2 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p06   TIME ALIGNMENT  FOR ACTIVITY _a3   %%%%%%%%%%%%%%%%
windowframe = p06_windowframe_a3;
t1_p06_a3 = p06_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p06_a3 = p06_s02m(windowframe,2);
t3_p06_a3 = p06_s03m(windowframe,2);
t4_p06_a3 = p06_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p06_a3 = p06_s01m(windowframe,3:15);
s2_p06_a3 = p06_s02m(windowframe,3:15);
s3_p06_a3 = p06_s03m(windowframe,3:15);
s4_p06_a3 = p06_s04m(windowframe,3:15);

[ns01_p06_a3, ns02_p06_a3, ns03_p06_a3, ns04_p06_a3] = sensors_timealignment_different_length(
							t1_p06_a3,t2_p06_a3,t3_p06_a3,t4_p06_a3, 
							s1_p06_a3,s2_p06_a3,s3_p06_a3,s4_p06_a3);

%plottingFOURsensors(ns01_p06_a3, ns02_p06_a3, ns03_p06_a3, ns04_p06_a3, 2)

dlmwrite([p06_outcome_data_path 'a03_s01_p06'], ns01_p06_a3 ,'delimiter',',','precision',15);
dlmwrite([p06_outcome_data_path 'a03_s02_p06'], ns02_p06_a3 ,'delimiter',',','precision',15);
dlmwrite([p06_outcome_data_path 'a03_s03_p06'], ns03_p06_a3 ,'delimiter',',','precision',15);
dlmwrite([p06_outcome_data_path 'a03_s04_p06'], ns04_p06_a3 ,'delimiter',',','precision',15);




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p06   TIME ALIGNMENT  FOR ACTIVITY _a4   %%%%%%%%%%%%%%%%
windowframe = p06_windowframe_a4;
t1_p06_a4 = p06_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p06_a4 = p06_s02m(windowframe,2);
t3_p06_a4 = p06_s03m(windowframe,2);
t4_p06_a4 = p06_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p06_a4 = p06_s01m(windowframe,3:15);
s2_p06_a4 = p06_s02m(windowframe,3:15);
s3_p06_a4 = p06_s03m(windowframe,3:15);
s4_p06_a4 = p06_s04m(windowframe,3:15);

[ns01_p06_a4, ns02_p06_a4, ns03_p06_a4, ns04_p06_a4] = sensors_timealignment_different_length_inverted_maxmin_vectors(
							t1_p06_a4,t2_p06_a4,t3_p06_a4,t4_p06_a4, 
							s1_p06_a4,s2_p06_a4,s3_p06_a4,s4_p06_a4);

%plottingFOURsensors(ns01_p06_a4, ns02_p06_a4, ns03_p06_a4, ns04_p06_a4, 2)

dlmwrite([p06_outcome_data_path 'a04_s01_p06'], ns01_p06_a4 ,'delimiter',',','precision',15);
dlmwrite([p06_outcome_data_path 'a04_s02_p06'], ns02_p06_a4 ,'delimiter',',','precision',15);
dlmwrite([p06_outcome_data_path 'a04_s03_p06'], ns03_p06_a4 ,'delimiter',',','precision',15);
dlmwrite([p06_outcome_data_path 'a04_s04_p06'], ns04_p06_a4 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p06   TIME ALIGNMENT  FOR ACTIVITY _a5   %%%%%%%%%%%%%%%%
windowframe = p06_windowframe_a5;
t1_p06_a5 = p06_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p06_a5 = p06_s02m(windowframe,2);
t3_p06_a5 = p06_s03m(windowframe,2);
t4_p06_a5 = p06_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p06_a5 = p06_s01m(windowframe,3:15);
s2_p06_a5 = p06_s02m(windowframe,3:15);
s3_p06_a5 = p06_s03m(windowframe,3:15);
s4_p06_a5 = p06_s04m(windowframe,3:15);

[ns01_p06_a5, ns02_p06_a5, ns03_p06_a5, ns04_p06_a5] = sensors_timealignment_different_length_inverted_maxmin_vectors(
							t1_p06_a5,t2_p06_a5,t3_p06_a5,t4_p06_a5, 
							s1_p06_a5,s2_p06_a5,s3_p06_a5,s4_p06_a5);

%plottingFOURsensors(ns01_p06_a5, ns02_p06_a5, ns03_p06_a5, ns04_p06_a5, 2)

dlmwrite([p06_outcome_data_path 'a05_s01_p06'], ns01_p06_a5 ,'delimiter',',','precision',15);
dlmwrite([p06_outcome_data_path 'a05_s02_p06'], ns02_p06_a5 ,'delimiter',',','precision',15);
dlmwrite([p06_outcome_data_path 'a05_s03_p06'], ns03_p06_a5 ,'delimiter',',','precision',15);
dlmwrite([p06_outcome_data_path 'a05_s04_p06'], ns04_p06_a5 ,'delimiter',',','precision',15);




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p06   TIME ALIGNMENT  FOR ACTIVITY _a6   %%%%%%%%%%%%%%%%
windowframe = p06_windowframe_a6;
t1_p06_a6 = p06_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p06_a6 = p06_s02m(windowframe,2);
t3_p06_a6 = p06_s03m(windowframe,2);
t4_p06_a6 = p06_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p06_a6 = p06_s01m(windowframe,3:15);
s2_p06_a6 = p06_s02m(windowframe,3:15);
s3_p06_a6 = p06_s03m(windowframe,3:15);
s4_p06_a6 = p06_s04m(windowframe,3:15);

[ns01_p06_a6, ns02_p06_a6, ns03_p06_a6, ns04_p06_a6] = sensors_timealignment_different_length_inverted_maxmin_vectors(
							t1_p06_a6,t2_p06_a6,t3_p06_a6,t4_p06_a6, 
							s1_p06_a6,s2_p06_a6,s3_p06_a6,s4_p06_a6);

%plottingFOURsensors(ns01_p06_a6, ns02_p06_a6, ns03_p06_a6, ns04_p06_a6, 2)

dlmwrite([p06_outcome_data_path 'a06_s01_p06'], ns01_p06_a6 ,'delimiter',',','precision',15);
dlmwrite([p06_outcome_data_path 'a06_s02_p06'], ns02_p06_a6 ,'delimiter',',','precision',15);
dlmwrite([p06_outcome_data_path 'a06_s03_p06'], ns03_p06_a6 ,'delimiter',',','precision',15);
dlmwrite([p06_outcome_data_path 'a06_s04_p06'], ns04_p06_a6 ,'delimiter',',','precision',15);









% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p06   TIME ALIGNMENT  FOR ACTIVITY _a7   %%%%%%%%%%%%%%%%
windowframe = p06_windowframe_a7;
t1_p06_a7 = p06_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p06_a7 = p06_s02m(windowframe,2);
t3_p06_a7 = p06_s03m(windowframe,2);
t4_p06_a7 = p06_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p06_a7 = p06_s01m(windowframe,3:15);
s2_p06_a7 = p06_s02m(windowframe,3:15);
s3_p06_a7 = p06_s03m(windowframe,3:15);
s4_p06_a7 = p06_s04m(windowframe,3:15);

[ns01_p06_a7, ns02_p06_a7, ns03_p06_a7, ns04_p06_a7] = sensors_timealignment_different_length_inverted_maxmin_vectors(
							t1_p06_a7,t2_p06_a7,t3_p06_a7,t4_p06_a7, 
							s1_p06_a7,s2_p06_a7,s3_p06_a7,s4_p06_a7);

%plottingFOURsensors(ns01_p06_a7, ns02_p06_a7, ns03_p06_a7, ns04_p06_a7, 2)
%not well aligned
dlmwrite([p06_outcome_data_path 'a07_s01_p06'], ns01_p06_a7 ,'delimiter',',','precision',15);
dlmwrite([p06_outcome_data_path 'a07_s02_p06'], ns02_p06_a7 ,'delimiter',',','precision',15);
dlmwrite([p06_outcome_data_path 'a07_s03_p06'], ns03_p06_a7 ,'delimiter',',','precision',15);
dlmwrite([p06_outcome_data_path 'a07_s04_p06'], ns04_p06_a7 ,'delimiter',',','precision',15);







% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p06   TIME ALIGNMENT  FOR ACTIVITY _a8   %%%%%%%%%%%%%%%%
t1_p06_a8 = p06_s01m(p06_labels(8,4):p06_max_length_sensors(1),2);   %TimestampTx
t2_p06_a8 = p06_s02m(p06_labels(8,4):p06_max_length_sensors(2),2);
t3_p06_a8 = p06_s03m(p06_labels(8,4):p06_max_length_sensors(3),2);
t4_p06_a8 = p06_s04m(p06_labels(8,4):p06_max_length_sensors(4),2);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p06_a8 = p06_s01m(windowframe,3:15);
s2_p06_a8 = p06_s02m(windowframe,3:15);
s3_p06_a8 = p06_s03m(windowframe,3:15);
s4_p06_a8 = p06_s04m(windowframe,3:15);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p06_a8 = p06_s01m(p06_labels(8,4):p06_max_length_sensors(1),3:15);
s2_p06_a8 = p06_s02m(p06_labels(8,4):p06_max_length_sensors(2),3:15);
s3_p06_a8 = p06_s03m(p06_labels(8,4):p06_max_length_sensors(3),3:15);
s4_p06_a8 = p06_s04m(p06_labels(8,4):p06_max_length_sensors(4),3:15);

[ns01_p06_a8, ns02_p06_a8, ns03_p06_a8, ns04_p06_a8] = sensors_timealignment_different_length_inverted_maxmin_vectors(
							t1_p06_a8,t2_p06_a8,t3_p06_a8,t4_p06_a8, 
							s1_p06_a8,s2_p06_a8,s3_p06_a8,s4_p06_a8);

%plottingFOURsensors(ns01_p06_a8, ns02_p06_a8, ns03_p06_a8, ns04_p06_a8, 2)

dlmwrite([p06_outcome_data_path 'a08_s01_p06'], ns01_p06_a8 ,'delimiter',',','precision',15);
dlmwrite([p06_outcome_data_path 'a08_s02_p06'], ns02_p06_a8 ,'delimiter',',','precision',15);
dlmwrite([p06_outcome_data_path 'a08_s03_p06'], ns03_p06_a8 ,'delimiter',',','precision',15);
dlmwrite([p06_outcome_data_path 'a08_s04_p06'], ns04_p06_a8 ,'delimiter',',','precision',15);







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  --  p07 -- %%%%%%%%%%%%%%%%%%%%%



p07_data_path = strcat(datapath,'/p07/p07-HII/');
[p07_s01m, p07_s02m, p07_s03m, p07_s04m, p07_max_length_sensors] = cvs2arrays(p07_data_path);
p07_labels = labels(49:56,:);



p07_windowframe_a1 = p07_labels(1,4):p07_labels(1,5);
p07_windowframe_a2 = p07_labels(2,4):p07_labels(2,5);
p07_windowframe_a3 = p07_labels(3,4):p07_labels(3,5);
p07_windowframe_a4 = p07_labels(4,4):p07_labels(4,5);
p07_windowframe_a5 = p07_labels(5,4):p07_labels(5,5);
p07_windowframe_a6 = p07_labels(6,4):p07_labels(6,5);
p07_windowframe_a7 = p07_labels(7,4):p07_labels(7,5);
%p07_windowframe_a8 HERE IS USED THE MAX LENGTH OF THE TIMESERIES

% CREATE PATH TO SAVE DATA
p07_split_path = strsplit(p07_data_path,'/');
p07_outcome_data_path = strcat(outcomes_path, p07_split_path(09),'/',p07_split_path(10),'/');
p07_outcome_data_path= char(p07_outcome_data_path);
if ~exist(p07_outcome_data_path,'dir');
  {
    myk =  cstrcat('system(',' ''mkdir', ' -p ',p07_outcome_data_path,''')');
    eval( sprintf(myk) );
  }
end





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p07   TIME ALIGNMENT  FOR ACTIVITY _a1   %%%%%%%%%%%%%%%%
windowframe = p07_windowframe_a1;
t1_p07_a1 = p07_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p07_a1 = p07_s02m(windowframe,2);
t3_p07_a1 = p07_s03m(windowframe,2);
t4_p07_a1 = p07_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p07_a1 = p07_s01m(windowframe,3:15);
s2_p07_a1 = p07_s02m(windowframe,3:15);
s3_p07_a1 = p07_s03m(windowframe,3:15);
s4_p07_a1 = p07_s04m(windowframe,3:15);

[ns01_p07_a1, ns02_p07_a1, ns03_p07_a1, ns04_p07_a1] = sensors_timealignment_different_length(
							t1_p07_a1,t2_p07_a1,t3_p07_a1,t4_p07_a1, 
							s1_p07_a1,s2_p07_a1,s3_p07_a1,s4_p07_a1);

%plottingFOURsensors(ns01_p07_a1, ns02_p07_a1, ns03_p07_a1, ns04_p07_a1, 2)

dlmwrite([p07_outcome_data_path 'a01_s01_p07'], ns01_p07_a1 ,'delimiter',',','precision',15);
dlmwrite([p07_outcome_data_path 'a01_s02_p07'], ns02_p07_a1 ,'delimiter',',','precision',15);
dlmwrite([p07_outcome_data_path 'a01_s03_p07'], ns03_p07_a1 ,'delimiter',',','precision',15);
dlmwrite([p07_outcome_data_path 'a01_s04_p07'], ns04_p07_a1 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p07   TIME ALIGNMENT  FOR ACTIVITY _a2   %%%%%%%%%%%%%%%%
windowframe = p07_windowframe_a2;
t1_p07_a2 = p07_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p07_a2 = p07_s02m(windowframe,2);
t3_p07_a2 = p07_s03m(windowframe,2);
t4_p07_a2 = p07_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p07_a2 = p07_s01m(windowframe,3:15);
s2_p07_a2 = p07_s02m(windowframe,3:15);
s3_p07_a2 = p07_s03m(windowframe,3:15);
s4_p07_a2 = p07_s04m(windowframe,3:15);

[ns01_p07_a2, ns02_p07_a2, ns03_p07_a2, ns04_p07_a2] = sensors_timealignment_different_length(
							t1_p07_a2,t2_p07_a2,t3_p07_a2,t4_p07_a2, 
							s1_p07_a2,s2_p07_a2,s3_p07_a2,s4_p07_a2);


%plottingFOURsensors(ns01_p07_a2, ns02_p07_a2, ns03_p07_a2, ns04_p07_a2, 2)

dlmwrite([p07_outcome_data_path 'a02_s01_p07'], ns01_p07_a2 ,'delimiter',',','precision',15);
dlmwrite([p07_outcome_data_path 'a02_s02_p07'], ns02_p07_a2 ,'delimiter',',','precision',15);
dlmwrite([p07_outcome_data_path 'a02_s03_p07'], ns03_p07_a2 ,'delimiter',',','precision',15);
dlmwrite([p07_outcome_data_path 'a02_s04_p07'], ns04_p07_a2 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p07   TIME ALIGNMENT  FOR ACTIVITY _a3   %%%%%%%%%%%%%%%%
windowframe = p07_windowframe_a3;
t1_p07_a3 = p07_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p07_a3 = p07_s02m(windowframe,2);
t3_p07_a3 = p07_s03m(windowframe,2);
t4_p07_a3 = p07_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p07_a3 = p07_s01m(windowframe,3:15);
s2_p07_a3 = p07_s02m(windowframe,3:15);
s3_p07_a3 = p07_s03m(windowframe,3:15);
s4_p07_a3 = p07_s04m(windowframe,3:15);

[ns01_p07_a3, ns02_p07_a3, ns03_p07_a3, ns04_p07_a3] = sensors_timealignment_different_length(
							t1_p07_a3,t2_p07_a3,t3_p07_a3,t4_p07_a3, 
							s1_p07_a3,s2_p07_a3,s3_p07_a3,s4_p07_a3);

%plottingFOURsensors(ns01_p07_a3, ns02_p07_a3, ns03_p07_a3, ns04_p07_a3, 2)

dlmwrite([p07_outcome_data_path 'a03_s01_p07'], ns01_p07_a3 ,'delimiter',',','precision',15);
dlmwrite([p07_outcome_data_path 'a03_s02_p07'], ns02_p07_a3 ,'delimiter',',','precision',15);
dlmwrite([p07_outcome_data_path 'a03_s03_p07'], ns03_p07_a3 ,'delimiter',',','precision',15);
dlmwrite([p07_outcome_data_path 'a03_s04_p07'], ns04_p07_a3 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p07   TIME ALIGNMENT  FOR ACTIVITY _a4   %%%%%%%%%%%%%%%%
windowframe = p07_windowframe_a4;
t1_p07_a4 = p07_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p07_a4 = p07_s02m(windowframe,2);
t3_p07_a4 = p07_s03m(windowframe,2);
t4_p07_a4 = p07_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p07_a4 = p07_s01m(windowframe,3:15);
s2_p07_a4 = p07_s02m(windowframe,3:15);
s3_p07_a4 = p07_s03m(windowframe,3:15);
s4_p07_a4 = p07_s04m(windowframe,3:15);

[ns01_p07_a4, ns02_p07_a4, ns03_p07_a4, ns04_p07_a4] = sensors_timealignment_different_length(
							t1_p07_a4,t2_p07_a4,t3_p07_a4,t4_p07_a4, 
							s1_p07_a4,s2_p07_a4,s3_p07_a4,s4_p07_a4);

%plottingFOURsensors(ns01_p07_a4, ns02_p07_a4, ns03_p07_a4, ns04_p07_a4, 2)

dlmwrite([p07_outcome_data_path 'a04_s01_p07'], ns01_p07_a4 ,'delimiter',',','precision',15);
dlmwrite([p07_outcome_data_path 'a04_s02_p07'], ns02_p07_a4 ,'delimiter',',','precision',15);
dlmwrite([p07_outcome_data_path 'a04_s03_p07'], ns03_p07_a4 ,'delimiter',',','precision',15);
dlmwrite([p07_outcome_data_path 'a04_s04_p07'], ns04_p07_a4 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p07   TIME ALIGNMENT  FOR ACTIVITY _a5   %%%%%%%%%%%%%%%%
windowframe = p07_windowframe_a5;
t1_p07_a5 = p07_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p07_a5 = p07_s02m(windowframe,2);
t3_p07_a5 = p07_s03m(windowframe,2);
t4_p07_a5 = p07_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p07_a5 = p07_s01m(windowframe,3:15);
s2_p07_a5 = p07_s02m(windowframe,3:15);
s3_p07_a5 = p07_s03m(windowframe,3:15);
s4_p07_a5 = p07_s04m(windowframe,3:15);

[ns01_p07_a5, ns02_p07_a5, ns03_p07_a5, ns04_p07_a5] = sensors_timealignment_different_length(
							t1_p07_a5,t2_p07_a5,t3_p07_a5,t4_p07_a5, 
							s1_p07_a5,s2_p07_a5,s3_p07_a5,s4_p07_a5);

%plottingFOURsensors(ns01_p07_a5, ns02_p07_a5, ns03_p07_a5, ns04_p07_a5, 2)

dlmwrite([p07_outcome_data_path 'a05_s01_p07'], ns01_p07_a5 ,'delimiter',',','precision',15);
dlmwrite([p07_outcome_data_path 'a05_s02_p07'], ns02_p07_a5 ,'delimiter',',','precision',15);
dlmwrite([p07_outcome_data_path 'a05_s03_p07'], ns03_p07_a5 ,'delimiter',',','precision',15);
dlmwrite([p07_outcome_data_path 'a05_s04_p07'], ns04_p07_a5 ,'delimiter',',','precision',15);






% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p07   TIME ALIGNMENT  FOR ACTIVITY _a6   %%%%%%%%%%%%%%%%
windowframe = p07_windowframe_a6;
t1_p07_a6 = p07_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p07_a6 = p07_s02m(windowframe,2);
t3_p07_a6 = p07_s03m(windowframe,2);
t4_p07_a6 = p07_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p07_a6 = p07_s01m(windowframe,3:15);
s2_p07_a6 = p07_s02m(windowframe,3:15);
s3_p07_a6 = p07_s03m(windowframe,3:15);
s4_p07_a6 = p07_s04m(windowframe,3:15);

[ns01_p07_a6, ns02_p07_a6, ns03_p07_a6, ns04_p07_a6] = sensors_timealignment_different_length(
							t1_p07_a6,t2_p07_a6,t3_p07_a6,t4_p07_a6, 
							s1_p07_a6,s2_p07_a6,s3_p07_a6,s4_p07_a6);

%plottingFOURsensors(ns01_p07_a6, ns02_p07_a6, ns03_p07_a6, ns04_p07_a6, 2)

dlmwrite([p07_outcome_data_path 'a06_s01_p07'], ns01_p07_a6 ,'delimiter',',','precision',15);
dlmwrite([p07_outcome_data_path 'a06_s02_p07'], ns02_p07_a6 ,'delimiter',',','precision',15);
dlmwrite([p07_outcome_data_path 'a06_s03_p07'], ns03_p07_a6 ,'delimiter',',','precision',15);
dlmwrite([p07_outcome_data_path 'a06_s04_p07'], ns04_p07_a6 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p07   TIME ALIGNMENT  FOR ACTIVITY _a7   %%%%%%%%%%%%%%%%
windowframe = p07_windowframe_a7;
t1_p07_a7 = p07_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p07_a7 = p07_s02m(windowframe,2);
t3_p07_a7 = p07_s03m(windowframe,2);
t4_p07_a7 = p07_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p07_a7 = p07_s01m(windowframe,3:15);
s2_p07_a7 = p07_s02m(windowframe,3:15);
s3_p07_a7 = p07_s03m(windowframe,3:15);
s4_p07_a7 = p07_s04m(windowframe,3:15);

[ns01_p07_a7, ns02_p07_a7, ns03_p07_a7, ns04_p07_a7] = sensors_timealignment_different_length(
							t1_p07_a7,t2_p07_a7,t3_p07_a7,t4_p07_a7, 
							s1_p07_a7,s2_p07_a7,s3_p07_a7,s4_p07_a7);

%plottingFOURsensors(ns01_p07_a7, ns02_p07_a7, ns03_p07_a7, ns04_p07_a7, 2)

dlmwrite([p07_outcome_data_path 'a07_s01_p07'], ns01_p07_a7 ,'delimiter',',','precision',15);
dlmwrite([p07_outcome_data_path 'a07_s02_p07'], ns02_p07_a7 ,'delimiter',',','precision',15);
dlmwrite([p07_outcome_data_path 'a07_s03_p07'], ns03_p07_a7 ,'delimiter',',','precision',15);
dlmwrite([p07_outcome_data_path 'a07_s04_p07'], ns04_p07_a7 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p07   TIME ALIGNMENT  FOR ACTIVITY _a8   %%%%%%%%%%%%%%%%
t1_p07_a8 = p07_s01m(p07_labels(8,4):p07_max_length_sensors(1),2);   %TimestampTx
t2_p07_a8 = p07_s02m(p07_labels(8,4):p07_max_length_sensors(2),2);
t3_p07_a8 = p07_s03m(p07_labels(8,4):p07_max_length_sensors(3),2);
t4_p07_a8 = p07_s04m(p07_labels(8,4):p07_max_length_sensors(4),2);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p07_a8 = p07_s01m(windowframe,3:15);
s2_p07_a8 = p07_s02m(windowframe,3:15);
s3_p07_a8 = p07_s03m(windowframe,3:15);
s4_p07_a8 = p07_s04m(windowframe,3:15);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p07_a8 = p07_s01m(p07_labels(8,4):p07_max_length_sensors(1),3:15);
s2_p07_a8 = p07_s02m(p07_labels(8,4):p07_max_length_sensors(2),3:15);
s3_p07_a8 = p07_s03m(p07_labels(8,4):p07_max_length_sensors(3),3:15);
s4_p07_a8 = p07_s04m(p07_labels(8,4):p07_max_length_sensors(4),3:15);

[ns01_p07_a8, ns02_p07_a8, ns03_p07_a8, ns04_p07_a8] = sensors_timealignment_different_length(
							t1_p07_a8,t2_p07_a8,t3_p07_a8,t4_p07_a8, 
							s1_p07_a8,s2_p07_a8,s3_p07_a8,s4_p07_a8);

%plottingFOURsensors(ns01_p07_a8, ns02_p07_a8, ns03_p07_a8, ns04_p07_a8, 2)

dlmwrite([p07_outcome_data_path 'a08_s01_p07'], ns01_p07_a8 ,'delimiter',',','precision',15);
dlmwrite([p07_outcome_data_path 'a08_s02_p07'], ns02_p07_a8 ,'delimiter',',','precision',15);
dlmwrite([p07_outcome_data_path 'a08_s03_p07'], ns03_p07_a8 ,'delimiter',',','precision',15);
dlmwrite([p07_outcome_data_path 'a08_s04_p07'], ns04_p07_a8 ,'delimiter',',','precision',15);








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  --  p08 -- %%%%%%%%%%%%%%%%%%%%%



p08_data_path = strcat(datapath,'/p08/p08-HII/');
[p08_s01m, p08_s02m, p08_s03m, p08_s04m, p08_max_length_sensors] = cvs2arrays(p08_data_path);
p08_labels = labels(57:64,:);

p08_windowframe_a1 = p08_labels(1,4):p08_labels(1,5);
p08_windowframe_a2 = p08_labels(2,4):p08_labels(2,5);
p08_windowframe_a3 = p08_labels(3,4):p08_labels(3,5);
p08_windowframe_a4 = p08_labels(4,4):p08_labels(4,5);
p08_windowframe_a5 = p08_labels(5,4):p08_labels(5,5);
p08_windowframe_a6 = p08_labels(6,4):p08_labels(6,5);
p08_windowframe_a7 = p08_labels(7,4):p08_labels(7,5);
%p08_windowframe_a8 HERE IS USED THE MAX LENGTH OF THE TIMESERIES

% CREATE PATH TO SAVE DATA
p08_split_path = strsplit(p08_data_path,'/');
p08_outcome_data_path = strcat(outcomes_path, p08_split_path(09),'/',p08_split_path(10),'/');
p08_outcome_data_path= char(p08_outcome_data_path);
if ~exist(p08_outcome_data_path,'dir');
  {
    myk =  cstrcat('system(',' ''mkdir', ' -p ',p08_outcome_data_path,''')');
    eval( sprintf(myk) );
  }
end




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p08   TIME ALIGNMENT  FOR ACTIVITY _a1   %%%%%%%%%%%%%%%%
windowframe = p08_windowframe_a1;
t1_p08_a1 = p08_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p08_a1 = p08_s02m(windowframe,2);
t3_p08_a1 = p08_s03m(windowframe,2);
t4_p08_a1 = p08_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p08_a1 = p08_s01m(windowframe,3:15);
s2_p08_a1 = p08_s02m(windowframe,3:15);
s3_p08_a1 = p08_s03m(windowframe,3:15);
s4_p08_a1 = p08_s04m(windowframe,3:15);

[ns01_p08_a1, ns02_p08_a1, ns03_p08_a1, ns04_p08_a1] = sensors_timealignment_different_length(
							t1_p08_a1,t2_p08_a1,t3_p08_a1,t4_p08_a1, 
							s1_p08_a1,s2_p08_a1,s3_p08_a1,s4_p08_a1);

%plottingFOURsensors(ns01_p08_a1, ns02_p08_a1, ns03_p08_a1, ns04_p08_a1, 2)

dlmwrite([p08_outcome_data_path 'a01_s01_p08'], ns01_p08_a1 ,'delimiter',',','precision',15);
dlmwrite([p08_outcome_data_path 'a01_s02_p08'], ns02_p08_a1 ,'delimiter',',','precision',15);
dlmwrite([p08_outcome_data_path 'a01_s03_p08'], ns03_p08_a1 ,'delimiter',',','precision',15);
dlmwrite([p08_outcome_data_path 'a01_s04_p08'], ns04_p08_a1 ,'delimiter',',','precision',15);




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p08   TIME ALIGNMENT  FOR ACTIVITY _a2   %%%%%%%%%%%%%%%%
windowframe = p08_windowframe_a2;
t1_p08_a2 = p08_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p08_a2 = p08_s02m(windowframe,2);
t3_p08_a2 = p08_s03m(windowframe,2);
t4_p08_a2 = p08_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p08_a2 = p08_s01m(windowframe,3:15);
s2_p08_a2 = p08_s02m(windowframe,3:15);
s3_p08_a2 = p08_s03m(windowframe,3:15);
s4_p08_a2 = p08_s04m(windowframe,3:15);

[ns01_p08_a2, ns02_p08_a2, ns03_p08_a2, ns04_p08_a2] = sensors_timealignment_different_length(
							t1_p08_a2,t2_p08_a2,t3_p08_a2,t4_p08_a2, 
							s1_p08_a2,s2_p08_a2,s3_p08_a2,s4_p08_a2);


%plottingFOURsensors(ns01_p08_a2, ns02_p08_a2, ns03_p08_a2, ns04_p08_a2, 2)

dlmwrite([p08_outcome_data_path 'a02_s01_p08'], ns01_p08_a2 ,'delimiter',',','precision',15);
dlmwrite([p08_outcome_data_path 'a02_s02_p08'], ns02_p08_a2 ,'delimiter',',','precision',15);
dlmwrite([p08_outcome_data_path 'a02_s03_p08'], ns03_p08_a2 ,'delimiter',',','precision',15);
dlmwrite([p08_outcome_data_path 'a02_s04_p08'], ns04_p08_a2 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p08   TIME ALIGNMENT  FOR ACTIVITY _a3   %%%%%%%%%%%%%%%%
windowframe = p08_windowframe_a3;
t1_p08_a3 = p08_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p08_a3 = p08_s02m(windowframe,2);
t3_p08_a3 = p08_s03m(windowframe,2);
t4_p08_a3 = p08_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p08_a3 = p08_s01m(windowframe,3:15);
s2_p08_a3 = p08_s02m(windowframe,3:15);
s3_p08_a3 = p08_s03m(windowframe,3:15);
s4_p08_a3 = p08_s04m(windowframe,3:15);

[ns01_p08_a3, ns02_p08_a3, ns03_p08_a3, ns04_p08_a3] = sensors_timealignment_different_length(
							t1_p08_a3,t2_p08_a3,t3_p08_a3,t4_p08_a3, 
							s1_p08_a3,s2_p08_a3,s3_p08_a3,s4_p08_a3);

%plottingFOURsensors(ns01_p08_a3, ns02_p08_a3, ns03_p08_a3, ns04_p08_a3, 2)

dlmwrite([p08_outcome_data_path 'a03_s01_p08'], ns01_p08_a3 ,'delimiter',',','precision',15);
dlmwrite([p08_outcome_data_path 'a03_s02_p08'], ns02_p08_a3 ,'delimiter',',','precision',15);
dlmwrite([p08_outcome_data_path 'a03_s03_p08'], ns03_p08_a3 ,'delimiter',',','precision',15);
dlmwrite([p08_outcome_data_path 'a03_s04_p08'], ns04_p08_a3 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p08   TIME ALIGNMENT  FOR ACTIVITY _a4   %%%%%%%%%%%%%%%%
windowframe = p08_windowframe_a4;
t1_p08_a4 = p08_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p08_a4 = p08_s02m(windowframe,2);
t3_p08_a4 = p08_s03m(windowframe,2);
t4_p08_a4 = p08_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p08_a4 = p08_s01m(windowframe,3:15);
s2_p08_a4 = p08_s02m(windowframe,3:15);
s3_p08_a4 = p08_s03m(windowframe,3:15);
s4_p08_a4 = p08_s04m(windowframe,3:15);

[ns01_p08_a4, ns02_p08_a4, ns03_p08_a4, ns04_p08_a4] = sensors_timealignment_different_length(
							t1_p08_a4,t2_p08_a4,t3_p08_a4,t4_p08_a4, 
							s1_p08_a4,s2_p08_a4,s3_p08_a4,s4_p08_a4);

%plottingFOURsensors(ns01_p08_a4, ns02_p08_a4, ns03_p08_a4, ns04_p08_a4, 2)

dlmwrite([p08_outcome_data_path 'a04_s01_p08'], ns01_p08_a4 ,'delimiter',',','precision',15);
dlmwrite([p08_outcome_data_path 'a04_s02_p08'], ns02_p08_a4 ,'delimiter',',','precision',15);
dlmwrite([p08_outcome_data_path 'a04_s03_p08'], ns03_p08_a4 ,'delimiter',',','precision',15);
dlmwrite([p08_outcome_data_path 'a04_s04_p08'], ns04_p08_a4 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p08   TIME ALIGNMENT  FOR ACTIVITY _a5   %%%%%%%%%%%%%%%%
windowframe = p08_windowframe_a5;
t1_p08_a5 = p08_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p08_a5 = p08_s02m(windowframe,2);
t3_p08_a5 = p08_s03m(windowframe,2);
t4_p08_a5 = p08_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p08_a5 = p08_s01m(windowframe,3:15);
s2_p08_a5 = p08_s02m(windowframe,3:15);
s3_p08_a5 = p08_s03m(windowframe,3:15);
s4_p08_a5 = p08_s04m(windowframe,3:15);

[ns01_p08_a5, ns02_p08_a5, ns03_p08_a5, ns04_p08_a5] = sensors_timealignment_different_length(
							t1_p08_a5,t2_p08_a5,t3_p08_a5,t4_p08_a5, 
							s1_p08_a5,s2_p08_a5,s3_p08_a5,s4_p08_a5);

%plottingFOURsensors(ns01_p08_a5, ns02_p08_a5, ns03_p08_a5, ns04_p08_a5, 2)

dlmwrite([p08_outcome_data_path 'a05_s01_p08'], ns01_p08_a5 ,'delimiter',',','precision',15);
dlmwrite([p08_outcome_data_path 'a05_s02_p08'], ns02_p08_a5 ,'delimiter',',','precision',15);
dlmwrite([p08_outcome_data_path 'a05_s03_p08'], ns03_p08_a5 ,'delimiter',',','precision',15);
dlmwrite([p08_outcome_data_path 'a05_s04_p08'], ns04_p08_a5 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p08   TIME ALIGNMENT  FOR ACTIVITY _a6   %%%%%%%%%%%%%%%%
windowframe = p08_windowframe_a6;
t1_p08_a6 = p08_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p08_a6 = p08_s02m(windowframe,2);
t3_p08_a6 = p08_s03m(windowframe,2);
t4_p08_a6 = p08_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p08_a6 = p08_s01m(windowframe,3:15);
s2_p08_a6 = p08_s02m(windowframe,3:15);
s3_p08_a6 = p08_s03m(windowframe,3:15);
s4_p08_a6 = p08_s04m(windowframe,3:15);

[ns01_p08_a6, ns02_p08_a6, ns03_p08_a6, ns04_p08_a6] = sensors_timealignment_different_length(
							t1_p08_a6,t2_p08_a6,t3_p08_a6,t4_p08_a6, 
							s1_p08_a6,s2_p08_a6,s3_p08_a6,s4_p08_a6);

%plottingFOURsensors(ns01_p08_a6, ns02_p08_a6, ns03_p08_a6, ns04_p08_a6, 2)

dlmwrite([p08_outcome_data_path 'a06_s01_p08'], ns01_p08_a6 ,'delimiter',',','precision',15);
dlmwrite([p08_outcome_data_path 'a06_s02_p08'], ns02_p08_a6 ,'delimiter',',','precision',15);
dlmwrite([p08_outcome_data_path 'a06_s03_p08'], ns03_p08_a6 ,'delimiter',',','precision',15);
dlmwrite([p08_outcome_data_path 'a06_s04_p08'], ns04_p08_a6 ,'delimiter',',','precision',15);







% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p08   TIME ALIGNMENT  FOR ACTIVITY _a7   %%%%%%%%%%%%%%%%
windowframe = p08_windowframe_a7;
t1_p08_a7 = p08_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p08_a7 = p08_s02m(windowframe,2);
t3_p08_a7 = p08_s03m(windowframe,2);
t4_p08_a7 = p08_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p08_a7 = p08_s01m(windowframe,3:15);
s2_p08_a7 = p08_s02m(windowframe,3:15);
s3_p08_a7 = p08_s03m(windowframe,3:15);
s4_p08_a7 = p08_s04m(windowframe,3:15);

[ns01_p08_a7, ns02_p08_a7, ns03_p08_a7, ns04_p08_a7] = sensors_timealignment_different_length(
							t1_p08_a7,t2_p08_a7,t3_p08_a7,t4_p08_a7, 
							s1_p08_a7,s2_p08_a7,s3_p08_a7,s4_p08_a7);

%plottingFOURsensors(ns01_p08_a7, ns02_p08_a7, ns03_p08_a7, ns04_p08_a7, 2)

dlmwrite([p08_outcome_data_path 'a07_s01_p08'], ns01_p08_a7 ,'delimiter',',','precision',15);
dlmwrite([p08_outcome_data_path 'a07_s02_p08'], ns02_p08_a7 ,'delimiter',',','precision',15);
dlmwrite([p08_outcome_data_path 'a07_s03_p08'], ns03_p08_a7 ,'delimiter',',','precision',15);
dlmwrite([p08_outcome_data_path 'a07_s04_p08'], ns04_p08_a7 ,'delimiter',',','precision',15);









% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p08   TIME ALIGNMENT  FOR ACTIVITY _a8   %%%%%%%%%%%%%%%%
t1_p08_a8 = p08_s01m(p08_labels(8,4):p08_max_length_sensors(1),2);   %TimestampTx
t2_p08_a8 = p08_s02m(p08_labels(8,4):p08_max_length_sensors(2),2);
t3_p08_a8 = p08_s03m(p08_labels(8,4):p08_max_length_sensors(3),2);
t4_p08_a8 = p08_s04m(p08_labels(8,4):p08_max_length_sensors(4),2);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p08_a8 = p08_s01m(windowframe,3:15);
s2_p08_a8 = p08_s02m(windowframe,3:15);
s3_p08_a8 = p08_s03m(windowframe,3:15);
s4_p08_a8 = p08_s04m(windowframe,3:15);

% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p08_a8 = p08_s01m(p08_labels(8,4):p08_max_length_sensors(1),3:15);
s2_p08_a8 = p08_s02m(p08_labels(8,4):p08_max_length_sensors(2),3:15);
s3_p08_a8 = p08_s03m(p08_labels(8,4):p08_max_length_sensors(3),3:15);
s4_p08_a8 = p08_s04m(p08_labels(8,4):p08_max_length_sensors(4),3:15);

[ns01_p08_a8, ns02_p08_a8, ns03_p08_a8, ns04_p08_a8] = sensors_timealignment_different_length(
							t1_p08_a8,t2_p08_a8,t3_p08_a8,t4_p08_a8, 
							s1_p08_a8,s2_p08_a8,s3_p08_a8,s4_p08_a8);

%plottingFOURsensors(ns01_p08_a8, ns02_p08_a8, ns03_p08_a8, ns04_p08_a8, 2)

dlmwrite([p08_outcome_data_path 'a08_s01_p08'], ns01_p08_a8 ,'delimiter',',','precision',15);
dlmwrite([p08_outcome_data_path 'a08_s02_p08'], ns02_p08_a8 ,'delimiter',',','precision',15);
dlmwrite([p08_outcome_data_path 'a08_s03_p08'], ns03_p08_a8 ,'delimiter',',','precision',15);
dlmwrite([p08_outcome_data_path 'a08_s04_p08'], ns04_p08_a8 ,'delimiter',',','precision',15);





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  --  p09 -- %%%%%%%%%%%%%%%%%%%%%



p09_data_path = strcat(datapath,'/p09/p09-HII/');
[p09_s01m, p09_s02m, p09_s03m, p09_s04m, p09_max_length_sensors] = cvs2arrays(p09_data_path);
p09_labels = labels(65:72,:);



p09_windowframe_a1 = p09_labels(1,4):p09_labels(1,5);
p09_windowframe_a2 = p09_labels(2,4):p09_labels(2,5);
p09_windowframe_a3 = p09_labels(3,4):p09_labels(3,5);
p09_windowframe_a4 = p09_labels(4,4):p09_labels(4,5);
p09_windowframe_a5 = p09_labels(5,4):p09_labels(5,5);
p09_windowframe_a6 = p09_labels(6,4):p09_labels(6,5);
p09_windowframe_a7 = p09_labels(7,4):p09_labels(7,5);
%p09_windowframe_a8 HERE IS USED THE MAX LENGTH OF THE TIMESERIES

% CREATE PATH TO SAVE DATA
p09_split_path = strsplit(p09_data_path,'/');
p09_outcome_data_path = strcat(outcomes_path, p09_split_path(09),'/',p09_split_path(10),'/');
p09_outcome_data_path= char(p09_outcome_data_path);
if ~exist(p09_outcome_data_path,'dir');
  {
    myk =  cstrcat('system(',' ''mkdir', ' -p ',p09_outcome_data_path,''')');
    eval( sprintf(myk) );
  }
end



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p09   TIME ALIGNMENT  FOR ACTIVITY _a1   %%%%%%%%%%%%%%%%
windowframe = p09_windowframe_a1;
t1_p09_a1 = p09_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p09_a1 = p09_s02m(windowframe,2);
t3_p09_a1 = p09_s03m(windowframe,2);
t4_p09_a1 = p09_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p09_a1 = p09_s01m(windowframe,3:15);
s2_p09_a1 = p09_s02m(windowframe,3:15);
s3_p09_a1 = p09_s03m(windowframe,3:15);
s4_p09_a1 = p09_s04m(windowframe,3:15);

[ns01_p09_a1, ns02_p09_a1, ns03_p09_a1, ns04_p09_a1] = sensors_timealignment_different_length(
							t1_p09_a1,t2_p09_a1,t3_p09_a1,t4_p09_a1, 
							s1_p09_a1,s2_p09_a1,s3_p09_a1,s4_p09_a1);

%plottingFOURsensors(ns01_p09_a1, ns02_p09_a1, ns03_p09_a1, ns04_p09_a1, 2)

dlmwrite([p09_outcome_data_path 'a01_s01_p09'], ns01_p09_a1 ,'delimiter',',','precision',15);
dlmwrite([p09_outcome_data_path 'a01_s02_p09'], ns02_p09_a1 ,'delimiter',',','precision',15);
dlmwrite([p09_outcome_data_path 'a01_s03_p09'], ns03_p09_a1 ,'delimiter',',','precision',15);
dlmwrite([p09_outcome_data_path 'a01_s04_p09'], ns04_p09_a1 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p09   TIME ALIGNMENT  FOR ACTIVITY _a2   %%%%%%%%%%%%%%%%
windowframe = p09_windowframe_a2;
t1_p09_a2 = p09_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p09_a2 = p09_s02m(windowframe,2);
t3_p09_a2 = p09_s03m(windowframe,2);
t4_p09_a2 = p09_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p09_a2 = p09_s01m(windowframe,3:15);
s2_p09_a2 = p09_s02m(windowframe,3:15);
s3_p09_a2 = p09_s03m(windowframe,3:15);
s4_p09_a2 = p09_s04m(windowframe,3:15);

[ns01_p09_a2, ns02_p09_a2, ns03_p09_a2, ns04_p09_a2] = sensors_timealignment_different_length(
							t1_p09_a2,t2_p09_a2,t3_p09_a2,t4_p09_a2, 
							s1_p09_a2,s2_p09_a2,s3_p09_a2,s4_p09_a2);


%plottingFOURsensors(ns01_p09_a2, ns02_p09_a2, ns03_p09_a2, ns04_p09_a2, 2)

dlmwrite([p09_outcome_data_path 'a02_s01_p09'], ns01_p09_a2 ,'delimiter',',','precision',15);
dlmwrite([p09_outcome_data_path 'a02_s02_p09'], ns02_p09_a2 ,'delimiter',',','precision',15);
dlmwrite([p09_outcome_data_path 'a02_s03_p09'], ns03_p09_a2 ,'delimiter',',','precision',15);
dlmwrite([p09_outcome_data_path 'a02_s04_p09'], ns04_p09_a2 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p09   TIME ALIGNMENT  FOR ACTIVITY _a3   %%%%%%%%%%%%%%%%
windowframe = p09_windowframe_a3;
t1_p09_a3 = p09_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p09_a3 = p09_s02m(windowframe,2);
t3_p09_a3 = p09_s03m(windowframe,2);
t4_p09_a3 = p09_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p09_a3 = p09_s01m(windowframe,3:15);
s2_p09_a3 = p09_s02m(windowframe,3:15);
s3_p09_a3 = p09_s03m(windowframe,3:15);
s4_p09_a3 = p09_s04m(windowframe,3:15);

[ns01_p09_a3, ns02_p09_a3, ns03_p09_a3, ns04_p09_a3] = sensors_timealignment_different_length(
							t1_p09_a3,t2_p09_a3,t3_p09_a3,t4_p09_a3, 
							s1_p09_a3,s2_p09_a3,s3_p09_a3,s4_p09_a3);

%plottingFOURsensors(ns01_p09_a3, ns02_p09_a3, ns03_p09_a3, ns04_p09_a3, 2)

dlmwrite([p09_outcome_data_path 'a03_s01_p09'], ns01_p09_a3 ,'delimiter',',','precision',15);
dlmwrite([p09_outcome_data_path 'a03_s02_p09'], ns02_p09_a3 ,'delimiter',',','precision',15);
dlmwrite([p09_outcome_data_path 'a03_s03_p09'], ns03_p09_a3 ,'delimiter',',','precision',15);
dlmwrite([p09_outcome_data_path 'a03_s04_p09'], ns04_p09_a3 ,'delimiter',',','precision',15);




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p09   TIME ALIGNMENT  FOR ACTIVITY _a4   %%%%%%%%%%%%%%%%
windowframe = p09_windowframe_a4;
t1_p09_a4 = p09_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p09_a4 = p09_s02m(windowframe,2);
t3_p09_a4 = p09_s03m(windowframe,2);
t4_p09_a4 = p09_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p09_a4 = p09_s01m(windowframe,3:15);
s2_p09_a4 = p09_s02m(windowframe,3:15);
s3_p09_a4 = p09_s03m(windowframe,3:15);
s4_p09_a4 = p09_s04m(windowframe,3:15);

[ns01_p09_a4, ns02_p09_a4, ns03_p09_a4, ns04_p09_a4] = sensors_timealignment_different_length(
							t1_p09_a4,t2_p09_a4,t3_p09_a4,t4_p09_a4, 
							s1_p09_a4,s2_p09_a4,s3_p09_a4,s4_p09_a4);

%plottingFOURsensors(ns01_p09_a4, ns02_p09_a4, ns03_p09_a4, ns04_p09_a4, 2)

dlmwrite([p09_outcome_data_path 'a04_s01_p09'], ns01_p09_a4 ,'delimiter',',','precision',15);
dlmwrite([p09_outcome_data_path 'a04_s02_p09'], ns02_p09_a4 ,'delimiter',',','precision',15);
dlmwrite([p09_outcome_data_path 'a04_s03_p09'], ns03_p09_a4 ,'delimiter',',','precision',15);
dlmwrite([p09_outcome_data_path 'a04_s04_p09'], ns04_p09_a4 ,'delimiter',',','precision',15);




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p09   TIME ALIGNMENT  FOR ACTIVITY _a5   %%%%%%%%%%%%%%%%
windowframe = p09_windowframe_a5;
t1_p09_a5 = p09_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p09_a5 = p09_s02m(windowframe,2);
t3_p09_a5 = p09_s03m(windowframe,2);
t4_p09_a5 = p09_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p09_a5 = p09_s01m(windowframe,3:15);
s2_p09_a5 = p09_s02m(windowframe,3:15);
s3_p09_a5 = p09_s03m(windowframe,3:15);
s4_p09_a5 = p09_s04m(windowframe,3:15);

[ns01_p09_a5, ns02_p09_a5, ns03_p09_a5, ns04_p09_a5] = sensors_timealignment_different_length(
							t1_p09_a5,t2_p09_a5,t3_p09_a5,t4_p09_a5, 
							s1_p09_a5,s2_p09_a5,s3_p09_a5,s4_p09_a5);

%plottingFOURsensors(ns01_p09_a5, ns02_p09_a5, ns03_p09_a5, ns04_p09_a5, 2)

dlmwrite([p09_outcome_data_path 'a05_s01_p09'], ns01_p09_a5 ,'delimiter',',','precision',15);
dlmwrite([p09_outcome_data_path 'a05_s02_p09'], ns02_p09_a5 ,'delimiter',',','precision',15);
dlmwrite([p09_outcome_data_path 'a05_s03_p09'], ns03_p09_a5 ,'delimiter',',','precision',15);
dlmwrite([p09_outcome_data_path 'a05_s04_p09'], ns04_p09_a5 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p09   TIME ALIGNMENT  FOR ACTIVITY _a6   %%%%%%%%%%%%%%%%
windowframe = p09_windowframe_a6;
t1_p09_a6 = p09_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p09_a6 = p09_s02m(windowframe,2);
t3_p09_a6 = p09_s03m(windowframe,2);
t4_p09_a6 = p09_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p09_a6 = p09_s01m(windowframe,3:15);
s2_p09_a6 = p09_s02m(windowframe,3:15);
s3_p09_a6 = p09_s03m(windowframe,3:15);
s4_p09_a6 = p09_s04m(windowframe,3:15);

[ns01_p09_a6, ns02_p09_a6, ns03_p09_a6, ns04_p09_a6] = sensors_timealignment_different_length(
							t1_p09_a6,t2_p09_a6,t3_p09_a6,t4_p09_a6, 
							s1_p09_a6,s2_p09_a6,s3_p09_a6,s4_p09_a6);

%plottingFOURsensors(ns01_p09_a6, ns02_p09_a6, ns03_p09_a6, ns04_p09_a6, 2)

dlmwrite([p09_outcome_data_path 'a06_s01_p09'], ns01_p09_a6 ,'delimiter',',','precision',15);
dlmwrite([p09_outcome_data_path 'a06_s02_p09'], ns02_p09_a6 ,'delimiter',',','precision',15);
dlmwrite([p09_outcome_data_path 'a06_s03_p09'], ns03_p09_a6 ,'delimiter',',','precision',15);
dlmwrite([p09_outcome_data_path 'a06_s04_p09'], ns04_p09_a6 ,'delimiter',',','precision',15);







% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p09   TIME ALIGNMENT  FOR ACTIVITY _a7   %%%%%%%%%%%%%%%%
windowframe = p09_windowframe_a7;
t1_p09_a7 = p09_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p09_a7 = p09_s02m(windowframe,2);
t3_p09_a7 = p09_s03m(windowframe,2);
t4_p09_a7 = p09_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p09_a7 = p09_s01m(windowframe,3:15);
s2_p09_a7 = p09_s02m(windowframe,3:15);
s3_p09_a7 = p09_s03m(windowframe,3:15);
s4_p09_a7 = p09_s04m(windowframe,3:15);

[ns01_p09_a7, ns02_p09_a7, ns03_p09_a7, ns04_p09_a7] = sensors_timealignment_different_length_inverted_maxmin_vectors(
							t1_p09_a7,t2_p09_a7,t3_p09_a7,t4_p09_a7, 
							s1_p09_a7,s2_p09_a7,s3_p09_a7,s4_p09_a7);

%plottingFOURsensors(ns01_p09_a7, ns02_p09_a7, ns03_p09_a7, ns04_p09_a7, 2)

dlmwrite([p09_outcome_data_path 'a07_s01_p09'], ns01_p09_a7 ,'delimiter',',','precision',15);
dlmwrite([p09_outcome_data_path 'a07_s02_p09'], ns02_p09_a7 ,'delimiter',',','precision',15);
dlmwrite([p09_outcome_data_path 'a07_s03_p09'], ns03_p09_a7 ,'delimiter',',','precision',15);
dlmwrite([p09_outcome_data_path 'a07_s04_p09'], ns04_p09_a7 ,'delimiter',',','precision',15);









% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p09   TIME ALIGNMENT  FOR ACTIVITY _a8   %%%%%%%%%%%%%%%%
t1_p09_a8 = p09_s01m(p09_labels(8,4):p09_max_length_sensors(1),2);   %TimestampTx
t2_p09_a8 = p09_s02m(p09_labels(8,4):p09_max_length_sensors(2),2);
t3_p09_a8 = p09_s03m(p09_labels(8,4):p09_max_length_sensors(3),2);
t4_p09_a8 = p09_s04m(p09_labels(8,4):p09_max_length_sensors(4),2);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p09_a8 = p09_s01m(windowframe,3:15);
s2_p09_a8 = p09_s02m(windowframe,3:15);
s3_p09_a8 = p09_s03m(windowframe,3:15);
s4_p09_a8 = p09_s04m(windowframe,3:15);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p09_a8 = p09_s01m(p09_labels(8,4):p09_max_length_sensors(1),3:15);
s2_p09_a8 = p09_s02m(p09_labels(8,4):p09_max_length_sensors(2),3:15);
s3_p09_a8 = p09_s03m(p09_labels(8,4):p09_max_length_sensors(3),3:15);
s4_p09_a8 = p09_s04m(p09_labels(8,4):p09_max_length_sensors(4),3:15);

[ns01_p09_a8, ns02_p09_a8, ns03_p09_a8, ns04_p09_a8] = sensors_timealignment_different_length(
							t1_p09_a8,t2_p09_a8,t3_p09_a8,t4_p09_a8, 
							s1_p09_a8,s2_p09_a8,s3_p09_a8,s4_p09_a8);

%plottingFOURsensors(ns01_p09_a8, ns02_p09_a8, ns03_p09_a8, ns04_p09_a8, 2)

dlmwrite([p09_outcome_data_path 'a08_s01_p09'], ns01_p09_a8 ,'delimiter',',','precision',15);
dlmwrite([p09_outcome_data_path 'a08_s02_p09'], ns02_p09_a8 ,'delimiter',',','precision',15);
dlmwrite([p09_outcome_data_path 'a08_s03_p09'], ns03_p09_a8 ,'delimiter',',','precision',15);
dlmwrite([p09_outcome_data_path 'a08_s04_p09'], ns04_p09_a8 ,'delimiter',',','precision',15);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  --  p10 -- %%%%%%%%%%%%%%%%%%%%%



p10_data_path = strcat(datapath,'/p10/p10-HII/');
[p10_s01m, p10_s02m, p10_s03m, p10_s04m, p10_max_length_sensors] = cvs2arrays(p10_data_path);
p10_labels = labels(73:80,:);



p10_windowframe_a1 = p10_labels(1,4):p10_labels(1,5);
p10_windowframe_a2 = p10_labels(2,4):p10_labels(2,5);
p10_windowframe_a3 = p10_labels(3,4):p10_labels(3,5);
p10_windowframe_a4 = p10_labels(4,4):p10_labels(4,5);
p10_windowframe_a5 = p10_labels(5,4):p10_labels(5,5);
p10_windowframe_a6 = p10_labels(6,4):p10_labels(6,5);
p10_windowframe_a7 = p10_labels(7,4):p10_labels(7,5);
%p10_windowframe_a8 HERE IS USED THE MAX LENGTH OF THE TIMESERIES

% CREATE PATH TO SAVE DATA
p10_split_path = strsplit(p10_data_path,'/');
p10_outcome_data_path = strcat(outcomes_path, p10_split_path(09),'/',p10_split_path(10),'/');
p10_outcome_data_path= char(p10_outcome_data_path);
if ~exist(p10_outcome_data_path,'dir');
  {
    myk =  cstrcat('system(',' ''mkdir', ' -p ',p10_outcome_data_path,''')');
    eval( sprintf(myk) );
  }
end




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p10   TIME ALIGNMENT  FOR ACTIVITY _a1   %%%%%%%%%%%%%%%%
windowframe = p10_windowframe_a1;
t1_p10_a1 = p10_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p10_a1 = p10_s02m(windowframe,2);
t3_p10_a1 = p10_s03m(windowframe,2);
t4_p10_a1 = p10_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p10_a1 = p10_s01m(windowframe,3:15);
s2_p10_a1 = p10_s02m(windowframe,3:15);
s3_p10_a1 = p10_s03m(windowframe,3:15);
s4_p10_a1 = p10_s04m(windowframe,3:15);

[ns01_p10_a1, ns02_p10_a1, ns03_p10_a1, ns04_p10_a1] = sensors_timealignment_different_length(
							t1_p10_a1,t2_p10_a1,t3_p10_a1,t4_p10_a1, 
							s1_p10_a1,s2_p10_a1,s3_p10_a1,s4_p10_a1);

%plottingFOURsensors(ns01_p10_a1, ns02_p10_a1, ns03_p10_a1, ns04_p10_a1, 2)

dlmwrite([p10_outcome_data_path 'a01_s01_p10'], ns01_p10_a1 ,'delimiter',',','precision',15);
dlmwrite([p10_outcome_data_path 'a01_s02_p10'], ns02_p10_a1 ,'delimiter',',','precision',15);
dlmwrite([p10_outcome_data_path 'a01_s03_p10'], ns03_p10_a1 ,'delimiter',',','precision',15);
dlmwrite([p10_outcome_data_path 'a01_s04_p10'], ns04_p10_a1 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p10   TIME ALIGNMENT  FOR ACTIVITY _a2   %%%%%%%%%%%%%%%%
windowframe = p10_windowframe_a2;
t1_p10_a2 = p10_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p10_a2 = p10_s02m(windowframe,2);
t3_p10_a2 = p10_s03m(windowframe,2);
t4_p10_a2 = p10_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p10_a2 = p10_s01m(windowframe,3:15);
s2_p10_a2 = p10_s02m(windowframe,3:15);
s3_p10_a2 = p10_s03m(windowframe,3:15);
s4_p10_a2 = p10_s04m(windowframe,3:15);

[ns01_p10_a2, ns02_p10_a2, ns03_p10_a2, ns04_p10_a2] = sensors_timealignment_different_length(
							t1_p10_a2,t2_p10_a2,t3_p10_a2,t4_p10_a2, 
							s1_p10_a2,s2_p10_a2,s3_p10_a2,s4_p10_a2);


%plottingFOURsensors(ns01_p10_a2, ns02_p10_a2, ns03_p10_a2, ns04_p10_a2, 2)

dlmwrite([p10_outcome_data_path 'a02_s01_p10'], ns01_p10_a2 ,'delimiter',',','precision',15);
dlmwrite([p10_outcome_data_path 'a02_s02_p10'], ns02_p10_a2 ,'delimiter',',','precision',15);
dlmwrite([p10_outcome_data_path 'a02_s03_p10'], ns03_p10_a2 ,'delimiter',',','precision',15);
dlmwrite([p10_outcome_data_path 'a02_s04_p10'], ns04_p10_a2 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p10   TIME ALIGNMENT  FOR ACTIVITY _a3   %%%%%%%%%%%%%%%%
windowframe = p10_windowframe_a3;
t1_p10_a3 = p10_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p10_a3 = p10_s02m(windowframe,2);
t3_p10_a3 = p10_s03m(windowframe,2);
t4_p10_a3 = p10_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p10_a3 = p10_s01m(windowframe,3:15);
s2_p10_a3 = p10_s02m(windowframe,3:15);
s3_p10_a3 = p10_s03m(windowframe,3:15);
s4_p10_a3 = p10_s04m(windowframe,3:15);

[ns01_p10_a3, ns02_p10_a3, ns03_p10_a3, ns04_p10_a3] = sensors_timealignment_different_length(
							t1_p10_a3,t2_p10_a3,t3_p10_a3,t4_p10_a3, 
							s1_p10_a3,s2_p10_a3,s3_p10_a3,s4_p10_a3);

%plottingFOURsensors(ns01_p10_a3, ns02_p10_a3, ns03_p10_a3, ns04_p10_a3, 2)

dlmwrite([p10_outcome_data_path 'a03_s01_p10'], ns01_p10_a3 ,'delimiter',',','precision',15);
dlmwrite([p10_outcome_data_path 'a03_s02_p10'], ns02_p10_a3 ,'delimiter',',','precision',15);
dlmwrite([p10_outcome_data_path 'a03_s03_p10'], ns03_p10_a3 ,'delimiter',',','precision',15);
dlmwrite([p10_outcome_data_path 'a03_s04_p10'], ns04_p10_a3 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p10   TIME ALIGNMENT  FOR ACTIVITY _a4   %%%%%%%%%%%%%%%%
windowframe = p10_windowframe_a4;
t1_p10_a4 = p10_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p10_a4 = p10_s02m(windowframe,2);
t3_p10_a4 = p10_s03m(windowframe,2);
t4_p10_a4 = p10_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p10_a4 = p10_s01m(windowframe,3:15);
s2_p10_a4 = p10_s02m(windowframe,3:15);
s3_p10_a4 = p10_s03m(windowframe,3:15);
s4_p10_a4 = p10_s04m(windowframe,3:15);

[ns01_p10_a4, ns02_p10_a4, ns03_p10_a4, ns04_p10_a4] = sensors_timealignment_different_length(
							t1_p10_a4,t2_p10_a4,t3_p10_a4,t4_p10_a4, 
							s1_p10_a4,s2_p10_a4,s3_p10_a4,s4_p10_a4);

%plottingFOURsensors(ns01_p10_a4, ns02_p10_a4, ns03_p10_a4, ns04_p10_a4, 2)

dlmwrite([p10_outcome_data_path 'a04_s01_p10'], ns01_p10_a4 ,'delimiter',',','precision',15);
dlmwrite([p10_outcome_data_path 'a04_s02_p10'], ns02_p10_a4 ,'delimiter',',','precision',15);
dlmwrite([p10_outcome_data_path 'a04_s03_p10'], ns03_p10_a4 ,'delimiter',',','precision',15);
dlmwrite([p10_outcome_data_path 'a04_s04_p10'], ns04_p10_a4 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p10   TIME ALIGNMENT  FOR ACTIVITY _a5   %%%%%%%%%%%%%%%%
windowframe = p10_windowframe_a5;
t1_p10_a5 = p10_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p10_a5 = p10_s02m(windowframe,2);
t3_p10_a5 = p10_s03m(windowframe,2);
t4_p10_a5 = p10_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p10_a5 = p10_s01m(windowframe,3:15);
s2_p10_a5 = p10_s02m(windowframe,3:15);
s3_p10_a5 = p10_s03m(windowframe,3:15);
s4_p10_a5 = p10_s04m(windowframe,3:15);

[ns01_p10_a5, ns02_p10_a5, ns03_p10_a5, ns04_p10_a5] = sensors_timealignment_different_length(
							t1_p10_a5,t2_p10_a5,t3_p10_a5,t4_p10_a5, 
							s1_p10_a5,s2_p10_a5,s3_p10_a5,s4_p10_a5);

%plottingFOURsensors(ns01_p10_a5, ns02_p10_a5, ns03_p10_a5, ns04_p10_a5, 2)

dlmwrite([p10_outcome_data_path 'a05_s01_p10'], ns01_p10_a5 ,'delimiter',',','precision',15);
dlmwrite([p10_outcome_data_path 'a05_s02_p10'], ns02_p10_a5 ,'delimiter',',','precision',15);
dlmwrite([p10_outcome_data_path 'a05_s03_p10'], ns03_p10_a5 ,'delimiter',',','precision',15);
dlmwrite([p10_outcome_data_path 'a05_s04_p10'], ns04_p10_a5 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p10   TIME ALIGNMENT  FOR ACTIVITY _a6   %%%%%%%%%%%%%%%%
windowframe = p10_windowframe_a6;
t1_p10_a6 = p10_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p10_a6 = p10_s02m(windowframe,2);
t3_p10_a6 = p10_s03m(windowframe,2);
t4_p10_a6 = p10_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p10_a6 = p10_s01m(windowframe,3:15);
s2_p10_a6 = p10_s02m(windowframe,3:15);
s3_p10_a6 = p10_s03m(windowframe,3:15);
s4_p10_a6 = p10_s04m(windowframe,3:15);

[ns01_p10_a6, ns02_p10_a6, ns03_p10_a6, ns04_p10_a6] = sensors_timealignment_different_length(
							t1_p10_a6,t2_p10_a6,t3_p10_a6,t4_p10_a6, 
							s1_p10_a6,s2_p10_a6,s3_p10_a6,s4_p10_a6);

%plottingFOURsensors(ns01_p10_a6, ns02_p10_a6, ns03_p10_a6, ns04_p10_a6, 2)

dlmwrite([p10_outcome_data_path 'a06_s01_p10'], ns01_p10_a6 ,'delimiter',',','precision',15);
dlmwrite([p10_outcome_data_path 'a06_s02_p10'], ns02_p10_a6 ,'delimiter',',','precision',15);
dlmwrite([p10_outcome_data_path 'a06_s03_p10'], ns03_p10_a6 ,'delimiter',',','precision',15);
dlmwrite([p10_outcome_data_path 'a06_s04_p10'], ns04_p10_a6 ,'delimiter',',','precision',15);







% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p10   TIME ALIGNMENT  FOR ACTIVITY _a7   %%%%%%%%%%%%%%%%
windowframe = p10_windowframe_a7;
t1_p10_a7 = p10_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p10_a7 = p10_s02m(windowframe,2);
t3_p10_a7 = p10_s03m(windowframe,2);
t4_p10_a7 = p10_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p10_a7 = p10_s01m(windowframe,3:15);
s2_p10_a7 = p10_s02m(windowframe,3:15);
s3_p10_a7 = p10_s03m(windowframe,3:15);
s4_p10_a7 = p10_s04m(windowframe,3:15);

[ns01_p10_a7, ns02_p10_a7, ns03_p10_a7, ns04_p10_a7] = sensors_timealignment_different_length(
							t1_p10_a7,t2_p10_a7,t3_p10_a7,t4_p10_a7, 
							s1_p10_a7,s2_p10_a7,s3_p10_a7,s4_p10_a7);

%plottingFOURsensors(ns01_p10_a7, ns02_p10_a7, ns03_p10_a7, ns04_p10_a7, 2)

dlmwrite([p10_outcome_data_path 'a07_s01_p10'], ns01_p10_a7 ,'delimiter',',','precision',15);
dlmwrite([p10_outcome_data_path 'a07_s02_p10'], ns02_p10_a7 ,'delimiter',',','precision',15);
dlmwrite([p10_outcome_data_path 'a07_s03_p10'], ns03_p10_a7 ,'delimiter',',','precision',15);
dlmwrite([p10_outcome_data_path 'a07_s04_p10'], ns04_p10_a7 ,'delimiter',',','precision',15);









% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p10   TIME ALIGNMENT  FOR ACTIVITY _a8   %%%%%%%%%%%%%%%%
t1_p10_a8 = p10_s01m(p10_labels(8,4):p10_max_length_sensors(1),2);   %TimestampTx
t2_p10_a8 = p10_s02m(p10_labels(8,4):p10_max_length_sensors(2),2);
t3_p10_a8 = p10_s03m(p10_labels(8,4):p10_max_length_sensors(3),2);
t4_p10_a8 = p10_s04m(p10_labels(8,4):p10_max_length_sensors(4),2);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p10_a8 = p10_s01m(windowframe,3:15);
s2_p10_a8 = p10_s02m(windowframe,3:15);
s3_p10_a8 = p10_s03m(windowframe,3:15);
s4_p10_a8 = p10_s04m(windowframe,3:15);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p10_a8 = p10_s01m(p10_labels(8,4):p10_max_length_sensors(1),3:15);
s2_p10_a8 = p10_s02m(p10_labels(8,4):p10_max_length_sensors(2),3:15);
s3_p10_a8 = p10_s03m(p10_labels(8,4):p10_max_length_sensors(3),3:15);
s4_p10_a8 = p10_s04m(p10_labels(8,4):p10_max_length_sensors(4),3:15);

[ns01_p10_a8, ns02_p10_a8, ns03_p10_a8, ns04_p10_a8] = sensors_timealignment_different_length(
							t1_p10_a8,t2_p10_a8,t3_p10_a8,t4_p10_a8, 
							s1_p10_a8,s2_p10_a8,s3_p10_a8,s4_p10_a8);

%plottingFOURsensors(ns01_p10_a8, ns02_p10_a8, ns03_p10_a8, ns04_p10_a8, 2)

dlmwrite([p10_outcome_data_path 'a08_s01_p10'], ns01_p10_a8 ,'delimiter',',','precision',15);
dlmwrite([p10_outcome_data_path 'a08_s02_p10'], ns02_p10_a8 ,'delimiter',',','precision',15);
dlmwrite([p10_outcome_data_path 'a08_s03_p10'], ns03_p10_a8 ,'delimiter',',','precision',15);
dlmwrite([p10_outcome_data_path 'a08_s04_p10'], ns04_p10_a8 ,'delimiter',',','precision',15);








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  --  p11 -- %%%%%%%%%%%%%%%%%%%%%



p11_data_path = strcat(datapath,'/p11/p11-HII/');
[p11_s01m, p11_s02m, p11_s03m, p11_s04m, p11_max_length_sensors] = cvs2arrays(p11_data_path);
p11_labels = labels(81:88,:);



p11_windowframe_a1 = p11_labels(1,4):p11_labels(1,5);
p11_windowframe_a2 = p11_labels(2,4):p11_labels(2,5);
p11_windowframe_a3 = p11_labels(3,4):p11_labels(3,5);
p11_windowframe_a4 = p11_labels(4,4):p11_labels(4,5);
p11_windowframe_a5 = p11_labels(5,4):p11_labels(5,5);
p11_windowframe_a6 = p11_labels(6,4):p11_labels(6,5);
p11_windowframe_a7 = p11_labels(7,4):p11_labels(7,5);
%p11_windowframe_a8 HERE IS USED THE MAX LENGTH OF THE TIMESERIES

% CREATE PATH TO SAVE DATA
p11_split_path = strsplit(p11_data_path,'/');
p11_outcome_data_path = strcat(outcomes_path, p11_split_path(09),'/',p11_split_path(10),'/');
p11_outcome_data_path= char(p11_outcome_data_path);
if ~exist(p11_outcome_data_path,'dir');
  {
    myk =  cstrcat('system(',' ''mkdir', ' -p ',p11_outcome_data_path,''')');
    eval( sprintf(myk) );
  }
end




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p11   TIME ALIGNMENT  FOR ACTIVITY _a1   %%%%%%%%%%%%%%%%
windowframe = p11_windowframe_a1;
t1_p11_a1 = p11_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p11_a1 = p11_s02m(windowframe,2);
t3_p11_a1 = p11_s03m(windowframe,2);
t4_p11_a1 = p11_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p11_a1 = p11_s01m(windowframe,3:15);
s2_p11_a1 = p11_s02m(windowframe,3:15);
s3_p11_a1 = p11_s03m(windowframe,3:15);
s4_p11_a1 = p11_s04m(windowframe,3:15);

[ns01_p11_a1, ns02_p11_a1, ns03_p11_a1, ns04_p11_a1] = sensors_timealignment_different_length(
							t1_p11_a1,t2_p11_a1,t3_p11_a1,t4_p11_a1, 
							s1_p11_a1,s2_p11_a1,s3_p11_a1,s4_p11_a1);

%plottingFOURsensors(ns01_p11_a1, ns02_p11_a1, ns03_p11_a1, ns04_p11_a1, 2)

dlmwrite([p11_outcome_data_path 'a01_s01_p11'], ns01_p11_a1 ,'delimiter',',','precision',15);
dlmwrite([p11_outcome_data_path 'a01_s02_p11'], ns02_p11_a1 ,'delimiter',',','precision',15);
dlmwrite([p11_outcome_data_path 'a01_s03_p11'], ns03_p11_a1 ,'delimiter',',','precision',15);
dlmwrite([p11_outcome_data_path 'a01_s04_p11'], ns04_p11_a1 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p11   TIME ALIGNMENT  FOR ACTIVITY _a2   %%%%%%%%%%%%%%%%
windowframe = p11_windowframe_a2;
t1_p11_a2 = p11_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p11_a2 = p11_s02m(windowframe,2);
t3_p11_a2 = p11_s03m(windowframe,2);
t4_p11_a2 = p11_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p11_a2 = p11_s01m(windowframe,3:15);
s2_p11_a2 = p11_s02m(windowframe,3:15);
s3_p11_a2 = p11_s03m(windowframe,3:15);
s4_p11_a2 = p11_s04m(windowframe,3:15);

[ns01_p11_a2, ns02_p11_a2, ns03_p11_a2, ns04_p11_a2] = sensors_timealignment_different_length(
							t1_p11_a2,t2_p11_a2,t3_p11_a2,t4_p11_a2, 
							s1_p11_a2,s2_p11_a2,s3_p11_a2,s4_p11_a2);


%plottingFOURsensors(ns01_p11_a2, ns02_p11_a2, ns03_p11_a2, ns04_p11_a2, 2)

dlmwrite([p11_outcome_data_path 'a02_s01_p11'], ns01_p11_a2 ,'delimiter',',','precision',15);
dlmwrite([p11_outcome_data_path 'a02_s02_p11'], ns02_p11_a2 ,'delimiter',',','precision',15);
dlmwrite([p11_outcome_data_path 'a02_s03_p11'], ns03_p11_a2 ,'delimiter',',','precision',15);
dlmwrite([p11_outcome_data_path 'a02_s04_p11'], ns04_p11_a2 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p11   TIME ALIGNMENT  FOR ACTIVITY _a3   %%%%%%%%%%%%%%%%
windowframe = p11_windowframe_a3;
t1_p11_a3 = p11_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p11_a3 = p11_s02m(windowframe,2);
t3_p11_a3 = p11_s03m(windowframe,2);
t4_p11_a3 = p11_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p11_a3 = p11_s01m(windowframe,3:15);
s2_p11_a3 = p11_s02m(windowframe,3:15);
s3_p11_a3 = p11_s03m(windowframe,3:15);
s4_p11_a3 = p11_s04m(windowframe,3:15);

[ns01_p11_a3, ns02_p11_a3, ns03_p11_a3, ns04_p11_a3] = sensors_timealignment_different_length(
							t1_p11_a3,t2_p11_a3,t3_p11_a3,t4_p11_a3, 
							s1_p11_a3,s2_p11_a3,s3_p11_a3,s4_p11_a3);

%plottingFOURsensors(ns01_p11_a3, ns02_p11_a3, ns03_p11_a3, ns04_p11_a3, 2)

dlmwrite([p11_outcome_data_path 'a03_s01_p11'], ns01_p11_a3 ,'delimiter',',','precision',15);
dlmwrite([p11_outcome_data_path 'a03_s02_p11'], ns02_p11_a3 ,'delimiter',',','precision',15);
dlmwrite([p11_outcome_data_path 'a03_s03_p11'], ns03_p11_a3 ,'delimiter',',','precision',15);
dlmwrite([p11_outcome_data_path 'a03_s04_p11'], ns04_p11_a3 ,'delimiter',',','precision',15);




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p11   TIME ALIGNMENT  FOR ACTIVITY _a4   %%%%%%%%%%%%%%%%
windowframe = p11_windowframe_a4;
t1_p11_a4 = p11_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p11_a4 = p11_s02m(windowframe,2);
t3_p11_a4 = p11_s03m(windowframe,2);
t4_p11_a4 = p11_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p11_a4 = p11_s01m(windowframe,3:15);
s2_p11_a4 = p11_s02m(windowframe,3:15);
s3_p11_a4 = p11_s03m(windowframe,3:15);
s4_p11_a4 = p11_s04m(windowframe,3:15);

[ns01_p11_a4, ns02_p11_a4, ns03_p11_a4, ns04_p11_a4] = sensors_timealignment_different_length(
							t1_p11_a4,t2_p11_a4,t3_p11_a4,t4_p11_a4, 
							s1_p11_a4,s2_p11_a4,s3_p11_a4,s4_p11_a4);

%plottingFOURsensors(ns01_p11_a4, ns02_p11_a4, ns03_p11_a4, ns04_p11_a4, 2)

dlmwrite([p11_outcome_data_path 'a04_s01_p11'], ns01_p11_a4 ,'delimiter',',','precision',15);
dlmwrite([p11_outcome_data_path 'a04_s02_p11'], ns02_p11_a4 ,'delimiter',',','precision',15);
dlmwrite([p11_outcome_data_path 'a04_s03_p11'], ns03_p11_a4 ,'delimiter',',','precision',15);
dlmwrite([p11_outcome_data_path 'a04_s04_p11'], ns04_p11_a4 ,'delimiter',',','precision',15);






% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p11   TIME ALIGNMENT  FOR ACTIVITY _a5   %%%%%%%%%%%%%%%%
windowframe = p11_windowframe_a5;
t1_p11_a5 = p11_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p11_a5 = p11_s02m(windowframe,2);
t3_p11_a5 = p11_s03m(windowframe,2);
t4_p11_a5 = p11_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p11_a5 = p11_s01m(windowframe,3:15);
s2_p11_a5 = p11_s02m(windowframe,3:15);
s3_p11_a5 = p11_s03m(windowframe,3:15);
s4_p11_a5 = p11_s04m(windowframe,3:15);

[ns01_p11_a5, ns02_p11_a5, ns03_p11_a5, ns04_p11_a5] = sensors_timealignment_different_length(
							t1_p11_a5,t2_p11_a5,t3_p11_a5,t4_p11_a5, 
							s1_p11_a5,s2_p11_a5,s3_p11_a5,s4_p11_a5);

%plottingFOURsensors(ns01_p11_a5, ns02_p11_a5, ns03_p11_a5, ns04_p11_a5, 2)

dlmwrite([p11_outcome_data_path 'a05_s01_p11'], ns01_p11_a5 ,'delimiter',',','precision',15);
dlmwrite([p11_outcome_data_path 'a05_s02_p11'], ns02_p11_a5 ,'delimiter',',','precision',15);
dlmwrite([p11_outcome_data_path 'a05_s03_p11'], ns03_p11_a5 ,'delimiter',',','precision',15);
dlmwrite([p11_outcome_data_path 'a05_s04_p11'], ns04_p11_a5 ,'delimiter',',','precision',15);






% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p11   TIME ALIGNMENT  FOR ACTIVITY _a6   %%%%%%%%%%%%%%%%
windowframe = p11_windowframe_a6;
t1_p11_a6 = p11_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p11_a6 = p11_s02m(windowframe,2);
t3_p11_a6 = p11_s03m(windowframe,2);
t4_p11_a6 = p11_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p11_a6 = p11_s01m(windowframe,3:15);
s2_p11_a6 = p11_s02m(windowframe,3:15);
s3_p11_a6 = p11_s03m(windowframe,3:15);
s4_p11_a6 = p11_s04m(windowframe,3:15);

[ns01_p11_a6, ns02_p11_a6, ns03_p11_a6, ns04_p11_a6] = sensors_timealignment_different_length(
							t1_p11_a6,t2_p11_a6,t3_p11_a6,t4_p11_a6, 
							s1_p11_a6,s2_p11_a6,s3_p11_a6,s4_p11_a6);

%plottingFOURsensors(ns01_p11_a6, ns02_p11_a6, ns03_p11_a6, ns04_p11_a6, 2)

dlmwrite([p11_outcome_data_path 'a06_s01_p11'], ns01_p11_a6 ,'delimiter',',','precision',15);
dlmwrite([p11_outcome_data_path 'a06_s02_p11'], ns02_p11_a6 ,'delimiter',',','precision',15);
dlmwrite([p11_outcome_data_path 'a06_s03_p11'], ns03_p11_a6 ,'delimiter',',','precision',15);
dlmwrite([p11_outcome_data_path 'a06_s04_p11'], ns04_p11_a6 ,'delimiter',',','precision',15);







% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p11   TIME ALIGNMENT  FOR ACTIVITY _a7   %%%%%%%%%%%%%%%%
windowframe = p11_windowframe_a7;
t1_p11_a7 = p11_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p11_a7 = p11_s02m(windowframe,2);
t3_p11_a7 = p11_s03m(windowframe,2);
t4_p11_a7 = p11_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p11_a7 = p11_s01m(windowframe,3:15);
s2_p11_a7 = p11_s02m(windowframe,3:15);
s3_p11_a7 = p11_s03m(windowframe,3:15);
s4_p11_a7 = p11_s04m(windowframe,3:15);

[ns01_p11_a7, ns02_p11_a7, ns03_p11_a7, ns04_p11_a7] = sensors_timealignment_different_length(
							t1_p11_a7,t2_p11_a7,t3_p11_a7,t4_p11_a7, 
							s1_p11_a7,s2_p11_a7,s3_p11_a7,s4_p11_a7);

%plottingFOURsensors(ns01_p11_a7, ns02_p11_a7, ns03_p11_a7, ns04_p11_a7, 2)

dlmwrite([p11_outcome_data_path 'a07_s01_p11'], ns01_p11_a7 ,'delimiter',',','precision',15);
dlmwrite([p11_outcome_data_path 'a07_s02_p11'], ns02_p11_a7 ,'delimiter',',','precision',15);
dlmwrite([p11_outcome_data_path 'a07_s03_p11'], ns03_p11_a7 ,'delimiter',',','precision',15);
dlmwrite([p11_outcome_data_path 'a07_s04_p11'], ns04_p11_a7 ,'delimiter',',','precision',15);









% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p11   TIME ALIGNMENT  FOR ACTIVITY _a8   %%%%%%%%%%%%%%%%
t1_p11_a8 = p11_s01m(p11_labels(8,4):p11_max_length_sensors(1),2);   %TimestampTx
t2_p11_a8 = p11_s02m(p11_labels(8,4):p11_max_length_sensors(2),2);
t3_p11_a8 = p11_s03m(p11_labels(8,4):p11_max_length_sensors(3),2);
t4_p11_a8 = p11_s04m(p11_labels(8,4):p11_max_length_sensors(4),2);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p11_a8 = p11_s01m(windowframe,3:15);
s2_p11_a8 = p11_s02m(windowframe,3:15);
s3_p11_a8 = p11_s03m(windowframe,3:15);
s4_p11_a8 = p11_s04m(windowframe,3:15);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p11_a8 = p11_s01m(p11_labels(8,4):p11_max_length_sensors(1),3:15);
s2_p11_a8 = p11_s02m(p11_labels(8,4):p11_max_length_sensors(2),3:15);
s3_p11_a8 = p11_s03m(p11_labels(8,4):p11_max_length_sensors(3),3:15);
s4_p11_a8 = p11_s04m(p11_labels(8,4):p11_max_length_sensors(4),3:15);

[ns01_p11_a8, ns02_p11_a8, ns03_p11_a8, ns04_p11_a8] = sensors_timealignment_different_length(
							t1_p11_a8,t2_p11_a8,t3_p11_a8,t4_p11_a8, 
							s1_p11_a8,s2_p11_a8,s3_p11_a8,s4_p11_a8);

%plottingFOURsensors(ns01_p11_a8, ns02_p11_a8, ns03_p11_a8, ns04_p11_a8, 2)

dlmwrite([p11_outcome_data_path 'a08_s01_p11'], ns01_p11_a8 ,'delimiter',',','precision',15);
dlmwrite([p11_outcome_data_path 'a08_s02_p11'], ns02_p11_a8 ,'delimiter',',','precision',15);
dlmwrite([p11_outcome_data_path 'a08_s03_p11'], ns03_p11_a8 ,'delimiter',',','precision',15);
dlmwrite([p11_outcome_data_path 'a08_s04_p11'], ns04_p11_a8 ,'delimiter',',','precision',15);







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  --  p13 -- %%%%%%%%%%%%%%%%%%%%%



p13_data_path = strcat(datapath,'/p13/p13-HII/');
[p13_s01m, p13_s02m, p13_s03m, p13_s04m, p13_max_length_sensors] = cvs2arrays(p13_data_path);
p13_labels = labels(97:104,:);



p13_windowframe_a1 = p13_labels(1,4):p13_labels(1,5);
p13_windowframe_a2 = p13_labels(2,4):p13_labels(2,5);
p13_windowframe_a3 = p13_labels(3,4):p13_labels(3,5);
p13_windowframe_a4 = p13_labels(4,4):p13_labels(4,5);
p13_windowframe_a5 = p13_labels(5,4):p13_labels(5,5);
p13_windowframe_a6 = p13_labels(6,4):p13_labels(6,5);
p13_windowframe_a7 = p13_labels(7,4):p13_labels(7,5);
%p13_windowframe_a8 HERE IS USED THE MAX LENGTH OF THE TIMESERIES

% CREATE PATH TO SAVE DATA
p13_split_path = strsplit(p13_data_path,'/');
p13_outcome_data_path = strcat(outcomes_path, p13_split_path(09),'/',p13_split_path(10),'/');
p13_outcome_data_path= char(p13_outcome_data_path);
if ~exist(p13_outcome_data_path,'dir');
  {
    myk =  cstrcat('system(',' ''mkdir', ' -p ',p13_outcome_data_path,''')');
    eval( sprintf(myk) );
  }
end





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p13   TIME ALIGNMENT  FOR ACTIVITY _a1   %%%%%%%%%%%%%%%%
windowframe = p13_windowframe_a1;
t1_p13_a1 = p13_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p13_a1 = p13_s02m(windowframe,2);
t3_p13_a1 = p13_s03m(windowframe,2);
t4_p13_a1 = p13_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p13_a1 = p13_s01m(windowframe,3:15);
s2_p13_a1 = p13_s02m(windowframe,3:15);
s3_p13_a1 = p13_s03m(windowframe,3:15);
s4_p13_a1 = p13_s04m(windowframe,3:15);

[ns01_p13_a1, ns02_p13_a1, ns03_p13_a1, ns04_p13_a1] = sensors_timealignment_different_length(
							t1_p13_a1,t2_p13_a1,t3_p13_a1,t4_p13_a1, 
							s1_p13_a1,s2_p13_a1,s3_p13_a1,s4_p13_a1);

%plottingFOURsensors(ns01_p13_a1, ns02_p13_a1, ns03_p13_a1, ns04_p13_a1, 2)

dlmwrite([p13_outcome_data_path 'a01_s01_p13'], ns01_p13_a1 ,'delimiter',',','precision',15);
dlmwrite([p13_outcome_data_path 'a01_s02_p13'], ns02_p13_a1 ,'delimiter',',','precision',15);
dlmwrite([p13_outcome_data_path 'a01_s03_p13'], ns03_p13_a1 ,'delimiter',',','precision',15);
dlmwrite([p13_outcome_data_path 'a01_s04_p13'], ns04_p13_a1 ,'delimiter',',','precision',15);




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p13   TIME ALIGNMENT  FOR ACTIVITY _a2   %%%%%%%%%%%%%%%%
windowframe = p13_windowframe_a2;
t1_p13_a2 = p13_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p13_a2 = p13_s02m(windowframe,2);
t3_p13_a2 = p13_s03m(windowframe,2);
t4_p13_a2 = p13_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p13_a2 = p13_s01m(windowframe,3:15);
s2_p13_a2 = p13_s02m(windowframe,3:15);
s3_p13_a2 = p13_s03m(windowframe,3:15);
s4_p13_a2 = p13_s04m(windowframe,3:15);

[ns01_p13_a2, ns02_p13_a2, ns03_p13_a2, ns04_p13_a2] = sensors_timealignment_different_length(
							t1_p13_a2,t2_p13_a2,t3_p13_a2,t4_p13_a2, 
							s1_p13_a2,s2_p13_a2,s3_p13_a2,s4_p13_a2);


%plottingFOURsensors(ns01_p13_a2, ns02_p13_a2, ns03_p13_a2, ns04_p13_a2, 2)

dlmwrite([p13_outcome_data_path 'a02_s01_p13'], ns01_p13_a2 ,'delimiter',',','precision',15);
dlmwrite([p13_outcome_data_path 'a02_s02_p13'], ns02_p13_a2 ,'delimiter',',','precision',15);
dlmwrite([p13_outcome_data_path 'a02_s03_p13'], ns03_p13_a2 ,'delimiter',',','precision',15);
dlmwrite([p13_outcome_data_path 'a02_s04_p13'], ns04_p13_a2 ,'delimiter',',','precision',15);






% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p13   TIME ALIGNMENT  FOR ACTIVITY _a3   %%%%%%%%%%%%%%%%
windowframe = p13_windowframe_a3;
t1_p13_a3 = p13_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p13_a3 = p13_s02m(windowframe,2);
t3_p13_a3 = p13_s03m(windowframe,2);
t4_p13_a3 = p13_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p13_a3 = p13_s01m(windowframe,3:15);
s2_p13_a3 = p13_s02m(windowframe,3:15);
s3_p13_a3 = p13_s03m(windowframe,3:15);
s4_p13_a3 = p13_s04m(windowframe,3:15);

[ns01_p13_a3, ns02_p13_a3, ns03_p13_a3, ns04_p13_a3] = sensors_timealignment_different_length(
							t1_p13_a3,t2_p13_a3,t3_p13_a3,t4_p13_a3, 
							s1_p13_a3,s2_p13_a3,s3_p13_a3,s4_p13_a3);

%plottingFOURsensors(ns01_p13_a3, ns02_p13_a3, ns03_p13_a3, ns04_p13_a3, 2)

dlmwrite([p13_outcome_data_path 'a03_s01_p13'], ns01_p13_a3 ,'delimiter',',','precision',15);
dlmwrite([p13_outcome_data_path 'a03_s02_p13'], ns02_p13_a3 ,'delimiter',',','precision',15);
dlmwrite([p13_outcome_data_path 'a03_s03_p13'], ns03_p13_a3 ,'delimiter',',','precision',15);
dlmwrite([p13_outcome_data_path 'a03_s04_p13'], ns04_p13_a3 ,'delimiter',',','precision',15);




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p13   TIME ALIGNMENT  FOR ACTIVITY _a4   %%%%%%%%%%%%%%%%
windowframe = p13_windowframe_a4;
t1_p13_a4 = p13_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p13_a4 = p13_s02m(windowframe,2);
t3_p13_a4 = p13_s03m(windowframe,2);
t4_p13_a4 = p13_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p13_a4 = p13_s01m(windowframe,3:15);
s2_p13_a4 = p13_s02m(windowframe,3:15);
s3_p13_a4 = p13_s03m(windowframe,3:15);
s4_p13_a4 = p13_s04m(windowframe,3:15);

[ns01_p13_a4, ns02_p13_a4, ns03_p13_a4, ns04_p13_a4] = sensors_timealignment_different_length(
							t1_p13_a4,t2_p13_a4,t3_p13_a4,t4_p13_a4, 
							s1_p13_a4,s2_p13_a4,s3_p13_a4,s4_p13_a4);

%plottingFOURsensors(ns01_p13_a4, ns02_p13_a4, ns03_p13_a4, ns04_p13_a4, 2)

dlmwrite([p13_outcome_data_path 'a04_s01_p13'], ns01_p13_a4 ,'delimiter',',','precision',15);
dlmwrite([p13_outcome_data_path 'a04_s02_p13'], ns02_p13_a4 ,'delimiter',',','precision',15);
dlmwrite([p13_outcome_data_path 'a04_s03_p13'], ns03_p13_a4 ,'delimiter',',','precision',15);
dlmwrite([p13_outcome_data_path 'a04_s04_p13'], ns04_p13_a4 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p13   TIME ALIGNMENT  FOR ACTIVITY _a5   %%%%%%%%%%%%%%%%
windowframe = p13_windowframe_a5;
t1_p13_a5 = p13_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p13_a5 = p13_s02m(windowframe,2);
t3_p13_a5 = p13_s03m(windowframe,2);
t4_p13_a5 = p13_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p13_a5 = p13_s01m(windowframe,3:15);
s2_p13_a5 = p13_s02m(windowframe,3:15);
s3_p13_a5 = p13_s03m(windowframe,3:15);
s4_p13_a5 = p13_s04m(windowframe,3:15);

[ns01_p13_a5, ns02_p13_a5, ns03_p13_a5, ns04_p13_a5] = sensors_timealignment_different_length(
							t1_p13_a5,t2_p13_a5,t3_p13_a5,t4_p13_a5, 
							s1_p13_a5,s2_p13_a5,s3_p13_a5,s4_p13_a5);

%plottingFOURsensors(ns01_p13_a5, ns02_p13_a5, ns03_p13_a5, ns04_p13_a5, 2)

dlmwrite([p13_outcome_data_path 'a05_s01_p13'], ns01_p13_a5 ,'delimiter',',','precision',15);
dlmwrite([p13_outcome_data_path 'a05_s02_p13'], ns02_p13_a5 ,'delimiter',',','precision',15);
dlmwrite([p13_outcome_data_path 'a05_s03_p13'], ns03_p13_a5 ,'delimiter',',','precision',15);
dlmwrite([p13_outcome_data_path 'a05_s04_p13'], ns04_p13_a5 ,'delimiter',',','precision',15);






% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p13   TIME ALIGNMENT  FOR ACTIVITY _a6   %%%%%%%%%%%%%%%%
windowframe = p13_windowframe_a6;
t1_p13_a6 = p13_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p13_a6 = p13_s02m(windowframe,2);
t3_p13_a6 = p13_s03m(windowframe,2);
t4_p13_a6 = p13_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p13_a6 = p13_s01m(windowframe,3:15);
s2_p13_a6 = p13_s02m(windowframe,3:15);
s3_p13_a6 = p13_s03m(windowframe,3:15);
s4_p13_a6 = p13_s04m(windowframe,3:15);

[ns01_p13_a6, ns02_p13_a6, ns03_p13_a6, ns04_p13_a6] = sensors_timealignment_different_length(
							t1_p13_a6,t2_p13_a6,t3_p13_a6,t4_p13_a6, 
							s1_p13_a6,s2_p13_a6,s3_p13_a6,s4_p13_a6);

%plottingFOURsensors(ns01_p13_a6, ns02_p13_a6, ns03_p13_a6, ns04_p13_a6, 2)

dlmwrite([p13_outcome_data_path 'a06_s01_p13'], ns01_p13_a6 ,'delimiter',',','precision',15);
dlmwrite([p13_outcome_data_path 'a06_s02_p13'], ns02_p13_a6 ,'delimiter',',','precision',15);
dlmwrite([p13_outcome_data_path 'a06_s03_p13'], ns03_p13_a6 ,'delimiter',',','precision',15);
dlmwrite([p13_outcome_data_path 'a06_s04_p13'], ns04_p13_a6 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p13   TIME ALIGNMENT  FOR ACTIVITY _a7   %%%%%%%%%%%%%%%%
windowframe = p13_windowframe_a7;
t1_p13_a7 = p13_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p13_a7 = p13_s02m(windowframe,2);
t3_p13_a7 = p13_s03m(windowframe,2);
t4_p13_a7 = p13_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p13_a7 = p13_s01m(windowframe,3:15);
s2_p13_a7 = p13_s02m(windowframe,3:15);
s3_p13_a7 = p13_s03m(windowframe,3:15);
s4_p13_a7 = p13_s04m(windowframe,3:15);

[ns01_p13_a7, ns02_p13_a7, ns03_p13_a7, ns04_p13_a7] = sensors_timealignment_different_length(
							t1_p13_a7,t2_p13_a7,t3_p13_a7,t4_p13_a7, 
							s1_p13_a7,s2_p13_a7,s3_p13_a7,s4_p13_a7);

%plottingFOURsensors(ns01_p13_a7, ns02_p13_a7, ns03_p13_a7, ns04_p13_a7, 2)

dlmwrite([p13_outcome_data_path 'a07_s01_p13'], ns01_p13_a7 ,'delimiter',',','precision',15);
dlmwrite([p13_outcome_data_path 'a07_s02_p13'], ns02_p13_a7 ,'delimiter',',','precision',15);
dlmwrite([p13_outcome_data_path 'a07_s03_p13'], ns03_p13_a7 ,'delimiter',',','precision',15);
dlmwrite([p13_outcome_data_path 'a07_s04_p13'], ns04_p13_a7 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p13   TIME ALIGNMENT  FOR ACTIVITY _a8   %%%%%%%%%%%%%%%%
t1_p13_a8 = p13_s01m(p13_labels(8,4):p13_max_length_sensors(1),2);   %TimestampTx
t2_p13_a8 = p13_s02m(p13_labels(8,4):p13_max_length_sensors(2),2);
t3_p13_a8 = p13_s03m(p13_labels(8,4):p13_max_length_sensors(3),2);
t4_p13_a8 = p13_s04m(p13_labels(8,4):p13_max_length_sensors(4),2);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p13_a8 = p13_s01m(windowframe,3:15);
s2_p13_a8 = p13_s02m(windowframe,3:15);
s3_p13_a8 = p13_s03m(windowframe,3:15);
s4_p13_a8 = p13_s04m(windowframe,3:15);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p13_a8 = p13_s01m(p13_labels(8,4):p13_max_length_sensors(1),3:15);
s2_p13_a8 = p13_s02m(p13_labels(8,4):p13_max_length_sensors(2),3:15);
s3_p13_a8 = p13_s03m(p13_labels(8,4):p13_max_length_sensors(3),3:15);
s4_p13_a8 = p13_s04m(p13_labels(8,4):p13_max_length_sensors(4),3:15);

[ns01_p13_a8, ns02_p13_a8, ns03_p13_a8, ns04_p13_a8] = sensors_timealignment_different_length(
							t1_p13_a8,t2_p13_a8,t3_p13_a8,t4_p13_a8, 
							s1_p13_a8,s2_p13_a8,s3_p13_a8,s4_p13_a8);

%plottingFOURsensors(ns01_p13_a8, ns02_p13_a8, ns03_p13_a8, ns04_p13_a8, 2)

dlmwrite([p13_outcome_data_path 'a08_s01_p13'], ns01_p13_a8 ,'delimiter',',','precision',15);
dlmwrite([p13_outcome_data_path 'a08_s02_p13'], ns02_p13_a8 ,'delimiter',',','precision',15);
dlmwrite([p13_outcome_data_path 'a08_s03_p13'], ns03_p13_a8 ,'delimiter',',','precision',15);
dlmwrite([p13_outcome_data_path 'a08_s04_p13'], ns04_p13_a8 ,'delimiter',',','precision',15);






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  --  p14 -- %%%%%%%%%%%%%%%%%%%%%



p14_data_path = strcat(datapath,'/p14/p14-HII/');
[p14_s01m, p14_s02m, p14_s03m, p14_s04m, p14_max_length_sensors] = cvs2arrays(p14_data_path);
p14_labels = labels(105:112,:);



p14_windowframe_a1 = p14_labels(1,4):p14_labels(1,5);
p14_windowframe_a2 = p14_labels(2,4):p14_labels(2,5);
p14_windowframe_a3 = p14_labels(3,4):p14_labels(3,5);
p14_windowframe_a4 = p14_labels(4,4):p14_labels(4,5);
p14_windowframe_a5 = p14_labels(5,4):p14_labels(5,5);
p14_windowframe_a6 = p14_labels(6,4):p14_labels(6,5);
p14_windowframe_a7 = p14_labels(7,4):p14_labels(7,5);
%p14_windowframe_a8 HERE IS USED THE MAX LENGTH OF THE TIMESERIES

% CREATE PATH TO SAVE DATA
p14_split_path = strsplit(p14_data_path,'/');
p14_outcome_data_path = strcat(outcomes_path, p14_split_path(09),'/',p14_split_path(10),'/');
p14_outcome_data_path= char(p14_outcome_data_path);
if ~exist(p14_outcome_data_path,'dir');
  {
    myk =  cstrcat('system(',' ''mkdir', ' -p ',p14_outcome_data_path,''')');
    eval( sprintf(myk) );
  }
end





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p14   TIME ALIGNMENT  FOR ACTIVITY _a1   %%%%%%%%%%%%%%%%
windowframe = p14_windowframe_a1;
t1_p14_a1 = p14_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p14_a1 = p14_s02m(windowframe,2);
t3_p14_a1 = p14_s03m(windowframe,2);
t4_p14_a1 = p14_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p14_a1 = p14_s01m(windowframe,3:15);
s2_p14_a1 = p14_s02m(windowframe,3:15);
s3_p14_a1 = p14_s03m(windowframe,3:15);
s4_p14_a1 = p14_s04m(windowframe,3:15);

[ns01_p14_a1, ns02_p14_a1, ns03_p14_a1, ns04_p14_a1] = sensors_timealignment_different_length(
							t1_p14_a1,t2_p14_a1,t3_p14_a1,t4_p14_a1, 
							s1_p14_a1,s2_p14_a1,s3_p14_a1,s4_p14_a1);

%plottingFOURsensors(ns01_p14_a1, ns02_p14_a1, ns03_p14_a1, ns04_p14_a1, 2)

dlmwrite([p14_outcome_data_path 'a01_s01_p14'], ns01_p14_a1 ,'delimiter',',','precision',15);
dlmwrite([p14_outcome_data_path 'a01_s02_p14'], ns02_p14_a1 ,'delimiter',',','precision',15);
dlmwrite([p14_outcome_data_path 'a01_s03_p14'], ns03_p14_a1 ,'delimiter',',','precision',15);
dlmwrite([p14_outcome_data_path 'a01_s04_p14'], ns04_p14_a1 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p14   TIME ALIGNMENT  FOR ACTIVITY _a2   %%%%%%%%%%%%%%%%
windowframe = p14_windowframe_a2;
t1_p14_a2 = p14_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p14_a2 = p14_s02m(windowframe,2);
t3_p14_a2 = p14_s03m(windowframe,2);
t4_p14_a2 = p14_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p14_a2 = p14_s01m(windowframe,3:15);
s2_p14_a2 = p14_s02m(windowframe,3:15);
s3_p14_a2 = p14_s03m(windowframe,3:15);
s4_p14_a2 = p14_s04m(windowframe,3:15);

[ns01_p14_a2, ns02_p14_a2, ns03_p14_a2, ns04_p14_a2] = sensors_timealignment_different_length(
							t1_p14_a2,t2_p14_a2,t3_p14_a2,t4_p14_a2, 
							s1_p14_a2,s2_p14_a2,s3_p14_a2,s4_p14_a2);


%plottingFOURsensors(ns01_p14_a2, ns02_p14_a2, ns03_p14_a2, ns04_p14_a2, 2)

dlmwrite([p14_outcome_data_path 'a02_s01_p14'], ns01_p14_a2 ,'delimiter',',','precision',15);
dlmwrite([p14_outcome_data_path 'a02_s02_p14'], ns02_p14_a2 ,'delimiter',',','precision',15);
dlmwrite([p14_outcome_data_path 'a02_s03_p14'], ns03_p14_a2 ,'delimiter',',','precision',15);
dlmwrite([p14_outcome_data_path 'a02_s04_p14'], ns04_p14_a2 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p14   TIME ALIGNMENT  FOR ACTIVITY _a3   %%%%%%%%%%%%%%%%
windowframe = p14_windowframe_a3;
t1_p14_a3 = p14_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p14_a3 = p14_s02m(windowframe,2);
t3_p14_a3 = p14_s03m(windowframe,2);
t4_p14_a3 = p14_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p14_a3 = p14_s01m(windowframe,3:15);
s2_p14_a3 = p14_s02m(windowframe,3:15);
s3_p14_a3 = p14_s03m(windowframe,3:15);
s4_p14_a3 = p14_s04m(windowframe,3:15);

[ns01_p14_a3, ns02_p14_a3, ns03_p14_a3, ns04_p14_a3] = sensors_timealignment_different_length(
							t1_p14_a3,t2_p14_a3,t3_p14_a3,t4_p14_a3, 
							s1_p14_a3,s2_p14_a3,s3_p14_a3,s4_p14_a3);

%plottingFOURsensors(ns01_p14_a3, ns02_p14_a3, ns03_p14_a3, ns04_p14_a3, 2)

dlmwrite([p14_outcome_data_path 'a03_s01_p14'], ns01_p14_a3 ,'delimiter',',','precision',15);
dlmwrite([p14_outcome_data_path 'a03_s02_p14'], ns02_p14_a3 ,'delimiter',',','precision',15);
dlmwrite([p14_outcome_data_path 'a03_s03_p14'], ns03_p14_a3 ,'delimiter',',','precision',15);
dlmwrite([p14_outcome_data_path 'a03_s04_p14'], ns04_p14_a3 ,'delimiter',',','precision',15);




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p14   TIME ALIGNMENT  FOR ACTIVITY _a4   %%%%%%%%%%%%%%%%
windowframe = p14_windowframe_a4;
t1_p14_a4 = p14_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p14_a4 = p14_s02m(windowframe,2);
t3_p14_a4 = p14_s03m(windowframe,2);
t4_p14_a4 = p14_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p14_a4 = p14_s01m(windowframe,3:15);
s2_p14_a4 = p14_s02m(windowframe,3:15);
s3_p14_a4 = p14_s03m(windowframe,3:15);
s4_p14_a4 = p14_s04m(windowframe,3:15);

[ns01_p14_a4, ns02_p14_a4, ns03_p14_a4, ns04_p14_a4] = sensors_timealignment_different_length(
							t1_p14_a4,t2_p14_a4,t3_p14_a4,t4_p14_a4, 
							s1_p14_a4,s2_p14_a4,s3_p14_a4,s4_p14_a4);

%plottingFOURsensors(ns01_p14_a4, ns02_p14_a4, ns03_p14_a4, ns04_p14_a4, 2)

dlmwrite([p14_outcome_data_path 'a04_s01_p14'], ns01_p14_a4 ,'delimiter',',','precision',15);
dlmwrite([p14_outcome_data_path 'a04_s02_p14'], ns02_p14_a4 ,'delimiter',',','precision',15);
dlmwrite([p14_outcome_data_path 'a04_s03_p14'], ns03_p14_a4 ,'delimiter',',','precision',15);
dlmwrite([p14_outcome_data_path 'a04_s04_p14'], ns04_p14_a4 ,'delimiter',',','precision',15);




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p14   TIME ALIGNMENT  FOR ACTIVITY _a5   %%%%%%%%%%%%%%%%
windowframe = p14_windowframe_a5;
t1_p14_a5 = p14_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p14_a5 = p14_s02m(windowframe,2);
t3_p14_a5 = p14_s03m(windowframe,2);
t4_p14_a5 = p14_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p14_a5 = p14_s01m(windowframe,3:15);
s2_p14_a5 = p14_s02m(windowframe,3:15);
s3_p14_a5 = p14_s03m(windowframe,3:15);
s4_p14_a5 = p14_s04m(windowframe,3:15);

[ns01_p14_a5, ns02_p14_a5, ns03_p14_a5, ns04_p14_a5] = sensors_timealignment_different_length(
							t1_p14_a5,t2_p14_a5,t3_p14_a5,t4_p14_a5, 
							s1_p14_a5,s2_p14_a5,s3_p14_a5,s4_p14_a5);

%plottingFOURsensors(ns01_p14_a5, ns02_p14_a5, ns03_p14_a5, ns04_p14_a5, 2)

dlmwrite([p14_outcome_data_path 'a05_s01_p14'], ns01_p14_a5 ,'delimiter',',','precision',15);
dlmwrite([p14_outcome_data_path 'a05_s02_p14'], ns02_p14_a5 ,'delimiter',',','precision',15);
dlmwrite([p14_outcome_data_path 'a05_s03_p14'], ns03_p14_a5 ,'delimiter',',','precision',15);
dlmwrite([p14_outcome_data_path 'a05_s04_p14'], ns04_p14_a5 ,'delimiter',',','precision',15);






% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p14   TIME ALIGNMENT  FOR ACTIVITY _a6   %%%%%%%%%%%%%%%%
windowframe = p14_windowframe_a6;
t1_p14_a6 = p14_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p14_a6 = p14_s02m(windowframe,2);
t3_p14_a6 = p14_s03m(windowframe,2);
t4_p14_a6 = p14_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p14_a6 = p14_s01m(windowframe,3:15);
s2_p14_a6 = p14_s02m(windowframe,3:15);
s3_p14_a6 = p14_s03m(windowframe,3:15);
s4_p14_a6 = p14_s04m(windowframe,3:15);

[ns01_p14_a6, ns02_p14_a6, ns03_p14_a6, ns04_p14_a6] = sensors_timealignment_different_length(
							t1_p14_a6,t2_p14_a6,t3_p14_a6,t4_p14_a6, 
							s1_p14_a6,s2_p14_a6,s3_p14_a6,s4_p14_a6);

%plottingFOURsensors(ns01_p14_a6, ns02_p14_a6, ns03_p14_a6, ns04_p14_a6, 2)

dlmwrite([p14_outcome_data_path 'a06_s01_p14'], ns01_p14_a6 ,'delimiter',',','precision',15);
dlmwrite([p14_outcome_data_path 'a06_s02_p14'], ns02_p14_a6 ,'delimiter',',','precision',15);
dlmwrite([p14_outcome_data_path 'a06_s03_p14'], ns03_p14_a6 ,'delimiter',',','precision',15);
dlmwrite([p14_outcome_data_path 'a06_s04_p14'], ns04_p14_a6 ,'delimiter',',','precision',15);







% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p14   TIME ALIGNMENT  FOR ACTIVITY _a7   %%%%%%%%%%%%%%%%
windowframe = p14_windowframe_a7;
t1_p14_a7 = p14_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p14_a7 = p14_s02m(windowframe,2);
t3_p14_a7 = p14_s03m(windowframe,2);
t4_p14_a7 = p14_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p14_a7 = p14_s01m(windowframe,3:15);
s2_p14_a7 = p14_s02m(windowframe,3:15);
s3_p14_a7 = p14_s03m(windowframe,3:15);
s4_p14_a7 = p14_s04m(windowframe,3:15);

[ns01_p14_a7, ns02_p14_a7, ns03_p14_a7, ns04_p14_a7] = sensors_timealignment_different_length(
							t1_p14_a7,t2_p14_a7,t3_p14_a7,t4_p14_a7, 
							s1_p14_a7,s2_p14_a7,s3_p14_a7,s4_p14_a7);

%plottingFOURsensors(ns01_p14_a7, ns02_p14_a7, ns03_p14_a7, ns04_p14_a7, 2)

dlmwrite([p14_outcome_data_path 'a07_s01_p14'], ns01_p14_a7 ,'delimiter',',','precision',15);
dlmwrite([p14_outcome_data_path 'a07_s02_p14'], ns02_p14_a7 ,'delimiter',',','precision',15);
dlmwrite([p14_outcome_data_path 'a07_s03_p14'], ns03_p14_a7 ,'delimiter',',','precision',15);
dlmwrite([p14_outcome_data_path 'a07_s04_p14'], ns04_p14_a7 ,'delimiter',',','precision',15);









% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p14   TIME ALIGNMENT  FOR ACTIVITY _a8   %%%%%%%%%%%%%%%%
t1_p14_a8 = p14_s01m(p14_labels(8,4):p14_max_length_sensors(1),2);   %TimestampTx
t2_p14_a8 = p14_s02m(p14_labels(8,4):p14_max_length_sensors(2),2);
t3_p14_a8 = p14_s03m(p14_labels(8,4):p14_max_length_sensors(3),2);
t4_p14_a8 = p14_s04m(p14_labels(8,4):p14_max_length_sensors(4),2);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p14_a8 = p14_s01m(windowframe,3:15);
s2_p14_a8 = p14_s02m(windowframe,3:15);
s3_p14_a8 = p14_s03m(windowframe,3:15);
s4_p14_a8 = p14_s04m(windowframe,3:15);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p14_a8 = p14_s01m(p14_labels(8,4):p14_max_length_sensors(1),3:15);
s2_p14_a8 = p14_s02m(p14_labels(8,4):p14_max_length_sensors(2),3:15);
s3_p14_a8 = p14_s03m(p14_labels(8,4):p14_max_length_sensors(3),3:15);
s4_p14_a8 = p14_s04m(p14_labels(8,4):p14_max_length_sensors(4),3:15);

[ns01_p14_a8, ns02_p14_a8, ns03_p14_a8, ns04_p14_a8] = sensors_timealignment_different_length(
							t1_p14_a8,t2_p14_a8,t3_p14_a8,t4_p14_a8, 
							s1_p14_a8,s2_p14_a8,s3_p14_a8,s4_p14_a8);

%plottingFOURsensors(ns01_p14_a8, ns02_p14_a8, ns03_p14_a8, ns04_p14_a8, 2)

dlmwrite([p14_outcome_data_path 'a08_s01_p14'], ns01_p14_a8 ,'delimiter',',','precision',15);
dlmwrite([p14_outcome_data_path 'a08_s02_p14'], ns02_p14_a8 ,'delimiter',',','precision',15);
dlmwrite([p14_outcome_data_path 'a08_s03_p14'], ns03_p14_a8 ,'delimiter',',','precision',15);
dlmwrite([p14_outcome_data_path 'a08_s04_p14'], ns04_p14_a8 ,'delimiter',',','precision',15);




%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  --  p15 -- %%%%%%%%%%%%%%%%%%%%%



p15_data_path = strcat(datapath,'/p15/p15-HII/');
[p15_s01m, p15_s02m, p15_s03m, p15_s04m, p15_max_length_sensors] = cvs2arrays(p15_data_path);
p15_labels = labels(113:120,:);



p15_windowframe_a1 = p15_labels(1,4):p15_labels(1,5);
p15_windowframe_a2 = p15_labels(2,4):p15_labels(2,5);
p15_windowframe_a3 = p15_labels(3,4):p15_labels(3,5);
p15_windowframe_a4 = p15_labels(4,4):p15_labels(4,5);
p15_windowframe_a5 = p15_labels(5,4):p15_labels(5,5);
p15_windowframe_a6 = p15_labels(6,4):p15_labels(6,5);
p15_windowframe_a7 = p15_labels(7,4):p15_labels(7,5);
%p15_windowframe_a8 HERE IS USED THE MAX LENGTH OF THE TIMESERIES

% CREATE PATH TO SAVE DATA
p15_split_path = strsplit(p15_data_path,'/');
p15_outcome_data_path = strcat(outcomes_path, p15_split_path(09),'/',p15_split_path(10),'/');
p15_outcome_data_path= char(p15_outcome_data_path);
if ~exist(p15_outcome_data_path,'dir');
  {
    myk =  cstrcat('system(',' ''mkdir', ' -p ',p15_outcome_data_path,''')');
    eval( sprintf(myk) );
  }
end




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p15   TIME ALIGNMENT  FOR ACTIVITY _a1   %%%%%%%%%%%%%%%%
windowframe = p15_windowframe_a1;
t1_p15_a1 = p15_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p15_a1 = p15_s02m(windowframe,2);
t3_p15_a1 = p15_s03m(windowframe,2);
t4_p15_a1 = p15_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p15_a1 = p15_s01m(windowframe,3:15);
s2_p15_a1 = p15_s02m(windowframe,3:15);
s3_p15_a1 = p15_s03m(windowframe,3:15);
s4_p15_a1 = p15_s04m(windowframe,3:15);

[ns01_p15_a1, ns02_p15_a1, ns03_p15_a1, ns04_p15_a1] = sensors_timealignment_different_length(
							t1_p15_a1,t2_p15_a1,t3_p15_a1,t4_p15_a1, 
							s1_p15_a1,s2_p15_a1,s3_p15_a1,s4_p15_a1);

%plottingFOURsensors(ns01_p15_a1, ns02_p15_a1, ns03_p15_a1, ns04_p15_a1, 2)

dlmwrite([p15_outcome_data_path 'a01_s01_p15'], ns01_p15_a1 ,'delimiter',',','precision',15);
dlmwrite([p15_outcome_data_path 'a01_s02_p15'], ns02_p15_a1 ,'delimiter',',','precision',15);
dlmwrite([p15_outcome_data_path 'a01_s03_p15'], ns03_p15_a1 ,'delimiter',',','precision',15);
dlmwrite([p15_outcome_data_path 'a01_s04_p15'], ns04_p15_a1 ,'delimiter',',','precision',15);




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p15   TIME ALIGNMENT  FOR ACTIVITY _a2   %%%%%%%%%%%%%%%%
windowframe = p15_windowframe_a2;
t1_p15_a2 = p15_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p15_a2 = p15_s02m(windowframe,2);
t3_p15_a2 = p15_s03m(windowframe,2);
t4_p15_a2 = p15_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p15_a2 = p15_s01m(windowframe,3:15);
s2_p15_a2 = p15_s02m(windowframe,3:15);
s3_p15_a2 = p15_s03m(windowframe,3:15);
s4_p15_a2 = p15_s04m(windowframe,3:15);

[ns01_p15_a2, ns02_p15_a2, ns03_p15_a2, ns04_p15_a2] = sensors_timealignment_different_length(
							t1_p15_a2,t2_p15_a2,t3_p15_a2,t4_p15_a2, 
							s1_p15_a2,s2_p15_a2,s3_p15_a2,s4_p15_a2);


%plottingFOURsensors(ns01_p15_a2, ns02_p15_a2, ns03_p15_a2, ns04_p15_a2, 2)

dlmwrite([p15_outcome_data_path 'a02_s01_p15'], ns01_p15_a2 ,'delimiter',',','precision',15);
dlmwrite([p15_outcome_data_path 'a02_s02_p15'], ns02_p15_a2 ,'delimiter',',','precision',15);
dlmwrite([p15_outcome_data_path 'a02_s03_p15'], ns03_p15_a2 ,'delimiter',',','precision',15);
dlmwrite([p15_outcome_data_path 'a02_s04_p15'], ns04_p15_a2 ,'delimiter',',','precision',15);







% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p15   TIME ALIGNMENT  FOR ACTIVITY _a3   %%%%%%%%%%%%%%%%
windowframe = p15_windowframe_a3;
t1_p15_a3 = p15_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p15_a3 = p15_s02m(windowframe,2);
t3_p15_a3 = p15_s03m(windowframe,2);
t4_p15_a3 = p15_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p15_a3 = p15_s01m(windowframe,3:15);
s2_p15_a3 = p15_s02m(windowframe,3:15);
s3_p15_a3 = p15_s03m(windowframe,3:15);
s4_p15_a3 = p15_s04m(windowframe,3:15);

[ns01_p15_a3, ns02_p15_a3, ns03_p15_a3, ns04_p15_a3] = sensors_timealignment_different_length(
							t1_p15_a3,t2_p15_a3,t3_p15_a3,t4_p15_a3, 
							s1_p15_a3,s2_p15_a3,s3_p15_a3,s4_p15_a3);

%plottingFOURsensors(ns01_p15_a3, ns02_p15_a3, ns03_p15_a3, ns04_p15_a3, 2)

dlmwrite([p15_outcome_data_path 'a03_s01_p15'], ns01_p15_a3 ,'delimiter',',','precision',15);
dlmwrite([p15_outcome_data_path 'a03_s02_p15'], ns02_p15_a3 ,'delimiter',',','precision',15);
dlmwrite([p15_outcome_data_path 'a03_s03_p15'], ns03_p15_a3 ,'delimiter',',','precision',15);
dlmwrite([p15_outcome_data_path 'a03_s04_p15'], ns04_p15_a3 ,'delimiter',',','precision',15);




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p15   TIME ALIGNMENT  FOR ACTIVITY _a4   %%%%%%%%%%%%%%%%
windowframe = p15_windowframe_a4;
t1_p15_a4 = p15_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p15_a4 = p15_s02m(windowframe,2);
t3_p15_a4 = p15_s03m(windowframe,2);
t4_p15_a4 = p15_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p15_a4 = p15_s01m(windowframe,3:15);
s2_p15_a4 = p15_s02m(windowframe,3:15);
s3_p15_a4 = p15_s03m(windowframe,3:15);
s4_p15_a4 = p15_s04m(windowframe,3:15);

[ns01_p15_a4, ns02_p15_a4, ns03_p15_a4, ns04_p15_a4] = sensors_timealignment_different_length(
							t1_p15_a4,t2_p15_a4,t3_p15_a4,t4_p15_a4, 
							s1_p15_a4,s2_p15_a4,s3_p15_a4,s4_p15_a4);

%plottingFOURsensors(ns01_p15_a4, ns02_p15_a4, ns03_p15_a4, ns04_p15_a4, 2)

dlmwrite([p15_outcome_data_path 'a04_s01_p15'], ns01_p15_a4 ,'delimiter',',','precision',15);
dlmwrite([p15_outcome_data_path 'a04_s02_p15'], ns02_p15_a4 ,'delimiter',',','precision',15);
dlmwrite([p15_outcome_data_path 'a04_s03_p15'], ns03_p15_a4 ,'delimiter',',','precision',15);
dlmwrite([p15_outcome_data_path 'a04_s04_p15'], ns04_p15_a4 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p15   TIME ALIGNMENT  FOR ACTIVITY _a5   %%%%%%%%%%%%%%%%
windowframe = p15_windowframe_a5;
t1_p15_a5 = p15_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p15_a5 = p15_s02m(windowframe,2);
t3_p15_a5 = p15_s03m(windowframe,2);
t4_p15_a5 = p15_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p15_a5 = p15_s01m(windowframe,3:15);
s2_p15_a5 = p15_s02m(windowframe,3:15);
s3_p15_a5 = p15_s03m(windowframe,3:15);
s4_p15_a5 = p15_s04m(windowframe,3:15);

[ns01_p15_a5, ns02_p15_a5, ns03_p15_a5, ns04_p15_a5] = sensors_timealignment_different_length(
							t1_p15_a5,t2_p15_a5,t3_p15_a5,t4_p15_a5, 
							s1_p15_a5,s2_p15_a5,s3_p15_a5,s4_p15_a5);

%plottingFOURsensors(ns01_p15_a5, ns02_p15_a5, ns03_p15_a5, ns04_p15_a5, 2)

dlmwrite([p15_outcome_data_path 'a05_s01_p15'], ns01_p15_a5 ,'delimiter',',','precision',15);
dlmwrite([p15_outcome_data_path 'a05_s02_p15'], ns02_p15_a5 ,'delimiter',',','precision',15);
dlmwrite([p15_outcome_data_path 'a05_s03_p15'], ns03_p15_a5 ,'delimiter',',','precision',15);
dlmwrite([p15_outcome_data_path 'a05_s04_p15'], ns04_p15_a5 ,'delimiter',',','precision',15);






% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p15   TIME ALIGNMENT  FOR ACTIVITY _a6   %%%%%%%%%%%%%%%%
windowframe = p15_windowframe_a6;
t1_p15_a6 = p15_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p15_a6 = p15_s02m(windowframe,2);
t3_p15_a6 = p15_s03m(windowframe,2);
t4_p15_a6 = p15_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p15_a6 = p15_s01m(windowframe,3:15);
s2_p15_a6 = p15_s02m(windowframe,3:15);
s3_p15_a6 = p15_s03m(windowframe,3:15);
s4_p15_a6 = p15_s04m(windowframe,3:15);

[ns01_p15_a6, ns02_p15_a6, ns03_p15_a6, ns04_p15_a6] = sensors_timealignment_different_length(
							t1_p15_a6,t2_p15_a6,t3_p15_a6,t4_p15_a6, 
							s1_p15_a6,s2_p15_a6,s3_p15_a6,s4_p15_a6);

%plottingFOURsensors(ns01_p15_a6, ns02_p15_a6, ns03_p15_a6, ns04_p15_a6, 2)

dlmwrite([p15_outcome_data_path 'a06_s01_p15'], ns01_p15_a6 ,'delimiter',',','precision',15);
dlmwrite([p15_outcome_data_path 'a06_s02_p15'], ns02_p15_a6 ,'delimiter',',','precision',15);
dlmwrite([p15_outcome_data_path 'a06_s03_p15'], ns03_p15_a6 ,'delimiter',',','precision',15);
dlmwrite([p15_outcome_data_path 'a06_s04_p15'], ns04_p15_a6 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p15   TIME ALIGNMENT  FOR ACTIVITY _a7   %%%%%%%%%%%%%%%%
windowframe = p15_windowframe_a7;
t1_p15_a7 = p15_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p15_a7 = p15_s02m(windowframe,2);
t3_p15_a7 = p15_s03m(windowframe,2);
t4_p15_a7 = p15_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p15_a7 = p15_s01m(windowframe,3:15);
s2_p15_a7 = p15_s02m(windowframe,3:15);
s3_p15_a7 = p15_s03m(windowframe,3:15);
s4_p15_a7 = p15_s04m(windowframe,3:15);

[ns01_p15_a7, ns02_p15_a7, ns03_p15_a7, ns04_p15_a7] = sensors_timealignment_different_length(
							t1_p15_a7,t2_p15_a7,t3_p15_a7,t4_p15_a7, 
							s1_p15_a7,s2_p15_a7,s3_p15_a7,s4_p15_a7);

%plottingFOURsensors(ns01_p15_a7, ns02_p15_a7, ns03_p15_a7, ns04_p15_a7, 2)

dlmwrite([p15_outcome_data_path 'a07_s01_p15'], ns01_p15_a7 ,'delimiter',',','precision',15);
dlmwrite([p15_outcome_data_path 'a07_s02_p15'], ns02_p15_a7 ,'delimiter',',','precision',15);
dlmwrite([p15_outcome_data_path 'a07_s03_p15'], ns03_p15_a7 ,'delimiter',',','precision',15);
dlmwrite([p15_outcome_data_path 'a07_s04_p15'], ns04_p15_a7 ,'delimiter',',','precision',15);









% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p15   TIME ALIGNMENT  FOR ACTIVITY _a8   %%%%%%%%%%%%%%%%
t1_p15_a8 = p15_s01m(p15_labels(8,4):p15_max_length_sensors(1),2);   %TimestampTx
t2_p15_a8 = p15_s02m(p15_labels(8,4):p15_max_length_sensors(2),2);
t3_p15_a8 = p15_s03m(p15_labels(8,4):p15_max_length_sensors(3),2);
t4_p15_a8 = p15_s04m(p15_labels(8,4):p15_max_length_sensors(4),2);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p15_a8 = p15_s01m(windowframe,3:15);
s2_p15_a8 = p15_s02m(windowframe,3:15);
s3_p15_a8 = p15_s03m(windowframe,3:15);
s4_p15_a8 = p15_s04m(windowframe,3:15);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p15_a8 = p15_s01m(p15_labels(8,4):p15_max_length_sensors(1),3:15);
s2_p15_a8 = p15_s02m(p15_labels(8,4):p15_max_length_sensors(2),3:15);
s3_p15_a8 = p15_s03m(p15_labels(8,4):p15_max_length_sensors(3),3:15);
s4_p15_a8 = p15_s04m(p15_labels(8,4):p15_max_length_sensors(4),3:15);

[ns01_p15_a8, ns02_p15_a8, ns03_p15_a8, ns04_p15_a8] = sensors_timealignment_different_length(
							t1_p15_a8,t2_p15_a8,t3_p15_a8,t4_p15_a8, 
							s1_p15_a8,s2_p15_a8,s3_p15_a8,s4_p15_a8);

%plottingFOURsensors(ns01_p15_a8, ns02_p15_a8, ns03_p15_a8, ns04_p15_a8, 2)

dlmwrite([p15_outcome_data_path 'a08_s01_p15'], ns01_p15_a8 ,'delimiter',',','precision',15);
dlmwrite([p15_outcome_data_path 'a08_s02_p15'], ns02_p15_a8 ,'delimiter',',','precision',15);
dlmwrite([p15_outcome_data_path 'a08_s03_p15'], ns03_p15_a8 ,'delimiter',',','precision',15);
dlmwrite([p15_outcome_data_path 'a08_s04_p15'], ns04_p15_a8 ,'delimiter',',','precision',15);





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  --  p16 -- %%%%%%%%%%%%%%%%%%%%%



p16_data_path = strcat(datapath,'/p16/p16-HII/');
[p16_s01m, p16_s02m, p16_s03m, p16_s04m, p16_max_length_sensors] = cvs2arrays(p16_data_path);
p16_labels = labels(121:128,:);



p16_windowframe_a1 = p16_labels(1,4):p16_labels(1,5);
p16_windowframe_a2 = p16_labels(2,4):p16_labels(2,5);
p16_windowframe_a3 = p16_labels(3,4):p16_labels(3,5);
p16_windowframe_a4 = p16_labels(4,4):p16_labels(4,5);
p16_windowframe_a5 = p16_labels(5,4):p16_labels(5,5);
p16_windowframe_a6 = p16_labels(6,4):p16_labels(6,5);
p16_windowframe_a7 = p16_labels(7,4):p16_labels(7,5);
%p16_windowframe_a8 HERE IS USED THE MAX LENGTH OF THE TIMESERIES

% CREATE PATH TO SAVE DATA
p16_split_path = strsplit(p16_data_path,'/');
p16_outcome_data_path = strcat(outcomes_path, p16_split_path(09),'/',p16_split_path(10),'/');
p16_outcome_data_path= char(p16_outcome_data_path);
if ~exist(p16_outcome_data_path,'dir');
  {
    myk =  cstrcat('system(',' ''mkdir', ' -p ',p16_outcome_data_path,''')');
    eval( sprintf(myk) );
  }
end



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p16   TIME ALIGNMENT  FOR ACTIVITY _a1   %%%%%%%%%%%%%%%%
windowframe = p16_windowframe_a1;
t1_p16_a1 = p16_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p16_a1 = p16_s02m(windowframe,2);
t3_p16_a1 = p16_s03m(windowframe,2);
t4_p16_a1 = p16_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p16_a1 = p16_s01m(windowframe,3:15);
s2_p16_a1 = p16_s02m(windowframe,3:15);
s3_p16_a1 = p16_s03m(windowframe,3:15);
s4_p16_a1 = p16_s04m(windowframe,3:15);

[ns01_p16_a1, ns02_p16_a1, ns03_p16_a1, ns04_p16_a1] = sensors_timealignment_different_length(
							t1_p16_a1,t2_p16_a1,t3_p16_a1,t4_p16_a1, 
							s1_p16_a1,s2_p16_a1,s3_p16_a1,s4_p16_a1);

%plottingFOURsensors(ns01_p16_a1, ns02_p16_a1, ns03_p16_a1, ns04_p16_a1, 2)

dlmwrite([p16_outcome_data_path 'a01_s01_p16'], ns01_p16_a1 ,'delimiter',',','precision',15);
dlmwrite([p16_outcome_data_path 'a01_s02_p16'], ns02_p16_a1 ,'delimiter',',','precision',15);
dlmwrite([p16_outcome_data_path 'a01_s03_p16'], ns03_p16_a1 ,'delimiter',',','precision',15);
dlmwrite([p16_outcome_data_path 'a01_s04_p16'], ns04_p16_a1 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p16   TIME ALIGNMENT  FOR ACTIVITY _a2   %%%%%%%%%%%%%%%%
windowframe = p16_windowframe_a2;
t1_p16_a2 = p16_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p16_a2 = p16_s02m(windowframe,2);
t3_p16_a2 = p16_s03m(windowframe,2);
t4_p16_a2 = p16_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p16_a2 = p16_s01m(windowframe,3:15);
s2_p16_a2 = p16_s02m(windowframe,3:15);
s3_p16_a2 = p16_s03m(windowframe,3:15);
s4_p16_a2 = p16_s04m(windowframe,3:15);

[ns01_p16_a2, ns02_p16_a2, ns03_p16_a2, ns04_p16_a2] = sensors_timealignment_different_length(
							t1_p16_a2,t2_p16_a2,t3_p16_a2,t4_p16_a2, 
							s1_p16_a2,s2_p16_a2,s3_p16_a2,s4_p16_a2);


%plottingFOURsensors(ns01_p16_a2, ns02_p16_a2, ns03_p16_a2, ns04_p16_a2, 2)

dlmwrite([p16_outcome_data_path 'a02_s01_p16'], ns01_p16_a2 ,'delimiter',',','precision',15);
dlmwrite([p16_outcome_data_path 'a02_s02_p16'], ns02_p16_a2 ,'delimiter',',','precision',15);
dlmwrite([p16_outcome_data_path 'a02_s03_p16'], ns03_p16_a2 ,'delimiter',',','precision',15);
dlmwrite([p16_outcome_data_path 'a02_s04_p16'], ns04_p16_a2 ,'delimiter',',','precision',15);







% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p16   TIME ALIGNMENT  FOR ACTIVITY _a3   %%%%%%%%%%%%%%%%
windowframe = p16_windowframe_a3;
t1_p16_a3 = p16_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p16_a3 = p16_s02m(windowframe,2);
t3_p16_a3 = p16_s03m(windowframe,2);
t4_p16_a3 = p16_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p16_a3 = p16_s01m(windowframe,3:15);
s2_p16_a3 = p16_s02m(windowframe,3:15);
s3_p16_a3 = p16_s03m(windowframe,3:15);
s4_p16_a3 = p16_s04m(windowframe,3:15);

[ns01_p16_a3, ns02_p16_a3, ns03_p16_a3, ns04_p16_a3] = sensors_timealignment_different_length(
							t1_p16_a3,t2_p16_a3,t3_p16_a3,t4_p16_a3, 
							s1_p16_a3,s2_p16_a3,s3_p16_a3,s4_p16_a3);

%plottingFOURsensors(ns01_p16_a3, ns02_p16_a3, ns03_p16_a3, ns04_p16_a3, 2)

dlmwrite([p16_outcome_data_path 'a03_s01_p16'], ns01_p16_a3 ,'delimiter',',','precision',15);
dlmwrite([p16_outcome_data_path 'a03_s02_p16'], ns02_p16_a3 ,'delimiter',',','precision',15);
dlmwrite([p16_outcome_data_path 'a03_s03_p16'], ns03_p16_a3 ,'delimiter',',','precision',15);
dlmwrite([p16_outcome_data_path 'a03_s04_p16'], ns04_p16_a3 ,'delimiter',',','precision',15);



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p16   TIME ALIGNMENT  FOR ACTIVITY _a4   %%%%%%%%%%%%%%%%
windowframe = p16_windowframe_a4;
t1_p16_a4 = p16_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p16_a4 = p16_s02m(windowframe,2);
t3_p16_a4 = p16_s03m(windowframe,2);
t4_p16_a4 = p16_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p16_a4 = p16_s01m(windowframe,3:15);
s2_p16_a4 = p16_s02m(windowframe,3:15);
s3_p16_a4 = p16_s03m(windowframe,3:15);
s4_p16_a4 = p16_s04m(windowframe,3:15);

[ns01_p16_a4, ns02_p16_a4, ns03_p16_a4, ns04_p16_a4] = sensors_timealignment_different_length(
							t1_p16_a4,t2_p16_a4,t3_p16_a4,t4_p16_a4, 
							s1_p16_a4,s2_p16_a4,s3_p16_a4,s4_p16_a4);

%plottingFOURsensors(ns01_p16_a4, ns02_p16_a4, ns03_p16_a4, ns04_p16_a4, 2)

dlmwrite([p16_outcome_data_path 'a04_s01_p16'], ns01_p16_a4 ,'delimiter',',','precision',15);
dlmwrite([p16_outcome_data_path 'a04_s02_p16'], ns02_p16_a4 ,'delimiter',',','precision',15);
dlmwrite([p16_outcome_data_path 'a04_s03_p16'], ns03_p16_a4 ,'delimiter',',','precision',15);
dlmwrite([p16_outcome_data_path 'a04_s04_p16'], ns04_p16_a4 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p16   TIME ALIGNMENT  FOR ACTIVITY _a5   %%%%%%%%%%%%%%%%
windowframe = p16_windowframe_a5;
t1_p16_a5 = p16_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p16_a5 = p16_s02m(windowframe,2);
t3_p16_a5 = p16_s03m(windowframe,2);
t4_p16_a5 = p16_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p16_a5 = p16_s01m(windowframe,3:15);
s2_p16_a5 = p16_s02m(windowframe,3:15);
s3_p16_a5 = p16_s03m(windowframe,3:15);
s4_p16_a5 = p16_s04m(windowframe,3:15);

[ns01_p16_a5, ns02_p16_a5, ns03_p16_a5, ns04_p16_a5] = sensors_timealignment_different_length(
							t1_p16_a5,t2_p16_a5,t3_p16_a5,t4_p16_a5, 
							s1_p16_a5,s2_p16_a5,s3_p16_a5,s4_p16_a5);

%plottingFOURsensors(ns01_p16_a5, ns02_p16_a5, ns03_p16_a5, ns04_p16_a5, 2)

dlmwrite([p16_outcome_data_path 'a05_s01_p16'], ns01_p16_a5 ,'delimiter',',','precision',15);
dlmwrite([p16_outcome_data_path 'a05_s02_p16'], ns02_p16_a5 ,'delimiter',',','precision',15);
dlmwrite([p16_outcome_data_path 'a05_s03_p16'], ns03_p16_a5 ,'delimiter',',','precision',15);
dlmwrite([p16_outcome_data_path 'a05_s04_p16'], ns04_p16_a5 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p16   TIME ALIGNMENT  FOR ACTIVITY _a6   %%%%%%%%%%%%%%%%
windowframe = p16_windowframe_a6;
t1_p16_a6 = p16_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p16_a6 = p16_s02m(windowframe,2);
t3_p16_a6 = p16_s03m(windowframe,2);
t4_p16_a6 = p16_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p16_a6 = p16_s01m(windowframe,3:15);
s2_p16_a6 = p16_s02m(windowframe,3:15);
s3_p16_a6 = p16_s03m(windowframe,3:15);
s4_p16_a6 = p16_s04m(windowframe,3:15);

[ns01_p16_a6, ns02_p16_a6, ns03_p16_a6, ns04_p16_a6] = sensors_timealignment_different_length(
							t1_p16_a6,t2_p16_a6,t3_p16_a6,t4_p16_a6, 
							s1_p16_a6,s2_p16_a6,s3_p16_a6,s4_p16_a6);

%plottingFOURsensors(ns01_p16_a6, ns02_p16_a6, ns03_p16_a6, ns04_p16_a6, 2)

dlmwrite([p16_outcome_data_path 'a06_s01_p16'], ns01_p16_a6 ,'delimiter',',','precision',15);
dlmwrite([p16_outcome_data_path 'a06_s02_p16'], ns02_p16_a6 ,'delimiter',',','precision',15);
dlmwrite([p16_outcome_data_path 'a06_s03_p16'], ns03_p16_a6 ,'delimiter',',','precision',15);
dlmwrite([p16_outcome_data_path 'a06_s04_p16'], ns04_p16_a6 ,'delimiter',',','precision',15);







% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p16   TIME ALIGNMENT  FOR ACTIVITY _a7   %%%%%%%%%%%%%%%%
windowframe = p16_windowframe_a7;
t1_p16_a7 = p16_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p16_a7 = p16_s02m(windowframe,2);
t3_p16_a7 = p16_s03m(windowframe,2);
t4_p16_a7 = p16_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p16_a7 = p16_s01m(windowframe,3:15);
s2_p16_a7 = p16_s02m(windowframe,3:15);
s3_p16_a7 = p16_s03m(windowframe,3:15);
s4_p16_a7 = p16_s04m(windowframe,3:15);

[ns01_p16_a7, ns02_p16_a7, ns03_p16_a7, ns04_p16_a7] = sensors_timealignment_different_length(
							t1_p16_a7,t2_p16_a7,t3_p16_a7,t4_p16_a7, 
							s1_p16_a7,s2_p16_a7,s3_p16_a7,s4_p16_a7);

%plottingFOURsensors(ns01_p16_a7, ns02_p16_a7, ns03_p16_a7, ns04_p16_a7, 2)

dlmwrite([p16_outcome_data_path 'a07_s01_p16'], ns01_p16_a7 ,'delimiter',',','precision',15);
dlmwrite([p16_outcome_data_path 'a07_s02_p16'], ns02_p16_a7 ,'delimiter',',','precision',15);
dlmwrite([p16_outcome_data_path 'a07_s03_p16'], ns03_p16_a7 ,'delimiter',',','precision',15);
dlmwrite([p16_outcome_data_path 'a07_s04_p16'], ns04_p16_a7 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p16   TIME ALIGNMENT  FOR ACTIVITY _a8   %%%%%%%%%%%%%%%%
t1_p16_a8 = p16_s01m(p16_labels(8,4):p16_max_length_sensors(1),2);   %TimestampTx
t2_p16_a8 = p16_s02m(p16_labels(8,4):p16_max_length_sensors(2),2);
t3_p16_a8 = p16_s03m(p16_labels(8,4):p16_max_length_sensors(3),2);
t4_p16_a8 = p16_s04m(p16_labels(8,4):p16_max_length_sensors(4),2);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p16_a8 = p16_s01m(windowframe,3:15);
s2_p16_a8 = p16_s02m(windowframe,3:15);
s3_p16_a8 = p16_s03m(windowframe,3:15);
s4_p16_a8 = p16_s04m(windowframe,3:15);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p16_a8 = p16_s01m(p16_labels(8,4):p16_max_length_sensors(1),3:15);
s2_p16_a8 = p16_s02m(p16_labels(8,4):p16_max_length_sensors(2),3:15);
s3_p16_a8 = p16_s03m(p16_labels(8,4):p16_max_length_sensors(3),3:15);
s4_p16_a8 = p16_s04m(p16_labels(8,4):p16_max_length_sensors(4),3:15);

[ns01_p16_a8, ns02_p16_a8, ns03_p16_a8, ns04_p16_a8] = sensors_timealignment_different_length(
							t1_p16_a8,t2_p16_a8,t3_p16_a8,t4_p16_a8, 
							s1_p16_a8,s2_p16_a8,s3_p16_a8,s4_p16_a8);

%plottingFOURsensors(ns01_p16_a8, ns02_p16_a8, ns03_p16_a8, ns04_p16_a8, 2)

dlmwrite([p16_outcome_data_path 'a08_s01_p16'], ns01_p16_a8 ,'delimiter',',','precision',15);
dlmwrite([p16_outcome_data_path 'a08_s02_p16'], ns02_p16_a8 ,'delimiter',',','precision',15);
dlmwrite([p16_outcome_data_path 'a08_s03_p16'], ns03_p16_a8 ,'delimiter',',','precision',15);
dlmwrite([p16_outcome_data_path 'a08_s04_p16'], ns04_p16_a8 ,'delimiter',',','precision',15);







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  --  p17 -- %%%%%%%%%%%%%%%%%%%%%



p17_data_path = strcat(datapath,'/p17/p17-HII/');
[p17_s01m, p17_s02m, p17_s03m, p17_s04m, p17_max_length_sensors] = cvs2arrays(p17_data_path);
p17_labels = labels(129:136,:);



p17_windowframe_a1 = p17_labels(1,4):p17_labels(1,5);
p17_windowframe_a2 = p17_labels(2,4):p17_labels(2,5);
p17_windowframe_a3 = p17_labels(3,4):p17_labels(3,5);
p17_windowframe_a4 = p17_labels(4,4):p17_labels(4,5);
p17_windowframe_a5 = p17_labels(5,4):p17_labels(5,5);
p17_windowframe_a6 = p17_labels(6,4):p17_labels(6,5);
p17_windowframe_a7 = p17_labels(7,4):p17_labels(7,5);
%p17_windowframe_a8 HERE IS USED THE MAX LENGTH OF THE TIMESERIES

% CREATE PATH TO SAVE DATA
p17_split_path = strsplit(p17_data_path,'/');
p17_outcome_data_path = strcat(outcomes_path, p17_split_path(09),'/',p17_split_path(10),'/');
p17_outcome_data_path= char(p17_outcome_data_path);
if ~exist(p17_outcome_data_path,'dir');
  {
    myk =  cstrcat('system(',' ''mkdir', ' -p ',p17_outcome_data_path,''')');
    eval( sprintf(myk) );
  }
end




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p17   TIME ALIGNMENT  FOR ACTIVITY _a1   %%%%%%%%%%%%%%%%
windowframe = p17_windowframe_a1;
t1_p17_a1 = p17_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p17_a1 = p17_s02m(windowframe,2);
t3_p17_a1 = p17_s03m(windowframe,2);
t4_p17_a1 = p17_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p17_a1 = p17_s01m(windowframe,3:15);
s2_p17_a1 = p17_s02m(windowframe,3:15);
s3_p17_a1 = p17_s03m(windowframe,3:15);
s4_p17_a1 = p17_s04m(windowframe,3:15);

[ns01_p17_a1, ns02_p17_a1, ns03_p17_a1, ns04_p17_a1] = sensors_timealignment_different_length(
							t1_p17_a1,t2_p17_a1,t3_p17_a1,t4_p17_a1, 
							s1_p17_a1,s2_p17_a1,s3_p17_a1,s4_p17_a1);

%plottingFOURsensors(ns01_p17_a1, ns02_p17_a1, ns03_p17_a1, ns04_p17_a1, 2)

dlmwrite([p17_outcome_data_path 'a01_s01_p17'], ns01_p17_a1 ,'delimiter',',','precision',15);
dlmwrite([p17_outcome_data_path 'a01_s02_p17'], ns02_p17_a1 ,'delimiter',',','precision',15);
dlmwrite([p17_outcome_data_path 'a01_s03_p17'], ns03_p17_a1 ,'delimiter',',','precision',15);
dlmwrite([p17_outcome_data_path 'a01_s04_p17'], ns04_p17_a1 ,'delimiter',',','precision',15);




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p17   TIME ALIGNMENT  FOR ACTIVITY _a2   %%%%%%%%%%%%%%%%
windowframe = p17_windowframe_a2;
t1_p17_a2 = p17_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p17_a2 = p17_s02m(windowframe,2);
t3_p17_a2 = p17_s03m(windowframe,2);
t4_p17_a2 = p17_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p17_a2 = p17_s01m(windowframe,3:15);
s2_p17_a2 = p17_s02m(windowframe,3:15);
s3_p17_a2 = p17_s03m(windowframe,3:15);
s4_p17_a2 = p17_s04m(windowframe,3:15);

[ns01_p17_a2, ns02_p17_a2, ns03_p17_a2, ns04_p17_a2] = sensors_timealignment_different_length(
							t1_p17_a2,t2_p17_a2,t3_p17_a2,t4_p17_a2, 
							s1_p17_a2,s2_p17_a2,s3_p17_a2,s4_p17_a2);

%plottingFOURsensors(ns01_p17_a2, ns02_p17_a2, ns03_p17_a2, ns04_p17_a2, 2)

dlmwrite([p17_outcome_data_path 'a02_s01_p17'], ns01_p17_a2 ,'delimiter',',','precision',15);
dlmwrite([p17_outcome_data_path 'a02_s02_p17'], ns02_p17_a2 ,'delimiter',',','precision',15);
dlmwrite([p17_outcome_data_path 'a02_s03_p17'], ns03_p17_a2 ,'delimiter',',','precision',15);
dlmwrite([p17_outcome_data_path 'a02_s04_p17'], ns04_p17_a2 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p17   TIME ALIGNMENT  FOR ACTIVITY _a3   %%%%%%%%%%%%%%%%
windowframe = p17_windowframe_a3;
t1_p17_a3 = p17_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p17_a3 = p17_s02m(windowframe,2);
t3_p17_a3 = p17_s03m(windowframe,2);
t4_p17_a3 = p17_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p17_a3 = p17_s01m(windowframe,3:15);
s2_p17_a3 = p17_s02m(windowframe,3:15);
s3_p17_a3 = p17_s03m(windowframe,3:15);
s4_p17_a3 = p17_s04m(windowframe,3:15);

[ns01_p17_a3, ns02_p17_a3, ns03_p17_a3, ns04_p17_a3] = sensors_timealignment_different_length(
							t1_p17_a3,t2_p17_a3,t3_p17_a3,t4_p17_a3, 
							s1_p17_a3,s2_p17_a3,s3_p17_a3,s4_p17_a3);

%plottingFOURsensors(ns01_p17_a3, ns02_p17_a3, ns03_p17_a3, ns04_p17_a3, 2)

dlmwrite([p17_outcome_data_path 'a03_s01_p17'], ns01_p17_a3 ,'delimiter',',','precision',15);
dlmwrite([p17_outcome_data_path 'a03_s02_p17'], ns02_p17_a3 ,'delimiter',',','precision',15);
dlmwrite([p17_outcome_data_path 'a03_s03_p17'], ns03_p17_a3 ,'delimiter',',','precision',15);
dlmwrite([p17_outcome_data_path 'a03_s04_p17'], ns04_p17_a3 ,'delimiter',',','precision',15);




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p17   TIME ALIGNMENT  FOR ACTIVITY _a4   %%%%%%%%%%%%%%%%
windowframe = p17_windowframe_a4;
t1_p17_a4 = p17_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p17_a4 = p17_s02m(windowframe,2);
t3_p17_a4 = p17_s03m(windowframe,2);
t4_p17_a4 = p17_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p17_a4 = p17_s01m(windowframe,3:15);
s2_p17_a4 = p17_s02m(windowframe,3:15);
s3_p17_a4 = p17_s03m(windowframe,3:15);
s4_p17_a4 = p17_s04m(windowframe,3:15);

[ns01_p17_a4, ns02_p17_a4, ns03_p17_a4, ns04_p17_a4] = sensors_timealignment_different_length(
							t1_p17_a4,t2_p17_a4,t3_p17_a4,t4_p17_a4, 
							s1_p17_a4,s2_p17_a4,s3_p17_a4,s4_p17_a4);

%plottingFOURsensors(ns01_p17_a4, ns02_p17_a4, ns03_p17_a4, ns04_p17_a4, 2)

dlmwrite([p17_outcome_data_path 'a04_s01_p17'], ns01_p17_a4 ,'delimiter',',','precision',15);
dlmwrite([p17_outcome_data_path 'a04_s02_p17'], ns02_p17_a4 ,'delimiter',',','precision',15);
dlmwrite([p17_outcome_data_path 'a04_s03_p17'], ns03_p17_a4 ,'delimiter',',','precision',15);
dlmwrite([p17_outcome_data_path 'a04_s04_p17'], ns04_p17_a4 ,'delimiter',',','precision',15);




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p17   TIME ALIGNMENT  FOR ACTIVITY _a5   %%%%%%%%%%%%%%%%
windowframe = p17_windowframe_a5;
t1_p17_a5 = p17_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p17_a5 = p17_s02m(windowframe,2);
t3_p17_a5 = p17_s03m(windowframe,2);
t4_p17_a5 = p17_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p17_a5 = p17_s01m(windowframe,3:15);
s2_p17_a5 = p17_s02m(windowframe,3:15);
s3_p17_a5 = p17_s03m(windowframe,3:15);
s4_p17_a5 = p17_s04m(windowframe,3:15);

[ns01_p17_a5, ns02_p17_a5, ns03_p17_a5, ns04_p17_a5] = sensors_timealignment_different_length(
							t1_p17_a5,t2_p17_a5,t3_p17_a5,t4_p17_a5, 
							s1_p17_a5,s2_p17_a5,s3_p17_a5,s4_p17_a5);

%plottingFOURsensors(ns01_p17_a5, ns02_p17_a5, ns03_p17_a5, ns04_p17_a5, 2)

dlmwrite([p17_outcome_data_path 'a05_s01_p17'], ns01_p17_a5 ,'delimiter',',','precision',15);
dlmwrite([p17_outcome_data_path 'a05_s02_p17'], ns02_p17_a5 ,'delimiter',',','precision',15);
dlmwrite([p17_outcome_data_path 'a05_s03_p17'], ns03_p17_a5 ,'delimiter',',','precision',15);
dlmwrite([p17_outcome_data_path 'a05_s04_p17'], ns04_p17_a5 ,'delimiter',',','precision',15);






% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p17   TIME ALIGNMENT  FOR ACTIVITY _a6   %%%%%%%%%%%%%%%%
windowframe = p17_windowframe_a6;
t1_p17_a6 = p17_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p17_a6 = p17_s02m(windowframe,2);
t3_p17_a6 = p17_s03m(windowframe,2);
t4_p17_a6 = p17_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p17_a6 = p17_s01m(windowframe,3:15);
s2_p17_a6 = p17_s02m(windowframe,3:15);
s3_p17_a6 = p17_s03m(windowframe,3:15);
s4_p17_a6 = p17_s04m(windowframe,3:15);

[ns01_p17_a6, ns02_p17_a6, ns03_p17_a6, ns04_p17_a6] = sensors_timealignment_different_length(
							t1_p17_a6,t2_p17_a6,t3_p17_a6,t4_p17_a6, 
							s1_p17_a6,s2_p17_a6,s3_p17_a6,s4_p17_a6);

%plottingFOURsensors(ns01_p17_a6, ns02_p17_a6, ns03_p17_a6, ns04_p17_a6, 2)

dlmwrite([p17_outcome_data_path 'a06_s01_p17'], ns01_p17_a6 ,'delimiter',',','precision',15);
dlmwrite([p17_outcome_data_path 'a06_s02_p17'], ns02_p17_a6 ,'delimiter',',','precision',15);
dlmwrite([p17_outcome_data_path 'a06_s03_p17'], ns03_p17_a6 ,'delimiter',',','precision',15);
dlmwrite([p17_outcome_data_path 'a06_s04_p17'], ns04_p17_a6 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p17   TIME ALIGNMENT  FOR ACTIVITY _a7   %%%%%%%%%%%%%%%%
windowframe = p17_windowframe_a7;
t1_p17_a7 = p17_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p17_a7 = p17_s02m(windowframe,2);
t3_p17_a7 = p17_s03m(windowframe,2);
t4_p17_a7 = p17_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p17_a7 = p17_s01m(windowframe,3:15);
s2_p17_a7 = p17_s02m(windowframe,3:15);
s3_p17_a7 = p17_s03m(windowframe,3:15);
s4_p17_a7 = p17_s04m(windowframe,3:15);

[ns01_p17_a7, ns02_p17_a7, ns03_p17_a7, ns04_p17_a7] = sensors_timealignment_different_length(
							t1_p17_a7,t2_p17_a7,t3_p17_a7,t4_p17_a7, 
							s1_p17_a7,s2_p17_a7,s3_p17_a7,s4_p17_a7);

%plottingFOURsensors(ns01_p17_a7, ns02_p17_a7, ns03_p17_a7, ns04_p17_a7, 2)

dlmwrite([p17_outcome_data_path 'a07_s01_p17'], ns01_p17_a7 ,'delimiter',',','precision',15);
dlmwrite([p17_outcome_data_path 'a07_s02_p17'], ns02_p17_a7 ,'delimiter',',','precision',15);
dlmwrite([p17_outcome_data_path 'a07_s03_p17'], ns03_p17_a7 ,'delimiter',',','precision',15);
dlmwrite([p17_outcome_data_path 'a07_s04_p17'], ns04_p17_a7 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p17   TIME ALIGNMENT  FOR ACTIVITY _a8   %%%%%%%%%%%%%%%%
t1_p17_a8 = p17_s01m(p17_labels(8,4):p17_max_length_sensors(1),2);   %TimestampTx
t2_p17_a8 = p17_s02m(p17_labels(8,4):p17_max_length_sensors(2),2);
t3_p17_a8 = p17_s03m(p17_labels(8,4):p17_max_length_sensors(3),2);
t4_p17_a8 = p17_s04m(p17_labels(8,4):p17_max_length_sensors(4),2);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p17_a8 = p17_s01m(windowframe,3:15);
s2_p17_a8 = p17_s02m(windowframe,3:15);
s3_p17_a8 = p17_s03m(windowframe,3:15);
s4_p17_a8 = p17_s04m(windowframe,3:15);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p17_a8 = p17_s01m(p17_labels(8,4):p17_max_length_sensors(1),3:15);
s2_p17_a8 = p17_s02m(p17_labels(8,4):p17_max_length_sensors(2),3:15);
s3_p17_a8 = p17_s03m(p17_labels(8,4):p17_max_length_sensors(3),3:15);
s4_p17_a8 = p17_s04m(p17_labels(8,4):p17_max_length_sensors(4),3:15);

[ns01_p17_a8, ns02_p17_a8, ns03_p17_a8, ns04_p17_a8] = sensors_timealignment_different_length(
							t1_p17_a8,t2_p17_a8,t3_p17_a8,t4_p17_a8, 
							s1_p17_a8,s2_p17_a8,s3_p17_a8,s4_p17_a8);

%plottingFOURsensors(ns01_p17_a8, ns02_p17_a8, ns03_p17_a8, ns04_p17_a8, 2)

dlmwrite([p17_outcome_data_path 'a08_s01_p17'], ns01_p17_a8 ,'delimiter',',','precision',15);
dlmwrite([p17_outcome_data_path 'a08_s02_p17'], ns02_p17_a8 ,'delimiter',',','precision',15);
dlmwrite([p17_outcome_data_path 'a08_s03_p17'], ns03_p17_a8 ,'delimiter',',','precision',15);
dlmwrite([p17_outcome_data_path 'a08_s04_p17'], ns04_p17_a8 ,'delimiter',',','precision',15);







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  --  p18 -- %%%%%%%%%%%%%%%%%%%%%



p18_data_path = strcat(datapath,'/p18/p18-HII/');
[p18_s01m, p18_s02m, p18_s03m, p18_s04m, p18_max_length_sensors] = cvs2arrays(p18_data_path);
p18_labels = labels(137:144,:);



p18_windowframe_a1 = p18_labels(1,4):p18_labels(1,5);
p18_windowframe_a2 = p18_labels(2,4):p18_labels(2,5);
p18_windowframe_a3 = p18_labels(3,4):p18_labels(3,5);
p18_windowframe_a4 = p18_labels(4,4):p18_labels(4,5);
p18_windowframe_a5 = p18_labels(5,4):p18_labels(5,5);
p18_windowframe_a6 = p18_labels(6,4):p18_labels(6,5);
p18_windowframe_a7 = p18_labels(7,4):p18_labels(7,5);
%p18_windowframe_a8 HERE IS USED THE MAX LENGTH OF THE TIMESERIES

% CREATE PATH TO SAVE DATA
p18_split_path = strsplit(p18_data_path,'/');
p18_outcome_data_path = strcat(outcomes_path, p18_split_path(09),'/',p18_split_path(10),'/');
p18_outcome_data_path= char(p18_outcome_data_path);
if ~exist(p18_outcome_data_path,'dir');
  {
    myk =  cstrcat('system(',' ''mkdir', ' -p ',p18_outcome_data_path,''')');
    eval( sprintf(myk) );
  }
end





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p18   TIME ALIGNMENT  FOR ACTIVITY _a1   %%%%%%%%%%%%%%%%
windowframe = p18_windowframe_a1;
t1_p18_a1 = p18_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p18_a1 = p18_s02m(windowframe,2);
t3_p18_a1 = p18_s03m(windowframe,2);
t4_p18_a1 = p18_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p18_a1 = p18_s01m(windowframe,3:15);
s2_p18_a1 = p18_s02m(windowframe,3:15);
s3_p18_a1 = p18_s03m(windowframe,3:15);
s4_p18_a1 = p18_s04m(windowframe,3:15);

[ns01_p18_a1, ns02_p18_a1, ns03_p18_a1, ns04_p18_a1] = sensors_timealignment_different_length(
							t1_p18_a1,t2_p18_a1,t3_p18_a1,t4_p18_a1, 
							s1_p18_a1,s2_p18_a1,s3_p18_a1,s4_p18_a1);

%plottingFOURsensors(ns01_p18_a1, ns02_p18_a1, ns03_p18_a1, ns04_p18_a1, 2)

dlmwrite([p18_outcome_data_path 'a01_s01_p18'], ns01_p18_a1 ,'delimiter',',','precision',15);
dlmwrite([p18_outcome_data_path 'a01_s02_p18'], ns02_p18_a1 ,'delimiter',',','precision',15);
dlmwrite([p18_outcome_data_path 'a01_s03_p18'], ns03_p18_a1 ,'delimiter',',','precision',15);
dlmwrite([p18_outcome_data_path 'a01_s04_p18'], ns04_p18_a1 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p18   TIME ALIGNMENT  FOR ACTIVITY _a2   %%%%%%%%%%%%%%%%
windowframe = p18_windowframe_a2;
t1_p18_a2 = p18_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p18_a2 = p18_s02m(windowframe,2);
t3_p18_a2 = p18_s03m(windowframe,2);
t4_p18_a2 = p18_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p18_a2 = p18_s01m(windowframe,3:15);
s2_p18_a2 = p18_s02m(windowframe,3:15);
s3_p18_a2 = p18_s03m(windowframe,3:15);
s4_p18_a2 = p18_s04m(windowframe,3:15);



[ns01_p18_a2, ns02_p18_a2, ns03_p18_a2, ns04_p18_a2] = sensors_timealignment_different_length(
							t1_p18_a2,t2_p18_a2,t3_p18_a2,t4_p18_a2, 
							s1_p18_a2,s2_p18_a2,s3_p18_a2,s4_p18_a2);


%plottingFOURsensors(ns01_p18_a2, ns02_p18_a2, ns03_p18_a2, ns04_p18_a2, 2)

dlmwrite([p18_outcome_data_path 'a02_s01_p18'], ns01_p18_a2 ,'delimiter',',','precision',15);
dlmwrite([p18_outcome_data_path 'a02_s02_p18'], ns02_p18_a2 ,'delimiter',',','precision',15);
dlmwrite([p18_outcome_data_path 'a02_s03_p18'], ns03_p18_a2 ,'delimiter',',','precision',15);
dlmwrite([p18_outcome_data_path 'a02_s04_p18'], ns04_p18_a2 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p18   TIME ALIGNMENT  FOR ACTIVITY _a3   %%%%%%%%%%%%%%%%
windowframe = p18_windowframe_a3;
t1_p18_a3 = p18_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p18_a3 = p18_s02m(windowframe,2);
t3_p18_a3 = p18_s03m(windowframe,2);
t4_p18_a3 = p18_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p18_a3 = p18_s01m(windowframe,3:15);
s2_p18_a3 = p18_s02m(windowframe,3:15);
s3_p18_a3 = p18_s03m(windowframe,3:15);
s4_p18_a3 = p18_s04m(windowframe,3:15);

[ns01_p18_a3, ns02_p18_a3, ns03_p18_a3, ns04_p18_a3] = sensors_timealignment_different_length(
							t1_p18_a3,t2_p18_a3,t3_p18_a3,t4_p18_a3, 
							s1_p18_a3,s2_p18_a3,s3_p18_a3,s4_p18_a3);

%plottingFOURsensors(ns01_p18_a3, ns02_p18_a3, ns03_p18_a3, ns04_p18_a3, 2)

dlmwrite([p18_outcome_data_path 'a03_s01_p18'], ns01_p18_a3 ,'delimiter',',','precision',15);
dlmwrite([p18_outcome_data_path 'a03_s02_p18'], ns02_p18_a3 ,'delimiter',',','precision',15);
dlmwrite([p18_outcome_data_path 'a03_s03_p18'], ns03_p18_a3 ,'delimiter',',','precision',15);
dlmwrite([p18_outcome_data_path 'a03_s04_p18'], ns04_p18_a3 ,'delimiter',',','precision',15);



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p18   TIME ALIGNMENT  FOR ACTIVITY _a4   %%%%%%%%%%%%%%%%
windowframe = p18_windowframe_a4;
t1_p18_a4 = p18_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p18_a4 = p18_s02m(windowframe,2);
t3_p18_a4 = p18_s03m(windowframe,2);
t4_p18_a4 = p18_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p18_a4 = p18_s01m(windowframe,3:15);
s2_p18_a4 = p18_s02m(windowframe,3:15);
s3_p18_a4 = p18_s03m(windowframe,3:15);
s4_p18_a4 = p18_s04m(windowframe,3:15);

[ns01_p18_a4, ns02_p18_a4, ns03_p18_a4, ns04_p18_a4] = sensors_timealignment_different_length(
							t1_p18_a4,t2_p18_a4,t3_p18_a4,t4_p18_a4, 
							s1_p18_a4,s2_p18_a4,s3_p18_a4,s4_p18_a4);

%plottingFOURsensors(ns01_p18_a4, ns02_p18_a4, ns03_p18_a4, ns04_p18_a4, 2)

dlmwrite([p18_outcome_data_path 'a04_s01_p18'], ns01_p18_a4 ,'delimiter',',','precision',15);
dlmwrite([p18_outcome_data_path 'a04_s02_p18'], ns02_p18_a4 ,'delimiter',',','precision',15);
dlmwrite([p18_outcome_data_path 'a04_s03_p18'], ns03_p18_a4 ,'delimiter',',','precision',15);
dlmwrite([p18_outcome_data_path 'a04_s04_p18'], ns04_p18_a4 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p18   TIME ALIGNMENT  FOR ACTIVITY _a5   %%%%%%%%%%%%%%%%
windowframe = p18_windowframe_a5;
t1_p18_a5 = p18_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p18_a5 = p18_s02m(windowframe,2);
t3_p18_a5 = p18_s03m(windowframe,2);
t4_p18_a5 = p18_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p18_a5 = p18_s01m(windowframe,3:15);
s2_p18_a5 = p18_s02m(windowframe,3:15);
s3_p18_a5 = p18_s03m(windowframe,3:15);
s4_p18_a5 = p18_s04m(windowframe,3:15);

[ns01_p18_a5, ns02_p18_a5, ns03_p18_a5, ns04_p18_a5] = sensors_timealignment_different_length(
							t1_p18_a5,t2_p18_a5,t3_p18_a5,t4_p18_a5, 
							s1_p18_a5,s2_p18_a5,s3_p18_a5,s4_p18_a5);

%plottingFOURsensors(ns01_p18_a5, ns02_p18_a5, ns03_p18_a5, ns04_p18_a5, 2)

dlmwrite([p18_outcome_data_path 'a05_s01_p18'], ns01_p18_a5 ,'delimiter',',','precision',15);
dlmwrite([p18_outcome_data_path 'a05_s02_p18'], ns02_p18_a5 ,'delimiter',',','precision',15);
dlmwrite([p18_outcome_data_path 'a05_s03_p18'], ns03_p18_a5 ,'delimiter',',','precision',15);
dlmwrite([p18_outcome_data_path 'a05_s04_p18'], ns04_p18_a5 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p18   TIME ALIGNMENT  FOR ACTIVITY _a6   %%%%%%%%%%%%%%%%
windowframe = p18_windowframe_a6;
t1_p18_a6 = p18_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p18_a6 = p18_s02m(windowframe,2);
t3_p18_a6 = p18_s03m(windowframe,2);
t4_p18_a6 = p18_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p18_a6 = p18_s01m(windowframe,3:15);
s2_p18_a6 = p18_s02m(windowframe,3:15);
s3_p18_a6 = p18_s03m(windowframe,3:15);
s4_p18_a6 = p18_s04m(windowframe,3:15);

[ns01_p18_a6, ns02_p18_a6, ns03_p18_a6, ns04_p18_a6] = sensors_timealignment_different_length(
							t1_p18_a6,t2_p18_a6,t3_p18_a6,t4_p18_a6, 
							s1_p18_a6,s2_p18_a6,s3_p18_a6,s4_p18_a6);

%plottingFOURsensors(ns01_p18_a6, ns02_p18_a6, ns03_p18_a6, ns04_p18_a6, 2)

dlmwrite([p18_outcome_data_path 'a06_s01_p18'], ns01_p18_a6 ,'delimiter',',','precision',15);
dlmwrite([p18_outcome_data_path 'a06_s02_p18'], ns02_p18_a6 ,'delimiter',',','precision',15);
dlmwrite([p18_outcome_data_path 'a06_s03_p18'], ns03_p18_a6 ,'delimiter',',','precision',15);
dlmwrite([p18_outcome_data_path 'a06_s04_p18'], ns04_p18_a6 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p18   TIME ALIGNMENT  FOR ACTIVITY _a7   %%%%%%%%%%%%%%%%
windowframe = p18_windowframe_a7;
t1_p18_a7 = p18_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p18_a7 = p18_s02m(windowframe,2);
t3_p18_a7 = p18_s03m(windowframe,2);
t4_p18_a7 = p18_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p18_a7 = p18_s01m(windowframe,3:15);
s2_p18_a7 = p18_s02m(windowframe,3:15);
s3_p18_a7 = p18_s03m(windowframe,3:15);
s4_p18_a7 = p18_s04m(windowframe,3:15);

[ns01_p18_a7, ns02_p18_a7, ns03_p18_a7, ns04_p18_a7] = sensors_timealignment_different_length_inverted_maxmin_vectors(
							t1_p18_a7,t2_p18_a7,t3_p18_a7,t4_p18_a7, 
							s1_p18_a7,s2_p18_a7,s3_p18_a7,s4_p18_a7);

%plottingFOURsensors(ns01_p18_a7, ns02_p18_a7, ns03_p18_a7, ns04_p18_a7, 2)

dlmwrite([p18_outcome_data_path 'a07_s01_p18'], ns01_p18_a7 ,'delimiter',',','precision',15);
dlmwrite([p18_outcome_data_path 'a07_s02_p18'], ns02_p18_a7 ,'delimiter',',','precision',15);
dlmwrite([p18_outcome_data_path 'a07_s03_p18'], ns03_p18_a7 ,'delimiter',',','precision',15);
dlmwrite([p18_outcome_data_path 'a07_s04_p18'], ns04_p18_a7 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p18   TIME ALIGNMENT  FOR ACTIVITY _a8   %%%%%%%%%%%%%%%%
t1_p18_a8 = p18_s01m(p18_labels(8,4):p18_max_length_sensors(1),2);   %TimestampTx
t2_p18_a8 = p18_s02m(p18_labels(8,4):p18_max_length_sensors(2),2);
t3_p18_a8 = p18_s03m(p18_labels(8,4):p18_max_length_sensors(3),2);
t4_p18_a8 = p18_s04m(p18_labels(8,4):p18_max_length_sensors(4),2);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p18_a8 = p18_s01m(windowframe,3:15);
s2_p18_a8 = p18_s02m(windowframe,3:15);
s3_p18_a8 = p18_s03m(windowframe,3:15);
s4_p18_a8 = p18_s04m(windowframe,3:15);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p18_a8 = p18_s01m(p18_labels(8,4):p18_max_length_sensors(1),3:15);
s2_p18_a8 = p18_s02m(p18_labels(8,4):p18_max_length_sensors(2),3:15);
s3_p18_a8 = p18_s03m(p18_labels(8,4):p18_max_length_sensors(3),3:15);
s4_p18_a8 = p18_s04m(p18_labels(8,4):p18_max_length_sensors(4),3:15);

[ns01_p18_a8, ns02_p18_a8, ns03_p18_a8, ns04_p18_a8] = sensors_timealignment_different_length(
							t1_p18_a8,t2_p18_a8,t3_p18_a8,t4_p18_a8, 
							s1_p18_a8,s2_p18_a8,s3_p18_a8,s4_p18_a8);

%plottingFOURsensors(ns01_p18_a8, ns02_p18_a8, ns03_p18_a8, ns04_p18_a8, 2)

dlmwrite([p18_outcome_data_path 'a08_s01_p18'], ns01_p18_a8 ,'delimiter',',','precision',15);
dlmwrite([p18_outcome_data_path 'a08_s02_p18'], ns02_p18_a8 ,'delimiter',',','precision',15);
dlmwrite([p18_outcome_data_path 'a08_s03_p18'], ns03_p18_a8 ,'delimiter',',','precision',15);
dlmwrite([p18_outcome_data_path 'a08_s04_p18'], ns04_p18_a8 ,'delimiter',',','precision',15);









%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  --  p19 -- %%%%%%%%%%%%%%%%%%%%%



p19_data_path = strcat(datapath,'/p19/p19-HII/');
[p19_s01m, p19_s02m, p19_s03m, p19_s04m, p19_max_length_sensors] = cvs2arrays(p19_data_path);
p19_labels = labels(145:152,:);



p19_windowframe_a1 = p19_labels(1,4):p19_labels(1,5);
p19_windowframe_a2 = p19_labels(2,4):p19_labels(2,5);
p19_windowframe_a3 = p19_labels(3,4):p19_labels(3,5);
p19_windowframe_a4 = p19_labels(4,4):p19_labels(4,5);
p19_windowframe_a5 = p19_labels(5,4):p19_labels(5,5);
p19_windowframe_a6 = p19_labels(6,4):p19_labels(6,5);
p19_windowframe_a7 = p19_labels(7,4):p19_labels(7,5);
%p19_windowframe_a8 HERE IS USED THE MAX LENGTH OF THE TIMESERIES

% CREATE PATH TO SAVE DATA
p19_split_path = strsplit(p19_data_path,'/');
p19_outcome_data_path = strcat(outcomes_path, p19_split_path(09),'/',p19_split_path(10),'/');
p19_outcome_data_path= char(p19_outcome_data_path);
if ~exist(p19_outcome_data_path,'dir');
  {
    myk =  cstrcat('system(',' ''mkdir', ' -p ',p19_outcome_data_path,''')');
    eval( sprintf(myk) );
  }
end




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p19   TIME ALIGNMENT  FOR ACTIVITY _a1   %%%%%%%%%%%%%%%%
windowframe = p19_windowframe_a1;
t1_p19_a1 = p19_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p19_a1 = p19_s02m(windowframe,2);
t3_p19_a1 = p19_s03m(windowframe,2);
t4_p19_a1 = p19_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p19_a1 = p19_s01m(windowframe,3:15);
s2_p19_a1 = p19_s02m(windowframe,3:15);
s3_p19_a1 = p19_s03m(windowframe,3:15);
s4_p19_a1 = p19_s04m(windowframe,3:15);

[ns01_p19_a1, ns02_p19_a1, ns03_p19_a1, ns04_p19_a1] = sensors_timealignment_different_length(
							t1_p19_a1,t2_p19_a1,t3_p19_a1,t4_p19_a1, 
							s1_p19_a1,s2_p19_a1,s3_p19_a1,s4_p19_a1);

%plottingFOURsensors(ns01_p19_a1, ns02_p19_a1, ns03_p19_a1, ns04_p19_a1, 2)

dlmwrite([p19_outcome_data_path 'a01_s01_p19'], ns01_p19_a1 ,'delimiter',',','precision',15);
dlmwrite([p19_outcome_data_path 'a01_s02_p19'], ns02_p19_a1 ,'delimiter',',','precision',15);
dlmwrite([p19_outcome_data_path 'a01_s03_p19'], ns03_p19_a1 ,'delimiter',',','precision',15);
dlmwrite([p19_outcome_data_path 'a01_s04_p19'], ns04_p19_a1 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p19   TIME ALIGNMENT  FOR ACTIVITY _a2   %%%%%%%%%%%%%%%%
windowframe = p19_windowframe_a2;
t1_p19_a2 = p19_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p19_a2 = p19_s02m(windowframe,2);
t3_p19_a2 = p19_s03m(windowframe,2);
t4_p19_a2 = p19_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p19_a2 = p19_s01m(windowframe,3:15);
s2_p19_a2 = p19_s02m(windowframe,3:15);
s3_p19_a2 = p19_s03m(windowframe,3:15);
s4_p19_a2 = p19_s04m(windowframe,3:15);

[ns01_p19_a2, ns02_p19_a2, ns03_p19_a2, ns04_p19_a2] = sensors_timealignment_different_length(
							t1_p19_a2,t2_p19_a2,t3_p19_a2,t4_p19_a2, 
							s1_p19_a2,s2_p19_a2,s3_p19_a2,s4_p19_a2);


%plottingFOURsensors(ns01_p19_a2, ns02_p19_a2, ns03_p19_a2, ns04_p19_a2, 2)

dlmwrite([p19_outcome_data_path 'a02_s01_p19'], ns01_p19_a2 ,'delimiter',',','precision',15);
dlmwrite([p19_outcome_data_path 'a02_s02_p19'], ns02_p19_a2 ,'delimiter',',','precision',15);
dlmwrite([p19_outcome_data_path 'a02_s03_p19'], ns03_p19_a2 ,'delimiter',',','precision',15);
dlmwrite([p19_outcome_data_path 'a02_s04_p19'], ns04_p19_a2 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p19   TIME ALIGNMENT  FOR ACTIVITY _a3   %%%%%%%%%%%%%%%%
windowframe = p19_windowframe_a3;
t1_p19_a3 = p19_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p19_a3 = p19_s02m(windowframe,2);
t3_p19_a3 = p19_s03m(windowframe,2);
t4_p19_a3 = p19_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p19_a3 = p19_s01m(windowframe,3:15);
s2_p19_a3 = p19_s02m(windowframe,3:15);
s3_p19_a3 = p19_s03m(windowframe,3:15);
s4_p19_a3 = p19_s04m(windowframe,3:15);

[ns01_p19_a3, ns02_p19_a3, ns03_p19_a3, ns04_p19_a3] = sensors_timealignment_different_length(
							t1_p19_a3,t2_p19_a3,t3_p19_a3,t4_p19_a3, 
							s1_p19_a3,s2_p19_a3,s3_p19_a3,s4_p19_a3);

%plottingFOURsensors(ns01_p19_a3, ns02_p19_a3, ns03_p19_a3, ns04_p19_a3, 2)

dlmwrite([p19_outcome_data_path 'a03_s01_p19'], ns01_p19_a3 ,'delimiter',',','precision',15);
dlmwrite([p19_outcome_data_path 'a03_s02_p19'], ns02_p19_a3 ,'delimiter',',','precision',15);
dlmwrite([p19_outcome_data_path 'a03_s03_p19'], ns03_p19_a3 ,'delimiter',',','precision',15);
dlmwrite([p19_outcome_data_path 'a03_s04_p19'], ns04_p19_a3 ,'delimiter',',','precision',15);



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p19   TIME ALIGNMENT  FOR ACTIVITY _a4   %%%%%%%%%%%%%%%%
windowframe = p19_windowframe_a4;
t1_p19_a4 = p19_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p19_a4 = p19_s02m(windowframe,2);
t3_p19_a4 = p19_s03m(windowframe,2);
t4_p19_a4 = p19_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p19_a4 = p19_s01m(windowframe,3:15);
s2_p19_a4 = p19_s02m(windowframe,3:15);
s3_p19_a4 = p19_s03m(windowframe,3:15);
s4_p19_a4 = p19_s04m(windowframe,3:15);

[ns01_p19_a4, ns02_p19_a4, ns03_p19_a4, ns04_p19_a4] = sensors_timealignment_different_length(
							t1_p19_a4,t2_p19_a4,t3_p19_a4,t4_p19_a4, 
							s1_p19_a4,s2_p19_a4,s3_p19_a4,s4_p19_a4);

%plottingFOURsensors(ns01_p19_a4, ns02_p19_a4, ns03_p19_a4, ns04_p19_a4, 2)

dlmwrite([p19_outcome_data_path 'a04_s01_p19'], ns01_p19_a4 ,'delimiter',',','precision',15);
dlmwrite([p19_outcome_data_path 'a04_s02_p19'], ns02_p19_a4 ,'delimiter',',','precision',15);
dlmwrite([p19_outcome_data_path 'a04_s03_p19'], ns03_p19_a4 ,'delimiter',',','precision',15);
dlmwrite([p19_outcome_data_path 'a04_s04_p19'], ns04_p19_a4 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p19   TIME ALIGNMENT  FOR ACTIVITY _a5   %%%%%%%%%%%%%%%%
windowframe = p19_windowframe_a5;
t1_p19_a5 = p19_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p19_a5 = p19_s02m(windowframe,2);
t3_p19_a5 = p19_s03m(windowframe,2);
t4_p19_a5 = p19_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p19_a5 = p19_s01m(windowframe,3:15);
s2_p19_a5 = p19_s02m(windowframe,3:15);
s3_p19_a5 = p19_s03m(windowframe,3:15);
s4_p19_a5 = p19_s04m(windowframe,3:15);

[ns01_p19_a5, ns02_p19_a5, ns03_p19_a5, ns04_p19_a5] = sensors_timealignment_different_length(
							t1_p19_a5,t2_p19_a5,t3_p19_a5,t4_p19_a5, 
							s1_p19_a5,s2_p19_a5,s3_p19_a5,s4_p19_a5);

%plottingFOURsensors(ns01_p19_a5, ns02_p19_a5, ns03_p19_a5, ns04_p19_a5, 2)

dlmwrite([p19_outcome_data_path 'a05_s01_p19'], ns01_p19_a5 ,'delimiter',',','precision',15);
dlmwrite([p19_outcome_data_path 'a05_s02_p19'], ns02_p19_a5 ,'delimiter',',','precision',15);
dlmwrite([p19_outcome_data_path 'a05_s03_p19'], ns03_p19_a5 ,'delimiter',',','precision',15);
dlmwrite([p19_outcome_data_path 'a05_s04_p19'], ns04_p19_a5 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p19   TIME ALIGNMENT  FOR ACTIVITY _a6   %%%%%%%%%%%%%%%%
windowframe = p19_windowframe_a6;
t1_p19_a6 = p19_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p19_a6 = p19_s02m(windowframe,2);
t3_p19_a6 = p19_s03m(windowframe,2);
t4_p19_a6 = p19_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p19_a6 = p19_s01m(windowframe,3:15);
s2_p19_a6 = p19_s02m(windowframe,3:15);
s3_p19_a6 = p19_s03m(windowframe,3:15);
s4_p19_a6 = p19_s04m(windowframe,3:15);

[ns01_p19_a6, ns02_p19_a6, ns03_p19_a6, ns04_p19_a6] = sensors_timealignment_different_length(
							t1_p19_a6,t2_p19_a6,t3_p19_a6,t4_p19_a6, 
							s1_p19_a6,s2_p19_a6,s3_p19_a6,s4_p19_a6);

%plottingFOURsensors(ns01_p19_a6, ns02_p19_a6, ns03_p19_a6, ns04_p19_a6, 2)

dlmwrite([p19_outcome_data_path 'a06_s01_p19'], ns01_p19_a6 ,'delimiter',',','precision',15);
dlmwrite([p19_outcome_data_path 'a06_s02_p19'], ns02_p19_a6 ,'delimiter',',','precision',15);
dlmwrite([p19_outcome_data_path 'a06_s03_p19'], ns03_p19_a6 ,'delimiter',',','precision',15);
dlmwrite([p19_outcome_data_path 'a06_s04_p19'], ns04_p19_a6 ,'delimiter',',','precision',15);











% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p19   TIME ALIGNMENT  FOR ACTIVITY _a7   %%%%%%%%%%%%%%%%
windowframe = p19_windowframe_a7;
t1_p19_a7 = p19_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p19_a7 = p19_s02m(windowframe,2);
t3_p19_a7 = p19_s03m(windowframe,2);
t4_p19_a7 = p19_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p19_a7 = p19_s01m(windowframe,3:15);
s2_p19_a7 = p19_s02m(windowframe,3:15);
s3_p19_a7 = p19_s03m(windowframe,3:15);
s4_p19_a7 = p19_s04m(windowframe,3:15);

[ns01_p19_a7, ns02_p19_a7, ns03_p19_a7, ns04_p19_a7] = sensors_timealignment_different_length(
							t1_p19_a7,t2_p19_a7,t3_p19_a7,t4_p19_a7, 
							s1_p19_a7,s2_p19_a7,s3_p19_a7,s4_p19_a7);

%plottingFOURsensors(ns01_p19_a7, ns02_p19_a7, ns03_p19_a7, ns04_p19_a7, 2)

dlmwrite([p19_outcome_data_path 'a07_s01_p19'], ns01_p19_a7 ,'delimiter',',','precision',15);
dlmwrite([p19_outcome_data_path 'a07_s02_p19'], ns02_p19_a7 ,'delimiter',',','precision',15);
dlmwrite([p19_outcome_data_path 'a07_s03_p19'], ns03_p19_a7 ,'delimiter',',','precision',15);
dlmwrite([p19_outcome_data_path 'a07_s04_p19'], ns04_p19_a7 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p19   TIME ALIGNMENT  FOR ACTIVITY _a8   %%%%%%%%%%%%%%%%
t1_p19_a8 = p19_s01m(p19_labels(8,4):p19_max_length_sensors(1),2);   %TimestampTx
t2_p19_a8 = p19_s02m(p19_labels(8,4):p19_max_length_sensors(2),2);
t3_p19_a8 = p19_s03m(p19_labels(8,4):p19_max_length_sensors(3),2);
t4_p19_a8 = p19_s04m(p19_labels(8,4):p19_max_length_sensors(4),2);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p19_a8 = p19_s01m(windowframe,3:15);
s2_p19_a8 = p19_s02m(windowframe,3:15);
s3_p19_a8 = p19_s03m(windowframe,3:15);
s4_p19_a8 = p19_s04m(windowframe,3:15);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p19_a8 = p19_s01m(p19_labels(8,4):p19_max_length_sensors(1),3:15);
s2_p19_a8 = p19_s02m(p19_labels(8,4):p19_max_length_sensors(2),3:15);
s3_p19_a8 = p19_s03m(p19_labels(8,4):p19_max_length_sensors(3),3:15);
s4_p19_a8 = p19_s04m(p19_labels(8,4):p19_max_length_sensors(4),3:15);

[ns01_p19_a8, ns02_p19_a8, ns03_p19_a8, ns04_p19_a8] = sensors_timealignment_different_length(
							t1_p19_a8,t2_p19_a8,t3_p19_a8,t4_p19_a8, 
							s1_p19_a8,s2_p19_a8,s3_p19_a8,s4_p19_a8);

%plottingFOURsensors(ns01_p19_a8, ns02_p19_a8, ns03_p19_a8, ns04_p19_a8, 2)

dlmwrite([p19_outcome_data_path 'a08_s01_p19'], ns01_p19_a8 ,'delimiter',',','precision',15);
dlmwrite([p19_outcome_data_path 'a08_s02_p19'], ns02_p19_a8 ,'delimiter',',','precision',15);
dlmwrite([p19_outcome_data_path 'a08_s03_p19'], ns03_p19_a8 ,'delimiter',',','precision',15);
dlmwrite([p19_outcome_data_path 'a08_s04_p19'], ns04_p19_a8 ,'delimiter',',','precision',15);







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  --  p21 -- %%%%%%%%%%%%%%%%%%%%%



p21_data_path = strcat(datapath,'/p21/p21-HII/');
[p21_s01m, p21_s02m, p21_s03m, p21_s04m, p21_max_length_sensors] = cvs2arrays(p21_data_path);
p21_labels = labels(161:168,:);



p21_windowframe_a1 = p21_labels(1,4):p21_labels(1,5);
p21_windowframe_a2 = p21_labels(2,4):p21_labels(2,5);
p21_windowframe_a3 = p21_labels(3,4):p21_labels(3,5);
p21_windowframe_a4 = p21_labels(4,4):p21_labels(4,5);
p21_windowframe_a5 = p21_labels(5,4):p21_labels(5,5);
p21_windowframe_a6 = p21_labels(6,4):p21_labels(6,5);
p21_windowframe_a7 = p21_labels(7,4):p21_labels(7,5);
%p21_windowframe_a8 HERE IS USED THE MAX LENGTH OF THE TIMESERIES

% CREATE PATH TO SAVE DATA
p21_split_path = strsplit(p21_data_path,'/');
p21_outcome_data_path = strcat(outcomes_path, p21_split_path(09),'/',p21_split_path(10),'/');
p21_outcome_data_path= char(p21_outcome_data_path);
if ~exist(p21_outcome_data_path,'dir');
  {
    myk =  cstrcat('system(',' ''mkdir', ' -p ',p21_outcome_data_path,''')');
    eval( sprintf(myk) );
  }
end



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p21   TIME ALIGNMENT  FOR ACTIVITY _a1   %%%%%%%%%%%%%%%%
windowframe = p21_windowframe_a1;
t1_p21_a1 = p21_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p21_a1 = p21_s02m(windowframe,2);
t3_p21_a1 = p21_s03m(windowframe,2);
t4_p21_a1 = p21_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p21_a1 = p21_s01m(windowframe,3:15);
s2_p21_a1 = p21_s02m(windowframe,3:15);
s3_p21_a1 = p21_s03m(windowframe,3:15);
s4_p21_a1 = p21_s04m(windowframe,3:15);

[ns01_p21_a1, ns02_p21_a1, ns03_p21_a1, ns04_p21_a1] = sensors_timealignment_different_length(
							t1_p21_a1,t2_p21_a1,t3_p21_a1,t4_p21_a1, 
							s1_p21_a1,s2_p21_a1,s3_p21_a1,s4_p21_a1);

%plottingFOURsensors(ns01_p21_a1, ns02_p21_a1, ns03_p21_a1, ns04_p21_a1, 2)

dlmwrite([p21_outcome_data_path 'a01_s01_p21'], ns01_p21_a1 ,'delimiter',',','precision',15);
dlmwrite([p21_outcome_data_path 'a01_s02_p21'], ns02_p21_a1 ,'delimiter',',','precision',15);
dlmwrite([p21_outcome_data_path 'a01_s03_p21'], ns03_p21_a1 ,'delimiter',',','precision',15);
dlmwrite([p21_outcome_data_path 'a01_s04_p21'], ns04_p21_a1 ,'delimiter',',','precision',15);




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p21   TIME ALIGNMENT  FOR ACTIVITY _a2   %%%%%%%%%%%%%%%%
windowframe = p21_windowframe_a2;
t1_p21_a2 = p21_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p21_a2 = p21_s02m(windowframe,2);
t3_p21_a2 = p21_s03m(windowframe,2);
t4_p21_a2 = p21_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p21_a2 = p21_s01m(windowframe,3:15);
s2_p21_a2 = p21_s02m(windowframe,3:15);
s3_p21_a2 = p21_s03m(windowframe,3:15);
s4_p21_a2 = p21_s04m(windowframe,3:15);

[ns01_p21_a2, ns02_p21_a2, ns03_p21_a2, ns04_p21_a2] = sensors_timealignment_different_length(
							t1_p21_a2,t2_p21_a2,t3_p21_a2,t4_p21_a2, 
							s1_p21_a2,s2_p21_a2,s3_p21_a2,s4_p21_a2);


%plottingFOURsensors(ns01_p21_a2, ns02_p21_a2, ns03_p21_a2, ns04_p21_a2, 2)

dlmwrite([p21_outcome_data_path 'a02_s01_p21'], ns01_p21_a2 ,'delimiter',',','precision',15);
dlmwrite([p21_outcome_data_path 'a02_s02_p21'], ns02_p21_a2 ,'delimiter',',','precision',15);
dlmwrite([p21_outcome_data_path 'a02_s03_p21'], ns03_p21_a2 ,'delimiter',',','precision',15);
dlmwrite([p21_outcome_data_path 'a02_s04_p21'], ns04_p21_a2 ,'delimiter',',','precision',15);







% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p21   TIME ALIGNMENT  FOR ACTIVITY _a3   %%%%%%%%%%%%%%%%
windowframe = p21_windowframe_a3;
t1_p21_a3 = p21_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p21_a3 = p21_s02m(windowframe,2);
t3_p21_a3 = p21_s03m(windowframe,2);
t4_p21_a3 = p21_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p21_a3 = p21_s01m(windowframe,3:15);
s2_p21_a3 = p21_s02m(windowframe,3:15);
s3_p21_a3 = p21_s03m(windowframe,3:15);
s4_p21_a3 = p21_s04m(windowframe,3:15);

[ns01_p21_a3, ns02_p21_a3, ns03_p21_a3, ns04_p21_a3] = sensors_timealignment_different_length(
							t1_p21_a3,t2_p21_a3,t3_p21_a3,t4_p21_a3, 
							s1_p21_a3,s2_p21_a3,s3_p21_a3,s4_p21_a3);

%plottingFOURsensors(ns01_p21_a3, ns02_p21_a3, ns03_p21_a3, ns04_p21_a3, 2)

dlmwrite([p21_outcome_data_path 'a03_s01_p21'], ns01_p21_a3 ,'delimiter',',','precision',15);
dlmwrite([p21_outcome_data_path 'a03_s02_p21'], ns02_p21_a3 ,'delimiter',',','precision',15);
dlmwrite([p21_outcome_data_path 'a03_s03_p21'], ns03_p21_a3 ,'delimiter',',','precision',15);
dlmwrite([p21_outcome_data_path 'a03_s04_p21'], ns04_p21_a3 ,'delimiter',',','precision',15);



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p21   TIME ALIGNMENT  FOR ACTIVITY _a4   %%%%%%%%%%%%%%%%
windowframe = p21_windowframe_a4;
t1_p21_a4 = p21_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p21_a4 = p21_s02m(windowframe,2);
t3_p21_a4 = p21_s03m(windowframe,2);
t4_p21_a4 = p21_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p21_a4 = p21_s01m(windowframe,3:15);
s2_p21_a4 = p21_s02m(windowframe,3:15);
s3_p21_a4 = p21_s03m(windowframe,3:15);
s4_p21_a4 = p21_s04m(windowframe,3:15);

[ns01_p21_a4, ns02_p21_a4, ns03_p21_a4, ns04_p21_a4] = sensors_timealignment_different_length(
							t1_p21_a4,t2_p21_a4,t3_p21_a4,t4_p21_a4, 
							s1_p21_a4,s2_p21_a4,s3_p21_a4,s4_p21_a4);

%plottingFOURsensors(ns01_p21_a4, ns02_p21_a4, ns03_p21_a4, ns04_p21_a4, 2)

dlmwrite([p21_outcome_data_path 'a04_s01_p21'], ns01_p21_a4 ,'delimiter',',','precision',15);
dlmwrite([p21_outcome_data_path 'a04_s02_p21'], ns02_p21_a4 ,'delimiter',',','precision',15);
dlmwrite([p21_outcome_data_path 'a04_s03_p21'], ns03_p21_a4 ,'delimiter',',','precision',15);
dlmwrite([p21_outcome_data_path 'a04_s04_p21'], ns04_p21_a4 ,'delimiter',',','precision',15);




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p21   TIME ALIGNMENT  FOR ACTIVITY _a5   %%%%%%%%%%%%%%%%
windowframe = p21_windowframe_a5;
t1_p21_a5 = p21_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p21_a5 = p21_s02m(windowframe,2);
t3_p21_a5 = p21_s03m(windowframe,2);
t4_p21_a5 = p21_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p21_a5 = p21_s01m(windowframe,3:15);
s2_p21_a5 = p21_s02m(windowframe,3:15);
s3_p21_a5 = p21_s03m(windowframe,3:15);
s4_p21_a5 = p21_s04m(windowframe,3:15);

[ns01_p21_a5, ns02_p21_a5, ns03_p21_a5, ns04_p21_a5] = sensors_timealignment_different_length(
							t1_p21_a5,t2_p21_a5,t3_p21_a5,t4_p21_a5, 
							s1_p21_a5,s2_p21_a5,s3_p21_a5,s4_p21_a5);

%plottingFOURsensors(ns01_p21_a5, ns02_p21_a5, ns03_p21_a5, ns04_p21_a5, 2)

dlmwrite([p21_outcome_data_path 'a05_s01_p21'], ns01_p21_a5 ,'delimiter',',','precision',15);
dlmwrite([p21_outcome_data_path 'a05_s02_p21'], ns02_p21_a5 ,'delimiter',',','precision',15);
dlmwrite([p21_outcome_data_path 'a05_s03_p21'], ns03_p21_a5 ,'delimiter',',','precision',15);
dlmwrite([p21_outcome_data_path 'a05_s04_p21'], ns04_p21_a5 ,'delimiter',',','precision',15);






% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p21   TIME ALIGNMENT  FOR ACTIVITY _a6   %%%%%%%%%%%%%%%%
windowframe = p21_windowframe_a6;
t1_p21_a6 = p21_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p21_a6 = p21_s02m(windowframe,2);
t3_p21_a6 = p21_s03m(windowframe,2);
t4_p21_a6 = p21_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p21_a6 = p21_s01m(windowframe,3:15);
s2_p21_a6 = p21_s02m(windowframe,3:15);
s3_p21_a6 = p21_s03m(windowframe,3:15);
s4_p21_a6 = p21_s04m(windowframe,3:15);

[ns01_p21_a6, ns02_p21_a6, ns03_p21_a6, ns04_p21_a6] = sensors_timealignment_different_length(
							t1_p21_a6,t2_p21_a6,t3_p21_a6,t4_p21_a6, 
							s1_p21_a6,s2_p21_a6,s3_p21_a6,s4_p21_a6);

%plottingFOURsensors(ns01_p21_a6, ns02_p21_a6, ns03_p21_a6, ns04_p21_a6, 2)

dlmwrite([p21_outcome_data_path 'a06_s01_p21'], ns01_p21_a6 ,'delimiter',',','precision',15);
dlmwrite([p21_outcome_data_path 'a06_s02_p21'], ns02_p21_a6 ,'delimiter',',','precision',15);
dlmwrite([p21_outcome_data_path 'a06_s03_p21'], ns03_p21_a6 ,'delimiter',',','precision',15);
dlmwrite([p21_outcome_data_path 'a06_s04_p21'], ns04_p21_a6 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p21   TIME ALIGNMENT  FOR ACTIVITY _a7   %%%%%%%%%%%%%%%%
windowframe = p21_windowframe_a7;
t1_p21_a7 = p21_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p21_a7 = p21_s02m(windowframe,2);
t3_p21_a7 = p21_s03m(windowframe,2);
t4_p21_a7 = p21_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p21_a7 = p21_s01m(windowframe,3:15);
s2_p21_a7 = p21_s02m(windowframe,3:15);
s3_p21_a7 = p21_s03m(windowframe,3:15);
s4_p21_a7 = p21_s04m(windowframe,3:15);

[ns01_p21_a7, ns02_p21_a7, ns03_p21_a7, ns04_p21_a7] = sensors_timealignment_different_length(
							t1_p21_a7,t2_p21_a7,t3_p21_a7,t4_p21_a7, 
							s1_p21_a7,s2_p21_a7,s3_p21_a7,s4_p21_a7);

%plottingFOURsensors(ns01_p21_a7, ns02_p21_a7, ns03_p21_a7, ns04_p21_a7, 2)

dlmwrite([p21_outcome_data_path 'a07_s01_p21'], ns01_p21_a7 ,'delimiter',',','precision',15);
dlmwrite([p21_outcome_data_path 'a07_s02_p21'], ns02_p21_a7 ,'delimiter',',','precision',15);
dlmwrite([p21_outcome_data_path 'a07_s03_p21'], ns03_p21_a7 ,'delimiter',',','precision',15);
dlmwrite([p21_outcome_data_path 'a07_s04_p21'], ns04_p21_a7 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p21   TIME ALIGNMENT  FOR ACTIVITY _a8   %%%%%%%%%%%%%%%%
t1_p21_a8 = p21_s01m(p21_labels(8,4):p21_max_length_sensors(1),2);   %TimestampTx
t2_p21_a8 = p21_s02m(p21_labels(8,4):p21_max_length_sensors(2),2);
t3_p21_a8 = p21_s03m(p21_labels(8,4):p21_max_length_sensors(3),2);
t4_p21_a8 = p21_s04m(p21_labels(8,4):p21_max_length_sensors(4),2);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p21_a8 = p21_s01m(windowframe,3:15);
s2_p21_a8 = p21_s02m(windowframe,3:15);
s3_p21_a8 = p21_s03m(windowframe,3:15);
s4_p21_a8 = p21_s04m(windowframe,3:15);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p21_a8 = p21_s01m(p21_labels(8,4):p21_max_length_sensors(1),3:15);
s2_p21_a8 = p21_s02m(p21_labels(8,4):p21_max_length_sensors(2),3:15);
s3_p21_a8 = p21_s03m(p21_labels(8,4):p21_max_length_sensors(3),3:15);
s4_p21_a8 = p21_s04m(p21_labels(8,4):p21_max_length_sensors(4),3:15);

[ns01_p21_a8, ns02_p21_a8, ns03_p21_a8, ns04_p21_a8] = sensors_timealignment_different_length(
							t1_p21_a8,t2_p21_a8,t3_p21_a8,t4_p21_a8, 
							s1_p21_a8,s2_p21_a8,s3_p21_a8,s4_p21_a8);

 %plottingFOURsensors(ns01_p21_a8, ns02_p21_a8, ns03_p21_a8, ns04_p21_a8, 2)

dlmwrite([p21_outcome_data_path 'a08_s01_p21'], ns01_p21_a8 ,'delimiter',',','precision',15);
dlmwrite([p21_outcome_data_path 'a08_s02_p21'], ns02_p21_a8 ,'delimiter',',','precision',15);
dlmwrite([p21_outcome_data_path 'a08_s03_p21'], ns03_p21_a8 ,'delimiter',',','precision',15);
dlmwrite([p21_outcome_data_path 'a08_s04_p21'], ns04_p21_a8 ,'delimiter',',','precision',15);





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%  --  p22 -- %%%%%%%%%%%%%%%%%%%%%



p22_data_path = strcat(datapath,'/p22/p22-HII/');
[p22_s01m, p22_s02m, p22_s03m, p22_s04m, p22_max_length_sensors] = cvs2arrays(p22_data_path);
p22_labels = labels(169:176,:);



p22_windowframe_a1 = p22_labels(1,4):p22_labels(1,5);
p22_windowframe_a2 = p22_labels(2,4):p22_labels(2,5);
p22_windowframe_a3 = p22_labels(3,4):p22_labels(3,5);
p22_windowframe_a4 = p22_labels(4,4):p22_labels(4,5);
p22_windowframe_a5 = p22_labels(5,4):p22_labels(5,5);
p22_windowframe_a6 = p22_labels(6,4):p22_labels(6,5);
p22_windowframe_a7 = p22_labels(7,4):p22_labels(7,5);
%p22_windowframe_a8 HERE IS USED THE MAX LENGTH OF THE TIMESERIES

% CREATE PATH TO SAVE DATA
p22_split_path = strsplit(p22_data_path,'/');
p22_outcome_data_path = strcat(outcomes_path, p22_split_path(09),'/',p22_split_path(10),'/');
p22_outcome_data_path= char(p22_outcome_data_path);
if ~exist(p22_outcome_data_path,'dir');
  {
    myk =  cstrcat('system(',' ''mkdir', ' -p ',p22_outcome_data_path,''')');
    eval( sprintf(myk) );
  }
end



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p22   TIME ALIGNMENT  FOR ACTIVITY _a1   %%%%%%%%%%%%%%%%
windowframe = p22_windowframe_a1;
t1_p22_a1 = p22_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p22_a1 = p22_s02m(windowframe,2);
t3_p22_a1 = p22_s03m(windowframe,2);
t4_p22_a1 = p22_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p22_a1 = p22_s01m(windowframe,3:15);
s2_p22_a1 = p22_s02m(windowframe,3:15);
s3_p22_a1 = p22_s03m(windowframe,3:15);
s4_p22_a1 = p22_s04m(windowframe,3:15);

[ns01_p22_a1, ns02_p22_a1, ns03_p22_a1, ns04_p22_a1] = sensors_timealignment_different_length(
							t1_p22_a1,t2_p22_a1,t3_p22_a1,t4_p22_a1, 
							s1_p22_a1,s2_p22_a1,s3_p22_a1,s4_p22_a1);

%plottingFOURsensors(ns01_p22_a1, ns02_p22_a1, ns03_p22_a1, ns04_p22_a1, 2)

dlmwrite([p22_outcome_data_path 'a01_s01_p22'], ns01_p22_a1 ,'delimiter',',','precision',15);
dlmwrite([p22_outcome_data_path 'a01_s02_p22'], ns02_p22_a1 ,'delimiter',',','precision',15);
dlmwrite([p22_outcome_data_path 'a01_s03_p22'], ns03_p22_a1 ,'delimiter',',','precision',15);
dlmwrite([p22_outcome_data_path 'a01_s04_p22'], ns04_p22_a1 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p22   TIME ALIGNMENT  FOR ACTIVITY _a2   %%%%%%%%%%%%%%%%
windowframe = p22_windowframe_a2;
t1_p22_a2 = p22_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p22_a2 = p22_s02m(windowframe,2);
t3_p22_a2 = p22_s03m(windowframe,2);
t4_p22_a2 = p22_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p22_a2 = p22_s01m(windowframe,3:15);
s2_p22_a2 = p22_s02m(windowframe,3:15);
s3_p22_a2 = p22_s03m(windowframe,3:15);
s4_p22_a2 = p22_s04m(windowframe,3:15);

[ns01_p22_a2, ns02_p22_a2, ns03_p22_a2, ns04_p22_a2] = sensors_timealignment_different_length(
							t1_p22_a2,t2_p22_a2,t3_p22_a2,t4_p22_a2, 
							s1_p22_a2,s2_p22_a2,s3_p22_a2,s4_p22_a2);


%plottingFOURsensors(ns01_p22_a2, ns02_p22_a2, ns03_p22_a2, ns04_p22_a2, 2)

dlmwrite([p22_outcome_data_path 'a02_s01_p22'], ns01_p22_a2 ,'delimiter',',','precision',15);
dlmwrite([p22_outcome_data_path 'a02_s02_p22'], ns02_p22_a2 ,'delimiter',',','precision',15);
dlmwrite([p22_outcome_data_path 'a02_s03_p22'], ns03_p22_a2 ,'delimiter',',','precision',15);
dlmwrite([p22_outcome_data_path 'a02_s04_p22'], ns04_p22_a2 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p22   TIME ALIGNMENT  FOR ACTIVITY _a3   %%%%%%%%%%%%%%%%
windowframe = p22_windowframe_a3;
t1_p22_a3 = p22_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p22_a3 = p22_s02m(windowframe,2);
t3_p22_a3 = p22_s03m(windowframe,2);
t4_p22_a3 = p22_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p22_a3 = p22_s01m(windowframe,3:15);
s2_p22_a3 = p22_s02m(windowframe,3:15);
s3_p22_a3 = p22_s03m(windowframe,3:15);
s4_p22_a3 = p22_s04m(windowframe,3:15);

[ns01_p22_a3, ns02_p22_a3, ns03_p22_a3, ns04_p22_a3] = sensors_timealignment_different_length(
							t1_p22_a3,t2_p22_a3,t3_p22_a3,t4_p22_a3, 
							s1_p22_a3,s2_p22_a3,s3_p22_a3,s4_p22_a3);

%plottingFOURsensors(ns01_p22_a3, ns02_p22_a3, ns03_p22_a3, ns04_p22_a3, 2)

dlmwrite([p22_outcome_data_path 'a03_s01_p22'], ns01_p22_a3 ,'delimiter',',','precision',15);
dlmwrite([p22_outcome_data_path 'a03_s02_p22'], ns02_p22_a3 ,'delimiter',',','precision',15);
dlmwrite([p22_outcome_data_path 'a03_s03_p22'], ns03_p22_a3 ,'delimiter',',','precision',15);
dlmwrite([p22_outcome_data_path 'a03_s04_p22'], ns04_p22_a3 ,'delimiter',',','precision',15);




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p22   TIME ALIGNMENT  FOR ACTIVITY _a4   %%%%%%%%%%%%%%%%
windowframe = p22_windowframe_a4;
t1_p22_a4 = p22_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p22_a4 = p22_s02m(windowframe,2);
t3_p22_a4 = p22_s03m(windowframe,2);
t4_p22_a4 = p22_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p22_a4 = p22_s01m(windowframe,3:15);
s2_p22_a4 = p22_s02m(windowframe,3:15);
s3_p22_a4 = p22_s03m(windowframe,3:15);
s4_p22_a4 = p22_s04m(windowframe,3:15);

[ns01_p22_a4, ns02_p22_a4, ns03_p22_a4, ns04_p22_a4] = sensors_timealignment_different_length(
							t1_p22_a4,t2_p22_a4,t3_p22_a4,t4_p22_a4, 
							s1_p22_a4,s2_p22_a4,s3_p22_a4,s4_p22_a4);

%plottingFOURsensors(ns01_p22_a4, ns02_p22_a4, ns03_p22_a4, ns04_p22_a4, 2)

dlmwrite([p22_outcome_data_path 'a04_s01_p22'], ns01_p22_a4 ,'delimiter',',','precision',15);
dlmwrite([p22_outcome_data_path 'a04_s02_p22'], ns02_p22_a4 ,'delimiter',',','precision',15);
dlmwrite([p22_outcome_data_path 'a04_s03_p22'], ns03_p22_a4 ,'delimiter',',','precision',15);
dlmwrite([p22_outcome_data_path 'a04_s04_p22'], ns04_p22_a4 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p22   TIME ALIGNMENT  FOR ACTIVITY _a5   %%%%%%%%%%%%%%%%
windowframe = p22_windowframe_a5;
t1_p22_a5 = p22_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p22_a5 = p22_s02m(windowframe,2);
t3_p22_a5 = p22_s03m(windowframe,2);
t4_p22_a5 = p22_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p22_a5 = p22_s01m(windowframe,3:15);
s2_p22_a5 = p22_s02m(windowframe,3:15);
s3_p22_a5 = p22_s03m(windowframe,3:15);
s4_p22_a5 = p22_s04m(windowframe,3:15);

[ns01_p22_a5, ns02_p22_a5, ns03_p22_a5, ns04_p22_a5] = sensors_timealignment_different_length(
							t1_p22_a5,t2_p22_a5,t3_p22_a5,t4_p22_a5, 
							s1_p22_a5,s2_p22_a5,s3_p22_a5,s4_p22_a5);

%plottingFOURsensors(ns01_p22_a5, ns02_p22_a5, ns03_p22_a5, ns04_p22_a5, 2)

dlmwrite([p22_outcome_data_path 'a05_s01_p22'], ns01_p22_a5 ,'delimiter',',','precision',15);
dlmwrite([p22_outcome_data_path 'a05_s02_p22'], ns02_p22_a5 ,'delimiter',',','precision',15);
dlmwrite([p22_outcome_data_path 'a05_s03_p22'], ns03_p22_a5 ,'delimiter',',','precision',15);
dlmwrite([p22_outcome_data_path 'a05_s04_p22'], ns04_p22_a5 ,'delimiter',',','precision',15);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p22   TIME ALIGNMENT  FOR ACTIVITY _a6   %%%%%%%%%%%%%%%%
windowframe = p22_windowframe_a6;
t1_p22_a6 = p22_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p22_a6 = p22_s02m(windowframe,2);
t3_p22_a6 = p22_s03m(windowframe,2);
t4_p22_a6 = p22_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p22_a6 = p22_s01m(windowframe,3:15);
s2_p22_a6 = p22_s02m(windowframe,3:15);
s3_p22_a6 = p22_s03m(windowframe,3:15);
s4_p22_a6 = p22_s04m(windowframe,3:15);

[ns01_p22_a6, ns02_p22_a6, ns03_p22_a6, ns04_p22_a6] = sensors_timealignment_different_length(
							t1_p22_a6,t2_p22_a6,t3_p22_a6,t4_p22_a6, 
							s1_p22_a6,s2_p22_a6,s3_p22_a6,s4_p22_a6);

%plottingFOURsensors(ns01_p22_a6, ns02_p22_a6, ns03_p22_a6, ns04_p22_a6, 2)

dlmwrite([p22_outcome_data_path 'a06_s01_p22'], ns01_p22_a6 ,'delimiter',',','precision',15);
dlmwrite([p22_outcome_data_path 'a06_s02_p22'], ns02_p22_a6 ,'delimiter',',','precision',15);
dlmwrite([p22_outcome_data_path 'a06_s03_p22'], ns03_p22_a6 ,'delimiter',',','precision',15);
dlmwrite([p22_outcome_data_path 'a06_s04_p22'], ns04_p22_a6 ,'delimiter',',','precision',15);






% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p22   TIME ALIGNMENT  FOR ACTIVITY _a7   %%%%%%%%%%%%%%%%
windowframe = p22_windowframe_a7;
t1_p22_a7 = p22_s01m(windowframe,2);   %[2]  <---->  [TimestampTx]
t2_p22_a7 = p22_s02m(windowframe,2);
t3_p22_a7 = p22_s03m(windowframe,2);
t4_p22_a7 = p22_s04m(windowframe,2);
% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p22_a7 = p22_s01m(windowframe,3:15);
s2_p22_a7 = p22_s02m(windowframe,3:15);
s3_p22_a7 = p22_s03m(windowframe,3:15);
s4_p22_a7 = p22_s04m(windowframe,3:15);

%[ns01_p22_a7, ns02_p22_a7, ns03_p22_a7, ns04_p22_a7] = sensors_timealignment_different_length(
[ns01_p22_a7, ns02_p22_a7, ns03_p22_a7, ns04_p22_a7] = sensors_timealignment_different_length_inverted_maxmin_vectors(
							t1_p22_a7,t2_p22_a7,t3_p22_a7,t4_p22_a7, 
							s1_p22_a7,s2_p22_a7,s3_p22_a7,s4_p22_a7);

%plottingFOURsensors(ns01_p22_a7, ns02_p22_a7, ns03_p22_a7, ns04_p22_a7, 2)

dlmwrite([p22_outcome_data_path 'a07_s01_p22'], ns01_p22_a7 ,'delimiter',',','precision',15);
dlmwrite([p22_outcome_data_path 'a07_s02_p22'], ns02_p22_a7 ,'delimiter',',','precision',15);
dlmwrite([p22_outcome_data_path 'a07_s03_p22'], ns03_p22_a7 ,'delimiter',',','precision',15);
dlmwrite([p22_outcome_data_path 'a07_s04_p22'], ns04_p22_a7 ,'delimiter',',','precision',15);








% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p22   TIME ALIGNMENT  FOR ACTIVITY _a8   %%%%%%%%%%%%%%%%
t1_p22_a8 = p22_s01m(p22_labels(8,4):p22_max_length_sensors(1),2);   %TimestampTx
t2_p22_a8 = p22_s02m(p22_labels(8,4):p22_max_length_sensors(2),2);
t3_p22_a8 = p22_s03m(p22_labels(8,4):p22_max_length_sensors(3),2);
t4_p22_a8 = p22_s04m(p22_labels(8,4):p22_max_length_sensors(4),2);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p22_a8 = p22_s01m(windowframe,3:15);
s2_p22_a8 = p22_s02m(windowframe,3:15);
s3_p22_a8 = p22_s03m(windowframe,3:15);
s4_p22_a8 = p22_s04m(windowframe,3:15);


% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p22_a8 = p22_s01m(p22_labels(8,4):p22_max_length_sensors(1),3:15);
s2_p22_a8 = p22_s02m(p22_labels(8,4):p22_max_length_sensors(2),3:15);
s3_p22_a8 = p22_s03m(p22_labels(8,4):p22_max_length_sensors(3),3:15);
s4_p22_a8 = p22_s04m(p22_labels(8,4):p22_max_length_sensors(4),3:15);

[ns01_p22_a8, ns02_p22_a8, ns03_p22_a8, ns04_p22_a8] = sensors_timealignment_different_length(
							t1_p22_a8,t2_p22_a8,t3_p22_a8,t4_p22_a8, 
							s1_p22_a8,s2_p22_a8,s3_p22_a8,s4_p22_a8);

%plottingFOURsensors(ns01_p22_a8, ns02_p22_a8, ns03_p22_a8, ns04_p22_a8, 2)

dlmwrite([p22_outcome_data_path 'a08_s01_p22'], ns01_p22_a8 ,'delimiter',',','precision',15);
dlmwrite([p22_outcome_data_path 'a08_s02_p22'], ns02_p22_a8 ,'delimiter',',','precision',15);
dlmwrite([p22_outcome_data_path 'a08_s03_p22'], ns03_p22_a8 ,'delimiter',',','precision',15);
dlmwrite([p22_outcome_data_path 'a08_s04_p22'], ns04_p22_a8 ,'delimiter',',','precision',15);








% Go back to the m-scripts_path
cd(m_scripts_path)
