import java.text.SimpleDateFormat;

//单链表
class ListNode {
    int val;
    ListNode next;
    ListNode(){}
    ListNode(int val) {
        this.val=val;
    }
}
class MyLinkedList {
    //size存储链表元素的个数
    int size;
    //虚拟头结点
    ListNode head;

    //初始化链表
    public MyLinkedList() {
        this.size = 0;
        this.head = new ListNode(0);
    }

    //获取第index个节点的数值，注意index是从0开始的，第0个节点就是头结点
    public int get(int index) {
        //如果index非法，返回-1
        if(index >= size || index < 0) {
            return -1;
        }
        ListNode cur = this.head;
    
        for(int i = 0; i <= index; i++) {
            cur = cur.next;
        }
        return cur.val;
    }

    //在链表最前面插入一个节点，等价于在第0个元素前添加
    public void addAtHead(int val) {
        addAtIndex(0, val);
    }

    //在链表的最后插入一个节点，等价于在(末尾+1)个元素前添加
    public void addAtTail(int val) {
        addAtIndex(size,val);
    }

    // 在第 index 个节点之前插入一个新节点，例如index为0，那么新插入的节点为链表的新头节点。
    // 如果 index 等于链表的长度，则说明是新插入的节点为链表的尾结点
    // 如果 index 大于链表的长度，则返回空
    public void addAtIndex(int index, int val) {
        //找到要插入节点的前驱
        if(index > size) {
            return;
        }

        if(index < 0) {
            index = 0;
        }
        size++;
        //找到节点
        ListNode pre = head;
        for(int i = 0;i < index;i++) {
            pre = pre.next;
        }
        //新建节点
        ListNode newNode = new ListNode(val);
        newNode.next = pre.next;
        pre.next = newNode;

    }

    //删除第index个节点
    public void deleteAtIndex(int index) {
        if(index < 0 || index >= size) {
            return;
        }
        size--;
        if(index == 0) {
            head = head.next;
            return;
        }
        ListNode pred = head;
        for(int i = 0; i < index;i++) {
            pred = pred.next;
        }
        pred.next = pred.next.next;
    }

    //插入节点
    public void insertAtIndex(int index,ListNode node) {
        if(index < 0 || index >= size) {
            return;
        }

        ListNode pred = head;
        for(int i = 0; i < index;i++) {
            pred = pred.next;
        }

        node.next = pred.next;
        pred.next = node;

        size++;
    }
}

// class ListNodeDuo {
//     int val;
//     ListNodeDuo next,prev;
//     ListNodeDuo(){}
//     ListNodeDuo(int val) {
//         this.val = val;
//     }
// }

// class MyLinkedListDuo {
//     //记录链表中元素的数量
//     int size;
//     //记录链表的虚拟头节点和尾节点
//     ListNodeDuo head,tail;

//     public MyLinkedListDuo(){
//         //初始化操作
//         this.size = 0;
//         this.head = new ListNodeDuo(0);
//         this.tail = new ListNodeDuo(0);

//         head.next = tail;
//         tail.prev = head;
//     }

//     public int get(int index) {
//         if(index < 0 || index >= size) {
//             return -1;
//         }

//         ListNodeDuo cur = this.head;

//         //判断哪一边遍历时间更短
//         if(index >= size/2) {
//             //从tail开始
//             cur = tail;
//             for(int i = 0;i < size-index;i++) {
//                 cur = cur.prev;
//             }
//         } else {
//             for(int i = 0;i <= index;i++) {
//                 cur = cur.next;
//             }
//         }
//         return cur.val;
//     }

//     public void addAtHead(int val) {
//         addAtIndex(0,val);
//     }

//     public void addAtTail(int val) {
//         addAtIndex(size,val);
//     }

//     public void addAtIndex(int index,int val) {
//         //index大于链表长度
//         if(index > size) {
//             return;
//         }

//         //index小于0
//         if(index < 0) {
//             index = 0;
//         }
//         size++;
//         //找到前驱
//         ListNodeDuo prev = this.head;
//         for(int i = 0; i < index; i++) {
//             prev = prev.next;
//         }
//         //新建节点
//         ListNodeDuo newNode = new ListNodeDuo(val);
//         newNode.next = prev.next;//tail无next
//         prev.next.prev = newNode;
//         newNode.prev = prev;
//         prev.next = newNode;
//     }
//     public void deleteAtIndex(int index) {
//         if(index < 0 || index >= size) {
//             return;
//         }

//         size--;
//         ListNodeDuo prev = this.head;
//         for(int i = 0;i < index; i++) {
//             prev = prev.next;
//         }
//         prev.next.next.prev = prev;
//         prev.next = prev.next.next;
//     }
// }

