import java.util.Arrays;

public class MyStringTest {
    
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


    public static void main(String[] args) {
        System.out.println();
        System.out.println("Hello MyString Test " + System.currentTimeMillis());
        System.out.println();

        String str = new String("lastchristmasigiveyoumyass");
        Solution slt = new Solution();
        
        System.out.println("before: " + str.toString());
        System.out.println();

        String reverse0 = slt.reverse0(str, 7);
        System.out.println("After: " + reverse0.toString());
        System.out.println();
        
        String reverse1 = slt.reverse1(str, 7);
        System.out.println("After: " + reverse1.toString());
        System.out.println();

        String reverse2 = slt.reverse2(str, 7);
        System.out.println("After: " + reverse2.toString());
        System.out.println();
    }
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
    public static String replaceSpace(String s) {
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
}