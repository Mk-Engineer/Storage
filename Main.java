import java.util.Scanner;

/**
 * 
 * 容量小的数据类型与容量大的数据类型做运算时，自动升为大容量类型
 * byte/char/short --> int --> long --> float --> double ---> String
 * 特别地：当byte、char、short三种类型做运算时，结果为int型
 *                                                                                                                                                                  
*/
public class Main
{
    public static void main(String[] args) 
    {       
        while(true) {
            Scanner in = new Scanner(System.in);
            System.out.print("输入n: ");
            int n = in.nextInt();
            long startTime = System.currentTimeMillis();

            // function1(n);
            // function2(n);
            // function3(n);
            System.out.println("Result:" + fibonacci2(0,1,n));
            System.out.println();

            long endTime = System.currentTimeMillis();
            long costTime = endTime - startTime;
            System.out.println("算法耗时 == " + costTime + "ms");
        }
        // System.out.println();
        // System.out.println("MMMMMMMMMMMMMMMMMMMNMMMMMMMMMMMMMMMMMMMM");
        // System.out.println("MMMMMMMMMMMM8ZZZZZZZZZZZZZZMMMMMMMMMMMMM");
        // System.out.println("MMMMMMMMM$ZZZZZZZZZZZZZZZZZZZZMMMMMMMMMM");
        // System.out.println("MMMMMMMZZZZZZZZZZZZZZZZZZZZZZZZZMMMMMMMM");
        // System.out.println("MMMMMMZZZZZZZZZZZZZZZZZZZZZZZZZZZZMMMMMM");
        // System.out.println("MMMMNZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZMMMMM");
        // System.out.println("MMMMZZZZZZZZZZZZZZZZZZZ~.....,ZZZZZZMMMM");
        // System.out.println("MMMZZZZZZZZZZO,..............ZZZZZZZZMMM");
        // System.out.println("MMZZZZZZ~................ZZZZZZZZZZZZNMM");
        // System.out.println("MMZZZZZZ,.......Z$ZZZZ...ZZZZZZZZZZZZZMM");
        // System.out.println("MZZZZZZZZZZZZ...$ZZZZZ...ZZZZZZZZZZZZZMM");
        // System.out.println("MZZZZZZZZZZZZ...$ZZZZZ...ZZZZZZZZZZZZZMM");
        // System.out.println("MZZZZZZZZZZZZ...$ZZZZZ...ZZZZZZZZZZZZZMM");
        // System.out.println("MZZZZZZZZZZZZ...$ZZZZZ...ZZZZZZZZZZZZZMM");
        // System.out.println("MMZZZZZZZZZZZ...$ZZZZ$...ZZZZZZZZZZZZZMM");
        // System.out.println("MMZZZZZZZZZZZ...$ZZZZZ...,ZZZZZZZZZZZZMM");
        // System.out.println("MMMZZZZZZZZZZ...$ZZZZZZ...=OZZZZZZZZZMMM");
        // System.out.println("MMMZZZZZZZZZZ...ZZZZZZZZ...$ZZZZZZZZMMMM");
        // System.out.println("MMMMZZZZZZZZZ?:OZZZZZZZZ=.,:ZZZZZZZZMMMM");
        // System.out.println("MMMMMZZZZZZZZZZZZZZZZZZZZZZZZZZZZZMMMMMM");
        // System.out.println("MMMMMMMZZZZZZZZZZZZZZZZZZZZZZZZZZMMMMMMM");
        // System.out.println("MMMMMMMMMZZZZZZZZZZZZZZZZZZZZZZMMMMMMMMM");
        // System.out.println("MMMMMMMMMMM$ZZZZZZZZZZZZZZZZNMMMMMMMMMMM");
        // System.out.println("MMMMMMMMMMMMMMMZZZZZZZZZMMMMMMMMMMMMMMMM");
        // System.out.println("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
        // System.out.println();
        
    }

    // O(n)
    public static void function1(long n) {
        System.out.println("O(n)");
        long k = 0;
        for (long i = 0; i < n; i++) {
            k++;
        }
    }
    
    // O(n^2)
    public static void function2(long n) {
        System.out.println("O(n^2)");
        long k = 0;
        for (long i = 0; i < n; i++) {
            for (long j = 0; j < n; j++) {
                k++;
            }
        }
    }
    
    /**
     * 基本操作的执行次数与n的关系：
     *  2^(执行次数) = n
     *  执行次数 = logn
     *  
     *  O(nlogn)
     */
    // O(nlogn)
    public static void function3(long n) {
        System.out.println("O(nlogn)");
        long k = 0;
        for (long i = 0; i < n; i++) {
            for (long j = 1; j < n; j = j*2) { // 注意这里j=1
                k++;
            }
        }
    }

    //斐波那契数列
    public static int fibonacci1(int i) {
        if(i <= 0) return 0;
        if(i == 1) return 1;
        return fibonacci1(i-1) + fibonacci1(i-2);
    }
    
    public static int fibonacci2(int first, int second, int n) {
        if (n <= 0) {
            return 0;
        }
        if (n < 3) {
            return 1;
        }
        else if (n == 3) {
            return first + second;
        }
        else {
            return fibonacci2(second, first + second, n - 1);
        }
    }

    /**
     * #二分查找-递归实现
     * 
     * @param arr 待查找数列
     * @param l   左边界脚标
     * @param r   右边界脚标
     * @param x   待查找值
     * @return    待查找值的脚标
     */
    public static int binary_search( int arr[], int l, int r, int x) {
        if (r >= l) {
            int mid = l + (r - l) / 2;
            if (arr[mid] == x)
                return mid;
            if (arr[mid] > x)
                return binary_search(arr, l, mid - 1, x);
            //if(arr[mid] < x)    
            return binary_search(arr, mid + 1, r, x);
        }
        return -1;
    }
	
	//二分查找
	//1 全闭区间
	public static int search1(int[] nums, int target) {
		if(target < nums[0] || target > nums[nums.length - 1]){
			return -1;
		}

		int left = 0, right = nums.length - 1;
		
		while(left <= right) {
			int mid = left + ((right - left) >> 1);

			if(nums[mid] == target)
				return mid;
			else if(nums[mid] < target)
				left = mid + 1;
			else if(nums[mid] > target)
				right = mid - 1;
		}
		return -1;
	}

	//2 左闭右开
	public static int search2(int[] nums, int target){
		int left = 0, right = nums.length;

		while(left < right) {
			int mid = left + ((right - left) >> 1);
			if(nums[mid] == target)
				return mid;
			else if(nums[mid] < target)
				left = mid + 1;
			else if(nums[mid] > target)
				right = mid;
		}
		return -1;
	}

}


