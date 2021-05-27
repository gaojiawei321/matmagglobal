function [ B ] = sph_b( g, h, a_over_r, sct, scp )
%SPH_B calculate magnetic field using SH coefficient in spherical coordinates
%Input: g h : SH coefficient
%Input: a_over_r : a/r r is the distance,a is reference radii
%Input: sct scp : colatitude and longitude
%Output: B= [Br, Bt, Bp]
a=size(g);
nmax=a(2)-1; % SH degree
cntarr=0:1:nmax;
%R(r) = [a/r]^(n+1)
%dR(r) = (n+1)*[a/r]^(n+1)
R = (a_over_r).^(cntarr+1);
dR = R.*(cntarr+1);
%Phi(phi) and dPhi(phi)
%Phi(phi) = gnm * cos(m*phi) + hnm * sin(m*phi)
%dPhi(phi) = m * [-gnm * sin(m*phi) + hnm * cos(m*phi)]
cos_m_phi = cos( cntarr * scp );
sin_m_phi = sin( cntarr * scp );
Phi  = g*0;  %zero matrix
dPhi = Phi;
for n=1:nmax
     Phi(:,n+1)  = cos_m_phi .* g(:,n+1)' + sin_m_phi .* h(:,n+1)';
     dPhi(:,n+1) = ( cos_m_phi.*h(:,n+1)'-sin_m_phi.* g(:,n+1)') .* cntarr;
end
%Theta and dTheta at each m,n 
%Theta(theta) = P(n,m,x)  
%Schmidt semi-normalized associated Legendre function 
%dTheta(theta) = m * cos(theta) / sin(theta) * P(n,m,x) -
%                 C(n,m) / C(n,m+1) * P(n,m+1,x)
%                  Where C(n,m) = 1 if m=0
%                        C(n,m) =( 2 * (n-m)! / (n+m)! ) ^ (1/2)
cos_theta = cos(sct);
sin_theta = sin(sct);

Theta=legendre_schmidt_all(nmax,cos_theta);
dTheta=g*0;

dTheta(:,2)=cntarr.*cos_theta./sin_theta.*Theta(:,2)';
dTheta(1,2)=dTheta(1,2)-Theta(2,2);

for n=2:nmax
    dTheta(:,n+1)=cntarr*cos_theta/sin_theta.*Theta(:,n+1)';
    dTheta(1,n+1)=dTheta(1,n+1)-sqrt((n*(n+1))*0.5)*Theta(2,n+1);
    hou=[Theta(3:n+1,n+1)',(0)];
    zhong=sqrt((n-cntarr(2:n+1)).*(n+cntarr(2:n+1)+1));
    dTheta(2:n+1,n+1)=dTheta(2:n+1,n+1)'-zhong.*hou;
end

for i=1:nmax+1
    Phi(i+1:nmax,i)=0;
    dPhi(i+1:nmax,i)=0;
end   
        
%Add all n and m
%Br = (a/r)* Sum(n=1,nmax) { (n+1) * R(r) *  Sum(m=0,n) { Theta(theta) * Phi(phi) } }

vv=sum(Theta.*Phi);
br=sum(vv.*dR)*a_over_r;

%Btheta=a*sin(theta)/r Sum(n=1,nmax) { R(r) *Sum(m=0,n) { dTheta(theta) * Phi(phi) } }
tt=sum(dTheta.*Phi);
bt=-1*sum(tt.*R)*a_over_r;

%Bphi= -a/r/sin(theta) Sum(n=1,nmax) { R(r) *Sum(m=0,n) { Theta(theta) * DPhi(phi) } }
pp=sum(Theta.*dPhi);
bp=-1*sum(pp.*R)*a_over_r/sin_theta;

B=[br,bt,bp];

end



