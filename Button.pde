class Button
{
  float x, y;
  String text;
  boolean clicked;
  color col;
  
  public Button(float x, float y, String text, color col)
  {
    this.x = x;
    this.y = y;
    this.text = text;
    this.clicked = false;
    this.col = col;
  }
  
  color darken(color c)
  {
    return color(red(c) / 1.5, green(c) / 1.5, blue(c) / 1.5); 
  }
  
  public void drawSelf()
  {
    if(!clicked)
    {
      fill(darken(col));
      rect(x, y, buttonW, buttonH + 4);
    }
    fill(col);
    rect(x, y + (clicked ? 4 : 0), buttonW, buttonH);
    
    fill(0);
    
    textAlign(CENTER);
    text(this.text, x + buttonW / 2.0f, y + buttonH / 2.0f + 5 + (clicked ? 4 : 0));
  }
}