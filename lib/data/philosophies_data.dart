// Local copy of the philosophy catalogue — mirrors the backend PHILOSOPHIES list.
// Used by TodayScreen (daily pick) and PhilosophiesScreen (library grid).

class PhilosophyMeta {
  final String id;
  final String name;
  final String icon;
  final String thinker;
  final String tagline;      // one punchy sentence shown on the card
  final String description;  // full text shown in the detail sheet
  final String challenge;    // daily action prompt

  const PhilosophyMeta({
    required this.id,
    required this.name,
    required this.icon,
    required this.thinker,
    required this.tagline,
    required this.description,
    required this.challenge,
  });
}

const List<PhilosophyMeta> kPhilosophies = [
  PhilosophyMeta(
    id: 'spartan_discipline',
    name: 'Spartan Discipline',
    icon: '⚔️',
    thinker: 'Ancient Sparta',
    tagline: 'Your comfort zone is slow death.',
    description:
        'Spartans didn\'t wait to feel ready — they trained until readiness '
        'was irrelevant. Discipline isn\'t punishment; it\'s the highest form '
        'of self-respect. Pick one hard thing right now and do it before '
        'you negotiate with yourself.',
    challenge:
        'Do the one physical or mental task you\'ve been dreading today. '
        'No warm-up. No conditions. Just start.',
  ),
  PhilosophyMeta(
    id: 'extreme_ownership',
    name: 'Extreme Ownership',
    icon: '🔱',
    thinker: 'Jocko Willink',
    tagline: 'You own everything in your world.',
    description:
        'Everything that happens in your life is your responsibility — '
        'not because it\'s all your fault, but because you are the only '
        'variable you control. Leaders who blame lose. Leaders who own, win. '
        'Stop auditing others. Audit yourself.',
    challenge:
        'Name one problem in your life you\'ve been blaming on someone else. '
        'Write one concrete action you can take on it today.',
  ),
  PhilosophyMeta(
    id: 'will_to_power',
    name: "Nietzsche's Self-Overcoming",
    icon: '⚡',
    thinker: 'Friedrich Nietzsche',
    tagline: 'Become who you are — destroy who you were.',
    description:
        'Nietzsche\'s demand was radical: become your highest possible self '
        'through relentless self-overcoming. Average is a choice. The herd '
        'is comfortable. You aren\'t here to be comfortable. '
        'Destroy the version of you that accepts less.',
    challenge:
        'Identify one belief about your limits that is actually just a habit. '
        'Act against it once today.',
  ),
  PhilosophyMeta(
    id: 'bushido',
    name: 'Bushido: The Way of the Warrior',
    icon: '🗡️',
    thinker: 'Miyamoto Musashi · Yamamoto Tsunetomo',
    tagline: 'Honor isn\'t reputation — it\'s what you do alone.',
    description:
        'Bushido teaches that a warrior\'s death begins the moment they '
        'compromise their code. Honor is what you do when no one is watching '
        'and everything is on the line. Cowardice is contagious — '
        'but so is courage.',
    challenge:
        'Do one thing today that you know is right but have been avoiding '
        'because it costs you something.',
  ),
  PhilosophyMeta(
    id: 'forty_percent_rule',
    name: 'The 40% Rule',
    icon: '💥',
    thinker: 'David Goggins · Jesse Itzler',
    tagline: 'When your mind quits, you\'re at 40%.',
    description:
        'When your mind says you\'re done, you\'re at 40% of your actual '
        'capacity. That voice is a biological liar built from evolution. '
        'The Navy SEALs proved it. Goggins proved it. '
        'The wall is where the real work starts — go through it.',
    challenge:
        'Stop at your normal stopping point today — then do 40% more. '
        'In your workout, your work session, your focus block.',
  ),
  PhilosophyMeta(
    id: 'warrior_stoicism',
    name: 'Warrior Stoicism',
    icon: '🏛️',
    thinker: 'Marcus Aurelius',
    tagline: 'Control what you can. Execute on it now.',
    description:
        'Marcus Aurelius commanded the largest empire on earth and still '
        'woke before dawn to remind himself: focus only on what you can act on. '
        'Complaining is a vote for your own defeat. Find the one degree '
        'you control and execute — now.',
    challenge:
        'Write down your biggest current problem. Circle only the parts '
        'you can act on today. Ignore the rest entirely.',
  ),
  PhilosophyMeta(
    id: 'sun_tzu',
    name: "Sun Tzu's Strategic Dominance",
    icon: '♟️',
    thinker: 'Sun Tzu',
    tagline: 'Every battle is won before it\'s fought.',
    description:
        'Sun Tzu didn\'t prize brute force — he prized positioning, '
        'information, and patience. You don\'t lose because they\'re stronger. '
        'You lose because you reacted instead of planned. '
        'Study the terrain. Move with purpose.',
    challenge:
        'Map out your next 3 moves in the situation you\'re losing. '
        'Don\'t react today — execute the plan.',
  ),
  PhilosophyMeta(
    id: 'musashi_mastery',
    name: "Musashi's Way of the Sword",
    icon: '⛩️',
    thinker: 'Miyamoto Musashi',
    tagline: 'One path. Total obsession. Undefeated.',
    description:
        'Musashi won 61 duels undefeated through one principle: '
        'single-pointed mastery. He didn\'t diversify. He cut everything '
        'that wasn\'t the sword. Distraction isn\'t a modern problem — '
        'it\'s a discipline problem.',
    challenge:
        'Identify your one most important skill. Block 90 uninterrupted minutes '
        'to work only on that today. No multitasking.',
  ),
  PhilosophyMeta(
    id: 'seneca_urgency',
    name: "Seneca's Urgency Doctrine",
    icon: '⏳',
    thinker: 'Lucius Annaeus Seneca',
    tagline: 'Your time is bleeding out. Act now.',
    description:
        'Seneca watched men squander entire lives waiting for the perfect moment. '
        'Everything is borrowed — only time is truly yours, and it\'s '
        'already draining. Not someday. Not when ready. '
        'This hour. Right now.',
    challenge:
        'Name the one project you\'ve been saying "soon" to. '
        'Do the first concrete step on it before noon today.',
  ),
  PhilosophyMeta(
    id: 'roosevelts_arena',
    name: "Roosevelt's Arena",
    icon: '🏟️',
    thinker: 'Theodore Roosevelt',
    tagline: 'The critic in the stands has no power over you.',
    description:
        'It is not the critic who counts. The credit belongs to the one '
        'in the arena — face marred by dust and sweat and blood. '
        'The people watching from the stands have zero power over you. '
        'The only shame is never entering at all.',
    challenge:
        'Do the one thing you\'ve been postponing because of what people might think. '
        'Post it, send it, say it, start it.',
  ),
  PhilosophyMeta(
    id: 'epictetus_fortress',
    name: "Epictetus' Inner Citadel",
    icon: '🔒',
    thinker: 'Epictetus',
    tagline: 'No one enters your inner world without permission.',
    description:
        'Epictetus was a slave who became freer than his masters — '
        'because he understood one absolute truth: no one can touch your '
        'inner world without your permission. Their opinion is their business. '
        'Lock the gate. Govern yourself.',
    challenge:
        'The next time someone\'s opinion or behavior bothers you today, '
        'pause and ask: "Did I choose to let this in?" Then don\'t.',
  ),
  PhilosophyMeta(
    id: 'alexander_conquest',
    name: "Alexander's Conquest Mindset",
    icon: '👑',
    thinker: 'Alexander the Great',
    tagline: 'Your goals are too small. Expand the frame.',
    description:
        'Alexander wept at 32 because he had no more worlds to conquer. '
        'Most people never conquer one. Your "realistic" goal is almost certainly '
        'a cage you built yourself. The audacity of the target calls forth '
        'the greatness to match it.',
    challenge:
        'Take your biggest current goal and 10x it on paper. '
        'Then ask: what would actually need to be true for that to happen?',
  ),
  PhilosophyMeta(
    id: 'mamba_mentality',
    name: 'Mamba Mentality',
    icon: '🐍',
    thinker: 'Kobe Bryant',
    tagline: '4am. Alone. Still training. That\'s the standard.',
    description:
        'The Mamba didn\'t train to be good. He trained at 4am alone '
        'because he was already better than everyone and still wanted more. '
        'Good enough is an insult to your potential. '
        'What would your absolute best look like?',
    challenge:
        'Identify where you\'ve been settling for "good enough" this week. '
        'Redo that one thing to your actual standard.',
  ),
  PhilosophyMeta(
    id: 'naval_long_game',
    name: "Naval's Long-Game Philosophy",
    icon: '🚀',
    thinker: 'Naval Ravikant',
    tagline: 'Equity, not salary. Leverage, not labor.',
    description:
        'Wealth is built through specific knowledge, leverage, and compounding — '
        'not by selling hours. You want equity, not salary. '
        'Play long-term games with long-term people. '
        'Every shortcut is a loan from your future self at ruinous interest.',
    challenge:
        'Spend 30 minutes today on something that compounds — a skill, '
        'a relationship, a system — not just what\'s urgent.',
  ),
  PhilosophyMeta(
    id: 'diogenes_freedom',
    name: "Diogenes' Radical Freedom",
    icon: '🔥',
    thinker: 'Diogenes of Sinope',
    tagline: 'The man with nothing to lose answers to no one.',
    description:
        'Diogenes smashed his bowl when he saw a child drink from cupped hands. '
        'Alexander offered him anything; he asked him to move — he was blocking the sun. '
        'What are you actually protecting? '
        'Is the cage worth what you think it\'s protecting?',
    challenge:
        'List three things you own or maintain purely for status or others\' approval. '
        'Ask what your life would look like without each one.',
  ),
];