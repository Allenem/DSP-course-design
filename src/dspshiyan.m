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
%��������ġ�¼�������š���ť
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ����������������ѡ������ʣ�����Ϊ��1��������Ϊ��2��
if get (handles.popupmenu5,'Value' )==1;
   Fs=8000;
elseif get (handles.popupmenu5, 'Value' )==2;
   Fs=44100;
else
   errordlg('error! ');
end
% ���ݡ�ʱ�����������ѡ��ʱ����s��
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
y=record0(Fs,T);%����¼�������������ź�
axes(handles.axes1);%��λ��ͼ��1����ͼ�Σ����ϣ�
plot(handles.axes1,y);
title('¼����Ƶʱ��');
Y=abs(fft(y));
axes(handles.axes2);%��λ��ͼ��2����ͼ�Σ����ϣ�
plot(handles.axes2,Y(1:round(length(y)/2)-1));
title('¼����ƵƵ��');

% --- Executes on button press in pushbutton1.
%��������ġ���ױ�˲�������ť
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ����������������ѡ������ʣ�����Ϊ��1��������Ϊ��2��
if get (handles.popupmenu5,'Value' )==1;
   Fs=8000;
elseif get (handles.popupmenu5, 'Value' )==2;
   Fs=44100;
else
   errordlg('error! ');
end
y=audioread('test.wav');%��ȡwav��ʽ��Ƶ�ļ�
%y=getappdata(handles.pushbutton4,'y');
a=0.5;%����˥��ϵ��
R=2000;%��ʱ��ʱ�䳤��
B=[1,zeros(1,R-1),a,zeros(1,R-1),a/2];%ϵͳ����
A=[1];%ϵͳ��ĸ
[h,w]=freqz(B,A);%��ϵͳƵ�����Եĺ���
y2=filter(B,A,y);%�˲����
Y2=fft(y2,length(y));%�˲������fft
Y3=abs(Y2);
sound(y2,Fs);%���Ŵ����������ź�
axes(handles.axes3);%��λ��ͼ��3����ͼ�Σ����£�
plot(handles.axes3,y2);
title('��ױ�˲������ʱ��ͼ');
axes(handles.axes4);%��λ��ͼ��4����ͼ�Σ����£�
plot(handles.axes4,Y3(1:round(length(y)/2)-1));
title('��ױ�˲������Ƶ��ͼ');


% --- Executes on button press in pushbutton2.
%��������ġ�ȫͨ�˲�������ť
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ����������������ѡ������ʣ�����Ϊ��1��������Ϊ��2��
if get (handles.popupmenu5,'Value' )==1;
   Fs=8000;
elseif get (handles.popupmenu5, 'Value' )==2;
   Fs=44100;
else
   errordlg('error! ');
end
y=audioread('test.wav');%��ȡwav��ʽ��Ƶ�ļ�
a=0.5;%����˥��ϵ��
R=2000;%��ʱ��ʱ�䳤��
B=[a,zeros(1,R-1),1];%ϵͳ����
A=[1,zeros(1,R-1),a];%ϵͳ��ĸ
[h,w]=freqz(B,A);%��ϵͳƵ�����Եĺ���
y2=filter(B,A,y);%�˲����
Y2=fft(y2,length(y));%�˲������fft
Y3=abs(Y2);
sound(y2,Fs);%���Ŵ����������ź�
axes(handles.axes3);%��λ��ͼ��3����ͼ�Σ����£�
plot(handles.axes3,y2);
title('ȫͨ�˲������ʱ��ͼ');
axes(handles.axes4);%��λ��ͼ��4����ͼ�Σ����£�
plot(handles.axes4,Y3(1:round(length(y)/2)-1));
title('ȫͨ�˲������Ƶ��ͼ');


% --- Executes on button press in pushbutton8.
%����������ġ�¼�������š���ť
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ����������������ѡ������ʣ�����Ϊ��1��������Ϊ��2��
if get (handles.popupmenu4,'Value' )==1;
   Fs=8000;
elseif get (handles.popupmenu4, 'Value' )==2;
   Fs=44100;
else
   errordlg('error! ');
end
% ���ݡ�ʱ�����������ѡ��ʱ����s��
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
axes(handles.axes1);%��λ��ͼ��1����ͼ�Σ����ϣ�
plot(handles.axes1,y);
title('¼����Ƶʱ��');
Y=abs(fft(y));
axes(handles.axes2);%��λ��ͼ��2����ͼ�Σ����ϣ�
plot(handles.axes2,Y(1:round(length(y)/2)-1));
title('¼����ƵƵ��');


% --- Executes on button press in pushbutton5.
%����������ġ����Ⲣ���š���ť
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[yy,Fs]=audioread('test.wav');
Y1=fft (yy);
fband =[100 200 500 1000 2000 3999 8000 16000 20000];% Ƶ�ʷֶ�
%����������������ѡ��Ƶ�εĶ��٣�����Ϊ��1��������Ϊ��2��
%��Ϊ�����������ƵΪ3999Hz����num=5���������ƵΪ20kHz,��num=8
if get (handles.popupmenu4,'Value' )==1;
   num=5;
elseif get (handles.popupmenu4, 'Value' )==2;
   num=8;
else
   errordlg('error! ');
end
y=zeros (size (yy));
%NΪ��������1-4����������ѡ�Ľ���
N=get (handles.popupmenu3,'Value' );
%handles.slideri (i=1,...,8)��ʾ�����ҵ�8��������
slider=[handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8];
%handles. popupmenu1Ϊ���˲����ͺš���
%���а�������Ϊ��1�����б�ѩ��I��Ϊ��2�����б�ѩ��II��Ϊ��3������ԲΪ��4��
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
title('�������Ƶʱ��');
axes(handles.axes4);
plot(handles.axes4,Y3(1:round(length(y)/2)-1));
title('�������ƵƵ��');



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
