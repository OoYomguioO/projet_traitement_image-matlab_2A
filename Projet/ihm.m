function varargout = ihm(varargin)
% IHM MATLAB code for ihm.fig
%      IHM, by itself, creates a new IHM or raises the existing
%      singleton*.
%
%      H = IHM returns the handle to a new IHM or the handle to
%      the existing singleton*.
%
%      IHM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IHM.M with the given input arguments.
%
%      IHM('Property','Value',...) creates a new IHM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ihm_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ihm_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ihm

% Last Modified by GUIDE v2.5 05-Jan-2021 09:17:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ihm_OpeningFcn, ...
                   'gui_OutputFcn',  @ihm_OutputFcn, ...
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


% --- Executes just before ihm is made visible.
function ihm_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ihm (see VARARGIN)

% Choose default command line output for ihm
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ihm wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ihm_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OuvertureImg.
function OuvertureImg_Callback(hObject, eventdata, handles)
% hObject    handle to OuvertureImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    name_file=uigetfile( '*.img');
    Fid = fopen(name_file);
    L = 1000;
    C = 1000;
    B = 3;
    donnees = fread(Fid, C * L * B,'*ubit8');
    fclose(Fid);
    donnees = reshape(donnees, C, L, B);
    IM(:,:,3)=donnees(:,:,1)';
    IM(:,:,2)=donnees(:,:,2)';
    IM(:,:,1)=donnees(:,:,3)';
    axes(handles.axes1);
    imshow(IM);
    
    h1=histogramme(IM(:,:,1));
    h2=histogramme(IM(:,:,2));
    h3=histogramme(IM(:,:,3));
    axes(handles.axes2);
    plot(h1,'r')
    hold on
    plot(h2,'g')
    plot(h3,'b')
    hold off
    
    assignin('base','image',IM);
    


