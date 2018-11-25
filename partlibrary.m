function [ partlibrary ] = partlibrary( x,y )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

Repressors = {
    'AmeR';
    'AmtR';
    'BetI';
    'BM3R1';
    'BM3R1-2';
    'BM3R1-3';
    'HlyIIR';
    'IcaRa';
    'LitR';
    'LmrA';
    'PhlF';
    'PhlF-2';
    'PhlF-3';
    'PsrA';
    'QacR';
    'QacR-2';
    'SrpR';
    'SrpR-2';
    'SrpR-3';
    'SrpR-4';
    };

RBS = [
    'F1';
    'A1';
    'E1';
    'B1';
    'B2';
    'B3';
    'H1';
    'I1';
    'L1';
    'N1';
    'P1';
    'P2';
    'P3';
    'R1';
    'Q1';
    'Q2';
    'S1';
    'S2';
    'S3';
    'S4'
    ];

ymin = [
    0.2;
    0.06;
    0.07;
    0.004;
    0.005;
    0.01;
    0.07;
    0.08;
    0.07;
    0.2;
    0.01;
    0.02;
    0.02;
    0.2;
    0.01;
    0.03;
    0.003;
    0.003;
    0.004;
    0.007
    ];

ymax = [
    3.8;
    3.8;
    3.8;
    0.5;
    0.5;
    0.8;
    2.5;
    2.2;
    4.3;
    2.2;
    3.9;
    4.1;
    6.8;
    5.9;
    2.4;
    2.8;
    1.3;
    2.1;
    2.1;
    2.1
    ];

K = [
    0.09;
    0.07;
    0.41;
    0.04;
    0.15;
    0.26;
    0.19;
    0.10;
    0.05;
    0.18;
    0.03;
    0.13;
    0.23;
    0.19;
    0.05;
    0.21;
    0.01;
    0.04;
    0.06;
    0.10
    ];


n = [
    1.4;
    1.6;
    2.4;
    3.4;
    2.9;
    3.4;
    2.6;
    1.4;
    1.7;
    2.1;
    4.0;
    3.9;
    4.2;
    1.8;
    2.7;
    2.4;
    2.9;
    2.6;
    2.8;
    2.8
    ];


part_table = table(ymin,ymax,K,n,'RowNames',Repressors);
partlibrary = part_table(x,y);

end

