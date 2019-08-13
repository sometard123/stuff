package ninjakiwi.monkeyTown.town.flare
{
   import com.lgrey.signal.SignalHub;
   import com.lgrey.vectors.LGVector2D;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.display.tileSystem.Camera;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.flare.atmospherics.AtmosphericsManager;
   import ninjakiwi.monkeyTown.town.flare.atmospherics.DesertDust;
   import ninjakiwi.monkeyTown.town.flare.birds.BirdManager;
   import ninjakiwi.monkeyTown.town.flare.borderlands.Cliffs;
   import ninjakiwi.monkeyTown.town.flare.borderlands.Horizon;
   import ninjakiwi.monkeyTown.town.flare.dustDevil.DustDevil;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import org.osflash.signals.Signal;
   
   public class FlareManager
   {
      
      public static var mousePositionInWorld:LGVector2D = new LGVector2D();
       
      
      private var _atmosphericsManager:AtmosphericsManager;
      
      private var _desertDust:DesertDust;
      
      private var _birdManager:BirdManager;
      
      private var _horizon:Horizon;
      
      private var _cliffs:Cliffs;
      
      private var _dustDevil:DustDevil;
      
      private var _map:TownMap;
      
      private var _camera:Camera;
      
      private var _system:MonkeySystem;
      
      private const _signalHub:SignalHub = SignalHub.getHub();
      
      private const mouseMoveSignal:Signal = this._signalHub.getSignal("mouseMoveSignal");
      
      public function FlareManager(param1:TownMap, param2:Camera)
      {
         this._atmosphericsManager = new AtmosphericsManager();
         this._birdManager = new BirdManager();
         this._dustDevil = new DustDevil();
         this._system = MonkeySystem.getInstance();
         super();
         this._map = param1;
         this._camera = param2;
         this._cliffs = new Cliffs(this._map);
         this._horizon = new Horizon(this._map);
         this._desertDust = new DesertDust(this._map,this._camera);
         this.mouseMoveSignal.add(this.onMouseMove);
      }
      
      private function onMouseMove(param1:Number, param2:Number) : void
      {
         if(this._camera !== null)
         {
            mousePositionInWorld.x = param1 + this._camera.x;
            mousePositionInWorld.y = param2 + this._camera.y;
         }
      }
      
      public function generate() : void
      {
         this._cliffs.generate();
         if(this._system.city.cityIndex == 0)
         {
            this._horizon.setCityOne();
         }
         else
         {
            this._horizon.setCityTwo();
         }
         this._horizon.generate();
         this._atmosphericsManager.generate();
      }
      
      public function renderBack(param1:BitmapData, param2:Rectangle) : void
      {
         this._horizon.render(param1,param2);
      }
      
      public function renderFront(param1:BitmapData, param2:Rectangle) : void
      {
         this._cliffs.render(param1,param2);
         if(Constants.IS_HALLOWEEN && this._system.city.cityIndex == 0)
         {
            this._birdManager.render(param1,param2);
         }
         if(this._system.city.cityIndex > 0)
         {
            this._desertDust.render(param1,param2);
            this._birdManager.render(param1,param2);
            this._dustDevil.render(param1,param2);
         }
         this._atmosphericsManager.render(param1,param2);
      }
      
      public function tick() : void
      {
         this._atmosphericsManager.tick();
         this._horizon.tick();
         this._cliffs.tick();
      }
      
      public function clear() : void
      {
         this._atmosphericsManager.clear();
      }
   }
}
