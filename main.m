% What's the potential value in using function hanlders in your code?
%
% One reason may be that if a specific function is commonly used
% throughout your logic, referencing it using a handler can
% make it easier to maintain your code if you need to swap it 
% for another function. 
% 
% For example, take a look at this logic:

a = calculate_value(0);
b = calculate_value(1);
c = calculate_value(2);
d = calculate_value(3);
f = calculate_value(4);

% In the logic above, we're using the "calculate_value" function
% 5 times. But what if we create a more efficient way to calculate
% this value, and we call it "calcuate_value_but_better"?
%
% If we want to use the new function instead, we have to change the
% name in 5 different places. This is a process that gets more cumbersome the more 
% the function is used.

a = calculate_value_but_better(0);
b = calculate_value_but_better(1);
c = calculate_value_but_better(2);
d = calculate_value_but_better(3);
f = calculate_value_but_better(4);

% Instead, what we can do is create a handler for this function, and use 
% that handler like so:

value_calculator = @calculate_value;

a = value_calculator(0);
b = value_calculator(1);
c = value_calculator(2);
d = value_calculator(3);
f = value_calculator(4);

% Now, if we want to swap out logic to use the better function,
% we only have to change it in one place

value_calculator = @calcuate_value_but_better;

a = value_calculator(0);
b = value_calculator(1);
c = value_calculator(2);
d = value_calculator(3);
f = value_calculator(4);
