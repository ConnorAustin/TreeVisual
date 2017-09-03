
import java.lang.Math; // imported for Math.max()

/*
 * A balanced Binary Search Tree using AVL
 * 
 * Reference: https://en.wikipedia.org/wiki/AVL_tree
 */
class AVL extends BST {
  /*
   * Updates the height of the given node using the maximum height of its two children plus one
   */
  void updateHeight(Node node) {
    node.height = Math.max(getHeight(node.left), getHeight(node.right)) + 1;
  }

  /*
   * Balances a node returning what node is now where the node we past it was
   */
  Node balanceNode(Node node) {
    updateHeight(node);
    if (getBalance(node) == 2) {
      // Right Left
      if (getBalance(node.right) == -1) {
        node.right = rotateRight(node.right);
      }
      return rotateLeft(node);
    } else if (getBalance(node) == -2) {
      // Left Right
      if (getBalance(node.left) == 1) {
        node.left = rotateLeft(node.left);
      }
      return rotateRight(node);
    }
    return node;
  }

  /*
   * Rotates the given node left
   * 
   * Returns the node at the position where the node we rotated was
   */
  @Override
  Node rotateLeft(Node node) {
    Node newNode = super.rotateLeft(node);
  
    // Update heights
    updateHeight(node);
    updateHeight(newNode);
    
    return newNode;
  }

  /*
   * Rotates the given node right
   * 
   * Returns the node at the position where the node we rotated was
   */
  @Override
  Node rotateRight(Node node) {
    Node newNode = super.rotateRight(node);

    // Update heights
    updateHeight(node);
    updateHeight(newNode);

    return newNode;
  }

  /*
   * Returns the height of the given node
   * 
   * If the node is null, it returns -1
   */
  @Override
  int getHeight(Node node) {
    return node == null ? -1 : node.height;
  }

  /*
   * Adds the given value to the tree
   */
  @Override
  public void add(int value) {
    root = _add(root, value);
  }

  /*
   * Returns what is the child of whatever called it after adding the new node and balancing the tree using the AVL approach
   */
  Node _add(Node node, int value) {
    if (node == null) {
      return new Node(value);
    }

    if (value == node.value) {
      return node;
    }

    if (value > node.value) {
      if (node.right == null) {
        node.right = new Node(value);
        updateHeight(node);
      } else {
        node.right = _add(node.right, value);
        return balanceNode(node);
      }
    } else {
      if (node.left == null) {
        node.left = new Node(value);
        updateHeight(node);
      } else {
        node.left = _add(node.left, value);
        return balanceNode(node);
      }
    }
    return node;
  }
}