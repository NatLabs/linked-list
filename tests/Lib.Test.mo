import Debug "mo:base/Debug";
import {test} "mo:test";
import LinkedList "../src";

test("create linked list", func() {
    let list = LinkedList.LinkedList<Nat>();

    LinkedList.append(list, 1);
    LinkedList.append(list, 2);
    LinkedList.append(list, 3);

    assert LinkedList.size(list) == 3;
    assert LinkedList.toArray(list) == [1, 2, 3];
});

test("populate list with externally created nodes", func() {
    let list = LinkedList.LinkedList<Nat>();

    let node1 = LinkedList.Node<Nat>(1);
    let node2 = LinkedList.Node<Nat>(2);
    let node3 = LinkedList.Node<Nat>(3);

    LinkedList.append_node(list, node3);
    LinkedList.prepend_node(list, node1);
    LinkedList.insert_node(list, 1, node2);

    assert LinkedList.size(list) == 3;
    assert LinkedList.get(list, 0) == 1;
    assert LinkedList.get(list, 1) == 2;
    assert LinkedList.get(list, 2) == 3;
});