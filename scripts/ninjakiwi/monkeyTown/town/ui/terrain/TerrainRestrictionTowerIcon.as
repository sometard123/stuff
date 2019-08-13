package ninjakiwi.monkeyTown.town.ui.terrain
{
   import assets.ui.towerIcon;
   import ninjakiwi.monkeyTown.common.Constants;
   
   public class TerrainRestrictionTowerIcon
   {
       
      
      private var _linkedClip:towerIcon;
      
      public function TerrainRestrictionTowerIcon(param1:towerIcon)
      {
         super();
         this._linkedClip = param1;
      }
      
      public function destroy() : void
      {
         this._linkedClip = null;
      }
      
      public function setIcon(param1:String) : void
      {
         if(this._linkedClip == null)
         {
            return;
         }
         this._linkedClip.visible = true;
         if(param1 == Constants.TOWER_DART)
         {
            this._linkedClip.gotoAndStop(1);
         }
         else if(param1 == Constants.TOWER_BOOMERANG)
         {
            this._linkedClip.gotoAndStop(2);
         }
         else if(param1 == Constants.TOWER_TACK)
         {
            this._linkedClip.gotoAndStop(3);
         }
         else if(param1 == Constants.TOWER_SNIPER)
         {
            this._linkedClip.gotoAndStop(4);
         }
         else if(param1 == Constants.TOWER_NINJA)
         {
            this._linkedClip.gotoAndStop(5);
         }
         else if(param1 == Constants.TOWER_BOMB)
         {
            this._linkedClip.gotoAndStop(6);
         }
         else if(param1 == Constants.TOWER_ICE)
         {
            this._linkedClip.gotoAndStop(7);
         }
         else if(param1 == Constants.TOWER_GLUE)
         {
            this._linkedClip.gotoAndStop(8);
         }
         else if(param1 == Constants.TOWER_BUCCANEER)
         {
            this._linkedClip.gotoAndStop(9);
         }
         else if(param1 == Constants.TOWER_PLANE)
         {
            this._linkedClip.gotoAndStop(10);
         }
         else if(param1 == Constants.TOWER_SUPER)
         {
            this._linkedClip.gotoAndStop(11);
         }
         else if(param1 == Constants.TOWER_APPRENTICE)
         {
            this._linkedClip.gotoAndStop(12);
         }
         else if(param1 == Constants.TOWER_VILLAGE)
         {
            this._linkedClip.gotoAndStop(13);
         }
         else if(param1 == Constants.TOWER_FARM)
         {
            this._linkedClip.gotoAndStop(14);
         }
         else if(param1 == Constants.TOWER_MORTAR)
         {
            this._linkedClip.gotoAndStop(15);
         }
         else if(param1 == Constants.TOWER_DARTLING)
         {
            this._linkedClip.gotoAndStop(16);
         }
         else if(param1 == Constants.TOWER_SPIKEFACTORY)
         {
            this._linkedClip.gotoAndStop(17);
         }
         else if(param1 == Constants.TOWER_PINEAPPLE)
         {
            this._linkedClip.gotoAndStop(18);
         }
         else if(param1 == Constants.TOWER_ROADSPIKE)
         {
            this._linkedClip.gotoAndStop(19);
         }
         else if(param1 == Constants.TOWER_ENGINEER)
         {
            this._linkedClip.gotoAndStop(20);
         }
         else
         {
            this._linkedClip.visible = false;
         }
      }
   }
}
