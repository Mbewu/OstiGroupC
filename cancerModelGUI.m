%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% OstiCancerC - Code to reproduce results of "Patel et al. (2001) A 
% Cellular Automaton Model of Early Tumor Growth and Invasion*: The 
% Effects of Native Tissue Vascularity and Increased Anaerobic
% Tumor Metabolism" simulating cancer growth using a hybrid cellular 
% automaton model.
%
% Copyright (C) 2013  Jackie Ang, Jonny Brook-Bartlett, Alexander Erlich,
% James Mbewu and Robert Ross.
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function varargout = cancerModelGUI(varargin)
% cancerModelGUI MATLAB code for cancerModelGUI.fig
%      cancerModelGUI, by itself, creates a new cancerModelGUI or raises the existing
%      singleton*.

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cancerModelGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @cancerModelGUI_OutputFcn, ...
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

% --- Executes just before cancerModelGUI is made visible.
function cancerModelGUI_OpeningFcn(hObject, eventdata, handles, varargin)

handles.stop = false;

% Choose default command line output for cancerModelGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

function varargout = cancerModelGUI_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

function gridSizeN_Callback(hObject, eventdata, handles)

function gridSizeN_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function phi2_edit_Callback(hObject, eventdata, handles)

function phi2_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dtphi1_edit_Callback(hObject, eventdata, handles)

function dtphi1_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dtphi2_edit_Callback(hObject, eventdata, handles)

function dtphi2_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function g_edit_Callback(hObject, eventdata, handles)

function g_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function m1_edit_Callback(hObject, eventdata, handles)

function m1_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function m2_edit_Callback(hObject, eventdata, handles)

function m2_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function l1_edit_Callback(hObject, eventdata, handles)

function l1_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function l2_edit_Callback(hObject, eventdata, handles)

function l2_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function fps_edit_Callback(hObject, eventdata, handles)

function fps_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function duration_edit_Callback(hObject, eventdata, handles)

function duration_edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function run_button_Callback(hObject, eventdata, handles)
% RUN_BUTTON_CALLBACK Runs cancer model animation.
%
clc;
%% Define all of the main variables
    cancervariable.matrixrownumber  = str2num(get(handles.gridSizeN, 'string'));
    cancervariable.matrixcolnumber = str2num(get(handles.edit22, 'string'));
    cancervariable.vesseldensity = str2num(get(handles.dtphi1_edit, 'string'));
    cancervariable.initialtumourdiameter = str2num(get(handles.edit23, 'string'));
    cancervariable.G_S = str2num(get(handles.phi2_edit, 'string'));
    cancervariable.H_S = str2num(get(handles.edit29, 'string'));
    cancervariable.GdN = str2num(get(handles.g_edit, 'string'));
    cancervariable.GdT = str2num(get(handles.m1_edit, 'string'));
    cancervariable.pHdN = str2num(get(handles.m2_edit, 'string'));
    cancervariable.pHdT = str2num(get(handles.l1_edit, 'string'));
    cancervariable.pHqN = str2num(get(handles.l2_edit, 'string'));
    cancervariable.pHqT = str2num(get(handles.duration_edit, 'string'));
    cancervariable.noofogenerations = str2num(get(handles.edit24, 'string'));
    fInv = str2num(get(handles.fps_edit, 'string'));
    cancervariable.f = 1/fInv;
    f = cancervariable.f;
    cancervariable.kr = zeros(7,1);
    kN = str2num(get(handles.edit15, 'string'));
    kT = str2num(get(handles.edit16, 'string'));
    cancervariable.kr(2) = 0; % empty k
    cancervariable.kr(3) = kN; % normal k
    cancervariable.kr(4)= kT; % activetumor k (1/s)
    cancervariable.kr(5)= kT; % quiescenttumor k (1/s)
    cancervariable.kr(6)= kN; % quiescentnormal k (1/s)
    cancervariable.kr(7)= 0; % empty tumor k (1/s)
    cancervariable.hr = zeros(7,1);
    HTA = str2num(get(handles.edit17, 'string'));
    HTQ = str2num(get(handles.edit20, 'string'));
    cancervariable.hr(2) = 0; % empty k
    cancervariable.hr(3) = 0; % normal k
    cancervariable.hr(4)= HTA; % activetumor k (1/s)
    cancervariable.hr(5) = HTQ; % quiescenttumor
    cancervariable.hr(6) = 0; % quiescentnormal
    cancervariable.hr(7) = 0; % empty tumor k
    cancervariable.spacestep = str2num(get(handles.edit19, 'string'));
    cancervariable.D_G = str2num(get(handles.edit25, 'string'));
    cancervariable.D_H = str2num(get(handles.edit26, 'string'));
    cancervariable.q_G = str2num(get(handles.edit27, 'string'));
    cancervariable.q_H = str2num(get(handles.edit28, 'string'));
    
    cancervariable.statematrix = 3*ones(cancervariable.matrixrownumber,cancervariable.matrixcolnumber); % matrix representing the state of each grid element (i.e. is it  a micro-vessel = 1, empty normal = 2, normal cell = 3, activetumor cell = 4, quiescenttumor cell = 5, quiescent normal = 6, empty tumor = 7). Notice that we're populating the matrix with normal cells
    cancervariable.pHmatrix = ones(cancervariable.matrixrownumber,cancervariable.matrixcolnumber); % matrix representing the value of the pH of the corresponding grid element
    cancervariable.glucosematrix = ones(cancervariable.matrixrownumber,cancervariable.matrixcolnumber); % matrix representing the value of the glucose concentration of the corresponding grid element
    cancervariable.currentgeneration = 1;
    cancervariable.radiusOfGyration = zeros(cancervariable.noofogenerations,1);
    
