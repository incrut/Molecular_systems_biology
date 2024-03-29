function deriv = dydt_novak(t, statevar)

global k1 k3
global ka Ka kb Kb kc Kc kd Kd
global ke Ke kf Kf kg Kg kh Kh
global v2_1 v2_2 v25_1 v25_2 vwee_1 vwee_2
global CDK_total cdc25_total wee1_total IE_total APC_total PPase

cyclin = statevar(1);
MPF = statevar(2);
preMPF = statevar(3);
cdc25P = statevar(4);
wee1P = statevar(5);
IEP = statevar(6);
APC = statevar(7);
DNA = statevar(8); % New variable for unreplicated DNA

CDK = CDK_total - MPF - preMPF;

% Calculate modified kb and kf based on DNA concentration
% Here, we assume both kb and kf decrease as DNA concentration increases
DNA_threshold = 1; % Adjust as needed
n = 2; % Adjust as needed
kb_modified = kb / (1 + (DNA / DNA_threshold)^n);
kf_modified = kf / (1 + (DNA / DNA_threshold)^n);

k25 = v25_1 * (cdc25_total - cdc25P) + v25_2 * cdc25P;
kwee = vwee_1 * wee1P + vwee_2 * (wee1_total - wee1P);
k2 = v2_1 * (APC_total - APC) + v2_2 * APC;

dcyclin = k1 - k2 * cyclin - k3 * cyclin * CDK;
dMPF = k3 * cyclin * CDK - k2 * MPF - kwee * MPF + k25 * preMPF;
dpreMPF = -k2 * preMPF + kwee * MPF - k25 * preMPF;
dcdc25P = ka * MPF * (cdc25_total - cdc25P) / (Ka + cdc25_total - cdc25P) - kb_modified * PPase * cdc25P / (Kb + cdc25P);
dwee1P = ke * MPF * (wee1_total - wee1P) / (Ke + wee1_total - wee1P) - kf_modified * PPase * wee1P / (Kf + wee1P);
dIEP = kg * MPF * (IE_total - IEP) / (Kg + IE_total - IEP) - kh * PPase * IEP / (Kh + IEP);
dAPC = kc * IEP * (APC_total - APC) / (Kc + APC_total - APC) - kd * PPase * APC / (Kd + APC);
dDNA = 0; % You can modify this equation for DNA if needed

deriv = [dcyclin; dMPF; dpreMPF; dcdc25P; dwee1P; dIEP; dAPC; dDNA];

return
