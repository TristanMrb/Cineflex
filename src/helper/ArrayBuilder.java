package helper;

public class ArrayBuilder {
    public static int[] stringToIntArray(String string, String del) {
        String[] splitString = string.split(del);
        int[] arr = new int[splitString.length];
        for(int i = 0; i < arr.length; i++) {
            arr[i] = Integer.parseInt(splitString[i]);
        }

        return arr;
    }

    public static String intArrayToString(int[] arr) {
        return intArrayToString(arr, ", ");
    }

    public static String intArrayToString(int[] arr, String del) {
        String output = "";
        for(int i = 0; i < arr.length; i++) {
            if(i != arr.length - 1) {
                output += arr[i] + del;
            } else {
                output += arr[i];
            }
        }
        return output;
    }
}