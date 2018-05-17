function varargout = digital_image_processing(varargin)
% DIGITAL_IMAGE_PROCESSING MATLAB code for digital_image_processing.fig
%      DIGITAL_IMAGE_PROCESSING, by itself, creates a new DIGITAL_IMAGE_PROCESSING or raises the existing
%      singleton*.
%
%      H = DIGITAL_IMAGE_PROCESSING returns the handle to a new DIGITAL_IMAGE_PROCESSING or the handle to
%      the existing singleton*.
%
%      DIGITAL_IMAGE_PROCESSING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIGITAL_IMAGE_PROCESSING.M with the given input arguments.
%
%      DIGITAL_IMAGE_PROCESSING('Property','Value',...) creates a new DIGITAL_IMAGE_PROCESSING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before digital_image_processing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to digital_image_processing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help digital_image_processing

% Last Modified by GUIDE v2.5 17-May-2018 09:25:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @digital_image_processing_OpeningFcn, ...
                   'gui_OutputFcn',  @digital_image_processing_OutputFcn, ...
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


% --- Executes just before digital_image_processing is made visible.
function digital_image_processing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to digital_image_processing (see VARARGIN)

% Choose default command line output for digital_image_processing
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes digital_image_processing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = digital_image_processing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_general_open.
function btn_general_open_Callback(hObject, eventdata, handles)
% hObject    handle to btn_general_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ori_img mod_img flip_rotate noisy_img not_grayscale not_invert
[path, user_cancel]=imgetfile;
if user_cancel == 0
    if ispc
        L = path=='\';
    else
        L = path=='/';
    end
    m = find(L==1, 2,'last');
    L = path=='.';
    n = find(L==1, 1,'last');
    file_name = path(m+1:n-1);
    set(handles.lbl_info_name, 'String', file_name);
    set(handles.lbl_info_status, 'String', "Image Loaded!");
else
    set(handles.lbl_info_status, 'String', "Load Failed!");
end

ori_img = imread(path);
[x, y, z] = size(ori_img);

set(handles.lbl_info_dimens, 'String', x + "px X " + y + "px");

mod_img = ori_img;
flip_rotate = ori_img;
noisy_img = ori_img;

not_grayscale = true;
not_invert = true;

axes(handles.axes_img_original);
imshow(mod_img);


% --- Executes on button press in btn_general_reset.
function btn_general_reset_Callback(hObject, eventdata, handles)
% hObject    handle to btn_general_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ori_img mod_img flip_rotate noisy_img not_grayscale not_invert
not_grayscale = true;
not_invert = true;
mod_img = ori_img;
flip_rotate = ori_img;
noisy_img = ori_img;

axes(handles.axes_img_mod);
imshow(mod_img);

% --- Executes on button press in btn_hist_rgb.
function btn_hist_rgb_Callback(hObject, eventdata, handles)
% hObject    handle to btn_hist_rgb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ori_img

[x, y_red, y_green, y_blue] = histogramRGB(ori_img);

figure('Name','Histogram','NumberTitle','off');
subplot(3, 1, 1), bar(x, y_red, 'r'), title('Histogram Red');
subplot(3, 1, 2), bar(x, y_green, 'g'), title('Histogram Green');
subplot(3, 1, 3), bar(x, y_blue, 'b'), title('Histogram Blue');


% --- Executes on button press in btn_hist_overall.
function btn_hist_overall_Callback(hObject, eventdata, handles)
% hObject    handle to btn_hist_overall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ori_img

[x, y] = histogramOverall(ori_img);

figure('Name','Overall Histogram','NumberTitle','off');
bar(x, y);

% --- Executes on button press in btn_colour_gray.
function btn_colour_gray_Callback(hObject, eventdata, handles)
% hObject    handle to btn_colour_gray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mod_img not_grayscale
if not_grayscale == true
    mod_img = colorGrayscale(mod_img);
    not_grayscale = false;
end

axes(handles.axes_img_mod);
imshow(mod_img);

% --- Executes on button press in btn_colour_invert.
function btn_colour_invert_Callback(hObject, eventdata, handles)
% hObject    handle to btn_colour_invert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mod_img not_invert
if not_invert == true
    mod_img = colorInvert(mod_img);
    not_invert = false;
end

axes(handles.axes_img_mod);
imshow(mod_img);


