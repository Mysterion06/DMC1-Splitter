//***********************************************Created by Mysterion_06_*************************************************
//DMC1 Autosplitter

state("dmc1")
{
    ushort roomID:      0x5eab88, 0x56e1830;         //The roomID's of the game
    int menu:           0x5eab88, 0x2a10;            //When you are in the menu, used to reset the splitter or start the splitter
    byte loadingStatus: 0x5eab88, 0x2780;            //A status that shows in what position of the game you are in, used to split Chapters
    byte paused:        0x5EAB88, 0x0c;
    int cutscene:       0x4CB3914;                   //Jumps up to 65537 when a cutscene is played, used to frame perfect split M23    
    int pause:          0x4CB3034;                   //5 different Values to show that the game is paused, can be used to stop the timer upon pausing
    byte loadingScreen: 0x3F533A0;
}

startup
{
    settings.Add("NoSF", false, "ONLY tick this if you play without a savefile");

    settings.Add("Doorsplitter", false, "DoorSplitter");
    settings.CurrentDefaultParent = "Doorsplitter";
    settings.Add("DSD", false, "Dante/SuperDante");
    settings.Add("LDK", false, "Legendary Dark Knight");
}

init
{
    vars.split = 0;

    vars.doorSplitDSD = new List<Tuple<int, int>>{
        //Mission 1
        Tuple.Create(56356, 1),
        Tuple.Create(8886, 2),
        Tuple.Create(56356, 3),
        Tuple.Create(7684, 4),
        Tuple.Create(0, 5),
        Tuple.Create(46, 6),
        Tuple.Create(0, 7),
        //Mission 2
        Tuple.Create(1152, 8),
        Tuple.Create(7172, 9),
        Tuple.Create(512, 10),
        Tuple.Create(9221, 11),
        Tuple.Create(1152, 12),
        Tuple.Create(7172, 13),
        //Mission 3
        Tuple.Create(59282, 14),
        Tuple.Create(35340, 15),
        Tuple.Create(59282, 16),
        Tuple.Create(22, 17),
        //Mission 4
        Tuple.Create(512, 18),
        Tuple.Create(0, 19),
        Tuple.Create(32768, 20),
        Tuple.Create(7848, 21),
        //Mission 5
        Tuple.Create(32768, 22),
        Tuple.Create(0, 23),
        //Mission 6
        Tuple.Create(42436, 24),
        Tuple.Create(8192, 25),
        Tuple.Create(2390, 26),
        //Mission 7
        Tuple.Create(8192, 27),
        Tuple.Create(0, 28),
        Tuple.Create(32768, 29),
        //Pre Mission 8
        Tuple.Create(12036, 30),
        //Mission 8
        Tuple.Create(46256, 31),
        Tuple.Create(27339, 32),
        Tuple.Create(65295, 33),
        Tuple.Create(8886, 34),
        Tuple.Create(56356, 35),
        //Mission 9
        Tuple.Create(12292, 36),
        Tuple.Create(2346, 37),
        Tuple.Create(12292, 38),
        Tuple.Create(60608, 39),
        Tuple.Create(13317, 40),
        //Mission 10
        Tuple.Create(46336, 41),
        //Mission 11
        Tuple.Create(256, 42),
        Tuple.Create(47224, 43),
        Tuple.Create(256, 44),
        Tuple.Create(47224, 45),
        Tuple.Create(4088, 46),
        //Mission 12
        Tuple.Create(0, 47),
        Tuple.Create(9732, 48),
        Tuple.Create(51276, 49),
        Tuple.Create(504, 50),
        //Mission 13
        Tuple.Create(17584, 51),
        Tuple.Create(64928, 52),
        Tuple.Create(7856, 53),
        //Pre Mission 14
        Tuple.Create(20896, 54),
        //Mission 14
        Tuple.Create(22477, 55),
        Tuple.Create(6919, 56),
        Tuple.Create(4, 57),
        //Mission 15
        Tuple.Create(15023, 58),
        Tuple.Create(4, 59),
        Tuple.Create(15023, 60),
        Tuple.Create(64345, 61),
        Tuple.Create(45072, 62),
        Tuple.Create(4, 63),
        //Mission 16
        Tuple.Create(45072, 64),
        Tuple.Create(64345, 65),
        Tuple.Create(0, 66),
        Tuple.Create(34784, 67),
        Tuple.Create(36414, 68),
        Tuple.Create(27539, 69),
        Tuple.Create(27008, 70),
        Tuple.Create(7685, 71),
        Tuple.Create(25896, 72),
        //Mission 17
        Tuple.Create(256, 73),
        Tuple.Create(39338, 74),
        Tuple.Create(4870, 75),
        Tuple.Create(26805, 76),
        Tuple.Create(4870, 77),
        Tuple.Create(4454, 78),
        //Mission 18
        Tuple.Create(256, 79),
        Tuple.Create(27403, 80),
        Tuple.Create(256, 81),
        Tuple.Create(21568, 82),
        Tuple.Create(23448, 83),
        //Mission 19
        Tuple.Create(256, 84),
        Tuple.Create(57320, 85),
        Tuple.Create(24896, 86),
        Tuple.Create(39700, 87),
        Tuple.Create(4442, 88),
        Tuple.Create(18184, 89),
        Tuple.Create(4442, 90),
        Tuple.Create(39700, 91),
        Tuple.Create(24896, 92),
        Tuple.Create(7685, 93),
        Tuple.Create(8964, 94),
        //Mission 20
        Tuple.Create(20408, 95),
        //Mission 21
        Tuple.Create(52440, 96),
        Tuple.Create(552, 97),
        Tuple.Create(64483, 98),
        Tuple.Create(14842, 99),
        Tuple.Create(52440, 100),
        //Mission 22
        Tuple.Create(256, 101),
        //Mission 23
        Tuple.Create(52440, 102),
        Tuple.Create(552, 103),
        Tuple.Create(20408, 104),
        Tuple.Create(1398, 105),
        Tuple.Create(8964, 106),
        //Mission 23 v2
        Tuple.Create(7685, 107),
        Tuple.Create(27008, 108),
        Tuple.Create(27539, 109),
        Tuple.Create(3080, 110),
        Tuple.Create(33843, 111),
    };

    vars.doorSplitLDK = new List<Tuple<int, int>>{
        //Mission 1
        Tuple.Create(1408, 1),
        Tuple.Create(43792, 2),
        Tuple.Create(1408, 3),
        Tuple.Create(12550, 4),
        Tuple.Create(3998, 5),
        Tuple.Create(12552, 6),
        Tuple.Create(3998, 7),
        //Mission 2
        Tuple.Create(1152, 8),
        Tuple.Create(7684, 9),
        Tuple.Create(33960, 10),
        Tuple.Create(10757, 11),
        Tuple.Create(1152, 12),
        Tuple.Create(7684, 13),
        //Mission 3
        Tuple.Create(28664, 14),
        Tuple.Create(57344, 15),
        Tuple.Create(28664, 16),
        Tuple.Create(774, 17),
        //Mission 4
        Tuple.Create(33960, 18),
        Tuple.Create(26848, 19),
        Tuple.Create(46284, 20),
        Tuple.Create(46768, 21),
        //Mission 5
        Tuple.Create(46284, 22),
        Tuple.Create(26848, 23),
        //Mission 6
        Tuple.Create(3144, 24),
        Tuple.Create(968, 25),
        Tuple.Create(2467, 26),
        //Mission 7
        Tuple.Create(968, 27),
        Tuple.Create(26848, 28),
        Tuple.Create(46284, 29),
        //Pre Mission 8
        Tuple.Create(19461, 30),
        //Mission 8
        Tuple.Create(58731, 31),
        Tuple.Create(6656, 32),
        Tuple.Create(65293, 33),
        Tuple.Create(43792, 34),
        Tuple.Create(1408, 35),
        //Mission 9
        Tuple.Create(1018, 36),
        Tuple.Create(1175, 37),
        Tuple.Create(1018, 38),
        Tuple.Create(23520, 39),
        Tuple.Create(19461, 40),
        //Mission 10
        Tuple.Create(61584, 41),
        //Mission 11
        Tuple.Create(2, 42),
        Tuple.Create(60736, 43),
        Tuple.Create(2, 44),
        Tuple.Create(60736, 45),
        Tuple.Create(4096, 46),
        //Mission 12
        Tuple.Create(32041, 47),
        Tuple.Create(9735, 48),
        Tuple.Create(28320, 49),
        Tuple.Create(504, 50),
        //Mission 13
        Tuple.Create(60360, 51),
        Tuple.Create(3848, 52),
        Tuple.Create(7941, 53),
        //Pre Mission 14
        Tuple.Create(28928, 54),
        //Mission 14
        Tuple.Create(49829, 55),
        Tuple.Create(6919, 56),
        Tuple.Create(9536, 57),
        //Mission 15
        Tuple.Create(40587, 58),
        Tuple.Create(7943, 59),
        Tuple.Create(40587, 60),
        Tuple.Create(15304, 61),
        Tuple.Create(57344, 62),
        Tuple.Create(7943, 63),
        //Mission 16
        Tuple.Create(57344, 64),
        Tuple.Create(15304, 65),
        Tuple.Create(32768, 66),
        Tuple.Create(2704, 67),
        Tuple.Create(15910, 68),
        Tuple.Create(62471, 69),
        Tuple.Create(42288, 70),
        Tuple.Create(1027, 71),
        Tuple.Create(8964, 72),
        //Mission 17
        Tuple.Create(256, 73),
        Tuple.Create(42896, 74),
        Tuple.Create(6412, 75),
        Tuple.Create(13590, 76),
        Tuple.Create(6412, 77),
        Tuple.Create(58112, 78),
        //Mission 18
        Tuple.Create(256, 79),
        Tuple.Create(19314, 80),
        Tuple.Create(256, 81),
        Tuple.Create(7320, 82),
        Tuple.Create(13806, 83),
        //Mission 19
        Tuple.Create(256, 84),
        Tuple.Create(42624, 85),
        Tuple.Create(47264, 86),
        Tuple.Create(31792, 87),
        Tuple.Create(44022, 88),
        Tuple.Create(45310, 89),
        Tuple.Create(44022, 90),
        Tuple.Create(31792, 91),
        Tuple.Create(47624, 92),
        Tuple.Create(1024, 93),
        Tuple.Create(8694, 94),
        //Mission 20
        Tuple.Create(20552, 95),
        //Mission 21
        Tuple.Create(4482, 96),
        Tuple.Create(833, 97),
        Tuple.Create(169, 98),
        Tuple.Create(36868, 99),
        Tuple.Create(4482, 100),
        //Mission 22
        Tuple.Create(256, 101),
        Tuple.Create(4096, 102),
        //Mission 23
        Tuple.Create(4482, 103),
        Tuple.Create(833, 104),
        Tuple.Create(20552, 105),
        Tuple.Create(1065, 106),
        Tuple.Create(8964, 107),
        //Mission 23 v2
        Tuple.Create(1024, 108),
        Tuple.Create(42288, 109),
        Tuple.Create(62471, 110),
        Tuple.Create(30217, 111),
        Tuple.Create(50818, 112),
    };
}

