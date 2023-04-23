# A Linked List library
This library offers a versatile and efficient implementation of a doubly linked list data structure in motoko.
It provides the ability to access and manipulate the linked list nodes directly, giving developers greater control and flexibility over their programs.
## Benefits of Direct Node Access
Direct access to linked list nodes allows developers to:
  - Avoid redundant traversals by storing references to nodes
  - Manipulate node references directly, for efficient insertions and deletions
  - Tailor node manipulations to their specific use cases, making the implementation more adaptable to a variety of applications

## Documentation
The documentation for this library can be found [here](./docs/lib.md);

## Usage Example
- Example with node level functions
```motoko
import LinkedList "mo:linked-list";

// Create a new linked list
let list = LinkedList.LinkedList<Nat>();

// Create a new node
let one = LinkedList.Node(1);
let two = LinkedList.Node(2);
let three = LinkedList.Node(3);

// Add nodes to the linked list
LinkedList.append_node(list, three);
LinkedList.prepend_node(list, one);

// Insert node into the linked list
LinkedList.insert_node(list, 1, two);

assert LinkedList.toArray(list) == [1, 2, 3];

LinkedList.remove_node(list, two); // Remove the node at index 1

assert LinkedList.toArray(list) == [1, 3];

```

- Example with list level functions
```motoko
import LinkedList "mo:linked-list";

// Create a new linked list
let list = LinkedList.LinkedList<Nat>();

// Add values to the linked list
LinkedList.append(list, 3);
LinkedList.prepend(list, 1);

// Insert value into the linked list
LinkedList.insert(list, 1, 2);

let node2 = LinkedList.get(list, 1) == 2;

assert node2.data == 2;
assert LinkedList.map(list, func (n: Nat) : Nat = n * n);

assert node2.data == 4;
assert LinkedList.toArray(list) == [1, 4, 9];

```