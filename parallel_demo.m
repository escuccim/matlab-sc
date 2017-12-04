do_parallel = false;

if do_parallel
    %if matlabpool('size') == 0 % checking to see if my pool is already open
    %    matlabpool open 2
    %end

    % Independent
    x = rand(1000,1); y = zeros(1000,1);
    parfor i = 1:1000
        y(i) = sin(x(i));
    end

    % Reduction
    count = 0;
    n = 1000;
    parfor i = 1:n
        count = count+i;
    end
    isequal(count,n*(n+1)/2)

    % Dependent (error) - Fibonacci
    fib = zeros(201,1);
    fib(1:2) = [0,1];
    parfor i = 3:size(fib,1)
        fib(i) = fib(i-1)+fib(i-2);
    end
else
    % Independent
    x = rand(1000,1); y = zeros(1000,1);
    for i = 1:1000
        y(i) = sin(x(i));
    end

    % Reduction
    count = 0;
    n = 1000;
    for i = 1:n
        count = count+i;
    end
    isequal(count,n*(n+1)/2)

    % Dependent  - Fibonacci
    fib = zeros(201,1);
    fib(1:2) = [0,1];
    for i = 3:size(fib,1)
        fib(i) = fib(i-1)+fib(i-2);
    end
end