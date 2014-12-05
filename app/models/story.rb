class Story < ActiveRecord::Base
  belongs_to :user

  def die
    return rand(1..7)
  end

  def story_maker
    @characters = ["a giant","an Old Tree","a Sphinx","a Baron","a Knight","Puck","Fox","Wolf","Coyote","fairies", "the Emperor of San Francisco","a Gate","ghosts","a school of fish", "a mermaid", "a bird", "Augustine the Hunter","a man","a woman","Crow","a soldier","a banshee", "Doge", "Baldur", "Mr. Wednesday", "Orpheus", "children", "the Lovers", "the Hermit", "Strength", "the Hanged Man", "Death", "the Devil", "bees", "snakes", "swords", "Excalibur", "the Saint"]
    case die
    when 1..3
      self.content = instructions_constructor
    when 4..6
      self.content = story_constructor
    when 7
      self.content = omen_constructor
    end
  end

  def instructions_constructor
    instruction_intro = ["When you see","Make sure you bow before","If challenged by","If you step on the toes of","If given a riddle by","If offered food by","If you see","Do not quarrel with","If poisoned by","When facing a parliament of","Knock on the door of","Do not make a bet with"]
    instruction_action = ["apologize","answer with a riddle","call for a Judge","call for a doctor","take them to their castle","don't", "do not answer them","give them one answer to one question","turn around three times then look them in the eye","do not eat their food","dry their tears","drink lots of water","tell one secret you have told no one else"]
    return "#{instruction_intro.shuffle.sample} #{@characters.shuffle.sample}, #{instruction_action.shuffle.sample}."
  end

  def story_constructor
    in_story_characters = @characters.shuffle
    story_action = ["stole from","saw the crimes of","spoke truth to","cast a spell on","betrayed","gave food to","banished","overheard the lies of","fed","ate with","hunted with","hunted","poisoned","made peace with","got drunk with","riddled","bewitched","broke the spell of"]
    return "#{in_story_characters[0].capitalize} #{story_action.sample} #{in_story_characters[1]}."
  end

  def omen_constructor
    omens=["The wind whistles.","Trust your heart. It knows the way.","A bad moon is on the rise","Birds are especially wise today.","Birds gather.","Watch for the color red. It is significant","Don't make expensive promises.","Use the right hammer for the job.","Plan an adventure.","Keep something precious close.","Things are afoot.","In the distance, whales can be heard.","Do you hear the people sing?","Answer truthfully.","Fear not.","Listen.","Breathe.","Something is on the horizon.","Does anybody else hear that?","HELPIMSTUCKINANINTERNETFACTORY","The clouds are thinking deeply.","The crow flies at midnight."]
    return omens.shuffle.sample
  end
end
