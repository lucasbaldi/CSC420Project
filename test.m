
function test;

globals;
list = getData('', 'list');
list = list.ids;

for i=1:size(list,1)
    imname = list{i}
    [roadbox, notroadbox] = getRoadBoxes(imname);
    %roadbox = [topleftrow, topleftcol, bottomrightrow, bottomrightcol]
    leftim = getData(imname, 'left');
    if(~roadbox)
        'missing roadbox'
    end
    if(~notroadbox)
        'missing notroadbox'
    end
end