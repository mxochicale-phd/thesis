

% To use this collection of functions, you have to source the m-file, e.g.
% source("MyFunctions_octave_linux.m");
% In MATLAB, you can try to group functions in one main file
% then calling subfunctions  [stackoverflow.com/questions/3569933]


%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%  FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [s01, s02, s03, s04, max_length_sensors] = cvs2arrays(sensor_data_path)
  % This function reads the values from the sensor_data_path
  % and convert them into arrays s01m, s02m, s03m, s04m
  %%% Define files variables which save an structure of the current files of
  %%% the path
  files=dir([sensor_data_path,'*']);

  clocks  = dlmread(  [sensor_data_path,files(2).name]  );
  s01  = dlmread(  [sensor_data_path,files(3).name]  );
  s02  = dlmread(  [sensor_data_path,files(4).name]  );
  s03  = dlmread(  [sensor_data_path,files(5).name]  );
  s04  = dlmread(  [sensor_data_path,files(6).name]  );

  #Delete first row
  clocks(1,:)=[];
  s01(1,:)=[];
  s02(1,:)=[];
  s03(1,:)=[];
  s04(1,:)=[];

  %%%% Update the time variable that sinchronise the data
  tnew = (s01(:,2) /clocks(1,2)) - clocks(1,3);
  s01(:,2) = tnew;

  tnew = (s02(:,2) /clocks(2,2)) - clocks(2,3);
  s02(:,2) = tnew;

  tnew = (s03(:,2) /clocks(3,2)) - clocks(3,3);
  s03(:,2) = tnew;

  tnew = (s04(:,2) /clocks(4,2)) - clocks(4,3);
  s04(:,2) = tnew;

  max_length_sensors = [ length(s01), length(s02), length(s03), length(s04) ];

endfunction





