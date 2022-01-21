Scriptname MEKCGSModInitialization extends ReferenceAlias 

Weapon Property MEKCGSIronGreatchair Auto
Weapon Property MEKCGSSteelGreatchair Auto
Weapon Property MEKCGSOrcishGreatchair Auto
Weapon Property MEKCGSDwarvenGreatchair Auto
Weapon Property MEKCGSElvenGreatchair Auto
Weapon Property MEKCGSGlassGreatchair Auto
Weapon Property MEKCGSEbonyGreatchair Auto
Weapon Property MEKCGSDaedricGreatchair Auto


LeveledItem Property LItemWeaponDwarvenGreatSword Auto
LeveledItem Property LItemWerewolfBossGreatsword Auto
LeveledItem Property LItemSoldierSonsGreatsword Auto
LeveledItem Property LItemWeaponGreatSwordTown Auto
LeveledItem Property LItemWeaponGreatSword Auto
LeveledItem Property LItemBanditGreatsword Auto
LeveledItem Property DLC2LItemWeaponGreatSwordTown Auto
LeveledItem Property LItemWeaponGreatSwordNotOrcish Auto
LeveledItem Property DLC2LItemWeaponGreatSword Auto
LeveledItem Property LItemWeaponGreatSwordSpecial Auto
LeveledItem Property LItemBlacksmithMinGreatsword Auto
LeveledItem Property LItemOrcStrongholdGreatsword Auto
LeveledItem Property LItemWeaponGreatSwordBlacksmith Auto
LeveledItem Property LItemWeaponGreatSwordBest Auto
LeveledItem Property LItemBanditBossGreatsword Auto
LeveledItem Property DLC2LItemWeaponGreatSwordDremora Auto
LeveledItem Property LItemDwarvenOnlyWeapons Auto
LeveledItem Property LItemDraugr05EWeapon2H Auto
LeveledItem Property SublistWeaponGreatswordDaedricBest05 Auto
LeveledItem Property SublistWeaponGreatswordDaedric05 Auto
LeveledItem Property DLC1LItemDaedricWeapon Auto

float Property StoredModVersion = 0.0 Auto
float Property StoredImmersiveWeaponsVersion = 0.0 Auto
float Property StoredBaseLeveledListsVersion = 0.0 Auto
float Property StoredValdacilsItemSortingVersion = 0.0 Auto

string ImmersiveWeapons = "Immersive Weapons.esp"
string ValdacilsItemSorting = "ValdacilsItemSorting.esp"
string UpdateText = "Greatchairs Updated to "
string LogPrefix = "[Greatchairs] "

Event OnInit()
    RegisterForSingleUpdate(10.0)
EndEvent

Event OnPlayerLoadGame()
    RegisterForSingleUpdate(10.0)
EndEvent

Event OnUpdate()
    If (StoredModVersion < 1.0)
        Maintenance()
        StoredModVersion = 1.0
        Debug.Notification(UpdateText + "1.0")
    Else
        Maintenance()
    EndIf
EndEvent

Function Maintenance()
    Debug.Trace(LogPrefix + "=================Maintenance Start=================")
    UpdateBaseLeveledLists1_0()
    UpdateImmersvieWeapons1_0()
    UpdateValdacilsItemSorting1_0()
    Debug.Trace(LogPrefix + "=================Maintenance End===================")
EndFunction

Function UpdateItemList(LeveledItem itemList, Form addItem, int itemLevel, int itemCount, int repeat = 1)
    int index = 0
    ; Try adding the item to Leveled Item List repeat number of times
    While (index < repeat)
        ; Leveled Lists can only have a max of 255 items, so skip if the list is full
        If (itemList.GetNumForms() == 255)
            ; break out of repeat loop
            index = repeat
            Debug.Trace(LogPrefix + "Skipping adding '" + addItem + "' to '" + itemList + "'. The list is full")
        Else
            Debug.Trace(LogPrefix + "Adding '" + addItem + "' Level '" + itemLevel + "' count '" + itemCount + "' to '" + itemList + "'")
            itemList.AddForm(addItem, itemLevel, itemCount)
        EndIf
        index += 1
    EndWhile
EndFunction

