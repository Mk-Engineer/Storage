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

        

        //#fourSum
        // int[] nums = new int[]{-2, -1, 0, 0, 1, 2};
        // System.out.println(Arrays.toString(nums));
        // System.out.println();
        // System.out.println(Arrays.toString(fourSum(nums,0).toArray()));

        

        //#isValid
        // String s1 = "([{}]()";
        // String s2 = "([{}}}";
        // String s3 = "([{}])))";
        // String s4 = "{[()]}";
        // System.out.println(s1 + " s1 Match is: " + isValid(s1));
        // System.out.println(s2 + " s2 Match is: " + isValid(s2));
        // System.out.println(s3 + " s3 Match is: " + isValid(s3));
        // System.out.println(s4 + " s4 Match is: " + isValid(s4));


        
        //#deque
        // ArrayDeque<Integer> deque = new ArrayDeque<>();
        // deque.offer(1);
        // deque.offer(2);
        // deque.offer(3);
        // deque.offer(4);
        // deque.offer(5);
        // deque.offer(6);

        // System.out.println(Arrays.toString(deque.toArray()));
        // System.out.println();

        // System.out.println("peek() " + deque.peek());
        // System.out.println("peekFirst() " + deque.peekFirst());
        // System.out.println("peekLast() " + deque.peekLast());
        // System.out.println();

        // System.out.println("poll() " + deque.poll());
        // System.out.println("pollFirst() " + deque.pollFirst());
        // System.out.println("pollLast() " + deque.pollLast());
        // System.out.println();
        // System.out.println("-------------"); //#
        // System.out.println();



        //#maxSlidingWindow2
        // System.out.println();
        // int[] num = new int[]{1,3,-1,-3,5,3,6,7};
        // System.out.println(Arrays.toString(num));
        // System.out.println();
        // System.out.println("-------------"); //#

        // int[] res = maxSlidingWindow2(num,3);
        // System.out.println(Arrays.toString(res));



        //#topKFrequent
        // int[] nums = new int[]{0,0,0,0,1,1,1,2,2,3};
        // System.out.println("topKFrequent1 " + Arrays.toString(topKFrequent1(nums,1)));
        // System.out.println("topKFrequent2 " + Arrays.toString(topKFrequent2(nums,3)));




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
		System.out.println("Host-iSH");
        
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



    /**
     * #四数之和
     * 
     *      给定一个包含 n 个整数的数组 nums 和一个目标值 target，
     *      判断 nums 中是否存在四个元素 a，b，c 和 d ，
     *      使得 a + b + c + d 的值与 target 相等？
     *      找出所有满足条件且不重复的四元组
     * 
     * @param nums
     * @param target
     * @return
     */
    public static List<List<Integer>> fourSum(int[] nums, int target) {
        List<List<Integer>> result = new ArrayList<>();
        Arrays.sort(nums);

        for(int i = 0; i < nums.length; i++) {
            if(nums[i] > 0 && nums[i] > target) {
                return result;//break
            }

            //去重
            if(i > 0 && nums[i - 1] == nums[i]) {
                continue;
            }

            for(int j = i + 1; j < nums.length; j++) {
                //对nums[j]去重
                if(j > i + 1 && nums[j - 1] == nums[j]) {
                    continue;
                }

                int left = j + 1;
                int right = nums.length - 1;

                while(right > left){
                    long sum = (long) nums[i] + nums[j] + nums[left] + nums[right];
                    if(sum > target) {
                        right--;
                    } else if(sum < target) {
                        left++;
                    } else {
                        result.add(Arrays.asList(nums[i], nums[j], nums[left], nums[right]));
                        //对nums[left]和nums[right]去重
                        while(right > left && nums[right] == nums[right - 1])
                            right--;
                        while(right > left && nums[left] == nums[left + 1])
                            left++;
                            
                        //双指针收缩
                        left++;    
                        right--;
                    }
                }
            }
        }
        return result;
    }



    /**
     * #括号匹配
     * 
     *  栈适合做对称匹配
     * 
     *      在匹配左括号的时候，右括号先入栈，
     *      就只需要比较当前元素和栈顶相不相等就可以了，
     *      比左括号先入栈代码实现要简单
     * 
     *  左括号和右括号全都匹配:
     *      字符串遍历完之后，正好栈是空的
     * 
     *  (左不匹配)
     *  情况1：已经遍历完了字符串，但是栈不为空，
     *        说明有相应的左括号没有右括号来匹配，所以return false
     *
     *  (括号类型不匹配)
     *  情况2：遍历字符串匹配的过程中，发现栈里没有要匹配的字符。
     *        所以return false
     *  
     *  (右不匹配)
     *  情况3：遍历字符串匹配的过程中，栈已经为空了，没有匹配的字符了，
     *        说明右括号没有找到对应的左括号return false
     * 
     * @param s
     * @return
     */
    public static boolean isValid(String s) {
        Deque<Character> deque = new LinkedList<>();
        char ch;

        for(int i = 0; i < s.length(); i++) {
            ch = s.charAt(i);

            //遇到左括号，将右括号入栈
            if(ch == '(') {
                deque.push(')');
            } else if (ch == '{') {
                deque.push('}');
            } else if (ch == '[') {
                deque.push(']');
            /* 如果是右括号，判断是否和栈顶元素匹配 */    
            } else if (deque.isEmpty() || deque.peek() != ch) {
                return false;
            } else {
                deque.pop();
            }
        }
        return deque.isEmpty();
    }



    /**
     * #删除字符串中的所有相邻重复项
     * 
     * @param s
     * @return
     */
    public static String removeDuplicates0(String s) {
        //ArrayDeque会比LinkedList在除了删除元素这一点外会快一点
        //参考：https://stackoverflow.com/questions/6163166/why-is-arraydeque-better-than-linkedlist

        ArrayDeque<Character> deque = new ArrayDeque<>();
        char ch;

        for(int i = 0; i < s.length(); i++) {
            ch = s.charAt(i);
            if(deque.isEmpty() || deque.peek() != ch) {
                deque.push(ch);
            } else {
                deque.pop();
            }
        }

        String str = "";
        //剩余元素即为不重复元素
        while(!deque.isEmpty()) {
            str = deque.pop() + str;
        }

        return str;
    }



    /**
     * #拿字符串直接作为栈
     * 
     * @param s
     * @return
     */
    public static String removeDuplicates1(String s) {
        //将res当作栈
        //也可以用 StringBuilder 来修改字符串，速度更快
        //StringBuilder res = new StringBuilder();

        StringBuffer res = new StringBuffer();
        //top为res的长度
        int top = -1;
        
        for(int i = 0;i < s.length(); i++) {
            char c = s.charAt(i);
            //当 top > 0，即栈中有字符时，当前字符如果和栈中字符相等，弹出栈顶字符，同时top--
            if(top >= 0 && res.charAt(top) == c) {
                res.deleteCharAt(top);
                top--;
            //否则，将该字符入栈，同时top++    
            } else {
                res.append(c);
                top++;
            }
        }

        return res.toString();
    }



    /**
     * #双指针法
     * 
     * @param s
     * @return
     */
    public static String removeDuplicates2(String s) {
        char[] ch = s.toCharArray();
        int fast = 0;
        int slow = 0;

        while(fast < s.length()) {
            //直接用fast指针覆盖slow指针
            ch[slow] = ch[fast];
            //遇到前后相同的值，就跳过，即slow指针后退一步，下次循环就可以直接覆盖掉
            if(slow > 0 && ch[slow] == ch[slow - 1]) {
                slow--;
            } else {
                slow++;
            }
            fast++;
        }
        
        return new String(ch,0,slow);
    }



    /**
     * #逆波兰表达式求值
     * 
     * @param tokens
     * @return
     */
    public static int evalRPN(String[] tokens) {
        Deque<Integer> stack = new LinkedList<>();
        for(String s : tokens) {
            if("+".equals(s)) {
                stack.push(stack.pop() + stack.pop());
            } else if ("-".equals(s)) {
                stack.push(-stack.pop() + stack.pop());
            } else if ("*".equals(s)) {
                stack.push(stack.pop() * stack.pop());
            } else if ("/".equals(s)) {
                int temp1 = stack.pop();
                int temp2 = stack.pop();
                stack.push(temp2 / temp1);
            } else {
                stack.push(Integer.valueOf(s));
            }
        }
        
        return stack.pop();
    }



    /**
     * 解法一：
     *      自定义数组
     *  
     * @param nums
     * @param k
     * @return
     */
    public static int[] maxSlidingWindow1(int[] nums,int k) {
        if(nums.length == 1) {
            return nums;
        }
        
        int len = nums.length - k + 1;
        
        //存放结果元素的数组
        int[] res = new int[len];
        int num = 0;

        //自定义队列
        MyQue myQueue = new MyQue();

        //先将前k个元素放入队列
        for(int i = 0; i < k; i++) {
            myQueue.add(nums[i]);
        }

        res[num++] = myQueue.peek();

        for(int i = k; i < nums.length; i++) {
            //滑动窗口移除最前面的元素，移除是判断该元素是否放入队列
            myQueue.poll(nums[i - k]);//poll() 出队
            //滑动窗口加入最后的元素
            myQueue.add(nums[i]);
            //记录对应的最大值
            res[num++] = myQueue.peek();
        }
        return res;
    }



    /**
     * 解法二：
     *  利用双端队列手动实现单调队列
     *      用一个单调队列来存储对应的下标，每当窗口滑动的时候，
     *      直接取队列的头部指针对应的值放入结果集即可
     * 
     *      单调队列类似 （tail -->） 3 --> 2 --> 1 --> 0 (--> head) 
     *      (右边为头结点，元素存的是下标)
     * 
     *             poll
     *             peek    offer
     *      deque: | 1 | 2 | 3 |    
     *                     peekLast
     *                     pollLast
     * 
     * @param nums
     * @param k
     * @return
     */
    public static int[] maxSlidingWindow2(int[] nums,int k) {
        ArrayDeque<Integer> deque = new ArrayDeque<>();

        int n = nums.length;
        int[] res = new int[n - k + 1];
        int idx = 0;

        for(int i = 0; i < n; i++) {
            // 根据题意，i为nums下标，是要在[i - k + 1, i]中选到最大值，只需要保证两点
            // 1.队列头节点需要在[i - k + 1, i]范围内，不符合则要弹出
            /*
            System.out.println("i = " + i); //#
            System.out.println("范围：" + "["+(i-k+1)+", "+(i-k+2)+", "+i+"]");
            if((i-k+1) >= 0)
                System.out.println("nums: " + "["+nums[i-k+1]+", "+nums[i-k+2]+", "+nums[i]+"]");
            System.out.println("deque.peek() = " + deque.peek()); //#
            System.out.println("i-k+1 = " + (i-k+1)); //#
            System.out.println(); //#
            */
            while(!deque.isEmpty() && deque.peek() < i - k + 1) {
                // System.out.println("while: deque.peek() = " + deque.peek()); //#
                deque.poll();//出队
            }
            // 2.出队直至队首为最大值
            /*
            if(deque.peekLast() != null)
                System.out.println("nums[deque.peekLast()="+nums[deque.peekLast()]+"] = " + deque.peekLast()); //#
            else
                System.out.println("nums[i="+i+"] = " + nums[i]); //#
            System.out.println(); //#
            */
            while(!deque.isEmpty() && nums[deque.peekLast()] < nums[i]) {
                deque.pollLast();
                /*
                if(deque.peekLast() != null)
                    System.out.println("while: nums[deque.peekLast()="+nums[deque.peekLast()]+"] = " + deque.peekLast()); //#
                else
                    System.out.println("deque.peekLast() = " + deque.peekLast()); //#
                */
                System.out.println(); //#
            }

            deque.offer(i);//入队

            // 存放最大值
            // 因为单调，当i增长到符合【第一个】k范围的时候，每滑动一步都将队列头节点放入结果就行了
            if(i >= k - 1) {
                /*
                if(deque.peekLast() != null)
                    System.out.println("if: nums["+"i="+deque.peek()+"] = " + deque.peekLast()); //#
                else
                    System.out.println("deque.peekLast() = " + deque.peekLast()); //#
                System.out.println(); //#
                */
                res[idx++] = nums[deque.peek()];
            }
            System.out.println("deque: " + Arrays.toString(deque.toArray()));
            // System.out.println("-------------"); //#
        }
        
        return res;
    }



    //#前 K 个高频元素
    /*Comparator接口说明：
     * 
     * 返回负数，形参中的第一个参数排在前面；返回正数，形参中第二个参数排在前面
     * 对于队列：排在前面意味着往队头靠
     * 对于堆 (使用PriorityQueue实现) ：从队头到队尾按 从小到大 排就是 小顶堆
     *                                从队头到队尾按从大到小排就是最大堆，队首元素相当于堆的根节点
     */

    //解法1：基于大顶堆实现
    public static int[] topKFrequent1(int[] nums, int k) {
        //key为数组元素值，val为对应出现次数
        Map<Integer,Integer> map = new HashMap<>();

        //getOrDefault(num,defaultValue)：获取num对应的value
        for(int num:nums) {
            map.put(num,map.getOrDefault(num,0) + 1);
        }

        //在优先队列中存储二元组(num,cnt)，cnt表示元素值num在书中的出现次数
        //出现次数按从队头到队尾的顺序是从大到小排，出现次数最多的在队头(相当于大顶堆)
        PriorityQueue<int[]> pq = new PriorityQueue<>((pair1,pair2)->pair2[1]-pair1[1]);
        
        //大顶堆需要对所有元素进行排序
        for(Map.Entry<Integer,Integer> entry : map.entrySet()) {
            pq.add(new int[]{entry.getKey(),entry.getValue()});
        }

        int[] ans = new int[k];
        //依次从队头弹出k个，就是出现频率前k高的元素
        for(int i = 0; i < k; i++) {
            ans[i] = pq.poll()[0];
        }
        
        return ans;
    }

    //解法2：基于小顶堆实现
    public static int[] topKFrequent2(int[] nums, int k) {
        //key为数组元素值，val为对应出现次数
        Map<Integer,Integer> map = new HashMap<>();

        for(int num:nums) {
            map.put(num,map.getOrDefault(num,0) + 1);
        }

        //在优先队列中存储二元组(num,cnt)，cnt表示元素值num在书中的出现次数
        //出现次数按从队头到队尾的顺序是从小到大排，出现次数最低的在队头(相当于小顶堆)
        //pair[0]: num / pair[1]: cnt
        PriorityQueue<int[]> pq = new PriorityQueue<>((pair1,pair2)->pair1[1]-pair2[1]);

        //小顶堆只需要维持k个元素有序
        for(Map.Entry<Integer,Integer> entry : map.entrySet()) {
            if(pq.size() < k) {//小顶堆元素小于k个时直接加
                pq.add(new int[]{entry.getKey(),entry.getValue()});
            } else {
                //当前元素出现次数大于小顶堆的根节点(这k个元素中出现次数最少的那个)
                if(entry.getValue() > pq.peek()[1]) {
                    //弹出队头，即把堆里出现次数最少的那个删除，留下的就是出现次数最多的了
                    pq.poll();
                    pq.add(new int[]{entry.getKey(),entry.getValue()});
                }
            }
        }

        int[] ans = new int[k];

        for(int i = k - 1; i >= 0; i--) {
            ans[i] = pq.poll()[0];
        }
        return ans;
    }



    //#
}