%% Set up the initial state of the matrix and plot it
    cancervariable.statematrix = initStateMatrix(cancervariable);
    
    axes(handles.stateMatrixAxes);
    plotStateMatrix(cancervariable);
    
%% Calculate the matrices and plot the glucose, lactic acid and state matrices
N = cancervariable.matrixrownumber;
M = cancervariable.matrixcolnumber;
state_matrix = cancervariable.statematrix;

%RANDOMLY PICK 1/f OF CELLS TO UPDATE FOR SUB-GENERATION

for k = 1:cancervariable.noofogenerations
    
    cancervariable.currentgeneration = k;
    vector_random = randperm(N*M);
    
    %SUBGENERATIONS
    for n = 1:ceil(1/f)
        death_matrix = state_matrix;
        %%%%%%%ENTER GLUCOSE FUNCTION%%%%%%%%%%%
        cancervariable.glucosematrix = findGlucoseMatrix(cancervariable);
        %%%%%%%ENTER LACTIC ACID FUNCTION%%%%%%%%%%%
        cancervariable.pHmatrix = findPHMatrix(cancervariable);
        %%%%%%%ENTER STATE MATRIX FUNCTION%%%%%%%%%%
        state_matrix = subgeneration(cancervariable,n,death_matrix,state_matrix,vector_random);
        
        cancervariable.statematrix = state_matrix;
        axes(handles.glucoseAxes);
        plotGlucoseMatrix(cancervariable);
        
        axes(handles.pHAxes);
        plotPHMatrix(cancervariable);
    end
    
    axes(handles.stateMatrixAxes);
    plotStateMatrix(cancervariable);
    
    cancervariable.radiusOfGyration(k) = radiusOfGyration(cancervariable);
    axes(handles.tumorsize);
    plot(1:k,cancervariable.radiusOfGyration(1:k));
    title(['Radius of Gyration at Generation ' num2str(cancervariable.currentgeneration)]);
    xlabel('Generation no.');
    ylabel('Radius of Gy (cm)');

        
end



%growthRates(m) = growthRate;
      
    

function myFigure_CreateFcn(hObject, eventdata, handles, varargin)

function phi1_slider_Callback(hObject, eventdata, handles)

slider_value = get(hObject,'Value');
set(handles.gridSizeN, 'String', num2str(slider_value));

function phi1_slider_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function dtphi1_slider_Callback(hObject, eventdata, handles)

slider_value = get(hObject,'Value');
set(handles.dtphi1_edit, 'String', num2str(slider_value));

function dtphi1_slider_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function phi2_slider_Callback(hObject, eventdata, handles)

slider_value = get(hObject,'Value');
set(handles.phi2_edit, 'String', num2str(slider_value));

function phi2_slider_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function dtphi2_slider_Callback(hObject, eventdata, handles)

slider_value = get(hObject,'Value');
set(handles.dtphi2_edit, 'String', num2str(slider_value));

function dtphi2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dtphi2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function g_slider_Callback(hObject, eventdata, handles)

slider_value = get(hObject,'Value');
set(handles.g_edit, 'String', num2str(slider_value));



function g_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function m1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to m1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
slider_value = get(hObject,'Value');
set(handles.m1_edit, 'String', num2str(slider_value));


function m1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function m2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to m2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
slider_value = get(hObject,'Value');
set(handles.m2_edit, 'String', num2str(slider_value));


function m2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function l1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to l1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
slider_value = get(hObject,'Value');
set(handles.l1_edit, 'String', num2str(slider_value));


function l1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to l1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function l2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to l2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
slider_value = get(hObject,'Value');
set(handles.l2_edit, 'String', num2str(slider_value));


function l2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to l2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function duration_slider_Callback(hObject, eventdata, handles)

slider_value = get(hObject,'Value');
set(handles.duration_edit, 'String', num2str(slider_value));


function duration_slider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fps_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fps_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
slider_value = get(hObject,'Value');
set(handles.fps_edit, 'String', num2str(slider_value));


function fps_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fps_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function stateMatrixAxes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stateMatrixAxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate stateMatrixAxes


% --- Executes during object creation, after setting all properties.
function glucoseAxes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to glucoseAxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate glucoseAxes


% --- Executes during object creation, after setting all properties.
function pHAxes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pHAxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate pHAxes



function edit29_Callback(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit29 as text
%        str2double(get(hObject,'String')) returns contents of edit29 as a double


function edit29_CreateFcn(hObject, eventdata, handles)

function edit28_CreateFcn(hObject, eventdata, handles)

function edit27_CreateFcn(hObject, eventdata, handles)

function edit26_CreateFcn(hObject, eventdata, handles)

function edit25_CreateFcn(hObject, eventdata, handles)

function edit24_CreateFcn(hObject, eventdata, handles)

function edit23_CreateFcn(hObject, eventdata, handles)

function edit22_CreateFcn(hObject, eventdata, handles)




% --- Executes during object creation, after setting all properties.
function tumorsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tumorsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate tumorsize
