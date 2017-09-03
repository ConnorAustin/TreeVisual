public class Node
{
  int value;

  Node left;
  Node right;
  
  //AVL
  int height;
  
  //Red Black
  Node parent;
  Color col;
  
  float size;
  
  public Node(int t)
  {
    value = t;
    left = null;
    right = null;
    
    height = 0;
    
    parent = null;
    col = Color.red;
    size = 0.0f;
  }
  
  public void update()
  {
    size = min(1, size + 0.1f);
  }
}