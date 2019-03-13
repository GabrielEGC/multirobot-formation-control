# multirobot-formation-control
Problem is defined as follows:
Suppose you have a set of differential wheeled robots. You want them to be located in a predefined formation, but you can send them only two variables to ALL robots: Angular and linear velocity.
The robots all have a different distance from wheel to wheel. This is crucial to make the system of n robots controllable under only 2 variables. A little proof can be found in MRControl.pdf.
Problem is solved with a change of variable, a constant angular velocity for all robots, and a LQR control applied to the new system (which is linear).

Let's note that in strict sense this is not optimal LQR because it can be "even more optimal" if we choose better the angular velocity. But this will be non-linear optimal control, a piecewise variable angular velocity is commented in code.
Simulation is showed in MATLAB script with graphics.


![Alt Text](MRC.gif)
