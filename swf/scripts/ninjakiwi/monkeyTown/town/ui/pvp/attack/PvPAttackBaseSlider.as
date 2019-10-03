package ninjakiwi.monkeyTown.town.ui.pvp.attack
{
   import assets.town.PvPAdvancedAttackClipNewVersion;
   import flash.display.DisplayObjectContainer;
   
   public class PvPAttackBaseSlider extends PvPAttackBase
   {
       
      
      protected var _sliderType:String;
      
      public function PvPAttackBaseSlider(param1:PvPAdvancedAttackClipNewVersion, param2:String)
      {
         super(param1);
         this._sliderType = param2;
      }
   }
}
