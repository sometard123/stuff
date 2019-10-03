package ninjakiwi.monkeyTown.btdModule.tutorial
{
   public class InGameTutorialData
   {
      
      private static const STEP_1:InGameTutorialDefinition = new InGameTutorialDefinition().Id("TutorialBTDStep1").Description("To take this area you need to fight the Bloons for it. The Bloons will attack by coming down the path towards the exit point. You lose lives every time one escapes past your defenses.").ButtonType(TutorialPanel.BUTTON_TYPE_NEXT);
      
      private static const STEP_2:InGameTutorialDefinition = new InGameTutorialDefinition().Id("TutorialBTDStep2").Description("Place the Monkeys you have around the Bloon track. They will automatically attack the Bloons once the round starts. Monkeys cost game money to deploy - this is not the same as City Cash. You can see how many of a particular Monkey type you have by looking at the menu to the right.").ButtonType(TutorialPanel.BUTTON_TYPE_NEXT);
      
      private static const STEP_3:InGameTutorialDefinition = new InGameTutorialDefinition().Id("TutorialBTDStep3").Description("The best place for monkeys is near corners or track cross over points. Go ahead and put one of your Dart Monkeys on the target circle.").ButtonType(TutorialPanel.BUTTON_TYPE_NONE);
      
      private static const STEP_4:InGameTutorialDefinition = new InGameTutorialDefinition().Id("TutorialBTDStep4").Description("Well done! Your Dart Monkey should have good coverage in that spot. You don\'t have enough game money to do anything else so let\'s get the first round started. Click the GO button.").ButtonType(TutorialPanel.BUTTON_TYPE_NONE);
      
      private static const STEP_5:InGameTutorialDefinition = new InGameTutorialDefinition().Id("TutorialBTDStep5").Description("That was Round 1 dealt with. You can see how many rounds are in a game by looking at the top right of the playing area. You have 2 rounds left in this game, but higher level areas will have lots more.").ButtonType(TutorialPanel.BUTTON_TYPE_NEXT);
      
      private static const STEP_6:InGameTutorialDefinition = new InGameTutorialDefinition().Id("TutorialBTDStep6").Description("You get money for every Bloon you pop. You also get a bonus amount of money at the end of each round. You have enough to get a second Dart Monkey. Get it and place it in the target area.").ButtonType(TutorialPanel.BUTTON_TYPE_NONE);
      
      private static const STEP_7:InGameTutorialDefinition = new InGameTutorialDefinition().Id("TutorialBTDStep7").Description("Round 2 sorted! Only one more round and you will win this piece of land. Good luck!").ButtonType(TutorialPanel.BUTTON_TYPE_OKAY);
      
      public static const TUTORIALS:Vector.<InGameTutorialDefinition> = Vector.<InGameTutorialDefinition>([STEP_1,STEP_2,STEP_3,STEP_4,STEP_5,STEP_6,STEP_7]);
       
      
      public function InGameTutorialData()
      {
         super();
      }
   }
}