class Solution {
    /**
     * 链表两两交换
     * @param head
     * @return
     */
    //方法一
    public ListNode swapPairs(ListNode h) {
        // System.out.println("public ListNode swapPairs(ListNode head) :");
        
        if(h == null || h.next == null) return h;

        //获取当前节点的下一节点
        ListNode nxt = h.next;
        //进行递归
        ListNode newNode = swapPairs(nxt.next);
        //进行交换
        nxt.next = h;
        h.next = newNode;

        return nxt;
    }
    //方法二
    public ListNode swapPair(ListNode h) {
        ListNode dummyhead = new ListNode(-1);
        dummyhead.next = h;

        ListNode cur = dummyhead;
        ListNode temp;
        ListNode first;
        ListNode second;

        while(cur.next != null && cur.next.next != null) {
                temp = cur.next.next.next;
                first = cur.next;
                second = cur.next.next;

                cur.next = second;
                second.next = first;
                first.next = temp;

                cur = first;
        }

        return dummyhead.next;
    }


    /**
     * 反转链表
     * @param head
     * @return
     */
    //方法一：从后向前递归
    ListNode reverseList(ListNode head) {
        //边缘条件判断
        if(head == null) return null;
        if(head.next == null) return head;

        //
        ListNode last = reverseList(head.next);//head = head.next
        //
        head.next.next = head;
        //
        head.next = null;
        
        return last;
    }
    //方法二：双指针
    public ListNode reverseList0(ListNode head) {
        //初始化
        ListNode prev = null;
        ListNode cur = head;
        ListNode temp = null;

        while(cur != null) {
            temp = cur.next;
            cur.next = prev;
            prev = cur;
            cur = temp;
        }
        return prev;//最后一个值是新的头节点
    }
    //方法三：递归
    public ListNode reverseList1(ListNode head) {
        return reverse(null,head);
    }
    private ListNode reverse(ListNode prev, ListNode cur) {
        if(cur == null) {//递归终止条件
            return prev;
        }

        ListNode temp = null;
        temp = cur.next;
        cur.next = prev;

        //prev = cur;
        //cur = temp;
        return reverse(cur,temp);
    }


    /**
     * 删除倒数第n个节点
     * @param head
     * @param n
     * @return
     */
    public ListNode removeNthFromEnd(ListNode head, int n) {
        ListNode dummy = new ListNode(0);
        dummy.next = head;

        ListNode fast = dummy;
        ListNode slow = dummy;

        for(int i = 0; i < n; i++) {
            fast = fast.next;
        }

        while(fast.next != null) {
            fast = fast.next;
            slow = slow.next;
        }

        slow.next = slow.next.next;

        return dummy.next;
    }

    /**
     * 求两个相交链表的交点
     * @param headA
     * @param headB
     * @return
     */
    public ListNode getIntersectionNode(ListNode headA, ListNode headB) {
        ListNode curA = headA;
        ListNode curB = headB;
        int lenA = 0, lenB = 0;

        //求链表A长度
        while (curA != null) {
            lenA++;
            curA = curA.next;
        }

        //求链表B长度
        while (curB != null) {
            lenB++;
            curB = curB.next;
        }

        curA = headA;
        curB = headB;

        //让curA为最长链表的头，lenA为其长度
        if(lenB > lenA) {
            //1. swap(lenA,lenB);
            int tmpLen = lenA;
            lenA = lenB;
            lenB = tmpLen;

            //2. swap(curA,curB);
            ListNode tempNode = curA;
            curA = curB;
            curB = tempNode;
        }

        //求长度差
        int gap = lenA - lenB;

        //让curA和curB在同一起点
        while (gap-- > 0) {
            curA = curA.next;
        }

        //遍历curA和curB，遇到相同则直接返回
        while(curA != null){
            if(curA == curB) {
                return curA;
            }
            curA = curA.next;
            curB = curB.next;
        }

        return null;
    }


    /**
     * 环形链表
     * @param head
     * @return
     */
    public ListNode detectCycle(ListNode head) {
        ListNode slow = head;
        ListNode fast = head;

        while(fast != null && fast.next != null) {
            slow = slow.next;//slow走1格
            fast = fast.next.next;//fast走两格

            if(slow == fast) {//有环
                ListNode index1 = fast;
                ListNode index2 = head;
                //两个指针，从头节点和相遇节点，各走一步，直到相遇，相遇点即为环入口
                while(index1 != index2) {
                    index1 = index1.next;
                    index2 = index2.next;
                }
                return index1;
            }
        }

        return null;        
    }
}

