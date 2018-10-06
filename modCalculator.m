%Number of solutions
NumS=0;
p = 3;
e = 6;
z = zeros(100,4);
%This program calculates the number of solutions and list the solutions
%into z
for a = 1:(p.^e)*(p-1)
    for h = 1:(p.^e)*(p-1)
        d=gcd(sym([a,h,p-1]));
        if (rem(a,d)==0 && rem(h,d)==0) && (rem(a,p)~=0 && rem(h,p)~=0)
            if rem((a.^(a/d)),(p.^e))==rem(h.^(h/d),p.^e)
                NumS=NumS+1;
                z(NumS,1)=d;
                z(NumS,2)=a;
                z(NumS,3)=h;
            end
        end 
    end
end
%This program removes the solutions which a=h and a or h congruent to -1 or 1
flag = 0;
sameCount = 0;
oneCount = 0;
gcdCount = 0;
%1...a=h,2...congruent to (1) or (-1 and it is negative)
for x =1:NumS
    if z(x,2)==z(x,3)
        z(x,4)=1;
        sameCount=sameCount+1;
    elseif (mod(z(x,2),(p.^e))==p.^e-1 && mod(z(x,2)/z(x,1),2)==0)|| (mod(z(x,2),(p.^e))==1)
        if (mod(z(x,3),(p.^e))==p.^e-1 && mod(z(x,3)/z(x,1),2)==0)|| (mod(z(x,3),(p.^e))==1)
            z(x,4)=2;
            oneCount = oneCount+1;
        end
    end
    if z(x,1)==1
        gcdCount = gcdCount+1;
    end
end
%List of whole solution
solutions = zeros(NumS,3);

%List of solutions which a=h
sameArray = zeros(sameCount,3);
sTracker = 1;

%List of solutions which a or h is congruent to 1 or -1
onesArray = zeros(oneCount,3);
oTracker = 1;

%List of solutions which d=1
gcd1Array = zeros(gcdCount,3);
oneTracker = 1;

%List of solutions which d=2
gcd2Array = zeros(NumS-gcdCount,3);
twoTracker = 1;

for x= 1:NumS
    solutions(x,1:3) = z(x,1:3);
    if z(x,4)==1
        sameArray(sTracker,1:3)= z(x,1:3);
        sTracker = sTracker+1;
    elseif z(x,4)==2
        onesArray(oTracker,1:3)= z(x,1:3);
        oTracker = oTracker+1;
    end
    
    if z(x,1)==1
        gcd1Array(oneTracker,1:3)= z(x,1:3);
        oneTracker = oneTracker+1;
    else
        gcd2Array(twoTracker,1:3)= z(x,1:3);
        twoTracker = twoTracker+1;
    end

end

fprintf('Number of solutions: %d \n',NumS)
disp(solutions)

fprintf('Number of solutions that is a=h: %d \n',sameCount)
disp(sameArray)

fprintf('Number of solutions that is a and h congruent to 1 or -1: %d \n',oneCount)
disp(onesArray)

fprintf('Number of solutions that is d=1: %d \n',gcdCount)
disp(gcd1Array)

fprintf('Number of solutions that is d=2: %d \n',NumS-gcdCount)
disp(gcd2Array)


