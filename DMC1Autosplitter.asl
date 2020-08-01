//***********************************************Created by Mysterion_06_*************************************************
//DMC1 Autosplitter

state("dmc1")
{
    int LoadingScreen: 0x28965D8;                   //Loadingscreen when opening the menu or when going through doors
    ushort roomID: 0x5eab88, 0x56e1830;
    int RS: 0x452AA14;
    int menu: 0x5eab88, 0x2a10;
    int loadingStatus : 0x5eab88, 0x2780;
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
    settings.Add("Dante");
    settings.Add("Legendary Dark Knight");
    settings.Add("Super Dante");
}

start
{
    if(current.menu != 266 && old.menu == 266){
        vars.split = 0;
        vars.chapter = 0;
        return true;
    }
}
split
{
    // if(settings["DoorSplitter"]){
    //     if((current.roomID == 7684 && old.roomID == 611 && vars.split == 0)
    //     ||
    //     (current.roomID == 56356 && old.roomID == 7684 && vars.split == 1)){
    //         vars.split++;
    //         return true;
    //     }
    // }
    if(current.loadingStatus == 4 && old.loadingStatus != 4){
        return true;
    }
}

reset
{
    if(current.menu == 517){
        return true;
    }
}