public class MyLinkedListTest {
    /*
    public static void main(String[] args) {
        System.out.println("Hello MyLinked List !" + System.currentTimeMillis());
        System.out.println();

        MyLinkedList list = new MyLinkedList();
        Solution slt = new Solution();

        list.addAtHead(65);
        list.addAtIndex(1, 66);
        list.addAtIndex(2, 67);
        list.addAtIndex(3, 68);
        list.addAtIndex(4, 69);
        list.addAtIndex(5, 70);
        list.addAtIndex(6, 71);
        
        System.out.println("head:" + list.head.val);
        System.out.println("list[0]:" + list.get(0));
        System.out.println("size:" + list.size);
        
        System.out.println();

        System.out.println("before:");
        for(int i = 0;i < list.size;i++) {
            System.out.println("list[" + i + "]: " + list.get(i));
        }

        System.out.println();

        System.out.println("after:");
        System.out.println("head:"+list.head.val);

        // ListNode nxt = slt.swapPair(list.head);
        // System.out.println("return: " + nxt.val);
        ListNode h = slt.removeNthFromEnd(list.head,3);
        System.out.println("head: " + h);
        for(int i = 0;i < list.size;i++) {
            System.out.println("list[" + i + "]: " + list.get(i));
        }

        // ListNode last = slt.reverseList(list.head);
        // System.out.println("last:" + last.val);
        // System.out.println("head:" + list.head.val);
        // System.out.println("list[5]" + list.get(5));
        // System.out.println("list[0]" + list.get(0));
        
        // NullPointException:
        //      cur = cur.next; //null
        // for(int i = 0;i < list.size;i++) {
        //     System.out.println(list.get(i));
        // }
    }
    */
    /* 
    public static void main(String[] args) {
        System.out.println("Hello MyLinked List !" + System.currentTimeMillis());
        System.out.println();

        Solution slt = new Solution();
        
        //list1
        MyLinkedList list1 = new MyLinkedList();
        list1.addAtHead(65);
        list1.addAtIndex(1, 66);//next
        list1.addAtIndex(2, 67);//next
        list1.addAtIndex(3, 68);//next
        list1.addAtIndex(4, 69);//交点
        list1.addAtIndex(5, 70);
        list1.addAtIndex(6, 71);

        System.out.println("head:" + list1.head.val);
        System.out.println("list1[0]:" + list1.get(0));
        System.out.println("size:" + list1.size);
        System.out.println();
        for(int i = 0;i < list1.size;i++) {
            System.out.println("list1[" + i + "]: " + list1.get(i));
        }
        System.out.println();


        //list2
        MyLinkedList list2 = new MyLinkedList();
        list2.addAtHead(101);
        list2.addAtIndex(1, 102);//交点
        list2.addAtIndex(2, 103);

        //插入动作
        list1.insertAtIndex(3, list2.head.next.next);

        System.out.println("After List1:");
        System.out.println("List1 size:" + list1.size);
        for(int i = 0;i < list1.size;i++) {
            System.out.println("list1[" + i + "]: " + list1.get(i));
        }
        System.out.println();
        
        ListNode node2 = list2.head;
        System.out.println("list2:");
        System.out.println("List2 size:" + list2.size);
        while(node2.next != null) {
            node2 = node2.next;
            System.out.println(node2.val);
        }

        ListNode sameNode = slt.getIntersectionNode(list2.head, list1.head);
        System.out.println("sameNode is:" + sameNode.val);
        System.out.println();

    }
    */
    public static void main(String[] args) {
        System.out.println("Hello MyLinked List !" + System.currentTimeMillis());
        System.out.println();

        Solution slt = new Solution();

        //list
        MyLinkedList list = new MyLinkedList();
        list.addAtHead(65);//next[0]
        list.addAtIndex(1, 66);//next[1]
        list.addAtIndex(2, 67);//next[2]
        list.addAtIndex(3, 68);//next[3]
        list.addAtIndex(4, 69);//next[4]
        list.addAtIndex(5, 70);//next[5]
        list.addAtIndex(6, 71);//next[6]

        //遍历链表
        System.out.println("list size:" + list.size);
        for(int i = 0;i < list.size;i++) {
            System.out.println("list[" + i + "]: " + list.get(i));
        }
        System.out.println();

        ListNode tail = list.head.next.next.next.next.next.next.next;
        ListNode nxt3 = list.head.next.next.next.next;

        System.out.println("head: " + list.head.val);
        System.out.println("head.next: " + list.head.next.val);
        System.out.println("tail: " + tail.val);
        System.out.println("next[3]: " + nxt3.val);
        System.out.println();

        tail.next = nxt3;
        
        System.out.println("After Cycle");
        ListNode node = list.head;

        ListNode cyc = slt.detectCycle(node);
        System.out.println("Cycle Entrance: " + cyc.val);

        // while(node.next != null) {
        //     node = node.next;
        //     System.out.println(node.val);
        // }
    }
}