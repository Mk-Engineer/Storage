import java.util.*;

public class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;

    TreeNode(){}

    TreeNode(int val) {
        this.val = val;
    }

    TreeNode(int val, TreeNode left, TreeNode right) {
        this.val = val;
        this.left = left;
        this.right = right;
    }

    public static void main(String args[]) {
       // System.out.println("Hello TreeNode iSH!");

		//Tree0
        TreeNode leftgrandson0 = new TreeNode(1);
        TreeNode rightgrandson0 = new TreeNode(2);
        TreeNode leftson0 = new TreeNode(4,leftgrandson0,rightgrandson0);
        TreeNode rightson0 = new TreeNode(6);
        TreeNode tree0 = new TreeNode(5,leftson0,rightson0);
		
		//Tree1
		TreeNode leftgrandson1 = new TreeNode(15);
        TreeNode rightgrandson1 = new TreeNode(7);
        TreeNode leftson1 = new TreeNode(9);
		TreeNode rightson1 = new TreeNode(20,leftgrandson1,rightgrandson1);       
        TreeNode tree1 = new TreeNode(3,leftson1,rightson1);

        //Tree2
        TreeNode rightgrandrightson2 = new TreeNode(3);
        TreeNode rightgrandleftson2 = new TreeNode(1);
        TreeNode leftgrandrightson2 = new TreeNode(6);
        TreeNode leftgrandleftson2 = new TreeNode(9);
        TreeNode rightson2 = new TreeNode(7,rightgrandleftson2,rightgrandrightson2);
        TreeNode leftson2 = new TreeNode(2,leftgrandleftson2,leftgrandrightson2);
        TreeNode tree2 = new TreeNode(4,leftson2,rightson2);

        //Tree3
        TreeNode III0_1 = new TreeNode(3);
        TreeNode III0_2 = new TreeNode(4);
        TreeNode III0_3 = new TreeNode(4);
        TreeNode III0_4 = new TreeNode(3);

        TreeNode II0_1 = new TreeNode(2,III0_1,III0_2);
        TreeNode II0_2 = new TreeNode(2,III0_3,III0_4);

        TreeNode tree3 = new TreeNode(1,II0_1,II0_2);

        //Tree4
        TreeNode III1_2 = new TreeNode(3);
        TreeNode III1_4 = new TreeNode(3);

        TreeNode II1_1 = new TreeNode(2,null,III1_2);
        TreeNode II1_2 = new TreeNode(2,null,III1_4);

        TreeNode tree4 = new TreeNode(1,II1_1,II1_2);

        //Tree5
        TreeNode II2_1 = new TreeNode(2);
        TreeNode II2_2 = new TreeNode(3);

        TreeNode tree5 = new TreeNode(1,II2_1,II2_2);

        //Tree6
        TreeNode IIII3_1 = new TreeNode(6);
        TreeNode IIII3_2 = new TreeNode(7);

        TreeNode III3_1 = new TreeNode(4,IIII3_1,IIII3_2);
        TreeNode III3_2 = new TreeNode(5);

        TreeNode II3_1 = new TreeNode(2,III3_1,III3_2);
        TreeNode II3_2 = new TreeNode(3);

        TreeNode tree6 = new TreeNode(1,II3_1,II3_2);

        //Tree7
        TreeNode IIII4_7 = new TreeNode(6);
        TreeNode IIII4_8 = new TreeNode(5);

        TreeNode III4_3 = new TreeNode(4);
        TreeNode III4_4 = new TreeNode(3,IIII4_7,IIII4_8);

        TreeNode II4_2 = new TreeNode(2,III4_3,III4_4);
        
        TreeNode tree7 = new TreeNode(1,null,II4_2);



        //
        Solution0 slt0 = new Solution0();
        List result0 = slt0.preorderTraversal(tree0);
        System.out.println("PREORDER: " + Arrays.toString(result0.toArray()));

        Solution1 slt1 = new Solution1();
        List result1 = slt1.inorderTraversal(tree0);
        System.out.println("INORDER: " + Arrays.toString(result1.toArray()));

        Solution2 slt2 = new Solution2();
        List result2 = slt2.postorderTraversal(tree0);
        System.out.println("POSTORDER: " + Arrays.toString(result2.toArray()));
        System.out.println(); 

        //
        Solution3 slt3 = new Solution3();
        List result3 = slt3.preorderTraversal(tree0);
        System.out.println("preorder: " + Arrays.toString(result3.toArray()));

        Solution4 slt4 = new Solution4();
        List result4 = slt4.inorderTraversal(tree0);
        System.out.println("inorder: " + Arrays.toString(result4.toArray()));
    
        Solution5 slt5 = new Solution5();
        List result5 = slt5.postorderTraversal(tree0);
        System.out.println("postorder: " + Arrays.toString(result5.toArray()));
        System.out.println();

        //
        Solution6 slt6 = new Solution6();
        List result6 = slt6.preorderTraversal(tree0);
        System.out.println("Preorder: " + Arrays.toString(result6.toArray()));
    
        Solution7 slt7 = new Solution7();
        List result7 = slt7.inorderTraversal(tree0);
        System.out.println("Inorder: " + Arrays.toString(result7.toArray()));
        
        Solution8 slt8 = new Solution8();
        List result8 = slt8.postorderTraversal(tree0);
        System.out.println("Postorder: " + Arrays.toString(result8.toArray()));
        System.out.println();

		//
		Solution9 slt9 = new Solution9();
		List<List<Integer>> result9 = slt9.levelOrder(tree1);
        System.out.println("LevelOrder: " + Arrays.toString(result9.toArray()));       
        System.out.println();

        //
        Solution10 slt10 = new Solution10();
        List<List<Integer>> result10 = slt9.levelOrder(tree2);
        System.out.println("Before Invert: " + Arrays.toString(result10.toArray()));
        slt10.invertTree(tree2);
        List<List<Integer>> result11 = slt9.levelOrder(tree2);
        System.out.println("After Invert: " + Arrays.toString(result11.toArray()));
        System.out.println();

        //
        Solution11 slt11 = new Solution11();
        slt11.invertTree(tree2);
        List<List<Integer>> result12 = slt9.levelOrder(tree2);
        System.out.println("Invert Tree: " + Arrays.toString(result12.toArray()));
    
        //
        Solution12 slt12 = new Solution12();
        List<List<Integer>> result13 = slt9.levelOrder(tree3);
        System.out.println("Tree3: " + Arrays.toString(result13.toArray()));
        List<List<Integer>> result14 = slt9.levelOrder(tree4);
        System.out.println("Tree4: " + Arrays.toString(result14.toArray()));

        System.out.println("Tree3 Result1: " + slt12.isSymmetric1(tree3));
        System.out.println("Tree4 Result1: " + slt12.isSymmetric1(tree4));
        System.out.println("Tree3 Result2: " + slt12.isSymmetric2(tree3));
        System.out.println("Tree4 Result2: " + slt12.isSymmetric2(tree4));
        System.out.println("Tree4 Result3: " + slt12.isSymmetric3(tree3));
        System.out.println("Tree4 Result3: " + slt12.isSymmetric3(tree4));
        System.out.println();

        //
        Solution9 slt91 = new Solution9();
        Solution9 slt92 = new Solution9();
        List<List<Integer>> result15 = slt91.levelOrder(tree5);
        List<List<Integer>> result16 = slt92.levelOrder(tree6);
        System.out.println("Tree5: " + Arrays.toString(result15.toArray()));
        System.out.println("Tree6: " + Arrays.toString(result16.toArray()));
        System.out.println();

        //
        Solution13 slt13 = new Solution13();
        System.out.println("Tree4 Depth: " + slt13.maxDepth(tree4));
        System.out.println("Tree5 Depth: " + slt13.maxDepth(tree5));
        System.out.println("Tree6 Depth: " + slt13.maxDepth(tree6));
        System.out.println();

        //
        Solution14 slt14 = new Solution14();
        System.out.println("Tree4 depth: " + slt14.maxDepth(tree4));
        System.out.println("Tree5 depth: " + slt14.maxDepth(tree5));
        System.out.println("Tree6 depth: " + slt14.maxDepth(tree6));
        System.out.println();

        //
        Solution15 slt15 = new Solution15();
        System.out.println("tree4 depth: " + slt15.maxDepth(tree4));
        System.out.println("tree5 depth: " + slt15.maxDepth(tree5));
        System.out.println("tree6 depth: " + slt15.maxDepth(tree6));
        System.out.println();

        //
        Solution9 slt93 = new Solution9();
        List<List<Integer>> result17 = slt93.levelOrder(tree7);
        System.out.println("Tree7: " + Arrays.toString(result17.toArray()));
        System.out.println();

    }
}

