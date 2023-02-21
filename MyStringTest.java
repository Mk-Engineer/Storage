import java.util.Arrays;

public class MyStringTest {
    public static void main(String[] args) {
        System.out.println();
        System.out.println("Hello MyString Test " + System.currentTimeMillis());
        System.out.println();
        
        String str = new String("   Last      Christmas You Giving My Ass   ");
        String str2 = new String("Hello MyString Test");
        System.out.println("Before: \n" + str);

        Solution slt = new Solution();
        System.out.println();
        System.out.println(slt.reverseWords(str));
        System.out.println(slt.reverseWords2(str));
        System.out.println(slt.reverseWords3(str));
        System.out.println(slt.reverseWords4(str));
        System.out.println();
        System.out.println(slt.reverseLeftWords1(str2,4));
        System.out.println(slt.reverseLeftWords2(str2,5));
        System.out.println();
    }

    // public static void main(String[] args) {
    //     System.out.println();
    //     System.out.println("Hello MyString Test " + System.currentTimeMillis());
    //     System.out.println();

    //     char[] str = new char[]{'l','i','n','k','e'};

    //     System.out.println("Before");
    //     System.out.println(Arrays.toString(str));
    //     System.out.println();

    //     Solution slt = new Solution();
    //     // slt.reverseString(str);
    //     slt.reverseStr(str);

    //     System.out.println("After");
    //     System.out.println(Arrays.toString(str));
    // }


    // public static void main(String[] args) {
    //     System.out.println();
    //     System.out.println("Hello MyString Test " + System.currentTimeMillis());
    //     System.out.println();

    //     String str = new String("lastchristmasigiveyoumyass");
    //     Solution slt = new Solution();
        
    //     System.out.println("before: " + str.toString());
    //     System.out.println();

    //     String reverse0 = slt.reverse0(str, 7);
    //     System.out.println("After: " + reverse0.toString());
    //     System.out.println();
        
    //     String reverse1 = slt.reverse1(str, 7);
    //     System.out.println("After: " + reverse1.toString());
    //     System.out.println();

    //     String reverse2 = slt.reverse2(str, 7);
    //     System.out.println("After: " + reverse2.toString());
    //     System.out.println();
    // }


    // public static void main(String[] args) {
    //     System.out.println();
    //     System.out.println("Hello MyString Test " + System.currentTimeMillis());
    //     System.out.println();
        
    //     String str = new String("Last Christmas You Giving My Ass");
    //     System.out.println("Before: " + str);

    //     Solution slt = new Solution();
    //     System.out.println("After: " + Solution.replaceSpace1(str));
    //     System.out.println("After: " + Solution.replaceSpace2(str));
    //     System.out.println();
    // }

}

class Solution {
    /**
     * 反转字符串：
     *      从两边向中间两辆交换
     * @param s
     */
    //方法一：
    //异或运算 ^ :相同的是0，不同的是1
    public void reverseString(char[] s) {
        int h = 0;
        int t = s.length -1;

        while(h < t) {
            //swap的过程
            s[h] ^= s[t]; //构造 a ^ b 的结果，并放在 a 中
            s[t] ^= s[h]; //将 a ^ b 的结果再 ^ b，存入 b 中，此时 b=a, a=a^b
            s[h] ^= s[t]; //a ^ b的结果再 ^ a，存入 a 中，此时 b = a， a = b 完成交换
            h++;
            t--;
        }
    }

    //方法二：
    public void reverseStr(char[] s) {
        int h = 0;
        int t = s.length - 1;

        while (h < t) {
            char temp = s[h];
            s[h] = s[t];
            s[t] = temp;
            h++;
            t--;
        }
    }


    /**
     * 反转字符串II
     * 
     * @param s
     * @param k
     * @return
     */
    //方法一
    public String reverse0(String s,int k) {
        StringBuffer res = new StringBuffer();
        
        int length = s.length();
        int start = 0;

        while(start < length) {
            //找到k和2k处
            StringBuffer temp = new StringBuffer();
            //与length进行判断，如果大于length，就将其置为length
            int firstK = (start + k > length) ? length : start + k;
            int secondK = (start + (2*k) > length) ? length : start + (2*k);

            //无论start所处位置，至少会反转一次
            temp.append(s.substring(start,firstK));
            res.append(temp.reverse());

            //如果firstK到secondK之间有元素，这些元素直接放入res里即可
            if(firstK < secondK) { //此时剩余长度一定大于k
                res.append(s.substring(firstK,secondK));
            }

            start += 2*k;
        }

        return res.toString();
    }

    //方法二
    public String reverse1(String s,int k) {
        char[] ch = s.toCharArray();

        for(int i = 0;i < ch.length;i += 2*k){
            int start = i;
            int end = Math.min(ch.length - 1, start + k - 1);//这里是判断位数够不够k个来取决end指针的位置

            //用异或运算反转
            while(start < end) {
                ch[start] ^= ch[end];
                ch[end] ^= ch[start];
                ch[start] ^= ch[end];
                start++;
                end--;
            }
        }

        return new String(ch);
    }