//#栈和队列
/**
 * 使用栈实现队列的下列操作：
 *  push(x) -- 将一个元素放入队列的尾部。
 *  pop() -- 从队列首部移除元素。
 *  peek() -- 返回队列首部的元素。
 *  empty() -- 返回队列是否为空。
*/
class MyQueue {
    Stack<Integer> stackIn;
    Stack<Integer> stackOut;

    public MyQueue() {
        stackIn = new Stack<>();
        stackOut = new Stack<>();
    }

    public void push(int x) {
        stackIn.push(x);
    }

    public int pop() {
        dumpstackIn();
        return stackOut.pop();
    }

    public int peek() {
        dumpstackIn();
        return stackOut.peek();
    }

    public boolean empty() {
        return (stackIn.isEmpty() && stackOut.isEmpty());
    }

    //如果stackOut不为空，将stackIn中的全部元素放到stackOut中
    private void dumpstackIn() {
        if(!stackOut.isEmpty())
            return;
        
        while(!stackIn.isEmpty()) {
            stackOut.push(stackIn.pop());
        }              
    }
}



/**
 * #单调队列
 *  滑动窗口最大值
 * 
 *  解法一：自定义数组
 *         @param maxSlidingWindow1
 *  解法二：利用双端队列手动实现单调队列 (见Main)
 *         @param maxSlidingWindow2
*/
class MyQue {
    Deque<Integer> deque = new LinkedList<>();

