clear; clc;

% Selección de método
fprintf('Seleccione el método:\n1. Bisección\n2. Newton-Raphson\n3. Secante\n');
opcion = input('Ingrese el número de opción: ');

% Parámetros comunes
f = input('Ingrese la función f(x) (ej. @(x) x.*cos(x)-1): ');
tol = input('Ingrese la tolerancia (ej. 1e-6): ');

switch opcion
    case 1 % BISECCIÓN
        a = input('Punto a: ');
        b = input('Punto b: ');
        
        fprintf('\nIter |      a      |      b      |      c      |    f(c)    |    Error   \n');
        fprintf('-------------------------------------------------------------------------\n');
        it = 0; error = (b-a)/2;
        while error > tol
            it = it + 1;
            c = (a + b)/2;
            fc = f(c);
            fprintf('%4d | %10.6f | %10.6f | %10.6f | %10.6f | %10.6e\n', it, a, b, c, fc, error);
            if abs(fc) < tol, break; end
            if f(a)*fc < 0, b = c; else, a = c; end
            error = (b-a)/2;
        end
        
    case 2 % NEWTON-RAPHSON
        x0 = input('Punto inicial x0: ');
        df = input('Ingrese la derivada df(x) (ej. @(x) cos(x)-x.*sin(x)): ');
        
        fprintf('\nIter |      xi     |     f(xi)   |    Error   \n');
        fprintf('----------------------------------------------\n');
        it = 0; error = 1;
        while error > tol
            it = it + 1;
            x1 = x0 - f(x0)/df(x0);
            error = abs(x1 - x0);
            fprintf('%4d | %10.6f | %10.6f | %10.6e\n', it, x1, f(x1), error);
            x0 = x1;
        end
        c = x1; % Para el mensaje final

    case 3 % SECANTE
        x0 = input('Punto x0: ');
        x1 = input('Punto x1: ');
        
        fprintf('\nIter |      xi     |     f(xi)   |    Error   \n');
        fprintf('----------------------------------------------\n');
        it = 0; error = 1;
        while error > tol
            it = it + 1;
            x2 = x1 - (f(x1)*(x1-x0))/(f(x1)-f(x0));
            error = abs(x2 - x1);
            fprintf('%4d | %10.6f | %10.6f | %10.6e\n', it, x2, f(x2), error);
            x0 = x1; x1 = x2;
        end
        c = x2; % Para el mensaje final
end

fprintf('\n==================================\n');
fprintf('RESULTADO FINAL:\n');
fprintf('Raíz obtenida: %.8f\n', c);
fprintf('Número de iteraciones: %d\n', it);
fprintf('Error final: %.2e\n', error);
fprintf('==================================\n');