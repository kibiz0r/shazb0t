require 'cinch'

DEFAULT_VOICE = 'light'
voice_prefs = {}
VGS_WHITESPACE = ['.', ' ']
WAIT_TIME = 0.1
INTERRUPT_CHARS = 1

VGS = {
  :path => "AUD",
  "v" => {
    :path => "VGS",
    "g" => {
      :path => "(Global)?",
      "c" => {
        :path => "Compliment",
        "a" => { :path => "Awesome", :desc => "Awesome!" },
        "g" => { :path => "GoodGame", :desc => "Good game!" },
        "n" => { :path => "NiceMove", :desc => "Nice move!" },
        "s" => { :path => "GreatShot", :desc => "Great shot!" },
        "y" => { :path => "YouRock", :desc => "You rock!" },
      },
      "r" => {
        :path => "Respond",
        "a" => { :path => "AnyTime", :desc => "Any time." },
        "d" => { :path => "DontKnow", :desc => "I don't know." },
        "t" => { :path => "Thanks", :desc => "Thanks." },
        "w" => { :path => "RespondWait", :desc => "Wait." },
      },
      "t" => {
        :path => "Taunt",
        "a" => { :path => "Aww", :desc => "Aww, that's too bad!" },
        "b" => { :path => "Obnoxious", :desc => "Is that the best you can do?" },
        "g" => { :path => "Brag", :desc => "I am the greatest!" },
        "t" => { :path => "Sarcasm", :desc => "THAT was graceful!" },
        "w" => { :path => "Learn", :desc => "When will you learn?" },
      },
      "y" => { :path => "Yes", :desc => "Yes." },
      "n" => { :path => "No", :desc => "No." },
      "h" => { :path => "Hi", :desc => "Hi." },
      "b" => { :path => "Bye", :desc => "Bye." },
      "o" => { :path => "Ooops", :desc => "Ooops." },
      "q" => { :path => "Quiet", :desc => "Quiet!" },
      "s" => { :path => "Shazbot", :desc => "Shazbot!" },
      "w" => { :path => "Woohoo", :desc => "Woohoo!" },
    },
    "a" => {
      :path => "Attack",
      "a" => { :path => "Attack", :desc => "Attack!" },
      "b" => { :path => "Base", :desc => "Attack the enemy base!" },
      "c" => { :path => "Chase", :desc => "Chase the enemy flag carrier!" },
      "d" => { :path => "Disrupt", :desc => "Disrupt the enemy defense!" },
      "f" => { :path => "Flag", :desc => "Get the enemy flag!" },
      "g" => { :path => "Generator", :desc => "Destroy the enemy generator!" },
      "r" => { :path => "Reinforce", :desc => "Reinforce the offense!" },
      "s" => { :path => "Sensors", :desc => "Destroy enemy sensors!" },
      "t" => { :path => "Turrets", :desc => "Destroy enemy turrets!" },
      "v" => { :path => "Vehicle", :desc => "Destroy the enemy vehicle!" },
      "w" => { :path => "AttackWait", :desc => "Wait for my signal before attacking!" },
    },
    "d" => {
      :path => "Defend",
      "b" => { :path => "Base", :desc => "Defend our base!" },
      "c" => { :path => "FlagCarrier", :desc => "Defend the flag carrier!" },
      "e" => { :path => "Entrances", :desc => "Defend the entrances!" },
      "f" => { :path => "Flag", :desc => "Defend our flag!" },
      "g" => { :path => "Generator", :desc => "Defend our generator!" },
      "m" => { :path => "Me", :desc => "Cover me!" },
      "r" => { :path => "Reinforce", :desc => "Reinforce our defense!" },
      "s" => { :path => "Sensors", :desc => "Defend our sensors!" },
      "t" => { :path => "Turrets", :desc => "Defend our turrets!" },
      "v" => { :path => "Vehicle", :desc => "Defend our vehicle!" },
    },
    "r" => {
      :path => "Repair",
      "g" => { :path => "Generator", :desc => "Repair our generator!" },
      "s" => { :path => "Sensors", :desc => "Repair our sensors!" },
      "t" => { :path => "Turrets", :desc => "Repair our turrets!" },
      "v" => { :path => "Vehicle", :desc => "Repair the vehicle!" },
    },
    "b" => {
      :path => "Base",
      "c" => { :path => "Clear", :desc => "Our base is clear." },
      "e" => { :path => "EnemyInBase", :desc => "The enemy is in our base." },
      "r" => { :path => "Retake", :desc => "Retake our base!" },
      "s" => { :path => "Secure", :desc => "Secure our base!" },
    },
    "c" => {
      :path => "Command",
      "a" => { :path => "Acknowledged", :desc => "Acknowledged." },
      "c" => { :path => "Completed", :desc => "Completed." },
      "d" => { :path => "Declined", :desc => "Declined." },
      "w" => { :path => "Assignment", :desc => "What's my assignment?" },
    },
    "e" => {
      :path => "Enemy",
      "d" => { :path => "Disarray", :desc => "The enemy is in disarray." },
      "g" => { :path => "Generator", :desc => "The enemy generator is destroyed." },
      "s" => { :path => "Sensors", :desc => "The enemy sensors are destroyed." },
      "t" => { :path => "Turrets", :desc => "The enemy turrets are destroyed." },
      "v" => { :path => "Vehicle", :desc => "The enemy vehicle is destroyed." },
    },
    "f" => {
      :path => "Flag",
      "d" => { :path => "Defend", :desc => "Defend our flag!" },
      "f" => { :path => "IHave", :desc => "I have the flag!" },
      "g" => { :path => "GiveMe", :desc => "Give me the flag!" },
      "r" => { :path => "Retrieve", :desc => "Retrieve our flag!" },
      "s" => { :path => "Secure", :desc => "Our flag is secure." },
      "t" => { :path => "Take", :desc => "Take the flag from me!" },
    },
    "n" => {
      :path => "Need",
      "c" => { :path => "Cover", :desc => "Need covering fire." },
      "d" => { :path => "Driver", :desc => "I need a driver." },
      "e" => { :path => "Escort", :desc => "I need an escort." },
      "h" => { :path => "HoldVehicle", :desc => "Hold that vehicle! I'm coming!" },
      "r" => { :path => "Ride", :desc => "I need a ride!" },
      "s" => { :path => "Support", :desc => "I need support!" },
      "v" => { :path => "VehicleReady", :desc => "Vehicle ready. Need a ride?" },
      "w" => { :path => "WhereTo", :desc => "Where to?" },
    },
    "s" => {
      :path => "",
      "a" => {
        :path => "SelfAttack",
        "a" => { :path => "Attack", :desc => "I will attack." },
        "b" => { :path => "Base", :desc => "I will attack the enemy base." },
        "f" => { :path => "Flag", :desc => "I'll go for the enemy flag." },
        "g" => { :path => "Generator", :desc => "I'll attack the enemy generator." },
        "s" => { :path => "Sensors", :desc => "I'll attack the enemy sensors." },
        "t" => { :path => "Turrets", :desc => "I'll attack the enemy turrets." },
        "v" => { :path => "Vehicle", :desc => "I'll attack the enemy vehicle." },
      },
      "d" => {
        :path => "SelfDefend",
        "b" => { :path => "Base", :desc => "I will defend our base." },
        "d" => { :path => "Defend", :desc => "I will defend." },
        "f" => { :path => "Flag", :desc => "I will defend our flag." },
        "g" => { :path => "Generator", :desc => "I'll defend our generator." },
        "s" => { :path => "Sensors", :desc => "I'll defend our sensors." },
        "t" => { :path => "Turrets", :desc => "I'll defend our turrets." },
        "v" => { :path => "Vehicle", :desc => "I'll defend our vehicle." },
      },
      "r" => {
        :path => "SelfRepair",
        "b" => { :path => "Base", :desc => "I'll repair our base." },
        "g" => { :path => "Generator", :desc => "I'll repair our generator." },
        "s" => { :path => "Sensors", :desc => "I'll repair our sensors." },
        "t" => { :path => "Turrets", :desc => "I'll repair our turrets." },
        "v" => { :path => "Vehicle", :desc => "I'll repair the vehicle." },
      },
      "t" => {
        :path => "SelfTask",
        "c" => { :path => "Cover", :desc => "I'll cover you." },
        "d" => { :path => "Defenses", :desc => "I'll set up defenses." },
        "f" => { :path => "Forcefield", :desc => "I'll deploy forcefields." },
        "o" => { :path => "OnIt", :desc => "I'm on it." },
        "s" => { :path => "DeploySensors", :desc => "I'm deploying sensors." },
        "t" => { :path => "DeployTurrets", :desc => "I'm deploying turrets." },
        "v" => { :path => "Vehicle", :desc => "I'll get a vehicle ready." },
      },
    },
    "t" => {
      :path => "Target",
      "a" => { :path => "Acquired", :desc => "Target acquired." },
      "b" => { :path => "Base", :desc => "Target the enemy base! I'm in position." },
      "d" => { :path => "Destroyed", :desc => "Target destroyed." },
      "f" => { :path => "Flag", :desc => "Target the enemy flag! I'm in position." },
      "m" => { :path => "FireOnMy", :desc => "Fire on my target!" },
      "n" => { :path => "Need", :desc => "I need a target painted!" },
      "s" => { :path => "Sensors", :desc => "Target the sensors! I'm in position." },
      "t" => { :path => "Turrets", :desc => "Target the turrets! I'm in position." },
      "v" => { :path => "Vehicle", :desc => "Target the vehicle! I'm in position." },
      "w" => { :path => "Wait", :desc => "Wait! I'll be in range soon." },
    },
    "w" => {
      :path => "Warn",
      "e" => { :path => "Enemies", :desc => "Incoming hostiles!" },
      "v" => { :path => "Vehicle", :desc => "Incoming enemy vehicle!" },
    },
    "v" => {
      :path => "Team",
      "y" => { :path => "Yes", :desc => "Yes." },
      "n" => { :path => "No", :desc => "No." },
      "a" => { :path => "Anytime", :desc => "Anytime." },
      "b" => { :path => "BaseSecure", :desc => "Is our base secure?" },
      "c" => { :path => "CeaseFire", :desc => "Cease fire!" },
      "d" => { :path => "DontKnow", :desc => "I don't know." },
      "h" => { :path => "Help", :desc => "Help!" },
      "m" => { :path => "Move", :desc => "Move!" },
      "s" => { :path => "Sorry", :desc => "Sorry." },
      "t" => { :path => "Thanks", :desc => "Thanks." },
      "w" => { :path => "Wait", :desc => "Wait." },
    },
  }
}

