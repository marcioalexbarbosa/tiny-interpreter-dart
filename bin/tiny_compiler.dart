class Node {
  dynamic val;
  final List<Node> children = [];

  Node({required this.val});

  @override
  String toString() {
    return 'Node{val: $val, children: $children}';
  }
}

bool isNumeric(String s) {
  return int.tryParse(s) != null;
}

List<String> lex(String value) => value.split(' ');

class Stack<E> {
  final _list = <E>[];

  void push(E value) => _list.add(value);

  E pop() => _list.removeLast();

  E get peek => _list.last;

  bool get isEmpty => _list.isEmpty;

  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}

Stack<Node> parse(List<String> tokens) {
  var i = 0;

  Stack<Node> stack = Stack();

  Node root = Node(val: 'root');

  String consume() => i < tokens.length ? tokens[i++].trim() : '';

  String token;

  Node current = root;

  while ((token = consume()) != '') {
    if (!isNumeric(token)) {
      final node = Node(val: token);
      current.children.add(node);
      current = node;
      stack.push(current);
    } else {
      current.children.add(Node(val: int.parse(token)));
    }
  }

  return stack;
}

double visit(Node node) {
  double total = 0;
  switch (node.val) {
    case 'sum':
      for (var element in node.children) {
        if (element.val is int) {
          total = element.val + total;
        }
      }
      break;
    case 'sub':
      for (var element in node.children) {
        if (element.val is int) {
          total = element.val - total;
        }
      }

      break;
    case 'mul':
      for (var element in node.children) {
        if (element.val is int) {
          total = element.val * total;
        }
      }
      break;
  }
  return total;
}

evaluate(Stack<Node> ast) {
  double total = 0;
  while (ast.isNotEmpty) {
    final node = ast.pop();
    final operation = node.val;
    switch (operation) {
      case 'sum':
        for (var element in node.children) {
          if (element.val is int) {
            total = element.val + total;
          }
        }
        break;
      case 'sub':
        for (var element in node.children) {
          if (element.val is int) {
            total = element.val - total;
          }
        }

        break;
      case 'mul':
        for (var element in node.children) {
          if (element.val is int) {
            total = element.val * (total == 0.0 ? 1.0 : total);
          }
        }
        break;
      case 'div':
        for (var element in node.children) {
          if (element.val is int) {
            total = element.val / (total == 0.0 ? 1.0 : total);
          }
        }
        break;
    }
  }
  return total;
}

void main(List<String> arguments) {
  const program = 'mul 3 sub 2 sum 1 3 4'; // -18.0

  print(evaluate(parse(lex(program))));

}
