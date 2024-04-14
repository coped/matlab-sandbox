# What's the value in using function handles in your code?

## 1. Working with higher order functions

### Overview
What is a higher order function? It's a function that can take one or more functions as an argument, and/or return a function as a result. For example:

```matlab
% A function that takes another function as an argument.

function y = apply(fn, x)
  y = fn(x);
end

% This takes a function `fn` and calls it with `x` as an argument. The result of this function application is then returned.

% Note, this is essentially equivalent to the built-in `feval`.
```

### Example
You may find yourself needing to express logic using higher order functions. Let's imagine you have a cool function called `myCoolFn`. It takes a number and *doubles* it. Woah!

```matlab
% myCoolFn.m

function y = myCoolFn(x)
  y = x + x;
end
```

Now lets say we want to test our function using `feval`. So we try

```matlab
% main.m

feval(myCoolFn, 2);
```

You'll find this results in an error. Why? Because MATLAB sucks. This is something that's supported in most functional programming languages (even JavaScript). But not in MATLAB. 

MATLAB functions can't receive functions as arguments, only function *handles*. So if we want `feval` to be able to use `myCoolFn`, we need to create a handle for it, and pass THAT to `feval`.

```matlab
% main.m

myCoolFnHandle = @myCoolFn;

feval(myCoolFnHandle, 2);
```
Now you'll see this works just fine, and you get a whopping `4` as the result!

### What's the difference?
So, what's the difference between a "function" and a "function handle"? 

> A function is the literal thing that does the work. 
> 
> A function handle merely points to the function. The underlying function still does the work.

You can think of the difference like this:

Think of your functions as giant machines in a factory. To pass values/arguments to your machines, you enter them through a little coin slot on the machine. 

Values and expressions like `2`, `"hello"`, and `3 + 3` can fit just fine. But other big machines (functions) can't fit through the coin slot at all. As a workaround, we write *directions* to the other machines on a piece of paper, and put them in the slot, which fits just fine. Now the machine knows where to go in order to do the work.

## 2. Function generalization

If a specific function is commonly used
throughout your logic, referencing it using a handler can
make it easier to maintain your code if you need to swap it 
for another function sometime in the future.

For example, take a look at this logic:
```matlab
% main.m

a = calculate_value(0);
b = calculate_value(1);
c = calculate_value(2);
d = calculate_value(3);
f = calculate_value(4);
```

In the logic above, we're using the `calculate_value` function
5 times. But what if we create a more efficient function to calculate
this value, and we call it `calcuate_value_but_better`?

If we want to use the new function instead, we have to change the
name in 5 different places. This is a process that gets more cumbersome the more 
the function is used.

```matlab
% main.m

% Every line needs to be changed
a = calculate_value_but_better(0);
b = calculate_value_but_better(1);
c = calculate_value_but_better(2);
d = calculate_value_but_better(3);
f = calculate_value_but_better(4);
```

Instead, what we can do is create a handle for this function, and use 
that handler like so:

```matlab
% main.m

get_value = @calculate_value;

a = get_value(0);
b = get_value(1);
c = get_value(2);
d = get_value(3);
f = get_value(4);
```

Now, if we want to swap out logic to use the better function,
we only have to change it in one place. This is easier to maintain.

```matlab
% main.m

% This is the only line that needs to be changed
get_value = @calcuate_value_but_better;

a = get_value(0);
b = get_value(1);
c = get_value(2);
d = get_value(3);
f = get_value(4);
```