    //弹出元素时，比较当前要弹出的数值是否等于队列出口的数值，如果相等则弹出
    //同时判断队列当前是否为空
    void poll(int val) {
        if(!deque.isEmpty() && val == deque.peek()) {
            deque.poll();
        }
    }

    //添加元素时，如果要添加的元素大于入口处的元素，就将入口元素弹出
    //保证队列元素单调递减
    //比如此时队列元素3、1，2将要入队，比1大，所以1弹出，此时队列3、2
    void add(int val) {
        while(!deque.isEmpty() && val > deque.getLast()) {
            deque.removeLast();
        }
        deque.add(val);
    }

    //队列队顶元素始终为最大值
    int peek() {
        return deque.peek();
    }
}



/**
 * 使用队列实现栈的下列操作：

    push(x) -- 元素 x 入栈
    pop() -- 移除栈顶元素
    top() -- 获取栈顶元素
    empty() -- 返回栈是否为空
*/

// 使用2个Queue实现
class MyStack0 {

    Queue<Integer> queue1; //和栈中保持一样元素的队列
    Queue<Integer> queue2; //辅助队列

    public MyStack0() {
        queue1 = new LinkedList<>();
        queue2 = new LinkedList<>();
    }

    //Push element onto stack
    //offer/add 入队
    public void push(int x) {
        queue2.offer(x); //先放入辅助队列

        while(!queue1.isEmpty()) {
            queue2.offer(queue1.poll());
        }

        Queue<Integer> queueTemp;
        queueTemp = queue1;
        queue1 = queue2;
        queue2 = queueTemp; //最后交换queue1和queue2，将元素都放到queue1中
    }

