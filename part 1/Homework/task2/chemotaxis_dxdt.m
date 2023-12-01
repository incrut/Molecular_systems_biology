function out=chemotaxis_dxdt(t,X)
    global Vr R Vb B K
    out = Vr*R-(Vb*B*X)/(K+X);
end