function show_changing_JPEG_quality
% Generuje posloupnost JPEG obrazu s menici se kvalitou,
% uklada vysledek jako film

% (c) 2019 Syrine Ben Ameur, Pavel Rajmic, Brno University of Technology

home;
close all
clear variables

%% Input image
img = imread('baboon_small.jpg');
img = rgb2gray(img);

%% Set parameters
qualities = [100 99 98 97:-3:10 8 6 5:-1:1];
% step = -3;
% final_quality = 2;
param.verbose = false; %ukecanost koderu a dekoderu


%% vyvolani JPEG tabulek (jednorazove)
htaclum = huffman_table_ac_lum();
htdclum = huffman_table_dc_lum();

[dim_vert, dim_horiz] = size(img); %zjisteni velikosti

%% Initialize movie object
movie = VideoWriter('show_changing_JPEG_quality','Grayscale AVI'); %not to mix compression of the video with compression of JPEG!
movie.FrameRate = 1/0.55; %frames per second
open(movie);

%% Write original image
% img = insertText(img, [1,1], sprintf('Original Image'));
current_image_with_text = insert_text(img,['original']);
writeVideo(movie, current_image_with_text);

%% Write compressed images
% for quality = initial_quality:step:final_quality
for quality = qualities
    disp(['Kodovani a dekodovani obrazku s kvalitou ' num2str(quality)])

    Qmtx = quant_matrix(quality); % kvantizacni matice pro danou kvalitu
    bitstream = ... %koder
        jpeg_encode(img, Qmtx, htaclum, htdclum, param);
    current_image = ... %dekoder
        jpeg_decode(bitstream, Qmtx, htaclum, htdclum, dim_horiz, dim_vert, param);
    
    %PSNR
    MSEr = norm(double(img-current_image),'fro')^2 / dim_vert / dim_horiz;
    PSNR = 10*log10(255^2 / MSEr);
    
    %add text
    current_image_with_text = insert_text(current_image,['JPEG Q=' num2str(quality) ', PSNR=' num2str(round(PSNR,2)) ' dB']);
    %     this_image = insertText(this_image.CData, [1,1], sprintf('JPEG, Q = %d ', quality));

   
    writeVideo(movie, current_image_with_text);
end

close(movie);

end

%%%%%%%%%%%%%%%%%%%%%
function IMGtxt = insert_text(IMG,txt)
    IMGtxt = IMG;
    figure
    imshow(IMGtxt)
    text('units','normalized','position',[.02 .95],'fontsize',12,'Color','white','string',txt)
    IMGtxt = getframe(gca); %shot the image
    IMGtxt = IMGtxt.cdata; %extract only data
    IMGtxt = IMGtxt(:,:,1); %extract only one component since it was a greyscale image
    close
end