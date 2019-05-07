:%

% USAGE
% octave --no-gui
% readrawdataHII_labels

%  M-Script to read data files for \data_P01-P22.
%  Data is separated by using labels_p01-p22_HII.txt for four activitities (a1,...,a4).


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


%%data seems fine
%p01_data_path = strcat(datapath,'/p01/p01-HII/');
%[p01_s01m, p01_s02m, p01_s03m, p01_s04m, p01_max_length_sensors] = cvs2arrays(p01_data_path);
%plottingFOURsensors(p01_s01m, p01_s02m, p01_s03m, p01_s04m, 3)


%%%data seems fine
%p02_data_path = strcat(datapath,'/p02/p02-HII/');
%[p02_s01m, p02_s02m, p02_s03m, p02_s04m, p02_max_length_sensors] = cvs2arrays(p02_data_path);
%plottingFOURsensors(p02_s01m, p02_s02m, p02_s03m, p02_s04m, 3)

%%DISCARTED: SENSORONE DID NOT STREAMED DATA
%%DISCARTED: SENSORONE DID NOT STREAMED DATA
%p03_data_path = strcat(datapath,'/p03/p03-HII/');
%[p03_s01m, p03_s02m, p03_s03m, p03_s04m, p03_max_length_sensors] = cvs2arrays(p03_data_path);
%plottingFOURsensors(p03_s01m, p03_s02m, p03_s03m, p03_s04m, 3)

%%data seems fine
%p04_data_path = strcat(datapath,'/p04/p04-HII/');
%[p04_s01m, p04_s02m, p04_s03m, p04_s04m, p04_max_length_sensors] = cvs2arrays(p04_data_path);
%plottingFOURsensors(p04_s01m, p04_s02m, p04_s03m, p04_s04m, 3)

%%DISCARTED: SENSOR TWO TIME SERIES IS NOT COMPLETED
%%DISCARTED: SENSOR TWO TIME SERIES IS NOT COMPLETED
%p05_data_path = strcat(datapath,'/p05/p05-HII/');
%[p05_s01m, p05_s02m, p05_s03m, p05_s04m, p05_max_length_sensors] = cvs2arrays(p05_data_path);
%plottingFOURsensors(p05_s01m, p05_s02m, p05_s03m, p05_s04m, 3)

%data seems fine
%p06_data_path = strcat(datapath,'/p06/p06-HII/');
%[p06_s01m, p06_s02m, p06_s03m, p06_s04m, p06_max_length_sensors] = cvs2arrays(p06_data_path);
%plottingFOURsensors(p06_s01m, p06_s02m, p06_s03m, p06_s04m, 3)


%%data seems fine
%p07_data_path = strcat(datapath,'/p07/p07-HII/');
%[p07_s01m, p07_s02m, p07_s03m, p07_s04m, p07_max_length_sensors] = cvs2arrays(p07_data_path);
%plottingFOURsensors(p07_s01m, p07_s02m, p07_s03m, p07_s04m, 3)
%

%%data seems fine
%p08_data_path = strcat(datapath,'/p08/p08-HII/');
%[p08_s01m, p08_s02m, p08_s03m, p08_s04m, p08_max_length_sensors] = cvs2arrays(p08_data_path);
%plottingFOURsensors(p08_s01m, p08_s02m, p08_s03m, p08_s04m, 3)
%


%%data seems fine
%p09_data_path = strcat(datapath,'/p09/p09-HII/');
%[p09_s01m, p09_s02m, p09_s03m, p09_s04m, p09_max_length_sensors] = cvs2arrays(p09_data_path);
%plottingFOURsensors(p09_s01m, p09_s02m, p09_s03m, p09_s04m, 3)
%

%%%data seems fine
%p10_data_path = strcat(datapath,'/p10/p10-HII/');
%[p10_s01m, p10_s02m, p10_s03m, p10_s04m, p10_max_length_sensors] = cvs2arrays(p10_data_path);
%plottingFOURsensors(p10_s01m, p10_s02m, p10_s03m, p10_s04m, 3)
%

