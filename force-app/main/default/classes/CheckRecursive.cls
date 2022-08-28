public Class CheckRecursive{
    private static boolean firstRun = true;
    public static boolean isFirstRun(){
        if(firstRun){
            firstRun = false;
            return true;
        }else{
            return firstRun;
        }
    }
    
    public static void reset(){
        firstRun = true;
    }
}
