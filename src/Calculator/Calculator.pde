// Samuel Maass | Sep 25 2025 | Calculator 

String displayText = "0";
double num1 = 0.0;
String operator = "";
boolean isOperatorClicked = false;
Button[] buttons = new Button[24];
PFont displayFont, buttonFont;

color backgroundColor = color(30, 30, 40);
color displayColor = color(50, 50, 60);
color textColor = color(230, 230, 230);


color blueButtonColor = color(0, 102, 204); 
color redButtonColor = color(204, 51, 51);  

void setup() {
  size(360, 650);
  
  displayFont = createFont("Monospaced.bold", 48);
  buttonFont = createFont("Monospaced.bold", 24);
  
  String[] buttonLabels = {
    "C", "√", "x²", "<-",
    "7", "8", "9", "/",
    "4", "5", "6", "x",
    "1", "2", "3", "-",
    "0", ".", "+/-", "+",
    "%", " ", " ", "="
  };
  
  int index = 0;
  float buttonWidth = 75;
  float buttonHeight = 75;
  float spacing = 10;

  for (int row = 0; row < 6; row++) {
    for (int col = 0; col < 4; col++) {
      String label = buttonLabels[index];
      if (!label.trim().isEmpty()) {
        float x = 10 + col * (buttonWidth + spacing);
        float y = 130 + row * (buttonHeight + spacing);
        

        color c;
        if ("+-/x=".contains(label)) {
          c = redButtonColor; 
        } else {
          c = blueButtonColor; 
        }
        
        buttons[index] = new Button(x, y, buttonWidth, buttonHeight, label, c);
      }
      index++;
    }
  }
}

void draw() {
  background(backgroundColor);
  drawDisplay();
  
  for (Button b : buttons) {
    if (b != null) {
      b.display();
    }
  }
}

void mousePressed() {
  for (Button b : buttons) {
    if (b != null && b.isHovering()) {
      processInput(b.label);
    }
  }
}

void drawDisplay() {
  fill(displayColor);
  noStroke();
  rect(10, 10, width - 20, 100, 10);

  fill(textColor);
  textFont(displayFont);
  textAlign(RIGHT, CENTER);
  float currentTextSize = 48;
  while (textWidth(displayText) > width - 50 && currentTextSize > 12) {
      currentTextSize--;
      textFont(createFont("Mono", currentTextSize));
  }
  text(displayText, width - 25, 60);
}

void processInput(String command) {
  switch (command) {
    case "C":
      displayText = "0";
      num1 = 0;
      operator = "";
      isOperatorClicked = false;
      break;
    case "<-":
      if (displayText.equals("Error") || displayText.equals("Infinity")) {
        displayText = "0";
      } else if (displayText.length() > 1) {
        displayText = displayText.substring(0, displayText.length() - 1);
      } else {
        displayText = "0";
      }
      break;
    case "+/-":
      if (!displayText.equals("0") && !displayText.equals("Error")) {
          if (displayText.startsWith("-")) {
              displayText = displayText.substring(1);
          } else {
              displayText = "-" + displayText;
          }
      }
      break;
    
    case "%":
      if (!displayText.equals("Error")) {
          num1 = Double.parseDouble(displayText);
          displayText = formatResult(num1 / 100.0);
          isOperatorClicked = true;
      }
      break;
    case "x²":
       if (!displayText.equals("Error")) {
          num1 = Double.parseDouble(displayText);
          displayText = formatResult(num1 * num1);
          isOperatorClicked = true;
      }
      break;
    case "√":
       if (!displayText.equals("Error")) {
          num1 = Double.parseDouble(displayText);
          if (num1 >= 0) {
            displayText = formatResult(sqrt((float)num1));
          } else {
            displayText = "Error";
          }
          isOperatorClicked = true;
      }
      break;

    case "=":
      if (!operator.isEmpty() && !isOperatorClicked) {
        double num2 = Double.parseDouble(displayText);
        double result = 0;
        switch (operator) {
          case "+": result = num1 + num2; break;
          case "-": result = num1 - num2; break;
          case "x": result = num1 * num2; break;
          case "/":
            if (num2 != 0) {
              result = num1 / num2;
            } else {
              displayText = "Error";
              return;
            }
            break;
        }
        displayText = formatResult(result);
        operator = "";
        isOperatorClicked = true;
      }
      break;
    case "+": case "-": case "x": case "/":
      if (!isOperatorClicked) {
          processInput("=");
      }
      num1 = Double.parseDouble(displayText);
      operator = command;
      isOperatorClicked = true;
      break;
    
    case ".":
      if (!displayText.contains(".")) {
        displayText += ".";
      }
      break;
    default:
      if (displayText.equals("0") || isOperatorClicked) {
        displayText = command;
        isOperatorClicked = false;
      } else {
        displayText += command;
      }
      break;
  }
}

String formatResult(double result) {
  if (Double.isNaN(result) || Double.isInfinite(result)) {
      return "Error";
  }
  if (result == (long) result) {
    return String.format("%d", (long)result);
  } else {
    return String.format("%.8f", result).replaceAll("\\.?0+$", "");
  }
}

class Button {
  float x, y, w, h;
  String label;
  color baseColor, hoverColor, pressColor;

  Button(float x, float y, float w, float h, String label, color c) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
    this.baseColor = c;
    this.hoverColor = color(min(255, red(c) + 30), min(255, green(c) + 30), min(255, blue(c) + 30)); // Brighter
    this.pressColor = color(max(0, red(c) - 30), max(0, green(c) - 30), max(0, blue(c) - 30)); // Darker
  }
  
  boolean isHovering() {
    float centerX = x + w / 2;
    float centerY = y + h / 2;
    float radius = w / 2;
    return dist(mouseX, mouseY, centerX, centerY) < radius;
  }

  void display() {
    noStroke();
    if (isHovering() && mousePressed) {
      fill(pressColor);
    } else if (isHovering()) {
      fill(hoverColor);
    } else {
      fill(baseColor);
    }
    
    ellipse(x + w / 2, y + h / 2, w, h);
    
    fill(textColor);
    textFont(buttonFont);
    textAlign(CENTER, CENTER);
    text(label, x + w / 2, y + h / 2 - 2); 
  }
}
