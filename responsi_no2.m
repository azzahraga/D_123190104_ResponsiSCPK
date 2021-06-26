function varargout = responsi_no2(varargin)
% RESPONSI_NO2 MATLAB code for responsi_no2.fig
%      RESPONSI_NO2, by itself, creates a new RESPONSI_NO2 or raises the existing
%      singleton*.
%
%      H = RESPONSI_NO2 returns the handle to a new RESPONSI_NO2 or the handle to
%      the existing singleton*.
%
%      RESPONSI_NO2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSI_NO2.M with the given input arguments.
%
%      RESPONSI_NO2('Property','Value',...) creates a new RESPONSI_NO2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before responsi_no2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to responsi_no2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help responsi_no2

% Last Modified by GUIDE v2.5 25-Jun-2021 21:13:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @responsi_no2_OpeningFcn, ...
                   'gui_OutputFcn',  @responsi_no2_OutputFcn, ...
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


% --- Executes just before responsi_no2 is made visible.
function responsi_no2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to responsi_no2 (see VARARGIN)
    global u
    u.urut=[];
% Choose default command line output for responsi_no2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes responsi_no2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = responsi_no2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnproses.
function btnproses_Callback(hObject, eventdata, handles)
% hObject    handle to btnproses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = [3:8];
x = readmatrix('DATA RUMAH.xlsx',opts);
k=[0,1,1,1,1,1];%nilai atribut, dimana 0= atribut biaya &1= atributkeuntungan
w=[0.3,0.2,0.23,0.1,0.07,0.1];% bobot untuk masing-masing kriteria

%tahapan 1. normalisasi matriks
[m n]=size (x); %matriks m x n dengan ukuran sebanyak variabel x (input)
R=zeros (m,n); %membuat matriks R, yang merupakan matriks kosong
Y=zeros (m,n); %membuat matriks Y, yang merupakan titik kosong
for j=1:n,
    if k(j)==1, %statement untuk kriteria dengan atribut keuntungan
        R(:,j)=x(:,j)./max(x(:,j));
    else
        R(:,j)=min(x(:,j))./x(:,j);
    end;
end;
    
%tahapan kedua, proses perangkingan
for i=1:m,
    V(i)= sum(w.*R(i,:))
end;
[nilai nr]= sort(V,'descend');%mengurutkan dari terbesar ke kecil

%meranking 20 nilai terbesar beserta no datanya
global u
for rank=1:20,
    u.urut = [u.urut; [nilai(rank),nr(rank)]];%menselect 20 data terbesar yang akan menampilkan nilai dari V dan no datanya
    disp(u.urut);%menampillkan urutan rekomendasi ke command window
    set(handles.uitable2, 'Data', u.urut);%menampilkan urutan rekomendasi ke table gui
end;



% --- Executes on button press in btnlihat.
function btnlihat_Callback(hObject, eventdata, handles)
% hObject    handle to btnlihat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('DATA RUMAH.xlsx');%import data dari exel ke matlab
opts.SelectedVariableNames = [3:8];%mengambil kolom 3- 8
x = readmatrix('DATA RUMAH.xlsx',opts);%membaca data
set(handles.uitable1,'Data',x);%menampilkan data yang di select ke dalam gui table
