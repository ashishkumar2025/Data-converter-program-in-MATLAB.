while (get(t, 'BytesAvailable') > -1) 
t.BytesAvailable 

DataReceived =fscanf((t));   % Reaceived real-time flight data

% DATA CONVERTING PROGRAM
% Attitude Spliting and converting the real-time flight data
 i=1;
    while(1)
data1 = fscanf(t);
        data_temp1 = regexp(data1, ' ', 'split');   
        l = length(data_temp1);
        data_temp1 = data_temp1(l);
        dataAtti = regexp(data_temp1, ',', 'split');   
        dataAtti = dataAtti{1};
        
        if strcmp(dataAtti(1), '$GPRPY') % GPRPY contains real-time attitude data    
            if strcmp(dataAtti(2), '')     
                continue;
            else
                Roll_temp(i) = dataAtti(2);      
                Pitch_temp(i)  = dataAtti(3);
                Heading_temp(i)  = dataAtti(4);
               
                
Roll(i) = str2num(Roll_temp{i});
Pitch(i)  = str2num(Pitch_temp{i});
Heading(i)  = str2num(Heading_temp{i});

% Attitude of quadcopter UAV
PITCH = Pitch(i);
ROLL =  Roll(i);
HEADING = Heading(i);

% Position Spliting and converting the real-time flight data
data2 = fscanf(t);
        data_temp = regexp(data2, ' ', 'split');   
        l = length(data_temp);
        data_temp = data_temp(l);
        dataPosi = regexp(data_temp, ',', 'split');   
        dataPosi = dataPosi{1};
        
        if strcmp(dataPosi(1), '$GPGGA')   % GPGGA contains real-time position data  
            if strcmp(dataPosi(2), '')     
                continue;
            else
                Time_temp(i) = dataPosi(2);      
                Lat_temp(i)  = dataPosi(3);
                Lon_temp(i)  = dataPosi(5);
                Alt_temp(i)  = dataPosi(10);
                
Time(i) = str2num(Time_temp{i});
Lat(i)  = str2num(Lat_temp{i});
Lon(i)  = str2num(Lon_temp{i});
Alt(i)  = str2num(Alt_temp{i});
                            
Time1         = (Time).';
LatitudeData  = (Lat(i)).';       % Degree minute
LongitudeData = (Lon(i)).';       % Degree minute
AltutudeData  = (Alt(i)).';       % Meter

% Position of quadcopter UAV                
% Latitude Degree minute to Decimal Degree
LATdata=num2str(LatitudeData , '%.5f');
LAT1 = str2num(LATdata(1:2));
LAT2 = str2num(LATdata(3:10));
LATdm = [LAT1 LAT2];
LATITUDE = dm2degrees(LATdm);     % Decimal Degree

% Longitude Degree minute to Decimal Degree
LONdata=num2str(LongitudeData, '%.5f');
LON1 = str2num(LONdata(1:3));
LON2 = str2num(LONdata(4:11));
LONdm = [LON1 LON2];
LONGITUDE = dm2degrees(LONdm);    % Decimal Degree  

% Altitude 
ALTITUDE = AltutudeData; 

            end
        end
    end
end 

 end
 end