    //方法三
    public String reverse2(String s,int k) {
        char[] ch = s.toCharArray();
        //1.每隔 2k 个字符的前 k 个字符进行反转
        for(int i = 0; i < ch.length; i += 2*k) {
            //2.剩余字符小于 2k 但大于或等于 k 个，则反转前 k 个字符
            if(i + k <= ch.length) {
                reverse(ch,i,i+k-1);
                continue;
            }
            //3.剩余字符少于 k 个，则将剩余字符全部反转
            reverse(ch,i,ch.length-1);
        }

        return new String(ch);
    }

    //定义反转函数
    public void reverse(char[] ch, int i, int j) {
        for(; i < j; i++, j--) {
            char temp = ch[i];
            ch[i] = ch[j];
            ch[j] = temp;
        }
    }



    /**
     * 替换空格
     * 
     * @param s
     * @return
     */
    //方法一：从前向后
    public static String replaceSpace1(String s) {
        if(s == null) {
            return null;
        }

        //选用 StringBuffer 单线程使用，比较i快
        StringBuffer sb = new StringBuffer();

        //使用 sb 逐个复制 s ，碰到空格则替换，否则直接复制
        for(int i = 0; i < s.length(); i++) {
            //s.charAt(i)为 char 类型，为了比较需要将其转为和" "相同的字符串类型
            //if(" ".equals(String.valueOf(s.charAt(i)))){}
            if (s.charAt(i) == ' ') {
                sb.append("%20");
            } else {
                sb.append(s.charAt(i));
            }
        }
        return sb.toString();
    }

    //方法二：双指针，从后向前
    public static String replaceSpace2(String s) {
        if(s == null || s.length() == 0) {
            return s;
        }

        //扩充空间，空格数量2倍
        StringBuffer str = new StringBuffer();
        for(int i = 0;i < s.length();i++) {
            if(s.charAt(i) == ' '){
                str.append("  ");
            }
        }

        //若无空格，直接返回
        if(str.length() == 0) {
            return s;
        }

        //有空格，定义2个指针
        int left = s.length() - 1;//指向尾位置
        s += str.toString();
        int right = s.length() - 1;//指向扩展字符的尾位置
        char[] chars = s.toCharArray();

        while(left >= 0) {
            if(chars[left] == ' ') {
                chars[right--] = '0';
                chars[right--] = '2';
                chars[right] = '%';
            } else {
                chars[right] = chars[left];
            }
            left--;
            right--;
        }

        return new String(chars);
    }

    
    /**
     * 反转字符串中的每个单词：
     * 
     *  1.去除首尾以及中间多余空格
     *  2.反转整个字符串
     *  3.反转各个单词
     * 
     * @param s
     * @return
     */
    //方法1
    public String reverseWords(String s) {
        //1.
        StringBuilder sb = removeSpace(s);
        //2.
        reverseString(sb, 0 , sb.length()-1);
        //3.
        reverseEachWord(sb);

        return sb.toString();
    }

    private StringBuilder removeSpace(String s) {
        int start = 0;
        int end = s.length() - 1;

        while(s.charAt(start) == ' ') start++;
        while(s.charAt(end) == ' ') end--;

        StringBuilder sb = new StringBuilder();

        while(start <= end) {
            char c = s.charAt(start);
            if(c != ' ' || sb.charAt(sb.length() - 1) != ' ') {
                sb.append(c);
            }
            start++;
        }

        return sb;
    }

    //反转字符串指定区间[start, end]的字符
    public void reverseString(StringBuilder sb, int start, int end) {
        while(start < end) {
            char temp = sb.charAt(start);
            sb.setCharAt(start, sb.charAt(end));
            sb.setCharAt(end,temp);
            start++;
            end--;
        }       
    }

    private void reverseEachWord(StringBuilder sb) {
        int start = 0;
        int end = 1;
        int n = sb.length();

        while(start < n) {
            while(end < n && sb.charAt(end) != ' ') {
                end++;
            }
            reverseString(sb, start, end - 1);
            start = end + 1;
            end = start + 1;
        }
    }


    //方法2：
    public String reverseWords2(String s) {
        //源字符数组
        char[] initialArr = s.toCharArray();
        //新字符数组
        char[] newArr = new char[initialArr.length + 1];//下面循环添加单词，最终末尾的空格不会返回
        int newArrPos = 0;
        //i来进行整体对源字符数组从后往前遍历
        int i = initialArr.length - 1;

        while(i >= 0) {
            while(i >= 0 && initialArr[i] == ' ') {i--;}//跳过空格
            //此时i位置是边界或!=空格，先记录当前索引，之后的while用来确定单词的首字母的位置
            int right = i;
            while(i >= 0 && initialArr[i] != ' ') {i--;}
            //指定区间单词取出(由于i为首字母的前一位，所以这里+1)，取出的每组末尾都带有一个空格
            for(int j = i + 1; j <= right; j++) {
                newArr[newArrPos++] = initialArr[j];
                if(j == right) {
                    newArr[newArrPos++] = ' ';
                }
            }
        }
        
        //若是原始字符串没有单词，直接返回空字符串；若是有单词，返回0-末尾空格索引前范围的字符数组(转换成String返回)
        if(newArrPos == 0) {
            return "";
        } else {
            return new String(newArr,0,newArrPos-1);
        }
    }

