function varargout = WebCam(varargin)
% WEBCAM MATLAB code for WebCam.fig
%      WEBCAM, by itself, creates a new WEBCAM or raises the existing
%      singleton*.
%
%      H = WEBCAM returns the handle to a new WEBCAM or the handle to
%      the existing singleton*.
%
%      WEBCAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WEBCAM.M with the given input arguments.
%
%      WEBCAM('Property','Value',...) creates a new WEBCAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before WebCam_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WebCam_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help WebCam

% Last Modified by GUIDE v2.5 05-Jan-2021 11:30:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WebCam_OpeningFcn, ...
                   'gui_OutputFcn',  @WebCam_OutputFcn, ...
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


% --- Executes just before WebCam is made visible.
function WebCam_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to WebCam (see VARARGIN)

% Choose default command line output for WebCam
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes WebCam wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = WebCam_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Affiche.
function Affiche_Callback(hObject, eventdata, handles)
% hObject    handle to Affiche (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    set(handles.Stop,'UserData',0); 
    vid = videoinput('winvideo',1,'MJPG_1280x720'); % à adapter à VOTRE caméra 
    set(vid,'FramesPerTrigger',1); 
    set(vid,'TriggerRepeat',Inf); 
    triggerconfig(vid, 'Manual'); 
    start(vid); 
    trigger(vid); 

    IM = (getdata(vid,1,'uint8')); 

    while ~(get(handles.Stop,'UserData'))
        trigger(vid); 
        IM = (getdata(vid,1,'uint8'));   

        axes(handles.axes1) 
        subimage(IM)
             
        h1=histogramme(IM(:,:,1));
        h2=histogramme(IM(:,:,2));
        h3=histogramme(IM(:,:,3));
        axes(handles.axes2);
        plot(h1,'r')
        hold on
        plot(h2,'g')
        plot(h3,'b')
        hold off
        
    
    end 
    stop(vid); 
    return 


% --- Executes on button press in Stop.
function Stop_Callback(hObject, eventdata, handles)
% hObject    handle to Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.Stop,'enable','on');
    set(handles.Stop,'UserData',1);



% --- Executes on selection change in Sobel.
function Sobel_Callback(hObject, eventdata, handles)
% hObject    handle to Sobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Sobel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Sobel
    set(handles.Stop,'UserData',0); 
    vid = videoinput('winvideo',1,'MJPG_1280x720'); % à adapter à VOTRE caméra 
    set(vid,'FramesPerTrigger',1); 
    set(vid,'TriggerRepeat',Inf); 
    triggerconfig(vid, 'Manual'); 
    start(vid); 
    trigger(vid); 

    IM = (getdata(vid,1,'uint8')); 

    while ~(get(handles.Stop,'UserData'))
        trigger(vid); 
        IM = (getdata(vid,1,'uint8'));   

        axes(handles.axes1) 
        subimage(IM)
             
        h1=histogramme(IM(:,:,1));
        h2=histogramme(IM(:,:,2));
        h3=histogramme(IM(:,:,3));
        axes(handles.axes2);
        plot(h1,'r')
        hold on
        plot(h2,'g')
        plot(h3,'b')
        hold off
            
        if (get(handles.Sobel,'value')~=1)
            IM=rgb2gray(IM);
            IM=Sobel(IM, get(handles.Sobel,'value'));
            axes(handles.axes3);
            imshow(IM);

            h=histogramme(IM);
            axes(handles.axes4);
            plot(h,'k')
        end

    end 
    stop(vid); 
    return 

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


% --- Executes on selection change in Prewitt.
function Prewitt_Callback(hObject, eventdata, handles)
% hObject    handle to Prewitt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Prewitt contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Prewitt

    set(handles.Stop,'UserData',0); 
    vid = videoinput('winvideo',1,'MJPG_1280x720'); % à adapter à VOTRE caméra 
    set(vid,'FramesPerTrigger',1); 
    set(vid,'TriggerRepeat',Inf); 
    triggerconfig(vid, 'Manual'); 
    start(vid); 
    trigger(vid); 

    IM = (getdata(vid,1,'uint8')); 

    while ~(get(handles.Stop,'UserData'))
        trigger(vid); 
        IM = (getdata(vid,1,'uint8'));

        axes(handles.axes1) 
        subimage(IM)
             
        h1=histogramme(IM(:,:,1));
        h2=histogramme(IM(:,:,2));
        h3=histogramme(IM(:,:,3));
        axes(handles.axes2);
        plot(h1,'r')
        hold on
        plot(h2,'g')
        plot(h3,'b')
        hold off
        
        if (get(handles.Prewitt,'value')~=1)
            IM=rgb2gray(IM);
            IM=Prewitt(IM, get(handles.Prewitt,'value'));
            axes(handles.axes3);
            imshow(IM);

            h=histogramme(IM);
            axes(handles.axes4);
            plot(h,'k')
        end

    end 
    stop(vid); 
    return 

        
   
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


