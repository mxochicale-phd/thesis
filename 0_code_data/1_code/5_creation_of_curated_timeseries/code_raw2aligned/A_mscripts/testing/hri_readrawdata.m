%

% USAGE
% octave --no-gui
% readrawdataHRI

%  M-Script to read data files for SIX participant from \data_P01-P22.
%  Data is separated by using labels00.txt in four activitities (a1,...,a4).
%

% Written by Miguel P Xochicale [http://mxochicale.github.io]
%
% If you see any errors or have any questions
% please create an issue at https://github.com/mxochicale/phd-thesis-code-data/issues
%


format long;
clear; % Clear all variables and functions from memory


m_scripts_path = pwd;
source("MyFunctions_octave_linux.m");

cd ..;
cd ..;
main_path = pwd;

data_path='/data_raw_p01-p22';
datapath=strcat(main_path, data_path);


p01_data_path = strcat(datapath,'/p01/p01-HRI/');
[p01_s01m, p01_s02m, p01_s03m, p01_s04m, p01_max_length_sensors] = cvs2arrays(p01_data_path);

%p02_data_path = strcat(datapath,'/p02/p02-HRI/');
%[p02_s01m, p02_s02m, p02_s03m, p02_s04m, p02_max_length_sensors] = cvs2arrays(p02_data_path);
%
%p03_data_path = strcat(datapath,'/p03/p03-HRI/');
%[p03_s01m, p03_s02m, p03_s03m, p03_s04m, p03_max_length_sensors] = cvs2arrays(p03_data_path);
%
%p04_data_path = strcat(datapath,'/p04/p04-HRI/');
%[p04_s01m, p04_s02m, p04_s03m, p04_s04m, p04_max_length_sensors] = cvs2arrays(p04_data_path);
%
%p05_data_path = strcat(datapath,'/p05/p05-HRI/');
%[p05_s01m, p05_s02m, p05_s03m, p05_s04m, p05_max_length_sensors] = cvs2arrays(p05_data_path);
%
%p06_data_path = strcat(datapath,'/p06/p06-HRI/');
%[p06_s01m, p06_s02m, p06_s03m, p06_s04m, p06_max_length_sensors] = cvs2arrays(p06_data_path);





%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Using Labels
%%%%%% activity_labels.txt
% 1 horizontal_arm_movement_at_normal_speed
% 2 vertical_arm_movement_at_normal_speed
% 3 horizontal_arm_movement_at_faster_speed
% 4 vertical_arm movement_at_faster_speed

%%%%%% Description of labels.txt
% Column 1 experiment number ID
% Column 2 user number ID
% Column 3 activity number ID
% Column 4 Label start sample (number of sample in the original file)
% Column 5 Label stop sample (number of sample in the original file)

path_filename = fullfile(m_scripts_path,'/labels_p01-p06.txt');
%path_filename = fullfile(current_path,'/m-scripts/labels_p01-p06.txt');
labels = importdata(path_filename);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  --  p01 -- %%%%%%%%%%%%%%%%%%%%%
p01_labels = labels(1:4,:);
p01_windowframe_a1 = p01_labels(1,4):p01_labels(1,5);
p01_windowframe_a2 = p01_labels(2,4):p01_labels(2,5);
p01_windowframe_a3 = p01_labels(3,4):p01_labels(3,5);




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p01   TIME ALIGNMENT  FOR ACTIVITY 01   %%%%%%%%%%%%%%%%
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

[ns01_p01_a1, ns02_p01_a1, ns03_p01_a1, ns04_p01_a1] = sensors_timealignment_different_length(t1_p01_a1,t2_p01_a1,t3_p01_a1,t4_p01_a1,s1_p01_a1,s2_p01_a1,s3_p01_a1,s4_p01_a1);





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%  p01   TIME ALIGNMENT  FOR ACTIVITY 02   %%%%%%%%%%%%%%%%
windowframe = p01_windowframe_a2;
t1_p01_a2 = p01_s01m(windowframe,2);    %[2]  <---->  [TimestampTx]
t2_p01_a2 = p01_s02m(windowframe,2);
t3_p01_a2 = p01_s03m(windowframe,2);
t4_p01_a2 = p01_s04m(windowframe,2);

% [3:15] <---> [    AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p01_a2 = p01_s01m(windowframe,3:15);
s2_p01_a2 = p01_s02m(windowframe,3:15);
s3_p01_a2 = p01_s03m(windowframe,3:15);
s4_p01_a2 = p01_s04m(windowframe,3:15);

[ns01_p01_a2, ns02_p01_a2, ns03_p01_a2, ns04_p01_a2] = sensors_timealignment_different_length(t1_p01_a2,t2_p01_a2,t3_p01_a2,t4_p01_a2,s1_p01_a2,s2_p01_a2,s3_p01_a2,s4_p01_a2);


% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % %%%%%%%%%%%%%%%%  p01   TIME ALIGNMENT  FOR ACTIVITY 03   %%%%%%%%%%%%%%%%
windowframe = p01_windowframe_a3;
t1_p01_a3 = p01_s01m(windowframe,2);    %[2]  <---->  [TimestampTx]
t2_p01_a3 = p01_s02m(windowframe,2);
t3_p01_a3 = p01_s03m(windowframe,2);
t4_p01_a3 = p01_s04m(windowframe,2);

% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p01_a3 = p01_s01m(windowframe,3:15);
s2_p01_a3 = p01_s02m(windowframe,3:15);
s3_p01_a3 = p01_s03m(windowframe,3:15);
s4_p01_a3 = p01_s04m(windowframe,3:15);

[ns01_p01_a3, ns02_p01_a3, ns03_p01_a3, ns04_p01_a3] = sensors_timealignment_different_length(t1_p01_a3,t2_p01_a3,t3_p01_a3,t4_p01_a3,s1_p01_a3,s2_p01_a3,s3_p01_a3,s4_p01_a3);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%  p01   TIME ALIGNMENT  FOR ACTIVITY 04   %%%%%%%%%%%%%%%%
t1_p01_a4 = p01_s01m(p01_labels(4,4):p01_max_length_sensors(1),2);   %TimestampTx
t2_p01_a4 = p01_s02m(p01_labels(4,4):p01_max_length_sensors(2),2);
t3_p01_a4 = p01_s03m(p01_labels(4,4):p01_max_length_sensors(3),2);
t4_p01_a4 = p01_s04m(p01_labels(4,4):p01_max_length_sensors(4),2);

% [3:15] <---> [  AccX    AccY    AccZ    MagnX   MagnY   MagnZ   GyroX   GyroY   GyroZ   qW      qX      qY      qZ ]
s1_p01_a4 = p01_s01m(p01_labels(4,4):p01_max_length_sensors(1),3:15);
s2_p01_a4 = p01_s02m(p01_labels(4,4):p01_max_length_sensors(2),3:15);
s3_p01_a4 = p01_s03m(p01_labels(4,4):p01_max_length_sensors(3),3:15);
s4_p01_a4 = p01_s04m(p01_labels(4,4):p01_max_length_sensors(4),3:15);

[ns01_p01_a4, ns02_p01_a4, ns03_p01_a4, ns04_p01_a4] = sensors_timealignment_different_length(t1_p01_a4,t2_p01_a4,t3_p01_a4,t4_p01_a4,s1_p01_a4,s2_p01_a4,s3_p01_a4,s4_p01_a4);


subplot(2,2,1)
plot(ns01_p01_a1(:,2), 'LineWidth',2)
subplot(2,2,2)
plot(ns01_p01_a2(:,2), 'LineWidth',2)
subplot(2,2,3)
plot(ns01_p01_a3(:,2), 'LineWidth',2)
subplot(2,2,4)
plot(ns01_p01_a4(:,2), 'LineWidth',2)



% Go back to the m-scripts_path
cd(m_scripts_path)