    //方法3:
    public String reverseWords3(String s) {
        //步骤1，字符串整体反转(此时其中的单词也都反转了)
        char[] initialArr = s.toCharArray();
        reverseIII(initialArr, 0, s.length() - 1);
        
        int k = 0;
        for(int i = 0; i < initialArr.length; i++) {
            if(initialArr[i] == ' ') {
                continue;
            }

            int tempCur = i;
            while (i < initialArr.length && initialArr[i] != ' ') {
                i++;
            }

            for(int j = tempCur; j < i; j++) {
                if(j == tempCur) {//步骤二：二次反转
                    reverseIII(initialArr, tempCur, i - 1);//对指定范围字符串进行反转
                }

                //步骤三：移动操作
                initialArr[k++] = initialArr[j];
                if(j == i - 1) {//遍历结束
                    //避免越界情况，例如 => "asdasd df f"，不加判断最后就会数组越界
                    if(k < initialArr.length) {
                        initialArr[k++] = ' ';
                    }
                }
            }
        }

        if(k == 0) {
            return "";
        } else {
            //参数三：以防出现如"asdasd df f " => "f df asdasd"正好凑满不需要省略空格情况
            return new String(initialArr, 0, (k == initialArr.length) && (initialArr[k-1] != ' ') ? k : k-1);
        }
    }

    public void reverseIII(char[] chars, int begin, int end) {
        for(int i = begin, j = end; i < j; i++,j--) {
            chars[i] ^= chars[j];
            chars[j] ^= chars[i];
            chars[i] ^= chars[j];
        }
    }

    //方法四：
    public String reverseWords4(String s) {
        char[] chars = s.toCharArray();
        //1.去除首尾以及中间多余空格
        chars = removeExtraSpaces(chars);
        //2.整个字符串反转
        reverseIV(chars, 0, chars.length - 1);
        //3.单词反转
        reverseEachWordIV(chars);

        return new String(chars);
    }

    //1.用快慢指针去除首尾以及中间多余的空格
    public char[] removeExtraSpaces(char[] chars) {
        int slow = 0;
        
        for(int fast = 0; fast < chars.length; fast++) {
            if(chars[fast] != ' ') {
                if(slow != 0) {
                    chars[slow++] = ' ';
                }
                while(fast < chars.length && chars[fast] != ' ') {
                    chars[slow++] = chars[fast++];
                }
            }
        }

        char[] newChars = new char[slow];
        System.arraycopy(chars, 0, newChars, 0, slow);
        
        return newChars;
    }

    //双指针实现范围内字符串反转
    public void reverseIV(char[] chars, int left, int right) {
        if(right >= chars.length) {
            System.out.println("set a wrong right");
        }

        while(left < right) {
            chars[left] ^= chars[right];
            chars[right] ^= chars[left];
            chars[left] ^= chars[right];
            left++;
            right--;
        }
    }

    //单词反转
    public void reverseEachWordIV(char[] chars) {
        int start = 0;

        for(int end = 0; end <= chars.length; end++) {
            if(end == chars.length || chars[end] == ' ') {
                reverseIV(chars, start, end - 1);
                start = end + 1;
            }
        }
    }




    /**
     * 左旋字符串
     * 
     * @param s
     * @param n
     * @return
     */
    //方法1：
    public String reverseLeftWords1(String s, int n) {
        int len = s.length();
        StringBuilder sb = new StringBuilder(s);
        
        reverseStringI(sb,0,n-1);
        reverseStringI(sb, n, len-1);

        return sb.reverse().toString();
    }

    public void reverseStringI(StringBuilder sb, int start, int end) {
        while(start < end) {
            char temp = sb.charAt(start);

            sb.setCharAt(start, sb.charAt(end));
            sb.setCharAt(end, temp);

            start++;
            end--;
        }
    }


    //方法2：
    //空间复杂度O(1)，用原始数组来进行反转操作
    //思路：先整个字符串反转，再反转前面的，最后反转后面的
    public String reverseLeftWords2(String s, int n) {
        char[] chars = s.toCharArray();

        reverseII(chars, 0, chars.length - 1);
        reverseII(chars, 0, chars.length - 1 - n);
        reverseII(chars, chars.length - n, chars.length - 1);

        return new String(chars);
    }

    public void reverseII(char[] chars, int left, int right) {
        while (left < right) {
            chars[left] ^= chars[right];
            chars[right] ^= chars[left];
            chars[left] ^= chars[right];
            
            left++;
            right--;
        }
    }


    //KMP
    // 给定一个 haystack 字符串和一个 needle 字符串，在 haystack 字符串中找出 needle 字符串出现的第一个位置 (从0开始)。如果不存在，则返回  -1。
    /**
     * 基于窗口滑动的算法
     * 
     * 时间复杂度：O(m*n)
     * 空间复杂度：O(1)
     * 注：n为haystack长度，m为needle长度
     * 
     * @param haystack
     * @param needle
     * @return
     */
    public int strStr(String haystack, String needle){
        

        return 0;
    }

}