package ninjakiwi.monkeyTown.town.entity
{
   import com.lgrey.vectors.LGVector2D;
   
   public class Entity extends LGVector2D
   {
       
      
      public var manager:EntityManager = null;
      
      public function Entity()
      {
         super();
      }
      
      public function tick() : void
      {
      }
      
      public function die() : void
      {
         if(this.manager != null)
         {
            this.manager.deregister(this);
         }
      }
      
      public function dieOnNextTick() : void
      {
         if(this.manager != null)
         {
            this.manager.deregisterOnNextTick(this);
         }
      }
   }
}