% --- Executes on button press in RadioPlus.
function RadioPlus_Callback(hObject, eventdata, handles)
% hObject    handle to RadioPlus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RadioPlus


% --- Executes on button press in RadioMinus.
function RadioMinus_Callback(hObject, eventdata, handles)
% hObject    handle to RadioMinus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RadioMinus


% --- Executes on button press in RadioMultiply.
function RadioMultiply_Callback(hObject, eventdata, handles)
% hObject    handle to RadioMultiply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RadioMultiply


% --- Executes on button press in RadioDivide.
function RadioDivide_Callback(hObject, eventdata, handles)
% hObject    handle to RadioDivide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RadioDivide



function EditNumBrightness_Callback(hObject, eventdata, handles)
% hObject    handle to EditNumBrightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditNumBrightness as text
%        str2double(get(hObject,'String')) returns contents of EditNumBrightness as a double
% set(handles.LabelBrightnessValue, 'String', value);

% --- Executes during object creation, after setting all properties.
function EditNumBrightness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditNumBrightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in BtnBrightness.
function BtnBrightness_Callback(hObject, eventdata, handles)
% hObject    handle to BtnBrightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mod_img
value = str2num(get(handles.EditNumBrightness, 'String'));

if get(handles.RadioPlus, 'Value')
    mod_img = colorIntentsity(mod_img, value, "Plus");
    
elseif get(handles.RadioMinus, 'Value')
    mod_img = colorIntentsity(mod_img, value, "Minus");
    
elseif get(handles.RadioMultiply, 'Value')
    mod_img = colorIntentsity(mod_img, value, "Multiply");
    
elseif get(handles.RadioDivide, 'Value')
    mod_img = colorIntentsity(mod_img, value, "Divide");
    
end

axes(handles.axes_img_mod);
imshow(mod_img);


