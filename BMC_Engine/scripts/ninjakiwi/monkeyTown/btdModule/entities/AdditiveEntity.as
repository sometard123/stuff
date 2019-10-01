package ninjakiwi.monkeyTown.btdModule.entities
{
   import assets.effects.Blacken;
   import display.Clip;
   import display.LabelOverCommand;
   import flash.display.BitmapData;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   
   public class AdditiveEntity extends Entity
   {
       
      
      private var front:AdditiveEntityFore = null;
      
      private var theZ:Number = 0;
      
      private var clip:Clip;
      
      public function AdditiveEntity()
      {
         this.clip = new Clip();
         super();
      }
      
      public function initialise(param1:Class, param2:Number, param3:Level) : void
      {
         this.theZ = param2 - 0.001;
         param2 = this.theZ;
         this.clip.initialiseWithEffect(param1,Blacken,64);
         if(this.clip.hasLabel("Loop"))
         {
            this.clip.labelOver["Loop"] = new LabelOverCommand();
            this.clip.labelOver["Loop"].command = LabelOverCommand.gotoAndPlay;
            this.clip.labelOver["Loop"].frameNoTo = 0;
            this.clip.gotoLabel("Loop");
            this.clip.play();
            this.clip.looping = true;
         }
         this.front = new AdditiveEntityFore();
         this.front.initialise(param1,param2);
         param3.addEntity(this.front);
      }
      
      override public function destroy() : void
      {
         this.front.destroy();
         super.destroy();
      }
      
      override public function process(param1:Number) : void
      {
         this.front.x = x;
         this.front.y = y;
         this.front.rotation = rotation;
         this.clip.process();
         super.process(param1);
      }
      
      override public function draw(param1:BitmapData) : void
      {
         this.front.x = x;
         this.front.y = y;
         this.front.rotation = rotation;
         this.clip.drawRotated(param1,x,y,rotation);
         super.draw(param1);
      }
   }
}
