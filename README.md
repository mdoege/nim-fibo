## A Fibonacci 12-hour clock in Nim using SDL2

Compile with

```nim c fibo```

The [Fibonacci clock](https://www.kickstarter.com/projects/basbrun/fibonacci-clock-an-open-source-clock-for-nerds-wit/) designed by [Philippe Chrétien](https://github.com/pchretien): Squares have values of 1, 2, 3, or 5. To get the hour, add red and blue squares. To get the minute, add green and blue squares, then multiply by five. (Minutes are displayed for the last five-minute increment, so e.g. 30 to 34 minutes is shown as 30 minutes.)

Pressing Space cycles between red/green/blue/black plus 10 different palettes from [fibonacci.ino](https://github.com/pchretien/fibo/blob/master/fibonacci.ino) which all use white for inactive elements.

Window size is fixed at 800x500 pixels.

The time in the screenshot below is 10:55.

![screenshot](https://github.com/mdoege/nim-fibo/raw/master/screenshot.png "nim-fibo screenshot")
