import java.io.FileInputStream; // imported for reading the text file
import java.io.FileNotFoundException; // imported for reading the text file
import java.util.Scanner; // imported for reading the text file

import java.util.ArrayList; // imported for ArrayList used *only* for file IO and as the result of (Post/Pre/In)-Order traversal

/*
 * An unbalanced Binary Search Tree
 */
class BST {
  // The root of the tree, this node has no parents. Basically Batman
  Node root;

  /*
   * Returns an ArrayList of the node values in PreOrder Order
   */
  public ArrayList<Node> preOrder() {
    return _preOrder(root);
  }

  /*
   * Returns an ArrayList of the node values in PreOrder Order starting at the given node
   */
  ArrayList<Node> _preOrder(Node node) {
    ArrayList<Node> list = new ArrayList<Node>();

    if (node != null) {
      list.add(node);
      list.addAll(_preOrder(node.left));
      list.addAll(_preOrder(node.right));
    }
    return list;
  }

  /*
   * Returns an ArrayList of the node values in InOrder Order
   */
  public ArrayList<Node> inOrder() {
    return _inOrder(root);
  }

  /*
   * Returns an ArrayList of the node values in InOrder Order starting at the given node
   */
  ArrayList<Node> _inOrder(Node node) {
    ArrayList<Node> list = new ArrayList<Node>();

    if (node != null) {
      list.addAll(_inOrder(node.left));
      list.add(node);
      list.addAll(_inOrder(node.right));
    }
    return list;
  }

  /*
   * Returns an ArrayList of the node values in PostOrder Order
   */
  public ArrayList<Node> postOrder() {
    return _postOrder(root);
  }

  /*
   * Returns an ArrayList of the node values in PostOrder Order starting at the given node
   */
  ArrayList<Node> _postOrder(Node node) {
    ArrayList<Node> list = new ArrayList<Node>();

    if (node != null) {
      list.addAll(_postOrder(node.left));
      list.addAll(_postOrder(node.right));
      list.add(node);
    }
    return list;
  }

  /*
   * Adds a node to the tree with the value given, ignores values already in the tree
   */
  public void add(int value) {
    root = _add(root, value);
  }

  /*
   * Returns what is the child of whatever called it after adding the new node
   */
  Node _add(Node node, int value) {
    if (node == null) {
      return new Node(value);
    }

    if (value == node.value) {
      return node;
    }

    if (value > node.value) {
      node.right = _add(node.right, value);
    } else {
      node.left = _add(node.left, value);
    }

    return node;
  }

  /*
   * Returns the number of comparisons needed to find a node of value starting at the given node
   */
  int findTime(Node node, int value) {
    // Check if this is the node
    if (value == node.value) {
      // Found node, return one as the comparisons done
      return 1;
    }

    // Check if the node is to the right
    if (value > node.value) {
      // Node must be to the right, the find time must be the time to find it
      // from the right child plus our comparisons
      return findTime(node.right, value) + 1;
    } else {
      // Node must be to the left, the find time must be the time to find it
      // from the left child plus our comparisons
      return findTime(node.left, value) + 1;
    }
  }
  
  /*
   * Rotates the given node left
   * 
   * Returns the node at the position where the node we rotated was
   */
  Node rotateLeft(Node node) {
    Node newNode = node.right;
    node.right = newNode.left;
    newNode.left = node;

    node.size = 0;
    newNode.size = 0;
    
    return newNode;
  }

  /*
   * Rotates the given node right
   * 
   * Returns the node at the position where the node we rotated was
   */
  Node rotateRight(Node node) {
    Node newNode = node.left;
    node.left = newNode.right;
    newNode.right = node;

    node.size = 0;
    newNode.size = 0;

    return newNode;
  }

  /*
   * Returns the Average Computational Effort of the BST
   */
  public double ACE() {
    // Gather all the nodes, we really don't care what order they come in
    ArrayList<Node> nodes = preOrder();
    int ace = 0;

    // Sum the computational effort to find each node starting at the root
    for (Node node : nodes) {
      ace += findTime(root, node.value);
    }

    // Average the computational effort and return
    return (double) ace / (double) (nodes.size() == 0 ? 1 : nodes.size());
  }

  /*
   * Returns the height of a given node
   * 
   * If the node is null, it returns -1
   */
  int getHeight(Node node) {
    if (node == null) {
      return -1;
    }
    return Math.max(getHeight(node.left), getHeight(node.right)) + 1;
  }

  /*
   * Returns the balance of a node
   * 
   * A positive balance is leaning right
   * 
   * A negative balance is leaning left
   * 
   * A zero balance is neutral
   */
  int getBalance(Node node) {
    return getHeight(node.right) - getHeight(node.left);
  }
}