//前序遍历：中左右
class Solution0 {
    public List<Integer> preorderTraversal(TreeNode root) {
        List<Integer> result = new ArrayList<Integer>();
        preorder(root, result);

        return result;
    }

    public void preorder(TreeNode root, List<Integer> result) {
        if(root == null) {
            return;
        }
        
        result.add(root.val);
        preorder(root.left, result);
        preorder(root.right,result);

    }
}

//中序遍历：左中右
class Solution1 {
    public List<Integer> inorderTraversal(TreeNode root) {
        List<Integer> result = new ArrayList<Integer>();
        inorder(root,result);
        
        return result;
    }

    public void inorder(TreeNode root, List<Integer> result) {
        if(root == null) {
            return;
        }

        inorder(root.left,result);
        result.add(root.val);
        inorder(root.right,result);
    }
}

//后序遍历：左右中
class Solution2 {
    public List<Integer> postorderTraversal(TreeNode root) {
        List<Integer> result = new ArrayList<Integer>();
        postorder(root,result);

        return result;
    }

    public void postorder(TreeNode root, List<Integer> result) {
        if(root == null) {
            return;
        }

        postorder(root.left,result);
        postorder(root.right,result);
        result.add(root.val);
    }
}


//栈-遍历树

//前序遍历：中左右
//入栈顺序：中右左
class Solution3 {
    public List<Integer> preorderTraversal(TreeNode root) {
        List<Integer> result = new ArrayList<>();
        
        if(root == null) {
            return result;
        }

        Stack<TreeNode> stack = new Stack<>();
        stack.push(root);

        while(!stack.isEmpty()) {
            TreeNode node = stack.pop();
            result.add(node.val);

            if(node.right != null) {
                stack.push(node.right);
            }

            if(node.left != null) {
                stack.push(node.left);
            }
        }
        return result;
    }    
}