% --- Executes on selection change in Bruit.
function Bruit_Callback(hObject, eventdata, handles)
% hObject    handle to Bruit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Bruit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Bruit
    set(handles.Stop,'UserData',0); 
    vid = videoinput('winvideo',1,'MJPG_1280x720'); % à adapter à VOTRE caméra 
    set(vid,'FramesPerTrigger',1); 
    set(vid,'TriggerRepeat',Inf); 
    triggerconfig(vid, 'Manual'); 
    start(vid); 
    trigger(vid); 

    IM = (getdata(vid,1,'uint8')); 

    while ~(get(handles.Stop,'UserData'))
        trigger(vid); 
        IM = (getdata(vid,1,'uint8')); 
        IM=rgb2gray(IM);

        axes(handles.axes1) 
        subimage(IM)
             
        h=histogramme(IM);
        axes(handles.axes2);
        plot(h,'k')
       
    
        if(get(handles.Bruit,'Value')~=1)
            pop_string=get(handles.Bruit,'String');
            IM=imnoise(IM, pop_string{get(handles.Bruit,'Value')});
            axes(handles.axes3);
            imshow(IM);

            h=histogramme(IM);
            axes(handles.axes4);
            plot(h,'k')
        end
        
    
    end 
    stop(vid); 
    return

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


% --- Executes on selection change in Filtre.
function Filtre_Callback(hObject, eventdata, handles)
% hObject    handle to Filtre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Filtre contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Filtre
    set(handles.Stop,'UserData',0); 
    vid = videoinput('winvideo',1,'MJPG_1280x720'); % à adapter à VOTRE caméra 
    set(vid,'FramesPerTrigger',1); 
    set(vid,'TriggerRepeat',Inf); 
    triggerconfig(vid, 'Manual'); 
    start(vid); 
    trigger(vid); 

    IM = (getdata(vid,1,'uint8')); 
    

    while ~(get(handles.Stop,'UserData'))
        trigger(vid); 
        IM = (getdata(vid,1,'uint8'));  
        IM=rgb2gray(IM);
        
        if(get(handles.Bruit,'Value')~=1)
            pop_string=get(handles.Bruit,'String');
            IM=imnoise(IM, pop_string{get(handles.Bruit,'Value')});
            axes(handles.axes1);
            imshow(IM);

            h=histogramme(IM);
            axes(handles.axes2);
            plot(h,'k')
        end

    
        if (get(handles.Filtre,'value')~=1)
            IM=filtre(IM, get(handles.Filtre,'value'));
            axes(handles.axes3);
            imshow(IM);

            h=histogramme(IM);
            axes(handles.axes4);
            plot(h,'k')
        end
        
    
    end 
    stop(vid); 
    return

% --- Executes during object creation, after setting all properties.
function Filtre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Filtre (see GCBO)
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
    set(handles.Stop,'UserData',0); 
    vid = videoinput('winvideo',1,'MJPG_1280x720'); % à adapter à VOTRE caméra 
    set(vid,'FramesPerTrigger',1); 
    set(vid,'TriggerRepeat',Inf); 
    triggerconfig(vid, 'Manual'); 
    start(vid); 
    trigger(vid); 

    IM = (getdata(vid,1,'uint8')); 

    while ~(get(handles.Stop,'UserData'))
        trigger(vid); 
        IM = (getdata(vid,1,'uint8'));   

        axes(handles.axes1) 
        subimage(IM)
             
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
        set(handles.text15,'string',get(hObject,'Value'));
        axes(handles.axes3);
        imshow(IM);

        h=histogramme(IM);
        axes(handles.axes4);
        plot(h,'k')
        
    end 
    stop(vid); 
    return 

% --- Executes during object creation, after setting all properties.
function binarisation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to binarisation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function multiseuilsC_Callback(hObject, eventdata, handles)
% hObject    handle to multiseuilsC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of multiseuilsC as text
%        str2double(get(hObject,'String')) returns contents of multiseuilsC as a double
    set(handles.Stop,'UserData',0); 
    vid = videoinput('winvideo',1,'MJPG_1280x720'); % à adapter à VOTRE caméra 
    set(vid,'FramesPerTrigger',1); 
    set(vid,'TriggerRepeat',Inf); 
    triggerconfig(vid, 'Manual'); 
    start(vid); 
    trigger(vid); 

    IM = (getdata(vid,1,'uint8')); 

    while ~(get(handles.Stop,'UserData'))
        trigger(vid); 
        IM = (getdata(vid,1,'uint8'));   

        axes(handles.axes1) 
        subimage(IM)
             
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
        
    
    end 
    stop(vid); 
    return 

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



function multiseuilsNB_Callback(hObject, eventdata, handles)
% hObject    handle to multiseuilsNB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of multiseuilsNB as text
%        str2double(get(hObject,'String')) returns contents of multiseuilsNB as a double
    set(handles.Stop,'UserData',0); 
    vid = videoinput('winvideo',1,'MJPG_1280x720'); % à adapter à VOTRE caméra 
    set(vid,'FramesPerTrigger',1); 
    set(vid,'TriggerRepeat',Inf); 
    triggerconfig(vid, 'Manual'); 
    start(vid); 
    trigger(vid); 

    IM = (getdata(vid,1,'uint8')); 

    while ~(get(handles.Stop,'UserData'))
        trigger(vid); 
        IM = (getdata(vid,1,'uint8'));   

        axes(handles.axes1) 
        subimage(IM)
             
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
        
    
    end 
    stop(vid); 
    return 

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
