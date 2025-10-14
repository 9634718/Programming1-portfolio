# Samuel Maass' Programming Portfolio

## Projects for Term 1

### Calculator (2025)

**This Processing code creates a sophisticated and visually polished graphical calculator application with a complete set of functionalities. The calculator features a dark-themed user interface with a clear, monospaced digital display at the top and a grid of twenty-four circular buttons below. The design is intuitive, utilizing distinct colors to differentiate button types: operational commands like addition, subtraction, multiplication, division, and the equals sign are colored red, while numbers and other functions are blue, providing clear visual cues to the user. Beyond basic arithmetic, the calculator handles more advanced mathematical operations including square root (`√`), squaring a number (`x²`), percentage calculation (`%`), and inverting the sign of the current number (`+/-`). The user experience is enhanced with interactive button feedback; the buttons change color to a brighter shade when the mouse hovers over them and a darker shade when pressed. The display is dynamically sized, automatically shrinking the font if a number becomes too long to fit, ensuring readability at all times. The internal logic is robust, managing the sequence of operations through state variables that track the first number (`num1`), the selected operator (`operator`), and whether an operator has just been clicked (`isOperatorClicked`), allowing for chained calculations (e.g., `5 * 4 - 2`). It also includes essential utility functions such as a clear button ("C") to reset the entire calculation and a backspace button ("<-") to delete the last entered digit. Error handling is built-in, correctly displaying "Error" for invalid operations like division by zero or taking the square root of a negative number. Finally, the output is intelligently formatted by the `formatResult` function, which displays whole numbers without a decimal point and trims unnecessary trailing zeros from floating-point results, presenting clean and professional-looking answers. The code is well-structured, using a dedicated `Button` class to encapsulate the properties and behaviors of each button, which makes the main program logic cleaner and more manageable.****

![Running Calculator](https://github.com/9634718/Programming1-portfolio/blob/main/images/calc.png?raw=true)

* [Windows EXE]()
* [MacOSX]()
* [Source Code]()