Function UpdateRemoteItemList(string ModName, int FormID, Form addItem, int itemLevel, int itemCount, int repeat = 1)
    Form listForm = Game.GetFormFromFile(FormID, ModName)
    If (listForm == None)
        Debug.Trace(LogPrefix + "Unable to find FormID '" + FormID + "' from '" + ModName + "' Skipping adding '" + addItem + "'" )
        Return
    EndIf
    UpdateItemList(listForm as LeveledItem, addItem, itemLevel, itemCount, repeat)
EndFunction

Function RenameWeaponValdacilsItemSorting(Weapon WeaponToRename)
    string prefix = "[2H Sword] "
    string oldName = WeaponToRename.GetName()
    If (StringUtil.Find(oldName, prefix) != -1)
        Debug.Trace(LogPrefix + "'" + oldName + "' is already correct on '" + WeaponToRename + "'")
        Return
    EndIf
    string newName = prefix + oldName
    Debug.Trace(LogPrefix + "Renaming '" + oldName + "' to '" + newName + "' on '" + WeaponToRename + "'")
    WeaponToRename.SetName(newName)
EndFunction

Function UpdateBaseLeveledLists1_0()
    If (StoredBaseLeveledListsVersion < 1.0)
        StoredBaseLeveledListsVersion = 1.0
    Else
        Return
    EndIf
    Debug.Trace(LogPrefix + "==========Updating Base Game Leveled Lists=========")
    UpdateItemList(LItemWeaponDwarvenGreatSword, MEKCGSIronGreatchair, 1, 1, 1)
    UpdateItemList(LItemWeaponDwarvenGreatSword, MEKCGSSteelGreatchair, 4, 1, 1)
    UpdateItemList(LItemWeaponDwarvenGreatSword, MEKCGSDwarvenGreatchair, 12, 1, 1)

    UpdateItemList(LItemWerewolfBossGreatsword, MEKCGSIronGreatchair, 1, 1, 1)
    UpdateItemList(LItemWerewolfBossGreatsword, MEKCGSSteelGreatchair, 1, 1, 1)
    UpdateItemList(LItemWerewolfBossGreatsword, MEKCGSOrcishGreatchair, 6, 1, 1)
    UpdateItemList(LItemWerewolfBossGreatsword, MEKCGSDwarvenGreatchair, 12, 1, 1)
    UpdateItemList(LItemWerewolfBossGreatsword, MEKCGSElvenGreatchair, 19, 1, 1)
    UpdateItemList(LItemWerewolfBossGreatsword, MEKCGSGlassGreatchair, 27, 1, 1)
    UpdateItemList(LItemWerewolfBossGreatsword, MEKCGSEbonyGreatchair, 36, 1, 1)

    UpdateItemList(LItemSoldierSonsGreatsword, MEKCGSIronGreatchair, 1, 1, 2)
    UpdateItemList(LItemSoldierSonsGreatsword, MEKCGSSteelGreatchair, 5, 1, 1)
    UpdateItemList(LItemSoldierSonsGreatsword, MEKCGSSteelGreatchair, 6, 1, 1)
    UpdateItemList(LItemSoldierSonsGreatsword, MEKCGSSteelGreatchair, 7, 1, 2)
    UpdateItemList(LItemSoldierSonsGreatsword, MEKCGSSteelGreatchair, 10, 1, 1)
    UpdateItemList(LItemSoldierSonsGreatsword, MEKCGSSteelGreatchair, 11, 1, 1)
    UpdateItemList(LItemSoldierSonsGreatsword, MEKCGSSteelGreatchair, 12, 1, 1)
    UpdateItemList(LItemSoldierSonsGreatsword, MEKCGSSteelGreatchair, 13, 1, 1)

    UpdateItemList(LItemWeaponGreatSwordTown, MEKCGSIronGreatchair, 1, 1, 2)
    UpdateItemList(LItemWeaponGreatSwordTown, MEKCGSSteelGreatchair, 4, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordTown, MEKCGSSteelGreatchair, 5, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordTown, MEKCGSSteelGreatchair, 6, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordTown, MEKCGSSteelGreatchair, 7, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordTown, MEKCGSOrcishGreatchair, 13, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordTown, MEKCGSDwarvenGreatchair, 18, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordTown, MEKCGSElvenGreatchair, 23, 1, 1)

    UpdateItemList(LItemWeaponGreatSword, MEKCGSIronGreatchair, 1, 1, 1)
    UpdateItemList(LItemWeaponGreatSword, MEKCGSSteelGreatchair, 2, 1, 1)
    UpdateItemList(LItemWeaponGreatSword, MEKCGSSteelGreatchair, 3, 1, 1)
    UpdateItemList(LItemWeaponGreatSword, MEKCGSSteelGreatchair, 4, 1, 1)
    UpdateItemList(LItemWeaponGreatSword, MEKCGSOrcishGreatchair, 6, 1, 1)
    UpdateItemList(LItemWeaponGreatSword, MEKCGSDwarvenGreatchair, 12, 1, 1)
    UpdateItemList(LItemWeaponGreatSword, MEKCGSElvenGreatchair, 19, 1, 1)
    UpdateItemList(LItemWeaponGreatSword, MEKCGSGlassGreatchair, 27, 1, 1)
    UpdateItemList(LItemWeaponGreatSword, MEKCGSEbonyGreatchair, 36, 1, 1)

    UpdateItemList(LItemBanditGreatsword, MEKCGSIronGreatchair, 1, 1, 1)
    UpdateItemList(LItemBanditGreatsword, MEKCGSSteelGreatchair, 1, 1, 1)
    UpdateItemList(LItemBanditGreatsword, MEKCGSIronGreatchair, 1, 1, 1)
    UpdateItemList(LItemBanditGreatsword, MEKCGSSteelGreatchair, 1, 1, 1)
    UpdateItemList(LItemBanditGreatsword, MEKCGSOrcishGreatchair, 9, 1, 1)
    UpdateItemList(LItemBanditGreatsword, MEKCGSDwarvenGreatchair, 15, 1, 1)
    UpdateItemList(LItemBanditGreatsword, MEKCGSElvenGreatchair, 22, 1, 1)

    UpdateItemList(DLC2LItemWeaponGreatSwordTown, MEKCGSIronGreatchair, 1, 1, 2)
    UpdateItemList(DLC2LItemWeaponGreatSwordTown, MEKCGSSteelGreatchair, 4, 1, 1)
    UpdateItemList(DLC2LItemWeaponGreatSwordTown, MEKCGSSteelGreatchair, 5, 1, 1)
    UpdateItemList(DLC2LItemWeaponGreatSwordTown, MEKCGSSteelGreatchair, 6, 1, 1)
    UpdateItemList(DLC2LItemWeaponGreatSwordTown, MEKCGSSteelGreatchair, 7, 1, 1)
    UpdateItemList(DLC2LItemWeaponGreatSwordTown, MEKCGSOrcishGreatchair, 13, 1, 1)
    UpdateItemList(DLC2LItemWeaponGreatSwordTown, MEKCGSDwarvenGreatchair, 18, 1, 1)
    UpdateItemList(DLC2LItemWeaponGreatSwordTown, MEKCGSElvenGreatchair, 23, 1, 1)

    UpdateItemList(LItemWeaponGreatSwordNotOrcish, MEKCGSIronGreatchair, 1, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordNotOrcish, MEKCGSSteelGreatchair, 2, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordNotOrcish, MEKCGSSteelGreatchair, 3, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordNotOrcish, MEKCGSSteelGreatchair, 4, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordNotOrcish, MEKCGSDwarvenGreatchair, 12, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordNotOrcish, MEKCGSElvenGreatchair, 19, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordNotOrcish, MEKCGSGlassGreatchair, 27, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordNotOrcish, MEKCGSEbonyGreatchair, 36, 1, 1)

    UpdateItemList(DLC2LItemWeaponGreatSword, MEKCGSIronGreatchair, 1, 1, 1)
    UpdateItemList(DLC2LItemWeaponGreatSword, MEKCGSSteelGreatchair, 2, 1, 1)
    UpdateItemList(DLC2LItemWeaponGreatSword, MEKCGSSteelGreatchair, 3, 1, 1)
    UpdateItemList(DLC2LItemWeaponGreatSword, MEKCGSSteelGreatchair, 4, 1, 1)
    UpdateItemList(DLC2LItemWeaponGreatSword, MEKCGSOrcishGreatchair, 6, 1, 1)
    UpdateItemList(DLC2LItemWeaponGreatSword, MEKCGSDwarvenGreatchair, 12, 1, 1)
    UpdateItemList(DLC2LItemWeaponGreatSword, MEKCGSElvenGreatchair, 19, 1, 1)
    UpdateItemList(DLC2LItemWeaponGreatSword, MEKCGSGlassGreatchair, 27, 1, 1)
    UpdateItemList(DLC2LItemWeaponGreatSword, MEKCGSEbonyGreatchair, 36, 1, 1)

    UpdateItemList(LItemWeaponGreatSwordSpecial, MEKCGSSteelGreatchair, 1, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordSpecial, MEKCGSOrcishGreatchair, 6, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordSpecial, MEKCGSDwarvenGreatchair, 12, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordSpecial, MEKCGSElvenGreatchair, 19, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordSpecial, MEKCGSGlassGreatchair, 27, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordSpecial, MEKCGSEbonyGreatchair, 36, 1, 1)

    UpdateItemList(LItemBlacksmithMinGreatsword, MEKCGSSteelGreatchair, 1, 1, 1)

    UpdateItemList(LItemOrcStrongholdGreatsword, MEKCGSSteelGreatchair, 1, 1, 1)
    UpdateItemList(LItemOrcStrongholdGreatsword, MEKCGSOrcishGreatchair, 6, 1, 1)

    UpdateItemList(LItemWeaponGreatSwordBlacksmith, MEKCGSSteelGreatchair, 1, 1, 2)
    UpdateItemList(LItemWeaponGreatSwordBlacksmith, MEKCGSOrcishGreatchair, 6, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordBlacksmith, MEKCGSDwarvenGreatchair, 12, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordBlacksmith, MEKCGSElvenGreatchair, 19, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordBlacksmith, MEKCGSGlassGreatchair, 27, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordBlacksmith, MEKCGSEbonyGreatchair, 36, 1, 1)

    UpdateItemList(LItemWeaponGreatSwordBest, MEKCGSSteelGreatchair, 1, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordBest, MEKCGSOrcishGreatchair, 6, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordBest, MEKCGSDwarvenGreatchair, 12, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordBest, MEKCGSElvenGreatchair, 19, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordBest, MEKCGSGlassGreatchair, 27, 1, 1)
    UpdateItemList(LItemWeaponGreatSwordBest, MEKCGSEbonyGreatchair, 36, 1, 1)

    UpdateItemList(LItemBanditBossGreatsword, MEKCGSSteelGreatchair, 1, 1, 1)
    UpdateItemList(LItemBanditBossGreatsword, MEKCGSOrcishGreatchair, 6, 1, 1)
    UpdateItemList(LItemBanditBossGreatsword, MEKCGSDwarvenGreatchair, 12, 1, 1)
    UpdateItemList(LItemBanditBossGreatsword, MEKCGSElvenGreatchair, 19, 1, 1)
    UpdateItemList(LItemBanditBossGreatsword, MEKCGSGlassGreatchair, 27, 1, 1)
    UpdateItemList(LItemBanditBossGreatsword, MEKCGSEbonyGreatchair, 36, 1, 1)

    UpdateItemList(DLC2LItemWeaponGreatSwordDremora, MEKCGSSteelGreatchair, 1, 1, 1)
    UpdateItemList(DLC2LItemWeaponGreatSwordDremora, MEKCGSOrcishGreatchair, 6, 1, 1)
    UpdateItemList(DLC2LItemWeaponGreatSwordDremora, MEKCGSDwarvenGreatchair, 13, 1, 1)
    UpdateItemList(DLC2LItemWeaponGreatSwordDremora, MEKCGSElvenGreatchair, 22, 1, 1)
    UpdateItemList(DLC2LItemWeaponGreatSwordDremora, MEKCGSGlassGreatchair, 30, 1, 1)
    UpdateItemList(DLC2LItemWeaponGreatSwordDremora, MEKCGSEbonyGreatchair, 40, 1, 1)
    UpdateItemList(DLC2LItemWeaponGreatSwordDremora, MEKCGSDaedricGreatchair, 51, 1, 1)

    UpdateItemList(LItemDwarvenOnlyWeapons, MEKCGSDwarvenGreatchair, 1, 1, 1)

    UpdateItemList(LItemDraugr05EWeapon2H, MEKCGSEbonyGreatchair, 1, 1, 1)

    UpdateItemList(SublistWeaponGreatswordDaedricBest05, MEKCGSEbonyGreatchair, 1, 1, 1)
    UpdateItemList(SublistWeaponGreatswordDaedricBest05, MEKCGSDaedricGreatchair, 1, 1, 1)

    UpdateItemList(SublistWeaponGreatswordDaedric05, MEKCGSDaedricGreatchair, 1, 1, 1)

    UpdateItemList(DLC1LItemDaedricWeapon, MEKCGSDaedricGreatchair, 1, 1, 1)
    Debug.Trace(LogPrefix + "==========Base Game Leveled Lists Updated==========")
