//***********************************************Created by Mysterion_06_*************************************************
//DMC1 Autosplitter

state("dmc1")
{
    int LoadingScreen: 0x28965D8;                   //Loadingscreen when opening the menu or when going through doors
    ushort roomID: 0x5eab88, 0x56e1830;
    int RS: 0x452AA14;
    int menu: 0x5eab88, 0x2a10;
    int loadingStatus: 0x5eab88, 0x2780;
    int m23: 0x4CB3914;
    int pause: 0x4CB3034;
}

init
{
    vars.split = 0;
    vars.chapter = 0;
}

startup
{
    settings.Add("Doorsplitter", false, "DoorSplitter (Currently under progress, untick this)");
    settings.CurrentDefaultParent = "Doorsplitter";
    settings.Add("Dante/SuperDante");
    settings.Add("Legendary Dark Knight (Do not use, still under work)");
}

start
{
    //Start the timer upon choosing the difficulty and reset split + chapter back to 0
    if(current.menu != 266 && old.menu == 266){
        vars.split = 0;
        vars.chapter = 0;
        return true;
    }
}

split
{


    //Chapter Splitting
    if(current.loadingStatus == 4 && old.loadingStatus != 4){
        return true;
    }
    
    //M23 frame perfect split
    if(current.m23 == 0 && old.m23 == 65537 && current.roomID == 65501){
        return true;
    }    
    
    //DoorSplitter for Costume Dante and SuperDante
    if(settings["Dante/SuperDante"]){
        //Pre Chapter 1
        if((current.roomID == 31616 && old.roomID == 7684 && vars.split == 0)
        ||
        //Chapter 1
        (current.roomID == 56356 && vars.split == 1)
        ||
        (current.roomID == 8886 && vars.split == 2)
        ||
        (current.roomID == 56356 && vars.split == 3)
        ||
        (current.roomID == 7684 && vars.split == 4)
        ||
        (current.roomID == 0 && vars.split == 5)
        ||
        (current.roomID == 46 && vars.split == 6)
        ||
        (current.roomID == 0 && vars.split == 7)
        ||
        //Chapter 2
        (current.roomID == 1152 && vars.split == 8)
        ||
        (current.roomID == 7172 && vars.split == 9)
        ||
        (current.roomID == 512 && vars.split == 10)
        ||
        (current.roomID == 9221 && vars.split == 11)
        ||
        (current.roomID == 1152 && vars.split == 12)
        ||
        (current.roomID == 7172 && vars.split == 13)
        //Chapter 3
        ||
        (current.roomID == 59282 && vars.split == 14)
        ||
        (current.roomID == 35340 && vars.split == 15)
        ||
        (current.roomID == 59282 && vars.split == 16)
        ||
        (current.roomID == 22 && vars.split == 17)
        //Chapter 4
        ||
        (current.roomID == 512 && vars.split == 18)
        ||
        (current.roomID == 0 && vars.split == 19)
        ||
        (current.roomID == 32768 && vars.split == 20)
        ||
        (current.roomID == 7848 && vars.split == 21)
        //Chapter 5
        ||
        (current.roomID == 32768 && vars.split == 22)
        ||
        (current.roomID == 0 && vars.split == 23)
        //Chapter 6
        ||
        (current.roomID == 42436 && vars.split == 24)
        ||
        (current.roomID == 8192 && vars.split == 25)
        ||
        (current.roomID == 2390 && vars.split == 26)
        //Chapter 7
        ||
        (current.roomID == 8192 && vars.split == 27)
        ||
        (current.roomID == 0 && vars.split == 28)
        ||
        (current.roomID == 32768 && vars.split == 29)
        //Pre Chapter 8
        ||
        (current.roomID == 12036 && vars.split == 30)
        //Chapter 8
        ||
        (current.roomID == 46256 && vars.split == 31)
        ||
        (current.roomID == 27339 && vars.split == 32)
        ||
        (current.roomID == 65295 && vars.split == 33)
        ||
        (current.roomID == 8886 && vars.split == 34)
        ||
        (current.roomID == 56356 && vars.split == 35)
        //Chapter 9
        ||
        (current.roomID == 12292 && vars.split == 36)
        ||
        (current.roomID == 2346 && vars.split == 37)
        ||
        (current.roomID == 12292 && vars.split == 38)
        ||
        (current.roomID == 60608 && vars.split == 39)
        ||
        (current.roomID == 13317 && vars.split == 40)
        //Chapter 10
        ||
        (current.roomID == 46336 && vars.split == 41)
        //Chapter 11
        ||
        (current.roomID == 256 && vars.split == 42)
        ||
        (current.roomID == 47224 && vars.split == 43)
        ||
        (current.roomID == 256 && vars.split == 44)
        ||
        (current.roomID == 47224 && vars.split == 45)
        ||
        (current.roomID == 4088 && vars.split == 46)
        //Chapter 12
        ||
        (current.roomID == 0 && vars.split == 47)
        ||
        (current.roomID == 9732 && vars.split == 48)
        ||
        (current.roomID == 51276 && vars.split == 49)
        ||
        (current.roomID == 504 && vars.split == 50)
        //Chapter 13
        ||
        (current.roomID == 17584 && vars.split == 51)
        ||
        (current.roomID == 64928 && vars.split == 52)
        ||
        (current.roomID == 7856 && vars.split == 53)
        //Pre Chapter 14
        ||
        (current.roomID == 20896 && vars.split == 54)
        //Chapter 14
        ||
        (current.roomID == 22477 && vars.split == 55)
        ||
        (current.roomID == 6919 && vars.split == 56)
        ||
        (current.roomID == 41724 && vars.split == 57)
        //Chapter 15
        ||
        (current.roomID == 15023 && vars.split == 58)
        ||
        (current.roomID == 4 && vars.split == 59)
        ||
        (current.roomID == 15023 && vars.split == 60)
        ||
        (current.roomID == 64345 && vars.split == 61)
        ||
        (current.roomID == 45072 && vars.split == 62)
        ||
        (current.roomID == 4 && vars.split == 63)
        //Chapter 16
        ||
        (current.roomID == 45072 && vars.split == 64)
        ||
        (current.roomID == 64345 && vars.split == 65)
        ||
        (current.roomID == 0 && vars.split == 66)
        ||
        (current.roomID == 34784 && vars.split == 67)
        ||
        (current.roomID == 36414 && vars.split == 68)
        ||
        (current.roomID == 27539 && vars.split == 69)
        ||
        (current.roomID == 27008 && vars.split == 70)
        ||
        (current.roomID == 7685 && vars.split == 71)
        ||
        (current.roomID == 34727 && vars.split == 72)
        ||
        (current.roomID == 24896 && vars.split == 73)
        //Chapter 17
        ||
        (current.roomID == 256 && vars.split == 74)
        ||
        (current.roomID == 39338 && vars.split == 75)
        ||
        (current.roomID == 4870 && vars.split == 76)
        ||
        (current.roomID == 26805 && vars.split == 77)
        ||
        (current.roomID == 4870 && vars.split == 78)
        ||
        (current.roomID == 4454 && vars.split == 79)
        //Chapter 18
        ||
        (current.roomID == 256 && vars.split == 80)
        ||
        (current.roomID == 27403 && vars.split == 81)
        ||
        (current.roomID == 256 && vars.split == 82)
        ||
        (current.roomID == 21568 && vars.split == 83)
        ||
        (current.roomID == 23448 && vars.split == 84)
        //Chapter 19
        ||
        (current.roomID == 256 && vars.split == 85)
        ||
        (current.roomID == 57320 && vars.split == 86)
        ||
        (current.roomID == 24896 && vars.split == 87)
        ||
        (current.roomID == 39700 && vars.split == 88)
        ||
        (current.roomID == 4442 && vars.split == 89)
        ||
        (current.roomID == 18184 && vars.split == 90)
        ||
        (current.roomID == 4442 && vars.split == 91)
        ||
        (current.roomID == 39700 && vars.split == 92)
        ||
        (current.roomID == 24896 && vars.split == 93)
        ||
        (current.roomID == 7685 && vars.split == 94)
        ||
        (current.roomID == 8964 && vars.split == 95)
        //Chapter 20
        ||
        (current.roomID == 20408 && vars.split == 96)
        //Chapter 21
        ||
        (current.roomID == 52440 && vars.split == 97)
        ||
        (current.roomID == 552 && vars.split == 98)
        ||
        (current.roomID == 64483 && vars.split == 99)
        ||
        (current.roomID == 14842 && vars.split == 100)
        ||
        (current.roomID == 52440 && vars.split == 101)
        //Chapter 22
        ||
        (current.roomID == 256 && vars.split == 102)
        //Chapter 23
        ||
        (current.roomID == 52440 && vars.split == 103)
        ||
        (current.roomID == 552 && vars.split == 104)
        ||
        (current.roomID == 20408 && vars.split == 105)
        ||
        (current.roomID == 1398 && vars.split == 106)
        ||
        (current.roomID == 8964 && vars.split == 107)
        //Chapter 23 v2
        ||
        (current.roomID == 27008 && vars.split == 108)
        ||
        (current.roomID == 27539 && vars.split == 109)
        ||
        (current.roomID == 3080 && vars.split == 110)
        ||
        (current.roomID == 33843 && vars.split == 111)){
            vars.split++;
            return true;
        }
    }
}

reset
{
    //Reset if we are in the main menu
    if(current.menu == 517){
        vars.split = 0;
        vars.chapter = 0;
        return true;
    }
}

isLoading
{
    //Stop the timer when entering the menu and being on one of the 5 possible menu selections
    if(current.pause == 1 || current.pause == 257 || current.pause == 513 || current.pause == 769 || current.pause == 1025){
        return true;
    }
    else{
        return false;
    }
}


