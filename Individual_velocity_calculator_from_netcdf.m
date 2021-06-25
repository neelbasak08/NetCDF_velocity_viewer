%%The following piece of MATLAB script for calculating u,v,w velocities
%%has been written and developed by Mr Shankhaneel Basak , undergraduate 
%%at Thapar Institute of Engineering and Technology, Patiala. Date of issue
%%21-February-2021. The script has been tested on MATLAB 2014b and MATLAB 2012a
%%requires mexcdf and snctools for reading netcdf files in these reeleases.
%%The author holds no guarentee for use of the script in any later versions
%%of MATLAB.
%%Shankhaneel Basak sbasak_be18@thapar.edu@thapar.edu
%%
%% Copyright (c) 2021 - Shankhaneel Basak - sbasak_be18@thapar.edu.edu
%%$Id: individual_cordinates_velocity.m 592 2020-12-28 21:56:28Z neel $
% file = 'Lombok_roms_his.nc';  %enter your filename
% 
% %The latitude range in the file is -8.96036167119211 to -8.2089282952945.
% %The longitude range in the file is 115.175227369057 to 116.320809555245.
% %Latitude and Longitude ranges are subjected to vary on a case by case basis
% 
% latitude = ncread(file,'lat_u');
% longitude = ncread(file,'lon_u');
% mask = ncread(file,'mask_rho');
% ocean_time = ncread(file,'ocean_time');
% u_vel = ncread(file,'u');  %read u velocities in MATLAB
% v_vel = ncread(file,'v');  %read v velocities in MATLAB
% w_vel = ncread(file,'w');  %read w velocities in MATLAB
% 
% unique_lat  = uniquetol(latitude);    %corresponds to columns
% unique_long = uniquetol(longitude);   %corresponds to rows
% caltime = seconds(ocean_time) + datetime('2011-01-01 00:00:00', 'TimeZone', 'UTC');
% 
% target_lat = -8.71499567089901;  %enter your latitude
% target_long = 115.198606597346;  %enter your latitude
% depth_idx = 3;  %enter your own index
% target_time = datetime('01-Jan-2020 02:00:00', 'TimeZone', 'UTC');  %enter your own time stamp in datenum format
% 
% time_idx = round(interp1(caltime, 1:length(caltime), target_time));
% if isnan(time_idx)
%     error('target time is not in the range stored in the file');
% end
% 
% u_slice = u_vel(:,:,depth_idx,time_idx);
% v_slice = v_vel(:,:,depth_idx,time_idx);
% w_slice = w_vel(:,:,depth_idx,time_idx);
% 
% target_u_value = interp2(unique_lat, unique_long, u_slice, target_lat, target_long);
% 
% if isnan(target_u_value)
%     error('location is over land or otherwise not available');
% else
%    fprintf('predicted u_val is %g\n', target_u_value);
% end
%% 3D surface plot of the domain along with 2D surface cordinates where values are present%%
% file = 'Lombok_roms_his.nc';
% %The latitude range in the file is -8.96036167119211 to -8.2089282952945.
% %The longitude range in the file is 115.175227369057 to 116.320809555245.
% latitude = ncread(file,'lat_u');
% longitude = ncread(file,'lon_u');
% depth_idx = 1;
% time_idx = 2;
% u_slice = u_vel(:,:,depth_idx,time_idx);
% v_slice = v_vel(:,:,depth_idx,time_idx);
% w_slice = w_vel(:,:,depth_idx,time_idx);
% 
% surf(longitude, latitude, u_slice, 'edgecolor','none');
% surf(longitude, latitude, v_slice, 'edgecolor','none');
% surf(longitude, latitude, w_slice, 'edgecolor','none');
% xlabel('long'); ylabel('lat')
% %mask will be 1 for sea where velocities are present and 0 where it's land
% %or it's out of range
% u_mask = ncread(file,'mask_u');
% v_mask = ncread(file,'mask_v');
% w_mask = ncread(file,'mask_w');
% idx = find(u_mask);
% jdx = find(v_mask);
% kdx = find(w_mask);
% scatter(longitude(idx),latitude(idx),'*')
% xlabel('long'); ylabel('lat')
%% Uncomment this section when you are not sure of your exact location%%
% file = 'Lombok_roms_his.nc';
% %The latitude range in the file is -8.96036167119211 to -8.2089282952945.
% %The longitude range in the file is 115.175227369057 to 116.320809555245.
% latitude = ncread(file,'lat_u');
% longitude = ncread(file,'lon_u');
% mask = ncread(file,'mask_rho');
% ocean_time = ncread(file,'ocean_time');
% u_vel = ncread(file,'u');
% v_vel = ncread(file,'v');
% w_vel = ncread(file,'w');
% unique_lat  = uniquetol(latitude);    %corresponds to columns
% unique_long = uniquetol(longitude);   %corresponds to rows
% caltime = seconds(ocean_time) + datetime('2011-01-01 00:00:00', 'TimeZone', 'UTC');
% u_mask = ncread(file,'mask_u');
% v_mask = ncread(file,'mask_v');
% w_mask = ncread(file,'mask_w');
% idx = find(u_mask);
% selected_long = longitude(idx);
% selected_lat = latitude(idx);
% target_lat = -8.22426367031282;
% target_long = 115.309657931722;
% dists = pdist2([target_long, target_lat], [selected_long, selected_lat]);
% [~, minidx] = min(dists,[],2);
% closest_lat = selected_lat(minidx);
% closest_long = selected_long(minidx);
% fprintf('closest defined point is at lat = %.15g, long = %.15g\n', closest_lat, closest_long)
% 
% caltime = seconds(ocean_time) + datetime('2011-01-01 00:00:00', 'TimeZone', 'UTC');
% depth_idx = 1;
% target_time = datetime('01-Jan-2020 01:00:00', 'TimeZone', 'UTC');
% time_idx = round(interp1(caltime, 1:length(caltime), target_time));
% if isnan(time_idx)
%     error('target time is not in the range stored in the file');
% end
% u_slice = u_vel(:,:,depth_idx,time_idx);
% v_slice = v_vel(:,:,depth_idx,time_idx);
% w_slice = w_vel(:,:,depth_idx,time_idx);
% target_u_value = interp2(unique_lat, unique_long, u_slice, closest_lat, closest_long);
% target_v_value = interp2(unique_lat, unique_long, v_slice, closest_lat, closest_long);
% target_w_value = interp2(unique_lat, unique_long, w_slice, closest_lat, closest_long);
% final_u_value = target_u_value * 10000;
% final_v_value = target_v_value * 10000;
% final_w_value = target_w_value * 10000;
% final_u_value;
% final_v_value;
% final_w_value;