bot = Cinch::Bot.new do
  configure do |c|
    c.server = 'sputnik'
    c.nick = 'shazb0t'
    c.channels = ['#foo']
  end

  on :message, /^shazb0t: are you there\?$/ do |m|
    m.reply 'nope'
  end

  on :message, /^say (.*)$/ do |m, s|
    if m.user.nick == 'kibiz0r'
      m.reply s
    else
      m.reply "#{m.user.nick}: i dont know you..."
    end
  end

  on :message, /^shazb0t: restart$/ do |m|
    m.reply 'okay, fine, brb'
    system("sh -c ./bounce_bot")
  end

  on :message, /^voice: (.*)$/ do |m, v|
    if File.directory? "vgs/#{v}"
      voice_prefs[m.user.nick] = v
      m.reply "#{m.user.nick}: Your voice is now '#{v}'"
    else
      m.reply "Unknown voice: '#{v}'\n  Options are: #{Dir['vgs/*'].map { |d| d.gsub 'vgs/', '' }.join ', '}"
    end
  end

  on :message, /^((?:v[a-z]{2,3})(?:[ .]+v[a-z]{2,3})*)$/i do |m, many_vgses|
    many_vgses = many_vgses.to_s
    puts many_vgses

    many_vgses.scan /(v[a-z]{2,3}[ .]*)/i do |(vgs)|
      puts vgs

      vgs, kill_after, _ = vgs.to_s.downcase.partition /[#{VGS_WHITESPACE.join}]+/
      kill_after = kill_after.empty? ? nil : kill_after.length

      _, path_regex, description = vgs.chars.reduce([VGS, VGS[:path]]) do |(vgs_source, p, _), c|
        source = vgs_source[c]
        unless source
          m.reply "#{m.user.nick}: Uknown VGS command: '#{vgs}'"
          raise 'hell'
        end
        [source, "#{p}_?#{source[:path]}", source[:desc]]
      end

      puts "looking for wav matching #{path_regex}"

      voice = voice_prefs[m.user.nick] || DEFAULT_VOICE

      wav = Dir["vgs/#{voice}/*.wav"].detect { |f| puts "does #{f} match #{Regexp.new(path_regex)}?"; f =~ Regexp.new(path_regex) }

      description = "#{description[0..(kill_after * INTERRUPT_CHARS)]} --" if kill_after && kill_after < description.size

      m.reply "[#{vgs.upcase}] #{description}"

      puts "playing #{wav}"
      IO.popen "afplay #{wav}" do |io|
        if kill_after
          sleep kill_after * WAIT_TIME
          Process.kill 'TERM', io.pid
        end
      end
    end
  end
end

bot.start
