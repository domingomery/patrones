function varargout = PAT03_GUI_Fisher(varargin)
% PAT03_GUI_FISHER M-file for PAT03_GUI_Fisher.fig
%      PAT03_GUI_FISHER, by itself, creates a new PAT03_GUI_FISHER or raises the existing
%      singleton*.
%
%      H = PAT03_GUI_FISHER returns the handle to a new PAT03_GUI_FISHER or the handle to
%      the existing singleton*.
%
%      PAT03_GUI_FISHER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PAT03_GUI_FISHER.M with the given input arguments.
%
%      PAT03_GUI_FISHER('Property','Value',...) creates a new PAT03_GUI_FISHER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PAT03_GUI_Fisher_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PAT03_GUI_Fisher_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PAT03_GUI_Fisher

% Last Modified by GUIDE v2.5 03-Apr-2016 20:20:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PAT03_GUI_Fisher_OpeningFcn, ...
                   'gui_OutputFcn',  @PAT03_GUI_Fisher_OutputFcn, ...
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


% --- Executes just before PAT03_GUI_Fisher is made visible.
function PAT03_GUI_Fisher_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PAT03_GUI_Fisher (see VARARGIN)

% Choose default command line output for PAT03_GUI_Fisher
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PAT03_GUI_Fisher wait for user response (see UIRESUME)
% uiwait(handles.figure1);

N = [1000 1000]';
MU = [1 5;5 1]';
SIG = [1 1;1 8]';
TH  = [0 0]';
[X,d] = Bds_gaussgen(MU,SIG,N);
plotfisher22(X,d,TH)
save fisherdata X d MU SIG N TH

% --- Outputs from this function are returned to the command line.
function varargout = PAT03_GUI_Fisher_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
load fisherdata
TH(1)=get(hObject,'Value')*pi;
plotfisher22(X,d,TH)
save fisherdata X d MU SIG N TH

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
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
load fisherdata
TH(2)=get(hObject,'Value')*pi;
plotfisher22(X,d,TH)
save fisherdata X d MU SIG N TH


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
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
load fisherdata
MU(1,1)=get(hObject,'Value')*30;
[X,d] = Bds_gaussgen(MU,SIG,N);
plotfisher22(X,d,TH)
save fisherdata X d MU SIG N TH


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
load fisherdata
MU(1,2)=get(hObject,'Value')*30;
[X,d] = Bds_gaussgen(MU,SIG,N);
plotfisher22(X,d,TH)
save fisherdata X d MU SIG N TH


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
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
load fisherdata
MU(2,1)=get(hObject,'Value')*30;
[X,d] = Bds_gaussgen(MU,SIG,N);
plotfisher22(X,d,TH)
save fisherdata X d MU SIG N TH


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
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
load fisherdata
MU(2,2)=get(hObject,'Value')*30;
[X,d] = Bds_gaussgen(MU,SIG,N);
plotfisher22(X,d,TH)
save fisherdata X d MU SIG N TH


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
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
load fisherdata
SIG(1,1)=get(hObject,'Value')*10;
[X,d] = Bds_gaussgen(MU,SIG,N);
plotfisher22(X,d,TH)
save fisherdata X d MU SIG N TH


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
load fisherdata
SIG(1,2)=get(hObject,'Value')*10;
[X,d] = Bds_gaussgen(MU,SIG,N);
plotfisher22(X,d,TH)
save fisherdata X d MU SIG N TH


% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider9_Callback(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
load fisherdata
SIG(2,1)=get(hObject,'Value')*10;
[X,d] = Bds_gaussgen(MU,SIG,N);
plotfisher22(X,d,TH)
save fisherdata X d MU SIG N TH


% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider10_Callback(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
load fisherdata
SIG(2,2)=get(hObject,'Value')*10;
[X,d] = Bds_gaussgen(MU,SIG,N);
plotfisher22(X,d,TH)
save fisherdata X d MU SIG N TH


% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function plotfisher22(X,d,th)
i1 = find(d==1);
i2 = find(d==2);
N = [length(i1);length(i2)];
m1 = ones(N(1),1)*mean(X(i1,:));
m2 = ones(N(2),1)*mean(X(i2,:));
Y = zeros(sum(N),2);
Y(i1,:) = [(X(i1,:)-m1)*[cos(th(1)) -sin(th(1));sin(th(1)) cos(th(1))]]+m1;
Y(i2,:) = [(X(i2,:)-m2)*[cos(th(2)) -sin(th(2));sin(th(2)) cos(th(2))]]+m2;
% plotfeatures(Y,d)
m = mean(X);
plot(Y(i1,1),Y(i1,2),'ro',Y(i2,1),Y(i2,2),'bx',m(1),m(2),'m*')
axis([-50 50 -50 50])
legend('Class 1','Class 2','Center')
J = jfisher(Y,d);
text(-40,30,sprintf('J=%f',J))

% J = jfisher(V,c,p)
%
% Toolbox: Balu
%    Fisher objective function J.
%    V features matrix. V(i,j) is the feature j of sample i.
%    c vector that indicates the ideal classification of the samples
%    p a priori probability of each class
%
% D.Mery, PUC-DCC, Apr. 2008
% http://dmery.ing.puc.cl


function J = jfisher(V,c,p)

% M: numero de caracteristicas
% N: numero de clases
% n: numero de muestras por clase

[n,M] = size(V);
cmin = min(c);
cmax = max(c);

N = cmax;

if not(exist('p'))
    p = ones(N,1)/N;
end

% la media de las caracteristicas es Vm
Vm = mean(V)';

L  = zeros(N,1);
Cw = zeros(M,M);
Cb = zeros(M,M);

for k=1:N
    ii   = find(c==k); % filas que pertenecen a la clase k
    L(k) = length(ii); % numero de muestras de la clase k
    Vk   = V(ii,:);    % muestras de la clase k
    Vkm  = mean(Vk)';  % media de la clase k 
    Ck = cov(Vk);      % covarianza de la clase k
    Cmk = (Vkm-Vm)*(Vkm-Vm)';
    % calculo de la covarianza intraclase (within-class covariance)
    Cw = Cw + p(k)*Ck; 
    
    % calculo de la covarianza interclase (between-class covariance)
    Cb = Cb + p(k)*Cmk;
    fprintf('Dispersion class %d\n',k)
    fprintf('Between-Class          Within-Class');    
    [ Cmk  Ck]
    
    
end

% calculo del discriminate Fisher
warning off
J = trace(inv(Cw)*Cb);
warning on
