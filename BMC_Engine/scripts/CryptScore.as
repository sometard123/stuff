package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class CryptScore
   {
      
      private static var randamaroo:MovieClip;
       
      
      private var scoreA:Number;
      
      private var bullshit1:Number;
      
      private var bullshit2:Number;
      
      private var bullshit3:Number;
      
      private var bullshit4:Number;
      
      private var scoreB:Number;
      
      public function CryptScore()
      {
         super();
         if(randamaroo == null)
         {
            randamaroo = new MovieClip();
         }
         this.scoreA = 0;
         this.bullshit1 = this.scoreA;
         this.bullshit2 = -this.bullshit1;
         this.bullshit3 = 2 * this.bullshit2;
         this.bullshit4 = 2 * this.bullshit3;
         this.scoreB = -this.scoreA;
         randamaroo.addEventListener(Event.ENTER_FRAME,this.randomise,false,0,true);
      }
      
      private function randomise(param1:Event) : void
      {
         var _loc2_:int = Math.random() * 133;
         this.scoreA = this.scoreA + _loc2_;
         this.scoreB = this.scoreB - _loc2_;
      }
      
      public function get value() : Number
      {
         return this.scoreA + this.scoreB;
      }
      
      public function set value(param1:Number) : void
      {
         this.scoreB = param1 - this.scoreA;
      }
      
      public function get v() : Number
      {
         return this.scoreA + this.scoreB;
      }
      
      public function set v(param1:Number) : void
      {
         this.scoreB = param1 - this.scoreA;
      }
   }
}