% --- Executes on button press in btn_tool_zoom_in.
function btn_tool_zoom_in_Callback(hObject, eventdata, handles)
% hObject    handle to btn_tool_zoom_in (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ori_img

toolZoomIn(ori_img);


% --- Executes on button press in btn_tool_zoom_out.
function btn_tool_zoom_out_Callback(hObject, eventdata, handles)
% hObject    handle to btn_tool_zoom_out (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ori_img

toolZoomOut(ori_img);

% --- Executes on button press in btn_crop.
function btn_crop_Callback(hObject, eventdata, handles)
% hObject    handle to btn_crop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ori_img

temp_img = toolCrop(ori_img);

axes(handles.axes_img_mod);
imshow(temp_img);



% --- Executes on button press in btn_flip_vertical.
function btn_flip_vertical_Callback(hObject, eventdata, handles)
% hObject    handle to btn_flip_vertical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ori_img flip_rotate

flip_rotate = toolFlipVertical(flip_rotate);

axes(handles.axes_img_mod);
imshow(flip_rotate);

% --- Executes on button press in btn_flip_horizon.
function btn_flip_horizon_Callback(hObject, eventdata, handles)
% hObject    handle to btn_flip_horizon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ori_img flip_rotate

flip_rotate = toolFlipHorizontal(flip_rotate);

axes(handles.axes_img_mod);
imshow(flip_rotate);


% --- Executes on button press in btn_rotate_90_cw.
function btn_rotate_90_cw_Callback(hObject, eventdata, handles)
% hObject    handle to btn_rotate_90_cw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ori_img flip_rotate

flip_rotate = toolRotateCW(flip_rotate);

axes(handles.axes_img_mod);
imshow(flip_rotate);

% --- Executes on button press in btn_rotate_90_cc.
function btn_rotate_90_cc_Callback(hObject, eventdata, handles)
% hObject    handle to btn_rotate_90_cc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ori_img flip_rotate

flip_rotate = toolRotateCC(flip_rotate);

axes(handles.axes_img_mod);
imshow(flip_rotate);


% --- Executes on button press in btn_conv_blur.
function btn_conv_blur_Callback(hObject, eventdata, handles)
% hObject    handle to btn_conv_blur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ori_img

kernel = [1/9 1/9 1/9; 1/9 1/9 1/9; 1/9 1/9 1/9];

temp_img = convolution(ori_img, kernel);

axes(handles.axes_img_mod);
imshow(temp_img);


% --- Executes on button press in btn_conv_sharp.
function btn_conv_sharp_Callback(hObject, eventdata, handles)
% hObject    handle to btn_conv_sharp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ori_img

kernel = [0 -1 0; -1 5 -1; 0 -1 0];

temp_img = convolution(ori_img, kernel);

axes(handles.axes_img_mod);
imshow(temp_img);


% --- Executes on button press in btn_conv_edge.
function btn_conv_edge_Callback(hObject, eventdata, handles)
% hObject    handle to btn_conv_edge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ori_img

kernel = [1 1 1; 1 -8 1; 1 1 1];

temp_img = convolution(ori_img, kernel);

axes(handles.axes_img_mod);
imshow(temp_img);

% --- Executes on button press in btn_general_compress.
function btn_general_compress_Callback(hObject, eventdata, handles)
% hObject    handle to btn_general_compress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ori_img

temp_img = imageCompression(ori_img);

set(handles.lbl_info_status, 'String', "Compression Successfull!");

axes(handles.axes_img_mod);
imshow(temp_img);


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to txt_info_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_info_name as text
%        str2double(get(hObject,'String')) returns contents of txt_info_name as a double


% --- Executes during object creation, after setting all properties.
function txt_info_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_info_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to txt_info_dimens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_info_dimens as text
%        str2double(get(hObject,'String')) returns contents of txt_info_dimens as a double


% --- Executes during object creation, after setting all properties.
function txt_info_dimens_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_info_dimens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_noise_generate.
function btn_noise_generate_Callback(hObject, eventdata, handles)
% hObject    handle to btn_noise_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global noisy_img
noisy_img = imnoise(noisy_img,'salt & pepper',0.02);

axes(handles.axes_img_mod);
imshow(noisy_img);


% --- Executes on button press in btn_noise_mean.
function btn_noise_mean_Callback(hObject, eventdata, handles)
% hObject    handle to btn_noise_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global noisy_img

temp_img = noiseFilterMean(noisy_img);

axes(handles.axes_img_mod);
imshow(temp_img);


% --- Executes on button press in btn_noise_median.
function btn_noise_median_Callback(hObject, eventdata, handles)
% hObject    handle to btn_noise_median (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global noisy_img

temp_img = noiseFilterMedian(noisy_img);

axes(handles.axes_img_mod);
imshow(temp_img);


% --- Executes on button press in btn_noise_modus.
function btn_noise_modus_Callback(hObject, eventdata, handles)
% hObject    handle to btn_noise_modus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global noisy_img

temp_img = noiseFilterModus(noisy_img);

axes(handles.axes_img_mod);
imshow(temp_img);


% --- Executes on button press in btn_segment_threshold.
function btn_segment_threshold_Callback(hObject, eventdata, handles)
% hObject    handle to btn_segment_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ori_img

bot_r = str2double(get(handles.edit_th_red_bot, 'String'));
bot_g = str2double(get(handles.edit_th_green_bot, 'String'));
bot_b = str2double(get(handles.edit_th_blue_bot, 'String'));

top_r = str2double(get(handles.edit_th_red_top, 'String'));
top_g = str2double(get(handles.edit_th_green_top, 'String'));
top_b = str2double(get(handles.edit_th_blue_top, 'String'));


temp_img = segmentThreshold(ori_img, bot_r, bot_g, bot_b, top_r, top_g, top_b);

axes(handles.axes_img_mod);
imshow(temp_img);

% --- Executes on button press in btn_segment_regrow.
function btn_segment_regrow_Callback(hObject, eventdata, handles)
% hObject    handle to btn_segment_regrow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ori_img

[x, y] = getpts(handles.axes_img_original);

x = uint8(x);
y = uint8(y);

temp_img = segmentRegionGrowth(ori_img, x, y);

axes(handles.axes_img_mod);
imshow(ori_img+temp_img);


% --- Executes on button press in btn_morph_dilation.
function btn_morph_dilation_Callback(hObject, eventdata, handles)
% hObject    handle to btn_morph_dilation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ori_img

morphDilation(ori_img);


% --- Executes on button press in btn_morph_erotion.
function btn_morph_erotion_Callback(hObject, eventdata, handles)
% hObject    handle to btn_morph_erotion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ori_img

morphErotion(ori_img);


% --- Executes on button press in btn_conv_custom.
function btn_conv_custom_Callback(hObject, eventdata, handles)
% hObject    handle to btn_conv_custom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ori_img
edit_1 = str2double(get(handles.edit_ker_1, 'String'));
edit_2 = str2double(get(handles.edit_ker_2, 'String'));
edit_3 = str2double(get(handles.edit_ker_3, 'String'));
edit_4 = str2double(get(handles.edit_ker_4, 'String'));
edit_5 = str2double(get(handles.edit_ker_5, 'String'));
edit_6 = str2double(get(handles.edit_ker_6, 'String'));
edit_7 = str2double(get(handles.edit_ker_7, 'String'));
edit_8 = str2double(get(handles.edit_ker_8, 'String'));
edit_9 = str2double(get(handles.edit_ker_9, 'String'));

kernel = [edit_1 edit_2 edit_3; edit_4 edit_5 edit_6; edit_7 edit_8 edit_9];

temp_img = convolution(ori_img, kernel);

axes(handles.axes_img_mod);
imshow(temp_img);



function edit_ker_9_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ker_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ker_9 as text
%        str2double(get(hObject,'String')) returns contents of edit_ker_9 as a double


% --- Executes during object creation, after setting all properties.
function edit_ker_9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ker_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ker_6_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ker_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ker_6 as text
%        str2double(get(hObject,'String')) returns contents of edit_ker_6 as a double


% --- Executes during object creation, after setting all properties.
function edit_ker_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ker_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ker_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ker_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ker_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_ker_3 as a double


% --- Executes during object creation, after setting all properties.
function edit_ker_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ker_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ker_8_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ker_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ker_8 as text
%        str2double(get(hObject,'String')) returns contents of edit_ker_8 as a double


% --- Executes during object creation, after setting all properties.
function edit_ker_8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ker_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ker_5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ker_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ker_5 as text
%        str2double(get(hObject,'String')) returns contents of edit_ker_5 as a double


% --- Executes during object creation, after setting all properties.
function edit_ker_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ker_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ker_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ker_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ker_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_ker_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_ker_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ker_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ker_7_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ker_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ker_7 as text
%        str2double(get(hObject,'String')) returns contents of edit_ker_7 as a double


% --- Executes during object creation, after setting all properties.
function edit_ker_7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ker_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ker_4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ker_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ker_4 as text
%        str2double(get(hObject,'String')) returns contents of edit_ker_4 as a double


% --- Executes during object creation, after setting all properties.
function edit_ker_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ker_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ker_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ker_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ker_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_ker_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_ker_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ker_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_th_red_bot_Callback(hObject, eventdata, handles)
% hObject    handle to edit_th_red_bot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_th_red_bot as text
%        str2double(get(hObject,'String')) returns contents of edit_th_red_bot as a double


% --- Executes during object creation, after setting all properties.
function edit_th_red_bot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_th_red_bot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_th_red_top_Callback(hObject, eventdata, handles)
% hObject    handle to edit_th_red_top (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_th_red_top as text
%        str2double(get(hObject,'String')) returns contents of edit_th_red_top as a double


% --- Executes during object creation, after setting all properties.
function edit_th_red_top_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_th_red_top (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_th_blue_top_Callback(hObject, eventdata, handles)
% hObject    handle to edit_th_blue_top (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_th_blue_top as text
%        str2double(get(hObject,'String')) returns contents of edit_th_blue_top as a double


% --- Executes during object creation, after setting all properties.
function edit_th_blue_top_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_th_blue_top (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_th_blue_bot_Callback(hObject, eventdata, handles)
% hObject    handle to edit_th_blue_bot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_th_blue_bot as text
%        str2double(get(hObject,'String')) returns contents of edit_th_blue_bot as a double


% --- Executes during object creation, after setting all properties.
function edit_th_blue_bot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_th_blue_bot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_th_green_top_Callback(hObject, eventdata, handles)
% hObject    handle to edit_th_green_top (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_th_green_top as text
%        str2double(get(hObject,'String')) returns contents of edit_th_green_top as a double


% --- Executes during object creation, after setting all properties.
function edit_th_green_top_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_th_green_top (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_th_green_bot_Callback(hObject, eventdata, handles)
% hObject    handle to edit_th_green_bot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_th_green_bot as text
%        str2double(get(hObject,'String')) returns contents of edit_th_green_bot as a double


% --- Executes during object creation, after setting all properties.
function edit_th_green_bot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_th_green_bot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes_img_mod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_img_mod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_img_mod
