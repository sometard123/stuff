package ninjakiwi.monkeyTown.town.ui
{
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.town.data.MyTowersData;
   
   public class MyTowersInfoPane
   {
       
      
      private var _clip:MovieClip;
      
      private var towerToFrameMap:Array;
      
      public function MyTowersInfoPane(param1:MovieClip)
      {
         this.towerToFrameMap = ["DartMonkey","TackTower","SniperMonkey","BoomerangThrower","NinjaMonkey","BombTower","IceTower","GlueGunner","MonkeyBuccaneer","MonkeyAce","SuperMonkey","MonkeyApprentice","MortarTower","DartlingGun","BananaFarm","MonkeyVillage","SpikeFactory","ExplodingPineapple","RoadSpikes","Helicopter","Engineer"];
         super();
         this._clip = param1;
         this._clip.towerIcon.gotoAndStop(1);
      }
      
      public function syncToTower(param1:String, param2:int) : void
      {
         var _loc3_:Object = MyTowersData.getDataForTower(param1);
         if(_loc3_ === null)
         {
            return;
         }
         this._clip.title.htmlText = "<b>" + _loc3_.name + "</b>";
         this._clip.description.htmlText = "<b>" + _loc3_.description + "</b>";
         this._clip.monkeyCount.htmlText = "<b>" + param2.toString() + "</b>";
         this._clip.strengthsInfo.htmlText = "<b>" + _loc3_.strengths + "</b>";
         this._clip.weaknessInfo.htmlText = "<b>" + _loc3_.weaknesses + "</b>";
         this._clip.occupiesInfo.htmlText = "<b>" + _loc3_.requires + "</b>";
         this._clip.upgradesInfo.htmlText = "<b>" + _loc3_.upgrades + "</b>";
         this._clip.towerIcon.gotoAndStop(this.towerToFrameMap.indexOf(param1) + 1);
      }
      
      public function destroy() : void
      {
         this._clip = null;
      }
   }
}
