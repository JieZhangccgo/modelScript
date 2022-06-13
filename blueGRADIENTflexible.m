function y = blueGRADIENTflexible(i,N) % Initial Conditions
lightBLUE = [0.356862745098039,0.811764705882353,0.956862745098039];
darkBLUE = [0.0196078431372549,0.0745098039215686,0.670588235294118];
y =darkBLUE - (darkBLUE-lightBLUE)*((i-1)/(N-1));
end
