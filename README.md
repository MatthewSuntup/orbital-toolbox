# <img src="img/orbital_toolbox_logo.png?raw=true" height="70">

<p align = center>
  <img src="https://img.shields.io/badge/-MATLAB-DD3A0A?logo=mathworks&logoColor=white"/>
  <img src="https://img.shields.io/badge/-Markdown-000000?logo=markdown&logoColor=white"/>
  <img src="https://img.shields.io/badge/-Atom-239120?logo=atom&logoColor=white"/>
  <img src="https://img.shields.io/badge/-Git-D51007?logo=git&logoColor=white"/>
  <img src="https://img.shields.io/badge/-GitHub-181717?logo=github&logoColor=white"/>
</p>

## About
A collection of MATLAB functions and classes to provide basic orbital analysis capabilities. This toolbox is intended for users seeking quick and easy calculations which may act as a starting point for mission planning, however, various assumptions render this toolbox insufficient for comprehensive mission design and analysis.

This README outlines some of the key features and methodologies implemented in this toolbox. Specific documentation and assumptions are outlined in the relevant function documentation found in the source code or by using the MATLAB `help` command. For examples of various use cases see the `example_usage` directory.

This toolbox is based on code originally developed for a University of Sydney assignment in the [Space Engineering 1 course (2017 Semester 2)](https://www.sydney.edu.au/courses/units-of-study/2020/aero/aero2705.html). The code has since been refactored for use in more general cases, while some of the original tasks are still shown as example usage.

### Contents
- [About](#About)
- [Features](#Features)
  - [TLE Analysis and Orbital Parameters](#TLE-Analysis-and-Orbital-Parameters)
  - [Ground Station Visibility Analysis](#Ground-Station-Visibility-Analysis)
  - [Hohmann Transfers](#Hohmann-Transfers)
  - [Launch Requirements](#Launch-Requirements)
- [Lessons](#Lessons)
- [Credit](#Credit)
- [Disclaimer](#Disclaimer)

## Features
### TLE Analysis and Orbital Parameters
#### TLE Parsing
The `tle(line_1, line_2)` function takes two strings corresponding to the first and second line of a [two-line element (TLE)](https://spaceflight.nasa.gov/realdata/sightings/SSapplications/Post/JavaSSOP/SSOP_Help/tle_def.html) set and returns a map of key-value pairs for each element. The toolbox provides a `Satellite` class with the method `Satellite.updateFromTLE(tle_file)` which utilises this function and then stores the map data into properties of the `Satellite` object.

#### Orbital Parameters from TLE
Additional orbital parameters may be calculated from the TLE data using the `Satellite.updateOrbit()` method of a `Satellite` object. This method will analytically determine the following values, using the formulae outlined here:

##### Orbital period
<p align = center>
<img src="https://render.githubusercontent.com/render/math?math=T=1/n">
</p>

where <img src="https://render.githubusercontent.com/render/math?math=n"> is the mean motion.

##### Semi-major axis
<p align = center>
<img src="https://render.githubusercontent.com/render/math?math=a=\sqrt[3]{(\frac{T}{2\pi})^2GM}">
</p>

where <img src="https://render.githubusercontent.com/render/math?math=T"> is the period, <img src="https://render.githubusercontent.com/render/math?math=G"> is the gravitational constant, and <img src="https://render.githubusercontent.com/render/math?math=M"> is the mass of the Earth.

##### Radius of perigee
<p align = center>
<img src="https://render.githubusercontent.com/render/math?math=R_p=a(1-e)">
</p>

where <img src="https://render.githubusercontent.com/render/math?math=a"> is the semi-major axis, and <img src="https://render.githubusercontent.com/render/math?math=e"> is the eccentricity.

##### Radius of apogee

<p align = center>
<img src="https://render.githubusercontent.com/render/math?math=R_a=2a-R_p">
</p>

where <img src="https://render.githubusercontent.com/render/math?math=a"> is the semi-major axis, and <img src="https://render.githubusercontent.com/render/math?math=R_p"> is the radius of perigee.

##### Semi-minor axis
<p align = center>
<img src="https://render.githubusercontent.com/render/math?math=b=\sqrt{R_aR_p}">
</p>
<p>

where <img src="https://render.githubusercontent.com/render/math?math=R_a"> is the radius of apogee and <img src="https://render.githubusercontent.com/render/math?math=R_p"> is the radius of perigee.

These values are stored in an `Orbit` object which is a property of the `Satellite`. Once these parameters have been a calculated, an [Orbital Simulation](#Orbital-Simulation) is also run.

#### Orbital Simulation
The `Orbit.sim()` method is provided by the `Orbit` class and generates an array of mean anomaly values, true anomaly values, radial distances, and cartesian coordinates, corresponding to a complete orbit. The data may be used for further analysis, polar plotting, or cartesian plotting. The method performs the following calculation:
- Generate an array of linearly spaced mean anomaly values
- Convert these values to eccentric anomaly vales using the Newton-Raphson method to solve Kepler's equation:

<p align = center>
<img src="https://render.githubusercontent.com/render/math?math=M=E-e\sin(E)">
</p>

- Convert eccentric anomalies to true anomalies:
<p align = center>
<img src="https://render.githubusercontent.com/render/math?math=\nu=2\tan^{-1}\big(\sqrt{\frac{1%2Be}{1-e}}\tan(\frac{E}{2})\big)">
</p>

-  Calculate the radial distance:
<p align = center>
<img src="https://render.githubusercontent.com/render/math?math=r=a\frac{1-e^2}{1%2Be\cos(\nu)}">
</p>

This resulting data is compared against the known semi-major and semi-minor axes to obtain the simulation error.

#### Orbit Area
The `Orbit.pathArea()` method simply calculates the area of the orbit using:

<p align = center>
<img src="https://render.githubusercontent.com/render/math?math=A=\pi a b">
</p>

where <img src="https://render.githubusercontent.com/render/math?math=a"> is the semi-major axis and <img src="https://render.githubusercontent.com/render/math?math=b"> is the semi-minor axis.

#### Orbit Length
The `Orbit.pathLength()` method approximates the line integral of an ellipse to find the length of the orbit. [The path length is given by](http://web.archive.org/web/20180219135426/http://pages.pacificcoast.net/~cazelais/250a/ellipse-length.pdf):

<p align = center>
<img src="https://render.githubusercontent.com/render/math?math=p=4a\int_{0}^{\frac{\pi}{2}}\sqrt{1-e^2\cos^2(\theta)}d\theta  ">
</p>

where <img src="https://render.githubusercontent.com/render/math?math=e"> is the eccentricity of the orbit.

In order to evaluate this computationally, the formula implemented in this toolbox is:

<p align = center>
<img src="https://render.githubusercontent.com/render/math?math=p=2\pi a\big( 1-\sum_{n=1}^{\infty}\big[(\frac{1\cdot3\cdot5...(2n-1)}{2\cdot4\cdot6...2n})^2 \frac{e^{2n}}{2n-1}\big]\big)">
</p>

The program will continue to loop until the increment added by the successive term is less than 100m, as the error at this point will be less than that associated with the semi-major axis.

### Ground Station Visibility Analysis
#### Visibility using only orbital radius and viewing angle
The `maxViewTimeStat(Ro, visible_ang)` function will calculate the maximum length of time a satellite in a circular orbit will be visible from the ground when passing directly overhead through the zenith of the observer, given a minimum viewing above the astronomical horizon. By assuming a circular orbit, [spherical Earth](https://en.wikipedia.org/wiki/Figure_of_the_Earth), and stationary (non-rotating) Earth, it is possible to calculate this analytically using only the orbital radius and viewing angle (in the following diagrams the viewing angle is noted as being 5°, however, the illustration is exaggerated).

<p align = center>
<img src="img/max_visibility_diagram.png?raw=true" height="380">
</p>

To get the viewing time for non-zenith passes, use the `viewTimeStat(Ro, visible_ang)` function, which will generate an array of maximum elevation angles and corresponding viewing times (where an elevation of 90° corresponds to a zenith pass).

<p align = center>
<img src="img/visibility_diagram.png?raw=true" height="400">
</p>

An example of the results obtained for an observer able to see 5° above the ascending and descending horizon, viewing a satellite at an altitude of 590km is shown below:

<p align = center>
<img src="img/visibility_graph_static.png?raw=true" height="400">
</p>

Note that running the `maxViewTimeStat(Ro, visible_ang)` function with the same input arguments will return the singular value of 618.5 seconds, seen in this graph as the viewing time for an elevation of 90°.

#### Visibility time with rotating Earth
The previous functions assumed a stationary Earth, this makes the calculation significantly less computationally expensive, and requires minimal information about the orbit and observer. The `viewTimeRot(Ro, i, visible_ang, loc)` function using a computational method to achieve an equivalent result, but this time taking into account the rotation of the Earth.

The concept driving this approach is that the longitude and latitude of the ground station may be converted to Earth-Centred Earth-Fixed (ECEF) coordinates, while the Satellite's movement in the perifocal plane is also converted to ECEF co-ordinates. The condition for the satellite to be visible is simply that it must be closer to the ground station than the distance associated with the edge of its cone of view. The simulation iterates through a set of varying RAAN values, and checks for this condition at each point along the orbit. The maximum elevation is then calculated from the closest point of the approach.

An example of the results obtained for an observer standing at Sydney Observatory, able to see 5° above the ascending and descending horizon, viewing a satellite at an altitude of 590km and inclination of 97°, is shown below:

<p align = center>
<img src="img/visibility_graph_rotating.png?raw=true" height="400">
</p>

Note that when the rotation of the Earth is considered, the time of visibility is shorter (612.5 seconds at 90° elevation in comparison to the previous 618.5 seconds). Additionally, there is an asymmetry between elevations on the east side of the zenith and the west side (seen in the offset blue line).

### Hohmann Transfers
#### Calculating required delta-V
The `hohmann(r1, r2, theta)` function calculates the required changes in velocity at the perigee and apogee of a transfer orbit for a [Hohmann transfer](https://en.wikipedia.org/wiki/Hohmann_transfer_orbit) between two circular orbits. The calculations used by this function assume that the burns are instantaneous, and that the eccentricities of the starting and final orbits are 0. Additionally, it is assumed that the inclination change is to occur entirely as part of the second burn, so the second burn is effectively a vector sum of a burn to circularise the orbit and a burn to change the inclination.

The semi-major axis of the transfer orbit is given by:

<p align = center>
<img src="https://render.githubusercontent.com/render/math?math=a=\frac{r_1+r_2}{2}">
</p>

The velocities associated with the initial and final orbits are given by:

<p align = center>
<img src="https://render.githubusercontent.com/render/math?math=v=\sqrt{\frac{GM}{r}}">
</p>

The velocity at the perigee and apogee of the transfer orbit is given by:

<p align = center>
<img src="https://render.githubusercontent.com/render/math?math=v=\sqrt{GM(\frac{2}{r}-\frac{1}{a})}">
</p>

where <img src="https://render.githubusercontent.com/render/math?math=r=r_1"> for the perigee and <img src="https://render.githubusercontent.com/render/math?math=r=r_2"> for the apogee.

Finally, the delta-v value at perigee is given by:
<p align = center>
<img src="https://render.githubusercontent.com/render/math?math=\Delta V_1=v_{perigee}-v_1">
</p>
and the delta-v value at apogee is given by:
<p align = center>
<img src="https://render.githubusercontent.com/render/math?math=\Delta V_2=\sqrt{v_{apogee}^2%2Bv_2^2-2v_{apogee}v_2\cos(\theta)}">
</p>

where <img src="https://render.githubusercontent.com/render/math?math=\theta"> is the difference in inclination between the two orbits.

For example, we can find the delta-V necessary to move the ESA's PROBA1 satellite from its current orbit with an inclination of 97.6° and an altitude of 585km, to a geostationary orbit with an inclination of 0° and altitude of 3579km. This function tells us that the required delta-V at the perigee of the transfer orbit will be 2347 m/s and the required delta-V at the apogee will be 3668 m/s.

<p align = center>
<img src="img/hohmann_diagram.png?raw=true" height="200">
</p>

### Launch Requirements
#### Launch Azimuth
The `launchAzimuth(i, r, lat, inertial)` function calculates an appropriate launch azimuth for a rocket to reach an orbit with a given inclination and radius, from a launch site at a given latitude. First, the function finds the inertial azimuth, that is, the launch azimuth that would be used if the starting velocity associated with the rotation of the Earth was neglected.

<p align = center>
<img src="https://render.githubusercontent.com/render/math?math=\beta_{inert}=\sin^{-1}\big(\frac{\cos(i)}{\cos(\phi)}\big)">
</p>

where <img src="https://render.githubusercontent.com/render/math?math=i"> is the inclination of the destination orbit, and <img src="https://render.githubusercontent.com/render/math?math=\phi"> is the latitude of the launch site.

It is assumed that the launch is directed eastwards (in the same direction as the Earth's rotation, to conserve energy). Taking into account the effects of the rotation of the Earth, the launch azimuth becomes:

<p align = center>
<img src="https://render.githubusercontent.com/render/math?math=\beta_{inert}=\tan^{-1}\big(\frac{v_{orbit}\sin(\beta_{inert})-v_{eqrot}\cos(\phi)}{v_{orbit}\cos(\beta_{inert})}\big)">
</p>

For example, if we want to launch a rocket from the Guiana Space Centre to an orbit with an inclination of 56° and altitude of 300km, this function tells us that the desired launch azimuth would be 31.2°.

#### Launch Time
In-orbit RAAN changes can be very fuel inefficient and are often unnecessary if the correct launch time is chosen for a desired RAAN. The `launchTime(RAAN, i, r, loc)` function calculates a possible launch time in order to launch directly into an orbit with a given inclination, RAAN, and orbit radius, from a given launch location (assuming an appropriate launch azimuth is used, see [Launch Azimuth](#Launch-Azimuth)). Note that the desired launch time will repeat every sidereal day, and so the launch time provided is simply the next available opportunity after the 2020 March Equinox and a user may add or subtract an integer number of sidereal days to find the launch time on any desired day. The time provided and location taken by this function are that of burnout, as it does not account for the mission-specific dynamics associated with the rocket, however, we will assume that burnout occurs instantaneously, allowing us to refer to the launch time and location.

The function first calculates the difference in longitude between the burnout location and the ascending node, using the formula:

<p align = center>
<img src="https://render.githubusercontent.com/render/math?math=\Delta \lambda=tan^{-1}(\sin(\delta)\tan(\beta_{inert}))">
</p>

where <img src="https://render.githubusercontent.com/render/math?math=\delta"> is the latitude of the burnout location.

Consider the Earth in an Earth Centred Inertial (ECI) reference frame, in which it is rotating beneath the stationary vernal equinox. To find the launch time, we want to find how long it will take for the planned location of the ascending node to rotate from its position at the time of the March Equinox to the vernal equinox. If we consider the longitudes to be expressed in terms of 0 to 360° from the prime meridian to the East, then we can express the angle that the Earth must rotate as:
<p align = center>
<img src="https://render.githubusercontent.com/render/math?math=\Rotation=\Equinox_{longitude}+\RAAN_{desired}-(\Launch_{longitude}-\Delta \lambda)">
</p>

in the ECI reference frame, we take Earth's rotation to be one sidereal day, and so the time between the March Equinox occurring and launch can be expressed as:

<p align = center>
<img src="https://render.githubusercontent.com/render/math?math=t=\frac{\Rotation}{360}t_{sidereal}">
</p>

where <img src="https://render.githubusercontent.com/render/math?math=t_{sidereal}"> is the length of time in a sidereal day. This time is then added to the time of the March Equinox ([in 2020, this occurred at 03:48 on the 20th of March (UTC)](https://www.timeanddate.com/worldclock/sunearth.html?iso=20200320T0348)).

For example, if we want to launch into an orbit with a 56° inclination, 300km altitude, and RAAN of 317°, from the Guiana Space Centre, this function tells us that the first available time after the 2020 March Equinox to do so will be on the same day at 12:59:39 (UTC).

## Lessons
When I originally developed much of this code in 2017, I researched the relevant space engineering concepts and gained a fundamental understanding of the orbital dynamics associated with the functionality of this toolbox. Returning to this project in 2020, to refactor and develop it into something more re-usable, gave me a welcome refresher on fundamental orbital dynamics and MATLAB programming.

## Credit
Thank you to the University of Sydney for the original task specifications which inspired the creation of this toolbox, and to my classmates who kept me going through all the late nights while working on this originally.

[Space Mission Analysis and Design: The New SMAD, James R. Wertz (2011)](https://www.amazon.com.au/Space-Mission-Engineering-Technology-Library/dp/1881883159) was the main source of reference for all of the formulae outlined in this README and implemented in the toolbox.

## Disclaimer
This work is entirely my own and has been modified since it was originally implemented for an assignment. It should not be copied in any form by students in university courses with similar assignments. If you are struggling with a similar project and want to get in touch I would be happy to have a chat and help out with your understanding or point you to some useful resources!
