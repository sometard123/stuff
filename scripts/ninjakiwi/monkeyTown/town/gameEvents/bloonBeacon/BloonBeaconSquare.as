package ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon
{
   import assets.ui.BloonBeaconClip;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeBuffData;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePathDefinition;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePortraitData;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.Awarder;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.quests.task.Quest;
   import ninjakiwi.monkeyTown.town.ui.TileBoundAnimation;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgeCard;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge._flipButton;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.onClickedShake;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.playFlipSound;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.preFlipShudder;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.that;
   
   public class BloonBeaconSquare extends TileBoundAnimation
   {
       
      
      private var _attachedTile:Tile;
      
      private var _isActive:Boolean = false;
      
      public function BloonBeaconSquare()
      {
         _clip = new BloonBeaconClip();
         super(_clip);
      }
      
      public static function unhover() : void
      {
      }
      
      public function reset() : void
      {
         this._attachedTile = null;
         this.setActive(false);
      }
      
      public function updatePosition(param1:Point) : void
      {
         this._attachedTile = TownUI.getInstance().worldView.map.tileAt(param1.x,param1.y);
         updateToTile(this.attachedTile);
      }
      
      public function setAttachedTile(param1:Tile) : void
      {
         this._attachedTile = param1;
         updateToTile(this._attachedTile);
      }
      
      public function setActive(param1:Boolean) : void
      {
         this._isActive = param1;
         if(param1)
         {
            _clip.play();
         }
         else
         {
            _clip.stop();
         }
      }
      
      override public function simulateClick() : void
      {
         MonkeyCityMain.getInstance().worldView.attackTile(this._attachedTile);
      }
      
      public function get attachedTile() : Tile
      {
         return this._attachedTile;
      }
      
      public function get isActive() : Boolean
      {
         return this._isActive;
      }
   }
}
