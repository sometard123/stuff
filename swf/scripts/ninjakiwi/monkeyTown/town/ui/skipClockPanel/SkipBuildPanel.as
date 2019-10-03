package ninjakiwi.monkeyTown.town.ui.skipClockPanel
{
   import com.codecatalyst.promise.Promise;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.ui.clock.BuildClock;
   import ninjakiwi.monkeyTown.town.ui.clock.DamageClock;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.VideoAdPanelController;
   
   public class SkipBuildPanel extends SkipClockPanel
   {
       
      
      private var _videoAdPanelController:VideoAdPanelController;
      
      public function SkipBuildPanel(param1:DisplayObjectContainer)
      {
         super(param1);
         isModal = true;
         _system.city.buildClockManager.userClickedBuildClockSignal.add(this.onUserClickedBuildClock);
         _system.city.damageClockManager.userClickedDamageClockSignal.add(this.onUserClickedDamageClock);
         skipNowTitleText = "Finish Building";
         _clip.iconBuilding.visible = false;
         _clip.iconUpgrade.visible = false;
         _clip.resourceBuildingIcons.visible = false;
         setAutoPlayStopClipsArray([_clip.iconBuilding,_clip.iconUpgrade,_clip.resourceBuildingIcons]);
         this._videoAdPanelController = new VideoAdPanelController(_clip.watchVideoPanel,this);
      }
      
      private function onUserClickedDamageClock(param1:DamageClock) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Building = null;
         LGDisplayListUtil.getInstance().removeAllChildren(_clip.iconBuilding);
         if(param1.target != null && param1.target.definition != null && param1.target.definition.iconGraphicClass != null)
         {
            _clip.iconBuilding.addChild(new param1.target.definition.iconGraphicClass());
         }
         skipNowTitleText = "Finish Repairing";
         _clip.repairIcon.visible = true;
         _clip.repairIcon.play();
         _clip.iconBuilding.visible = false;
         _clip.iconBuilding.stop();
         _clip.resourceBuildingIcons.gotoAndStop(1);
         _clip.resourceBuildingIcons.visible = false;
         _clip.repairAllButton.visible = true;
         var _loc2_:Array = _system.city.buildingManager.getDamagedBuildingsOfType(param1.target.definition.id);
         var _loc3_:Number = 0;
         if(_loc2_.length > 1)
         {
            _repairAllButton.target.visible = true;
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc5_ = _loc2_[_loc4_] as Building;
               if(_loc5_.damageClock != null)
               {
                  _loc3_ = _loc3_ + _loc5_.damageClock.getBloonstonesRequiredToSkip();
               }
               _loc4_++;
            }
            _repairAllButton.target.bloonStones_txt.text = _loc3_;
         }
         else
         {
            _repairAllButton.target.visible = false;
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
      
      private function onUserClickedBuildClock(param1:BuildClock) : void
      {
         LGDisplayListUtil.getInstance().removeAllChildren(_clip.iconBuilding);
         if(param1.target != null && param1.target.definition != null && param1.target.definition.iconGraphicClass != null)
         {
            if(param1.target.definition.id === BuildingData.getInstance().BLOONTONIUM_STORAGE_TANK.id)
            {
               _clip.iconBuilding.visible = false;
               _clip.resourceBuildingIcons.visible = true;
               _clip.resourceBuildingIcons.gotoAndStop(8);
            }
            else
            {
               _clip.iconBuilding.visible = true;
               _clip.iconBuilding.play();
               _clip.resourceBuildingIcons.visible = false;
               _clip.iconBuilding.addChild(new param1.target.definition.iconGraphicClass());
            }
         }
         _clip.repairIcon.visible = false;
         _clip.repairIcon.stop();
         skipNowTitleText = "Finish Building";
         _repairAllButton.target.visible = false;
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
      
      override public function reveal(param1:Number = 0.5) : void
      {
         var _loc2_:int = _clip.resourceBuildingIcons.currentFrame;
         super.reveal(param1);
         this._videoAdPanelController.doVideoAvailableCheck();
         _clip.resourceBuildingIcons.gotoAndStop(8);
      }
   }
}
