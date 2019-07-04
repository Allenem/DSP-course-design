function varargout = dspshiyan(varargin)
% DSPSHIYAN MATLAB code for dspshiyan.fig
%      DSPSHIYAN, by itself, creates a new DSPSHIYAN or raises the existing
%      singleton*.
%
%      H = DSPSHIYAN returns the handle to a new DSPSHIYAN or the handle to
%      the existing singleton*.
%
%      DSPSHIYAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DSPSHIYAN.M with the given input arguments.
%
%      DSPSHIYAN('Property','Value',...) creates a new DSPSHIYAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dspshiyan_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dspshiyan_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dspshiyan

% Last Modified by GUIDE v2.5 26-Nov-2018 13:47:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dspshiyan_OpeningFcn, ...
                   'gui_OutputFcn',  @dspshiyan_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before dspshiyan is made visible.
function dspshiyan_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dspshiyan (see VARARGIN)

% Choose default command line output for dspshiyan
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dspshiyan wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dspshiyan_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton4.
%回声框里的“录音并播放”按钮
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 根据语音还是音乐选择采样率，语音为“1”，音乐为“2”
if get (handles.popupmenu5,'Value' )==1;
   Fs=8000;
elseif get (handles.popupmenu5, 'Value' )==2;
   Fs=44100;
else
   errordlg('error! ');
end
% 根据“时长”框里的数选择时长（s）
if get (handles.popupmenu6,'Value' )==1;
   T=1;
elseif get (handles.popupmenu6, 'Value' )==2;
   T=2;
elseif get (handles.popupmenu6, 'Value' )==3;
   T=3;
elseif get (handles.popupmenu6, 'Value' )==4;
   T=4;
elseif get (handles.popupmenu6, 'Value' )==5;
   T=5;
elseif get (handles.popupmenu6, 'Value' )==6;
   T=6;
elseif get (handles.popupmenu6, 'Value' )==7;
   T=7;
elseif get (handles.popupmenu6, 'Value' )==8;
   T=8;
else
   errordlg('error! ');
end
y=record0(Fs,T);%调用录音函数，返回信号
axes(handles.axes1);%定位到图框1绘制图形（左上）
plot(handles.axes1,y);
title('录制音频时域');
Y=abs(fft(y));
axes(handles.axes2);%定位到图框2绘制图形（右上）
plot(handles.axes2,Y(1:round(length(y)/2)-1));
title('录制音频频域');

% --- Executes on button press in pushbutton1.
%回声框里的“梳妆滤波器”按钮
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 根据语音还是音乐选择采样率，语音为“1”，音乐为“2”
if get (handles.popupmenu5,'Value' )==1;
   Fs=8000;
elseif get (handles.popupmenu5, 'Value' )==2;
   Fs=44100;
else
   errordlg('error! ');
end
y=audioread('test.wav');%读取wav格式音频文件
%y=getappdata(handles.pushbutton4,'y');
a=0.5;%设置衰减系数
R=2000;%延时的时间长短
B=[1,zeros(1,R-1),a,zeros(1,R-1),a/2];%系统分子
A=[1];%系统分母
[h,w]=freqz(B,A);%求系统频响特性的函数
y2=filter(B,A,y);%滤波输出
Y2=fft(y2,length(y));%滤波输出的fft
Y3=abs(Y2);
sound(y2,Fs);%播放处理后的声音信号
axes(handles.axes3);%定位到图框3绘制图形（左下）
plot(handles.axes3,y2);
title('梳妆滤波结果的时域图');
axes(handles.axes4);%定位到图框4绘制图形（右下）
plot(handles.axes4,Y3(1:round(length(y)/2)-1));
title('梳妆滤波结果的频域图');


% --- Executes on button press in pushbutton2.
%回声框里的“全通滤波器”按钮
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 根据语音还是音乐选择采样率，语音为“1”，音乐为“2”
if get (handles.popupmenu5,'Value' )==1;
   Fs=8000;
elseif get (handles.popupmenu5, 'Value' )==2;
   Fs=44100;
else
   errordlg('error! ');
