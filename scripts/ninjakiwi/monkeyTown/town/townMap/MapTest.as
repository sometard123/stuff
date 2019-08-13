package ninjakiwi.monkeyTown.town.townMap
{
   import com.lgrey.utils.LGMathUtil;
   import ninjakiwi.monkeyTown.town.terrainGenerator.WorldSeed;
   import org.osflash.signals.Signal;
   
   public class MapTest
   {
      
      public static const messageSignal:Signal = new Signal(String);
      
      public static const taskSignal:Signal = new Signal(String);
       
      
      private var _townMap:TownMap;
      
      private var _seeds:Array;
      
      private var _currentSeedIndex:int = 0;
      
      private var LGMath:LGMathUtil;
      
      public function MapTest(param1:TownMap)
      {
         this._seeds = [1];
         this.LGMath = LGMathUtil.getInstance();
         super();
         this._townMap = param1;
         this.loadSeeds();
         this.test();
      }
      
      private function test() : void
      {
         var _loc1_:uint = this._seeds[this._currentSeedIndex];
         var _loc2_:WorldSeed = new WorldSeed();
         taskSignal.dispatch("Generating map: " + this._currentSeedIndex + " from seed " + _loc1_);
         _loc2_.randomiseSeeded(_loc1_);
         this._townMap.generateTerrain(this.testComplete,_loc2_);
      }
      
      private function testComplete() : void
      {
         var _loc1_:String = this._townMap.getMapDescription();
         var _loc2_:* = "map-" + this.zeroPad(this._currentSeedIndex,6) + ".txt";
         this.saveFile(_loc2_,_loc1_);
         this._currentSeedIndex++;
         if(this._currentSeedIndex < this._seeds.length)
         {
            this.test();
         }
      }
      
      public function loadSeeds() : void
      {
      }
      
      private function saveFile(param1:String, param2:String) : void
      {
      }
      
      public function zeroPad(param1:int, param2:int) : String
      {
         var _loc3_:String = "" + param1;
         while(_loc3_.length < param2)
         {
            _loc3_ = "0" + _loc3_;
         }
         return _loc3_;
      }
   }
}
