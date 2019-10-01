package ninjakiwi.monkeyTown.btdModule.ingame
{
   import flash.geom.ColorTransform;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   
   public class RangeCombo
   {
       
      
      public var range:RangeShade;
      
      public var rangeOutline:RangeOutline;
      
      public function RangeCombo()
      {
         this.range = new RangeShade();
         this.rangeOutline = new RangeOutline();
         super();
      }
      
      public function initialise(param1:TowerDef) : void
      {
         this.range.initialise(param1);
         this.rangeOutline.initialise(param1);
         if(this.range.scene == null)
         {
            Main.instance.game.level.addEntity(this.range);
         }
         if(this.rangeOutline.scene == null)
         {
            Main.instance.game.level.addEntity(this.rangeOutline);
         }
      }
      
      public function destroy() : void
      {
         this.range.destroy();
         this.rangeOutline.destroy();
      }
      
      public function set colorTransform(param1:ColorTransform) : void
      {
         this.range.colorTransform = param1;
         this.rangeOutline.colorTransform = param1;
      }
      
      public function set x(param1:Number) : void
      {
         this.range.x = param1;
         this.rangeOutline.x = param1;
      }
      
      public function set y(param1:Number) : void
      {
         this.range.y = param1;
         this.rangeOutline.y = param1;
      }
      
      public function set visible(param1:Boolean) : void
      {
         this.range.visible = param1;
         this.rangeOutline.visible = param1;
      }
   }
}