end
y=audioread('test.wav');%读取wav格式音频文件
a=0.5;%设置衰减系数
R=2000;%延时的时间长短
B=[a,zeros(1,R-1),1];%系统分子
A=[1,zeros(1,R-1),a];%系统分母
[h,w]=freqz(B,A);%求系统频响特性的函数
y2=filter(B,A,y);%滤波输出
Y2=fft(y2,length(y));%滤波输出的fft
Y3=abs(Y2);
sound(y2,Fs);%播放处理后的声音信号
axes(handles.axes3);%定位到图框3绘制图形（左下）
plot(handles.axes3,y2);
title('全通滤波结果的时域图');
axes(handles.axes4);%定位到图框4绘制图形（右下）
plot(handles.axes4,Y3(1:round(length(y)/2)-1));
title('全通滤波结果的频域图');


% --- Executes on button press in pushbutton8.
%均衡器框里的“录音并播放”按钮
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 根据语音还是音乐选择采样率，语音为“1”，音乐为“2”
if get (handles.popupmenu4,'Value' )==1;
   Fs=8000;
elseif get (handles.popupmenu4, 'Value' )==2;
   Fs=44100;
else
   errordlg('error! ');
end
% 根据“时长”框里的数选择时长（s）
if get (handles.popupmenu7,'Value' )==1;
   T=1;
elseif get (handles.popupmenu7, 'Value' )==2;
   T=2;
elseif get (handles.popupmenu7, 'Value' )==3;
   T=3;
elseif get (handles.popupmenu7, 'Value' )==4;
   T=4;
elseif get (handles.popupmenu7, 'Value' )==5;
   T=5;
elseif get (handles.popupmenu7, 'Value' )==6;
   T=6;
elseif get (handles.popupmenu7, 'Value' )==7;
   T=7;
elseif get (handles.popupmenu7, 'Value' )==8;
   T=8;
else
   errordlg('error! ');
end
y=record0(Fs,T);
axes(handles.axes1);%定位到图框1绘制图形（左上）
plot(handles.axes1,y);
title('录制音频时域');
Y=abs(fft(y));
axes(handles.axes2);%定位到图框2绘制图形（右上）
plot(handles.axes2,Y(1:round(length(y)/2)-1));
title('录制音频频域');


% --- Executes on button press in pushbutton5.
%均衡器框里的“均衡并播放”按钮
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[yy,Fs]=audioread('test.wav');
Y1=fft (yy);
fband =[100 200 500 1000 2000 3999 8000 16000 20000];% 频率分段
%根据语音还是音乐选择频段的多少，语音为“1”，音乐为“2”
%若为语音，则最高频为3999Hz，即num=5，否则最高频为20kHz,即num=8
if get (handles.popupmenu4,'Value' )==1;
   num=5;
elseif get (handles.popupmenu4, 'Value' )==2;
   num=8;
else
   errordlg('error! ');
end
y=zeros (size (yy));
%N为“阶数（1-4）”框里所选的阶数
N=get (handles.popupmenu3,'Value' );
%handles.slideri (i=1,...,8)表示从左到右的8个滑动条
slider=[handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8];
%handles. popupmenu1为“滤波器型号”框
%其中巴特沃兹为“1”，切比雪夫I型为“2”，切比雪夫II型为“3”，椭圆为“4”
for i=1:num;
    k(i)=get (slider(i),'Value' )
    if get (handles. popupmenu1,'Value' )==1;
        [b a]=butter (N, 2*fband(i:i+1)/Fs);
    elseif get (handles. popupmenu1, 'Value' )==2;
        [b a]=cheby1 (N, 0.5, 2*fband(i:i+1)/Fs);
    elseif get (handles. popupmenu1,'Value' )==3;
        [b a]=cheby2 (N, 20, 2*fband(i:i+1)/Fs);
    elseif get (handles. popupmenu1, 'Value' )==4;
        [b a]=ellip(N, 0.5, 20, 2*fband(i:i+1)/Fs);
    else
        errordlg(' No filter type chosen or filter type error! ');
    end
    y=y+k(i)*filter (b, a, yy);
end
Y2=fft(y);
Y3=abs(Y2);
sound(y,Fs);
axes(handles.axes3);
plot(handles.axes3,y);
title('均衡后音频时域');
axes(handles.axes4);
plot(handles.axes4,Y3(1:round(length(y)/2)-1));
title('均衡后音频频域');



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton2.
function pushbutton2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function uipanel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6


% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7


% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
