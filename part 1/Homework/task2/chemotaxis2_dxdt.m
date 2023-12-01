function out=chemotaxis2_dxdt(t,X)
    global a Vr R Vb B K
    out = Vr*R-Vb*B*a*X/(K+a*X);
end