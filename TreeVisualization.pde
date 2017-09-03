static int nodeSize = 20;
static int nodeYSpacing = 20;
static float guiWidth = 140;
static float buttonW = 100;
static float buttonH = 40;

BST bst = new BST();
AVL avl = new AVL();
RB rb = new RB();

BST curBST = bst;

String inputBox = "";

ArrayList<Button> buttons = new ArrayList<Button>();

ArrayList<Integer> nodes = new ArrayList<Integer>();

void setup()
{
  noStroke();
  size(1440, 990);
  buttons.add(new Button(40, 60, "Add", color(200)));
  buttons.add(new Button(40, 140, "Unbalanced", color(200, 120, 120)));
  buttons.add(new Button(40, 200, "AVL", color(200)));
  buttons.add(new Button(40, 260, "Red-Black", color(200)));
}

void keyPressed()
{ 
  if((key == 8 || key == 46) && inputBox.length() > 0)
  {
   inputBox = inputBox.substring(0, inputBox.length() - 1);
  }
  if(inputBox.length() != 3 && (key >= '0' && key <= '9'))
  {
    inputBox += key;
  }
  
  if(key == '\n' && inputBox.length() > 0)
  {
    curBST.add(Integer.parseInt(inputBox));
    inputBox = "";
  }
}

void mousePressed()
{
  for(Button b : buttons)
  {
    if(mouseX >= b.x && mouseX <= b.x + buttonW && mouseY >= b.y && mouseY <= b.y + buttonH)
    {
      b.clicked = true;
    }
  }
}

Button getButton(String text)
{
  for(Button b : buttons)
  {
    if(b.text.equals(text))
      return b;
  }
  return null;
}

void mouseReleased()
{
  for(Button b : buttons)
  {
    if(mouseX >= b.x && mouseX <= b.x + buttonW && mouseY >= b.y && mouseY <= b.y + buttonH && b.clicked)
    {
      if(b.text.equals("Add") && inputBox.length() > 0)
      {        
        curBST.add(Integer.parseInt(inputBox));
        inputBox = "";
      }
      if(b.text.equals("Unbalanced"))
      {
        curBST = bst;
        
        b.col = color(200, 120, 120); 
        getButton("AVL").col = color(200);
        getButton("Red-Black").col = color(200);
      }
      if(b.text.equals("AVL"))
      {
        curBST = avl;
        
        b.col = color(200, 120, 120); 
        getButton("Unbalanced").col = color(200);
        getButton("Red-Black").col = color(200);
      }
      if(b.text.equals("Red-Black"))
      {
        curBST = rb;
        
        b.col = color(200, 120, 120); 
        getButton("AVL").col = color(200);
        getButton("Unbalanced").col = color(200);
      }
    }
    b.clicked = false;
  }
}

void draw()
{
  background(120);
  
  for(Node node : curBST.preOrder())
  {
    node.update();
  }
  if(nodes.size() > 0)
  {
    text("Next node: " + nodes.get(0), 10, 10);
  }
  
  drawNode(curBST.root, width / 2, 20);
  
  fill(110);
  rect(1, 0, 180, height);
  
  fill(80);
  rect(0, 0, 180, height);
  
  fill(90);
  rect(0, 120, 180, 5);
  
  for(Button b : buttons)
  {
    b.drawSelf();
  }
  
  fill(220);
  rect(40, 22, buttonW, 20);
  fill(255);
  rect(40, 20, buttonW, 20);
  fill(0);
  textAlign(LEFT);
  text(inputBox, 40 + 3, 20 + 14); 
}