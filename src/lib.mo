import Array "mo:base/Array";
import Option "mo:base/Option";
import Iter "mo:base/Iter";
import Debug "mo:base/Debug";
import Prelude "mo:base/Prelude";

module {
    type Iter<A> = Iter.Iter<A>;
    public type Node<Item> = {
        var data : Item;

        var _prev : ?Node<Item>;
        var _next : ?Node<Item>;
    };

    /// Creates a new node with the given data.
    public func Node<Item>(data : Item) : Node<Item> {
        {
            var data = data;

            var _prev = null;
            var _next = null;
        };
    };

    private module NodeModule = {
        public func link<Item>(ref : Node<Item>, node : Node<Item>) {
            node._prev := ?ref;
            ref._next := ?node;
        };

        public func remove<Item>(node : Node<Item>) {
            ignore do ? {
                node._prev!._next := node._next;
            };

            ignore do ? {
                node._next!._prev := node._prev;
            };

            node._prev := null;
            node._next := null;
        };
    };

    public type LinkedList<Item> = {
        var _head : ?Node<Item>;
        var _tail : ?Node<Item>;
        var _size : Nat;
    };

    /// Creates an empty linked list.
    public func LinkedList<Item>() : LinkedList<Item> {
        {
            var _head = null;
            var _tail = null;
            var _size = 0;
        };
    };

    /// Returns the size of the list.
    public func size<Item>(list : LinkedList<Item>) : Nat {
        list._size;
    };

    /// Returns the data stored in the given node.
    public func node_data<Item>(node : Node<Item>) : Item {
        node.data;
    };

    /// Updates the data stored in the given node.
    public func set_node_data<Item>(node : Node<Item>, data : Item) {
        node.data := data;
    };

    /// Adds a node to the beginning of the list.
    public func prepend_node<Item>(list : LinkedList<Item>, node : Node<Item>) {
        switch (list._head) {
            case (null) {
                list._head := ?node;
                list._tail := ?node;
            };
            case (?head) {
                NodeModule.link(node, head);
                list._head := ?node;
            };
        };

        list._size += 1;
    };

    /// Adds a node to the end of the list.
    public func append_node<Item>(list : LinkedList<Item>, node : Node<Item>) {
        switch (list._tail) {
            case (null) {
                list._head := ?node;
                list._tail := ?node;
            };
            case (?tail) {
                NodeModule.link(tail, node);
                list._tail := ?node;
            };
        };

        list._size += 1;
    };

    /// Remove the given node from the list.
    public func remove_node<Item>(list : LinkedList<Item>, node : Node<Item>) {

        if (Option.isNull(node._prev)) {
            list._head := node._next;
        };

        if (Option.isNull(node._next)) {
            list._tail := node._prev;
        };

        NodeModule.remove(node);
        list._size -= 1;
    };

    /// Returns the node at the specified index or null if the index is out of bounds.
    public func get_node_opt<Item>(list : LinkedList<Item>, i : Nat) : ?Node<Item> {
        if (i >= list._size) {
            return null;
        };

        let trav_from_head = i <= list._size / 2;

        do ? {
            var node : ?Node<Item> = null;

            if (trav_from_head) {
                node := list._head;

                for (_ in Iter.range(1, i)) {
                    node := node!._next;
                };
            } else {
                node := list._tail;
                for (_ in Iter.range(1, list._size - i - 1)) {
                    node := node!._prev;
                };
            };

            node!;
        };
    };

    /// Returns the node at the specified index or traps if the index is out of bounds.
    public func get_node<Item>(list : LinkedList<Item>, i : Nat) : Node<Item> {
        switch (get_node_opt(list, i)) {
            case (?node) node;
            case (_) Debug.trap("LinkedList: Index out of bounds");
        };
    };

    /// Inserts a node at the specified index.
    public func insert_node<Item>(list : LinkedList<Item>, i : Nat, node : Node<Item>) {
        if (i > list._size) {
            Debug.trap("LinkedList: Index out of bounds");
        };

        if (i == 0) {
            prepend_node(list, node);
        } else if (i == list._size) {
            append_node(list, node);
        } else {
            ignore do ? {
                let prev = get_node(list, (i - 1) : Nat);
                let next = prev._next!;

                NodeModule.link(prev, node);
                NodeModule.link(node, next);

                list._size += 1;
            };
        };
    };

    /// Returns the first node in the list that matches the given item.
    public func find_node<Item>(
        list : LinkedList<Item>,
        item : Item,
        isEq : (Item, Item) -> Bool,
    ) : ?Node<Item> = do ? {
        var node = list._head;

        while (not Option.isNull(node)) {
            if (isEq(node!.data, item)) {
                return node;
            };

            node := node!._next;
        };

        return node;
    };

    /// Adds an item to the beginning of the list.
    public func prepend<Item>(list : LinkedList<Item>, item : Item) {
        let node = Node<Item>(item);
        prepend_node(list, node);
    };

    /// Adds an item to the end of the list.
    public func append<Item>(list : LinkedList<Item>, item : Item) {
        let node = Node<Item>(item);
        append_node(list, node);
    };

    /// Returns the item at the specified index or null if the index is out of bounds.
    public func get_opt<Item>(list : LinkedList<Item>, i : Nat) : ?Item {
        do ? {
            get_node_opt(list, i)!.data;
        };
    };

    /// Returns the item at the specified index or traps if the index is out of bounds.
    public func get<Item>(list : LinkedList<Item>, i : Nat) : Item {
        get_node(list, i).data;
    };

    /// Inserts an item at the specified index.
    public func insert<Item>(list : LinkedList<Item>, i : Nat, item : Item) {
        let node = Node<Item>(item);
        insert_node(list, i, node);
    };

    /// Removes the item at the specified index.
    public func remove<Item>(list : LinkedList<Item>, i : Nat) : Item {
        let node = get_node(list, i);
        remove_node(list, node);
        node.data;
    };

    /// Replaces the item at the specified index with a new item and returns the replaced item.
    public func replace<Item>(list : LinkedList<Item>, i : Nat, item : Item) : Item {
        let node = get_node(list, i);
        let prev_item = node.data;

        node.data := item;
        prev_item;
    };

    /// Sets the item at the specified index.
    public func put<Item>(list : LinkedList<Item>, i : Nat, item : Item) {
        let node = get_node(list, i);
        node.data := item;
    };

    /// Returns the index of the first item that matches the given item or null if no item matches.
    public func find_index<Item>(list : LinkedList<Item>, item : Item, isEq : (Item, Item) -> Bool) : ?Nat {
        var i = 0;

        for (item in vals(list)) {
            if (isEq(item, item)) {
                return ?i;
            };

            i += 1;
        };

        return null;
    };

    /// Updates the list by applying the given function to each item.
    public func map<Item>(list : LinkedList<Item>, fn : (Item) -> Item) {
        for (node in nodes(list)) {
            node.data := fn(node.data);
        };
    };

    /// Removes all items from the list.
    public func clear<Item>(list : LinkedList<Item>) {
        list._head := null;
        list._tail := null;
        list._size := 0;
    };

    /// Returns an iterator over the items in the list.
    public func vals<Item>(list : LinkedList<Item>) : Iter<Item> {
        Iter.map(
            nodes(list),
            func(node : Node<Item>) : Item {
                node.data;
            },
        );
    };

    /// Returns an iterator over the nodes in the list.
    public func nodes<Item>(list : LinkedList<Item>) : Iter<Node<Item>> {
        var node = list._head;

        object {
            public func next() : ?Node<Item> {
                do ? {
                    let curr = node!;
                    node := node!._next;
                    curr;
                };
            };
        };
    };

    public func prepend_list<Item>(list : LinkedList<Item>, other : LinkedList<Item>) {
        if (not isEmpty(other)) {
            switch(list._head){
                case (null) {
                    list._head := other._head;
                    list._tail := other._tail;
                };
                case (?head) {
                    ignore do ? {
                        NodeModule.link(other._tail!, head);
                        list._head := other._head;
                    };
                };
            };

            list._size += other._size;
        };
    };

    public func append_list<Item>(list : LinkedList<Item>, other : LinkedList<Item>) {
        if (not isEmpty(other)) {
            switch(list._tail){
                case (null) {
                    list._head := other._head;
                    list._tail := other._tail;
                };
                case (?tail) {
                    ignore do ? {
                        NodeModule.link(tail, other._head!);
                        list._tail := other._tail;
                    };
                };
            };

            list._size += other._size;
        };
    };

    public func insert_list<Item>(list : LinkedList<Item>, i : Nat, other : LinkedList<Item>) {
        if (not isEmpty(other)) {
            if (i == 0) {
                prepend_list(list, other);
            } else if (i == list._size) {
                append_list(list, other);
            } else {
                let node = get_node(list, i);
                let prev = node._prev;

                ignore do ? {
                    NodeModule.link(prev!, other._head!);
                    NodeModule.link(other._tail!, node);
                    list._size += other._size;
                };
            };
        };
    };

    /// Returns `true` if the list is empty, `false` otherwise.
    public func isEmpty<Item>(list : LinkedList<Item>) : Bool {
        list._size == 0;
    };

    /// Creates a new linked list from an array.
    public func fromArray<Item>(arr : [Item]) : LinkedList<Item> {
        let list = LinkedList<Item>();

        for (item in arr.vals()) {
            append(list, item);
        };

        list;
    };

    /// Converts the list to an array.
    public func toArray<Item>(list : LinkedList<Item>) : [Item] {
        var curr = list._head;

        Array.tabulate(
            list._size,
            func(i : Nat) : Item {
                switch (curr) {
                    case (?node) {
                        let data = node.data;
                        curr := node._next;
                        data;
                    };
                    case (_) Prelude.unreachable();
                };
            },
        );
    };
};