update{
    if (timer.CurrentPhase == TimerPhase.NotRunning)
    {
        vars.split = 0;
    }
}

start
{
    //Start the timer upon choosing the difficulty and reset split + chapter back to 0
    if(current.menu != 266 && old.menu == 266){
        vars.split = 0;
        return true;
    }

    //Starts the timer if you play without a savefile
    if(current.menu != 517 && old.menu == 517 && settings["NoSF"]){
        vars.split = 0;
        return true;
    }
}

split
{
    //Chapter Splitting
    if(current.loadingStatus == 4 && old.loadingStatus != 4){
        return true;
    }
    
    //M23 final split
    if(current.cutscene == 0 && old.cutscene == 65537 && current.roomID == 65501 || current.cutscene == 0 && old.cutscene == 65537 && current.roomID == 562){
        return true;
    }    
    
    //DoorSplitter for Costume Dante and SuperDante
    if(settings["DSD"]){
        if(current.roomID == 31616 && old.roomID == 7684 && vars.split == 0 || vars.doorSplitDSD.Contains(Tuple.Create(current.roomID, vars.split))){
            vars.split++;
            return true;        
        }
    }

    //DoorSplitter for Legendary Dark Knight Costume
    if(settings["Legendary Dark Knight"]){
        if(current.roomID == 12550 && vars.split == 0 || vars.doorSplitLDK.Contains(Tuple.Create(current.roomID, vars.split))){
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
    if(current.pause == 1 || current.pause == 257 || current.pause == 513 || current.pause == 769 || current.pause == 1025 || 
    current.loadingStatus == 1 && current.paused != 1 || current.loadingScreen == 16 && current.paused == 0){
       return true;
    }
    else{
        return false;
    }
}
