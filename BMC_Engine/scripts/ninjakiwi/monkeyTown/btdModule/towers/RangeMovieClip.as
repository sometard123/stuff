package ninjakiwi.monkeyTown.btdModule.towers
{
   import assets.towers.Range;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class RangeMovieClip extends MovieClip
   {
       
      
      private var rangeInner:Range = null;
      
      public function RangeMovieClip()
      {
         super();
      }
      
      public function initialise(param1:TowerDef) : void
      {
         if(this.rangeInner == null)
         {
            this.rangeInner = Pool.get(Range);
            addChild(this.rangeInner);
         }
         if(param1.rangeOfVisibility < 1000)
         {
            this.rangeInner.width = param1.rangeOfVisibility * 2 * Main.instance.scale;
         }
         else
         {
            this.rangeInner.width = 100 * Main.instance.scale;
         }
         this.rangeInner.height = this.rangeInner.width;
      }
   }
}
