int getWidth(Node n)
{
  if(n == null)
  {
    return 0;
  }
  
  return getWidth(n.left) + getWidth(n.right) + 10;
}

float getLeftChildX(Node node, float nodeX)
{
  int w = getWidth(node);
  return nodeX - w / 2.0f;
}

float getRightChildX(Node node, float nodeX)
{
  int w = getWidth(node);
  return nodeX + w / 2.0f;
}

float getChildY(Node node, float nodeY)
{
  return nodeY + nodeYSpacing;
}

void drawNode(Node node, float x, float y)
{ 
  if(node == null)
    return;
  
  if(node.col == Color.black)
  {
    fill(31, 32, 38);
  }
  else 
  { 
    fill(240, 79, 79);
  }
  
  float leftX = getLeftChildX(node, x);
  float rightX = getRightChildX(node, x);
  float childY = getChildY(node, y);
  
  stroke(0);
  if(node.left != null)
    line(x, y, leftX, childY);
  if(node.right != null)
    line(x, y, rightX, childY);
    
  noStroke();
  pushMatrix();
  translate(x, y);
  scale(node.size);
  ellipse(0, 0, nodeSize, nodeSize);
  
  textAlign(CENTER);
  fill(255);
  text("" + node.value, 0, 5);
  
  popMatrix();
  
  drawNode(node.left, leftX, childY);
  drawNode(node.right, rightX, childY);
  
  
}