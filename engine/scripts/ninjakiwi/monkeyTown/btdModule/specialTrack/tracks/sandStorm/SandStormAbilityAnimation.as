package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.sandStorm
{
   import flash.display.BitmapData;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   
   public class SandStormAbilityAnimation extends Entity
   {
       
      
      private const NUMBER_OF_GUSTS:int = 30;
      
      private var _gusts:Vector.<SandstormAbilityGust>;
      
      public function SandStormAbilityAnimation()
      {
         this._gusts = new Vector.<SandstormAbilityGust>();
         super();
         z = int.MAX_VALUE;
         this.init();
      }
      
      private function init() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.NUMBER_OF_GUSTS)
         {
            this._gusts[_loc1_] = new SandstormAbilityGust();
            _loc1_++;
         }
      }
      
      public function activate() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._gusts.length)
         {
            this._gusts[_loc1_].activate();
            _loc1_++;
         }
      }
      
      public function deactivate() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._gusts.length)
         {
            this._gusts[_loc1_].deactivate();
            _loc1_++;
         }
      }
      
      override public function process(param1:Number) : void
      {
         super.process(param1);
         var _loc2_:int = 0;
         while(_loc2_ < this._gusts.length)
         {
            this._gusts[_loc2_].process(param1);
            _loc2_++;
         }
      }
      
      override public function draw(param1:BitmapData) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._gusts.length)
         {
            this._gusts[_loc2_].draw(param1);
            _loc2_++;
         }
      }
      
      public function disposeFrames() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._gusts.length)
         {
            this._gusts[_loc1_].disposeFrames();
            _loc1_++;
         }
      }
   }
}
