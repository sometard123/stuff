package ninjakiwi.monkeyTown.town.townMap
{
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.pvp.IncomingRaid;
   import ninjakiwi.monkeyTown.pvp.PvPClient;
   import ninjakiwi.monkeyTown.pvp.PvPMain;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon.BloonBeaconSystem;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.specialMissions.SpecialMissionsManager;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import ninjakiwi.monkeyTown.town.ui.pvp.PvPAttackSquare;
   
   public class TownMapInvasionUtil
   {
       
      
      private var _map:TownMap;
      
      protected var _tiles:Vector.<Tile>;
      
      private var _system:MonkeySystem;
      
      private var _worldReady:Boolean = false;
      
      private const _notifiedAttacks:Vector.<String> = new Vector.<String>();
      
      public function TownMapInvasionUtil(param1:TownMap)
      {
         this._system = MonkeySystem.getInstance();
         super();
         this._map = param1;
         this._tiles = param1.tiles;
         PvPSignals.pvpDataUpdatedSignal.add(this.onPvPDataUpdatedSignal);
         MonkeyCityMain.getInstance().signals.loadCityAllCompleteSignal.add(this.worldReady);
      }
      
      private function worldReady() : void
      {
         this._worldReady = true;
      }
      
      private function onPvPDataUpdatedSignal(param1:Object, param2:Object, param3:Object) : void
      {
         this.updateAssignedTiles(param1);
      }
      
      private function updateAssignedTiles(param1:Object) : void
      {
         var _loc2_:Array = param1.incomingRaids;
         this.assignAttacksToTiles(_loc2_);
      }
      
      private function unlinkLinkedAttacks() : void
      {
         var _loc2_:Object = null;
         if(null == PvPMain.instance.incomingRaids)
         {
            return;
         }
         var _loc1_:int = 0;
         while(_loc1_ < PvPMain.instance.incomingRaids.length)
         {
            _loc2_ = PvPMain.instance.incomingRaids[_loc1_];
            if(_loc2_.linkedTile && _loc2_.linkedTile.tile)
            {
               _loc2_.linkedTile.tile = null;
               _loc2_.linkedTile.isUnderPvPAttack = false;
            }
            _loc1_++;
         }
      }
      
      private function assignAttacksToTiles(param1:Array) : void
      {
         var _loc2_:IncomingRaid = null;
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         if(param1 == null)
         {
            return;
         }
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            _loc2_ = param1[_loc5_];
            if(_loc2_.linkedTile === null)
            {
               _loc4_.push(_loc2_);
               _loc2_.checked = false;
            }
            else
            {
               _loc3_.push(_loc2_);
               _loc2_.checked = true;
            }
            _loc5_++;
         }
         var _loc6_:Array = _loc3_.concat(_loc4_);
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_.length)
         {
            _loc2_ = _loc6_[_loc7_];
            this.assignAttackToTile(_loc2_);
            _loc7_++;
         }
      }
      
      private function assignAttackToTile(param1:IncomingRaid) : void
      {
         var _loc2_:Tile = null;
         if(param1.linkedTile !== null)
         {
            _loc2_ = this._map.tileAt(param1.linkedTile.x,param1.linkedTile.y);
            if(_loc2_.isCaptured)
            {
               _loc2_ = this.linkAttackToTile(param1);
            }
            if(_loc2_ == null)
            {
               return;
            }
            param1.linkedTile.tile = _loc2_;
         }
         else
         {
            _loc2_ = this.linkAttackToTile(param1);
            if(_loc2_ == null)
            {
               return;
            }
         }
         _loc2_.isUnderPvPAttack = true;
         var _loc3_:PvPAttackSquare = PvPAttackSquare.getSquare(param1);
         _loc2_.pvpAttackSquare = _loc3_;
         this.notifyIncomingRaid(param1,!param1.checked);
      }
      
      private function linkAttackToTile(param1:IncomingRaid) : Tile
      {
         var tile:Tile = null;
         var attack:IncomingRaid = param1;
         tile = this.getValidInvasionTile();
         if(tile == null)
         {
            tile = this.getValidInvasionTileOwned();
            if(tile == null)
            {
               return null;
            }
         }
         attack.linkedTile = {
            "x":tile.positionTilespace.x,
            "y":tile.positionTilespace.y,
            "tile":tile
         };
         PvPClient.linkAttackToTile(attack.attackID,tile,function():void
         {
         });
         return tile;
      }
      
      public function getValidInvasionTile() : Tile
      {
         var _loc1_:Tile = null;
         var _loc8_:int = 0;
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < this._system.TOWN_MAP_HEIGHT_GRIDSPACE)
         {
            _loc8_ = 0;
            while(_loc8_ < this._system.TOWN_MAP_WIDTH_GRIDSPACE)
            {
               _loc1_ = this._tiles[_loc8_ + _loc3_ * this._system.TOWN_MAP_WIDTH_GRIDSPACE];
               if(this.canInvadeTile(_loc1_))
               {
                  _loc2_.push(_loc1_);
                  _loc1_.sort = this._map.getDifficultyAtLocationPoint(_loc1_.positionTilespace);
               }
               _loc8_++;
            }
            _loc3_++;
         }
         if(_loc2_.length === 0)
         {
            return null;
         }
         _loc2_.sortOn("sort",Array.NUMERIC);
         var _loc4_:int = _loc2_[0].sort;
         var _loc5_:int = 0;
         var _loc6_:int = 1;
         while(_loc6_ < _loc2_.length)
         {
            if(_loc4_ === int(_loc2_[_loc6_].sort))
            {
               _loc5_ = _loc6_;
               _loc6_++;
               continue;
            }
            break;
         }
         var _loc7_:Tile = _loc2_[int(Math.random() * _loc5_)];
         return _loc7_;
      }
      
      public function canInvadeTile(param1:Tile) : Boolean
      {
         return !param1.isCaptured && this._map.hasAdjacentConqueredTile(param1.positionTilespace.x,param1.positionTilespace.y) && !param1.isUnderPvPAttack && !param1.hasTreasureChest && SpecialMissionsManager.getInstance().findSpecialMission(param1) == null && !TileDefinitions.getInstance().isVolcano(param1) && !TileDefinitions.getInstance().isCave(param1) && !BloonBeaconSystem.getInstance().doesTileHaveBeacon(param1);
      }
      
      public function getValidInvasionTileOwned() : Tile
      {
         var _loc1_:Tile = null;
         var _loc8_:int = 0;
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < this._system.TOWN_MAP_HEIGHT_GRIDSPACE)
         {
            _loc8_ = 0;
            while(_loc8_ < this._system.TOWN_MAP_WIDTH_GRIDSPACE)
            {
               _loc1_ = this._tiles[_loc8_ + _loc3_ * this._system.TOWN_MAP_WIDTH_GRIDSPACE];
               if(!_loc1_.isUnderPvPAttack && SpecialMissionsManager.getInstance().findSpecialMission(_loc1_) == null && !TileDefinitions.getInstance().isVolcano(_loc1_) && !TileDefinitions.getInstance().isCave(_loc1_) && !BloonBeaconSystem.getInstance().doesTileHaveBeacon(_loc1_))
               {
                  _loc2_.push(_loc1_);
                  _loc1_.sort = this._map.getDifficultyAtLocationPoint(_loc1_.positionTilespace);
               }
               _loc8_++;
            }
            _loc3_++;
         }
         if(_loc2_.length === 0)
         {
            return null;
         }
         _loc2_.sortOn("sort",Array.NUMERIC);
         _loc2_.reverse();
         var _loc4_:int = _loc2_[0].sort;
         var _loc5_:int = 0;
         var _loc6_:int = 1;
         while(_loc6_ < _loc2_.length)
         {
            if(_loc4_ === int(_loc2_[_loc6_].sort))
            {
               _loc5_ = _loc6_;
               _loc6_++;
               continue;
            }
            break;
         }
         var _loc7_:Tile = _loc2_[int(Math.random() * _loc5_)];
         return _loc7_;
      }
      
      private function notifyIncomingRaid(param1:IncomingRaid, param2:Boolean = true) : void
      {
         if(this._notifiedAttacks.indexOf(param1.attackID) == -1)
         {
            this._notifiedAttacks.push(param1.attackID);
            if(param2 == true)
            {
               PvPSignals.defendTileSignal.dispatch(param1,true);
            }
         }
      }
      
      public function get notifiedAttacks() : Vector.<String>
      {
         return this._notifiedAttacks;
      }
   }
}
