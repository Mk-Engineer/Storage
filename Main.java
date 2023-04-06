// import java.util.Arrays;
// import java.util.Scanner;
import java.text.SimpleDateFormat;
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
        // int[] arr1 = new int[]{9,4,9,8,4};
        // int[] arr2 = new int[]{4,9,5};
        // intersection(arr1,arr2);


        //#twoSum
        // int[] num1 = new int[]{11,2,9,7,15,3,21,6};
        // int[] num2 = new int[]{11,9,15,21};
        // System.out.println(Arrays.toString(twoSum(num1,9)));
        // System.out.println();
        // System.out.println(Arrays.toString(twoSum(num2,9)));



        //#threeSum
        // int[] nums = new int[]{-1, 0, 1, 2, -1, -4};
        // System.out.println(Arrays.toString(nums));
        // System.out.println();
        // System.out.println(Arrays.toString(threeSum(nums).toArray()));



        /* SYMBOL */
        System.out.println();
        Date date = new Date(System.currentTimeMillis()); // 将毫秒数转换为Date对象
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // 创建日期格式化对象
        String formattedDate = formatter.format(date); // 将Date对象格式化为字符串
        
        System.out.println("SAMPING AT: " + formattedDate);
        
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

        //将数组1的元素，全部加入set，去掉重复元素
        for(int i : nums1) {
            // System.out.println("nums1-i: " + i);
            set1.add(i);
        }
        
        // System.out.println("set1: " + Arrays.toString(set1.toArray()));
        
        //判断hash表中是否存在该元素
        for(int i : nums2) {
            if(set1.contains(i)) {
                resSet.add(i);
                // System.out.println("nums2-i: " + i);
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



    /***
     * #快乐数：
     *      对于一个正整数，每一次将该数替换为它每个位置上的数字的平方和，
     *  然后重复这个过程直到这个数变为 1，也可能是 无限循环 但始终变不到 1。
     *  如果 可以变为  1，那么这个数就是快乐数。
     * 
     * @param n
     * @return
     */
    public static boolean isHappy(int n) {
        Set<Integer> record = new HashSet<>();
        while(n != 1 && !record.contains(n)){//出现重复，跳出循环
            record.add(n);
            n = getNextNumber(n);
        }
        return n == 1;
    }

    // 完成数字的按位拆分、平方和求和运算
    private static int getNextNumber(int n) {
        int res = 0;
        while (n > 0) {
            int temp = n % 10;
            res += temp * temp;
            n = n / 10;            
        }
        return res;
    }



    /**
     * #两数之和
     * 
     * @param nums
     * @param target
     * @return 存在，返回下标 / 不存在，返回[0,0]
    */
    public static int[] twoSum(int[] nums, int target) {
        int[] res = new int[2];
        if(nums == null || nums.length == 0){
            return res;
        }

        Map<Integer,Integer> map = new HashMap<>();

        for(int i = 0; i < nums.length; i++) {
            int temp = target - nums[i];
            if(map.containsKey(temp)) {
                res[1] = i;
                res[0] = map.get(temp);
                break;
            }
            map.put(nums[i], i); //没找到匹配对，把访问过的元素和下表加入到map中
        }
        
        return res;
    }



    /**
     * #四数之和
     *      给定四个包含整数的数组列表 A , B , C , D ,
     *      计算有多少个元组 (i, j, k, l) ，使得 A[i] + B[j] + C[k] + D[l] = 0。
     * 
     * 步骤：
     *     首先定义 一个unordered_map，key放a和b两数之和，value 放a和b两数之和出现的次数。 
     *     遍历大A和大B数组，统计两个数组元素之和，和出现的次数，放到map中。
     *     定义int变量count，用来统计 a+b+c+d = 0 出现的次数。
     *     在遍历大C和大D数组，找到如果 0-(c+d) 在map中出现过的话，
     *     就用count把map中key对应的value也就是出现次数统计出来。
     *     最后返回统计值 count。
     * 
     * @param nums1
     * @param nums2
     * @param nums3
     * @param nums4
     * @return 总元组数 \ 总次数
     */
    public static int fourSumCount(int[] nums1,int[] nums2,int[] nums3,int[] nums4) {
        Map<Integer,Integer> map = new HashMap<>();
        int temp;
        int res = 0;

        //统计两个数组中的元素之和，同时统计出现的次数，放入map。
        for(int i : nums1) {
            for(int j : nums2) {
                temp = i + j;
                if (map.containsKey(temp)) {
                    map.put(temp, map.get(temp) + 1);//value + 1
                } else {
                    map.put(temp,1);
                }
            }
        }

        //统计剩余两个元素的和，在map中找到是否存在相加为0的情况，同记录次数
        for(int i : nums3) {
            for(int j : nums4) {
                temp = i + j;
                if(map.containsKey(0-temp)) {
                    res += map.get(0-temp);
                }
            }
        }
        
        return res;
    }



    /**
     * #赎金信
     *      给定一个赎金信 (ransom) 字符串和一个杂志(magazine)字符串，
     *      判断第一个字符串 ransom 能不能由第二个字符串 magazines 里面的字符构成。
     *      如果可以构成，返回 true ；否则返回 false。
     * 
     *      (题目说明：为了不暴露赎金信字迹，要从杂志上搜索各个需要的字母，组成单词来表达意思。
     *      杂志字符串中的每个字符只能在赎金信字符串中使用一次。)
     * 
     * @param ransomNote
     * @param magazine
     * @return 能构成 / 不能构成
     */
    public static boolean canConstruct(String ransomNote, String magazine) {
        //定义一个哈希映射数组
        int[] record = new int[26];

        for(char c : magazine.toCharArray()) {
            record[c - 'a'] += 1;
        }
        
        for(char c : ransomNote.toCharArray()) {
            record[c - 'a'] -= 1;
        }

        //如果数组中存在负数，说明ransomNote中总存在magazine中不存在的字符
        for(int i : record) {
            if(i < 0) {
                return false;
            }
        }
        
        return true;
    }



    /**
     * #三数之和
     *      给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，
     *      使得 a + b + c = 0 ？请你找出所有满足条件且不重复的三元组。
     * 
     * [双指针法]
     *      * 双指针法一定要排序！
     * 
     *      拿这个nums数组来举例，首先将数组排序，然后有一层for循环，i从下标0的地方开始，同时定一个下标left 定义在i+1的位置上，定义下标right 在数组结尾的位置上。
     *      依然还是在数组中找到 abc 使得a + b +c =0，我们这里相当于 a = nums[i]，b = nums[left]，c = nums[right]。
     *      接下来如何移动left 和right呢， 如果nums[i] + nums[left] + nums[right] > 0 就说明 此时三数之和大了，因为数组是排序后了，所以right下标就应该向左移动，这样才能让三数之和小一些。
     *      如果 nums[i] + nums[left] + nums[right] < 0 说明 此时 三数之和小了，left 就向右移动，才能让三数之和大一些，直到left与right相遇为止。
     * 
     * 时间复杂度：O(n^2)
     * 
     * @param nums
     * @return
     */
    public static List<List<Integer>> threeSum(int[] nums) {
        List<List<Integer>> result = new ArrayList<>();
        Arrays.sort(nums);

        //找出a + b + c = 0
        //a = nums[i] , b = nums[left] , c = nums[right]
        for(int i = 0; i < nums.length; i++) {
            // 排序之后如果第一个元素已经大于零，那么无论如何组合都不可能凑成三元组，直接返回结果
            if(nums[i] > 0) {
                return result;
            }

            if(i > 0 && nums[i] == nums[i-1]) { //去重a
                continue;
            }

            int left = i + 1;
            int right = nums.length - 1;

            while(right > left) {//直到left与right相遇为止
                int sum = nums[i] + nums[left] + nums[right];
                if(sum > 0) {
                    right--;
                } else if (sum < 0) {
                    left++;
                } else {
                    result.add(Arrays.asList(nums[i], nums[left], nums[right]));
                    //去重逻辑应该放到找到一个三元组之后，对b、c进行去重
                    while(right > left && nums[right] == nums[right - 1])
                        right--;
                    while(right > left && nums[left] == nums[left + 1])
                        left++;    

                    //找到答案时，双指针同时收缩    
                    right--;
                    left++;                        
                }
            }
        }
        return result;
    }



    //#MK-OMEN
}