//中序遍历：左中右
//入栈顺序：左右
class Solution4 {
    public List<Integer> inorderTraversal(TreeNode root) {
       List<Integer> result = new ArrayList<>();
       
       if(root == null) {
           return result;
       }

       Stack<TreeNode> stack = new Stack<>();
       TreeNode cur = root;

       while(cur != null || !stack.isEmpty()) {
           if(cur != null) {
               stack.push(cur);
               cur = cur.left;
           } else {
               cur = stack.pop();
               result.add(cur.val);
               cur = cur.right;
           }
       }
       return result;
    }
}

//后续遍历：左右中
//入栈顺序：中左右
//出栈顺序：中右左
//翻转最后的结果
class Solution5 {
    public List<Integer> postorderTraversal(TreeNode root) {
        List<Integer> result = new ArrayList<>();

        if(root == null) {
            return result;
        }

        Stack<TreeNode> stack = new Stack<>();
        stack.push(root);

        while(!stack.isEmpty()) {
            TreeNode node = stack.pop();
            result.add(node.val);

            if(node.left != null) {
                stack.push(node.left);
            }

            if(node.right != null) {
                stack.push(node.right);
            }
        }

        Collections.reverse(result);
        return result;
    }
}

//统一迭代法
//PREORDER
//mid left right
class Solution6 {
    public List<Integer> preorderTraversal(TreeNode root) {
        List<Integer> result = new ArrayList<>();
        Stack<TreeNode> st = new Stack<>();

       if(root !=  null){
           st.push(root);
       }

       while(!st.empty()) {
           TreeNode node = st.peek();

           if(node != null) {
               st.pop();// 将该节点弹出，避免重复操作，下面再将右中左节点添加到栈中

               if(node.right != null) {// 添加右节点，空节点不入栈
                   st.push(node.right);
               }

               if(node.left != null) {// 添加左节点，空节点不入栈
                   st.push(node.left);
               }

               st.push(node);// 添加中间节点
               st.push(null);// 中间节点访问过，但是还没有处理，加入空节点作为标记
           } else { // 只有遇到空节点时，才将下一个节点放进结果集
               st.pop();// 将空节点弹出
               node = st.peek();// 重新取出栈中元素
               st.pop();
               result.add(node.val);// 加入到结果集
           }
       }

       return result;
    }
}


