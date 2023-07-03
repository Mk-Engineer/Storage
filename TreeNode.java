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

		//Tree
        TreeNode leftgrandson = new TreeNode(1);
        TreeNode rightgrandson = new TreeNode(2);
        TreeNode leftson = new TreeNode(4,leftgrandson,rightgrandson);
        TreeNode rightson = new TreeNode(6);
        TreeNode tree = new TreeNode(5,leftson,rightson);
		
		//Binary Tree
		TreeNode bleftgrandson = new TreeNode(15);
        TreeNode brightgrandson = new TreeNode(7);
        TreeNode bleftson = new TreeNode(9);
		TreeNode brightson = new TreeNode(20,bleftgrandson,brightgrandson);       
        TreeNode btree = new TreeNode(3,bleftson,brightson);

        //
        Solution0 slt0 = new Solution0();
        List result0 = slt0.preorderTraversal(tree);
        System.out.println("PREORDER: " + Arrays.toString(result0.toArray()));

        Solution1 slt1 = new Solution1();
        List result1 = slt1.inorderTraversal(tree);
        System.out.println("INORDER: " + Arrays.toString(result1.toArray()));

        Solution2 slt2 = new Solution2();
        List result2 = slt2.postorderTraversal(tree);
        System.out.println("POSTORDER: " + Arrays.toString(result2.toArray()));
        System.out.println(); 

        //
        Solution3 slt3 = new Solution3();
        List result3 = slt3.preorderTraversal(tree);
        System.out.println("preorder: " + Arrays.toString(result3.toArray()));

        Solution4 slt4 = new Solution4();
        List result4 = slt4.inorderTraversal(tree);
        System.out.println("inorder: " + Arrays.toString(result4.toArray()));
    
        Solution5 slt5 = new Solution5();
        List result5 = slt5.postorderTraversal(tree);
        System.out.println("postorder: " + Arrays.toString(result5.toArray()));
        System.out.println();

        //
        Solution6 slt6 = new Solution6();
        List result6 = slt6.preorderTraversal(tree);
        System.out.println("Preorder: " + Arrays.toString(result6.toArray()));
    
        Solution7 slt7 = new Solution7();
        List result7 = slt7.inorderTraversal(tree);
        System.out.println("Inorder: " + Arrays.toString(result7.toArray()));
        
        Solution8 slt8 = new Solution8();
        List result8 = slt8.postorderTraversal(tree);
        System.out.println("Postorder: " + Arrays.toString(result8.toArray()));
        System.out.println();

		//
		Solution9 slt9 = new Solution9();
		List<List<Integer>> result9 = slt9.levelOrder(btree);
        System.out.println("LevelOrder: " + Arrays.toString(result9.toArray()));       
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
