[data,name]=xlsread('moran_data.xlsx');
data=data(:,2:end);
name=name(2:end,1); 
colour_totall=128;
% Import shp file£¡
shp_data=shaperead( 'chinamap.shp' ,  'UseGeoCoords' , true); 
year=2011;
i=year-2007+1;
data=data(:,i);  
province_arr=name(:,1);  % province name
%% Parameters
% FaceColor
mycolormap=summer(colour_totall);  %  Define color
% Collors in different regions
geo_name={shp_data.NAME}';
max_height=max(data(:));
min_height=min(data(:));
n=length(data);  % provice num
symbol_spec=cell(1,n);  % just to speed up

hh=[];
for i =1:n
     height_tmp=data(i);
     % Change the scale function by yourself
     x=colour_totall*(1- (height_tmp-min_height)/(max_height-min_height));
     % x=colour_totall*(1-height_tmp/100);
     % x=colour_totall*(1-height_tmp/max_height);
     c_index= floor(x);
     c_index(c_index<1)=1;
     tmp_pn=province_arr{i};
     geoidx=find(strncmp(tmp_pn,geo_name,length (tmp_pn))==1);
     if  numel(geoidx)>0
         province_name=geo_name(geoidx(1));
         symbol_spec{i}={'NAME',char(province_name),'FaceColor',mycolormap(c_index,:)};
         symbol_spec{i};
     end
end
%% Plot
figure(1)
ax=worldmap('china');  % Use axis in "World-Map"
setm(ax,'grid','off')  
setm(ax,'frame','off')  
setm(ax,'parallellabel','off')  
setm(ax,'meridianlabel','off')  
 
symbols=makesymbolspec( 'Polygon',{ 'default','FaceColor',[0.9 0.9 0.8],...
     'LineStyle','--','LineWidth',0.2, ...
     'EdgeColor',[0.8 0.9 0.9]},...
     symbol_spec{:}...
     );

geoshow(shp_data, 'SymbolSpec',symbols); 

% Bar in right
colormap(summer(colour_totall))
hcb=colorbar('EastOutside' );
step=(max_height-min_height)/11;
set(hcb,'YTick',(0:0.1:1))
set(hcb,'YTickLabel',num2cell(max_height:-step:min_height))
title('SG3/GDP in China')



