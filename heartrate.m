%{
clc
clear all 
close all 
a=arduino;
tw=readVoltage(a,'A0');
ii = 0;
beats= zeros(1e4,1);
tw = zeros(1e4,1);

tic
while toc < 10
    ii = ii + 1;
    v = readVoltage(a,'A0');
    beats(ii) = v;
    tw(ii) = toc;
end
beats = beats(1:ii);
tw = tw(1:ii);
figure
plot(tw,beats)
xlabel('Elapsed time (sec)')
ylabel('Voltage From Sensor')
title('Ten Seconds of heart rate Data')
%set(ax,'xlim',[t(1) t(ii)])
%{
figure
h = animatedline;
gca.YGrid = 'on';
gca.YLim = [65 85];

tic
startTime = datetime('now');
while toc<50
    v = readVoltage(a,'A0');
    t =  datetime('now') - startTime;
    addpoints(h,datenum(t),v)
    gca.XLim = datenum([t-seconds(15) t]);
    datetick('x','keeplimits')
    drawnow
   
end
[timeLogs,Heartrate] = getpoints(h);
timeSecs = (timeLogs-timeLogs(1))*24*3600;
figure
plot(timeSecs,Heartrate)
xlabel('Elapsed time (sec)')
ylabel('heartrate')
%{
algorithm for Beats per Minute
create a counter suppose C=0
now start a tictoc function for 30 seconds
for all the time the value of voltage goes above 3.5v and comes back 
increment the counter 
multiply this counter by 2 to get the BPM
%}
b=1/32*[1 0 0 0 0 0 -2 0 0 0 0 0 1];
a=[1 -2 1];
sigL=filter(b,a,beats)
%}
%}
