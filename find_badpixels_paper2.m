% Display each assigned sample on according image to determine bad, good or
% tentative pixels (contaminated by haze, cloud or shadow)


samples = readtable('..\BPL_chla_modelling_RSdata\vis_forbadpixeldetermination.csv');
images = load('..\Data\S2_img_AC_acolite_2014-2019\SatData_S2_L2R');

 figure
badpixels = [];
for i = 1 : height(samples)
        image = images.SatData_S2_L2R.images(:,:,[4,3,2],samples.x_img(i) + 1);
        location = [samples.pix_X(i), samples.pix_Y(i)];
        DisplaySampleOnImage(image , location, 'fullscreen',  samples.Date(i), samples.Lab_Chla(i), samples.SiteNumber(i))
        answer = menu('is the pixel an outlier?', 'No', 'Yes', 'Tentative')
        badpixels(i) = answer-1     
end

writematrix(badpixels, 'badpixels_S2_samedaySamples.csv')