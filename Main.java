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
        String[] arr = new String[]{"JJ","DD","MM","BB","GG","AA"};
        System.out.println("Java Success!");

        //Search
        // String dest = "BB";

        // boolean isFlag = true;

        // for(int i = 0;i < arr.length; i++)
        // {
        //     if(dest.equals(arr[i]))
        //     {
        //         System.out.println("Locate at : arr[" + i + "]");
        //         isFlag = false;
        //         break;
        //     }
        // }

        // if(isFlag)
        // {
        //     System.out.println("Not Exist");
        // }


        //Binary Search
        int[] list = new int[]{-98,-34,2,34,54,66,79,105,210,333};
        int target = 66;
        int head = 0;
        int end = list.length - 1;
        boolean isFlag = true;
        
        while(head <= end)
        {
            int middle = (end + head) / 2;

            if(target == list[middle])
            {
                System.out.println("Locate at : arr[" + middle + "]");
                isFlag = false;
                break;
            }
            else if(target < list[middle])
            {
                end = middle - 1;
            }
            else//target > list[middle]
            {
                head = middle + 1;                
            }
            System.out.println("head : " + head);
            System.out.println("end : " + end);
            System.out.println("middle : " + middle);
            System.out.println("  ");
        }

        if(isFlag)
        {
            System.out.println("Not Exist");
        }
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
        
	System.out.println("iPad upload");
	System.out.println("Add File");
	System.out.println("iSH upload 2nd");
   	System.out.println("OhMyZsh Success");
    }

}
