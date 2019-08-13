package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import assets.ui.KnowledgeInformationPanelClip;
   import assets.ui.MKInfoSet1;
   import assets.ui.MKInfoSet2;
   import assets.ui.MKInfoSet3;
   import com.greensock.TweenLite;
   import com.greensock.easing.Back;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeBuffData;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePath;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePathDefinition;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class MonkeyKnowledgeInfoPanel extends HideRevealView
   {
       
      
      private var _clip:KnowledgeInformationPanelClip;
      
      private var _set1:MKInfoSet1;
      
      private var _set2:MKInfoSet2;
      
      private var _set3:MKInfoSet3;
      
      private var _set1Home:Point;
      
      private var _set2Home:Point;
      
      private var _set3Home:Point;
      
      private var _titleHome:Point;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _numberFields:Vector.<TextField>;
      
      private var _infoFields:Vector.<TextField>;
      
      private var _numberFieldFormats:Vector.<TextFormat>;
      
      private var _infoFieldFormats:Vector.<TextFormat>;
      
      private const _buffData:MonkeyKnowledgeBuffData = MonkeyKnowledgeBuffData.getInstance();
      
      private const DisplayUtil:LGDisplayListUtil = LGDisplayListUtil.getInstance();
      
      public function MonkeyKnowledgeInfoPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new KnowledgeInformationPanelClip();
         this._set1 = this._clip.set1;
         this._set2 = this._clip.set2;
         this._set3 = this._clip.set3;
         this._set1Home = new Point(this._set1.x,this._set1.y);
         this._set2Home = new Point(this._set2.x,this._set2.y);
         this._set3Home = new Point(this._set3.x,this._set3.y);
         this._titleHome = new Point(this._clip.titleBlock.x,this._clip.titleBlock.y);
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._numberFields = new Vector.<TextField>();
         this._infoFields = new Vector.<TextField>();
         this._numberFieldFormats = new Vector.<TextFormat>();
         this._infoFieldFormats = new Vector.<TextFormat>();
         super(param1,param2);
         this.build();
      }
      
      private function build() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         addChild(this._clip);
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 3)
         {
            _loc3_ = this._clip["set" + (_loc2_ + 1)];
            _loc4_ = 0;
            while(_loc4_ < 5)
            {
               this._numberFields.push(_loc3_["rankField" + (_loc4_ + 1)]);
               this._infoFields.push(_loc3_["field" + (_loc4_ + 1)]);
               this._numberFieldFormats.push(this._numberFields[_loc1_].getTextFormat());
               this._infoFieldFormats.push(this._infoFields[_loc1_].getTextFormat());
               this._infoFieldFormats[_loc2_].leading = -2;
               _loc1_++;
               _loc4_++;
            }
            _loc2_++;
         }
         this._clip.titleBlock.titleClip.stop();
         this._closeButton.setClickFunction(hide);
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         super.reveal(param1);
         this._clip.titleBlock.y = -100;
         this._set1.x = -(this._set1.width * 0.5 + 50);
         this._set1.y = -(this._set1Home.y - 150);
         this._set2.y = _stage.stageHeight + (this._set2.height * 0.5 + 50);
         this._set3.x = _stage.stageWidth + (this._set3.width * 0.5 + 50);
         this._set3.y = -(this._set3Home.y - 150);
         var _loc2_:Number = 0.5;
         var _loc3_:Number = 0.1;
         var _loc4_:Number = 0;
         TweenLite.to(this._set1,_loc2_,{
            "x":this._set1Home.x,
            "y":this._set1Home.y,
            "ease":Back.easeOut,
            "delay":_loc4_
         });
         _loc4_ = _loc4_ + _loc3_;
         TweenLite.to(this._set2,_loc2_,{
            "x":this._set2Home.x,
            "y":this._set2Home.y,
            "ease":Back.easeOut,
            "delay":_loc4_
         });
         _loc4_ = _loc4_ + _loc3_;
         TweenLite.to(this._set3,_loc2_,{
            "x":this._set3Home.x,
            "y":this._set3Home.y,
            "ease":Back.easeOut,
            "delay":_loc4_
         });
         _loc4_ = _loc4_ + _loc3_;
         TweenLite.to(this._clip.titleBlock,_loc2_,{
            "x":this._titleHome.x,
            "y":this._titleHome.y,
            "ease":Back.easeOut,
            "delay":_loc4_
         });
      }
      
      public function sync(param1:MonkeyKnowledgePath) : void
      {
         var _loc4_:String = null;
         var _loc2_:MonkeyKnowledgePathDefinition = this._buffData.getPathDefinition(param1.id);
         if(this.DisplayUtil.hasLabel(this._clip.titleBlock.titleClip,param1.id))
         {
            this._clip.titleBlock.titleClip.gotoAndStop(param1.id);
         }
         else
         {
            this._clip.titleBlock.titleClip.gotoAndStop(0);
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._numberFields.length)
         {
            _loc4_ = _loc2_.getRankDescription(_loc3_ + 1);
            if(_loc4_ == "")
            {
               _loc4_ = "TODO...";
            }
            this._infoFields[_loc3_].text = _loc4_;
            if(param1.rank > _loc3_)
            {
               this.turnFieldWhite(this._numberFields[_loc3_]);
               this.turnFieldWhite(this._infoFields[_loc3_]);
            }
            else
            {
               this._numberFields[_loc3_].setTextFormat(this._numberFieldFormats[_loc3_]);
               this._infoFields[_loc3_].setTextFormat(this._infoFieldFormats[_loc3_]);
            }
            _loc3_++;
         }
      }
      
      public function turnFieldWhite(param1:TextField) : void
      {
         var _loc2_:TextFormat = param1.getTextFormat();
         _loc2_.color = 16777215;
         param1.setTextFormat(_loc2_);
      }
   }
}