    //Removes the top element
    //poll 出队
    public int pop() {
        return queue1.poll(); // queue1中的元素和栈中保持一致
    }

    //Get the top element
    public int top() {
        return queue1.peek();
    }

    public boolean empty() {
        return queue1.isEmpty();
    }
}



//使用两个Deque实现
class MyStack1 {
    //Deque接口继承了Queue接口
    //所以Queue中的add、poll、peek等效于Deque中的addLast、pollFirst、peekFirst

    Deque<Integer> que1;//和栈中保持元素一致的队列
    Deque<Integer> que2;//辅助队列

    public MyStack1() {
        que1 = new ArrayDeque<>();
        que2 = new ArrayDeque<>();
    }

    public void push(int x) {
        que1.addLast(x);
    }

    public int pop() {
        int size = que1.size();
        size--;

        //将que1导入que2，但留下最后一个值
        while((size--) > 0) {
            que2.addLast/*入队*/(que1.peekFirst()/*出队*/);
            que1.pollFirst();/*出队*/
        }

        int res = que1.pollFirst();/*出队*/
        //
        que1 = que2;
        //
        que2 = new ArrayDeque<>();

        return res;
    }

    public int top() {
        return que1.peekLast();
    }

    public boolean empty() {
        return que1.isEmpty();
    }
}



//用1个Deque实现
class MyStack2 {
    Deque<Integer> que;

    public MyStack2() {
        que = new ArrayDeque<>();
    }

    public void push(int x) {
        que.addLast(x);
    }

    public int pop() {
        int size = que.size();
        size--;

        while((size--) > 0) {
            que.addLast(que.peekFirst());
            que.pollFirst();
        }

        int res = que.pollFirst();
        return res;
    }

    public int top() {
        return que.peekLast();
    }

    public boolean empty() {
        return que.isEmpty();
    }
}



//用1个Queue实现
class MyStack3 {
    Queue<Integer> queue;

    public MyStack3() {
        queue = new LinkedList<>();
    }

    //每offer一个数A进来，都重新排列，将此数A放到队首
    public void push(int x) {
        queue.offer(x);
        int size = queue.size();

        //移动除了 A 的其它数
        while((size--) > 1)
            queue.offer(queue.poll());
    }

    public int pop() {
        return queue.poll();
    }

    public int top() {
        return queue.peek();
    }

    public boolean empty() {
        return queue.isEmpty();
    }
}
