import 'dart:collection';
import 'dart:io';

class Node<T> {
  T value;
  Node<T>? left, right;

  Node(this.value);
}

class BinaryTree<T> {
  Node<T>? root;

  void printPreOrder(Node? node) {
    if (node != null) {
      stdout.write('${node.value} ');
      printPreOrder(node.left);
      printPreOrder(node.right);
    }
  }

  void printInOrder(Node? node) {
    if (node != null) {
      printInOrder(node.left);
      stdout.write('${node.value} ');
      printInOrder(node.right);
    }
  }

  void printPostOrder(Node? node) {
    if (node != null) {
      printPostOrder(node.left);
      printPostOrder(node.right);
      stdout.write('${node.value} ');
    }
  }

  void addLevelOrder(T value) {
    Node<T> newNode = Node(value);
    if (root == null) {
      root = newNode;
      return;
    }

    Queue<Node<T>> queue = Queue();
    queue.add(root!);

    while (queue.isNotEmpty) {
      Node<T> current = queue.removeFirst();

      if (current.left == null) {
        current.left = newNode;
        break;
      } else {
        queue.add(current.left!);
      }

      if (current.right == null) {
        current.right = newNode;
        break;
      } else {
        queue.add(current.right!);
      }
    }
  }

  bool addByTarget(T target, T newValue, {bool left = true}) {
    if (root == null) return false;

    Queue<Node<T>> queue = Queue();
    queue.add(root!);

    while (queue.isNotEmpty) {
      Node<T> current = queue.removeFirst();
      if (current.value == target) {
        if (left && current.left == null) {
          current.left = Node(newValue);
          return true;
        } else if (!left && current.right == null) {
          current.right = Node(newValue);
          return true;
        }
        return false;
      }
      if (current.left != null) queue.add(current.left!);
      if (current.right != null) queue.add(current.right!);
    }
    return false;
  }

  void preOrderNonRecursive() {
    if (root == null) return;
    List<Node<T>> stack = [root!];

    while (stack.isNotEmpty) {
      Node<T> current = stack.removeLast();
      stdout.write('${current.value} ');

      if (current.right != null) stack.add(current.right!);
      if (current.left != null) stack.add(current.left!);
    }
  }

  void inOrderNonRecursive() {
    List<Node<T>> stack = [];
    Node<T>? current = root;

    while (current != null || stack.isNotEmpty) {
      while (current != null) {
        stack.add(current);
        current = current.left;
      }
      current = stack.removeLast();
      stdout.write('${current.value} ');
      current = current.right;
    }
  }

  void postOrderNonRecursive() {
    if (root == null) return;

    List<Node<T>> stack1 = [root!];
    List<Node<T>> stack2 = [];

    while (stack1.isNotEmpty) {
      Node<T> current = stack1.removeLast();
      stack2.add(current);

      if (current.left != null) stack1.add(current.left!);
      if (current.right != null) stack1.add(current.right!);
    }

    while (stack2.isNotEmpty) {
      stdout.write('${stack2.removeLast().value} ');
    }
  }
}

void main() {
  BinaryTree<dynamic> bt = BinaryTree();
  bt.root = Node("a");
  bt.root!.left = Node(1);
  bt.root!.right = Node(2);
  bt.root!.left!.left = Node(3);
  bt.root!.left!.right = Node(4);
  bt.root!.right!.left = Node(5);
  bt.root!.right!.right = Node(6);

  print("Rekursif Pre Order:");
  bt.printPreOrder(bt.root);
  print("\nRekursif In Order:");
  bt.printInOrder(bt.root);
  print("\nRekursif Post Order:");
  bt.printPostOrder(bt.root);

  print("\n\nNon-Rekursif Pre Order:");
  bt.preOrderNonRecursive();
  print("\nNon-Rekursif In Order:");
  bt.inOrderNonRecursive();
  print("\nNon-Rekursif Post Order:");
  bt.postOrderNonRecursive();

  // Tambah berdasarkan Level Order
  bt.addLevelOrder(99);
  print("\n\nSetelah tambah 99 (Level Order):");
  bt.inOrderNonRecursive();

  // Tambah berdasarkan target
  bool success = bt.addByTarget(5, 88, left: true);
  print("\n\nTambah 88 sebagai anak kiri dari 5: ${success ? "Berhasil" : "Gagal"}");
  bt.inOrderNonRecursive();
}
