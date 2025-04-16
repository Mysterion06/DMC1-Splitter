//***********************************************Created by Mysterion_06_*************************************************
//Updated by Muty
//Changelog:
//-Reworked chapter splitting and fixed splitting on death
//-Tweaked final split logic so it is more likely to split after plane cutscene
//-Fixed doorsplitter and removed custome dependency. Doorsplitter is now flexible for all 3 main categories(Any%,All Collectibles,100%)
//-Added Blue Orb and Blue Orb Fragment splitting
//DMC1 Autosplitter

state("dmc1")
{
    byte roomNumber:    "dmc1.exe", 0x279E6B4;               //Room Number, used for doorsplitting
    ushort missionNumber: "dmc1.exe", 0x00488B60, 0x44;      //Mission Number, used to split chapters
    int menu:           0x5eab88, 0x2a10;            	     //When you are in the menu, used to reset the splitter or start the splitter
    int loadingStatus:  0x5eab88, 0x2780;            	     //A status that shows in what position of the game you are in, helps pause the timer
    byte paused:        0x5EAB88, 0x0c;
    bool cutscene:      "dmc1.exe", 0x04CB3848, 0x154;        
    int pause:          0x4CB3034;                   	     //5 different Values to show that the game is paused, can be used to stop the timer upon pausing
    byte loadingScreen: 0x3F533A0;
    byte fragment:	"dmc1.exe", 0x0060B158, 0x0, 0x7D4;  //Blue Orb Fragment count
    ushort maxHP:       "dmc1.exe", 0x04CB3340, 0x418;       //Max HP of Dante, used to split for full Blue Orbs
    ushort totalSaves:  "dmc1.exe", 0x00488B60, 0x40;        //unused, feel free to implement if you can find a use for it(anti-cheat measurement)
}

startup
{
    settings.Add("NoSF", false, "ONLY tick this if you play without a savefile");
    settings.Add("Fragment", false, "Split on Blue Orbs/Fragments");
    settings.Add("RS", false, "Roomsplitter");
}

init
{
    refreshRate = 60;
    vars.split = 0;
}

update
{
    if (timer.CurrentPhase == TimerPhase.NotRunning)
    {
        vars.split = 0;
    }
}

start
{
    //Start the timer upon choosing the difficulty and reset split + chapter back to 0
    if(current.menu != 266 && old.menu == 266)
    {
        vars.split = 0;
        return true;
    }

    //Starts the timer if you play without a savefile
    if(current.menu != 517 && old.menu == 517 && settings["NoSF"])
    {
        vars.split = 0;
        return true;
    }
}

split
{
    //Mission Splitting
    if(current.missionNumber < old.missionNumber
    || (current.missionNumber == 1 && old.missionNumber == 0))          //pre-M1/reset/Intermission catch
    {
        return false;
    }
    else if(current.missionNumber != old.missionNumber)
    {
        return true;
    }
    
    //M23 final split
    if(current.roomNumber == 14 && current.missionNumber == 23 && (current.cutscene == false && old.cutscene == true))
    {
        return true;
    }   

 
    //Blue Orbs
    if(settings["Fragment"])
    {
        if(current.fragment < old.fragment
	|| (current.maxHP < old.maxHP))              // checks for reset and also removes redundant split when fragments become full
        {
        	return false;
        }
	else if((current.fragment == old.fragment + 1 && old.loadingStatus != 0)            // avoids savequit split
        || (current.maxHP == old.maxHP + 100 && current.loadingStatus != 1))		    // avoids split on buying blue orbs
	    	{
		    return true;
        	}
    }



    //RoomSplitter
    if(settings["RS"])
    {
        if(current.missionNumber == 0 && (current.roomNumber == 2 || current.roomNumber == 33)) // don't split on intro cutscene
        {
            return false;
        }
        if((current.missionNumber == 2 && (old.roomNumber == 27 && current.roomNumber == 8))
        || (current.missionNumber == 3 && (old.roomNumber == 8 && current.roomNumber == 10))
        || (current.missionNumber == 4 && (old.roomNumber == 10 && current.roomNumber == 8))
        || (current.missionNumber == 4 && (old.roomNumber == 8 && current.roomNumber == 10)) //M4 Secret Mission Filter
        || (current.missionNumber == 6 && (old.roomNumber == 6 && current.roomNumber == 25))
        || (current.missionNumber == 9 && (old.roomNumber == 1 && current.roomNumber == 0))
        || (current.missionNumber == 10 && (old.roomNumber == 5 && current.roomNumber == 20))
        || (current.missionNumber == 10 && (old.roomNumber == 20 && current.roomNumber == 21))
        || (current.missionNumber == 11 && (old.roomNumber == 21 && current.roomNumber == 6))
        || (current.missionNumber == 11 && (old.roomNumber == 6 && current.roomNumber == 21)) //M11 Secret Mission Filter
        || (current.missionNumber == 12 && (old.roomNumber == 7 && current.roomNumber == 0))
        || (current.missionNumber == 13 && (old.roomNumber == 6 && current.roomNumber == 5))
        || (current.missionNumber == 269 && (old.roomNumber == 8 && current.roomNumber == 7))
        || (current.missionNumber == 15 && (old.roomNumber == 9 && current.roomNumber == 1))    
        || (current.missionNumber == 16 && (old.roomNumber == 18 && current.roomNumber == 3)) //Arena Secret Mission Filter
        || (current.missionNumber == 17 && (old.roomNumber == 12 && current.roomNumber == 2))
        || (current.missionNumber == 20 && (old.roomNumber == 39 && current.roomNumber == 0))
        || (current.missionNumber == 21 && (old.roomNumber == 1 && current.roomNumber == 2))
        || (current.missionNumber == 22 && (old.roomNumber == 5 && current.roomNumber == 8))
        || (current.missionNumber == 22 && (old.roomNumber == 9 && current.roomNumber == 13)) //I SHOULD HAVE BEEN THE ONE TO FILL YOU DARK SOUL WITH LIIIIIIIIIIIIIIIIIIIIGHT
        || (current.missionNumber == 23 && (old.roomNumber == 27 && current.roomNumber == 10))
        || (current.missionNumber == 23 && (old.roomNumber == 12 && current.roomNumber == 13))
        || (current.missionNumber == 23 && (old.roomNumber == 13 && current.roomNumber == 14)))
        {
            return false;   //Filters redundant splits between Mission ending and the loading screen for next Mission start. Needs better implementation, since this looks disgusting
        }
        else if ((current.roomNumber != old.roomNumber) 
        || (current.missionNumber == 10 && current.roomNumber == 20 && current.loadingStatus == 1 && old.loadingStatus == 2)) //Mission 10 repeats room twice
        {
            return true;
        }
    }
}

reset
{
    //Reset if we are in the main menu
    if(current.menu == 517)
    {
        vars.split = 0;
        vars.chapter = 0;
        return true;
    }
}

isLoading
{
    //Stop the timer when entering the menu and being on one of the 5 possible menu selections
    if(current.pause == 1 || current.pause == 257 || current.pause == 513 || current.pause == 769 || current.pause == 1025 || 
    current.loadingStatus == 1 && current.paused != 1 || current.loadingScreen == 16 && current.paused == 0)
    {
       return true;
    }
    else
    {
       return false;
    }
}