function [ns01, ns02, ns03, ns04] = sensors_timealignment(t1,t2,t3,t4,s1,s2,s3,s4)
  % [ns01, ns02, ns03, ns04] = sensors_timealignment(t1,t2,t3,t4,s1,s2,s3,s4)
  [start_time_max_val,index_stmax ] = max([t1(1),t2(1),t3(1),t4(1)]);
  [start_time_min_val,index_stmin ] = min([t1(1),t2(1),t3(1),t4(1)]);

  [end_time_min_val,index_etmin] = min([t1(end),t2(end),t3(end),t4(end)]);
  [end_time_max_val,index_etmax] = max([t1(end),t2(end),t3(end),t4(end)]);


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % FOR SENSORS 1 and 2
  %%%% t1 -t2 which align the end of s1 and s2
  start_repstar = repelems(start_time_max_val,[1;length(t1)]);
  start_dif = abs(t1-start_repstar');
  [sv,si]=min(start_dif);

  end_repstar = repelems(end_time_min_val,[1;length(t1)]);
  end_dif = abs(t1-end_repstar');
  [ev,ei]=min(end_dif);

  newt1 = t1(si:ei);
  news1 = s1(si:ei,:);


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % FOR SENSORS 1 and 2
  start_repstar = repelems(start_time_max_val,[1;length(t2)]);
  start_dif = abs(t2-start_repstar');
  [sv,si]=min(start_dif);

  end_repstar = repelems(end_time_min_val,[1;length(t2)]);
  end_dif = abs(t2-end_repstar');
  [ev,ei]=min(end_dif);

  newt2 = t2(si:ei);
  news2 = s2(si:ei,:);


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % FOR SENSORS 1 and 3
  start_repstar = repelems(start_time_max_val,[1;length(t3)]);
  start_dif = abs(t3-start_repstar');
  [sv,si]=min(start_dif);

  end_repstar = repelems(end_time_min_val,[1;length(t3)]);
  end_dif = abs(t3-end_repstar');
  [ev,ei]=min(end_dif);

  newt3 = t3(si:ei);
  news3 = s3(si:ei,:);


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % FOR SENSORS 1 and 4
  start_repstar = repelems(start_time_max_val,[1;length(t4)]);
  start_dif = abs(t4-start_repstar');
  [sv,si] = min(start_dif);

  end_repstar = repelems(end_time_min_val,[1;length(t4)]);
  end_dif = abs(t4-end_repstar');
  [ev,ei] = min(end_dif);

  newt4 = t4(si:ei);
  news4 = s4(si:ei,:);


%%% interpolation to get the same length per sensor variable
%pchip: Piecewise cubic Hermite interpolating polynomial -- shape-preserving interpolation
%with smooth first derivative
  inewt1 = interp1(newt1,newt1,newt2,'pchip');
  inews1 = interp1(newt1,news1,newt2,'pchip');

  inewt2 = interp1(newt2,newt2,newt2,'pchip');
  inews2 = interp1(newt2,news2,newt2,'pchip');

  inewt3 = interp1(newt3,newt3,newt2,'pchip');
  inews3 = interp1(newt3,news3,newt2,'pchip');

  inewt4 = interp1(newt4,newt4,newt2,'pchip');
  inews4 = interp1(newt4,news4,newt2,'pchip');

  ns01 = [inewt1 , inews1];
  ns02 = [inewt2 , inews2];
  ns03 = [inewt3 , inews3];
  ns04 = [inewt4 , inews4];

endfunction




function [ns01, ns02, ns03, ns04] = sensors_timealignment_different_length(t1,t2,t3,t4,s1,s2,s3,s4)
  % [ns01, ns02, ns03, ns04] = sensors_timealignment(t1,t2,t3,t4,s1,s2,s3,s4)
  [start_time_max_val,index_stmax ] = max([t1(1),t2(1),t3(1),t4(1)]);
  [start_time_min_val,index_stmin ] = min([t1(1),t2(1),t3(1),t4(1)]);

  [end_time_min_val,index_etmin] = min([t1(end),t2(end),t3(end),t4(end)]);
  [end_time_max_val,index_etmax] = max([t1(end),t2(end),t3(end),t4(end)]);


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % FOR SENSORS 1 and 2
  %%%% t1 -t2 which align the end of s1 and s2
  start_repstar = repelems(start_time_max_val,[1;length(t1)]);
  start_dif = abs(t1-start_repstar');
  [sv,si]=min(start_dif);

  end_repstar = repelems(end_time_min_val,[1;length(t1)]);
  end_dif = abs(t1-end_repstar');
  [ev,ei]=min(end_dif);

  newt1 = t1(si:ei);
  news1 = s1(si:ei,:);


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % FOR SENSORS 1 and 2
  start_repstar = repelems(start_time_max_val,[1;length(t2)]);
  start_dif = abs(t2-start_repstar');
  [sv,si]=min(start_dif);

  end_repstar = repelems(end_time_min_val,[1;length(t2)]);
  end_dif = abs(t2-end_repstar');
  [ev,ei]=min(end_dif);

  newt2 = t2(si:ei);
  news2 = s2(si:ei,:);


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % FOR SENSORS 1 and 3
  start_repstar = repelems(start_time_max_val,[1;length(t3)]);
  start_dif = abs(t3-start_repstar');
  [sv,si]=min(start_dif);

  end_repstar = repelems(end_time_min_val,[1;length(t3)]);
  end_dif = abs(t3-end_repstar');
  [ev,ei]=min(end_dif);

  newt3 = t3(si:ei);
  news3 = s3(si:ei,:);


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % FOR SENSORS 1 and 4
  start_repstar = repelems(start_time_max_val,[1;length(t4)]);
  start_dif = abs(t4-start_repstar');
  [sv,si] = min(start_dif);

  end_repstar = repelems(end_time_min_val,[1;length(t4)]);
  end_dif = abs(t4-end_repstar');
  [ev,ei] = min(end_dif);

  newt4 = t4(si:ei);
  news4 = s4(si:ei,:);


%%%% interpolation to get the same length per sensor variable
%%pchip: Piecewise cubic Hermite interpolating polynomial -- shape-preserving interpolation
%%with smooth first derivative
%  inewt1 = interp1(newt1,newt1,newt2,'pchip');
%  inews1 = interp1(newt1,news1,newt2,'pchip');
%
%  inewt2 = interp1(newt2,newt2,newt2,'pchip');
%  inews2 = interp1(newt2,news2,newt2,'pchip');
%
%  inewt3 = interp1(newt3,newt3,newt2,'pchip');
%  inews3 = interp1(newt3,news3,newt2,'pchip');
%
%  inewt4 = interp1(newt4,newt4,newt2,'pchip');
%  inews4 = interp1(newt4,news4,newt2,'pchip');
%
%  ns01 = [inewt1 , inews1];
%  ns02 = [inewt2 , inews2];
%  ns03 = [inewt3 , inews3];
%  ns04 = [inewt4 , inews4];


% tempsize = [size(newt1), size(newt2), size(newt3), size(newt4)]

  ns01 = [newt1 , news1];
  ns02 = [newt2 , news2];
  ns03 = [newt3 , news3];
  ns04 = [newt4 , news4];

endfunction








function [ns01, ns02, ns03, ns04] = sensors_timealignment_different_length_p16(t1,t2,t3,t4,s1,s2,s3,s4)
  % [ns01, ns02, ns03, ns04] = sensors_timealignment(t1,t2,t3,t4,s1,s2,s3,s4)

  % % Original
  % [start_time_max_val,index_stmax ] = max([t1(1),t2(1),t3(1),t4(1)])
  % [start_time_min_val,index_stmin ] = min([t1(1),t2(1),t3(1),t4(1)])
  % [end_time_min_val,index_etmin] = min([t1(end),t2(end),t3(end),t4(end)])
  % [end_time_max_val,index_etmax] = max([t1(end),t2(end),t3(end),t4(end)])


  % Inverted max and min vectors
  [start_time_max_val,index_stmax ] = min([t1(1),t2(1),t3(1),t4(1)]);
  [start_time_min_val,index_stmin ] = max([t1(1),t2(1),t3(1),t4(1)]);
  [end_time_min_val,index_etmin] = max([t1(end),t2(end),t3(end),t4(end)]);
  [end_time_max_val,index_etmax] = min([t1(end),t2(end),t3(end),t4(end)]);


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % FOR SENSORS 1 and 2
  %%%% t1 -t2 which align the end of s1 and s2
  start_repstar = repelems(start_time_max_val,[1;length(t1)]);
  start_dif = abs(t1-start_repstar');
  [sv,si]=min(start_dif);

  end_repstar = repelems(end_time_min_val,[1;length(t1)]);
  end_dif = abs(t1-end_repstar');
  [ev,ei]=min(end_dif);

  newt1 = t1(si:ei);
  news1 = s1(si:ei,:);


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % FOR SENSORS 1 and 2
  start_repstar = repelems(start_time_max_val,[1;length(t2)]);
  start_dif = abs(t2-start_repstar');
  [sv,si]=min(start_dif);

  end_repstar = repelems(end_time_min_val,[1;length(t2)]);
  end_dif = abs(t2-end_repstar');
  [ev,ei]=min(end_dif);

  newt2 = t2(si:ei);
  news2 = s2(si:ei,:);


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % FOR SENSORS 1 and 3
  start_repstar = repelems(start_time_max_val,[1;length(t3)]);
  start_dif = abs(t3-start_repstar');
  [sv,si]=min(start_dif);

  end_repstar = repelems(end_time_min_val,[1;length(t3)]);
  end_dif = abs(t3-end_repstar');
  [ev,ei]=min(end_dif);

  newt3 = t3(si:ei);
  news3 = s3(si:ei,:);


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % FOR SENSORS 1 and 4
  start_repstar = repelems(start_time_max_val,[1;length(t4)]);
  start_dif = abs(t4-start_repstar');
  [sv,si] = min(start_dif);

  end_repstar = repelems(end_time_min_val,[1;length(t4)]);
  end_dif = abs(t4-end_repstar');
  [ev,ei] = min(end_dif);

  newt4 = t4(si:ei);
  news4 = s4(si:ei,:);


% tempsize = [size(newt1), size(newt2), size(newt3), size(newt4)]

  ns01 = [newt1 , news1];
  ns02 = [newt2 , news2];
  ns03 = [newt3 , news3];
  ns04 = [newt4 , news4];

endfunction






function [ns01, ns02, ns03, ns04] = sensors_timealignment_different_length_inverted_maxmin_vectors(t1,t2,t3,t4,s1,s2,s3,s4)
  % [ns01, ns02, ns03, ns04] = sensors_timealignment(t1,t2,t3,t4,s1,s2,s3,s4)

  % % Original
  % [start_time_max_val,index_stmax ] = max([t1(1),t2(1),t3(1),t4(1)])
  % [start_time_min_val,index_stmin ] = min([t1(1),t2(1),t3(1),t4(1)])
  % [end_time_min_val,index_etmin] = min([t1(end),t2(end),t3(end),t4(end)])
  % [end_time_max_val,index_etmax] = max([t1(end),t2(end),t3(end),t4(end)])


  % Inverted max and min vectors
  [start_time_max_val,index_stmax ] = min([t1(1),t2(1),t3(1),t4(1)]);
  [start_time_min_val,index_stmin ] = max([t1(1),t2(1),t3(1),t4(1)]);
  [end_time_min_val,index_etmin] = max([t1(end),t2(end),t3(end),t4(end)]);
  [end_time_max_val,index_etmax] = min([t1(end),t2(end),t3(end),t4(end)]);


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % FOR SENSORS 1 and 2
  %%%% t1 -t2 which align the end of s1 and s2
  start_repstar = repelems(start_time_max_val,[1;length(t1)]);
  start_dif = abs(t1-start_repstar');
  [sv,si]=min(start_dif);

  end_repstar = repelems(end_time_min_val,[1;length(t1)]);
  end_dif = abs(t1-end_repstar');
  [ev,ei]=min(end_dif);

  newt1 = t1(si:ei);
  news1 = s1(si:ei,:);


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % FOR SENSORS 1 and 2
  start_repstar = repelems(start_time_max_val,[1;length(t2)]);
  start_dif = abs(t2-start_repstar');
  [sv,si]=min(start_dif);

  end_repstar = repelems(end_time_min_val,[1;length(t2)]);
  end_dif = abs(t2-end_repstar');
  [ev,ei]=min(end_dif);

  newt2 = t2(si:ei);
  news2 = s2(si:ei,:);


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % FOR SENSORS 1 and 3
  start_repstar = repelems(start_time_max_val,[1;length(t3)]);
  start_dif = abs(t3-start_repstar');
  [sv,si]=min(start_dif);

  end_repstar = repelems(end_time_min_val,[1;length(t3)]);
  end_dif = abs(t3-end_repstar');
  [ev,ei]=min(end_dif);

  newt3 = t3(si:ei);
  news3 = s3(si:ei,:);


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % FOR SENSORS 1 and 4
  start_repstar = repelems(start_time_max_val,[1;length(t4)]);
  start_dif = abs(t4-start_repstar');
  [sv,si] = min(start_dif);

  end_repstar = repelems(end_time_min_val,[1;length(t4)]);
  end_dif = abs(t4-end_repstar');
  [ev,ei] = min(end_dif);

  newt4 = t4(si:ei);
  news4 = s4(si:ei,:);


%%%% interpolation to get the same length per sensor variable
%%pchip: Piecewise cubic Hermite interpolating polynomial -- shape-preserving interpolation
%%with smooth first derivative
%  inewt1 = interp1(newt1,newt1,newt2,'pchip');
%  inews1 = interp1(newt1,news1,newt2,'pchip');
%
%  inewt2 = interp1(newt2,newt2,newt2,'pchip');
%  inews2 = interp1(newt2,news2,newt2,'pchip');
%
%  inewt3 = interp1(newt3,newt3,newt2,'pchip');
%  inews3 = interp1(newt3,news3,newt2,'pchip');
%
%  inewt4 = interp1(newt4,newt4,newt2,'pchip');
%  inews4 = interp1(newt4,news4,newt2,'pchip');
%
%  ns01 = [inewt1 , inews1];
%  ns02 = [inewt2 , inews2];
%  ns03 = [inewt3 , inews3];
%  ns04 = [inewt4 , inews4];


% tempsize = [size(newt1), size(newt2), size(newt3), size(newt4)]

  ns01 = [newt1 , news1];
  ns02 = [newt2 , news2];
  ns03 = [newt3 , news3];
  ns04 = [newt4 , news4];

endfunction










%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[] = plottingFOURsensors(s01m, s02m, s03m, s04m, MainAxis)
% Plotting 's01','s02','s03','s04'
% Usage:
%            plottingFOURsensors(p01_s01m, p01_s02m, p01_s03m, p01_s04m, 3)
subplot(4,1,1)
plot(s01m(:,MainAxis), 'LineWidth',2)
subplot(4,1,2)
plot(s02m(:,MainAxis), 'LineWidth',2)
subplot(4,1,3)
plot(s03m(:,MainAxis), 'LineWidth',2)
subplot(4,1,4)
plot(s04m(:,MainAxis), 'LineWidth',2)

endfunction





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[] = plottingALL(
	ns01_p01_a1, ns02_p01_a1, ns03_p01_a1, ns04_p01_a1,
	ns01_p01_a2, ns02_p01_a2, ns03_p01_a2, ns04_p01_a2,
	ns01_p01_a3, ns02_p01_a3, ns03_p01_a3, ns04_p01_a3,
	ns01_p01_a4, ns02_p01_a4, ns03_p01_a4, ns04_p01_a4,
	ns01_p01_a5, ns02_p01_a5, ns03_p01_a5, ns04_p01_a5,
	ns01_p01_a6, ns02_p01_a6, ns03_p01_a6, ns04_p01_a6,
	ns01_p01_a7, ns02_p01_a7, ns03_p01_a7, ns04_p01_a7,
	ns01_p01_a8, ns02_p01_a8, ns03_p01_a8, ns04_p01_a8,
	MainAxis)


%plottingFOURsensors(ns01_p01_a1, ns02_p01_a1, ns03_p01_a1, ns04_p01_a1, 2)
%plottingFOURsensors(ns01_p01_a2, ns02_p01_a2, ns03_p01_a2, ns04_p01_a2, 2)
%plottingFOURsensors(ns01_p01_a3, ns02_p01_a3, ns03_p01_a3, ns04_p01_a3, 2)
%plottingFOURsensors(ns01_p01_a4, ns02_p01_a4, ns03_p01_a4, ns04_p01_a4, 2)
%plottingFOURsensors(ns01_p01_a5, ns02_p01_a5, ns03_p01_a5, ns04_p01_a5, 2)
%plottingFOURsensors(ns01_p01_a6, ns02_p01_a6, ns03_p01_a6, ns04_p01_a6, 2)
%plottingFOURsensors(ns01_p01_a7, ns02_p01_a7, ns03_p01_a7, ns04_p01_a7, 2)
%plottingFOURsensors(ns01_p01_a8, ns02_p01_a8, ns03_p01_a8, ns04_p01_a8, 2)

subplot(32,1,1)
plot(ns01_p01_a1(:,MainAxis), 'LineWidth',2)
subplot(32,1,2)
plot(ns02_p01_a1(:,MainAxis), 'LineWidth',2)
subplot(32,1,3)
plot(ns03_p01_a1(:,MainAxis), 'LineWidth',2)
subplot(32,1,4)
plot(ns04_p01_a1(:,MainAxis), 'LineWidth',2)

subplot(32,1,5)
plot(ns01_p01_a2(:,MainAxis), 'LineWidth',2)
subplot(32,1,6)
plot(ns02_p01_a2(:,MainAxis), 'LineWidth',2)
subplot(32,1,7)
plot(ns03_p01_a2(:,MainAxis), 'LineWidth',2)
subplot(32,1,8)
plot(ns04_p01_a2(:,MainAxis), 'LineWidth',2)

subplot(32,1,9)
plot(ns01_p01_a3(:,MainAxis), 'LineWidth',2)
subplot(32,1,10)
plot(ns02_p01_a3(:,MainAxis), 'LineWidth',2)
subplot(32,1,11)
plot(ns03_p01_a3(:,MainAxis), 'LineWidth',2)
subplot(32,1,12)
plot(ns04_p01_a3(:,MainAxis), 'LineWidth',2)

subplot(32,1,13)
plot(ns01_p01_a4(:,MainAxis), 'LineWidth',2)
subplot(32,1,14)
plot(ns02_p01_a4(:,MainAxis), 'LineWidth',2)
subplot(32,1,15)
plot(ns03_p01_a4(:,MainAxis), 'LineWidth',2)
subplot(32,1,16)
plot(ns04_p01_a4(:,MainAxis), 'LineWidth',2)

subplot(32,1,17)
plot(ns01_p01_a5(:,MainAxis), 'LineWidth',2)
subplot(32,1,18)
plot(ns02_p01_a5(:,MainAxis), 'LineWidth',2)
subplot(32,1,19)
plot(ns03_p01_a5(:,MainAxis), 'LineWidth',2)
subplot(32,1,20)
plot(ns04_p01_a5(:,MainAxis), 'LineWidth',2)

subplot(32,1,21)
plot(ns01_p01_a6(:,MainAxis), 'LineWidth',2)
subplot(32,1,22)
plot(ns02_p01_a6(:,MainAxis), 'LineWidth',2)
subplot(32,1,23)
plot(ns03_p01_a6(:,MainAxis), 'LineWidth',2)
subplot(32,1,24)
plot(ns04_p01_a6(:,MainAxis), 'LineWidth',2)

subplot(32,1,25)
plot(ns01_p01_a7(:,MainAxis), 'LineWidth',2)
subplot(32,1,26)
plot(ns02_p01_a7(:,MainAxis), 'LineWidth',2)
subplot(32,1,27)
plot(ns03_p01_a7(:,MainAxis), 'LineWidth',2)
subplot(32,1,28)
plot(ns04_p01_a7(:,MainAxis), 'LineWidth',2)

subplot(32,1,29)
plot(ns01_p01_a8(:,MainAxis), 'LineWidth',2)
subplot(32,1,30)
plot(ns02_p01_a8(:,MainAxis), 'LineWidth',2)
subplot(32,1,31)
plot(ns03_p01_a8(:,MainAxis), 'LineWidth',2)
subplot(32,1,32)
plot(ns04_p01_a8(:,MainAxis), 'LineWidth',2)




endfunction






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function[] = PlottingFourSensors(s01m, s02m, s03m, s04m, windowframe, MainAxis)
%%%% Plotting 's01','s02','s03','s04'
%plot(s01m(windowframe,2),s01m(windowframe,MainAxis),  s02m(windowframe,2),s02m(windowframe,MainAxis),   s03m(windowframe,2),s03m(windowframe,MainAxis),':',   s04m(windowframe,2),s04m(windowframe,MainAxis),':'  ,'LineWidth',2)
%legend('s01','s02','s03','s04')
%
%end
%
%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function[] = PlottingTwoSensors(s01m, s02m, windowframe, MainAxis)
%%%% Plotting 's01','s02'
%plot(s01m(windowframe,2),s01m(windowframe,MainAxis),  s02m(windowframe,2),s02m(windowframe,MainAxis),'LineWidth',2)
%legend('s01','s02')
%end
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function[] = PlottingOneSensors(s01m, windowframe, MainAxis)
%%%% Plotting 's01'
%plot(s01m(windowframe,2),s01m(windowframe,MainAxis) ,'LineWidth',2)
%legend('s')
%end
%
%
%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [delay] = finddelayMX(X,Y)
%
%[R, lag] = xcorr(X,Y);
%[Y,I] = max(R);  %%%[Y,I] = max(X) returns the indices of the maximum values in vector I.
%delay = abs(I - length( X ) );
%
%
%end
%
%
%function [a,b,delay] = alignsignalsMX(sA,sB,windowframe,MainAxis,truncate_delay, tuning_delay)
%
%X = sA(windowframe,MainAxis);
%Y = sB(windowframe,MainAxis);
%
%% Adding extra delay in the function and make it zero as default
%if tuning_delay == 0
%    delay = finddelayMX(X,Y);
%else
%    delay = finddelayMX(X,Y) + tuning_delay;
%end
%
%
%XX = sA(windowframe(1+truncate_delay):windowframe(end),        MainAxis);
%YY = sB(windowframe(delay+truncate_delay):windowframe(end),    MainAxis);
%
%vectorlengths = [size(XX), size(YY)];
%minlength = min(vectorlengths(1),vectorlengths(3));
%
%a = sA(windowframe(1+truncate_delay):windowframe(minlength),        MainAxis);
%b = sB(windowframe(delay+truncate_delay):windowframe(end),    MainAxis);
%
%
%end
%
%
%
%function [a,b,delay] = aligntwosignals(X,Y,truncate_delay, tuning_delay)
%
%X = X(1+tuning_delay: end);
%Y = Y(1:end);
%
%delay = finddelayMX(X,Y);
%
%XX = X(1+delay +truncate_delay: end);
%YY = Y(1:end);
%
%
%vectorlengths = [size(XX), size(YY)];
%minlength = min(vectorlengths(1),vectorlengths(3));
%
%a = XX(1:minlength);
%b = YY(1:minlength);
%
%
%% a = sA(windowframe(1+truncate_delay):windowframe(minlength),        MainAxis);
%% b = sB(windowframe(delay+truncate_delay):windowframe(end),    MainAxis);
%
%end
%
%
%
%
%
%
%function [a,b,c,d] = samelengthvectors(W,X,Y,Z)
%  %[a,b,c,d] = samelengthvectors(W,X,Y,Z)
%  lengths = [size(W), size(X),size(Y), size(Z)];
%  vectorlenghts = [lengths(1),lengths(3),lengths(5),lengths(7)];
%
%  minlength = min(vectorlenghts);
%
%  a = W(1:minlength);
%  b = X(1:minlength);
%  c = Y(1:minlength);
%  d = Z(1:minlength);
%
%endfunction
