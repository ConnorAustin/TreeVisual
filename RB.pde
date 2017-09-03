/*
 * A balanced Binary Search Tree using Red-Black balancing
 * 
 * Reference: https://en.wikipedia.org/wiki/Red%E2%80%93black_tree
 */
public class RB extends BST {
  /*
   * Adds a node to the tree with the value given, ignores values already in the tree
   * 
   * It then balances the tree using Red-Black balancing
   */
  @Override
  public void add(int value) {
    // Case 1, the root is null
    if (root == null) {
      root = new Node(value);
      root.col = Color.black;
      return;
    }

    Node node = root;
    while (true) {
      // Ignore values if they are already in the tree
      if (node.value == value) {
        return;
      }

      if (value > node.value) {
        if (node.right == null) {
          node.right = new Node(value);
          node.right.parent = node;
          rbCase2(node.right);
          break;
        } else {
          node = node.right;
        }
      } else {
        if (node.left == null) {
          node.left = new Node(value);
          node.left.parent = node;
          rbCase2(node.left);
          break;
        } else {
          node = node.left;
        }
      }
    }
  }

  /*
   * Returns the grand parent of a node, if it has one
   */
  Node grandParent(Node node) {
    if (node != null && node.parent != null) {
      return node.parent.parent;
    }
    return null;
  }

  /*
   * Returns the uncle of a node, if it has one
   */
  Node uncle(Node node) {
    Node gp = grandParent(node);
    if (gp == null) {
      return null;
    }
    if (gp.left == node.parent) {
      return gp.right;
    }
    return gp.left;
  }

  /*
   * Rotates the given node left, ignore the return value. It is not used
   */
  @Override
  Node rotateLeft(Node node) {
    Node newNode = super.rotateLeft(node);

    // Update parents
    if (node.right != null) {
      node.right.parent = node;
    }

    newNode.parent = node.parent;
    node.parent = newNode;

    if (newNode.parent == null) {
      root = newNode;
    } else if (newNode.parent.left == node) {
      newNode.parent.left = newNode;
    } else {
      newNode.parent.right = newNode;
    }
    // We don't use the return value of a rotate in a RB tree
    return null;
  }

  /*
   * Rotates the given node right, ignore the return value. It is not used
   */
  @Override
  Node rotateRight(Node node) {
    Node newNode = super.rotateRight(node);
    
    // Update parents
    if (node.left != null) {
      node.left.parent = node;
    }

    newNode.parent = node.parent;
    node.parent = newNode;

    if (newNode.parent == null) {
      root = newNode;
    } else if (newNode.parent.left == node) {
      newNode.parent.left = newNode;
    } else {
      newNode.parent.right = newNode;
    }
    // We don't use the return value of a rotate in a RB tree
    return null;
  }

  /*
   * Case 1 for Red-Black insertion: This is the root
   */
  void rbCase1(Node node) {
    // If this is the root
    if (node.parent == null) {
      // Make the root black because one of the rules is that the root is always black and we are done
      node.col = Color.black;
    } else {
      rbCase2(node);
    }
  }

  /*
   * Case 2 for Red-Black insertion: The parent is black
   */
  void rbCase2(Node node) {
    if (node.parent.col != Color.black) {
      rbCase3(node);
    }
    // Nodes that are just added are red. If the parent is black, the number of blacks hasn't changed
    // So no action is needed and we are done
  }

  /*
   * Case 3 for Red-Black insertion: The uncle is red
   */
  void rbCase3(Node node) {
    Node uncle = uncle(node);
    if (uncle != null && uncle.col == Color.red) {
      // Push the blackness down from the grandparent
      uncle.col = Color.black;
      node.parent.col = Color.black;

      Node gp = grandParent(node);
      gp.col = Color.red;
      rbCase1(gp);
    } else {
      rbCase4(node);
    }
  }

  /*
   * Case 4 and 5 for Red-Black insertion: Single or double rotate is needed respectively
   */
  void rbCase4(Node node) {
    Node gp = grandParent(node);
    if (gp.left == node.parent) {
      // Case 5, double rotation. Do one rotation then go to case 4 for the other
      if (node.parent.right == node) {
        rotateLeft(node.parent);
        node.col = Color.black;
        gp.col = Color.red;
      } else {
        node.parent.col = Color.black;
        gp.col = Color.red;
      }
      // Case 4, single rotation
      rotateRight(gp);
    } else {
      // Case 5, double rotation. Do one rotation then go to case 4 for the other
      if (node.parent.left == node) {
        rotateRight(node.parent);
        node.col = Color.black;
        gp.col = Color.red;
      } else {
        node.parent.col = Color.black;
        gp.col = Color.red;
      }
      // Case 4, single rotation
      rotateLeft(gp);
    }
  }
}