package ninjakiwi.monkeyTown.town.ui.skipClockPanel
{
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.ui.clock.UpgradeBuildingWarmupClock;
   import ninjakiwi.net.JSONRequest;
   
   public class SkipBuildingUpgradeWarmupPanel extends SkipClockPanel
   {
       
      
      public function SkipBuildingUpgradeWarmupPanel(param1:DisplayObjectContainer)
      {
         super(param1);
         isModal = true;
         _system.city.upgradeBuildingWarmupClockManager.userClickedUpgradeClockSignal.add(this.onUserClickedBuildingWarmupUpgradeClock);
         skipNowTitleText = "Finish Upgrading";
         _clip.iconBuilding.visible = false;
         _clip.iconUpgrade.visible = false;
         _clip.resourceBuildingIcons.visible = true;
      }
      
      private function onUserClickedBuildingWarmupUpgradeClock(param1:UpgradeBuildingWarmupClock) : void
      {
         var _loc2_:MonkeyTownBuildingDefinition = null;
         LGDisplayListUtil.getInstance().removeAllChildren(_clip.iconBuilding);
         if(param1.upgradeableTarget != null && param1.upgradeableTarget.definition != null)
         {
            _loc2_ = param1.upgradeableTarget.definition;
            if(_loc2_.id === BuildingData.getInstance().BANANA_FARM.id)
            {
               if(param1.upgradeableTarget.tier === 1)
               {
                  _clip.resourceBuildingIcons.gotoAndStop(1);
               }
               else if(param1.upgradeableTarget.tier === 2)
               {
                  _clip.resourceBuildingIcons.gotoAndStop(9);
               }
               else if(param1.upgradeableTarget.tier === 3)
               {
                  _clip.resourceBuildingIcons.gotoAndStop(10);
               }
               else if(param1.upgradeableTarget.tier === 4)
               {
                  _clip.resourceBuildingIcons.gotoAndStop(11);
               }
            }
            else if(_loc2_.id === BuildingData.getInstance().MONKEY_BANK.id)
            {
               if(param1.upgradeableTarget.tier === 1)
               {
                  _clip.resourceBuildingIcons.gotoAndStop(2);
               }
               else if(param1.upgradeableTarget.tier === 2)
               {
                  _clip.resourceBuildingIcons.gotoAndStop(3);
               }
               else if(param1.upgradeableTarget.tier === 3)
               {
                  _clip.resourceBuildingIcons.gotoAndStop(4);
               }
               else if(param1.upgradeableTarget.tier === 4)
               {
                  _clip.resourceBuildingIcons.gotoAndStop(12);
               }
               else if(param1.upgradeableTarget.tier === 5)
               {
                  _clip.resourceBuildingIcons.gotoAndStop(13);
               }
               else if(param1.upgradeableTarget.tier === 6)
               {
                  _clip.resourceBuildingIcons.gotoAndStop(14);
               }
               else if(param1.upgradeableTarget.tier === 7)
               {
                  _clip.resourceBuildingIcons.gotoAndStop(15);
               }
            }
            else if(_loc2_.id === BuildingData.getInstance().WINDMILL.id)
            {
               _clip.resourceBuildingIcons.gotoAndStop(5);
            }
            else if(_loc2_.id === BuildingData.getInstance().WATERMILL.id)
            {
               _clip.resourceBuildingIcons.gotoAndStop(6);
            }
            else if(_loc2_.id === BuildingData.getInstance().BLOONTONIUM_GENERATOR.id)
            {
               _clip.resourceBuildingIcons.gotoAndStop(7);
            }
            else if(_loc2_.id === BuildingData.getInstance().BLOONTONIUM_STORAGE_TANK.id)
            {
               _clip.resourceBuildingIcons.gotoAndStop(8);
            }
            else
            {
               _clip.resourceBuildingIcons.gotoAndStop(1);
            }
         }
         requestSkipForClock(param1);
         if(param1.target != null && param1.target.definition != null)
         {
            _clip.description.text = param1.target.definition.name + "?";
         }
         else
         {
            _clip.description.text = "";
         }
      }
   }
}
