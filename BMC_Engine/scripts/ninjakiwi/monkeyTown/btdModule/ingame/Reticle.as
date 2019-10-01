package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.tower.MortarReticle;
   import display.Clip;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.weapons.FireAtReticle;
   
   public class Reticle extends Entity
   {
       
      
      private var clip:Clip;
      
      public var tower:Tower = null;
      
      private var processa:Boolean = false;
      
      public function Reticle()
      {
         this.clip = new Clip();
         super();
      }
      
      public function initialise(param1:Tower, param2:Boolean) : void
      {
         this.tower = param1;
         this.processa = param2;
         this.clip.initialise(MortarReticle,1);
         z = 300;
         this.refreshReticle(param1);
      }
      
      public function refreshReticle(param1:Tower) : void
      {
         if(param1.def.weapons && param1.def.weapons[0] as FireAtReticle != null)
         {
            if((param1.def.weapons[0] as FireAtReticle).spread < 60)
            {
               this.clip.gotoAndStop(1);
            }
            else
            {
               this.clip.gotoAndStop(0);
            }
         }
         else if(param1.rootID == "DartlingGun")
         {
            this.clip.gotoAndStop(2);
         }
      }
      
      override public function process(param1:Number) : void
      {
         this.clip.process();
         if(this.processa == false)
         {
            return;
         }
         x = Main.instance.mouseX;
         y = Main.instance.mouseY;
         var _loc2_:Rectangle = this.tower.level.boundries;
         if(x > _loc2_.right - 10)
         {
            x = _loc2_.right - 10;
         }
         else if(x < _loc2_.left + 10)
         {
            x = _loc2_.left + 10;
         }
         if(y > _loc2_.bottom - 10)
         {
            y = _loc2_.bottom - 10;
         }
         else if(y < _loc2_.top + 10)
         {
            y = _loc2_.top + 10;
         }
      }
      
      override public function draw(param1:BitmapData) : void
      {
         this.clip.quickDraw(param1,x,y);
      }
   }
}