//INORDER
//left mid right
class Solution7 {
    public List<Integer> inorderTraversal(TreeNode root) {
        List<Integer> result = new ArrayList<>();
        Stack<TreeNode> st = new Stack<>();

        if(root != null) {
            st.push(root);
        }

        while(!st.empty()) {
           TreeNode node = st.peek();

           if(node != null) {
                st.pop();
               
                if(node.right != null) {
                    st.push(node.right);
                }
               
                st.push(node);
                st.push(null);// 中间节点访问过，但是还没处理，因此做标记

                if(node.left != null) {
                    st.push(node.left);
                }
           } else {
                st.pop();
                node = st.peek();
                st.pop();
                result.add(node.val);
           }
        }

        return result;
    }
}


//POSTORDER
//left right mid
class Solution8 {
    public List<Integer> postorderTraversal(TreeNode root) {
        List<Integer> result = new ArrayList<>();
        Stack<TreeNode> st = new Stack<>();

        if(root != null) {
            st.push(root);
        }

        while(!st.empty()) {
            TreeNode node = st.peek();

            if(node != null) {
                st.pop();

                st.push(node);
                st.push(null);
                
                if(node.right != null) {
                    st.push(node.right);
                }

                if(node.left != null) {
                    st.push(node.left);
                }
            } else {
                st.pop();
                node = st.peek();
                st.pop();
                result.add(node.val);

            }
        }

        return result;
    }
}



//二叉树：层序遍历
class Solution9 {
    public List<List<Integer>> resList = new ArrayList<List<Integer>>();
    
    public List<List<Integer>> levelOrder(TreeNode root) {
        //checkFun01(root,0); 
        checkFun02(root);
    
        return resList;
    }

    //DFS--递归方式
    public void checkFun01(TreeNode node, Integer deep) {
        if(node == null)
            return;

        deep++;

        if(resList.size() < deep) {
            //当层级增加时，list的Item也增加，利用list的索引值进行层级界定
            List<Integer> item = new ArrayList<Integer>();
            resList.add(item);
        }

        resList.get(deep - 1).add(node.val);

        checkFun01(node.left, deep);
        checkFun01(node.right, deep);
    }

    //BFS--迭代方式：借助队列
    public void checkFun02(TreeNode node) {
        if(node == null)
            return;

        Queue<TreeNode> que = new LinkedList<TreeNode>();
        que.offer(node);

        while(!que.isEmpty()) {
            List<Integer> itemList = new ArrayList<Integer>();
            int len = que.size();

            while(len > 0) {
                TreeNode tmpNode = que.poll();
                itemList.add(tmpNode.val);

                if(tmpNode.left != null) {
                    que.offer(tmpNode.left);
                }

                if(tmpNode.right != null) {
                    que.offer(tmpNode.right);
                }

                len--;
            }
            resList.add(itemList);
        }
    }
}


//翻转二叉树
class Solution10 {
    //DFS递归
    public TreeNode invertTree(TreeNode root) {
        if(root == null) {
            return null;
        }

        invertTree(root.left);
        invertTree(root.right);
        swapChildren(root);
        
        return root;
    }

    private void swapChildren(TreeNode root) {
        TreeNode tmp = root.left;
        root.left = root.right;
        root.right = tmp;
    }
}
//BFS
class Solution11 {
    public TreeNode invertTree(TreeNode root) {
        if(root == null) {
            return null;
        }

        ArrayDeque<TreeNode> deque = new ArrayDeque<>();
        deque.offer(root);
        while (!deque.isEmpty()) {
            int size = deque.size();
            while(size-- > 0) {
                TreeNode node = deque.poll();
                swap(node);
                if(node.left != null)
                    deque.offer(node.left);
                if(node.right != null)
                    deque.offer(node.right);
            }
        }
        return root;
    }

    public void swap(TreeNode root) {
        TreeNode temp = root.left;
        root.left = root.right;
        root.right = temp;
    }
}


//对称二叉树
class Solution12 {
    //递归法
    public boolean isSymmetric1(TreeNode root) {
        return compare(root.left,root.right);
    }

