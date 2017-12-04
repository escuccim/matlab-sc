classdef piecewise_polynomial
    %PIECEWISE_POLYNOMIAL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        xi = [];
        npoly = 0;
        polys = [];
    end
    
    methods
        function  self = piecewise_polynomial(arg1, arg2)
            
            % Return empty if no arguments
            if nargin == 0
                return;
            end
            
            if nargin == 1
                % Copy constructor if arg1 polynomial
                if isa(arg1,'piecewise_polynomial')
                    self.xi = arg1.xi;
                    self.npoly  = arg1.npoly;
                    self.polys  = arg1.polys;
                    return;
                elseif isa(arg1, 'double')
                    self.xi = arg1;
                end
            end
            
            % Otherwise, two args - xi, and polynomial array 
            self.xi = arg1;
            self.polys = arg2;
            self.npoly = length(self.xi) - 1;
        end
        
        function  [iseq] = eq(poly1,poly2)
            
            if poly1.order < poly2.order
                coeffs1=[poly1.coeffs,zeros(1,length(poly2.coeffs)-length(poly1.coeffs))];
                coeffs2=poly2.coeffs;
            else
                coeffs1=poly1.coeffs;
                coeffs2=[poly2.coeffs,zeros(1,length(poly1.coeffs)-length(poly2.coeffs))];
            end
            iseq = all(coeffs1 == coeffs2);
            
        end
        
        function  [poly_out] = uplus(poly_in)
            poly_out=poly_in;
        end
        
        function  [poly] = uminus(poly1)
            new_poly = zeros(1,poly1.npoly);
            for i = 1:poly1.npoly
                new_poly(i) = -poly1.polys(i);
            end
            poly = piecewise_polynomial(poly1.xi, new_poly);
        end
        
        function  [poly] = mtimes(a,b)  
            
            if strcmpi(class(a),'polynomial') && strcmpi(class(b),'polynomial')
                poly = polynomial(conv(a.coeffs,b.coeffs));
            elseif strcmpi(class(a),'polynomial') && strcmpi(class(b),'double')
                poly = polynomial(b*a.coeffs);
            elseif strcmpi(class(b),'polynomial') && strcmpi(class(a),'double')
                poly = polynomial(a*b.coeffs);
            end
            
        end
        
        function  [poly] = mpower(poly1,b)
            
            if b == 0
                poly = polynomial(1);
                return;
            elseif b == 1
                poly = poly1;
                return;
            end
            
            if ~(isa(poly1,'polynomial') && isa(b,'double') && b >= 0 && round(b) == b)
                error('mpower requires polynomial and integer');
            end
            poly = polynomial(poly1);
            for i = 1:b-1
                poly = poly*poly1;
            end
            
        end
        
        % Complete the functions below
        function  [poly3] = plus(poly1,poly2)
            if poly1.order == poly2.order
                newCoeffs = poly1.coeffs + poly2.coeffs;
            elseif poly1.order > poly2.order
                newCoeffs = poly1.coeffs;
                newCoeffs(1:length(poly2.coeffs)) = newCoeffs(1:length(poly2.coeffs))...
                                                  + poly2.coeffs;
            else
                newCoeffs = poly2.coeffs;
                newCoeffs(1:length(poly1.coeffs)) = newCoeffs(1:length(poly1.coeffs))...
                                                  + poly1.coeffs;
            end
            poly3 = polynomial(newCoeffs);
        end
        
        function  [poly3] = minus(poly1,poly2)
            max_order = max(poly1.order, poly2.order);
            poly3 = polynomial_solution([poly1.coeffs,zeros(1,max_order-poly1.order)] - [poly2.coeffs,zeros(1,max_order-poly2.order)]);
        end
    end
    
end

