%% example call to rcaSweep
clear all; close all; clc

%% setup inputs
% the main input is a cell array of strings which points to a folder of
% DFT/RLS exports for each subject
pathnames={'/Volumes/Denali_4D2/rca/s001/','/Volumes/Denali_4D2/rca/s002/','/Volumes/Denali_4D2/rca/s003/'};
binsToUse=1:10; % indices of bins to include in analysis (the values must be present in the bin column of all DFT/RLS exports)
freqsToUse=[1 3 5]; % indices of frequencies to include in analysis (the values must be present in the frequency column of all DFT/RLS exports)
condsToUse = 1:2; % if you want to include all conditions, create a vector here listing all condition numbers
nReg=7; % RCA regularization constant (7-9 are typical values, but see within-trial eigenvalue plot in rca output)
nComp=3; % number of RCs that you want to look at (3-5 are good values, but see across-trial eigenvalue plot in rca output)
chanToCompare = 75; % channel to use for a performance evaluation
dataType = 'RLS'; % can also be 'DFT' if you have DFT exports

%% call the function
[rcaData,W,A,noiseData,ozData,ozNoiseData,rcaSettings]=rcaSweep(pathnames,binsToUse,freqsToUse,condsToUse,nReg,nComp,dataType,chanToCompare);

%% examples of provided plotting routines
plotSnr(rcaData,noiseData,rcaSettings);
plotSnr(rcaData,noiseData,rcaSettings,[],ozData,ozNoiseData);

%%
plotSettings.comparisonName = 'OZ';
plotSnr(rcaData,noiseData,rcaSettings,plotSettings,ozData,ozNoiseData);

plotFreqByComp(rcaData,noiseData,rcaSettings,plotSettings,ozData,ozNoiseData);