/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-28-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
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