% --- Executes on button press in Transformation_lineaire.
function Transformation_lineaire_Callback(hObject, eventdata, handles)
% hObject    handle to Transformation_lineaire (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    IM=evalin('base','image');
    IM2(:,:,1)=transformation_lineaire(IM(:,:,1));
    IM2(:,:,2)=transformation_lineaire(IM(:,:,2));
    IM2(:,:,3)=transformation_lineaire(IM(:,:,3));
    axes(handles.axes3);
    imshow(IM2);
    
    h1=histogramme(IM2(:,:,1));
    h2=histogramme(IM2(:,:,2));
    h3=histogramme(IM2(:,:,3));
    axes(handles.axes4);
    plot(h1,'r')
    hold on
    plot(h2,'g')
    plot(h3,'b')
    hold off
    
    assignin('base','image',IM2);
    


% --- Executes on button press in egalisation.
function egalisation_Callback(hObject, eventdata, handles)
% hObject    handle to egalisation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    IM=evalin('base','image');
    IM2(:,:,1)=egalisation(IM(:,:,1));
    IM2(:,:,2)=egalisation(IM(:,:,2));
    IM2(:,:,3)=egalisation(IM(:,:,3));
    axes(handles.axes3);
    imshow(IM2);
    
    h1=histogramme(IM2(:,:,1));
    h2=histogramme(IM2(:,:,2));
    h3=histogramme(IM2(:,:,3));
    axes(handles.axes4);
    plot(h1,'r')
    hold on
    plot(h2,'g')
    plot(h3,'b')
    hold off
    assignin('base','image',IM2);


% --- Executes on selection change in Prewitt.
function Prewitt_Callback(hObject, eventdata, handles)
% hObject    handle to Prewitt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Prewitt contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Prewitt
    IM=evalin('base','image');
    axes(handles.axes1);
    imshow(IM);
    
    h1=histogramme(IM(:,:,1));
    h2=histogramme(IM(:,:,2));
    h3=histogramme(IM(:,:,3));
    axes(handles.axes2);
    plot(h1,'r')
    hold on
    plot(h2,'g')
    plot(h3,'b')
    hold off
    
    IM=rgb2gray(IM);
    
    if (get(handles.Prewitt,'value')~=1)
        IM=Prewitt(IM, get(handles.Prewitt,'value'));
        axes(handles.axes3);
        imshow(IM);

        h=histogramme(IM);
        axes(handles.axes4);
        plot(h,'k')
    end 
    


% --- Executes during object creation, after setting all properties.
function Prewitt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Prewitt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Sobel.
function Sobel_Callback(hObject, eventdata, handles)
% hObject    handle to Sobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Sobel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Sobel
    IM=evalin('base','image');
    axes(handles.axes1);
    imshow(IM);
    
    h1=histogramme(IM(:,:,1));
    h2=histogramme(IM(:,:,2));
    h3=histogramme(IM(:,:,3));
    axes(handles.axes2);
    plot(h1,'r')
    hold on
    plot(h2,'g')
    plot(h3,'b')
    hold off
    
    IM=rgb2gray(IM);
    
    if (get(handles.Sobel,'value')~=1)
        IM=Sobel(IM, get(handles.Sobel,'value'));
        axes(handles.axes3);
        imshow(IM);

        h=histogramme(IM);
        axes(handles.axes4);
        plot(h,'k')
    end


% --- Executes during object creation, after setting all properties.
function Sobel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Bruit.
function Bruit_Callback(hObject, eventdata, handles)
% hObject    handle to Bruit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Bruit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Bruit
    IM=evalin('base','image');
    IM=rgb2gray(IM);
    
    axes(handles.axes1);
    imshow(IM);
    
    h=histogramme(IM(:,:,1));
    axes(handles.axes2);
    plot(h,'k')
    
    
    if(get(handles.Bruit,'Value')~=1)
        pop_string=get(handles.Bruit,'String');
        IM=imnoise(IM, pop_string{get(handles.Bruit,'Value')});
        axes(handles.axes3);
        imshow(IM);
        assignin('base','imageBruit',IM);
        
        h=histogramme(IM);
        axes(handles.axes4);
        plot(h,'k')
    end

% --- Executes during object creation, after setting all properties.
function Bruit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Bruit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in filtre.
function filtre_Callback(hObject, eventdata, handles)
% hObject    handle to filtre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns filtre contents as cell array
%        contents{get(hObject,'Value')} returns selected item from filtre

    IM=evalin('base','imageBruit');
    axes(handles.axes1);
    imshow(IM);
    
    h=histogramme(IM);
    axes(handles.axes2);
    plot(h,'k')
    
    if (get(handles.filtre,'value')~=1)
        IM=filtre(IM, get(handles.filtre,'value'));
        axes(handles.axes3);
        imshow(IM);

        h=histogramme(IM);
        axes(handles.axes4);
        plot(h,'k')
    end


% --- Executes during object creation, after setting all properties.
function filtre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filtre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function binarisation_Callback(hObject, eventdata, handles)
% hObject    handle to binarisation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    IM=evalin('base','image');
    axes(handles.axes1);
    imshow(IM);
    
    h1=histogramme(IM(:,:,1));
    h2=histogramme(IM(:,:,2));
    h3=histogramme(IM(:,:,3));
    axes(handles.axes2);
    plot(h1,'r')
    hold on
    plot(h2,'g')
    plot(h3,'b')
    hold off
    
    IM=binarisation(IM(:,:,1), get(hObject,'Value'));
    set(handles.text11,'string',get(hObject,'Value'));
    axes(handles.axes3);
    imshow(IM);
    
    h=histogramme(IM);
    axes(handles.axes4);
    plot(h,'k')


% --- Executes during object creation, after setting all properties.
function binarisation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to binarisation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function multiseuilsNB_Callback(hObject, eventdata, handles)
% hObject    handle to multiseuilsNB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of multiseuilsNB as text
%        str2double(get(hObject,'String')) returns contents of multiseuilsNB as a double
    IM=evalin('base','image');
    axes(handles.axes1);
    imshow(IM);
    
    h1=histogramme(IM(:,:,1));
    h2=histogramme(IM(:,:,2));
    h3=histogramme(IM(:,:,3));
    axes(handles.axes2);
    plot(h1,'r')
    hold on
    plot(h2,'g')
    plot(h3,'b')
    hold off
    
    IM=rgb2gray(IM);
    IM=multiseuilsNB(IM, str2double(get(hObject,'String')));
    axes(handles.axes3);
    imshow(IM);
    
    h=histogramme(IM);
    axes(handles.axes4);
    plot(h,'k')


% --- Executes during object creation, after setting all properties.
function multiseuilsNB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to multiseuilsNB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function multiseuilsC_Callback(hObject, eventdata, handles)
% hObject    handle to multiseuilsC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of multiseuilsC as text
%        str2double(get(hObject,'String')) returns contents of multiseuilsC as a double
    IM=evalin('base','image');
    axes(handles.axes1);
    imshow(IM);
    
    h1=histogramme(IM(:,:,1));
    h2=histogramme(IM(:,:,2));
    h3=histogramme(IM(:,:,3));
    axes(handles.axes2);
    plot(h1,'r')
    hold on
    plot(h2,'g')
    plot(h3,'b')
    hold off
    
    IM(:,:,1)=multiseuilsNB(IM(:,:,1), str2double(get(hObject,'String')));
    IM(:,:,2)=multiseuilsNB(IM(:,:,2), str2double(get(hObject,'String')));
    IM(:,:,3)=multiseuilsNB(IM(:,:,3), str2double(get(hObject,'String')));
    
    axes(handles.axes3);
    imshow(IM);
    
    h1=histogramme(IM(:,:,1));
    h2=histogramme(IM(:,:,2));
    h3=histogramme(IM(:,:,3));
    axes(handles.axes4);
    plot(h1,'r')
    hold on
    plot(h2,'g')
    plot(h3,'b')
    hold off
    

% --- Executes during object creation, after setting all properties.
function multiseuilsC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to multiseuilsC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Fermeture.
function Fermeture_Callback(hObject, eventdata, handles)
% hObject    handle to Fermeture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    IM=evalin('base','image');    
    axes(handles.axes1);
    imshow(IM);
    
    h1=histogramme(IM(:,:,1));
    h2=histogramme(IM(:,:,2));
    h3=histogramme(IM(:,:,3));
    axes(handles.axes2);
    plot(h1,'r')
    hold on
    plot(h2,'g')
    plot(h3,'b')
    hold off
    
    SE=[0 1 0; 1 1 1; 0 1 0];
    IM=imclose(IM, SE);
    axes(handles.axes3);
    imshow(IM);
    
    h1=histogramme(IM(:,:,1));
    h2=histogramme(IM(:,:,2));
    h3=histogramme(IM(:,:,3));
    axes(handles.axes4);
    plot(h1,'r')
    hold on
    plot(h2,'g')
    plot(h3,'b')
    hold off


% --- Executes on button press in Dilatation.
function Dilatation_Callback(hObject, eventdata, handles)
% hObject    handle to Dilatation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    IM=evalin('base','image');
    IM=rgb2gray(IM);
    
    axes(handles.axes1);
    imshow(IM);
    
    h=histogramme(IM);
    axes(handles.axes2);
    plot(h,'k')
    
    IM=Dilatation(IM);
    axes(handles.axes3);
    imshow(IM);
    
    h=histogramme(IM);
    axes(handles.axes4);
    plot(h,'k')


% --- Executes on button press in Erossion.
function Erossion_Callback(hObject, eventdata, handles)
% hObject    handle to Erossion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    IM=evalin('base','image');
    IM=rgb2gray(IM);
    
    axes(handles.axes1);
    imshow(IM);
    
    h=histogramme(IM);
    axes(handles.axes2);
    plot(h,'k')
    
    IM=Erosion(IM(:,:,1));
    axes(handles.axes3);
    imshow(IM);
    
    h=histogramme(IM);
    axes(handles.axes4);
    plot(h,'k')


% --- Executes on button press in Ouverture.
function Ouverture_Callback(hObject, eventdata, handles)
% hObject    handle to Ouverture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    IM=evalin('base','image');
    axes(handles.axes1);
    imshow(IM);
    
    h1=histogramme(IM(:,:,1));
    h2=histogramme(IM(:,:,2));
    h3=histogramme(IM(:,:,3));
    axes(handles.axes2);
    plot(h1,'r')
    hold on
    plot(h2,'g')
    plot(h3,'b')
    hold off
    
    SE=[0 1 0; 1 1 1; 0 1 0];
    IM=imopen(IM, SE);
    
    axes(handles.axes3);
    imshow(IM);
    
    h1=histogramme(IM(:,:,1));
    h2=histogramme(IM(:,:,2));
    h3=histogramme(IM(:,:,3));
    axes(handles.axes4);
    plot(h1,'r')
    hold on
    plot(h2,'g')
    plot(h3,'b')
    hold off


% --- Executes on button press in Morpho_filtrage.
function Morpho_filtrage_Callback(hObject, eventdata, handles)
% hObject    handle to Morpho_filtrage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    IM=evalin('base','image');
    IM=rgb2gray(IM);
    IM=imnoise(IM, 'salt & pepper');
    
    axes(handles.axes1);
    imshow(IM);
    
    h=histogramme(IM);
    axes(handles.axes2);
    plot(h,'k')
    
    IM=Dilatation(Dilatation(Erosion(IM)));

    axes(handles.axes3);
    imshow(IM);
    
    h=histogramme(IM);
    axes(handles.axes4);
    plot(h,'k')
  


% --- Executes on button press in Morpho_contour.
function Morpho_contour_Callback(hObject, eventdata, handles)
% hObject    handle to Morpho_contour (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    IM=evalin('base','image');
    axes(handles.axes1);
    imshow(IM);
    
    h1=histogramme(IM(:,:,1));
    h2=histogramme(IM(:,:,2));
    h3=histogramme(IM(:,:,3));
    axes(handles.axes2);
    plot(h1,'r')
    hold on
    plot(h2,'g')
    plot(h3,'b')
    hold off
    
    IM=rgb2gray(IM);
    
    IM=Sobel(IM, 4);
    IM=Dilatation(IM)-Erosion(IM);
    
    axes(handles.axes3);
    imshow(IM);
    
    h=histogramme(IM);
    axes(handles.axes4);
    plot(h,'k')
