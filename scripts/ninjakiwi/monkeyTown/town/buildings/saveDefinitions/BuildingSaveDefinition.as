package ninjakiwi.monkeyTown.town.buildings.saveDefinitions
{
   import ninjakiwi.monkeyTown.town.ui.clock.ClockSaveDefinition;
   import ninjakiwi.monkeyTown.utils.IntPoint2D;
   
   public class BuildingSaveDefinition
   {
       
      
      public var id:String;
      
      public var buildComplete:Boolean = false;
      
      public var clockSaveDefinition:ClockSaveDefinition = null;
      
      public var damageClockSaveDefinition:ClockSaveDefinition = null;
      
      public var mapCoordinates:IntPoint2D;
      
      public var state:int = -1;
      
      public var timeCreated:Number = 0;
      
      public function BuildingSaveDefinition()
      {
         this.mapCoordinates = new IntPoint2D(-1,-1);
         super();
      }
   }
}