%%%data seems fine
%p11_data_path = strcat(datapath,'/p11/p11-HII/');
%[p11_s01m, p11_s02m, p11_s03m, p11_s04m, p11_max_length_sensors] = cvs2arrays(p11_data_path);
%plottingFOURsensors(p11_s01m, p11_s02m, p11_s03m, p11_s04m, 3)
%
%%%data seems fine
%%%ALIGNMENT IS NOT WELL MADE
%%%POSIBLY DISCARD IT
%p12_data_path = strcat(datapath,'/p12/p12-HII/');
%[p12_s01m, p12_s02m, p12_s03m, p12_s04m, p12_max_length_sensors] = cvs2arrays(p12_data_path);
%plottingFOURsensors(p12_s01m, p12_s02m, p12_s03m, p12_s04m, 3)

%%%data seems fine
%p13_data_path = strcat(datapath,'/p13/p13-HII/');
%[p13_s01m, p13_s02m, p13_s03m, p13_s04m, p13_max_length_sensors] = cvs2arrays(p13_data_path);
%plottingFOURsensors(p13_s01m, p13_s02m, p13_s03m, p13_s04m, 3)

%%%data seems fine
%p14_data_path = strcat(datapath,'/p14/p14-HII/');
%[p14_s01m, p14_s02m, p14_s03m, p14_s04m, p14_max_length_sensors] = cvs2arrays(p14_data_path);
%plottingFOURsensors(p14_s01m, p14_s02m, p14_s03m, p14_s04m, 3)

%%%data seems fine
%p15_data_path = strcat(datapath,'/p15/p15-HII/');
%[p15_s01m, p15_s02m, p15_s03m, p15_s04m, p15_max_length_sensors] = cvs2arrays(p15_data_path);
%plottingFOURsensors(p15_s01m, p15_s02m, p15_s03m, p15_s04m, 3)
%
%%%data seems fine
%p16_data_path = strcat(datapath,'/p16/p16-HII/');
%[p16_s01m, p16_s02m, p16_s03m, p16_s04m, p16_max_length_sensors] = cvs2arrays(p16_data_path);
%plottingFOURsensors(p16_s01m, p16_s02m, p16_s03m, p16_s04m, 3)

%%data seems fine
%p17_data_path = strcat(datapath,'/p17/p17-HII/');
%[p17_s01m, p17_s02m, p17_s03m, p17_s04m, p17_max_length_sensors] = cvs2arrays(p17_data_path);
%plottingFOURsensors(p17_s01m, p17_s02m, p17_s03m, p17_s04m, 3)

%%data seems fine, excpet activity 7 which is shifted
%p18_data_path = strcat(datapath,'/p18/p18-HII/');
%[p18_s01m, p18_s02m, p18_s03m, p18_s04m, p18_max_length_sensors] = cvs2arrays(p18_data_path);
%plottingFOURsensors(p18_s01m, p18_s02m, p18_s03m, p18_s04m, 3)


%%data seems fine
%p19_data_path = strcat(datapath,'/p19/p19-HII/');
%[p19_s01m, p19_s02m, p19_s03m, p19_s04m, p19_max_length_sensors] = cvs2arrays(p19_data_path);
%plottingFOURsensors(p19_s01m, p19_s02m, p19_s03m, p19_s04m, 3)


%%data: SENSOR ONE NOT COMPLETED
%p20_data_path = strcat(datapath,'/p20/p20-HII/');
%[p20_s01m, p20_s02m, p20_s03m, p20_s04m, p20_max_length_sensors] = cvs2arrays(p20_data_path);
%plottingFOURsensors(p20_s01m, p20_s02m, p20_s03m, p20_s04m, 3)
%
%
%%data seems fine
%%SENSOR TWO IS SHIFTED
%p21_data_path = strcat(datapath,'/p21/p21-HII/');
%[p21_s01m, p21_s02m, p21_s03m, p21_s04m, p21_max_length_sensors] = cvs2arrays(p21_data_path);
%plottingFOURsensors(p21_s01m, p21_s02m, p21_s03m, p21_s04m, 3)
%
%
%%data seems fine
%%after inverting axis to get the time series, Activity 7 is shifted
%p22_data_path = strcat(datapath,'/p22/p22-HII/');
%[p22_s01m, p22_s02m, p22_s03m, p22_s04m, p22_max_length_sensors] = cvs2arrays(p22_data_path);
%plottingFOURsensors(p22_s01m, p22_s02m, p22_s03m, p22_s04m, 3)
%





% Go back to the m-scripts_path
cd(m_scripts_path)