    private boolean compare(TreeNode left,TreeNode right) {
        if(left == null && right != null) {
            return false;
        }
        if (left != null && right == null){
            return false;
        }
        if (left == null && right == null) {
            return true;
        }
        if (left.val != right.val) {
            return false;
        }

        //比较外侧
        boolean compareOutside = compare(left.left,right.right);
        //比较内测
        boolean compareInside = compare(left.right,right.left);

        return compareOutside && compareInside;
    }

    /*
     * 迭代法
     * 使用双端队列，相当于两个栈
    */
    public boolean isSymmetric2(TreeNode root) {
        Deque<TreeNode> deque = new LinkedList<>();
        deque.offerFirst(root.left);
        deque.offerLast(root.right);

        while(!deque.isEmpty()) {
            TreeNode leftNode = deque.pollFirst();
            TreeNode rightNode = deque.pollLast();

            if(leftNode == null && rightNode == null) {
                continue;
            }

            if(leftNode == null && rightNode != null) {
                return false;
            }
            
            if(leftNode != null && rightNode == null) {
                return false;
            }
            
            if(leftNode.val != rightNode.val) {
                return false;
            }

            /* 以上三个条件合并 */
            // if(leftNode == null || rightNode == null || leftNode.val != rightNode.val) {
            //     return false;
            // }

            deque.offerFirst(leftNode.left);
            deque.offerFirst(leftNode.right);
            deque.offerLast(rightNode.right);
            deque.offerLast(rightNode.left);
        }

        return true;
    }
    /* 
     * 迭代法      
     * 使用普通队列
     */
    public boolean isSymmetric3(TreeNode root) {
        Queue<TreeNode> deque = new LinkedList<>();
        deque.offer(root.left);
        deque.offer(root.right);

        while(!deque.isEmpty()) {
            TreeNode leftNode = deque.poll();
            TreeNode rightNode = deque.poll();

            if(leftNode == null && rightNode == null) {
                continue;
            }

            if(leftNode == null && rightNode != null) {
                return false;
            }

            if(leftNode != null && rightNode == null) {
                return false;
            }

            if(leftNode.val != rightNode.val) {
                return false;
            }

            deque.offer(leftNode.left);
            deque.offer(rightNode.right);
            deque.offer(leftNode.right);
            deque.offer(rightNode.left);
        }
        
        return true;
    }
}

/*
 * 二叉树：
 * 
 * 深度：从 根节点 到 最远叶子节点 的最长路径上的节点数
 * 高度：从 某节点 到 最远叶子节点 的最长路径上的节点数
 * 
 * 根节点 的 高度 就是 二叉树的最大深度
 * 叶子节点 是指 没有子节点的节点
 * 
*/
class Solution13 {
    //递归法
    public int maxDepth(TreeNode root) {
        if(root == null) {
            return 0;
        }
        int leftDepth = maxDepth(root.left);
        int rightDepth = maxDepth(root.right);

        return Math.max(leftDepth,rightDepth) + 1;
    }
}

class Solution14 {
    int maxnum = 0;

    //递归法
    public int maxDepth(TreeNode root) {
        ans(root,0);
        return maxnum;
    }

    private void ans(TreeNode tr, int tmp) {
        if(tr == null)
            return;
        tmp++;
        maxnum = maxnum < tmp ? tmp : maxnum;
        ans(tr.left,tmp);
        ans(tr.right,tmp);    
        tmp--;
    }
}

class Solution15 {
    //迭代法，使用层序遍历
    public int maxDepth(TreeNode root) {
        if(root == null) {
            return 0;
        }

        Deque<TreeNode> deque = new LinkedList<>();
        deque.offer(root);

        int depth = 0;

        while(!deque.isEmpty()) {
            int size = deque.size();
            depth++;
            for(int i = 0; i < size; i++) {
                TreeNode node = deque.poll();
                if(node.left != null) {
                    deque.offer(node.left);
                }
                if(node.right != null) {
                    deque.offer(node.right);
                }
            }
        }

        return depth;
    }
}

/* N叉树的最大深度 */


/*
 * 二叉树的最小深度
 * 最小深度是从 根节点 到最近 叶子节点 的最短路径上的节点数量
*/
class Solution16 {
    //递归法
    
    //迭代法

}