# lib

## Type `Node`
``` motoko no-repl
type Node<Item> = { var data : Item; var _prev : ?Node<Item>; var _next : ?Node<Item> }
```


## Function `Node`
``` motoko no-repl
func Node<Item>(data : Item) : Node<Item>
```

Creates a new node with the given data.

## Type `LinkedList`
``` motoko no-repl
type LinkedList<Item> = { var _head : ?Node<Item>; var _tail : ?Node<Item>; var _size : Nat }
```


## Function `LinkedList`
``` motoko no-repl
func LinkedList<Item>() : LinkedList<Item>
```

Creates an empty linked list.

## Function `size`
``` motoko no-repl
func size<Item>(list : LinkedList<Item>) : Nat
```

Returns the size of the list.

## Function `node_data`
``` motoko no-repl
func node_data<Item>(node : Node<Item>) : Item
```

Returns the data stored in the given node.

## Function `set_node_data`
``` motoko no-repl
func set_node_data<Item>(node : Node<Item>, data : Item)
```

Updates the data stored in the given node.

## Function `prepend_node`
``` motoko no-repl
func prepend_node<Item>(list : LinkedList<Item>, node : Node<Item>)
```

Adds a node to the beginning of the list.

## Function `append_node`
``` motoko no-repl
func append_node<Item>(list : LinkedList<Item>, node : Node<Item>)
```

Adds a node to the end of the list.

## Function `remove_node`
``` motoko no-repl
func remove_node<Item>(list : LinkedList<Item>, node : Node<Item>)
```

Remove the given node from the list.

## Function `get_node_opt`
``` motoko no-repl
func get_node_opt<Item>(list : LinkedList<Item>, i : Nat) : ?Node<Item>
```

Returns the node at the specified index or null if the index is out of bounds.

## Function `get_node`
``` motoko no-repl
func get_node<Item>(list : LinkedList<Item>, i : Nat) : Node<Item>
```

Returns the node at the specified index or traps if the index is out of bounds.

## Function `insert_node`
``` motoko no-repl
func insert_node<Item>(list : LinkedList<Item>, node : Node<Item>, i : Nat)
```

Inserts a node at the specified index.

## Function `find_node`
``` motoko no-repl
func find_node<Item>(list : LinkedList<Item>, item : Item, isEq : (Item, Item) -> Bool) : ?Node<Item>
```

Returns the first node in the list that matches the given item.

## Function `prepend`
``` motoko no-repl
func prepend<Item>(list : LinkedList<Item>, item : Item)
```

Adds an item to the beginning of the list.

## Function `append`
``` motoko no-repl
func append<Item>(list : LinkedList<Item>, item : Item)
```

Adds an item to the end of the list.

## Function `get_opt`
``` motoko no-repl
func get_opt<Item>(list : LinkedList<Item>, i : Nat) : ?Item
```

Returns the item at the specified index or null if the index is out of bounds.

## Function `get`
``` motoko no-repl
func get<Item>(list : LinkedList<Item>, i : Nat) : Item
```

Returns the item at the specified index or traps if the index is out of bounds.

## Function `insert`
``` motoko no-repl
func insert<Item>(list : LinkedList<Item>, i : Nat, item : Item)
```

Inserts an item at the specified index.

## Function `remove`
``` motoko no-repl
func remove<Item>(list : LinkedList<Item>, i : Nat) : Item
```

Removes the item at the specified index.

## Function `replace`
``` motoko no-repl
func replace<Item>(list : LinkedList<Item>, i : Nat, item : Item) : Item
```

Replaces the item at the specified index with a new item and returns the replaced item.

## Function `put`
``` motoko no-repl
func put<Item>(list : LinkedList<Item>, i : Nat, item : Item)
```

Sets the item at the specified index.

## Function `find_index`
``` motoko no-repl
func find_index<Item>(list : LinkedList<Item>, item : Item, isEq : (Item, Item) -> Bool) : ?Nat
```

Returns the index of the first item that matches the given item or null if no item matches.

## Function `map`
``` motoko no-repl
func map<Item>(list : LinkedList<Item>, fn : (Item) -> Item)
```

Updates the list by applying the given function to each item.

## Function `clear`
``` motoko no-repl
func clear<Item>(list : LinkedList<Item>)
```

Removes all items from the list.

## Function `vals`
``` motoko no-repl
func vals<Item>(list : LinkedList<Item>) : Iter<Item>
```

Returns an iterator over the items in the list.

## Function `nodes`
``` motoko no-repl
func nodes<Item>(list : LinkedList<Item>) : Iter<Node<Item>>
```

Returns an iterator over the nodes in the list.

## Function `prepend_list`
``` motoko no-repl
func prepend_list<Item>(list : LinkedList<Item>, other : LinkedList<Item>)
```


## Function `append_list`
``` motoko no-repl
func append_list<Item>(list : LinkedList<Item>, other : LinkedList<Item>)
```


## Function `insert_list`
``` motoko no-repl
func insert_list<Item>(list : LinkedList<Item>, i : Nat, other : LinkedList<Item>)
```


## Function `isEmpty`
``` motoko no-repl
func isEmpty<Item>(list : LinkedList<Item>) : Bool
```

Returns `true` if the list is empty, `false` otherwise.

## Function `fromArray`
``` motoko no-repl
func fromArray<Item>(arr : [Item]) : LinkedList<Item>
```

Creates a new linked list from an array.

## Function `toArray`
``` motoko no-repl
func toArray<Item>(list : LinkedList<Item>) : [Item]
```

Converts the list to an array.
