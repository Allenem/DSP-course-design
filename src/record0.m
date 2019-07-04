function [y]=record0(Fs,T)
R = audiorecorder(Fs, 16 ,1) ;
%创建一个保存音频信息的对象，它包含采样率，时间和录制的音频信息等等。
%44100表示采样为44100Hz（可改为8000, 11025, 22050等，此数值越大，录入的声音质量越好，相应需要的存储空间越大）
%16为用16bits存储，2为两通道即立体声（也可以改为1即单声道）。
record(R);
%开始录制，此时对着麦克风说话即可。
pause(T);
%暂停录制。
stop(R);
%停止录制
myspeech = getaudiodata(R);
%得到以n*2列数字矩阵存储的刚录制的音频信号。
sound(myspeech,Fs);
%对这个矩阵你就可以用各种滤波器进行处理，或者把它和别的音频混音等等。你也可以画出它的波形（如果时间较长画波形可能会花点时间）。
audiowrite('test.wav',myspeech,Fs) %存储.wav音频文件，在这里文件名为test.wav
y=audioread('test.wav');

