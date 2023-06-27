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

        TreeNode leftgrandson = new TreeNode(1);
        TreeNode rightgrandson = new TreeNode(2);
        TreeNode leftson = new TreeNode(4,leftgrandson,rightgrandson);
        TreeNode rightson = new TreeNode(6);
        TreeNode tree = new TreeNode(5,leftson,rightson);

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
          
       }

       return result;
    }
}
