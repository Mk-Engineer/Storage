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
            function3(n);

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
}


