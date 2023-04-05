// import java.util.Arrays;
// import java.util.Scanner;
import java.util.*;

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
        // while(true) {
        //     Scanner in = new Scanner(System.in);
        //     System.out.print("输入n: ");
        //     int n = in.nextInt();
        //     long startTime = System.currentTimeMillis();

        //     // function1(n);
        //     // function2(n);
        //     // function3(n);
        //     System.out.println("Result:" + fibonacci2(0,1,n));
        //     System.out.println();

        //     long endTime = System.currentTimeMillis();
        //     long costTime = endTime - startTime;
        //     System.out.println("算法耗时 == " + costTime + "ms");
        // }

        

        /* Remove Arr Elements */
        // int[] arr = new int[]{6,3,3,5,6,5,9,8};
        // System.out.println(Arrays.toString(arr));
        // System.out.println();
        
        // // int index1 = removeElement1(arr,5);
        // // System.out.println("removeElement1:" + index1);
        // // System.out.println(Arrays.toString(arr));
        // // System.out.println();
        
        // int index2 = removeElement2(arr,5);
        // System.out.println("removeElement2:"+ index2);
        // System.out.println(Arrays.toString(arr));
        // System.out.println();



        //#HashSetTest
        int[] arr1 = new int[]{4,9,5};
        int[] arr2 = new int[]{9,4,9,8,4};
        intersection(arr1,arr2);



        /* SYMBOL */
        System.out.println();
        System.out.println("SAMPING:" + System.currentTimeMillis());
        System.out.println();
        System.out.println("MMMMMMMMMMMMMMMMMMMNMMMMMMMMMMMMMMMMMMMM");
        System.out.println("MMMMMMMMMMMM8ZZZZZZZZZZZZZZMMMMMMMMMMMMM");
        System.out.println("MMMMMMMMM$ZZZZZZZZZZZZZZZZZZZZMMMMMMMMMM");
        System.out.println("MMMMMMMZZZZZZZZZZZZZZZZZZZZZZZZZMMMMMMMM");
        System.out.println("MMMMMMZZZZZZZZZZZZZZZZZZZZZZZZZZZZMMMMMM");
        System.out.println("MMMMNZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZMMMMM");
        System.out.println("MMMMZZZZZZZZZZZZZZZZZZZ~.....,ZZZZZZMMMM");
        System.out.println("MMMZZZZZZZZZZO,..............ZZZZZZZZMMM");
        System.out.println("MMZZZZZZ~................ZZZZZZZZZZZZNMM");
        System.out.println("MMZZZZZZ,.......Z$ZZZZ...ZZZZZZZZZZZZZMM");
        System.out.println("MZZZZZZZZZZZZ...$ZZZZZ...ZZZZZZZZZZZZZMM");
        System.out.println("MZZZZZZZZZZZZ...$ZZZZZ...ZZZZZZZZZZZZZMM");
        System.out.println("MZZZZZZZZZZZZ...$ZZZZZ...ZZZZZZZZZZZZZMM");
        System.out.println("MZZZZZZZZZZZZ...$ZZZZZ...ZZZZZZZZZZZZZMM");
        System.out.println("MMZZZZZZZZZZZ...$ZZZZ$...ZZZZZZZZZZZZZMM");
        System.out.println("MMZZZZZZZZZZZ...$ZZZZZ...,ZZZZZZZZZZZZMM");
        System.out.println("MMMZZZZZZZZZZ...$ZZZZZZ...=OZZZZZZZZZMMM");
        System.out.println("MMMZZZZZZZZZZ...ZZZZZZZZ...$ZZZZZZZZMMMM");
        System.out.println("MMMMZZZZZZZZZ?:OZZZZZZZZ=.,:ZZZZZZZZMMMM");
        System.out.println("MMMMMZZZZZZZZZZZZZZZZZZZZZZZZZZZZZMMMMMM");
        System.out.println("MMMMMMMZZZZZZZZZZZZZZZZZZZZZZZZZZMMMMMMM");
        System.out.println("MMMMMMMMMZZZZZZZZZZZZZZZZZZZZZZMMMMMMMMM");
        System.out.println("MMMMMMMMMMM$ZZZZZZZZZZZZZZZZNMMMMMMMMMMM");
        System.out.println("MMMMMMMMMMMMMMMZZZZZZZZZMMMMMMMMMMMMMMMM");
        System.out.println("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
        System.out.println();
        
    }


    //#时间复杂度
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



    //#斐波那契数列
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



    //#移除数组中的元素
    //1 快慢双指针法
    public static int removeElement1(int[] nums, int val) {
        int slowIndex = 0;
        for(int fastIndex = 0; fastIndex < nums.length; fastIndex++) {
            if(nums[fastIndex] != val) {
                nums[slowIndex] = nums[fastIndex];
                slowIndex++;
            }
            // else if(nums[fastIndex] = val) {
            //     //nums[slowIndex] = val;
            //     //slowIndex : stay
            // }
        }

        return slowIndex;
    }

    //2 相向双指针法
    public static int removeElement2(int[] nums, int val) {
        int left = 0;
        int right = nums.length - 1;

        while(right >= 0 && nums[right] == val) 
            right--;//将right移到从右数第一个值不为val的位置

        while(left <= right) {
            if(nums[left] == val) {//left位置的元素需要移除
                //将right位置的元素移到left覆盖，right位置移除
                nums[left] = nums[right];
                right--;
            }
            left++;

            while(right >= 0 && nums[right] == val)
                right--;
        }    
        return left;
    }

    

    //#数组平方排序
    //双指针法
    public static int[] sortedSquares(int[] nums) {
        int right = nums.length - 1;
        int left = 0;

        int[] result = new int[nums.length];
        int index = result.length - 1;

        while(left <= right) {
            if(nums[left] * nums[left] > nums[right] * nums[right]) {
                result[index--] = nums[left] * nums[left];
                ++left;
            } else {
                result[index--] = nums[right] * nums[right];
                --right;
            }
        }
        return result;
    }
	
	
	
	
	//#长度最小的子数组
	//滑动窗口法
	public static int minSubArrayLen(int s, int[] nums) {
		int left = 0;
		int sum = 0;
		int result = Integer.MAX_VALUE;//窗口长度
		
		for(int right = 0; right < nums.length; right++) {
				sum += nums[right];
				while(sum >= s) {//如果当前窗口的值大于s了，窗口就要向前移动了
					result = Math.min(result, right - left + 1);
					sum -= nums[left++];//sum去掉上一个值之后，left向后移动
				}
		}
		return result == Integer.MAX_VALUE ? 0 : result;
	}



    /**
     * #哈希表
     *  根据关键码的值而直接进行访问的数据结构
     *  用来快速判断一个元素是否出现在集合里
     * 
     * 有效的字母异位词 字典解法
     * 时间复杂度O(n) 空间复杂度O(1)
     * @param s
     * @param t
     * @return
     */
    public static boolean isAnagram(String s, String t) {
        int[] record = new int[26];

        // 在24个位置上，字母存在，数字+1
        for(int i = 0; i < s.length(); i++) {
            record[s.charAt(i) - 'a']++;
        }
        
        // 在24个位置上，字母存在，数字-1
        for(int i = 0; i < t.length(); i++) {
            record[t.charAt(i) - 'a']--;
        }

        //如果字母种类及出现次数完全吻合，最终record中24个位置应该全部为 0
        for(int count: record) {
            if(count != 0) {
                return false;
            }
        }
        return true;
    }



    /**
     * #两个数组的交集
     * 
     * @param nums1
     * @param nums2
     * @return
     */
    public static int[] intersection(int[] nums1, int[] nums2) {
        if(nums1 == null || nums1.length == 0 || nums2 == null || nums2.length == 0){
            return new int[0];
        }

        // System.out.println("nums1: " + Arrays.toString(nums1));
        // System.out.println("nums2: " + Arrays.toString(nums2));

        Set<Integer> set1 = new HashSet<>();
        Set<Integer> resSet = new HashSet<>();

        //将数组1的元素，全部加入set
        for(int i : nums1) {
            set1.add(i);
        }

        // System.out.println("set1: " + Arrays.toString(set1.toArray()));
        
        //判断hash表中是否存在该元素
        for(int i : nums2) {
            if(set1.contains(i)) {
                resSet.add(i);
            }
        }
        // System.out.println("resSet: " + Arrays.toString(resSet.toArray()));

        //方法1：将结果集合转换为数组
        // return resSet.stream().mapToInt(x -> x).toArray();

        //方法2：另外申请一个数组存放setRes中的元素，最后返回数组
        int[] arr = new int[resSet.size()];
        int j = 0;
        for(int i : resSet) {
            arr[j++] = i;
        }
        return arr;
    }
}