EndFunction

Function UpdateImmersvieWeapons1_0()
    If (Game.GetModByName(ImmersiveWeapons) == 255)
        Return
    EndIf
    If (StoredImmersiveWeaponsVersion < 1.0)
        StoredImmersiveWeaponsVersion = 1.0
    Else
        Return
    EndIf
    Debug.Trace(LogPrefix + "Immersive Armors Detected. Updating leveled lists")

                                       int IWLIWeaponGreatsword = 0x0001CB24
    UpdateRemoteItemList(ImmersiveWeapons, IWLIWeaponGreatsword, MEKCGSIronGreatchair, 1, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIWeaponGreatsword, MEKCGSSteelGreatchair, 2, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIWeaponGreatsword, MEKCGSSteelGreatchair, 3, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIWeaponGreatsword, MEKCGSSteelGreatchair, 4, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIWeaponGreatsword, MEKCGSOrcishGreatchair, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIWeaponGreatsword, MEKCGSDwarvenGreatchair, 12, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIWeaponGreatsword, MEKCGSElvenGreatchair, 19, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIWeaponGreatsword, MEKCGSGlassGreatchair, 27, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIWeaponGreatsword, MEKCGSEbonyGreatchair, 36, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIWeaponGreatsword, MEKCGSDaedricGreatchair, 51, 1, 1)

                                       int IWLIBanditGreatsword = 0x0001D5FB
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBanditGreatsword, MEKCGSIronGreatchair, 1, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBanditGreatsword, MEKCGSSteelGreatchair, 2, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBanditGreatsword, MEKCGSSteelGreatchair, 3, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBanditGreatsword, MEKCGSSteelGreatchair, 4, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBanditGreatsword, MEKCGSOrcishGreatchair, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBanditGreatsword, MEKCGSDwarvenGreatchair, 12, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBanditGreatsword, MEKCGSElvenGreatchair, 19, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBanditGreatsword, MEKCGSGlassGreatchair, 27, 1, 1)

                                       int IWLISoldierSonsWeapon2H = 0x0001F0F6
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H, MEKCGSIronGreatchair, 1, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H, MEKCGSSteelGreatchair, 2, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H, MEKCGSSteelGreatchair, 3, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H, MEKCGSSteelGreatchair, 4, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H, MEKCGSOrcishGreatchair, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H, MEKCGSDwarvenGreatchair, 12, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H, MEKCGSElvenGreatchair, 19, 1, 1)

                                       int IWLITownGreatsword = 0x000365C3
    UpdateRemoteItemList(ImmersiveWeapons, IWLITownGreatsword, MEKCGSIronGreatchair, 1, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLITownGreatsword, MEKCGSIronGreatchair, 2, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLITownGreatsword, MEKCGSSteelGreatchair, 3, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLITownGreatsword, MEKCGSSteelGreatchair, 4, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLITownGreatsword, MEKCGSOrcishGreatchair, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLITownGreatsword, MEKCGSDwarvenGreatchair, 12, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLITownGreatsword, MEKCGSElvenGreatchair, 19, 1, 1)

                                       int IWLI_ListGreatsword = 0x0003CC22
    UpdateRemoteItemList(ImmersiveWeapons, IWLI_ListGreatsword, MEKCGSIronGreatchair, 1, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLI_ListGreatsword, MEKCGSSteelGreatchair, 2, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLI_ListGreatsword, MEKCGSOrcishGreatchair, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLI_ListGreatsword, MEKCGSDwarvenGreatchair, 12, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLI_ListGreatsword, MEKCGSElvenGreatchair, 19, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLI_ListGreatsword, MEKCGSGlassGreatchair, 27, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLI_ListGreatsword, MEKCGSEbonyGreatchair, 36, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLI_ListGreatsword, MEKCGSDaedricGreatchair, 51, 1, 1)

                                       int IWLIOrcGreatsword = 0x00040CE1
    UpdateRemoteItemList(ImmersiveWeapons, IWLIOrcGreatsword, MEKCGSSteelGreatchair, 1, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIOrcGreatsword, MEKCGSOrcishGreatchair, 6, 1, 1)

                                       int IWLIBestGreatsword = 0x00040CED
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBestGreatsword, MEKCGSSteelGreatchair, 4, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBestGreatsword, MEKCGSOrcishGreatchair, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBestGreatsword, MEKCGSDwarvenGreatchair, 12, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBestGreatsword, MEKCGSElvenGreatchair, 19, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBestGreatsword, MEKCGSGlassGreatchair, 27, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBestGreatsword, MEKCGSEbonyGreatchair, 36, 1, 1)

                                       int IWLIBlacksmithGreatsword = 0x00040CEE
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBlacksmithGreatsword, MEKCGSSteelGreatchair, 4, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBlacksmithGreatsword, MEKCGSOrcishGreatchair, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBlacksmithGreatsword, MEKCGSDwarvenGreatchair, 12, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBlacksmithGreatsword, MEKCGSElvenGreatchair, 19, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBlacksmithGreatsword, MEKCGSGlassGreatchair, 27, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBlacksmithGreatsword, MEKCGSEbonyGreatchair, 36, 1, 1)

                                       int IWLIDraugr2H = 0x000417C7
    UpdateRemoteItemList(ImmersiveWeapons, IWLIDraugr2H, MEKCGSSteelGreatchair, 4, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIDraugr2H, MEKCGSOrcishGreatchair, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIDraugr2H, MEKCGSDwarvenGreatchair, 12, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIDraugr2H, MEKCGSElvenGreatchair, 19, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIDraugr2H, MEKCGSGlassGreatchair, 27, 1, 1)

                                       int IWLIEbony2H = 0x000417CA
    UpdateRemoteItemList(ImmersiveWeapons, IWLIEbony2H, MEKCGSEbonyGreatchair, 1, 1, 1)

    Debug.Trace(LogPrefix + "Immersive Armors leveled lists updated.")
EndFunction

Function UpdateValdacilsItemSorting1_0()
    If (Game.GetModByName(ValdacilsItemSorting) == 255)
        Return
    EndIf
    If (StoredValdacilsItemSortingVersion < 1.0)
        StoredValdacilsItemSortingVersion = 1.0
    Else
        Return
    EndIf

    Debug.Trace(LogPrefix + "Valdacil's Item Sorting Detected. Updating Weapon Names")
    RenameWeaponValdacilsItemSorting(MEKCGSIronGreatchair)
    RenameWeaponValdacilsItemSorting(MEKCGSDaedricGreatchair)
    RenameWeaponValdacilsItemSorting(MEKCGSDwarvenGreatchair)
    RenameWeaponValdacilsItemSorting(MEKCGSEbonyGreatchair)
    RenameWeaponValdacilsItemSorting(MEKCGSElvenGreatchair)
    RenameWeaponValdacilsItemSorting(MEKCGSGlassGreatchair)
    RenameWeaponValdacilsItemSorting(MEKCGSOrcishGreatchair)
    RenameWeaponValdacilsItemSorting(MEKCGSSteelGreatchair)
    Debug.Trace(LogPrefix + "Valdacil's Item Sorting Names Set")
EndFunction
