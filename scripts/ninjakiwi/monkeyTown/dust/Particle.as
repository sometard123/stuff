package ninjakiwi.monkeyTown.dust
{
   import com.lgrey.vectors.LGVector2D;
   import ninjakiwi.monkeyTown.display.bitClip.BitClipCustom;
   
   public class Particle extends BitClipCustom
   {
       
      
      public var velocity:LGVector2D;
      
      public var friction:Number = 0.1;
      
      public var goal:LGVector2D;
      
      public function Particle()
      {
         this.velocity = new LGVector2D();
         this.goal = new LGVector2D();
         super();
      }
   }
}
