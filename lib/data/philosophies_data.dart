// ═══════════════════════════════════════════════════════════════════════════════
// Philosophy catalogue — 30 timeless frameworks, no modern gurus.
// Grouped into 6 categories matched by the onboarding quiz scorer.
// ═══════════════════════════════════════════════════════════════════════════════

enum PhilosophyCategory {
  discipline,   // willpower, action, mastery
  creativity,   // art, expression, making
  mindfulness,  // presence, peace, acceptance
  reason,       // science, inquiry, logic
  existential,  // meaning, identity, authenticity
  relations,    // ethics, friendship, society
}

class PhilosophyMeta {
  final String id;
  final String name;
  final String icon;
  final String thinker;
  final String era;
  final String tagline;
  final String description;
  final String challenge;
  final String weeklyChallenge;
  final PhilosophyCategory category;

  const PhilosophyMeta({
    required this.id,
    required this.name,
    required this.icon,
    required this.thinker,
    required this.era,
    required this.tagline,
    required this.description,
    required this.challenge,
    required this.weeklyChallenge,
    required this.category,
  });
}

const List<PhilosophyMeta> kPhilosophies = [

  // DISCIPLINE ─────────────────────────────────────────────────────────────────

  PhilosophyMeta(
    id: 'spartan_discipline',
    name: 'Spartan Discipline',
    icon: '⚔️',
    thinker: 'The Spartan Code',
    era: 'Ancient Greece · 900 BCE',
    tagline: 'The obstacle is the training.',
    description:
        'Spartans understood that hardship was not the enemy of excellence — it was the method. '
        'Every deprivation was deliberate. Every challenge was the curriculum. '
        'The body does not build character; suffering the body voluntarily does. '
        'Choose difficulty before difficulty chooses you.',
    challenge:
        'Do one physically hard thing today before anything comfortable. '
        'Cold shower, early run, heavy lift — no negotiation, no conditions.',
    weeklyChallenge:
        'For 7 days, wake at the same time regardless of the night before. '
        'Track it. The streak itself becomes the discipline.',
    category: PhilosophyCategory.discipline,
  ),

  PhilosophyMeta(
    id: 'marcus_aurelius',
    name: 'The Meditations',
    icon: '🏛️',
    thinker: 'Marcus Aurelius',
    era: 'Roman Empire · 161–180 CE',
    tagline: 'You have power over your mind, not events.',
    description:
        'Marcus Aurelius ruled the known world and wrote a private journal he never intended to publish — '
        'a daily practice of reminding himself what he could and could not control. '
        'The Meditations are not philosophy performed for an audience. '
        'They are philosophy as survival. He failed often. He wrote anyway. That is the point.',
    challenge:
        'Write three sentences: what happened, what you cannot control about it, '
        'and the one action you can take. Do this for your biggest current problem.',
    weeklyChallenge:
        'Each morning this week, write one thing you are grateful for and one obstacle you will meet. '
        'Each night, write what actually happened.',
    category: PhilosophyCategory.discipline,
  ),

  PhilosophyMeta(
    id: 'bushido',
    name: 'Bushido',
    icon: '🗡️',
    thinker: 'Yamamoto Tsunetomo',
    era: 'Feudal Japan · 1716 CE',
    tagline: 'The way of the samurai is found in death.',
    description:
        'Tsunetomo wrote the Hagakure for a world where a samurai purpose was total service — '
        'not to outcome, not to reward, but to the code itself. '
        'Honor is not reputation. It is the private standard you hold when no one will ever know you kept it. '
        'Every small compromise is where the decay begins.',
    challenge:
        'Identify one small place where you have been cutting corners. '
        'Fix it today — not because anyone will see, but because you will know.',
    weeklyChallenge:
        'Write your personal code — five rules you will not break, regardless of cost. '
        'Live by them this week.',
    category: PhilosophyCategory.discipline,
  ),

  PhilosophyMeta(
    id: 'sun_tzu',
    name: 'The Art of War',
    icon: '♟️',
    thinker: 'Sun Tzu',
    era: 'Ancient China · 500 BCE',
    tagline: 'Supreme excellence is winning without fighting.',
    description:
        'Sun Tzu was not interested in brute force — he was interested in positioning. '
        'Putting yourself where winning is inevitable before the contest begins. '
        'Most people fight when they should be preparing, charge when they should be waiting. '
        'Know your terrain. Know your opponent. Know yourself. In that order.',
    challenge:
        'Map the situation you are navigating as if it is a battlefield. '
        'Where are you strong? Where exposed? What terrain are you not using?',
    weeklyChallenge:
        'Plan next week before it begins. Write your three most important objectives '
        'and anticipate the one thing most likely to derail each.',
    category: PhilosophyCategory.discipline,
  ),

  PhilosophyMeta(
    id: 'musashi',
    name: 'The Book of Five Rings',
    icon: '⛩️',
    thinker: 'Miyamoto Musashi',
    era: 'Feudal Japan · 1645 CE',
    tagline: 'Do nothing that is not useful.',
    description:
        'Musashi won 61 duels and spent the last years of his life in a cave writing about mastery. '
        'His conclusion: mastery is the elimination of everything unnecessary. '
        'Not just in technique — in life. Every possession, habit, and relationship '
        'that does not serve your path is weight. Cut it.',
    challenge:
        'List everything you did yesterday. Mark each as essential or noise. '
        'Eliminate one noise item today.',
    weeklyChallenge:
        'Pick one skill. Spend 45 minutes every day this week practicing it '
        'with full attention. No multitasking. No checking.',
    category: PhilosophyCategory.discipline,
  ),

  PhilosophyMeta(
    id: 'seneca',
    name: 'Letters on Time',
    icon: '⏳',
    thinker: 'Lucius Annaeus Seneca',
    era: 'Roman Empire · 65 CE',
    tagline: 'It is not that we have little time — we waste much.',
    description:
        'Seneca wrote his letters to Lucilius knowing he was dying, watching powerful men '
        'squander decades on trivialities. His argument: time is the only truly non-renewable resource, '
        'and most people spend it as if it were infinite. It is not. Begin.',
    challenge:
        'Name the one project you have been saying "soon" to. '
        'Do the first concrete step before anything else today.',
    weeklyChallenge:
        'Audit one hour of your average day. Track exactly how each minute is spent. '
        'Reclaim the minutes being lost without decision.',
    category: PhilosophyCategory.discipline,
  ),

  PhilosophyMeta(
    id: 'epictetus',
    name: 'The Enchiridion',
    icon: '🔒',
    thinker: 'Epictetus',
    era: 'Roman Empire · 50–135 CE',
    tagline: 'Seek not that events happen as you wish — wish them as they do.',
    description:
        'Epictetus was born a slave. He became one of the most influential philosophers in history '
        'by mastering one insight: the dichotomy of control. '
        'There are things in your power — judgments, impulses, desires. '
        'There are things not in your power — everything else. '
        'The entirety of philosophy, he argued, is learning to tell them apart.',
    challenge:
        'Write down your three biggest current worries. Mark each: in my control or not in my control. '
        'For the latter — release them.',
    weeklyChallenge:
        'For 7 days, whenever you feel upset, pause and ask: is this in my control? '
        'Spend your energy only on what is.',
    category: PhilosophyCategory.discipline,
  ),

  PhilosophyMeta(
    id: 'nietzsche',
    name: 'Self-Overcoming',
    icon: '⚡',
    thinker: 'Friedrich Nietzsche',
    era: 'Prussia · 1883–1888 CE',
    tagline: 'Become who you are.',
    description:
        'Nietzsche demand was not to be better than others — it was to be better than '
        'yesterday version of yourself, relentlessly, without comfort, without the approval of the herd. '
        'The Ubermensch is not a superior human type. '
        'It is the personal commitment to create your own values rather than inherit them. '
        'Destroy what you have outgrown. Become the next thing.',
    challenge:
        'Identify one belief about your limits that is actually a habit masquerading as fact. '
        'Act against it once today.',
    weeklyChallenge:
        'Write a manifesto — your own values, not borrowed ones. '
        'What do you actually believe? What are you willing to live for?',
    category: PhilosophyCategory.discipline,
  ),

  PhilosophyMeta(
    id: 'roosevelts_arena',
    name: 'The Man in the Arena',
    icon: '🏟️',
    thinker: 'Theodore Roosevelt',
    era: 'United States · 1910 CE',
    tagline: 'The credit belongs to the one actually in the arena.',
    description:
        'Roosevelt 1910 Sorbonne speech became one of the most quoted calls to action in history. '
        'Its argument is simple: the critic has no standing. '
        'Only the person who attempts — who risks failure, public embarrassment, and real consequences — '
        'has any right to an opinion on the outcome. Stop watching from the stands.',
    challenge:
        'Do the one thing you have been postponing because of what others might think. '
        'Publish it, send it, say it, start it — today.',
    weeklyChallenge:
        'Enter one arena you have been avoiding — pitch something, start something, apply for something. '
        'Risk something real this week.',
    category: PhilosophyCategory.discipline,
  ),

  PhilosophyMeta(
    id: 'diogenes',
    name: "Diogenes' Radical Freedom",
    icon: '🔥',
    thinker: 'Diogenes of Sinope',
    era: 'Ancient Greece · 412–323 BCE',
    tagline: 'The man with nothing to lose answers to no one.',
    description:
        'When Alexander the Great offered Diogenes anything he desired, '
        'Diogenes asked him to step aside — he was blocking the sun. '
        'Diogenes owned almost nothing by choice. He understood that every possession, '
        'status symbol, and social obligation is also a chain. '
        'Freedom is not having more options — it is needing fewer.',
    challenge:
        'List three things you maintain purely for status or others approval. '
        'Ask honestly: what would your life look like without each one?',
    weeklyChallenge:
        'Spend one day this week deliberately without something you consider essential comfort. '
        'Notice what you actually need.',
    category: PhilosophyCategory.discipline,
  ),

  // CREATIVITY ──────────────────────────────────────────────────────────────────

  PhilosophyMeta(
    id: 'davinci',
    name: "Da Vinci's Curiosity",
    icon: '🎨',
    thinker: 'Leonardo da Vinci',
    era: 'Florence · 1452–1519 CE',
    tagline: 'Study the science of art. Study the art of science.',
    description:
        'Leonardo notebooks — 7,200 pages — contain painting, anatomy, engineering, geology, music, and optics. '
        'He never considered these separate domains. His method was insatiable curiosity without premature judgment. '
        'He would spend years on a question with no practical application. '
        'That is not inefficiency. That is how the Mona Lisa gets painted.',
    challenge:
        'Ask one question today that has no immediate practical use. '
        'Spend 20 minutes following your curiosity wherever it leads, without guilt.',
    weeklyChallenge:
        'Start a curiosity journal. Each day this week, write one thing you noticed '
        'and one question it raised. Ask without needing to answer.',
    category: PhilosophyCategory.creativity,
  ),

  PhilosophyMeta(
    id: 'rumi',
    name: "Rumi's Way of the Heart",
    icon: '❤️‍🔥',
    thinker: 'Jalal ad-Din Rumi',
    era: 'Persia · 1207–1273 CE',
    tagline: 'The wound is the place where light enters you.',
    description:
        'Rumi wrote the Masnavi — 25,000 verses — in grief, after his spiritual companion Shams disappeared. '
        'He transformed loss into the most widely read poetry in human history. '
        'His teaching is not that pain should be avoided. '
        'It is that pain, fully felt, becomes the instrument of transformation.',
    challenge:
        'Write three lines about something you are carrying — '
        'not to analyze it, but to let it speak. No craft required. Just honesty.',
    weeklyChallenge:
        'Create something this week solely for yourself — not to share, not to improve. '
        'A poem, a sketch, a song. The audience is your own inner life.',
    category: PhilosophyCategory.creativity,
  ),

  PhilosophyMeta(
    id: 'picasso',
    name: 'Creative Destruction',
    icon: '✂️',
    thinker: 'Pablo Picasso',
    era: 'Spain · 1881–1973 CE',
    tagline: 'Every act of creation is first an act of destruction.',
    description:
        'Picasso invented Cubism by destroying the rules of perspective that had governed '
        'Western painting for 400 years. He did not improve the existing framework — he shattered it. '
        'His lesson is not about art. It is about the courage to make something '
        'unrecognizable to the people around you, before you have permission.',
    challenge:
        'Take something you have been working on and remove its most "safe" element. '
        'Break one rule you have been following without examining why.',
    weeklyChallenge:
        'Produce something this week that intentionally breaks the conventions of its form. '
        'If you write, write differently. If you design, violate one rule deliberately.',
    category: PhilosophyCategory.creativity,
  ),

  PhilosophyMeta(
    id: 'montaigne',
    name: 'The Self as Subject',
    icon: '🪞',
    thinker: 'Michel de Montaigne',
    era: 'France · 1533–1592 CE',
    tagline: 'Every man carries the entire form of the human condition within him.',
    description:
        'Montaigne invented the essay — and with it, a new kind of self-examination. '
        'His subject was himself, not because he was important, but because honest '
        'observation of oneself is the most universal thing a person can offer. '
        'He wrote about fear, friendship, and cannibals with equal seriousness. '
        'The examined life does not need grand material.',
    challenge:
        'Write one honest page about something you have never put into words — '
        'not a journal entry, but an essay with an actual argument about yourself.',
    weeklyChallenge:
        'Each day this week, write one observation about your own behavior that surprised you. '
        'Look for patterns by day 7.',
    category: PhilosophyCategory.creativity,
  ),

  PhilosophyMeta(
    id: 'chekhov',
    name: "Chekhov's Gun",
    icon: '🖊️',
    thinker: 'Anton Chekhov',
    era: 'Russia · 1860–1904 CE',
    tagline: 'If you show a gun in Act One, it must fire by Act Three.',
    description:
        'Chekhov principle of narrative economy is one of the most useful '
        'ideas in any creative field: nothing should exist without purpose. '
        'Every element either earns its place or dilutes everything around it. '
        'This extends beyond writing — to conversations, products, relationships, lives. '
        'What are you carrying that will never fire?',
    challenge:
        'Identify one thing in your current project, workspace, or life '
        'that exists without clear purpose. Decide: make it earn its place or remove it.',
    weeklyChallenge:
        'Apply radical edit to something you have been working on. '
        'Remove 20% of it. See if it becomes more powerful.',
    category: PhilosophyCategory.creativity,
  ),

  // MINDFULNESS ─────────────────────────────────────────────────────────────────

  PhilosophyMeta(
    id: 'zen',
    name: "Zen's Beginner's Mind",
    icon: '🍃',
    thinker: 'Shunryu Suzuki',
    era: 'Japan · 1904–1971 CE',
    tagline: "In the beginner's mind there are many possibilities. In the expert's, few.",
    description:
        "Suzuki teaching is deceptively simple: the moment you believe you know something completely, "
        'you stop seeing it. Expertise becomes blindness. The beginner asks obvious questions. '
        'The beginner notices what the expert overlooks. '
        'This is not incompetence — it is the discipline of remaining open.',
    challenge:
        'Approach one task you do habitually today as if for the first time. '
        'Notice three things you have never noticed before.',
    weeklyChallenge:
        'Spend 10 minutes each morning in complete silence before checking anything. '
        'No phone, no podcast, no plan. Simply sit.',
    category: PhilosophyCategory.mindfulness,
  ),

  PhilosophyMeta(
    id: 'epicurus',
    name: "Epicurus' Garden",
    icon: '🌿',
    thinker: 'Epicurus',
    era: 'Ancient Greece · 341–270 BCE',
    tagline: 'It is not the man who has too little who is poor, but the one who craves more.',
    description:
        'Epicurus is almost always misunderstood. He did not advocate for excess. '
        'He taught that the good life was achieved through ataraxia — tranquility, freedom from anxiety — '
        'and philia — deep friendship. His commune outside Athens was called the Garden. '
        'They grew food and discussed philosophy. Pleasure was the absence of pain, not the pursuit of more.',
    challenge:
        'Identify the one thing causing the most anxiety right now. '
        'Ask: is this desire necessary, or is it manufactured? What would actually be enough?',
    weeklyChallenge:
        'Spend time this week investing in one friendship — not networking, not socializing. '
        'Actual sustained attention to one person.',
    category: PhilosophyCategory.mindfulness,
  ),

  PhilosophyMeta(
    id: 'zhuangzi',
    name: "Zhuangzi's Transformation",
    icon: '🦋',
    thinker: 'Zhuangzi',
    era: 'Ancient China · 370–287 BCE',
    tagline: 'Am I a man dreaming I am a butterfly, or a butterfly dreaming I am a man?',
    description:
        'Zhuangzi cooked a magnificent ox for a prince who asked how he did it. '
        'He replied that he had stopped seeing the whole ox — he worked with his mind, not his eyes, '
        'following the natural structure. His teaching: effort fighting against natural structure '
        'creates suffering. Effortlessness is not laziness — it is alignment with how things actually are.',
    challenge:
        'Find one place where you are forcing something today. '
        'Step back and let it find its own natural shape instead.',
    weeklyChallenge:
        'Choose one problem you have been pushing against. Spend this week '
        'approaching it through indirect paths — what would happen if you stopped pushing?',
    category: PhilosophyCategory.mindfulness,
  ),

  PhilosophyMeta(
    id: 'wu_wei',
    name: "Lao Tzu's Wu Wei",
    icon: '🌊',
    thinker: 'Lao Tzu',
    era: 'Ancient China · 6th Century BCE',
    tagline: 'The Tao that can be named is not the eternal Tao.',
    description:
        'Wu Wei is translated as non-action but better understood as action without force. '
        'Water is the softest substance in the world. It is also what carves canyons. '
        'The Tao Te Ching entire message: excessive effort against the nature of things '
        'creates its own resistance. Move with what is, not against it.',
    challenge:
        'Today, when you feel the urge to force or control an outcome, pause. '
        'Ask what would happen if you created the conditions and stepped aside.',
    weeklyChallenge:
        'Identify one relationship or project where you are over-controlling. '
        'This week, do 30% less management of it. Observe what happens.',
    category: PhilosophyCategory.mindfulness,
  ),

  PhilosophyMeta(
    id: 'frankl',
    name: "Man's Search for Meaning",
    icon: '🕯️',
    thinker: 'Viktor Frankl',
    era: 'Vienna · 1905–1997 CE',
    tagline: 'Between stimulus and response there is a space. In that space is our power to choose.',
    description:
        'Frankl survived four Nazi concentration camps — Auschwitz among them — '
        'and emerged to write the most significant work of existential psychology in the 20th century. '
        'His finding: people could endure almost anything if they had a reason. '
        'The camps stripped everything from him except the last human freedom — '
        'the choice of how to respond. That freedom can never be taken.',
    challenge:
        'Write one sentence answering: what is the one thing making your current difficulty worth enduring? '
        'If you cannot find it, that is your real problem.',
    weeklyChallenge:
        'Write a meaning statement — not goals, not values, but one paragraph '
        'about why your life matters in a way only you can fill.',
    category: PhilosophyCategory.mindfulness,
  ),

  // REASON ──────────────────────────────────────────────────────────────────────

  PhilosophyMeta(
    id: 'socratic',
    name: 'The Socratic Method',
    icon: '❓',
    thinker: 'Socrates',
    era: 'Ancient Athens · 470–399 BCE',
    tagline: 'I know that I know nothing.',
    description:
        'Socrates was executed for asking too many questions. '
        'His method was not to teach — it was to expose the difference '
        'between knowing something and merely believing it with confidence. '
        'He would take a smart person most certain belief and ask why '
        'until they arrived at the foundation — which was usually nothing. '
        'True knowledge begins where comfortable certainty ends.',
    challenge:
        'Take your most confident current belief and ask why five times. '
        'Write down what you find at the bottom.',
    weeklyChallenge:
        'Have one conversation this week where you only ask questions — '
        'no opinions, no advice, no agreement. Just inquiry.',
    category: PhilosophyCategory.reason,
  ),

  PhilosophyMeta(
    id: 'feynman',
    name: 'The Pleasure of Finding Out',
    icon: '🔬',
    thinker: 'Richard Feynman',
    era: 'United States · 1918–1988 CE',
    tagline: 'The first principle is that you must not fool yourself — and you are the easiest person to fool.',
    description:
        'Feynman was one of the greatest physicists of the 20th century and its best teacher. '
        'His method: if you cannot explain something simply, you do not understand it yet. '
        'He was pathologically honest about what he did not know, and joyfully curious about everything. '
        'He safecracked as a hobby in Los Alamos. He played bongo drums. '
        'Curiosity is not a personality type — it is a practice.',
    challenge:
        'Pick one thing you think you understand. Try to explain it to a 10-year-old. '
        'Identify exactly where your explanation breaks down.',
    weeklyChallenge:
        'Learn one thing this week with absolutely no connection to your work or goals. '
        'Follow pure curiosity for its own sake.',
    category: PhilosophyCategory.reason,
  ),

  PhilosophyMeta(
    id: 'sagan',
    name: 'The Pale Blue Dot',
    icon: '🌌',
    thinker: 'Carl Sagan',
    era: 'United States · 1934–1996 CE',
    tagline: 'We are a way for the cosmos to know itself.',
    description:
        'In 1990, Voyager 1 was 3.7 billion miles from Earth. Sagan asked NASA to turn its camera around. '
        'In the photograph, Earth is a fraction of a pixel. '
        'On that mote of dust, every human being who ever lived, every empire, '
        'every war, every act of cruelty and kindness. '
        'The cosmic perspective does not diminish life — it clarifies it.',
    challenge:
        'Write about your current biggest problem from the perspective of 4 billion years of geology. '
        'Then write what actually matters from that view.',
    weeklyChallenge:
        'Spend one hour this week with the scale of the universe — a documentary, a dark sky, a telescope. '
        'Return to your problems with adjusted eyes.',
    category: PhilosophyCategory.reason,
  ),

  PhilosophyMeta(
    id: 'aristotle',
    name: "Aristotle's Eudaimonia",
    icon: '🏺',
    thinker: 'Aristotle',
    era: 'Ancient Greece · 384–322 BCE',
    tagline: 'Happiness is the activity of the soul in accordance with virtue.',
    description:
        'Aristotle eudaimonia is usually translated as happiness but actually means human flourishing — '
        'the full exercise of distinctly human capacities. '
        'He argued it was not a feeling but an activity. '
        'You do not receive flourishing — you practice it, through virtue, through friendship, '
        'through the life of the mind, repeatedly, over a lifetime.',
    challenge:
        'Identify the one activity where you feel most fully yourself. '
        'Ask why you do not do it more. Remove one obstacle to it today.',
    weeklyChallenge:
        'Practice one virtue deliberately this week — courage, honesty, generosity, or justice. '
        'Not as a feeling but as a repeated choice.',
    category: PhilosophyCategory.reason,
  ),

  PhilosophyMeta(
    id: 'russell',
    name: "Russell's Honest Uncertainty",
    icon: '🧩',
    thinker: 'Bertrand Russell',
    era: 'Britain · 1872–1970 CE',
    tagline: 'The stupid are cocksure while the intelligent are full of doubt.',
    description:
        'Russell spent his career arguing that intellectual honesty — the willingness to say I do not know — '
        'was the most important and rarest human virtue. '
        'He watched two World Wars unfold driven by men who were absolutely certain. '
        'Proportioning your conviction to your evidence, and maintaining calibrated uncertainty, '
        'is not weakness. It is the foundation of all good thinking.',
    challenge:
        'Find one belief you hold with high certainty. Ask: what evidence would change my mind? '
        'If you cannot name it, you are rationalizing, not reasoning.',
    weeklyChallenge:
        'Replace "I know" with "I think" or "the evidence suggests" in your speech this week. '
        'Notice how it changes what you say.',
    category: PhilosophyCategory.reason,
  ),

  // EXISTENTIAL ─────────────────────────────────────────────────────────────────

  PhilosophyMeta(
    id: 'camus',
    name: "Camus' Revolt",
    icon: '🎭',
    thinker: 'Albert Camus',
    era: 'France / Algeria · 1913–1960 CE',
    tagline: 'One must imagine Sisyphus happy.',
    description:
        'The gods condemned Sisyphus to roll a boulder to the hilltop, watch it roll back, and repeat forever. '
        'Camus argument: this is the human condition. There is no cosmic meaning. '
        'The universe does not care. And therefore — revolt. '
        'To live fully and joyfully despite the absurdity is not defeat. '
        'It is the only authentic victory available to us.',
    challenge:
        'Name one area of your life you have been waiting for meaning to arrive in. '
        'Stop waiting. Act in it today as if it matters, because you have decided it does.',
    weeklyChallenge:
        'Do one thing this week purely for the joy of doing it, '
        'with no outcome, no audience, no purpose beyond the doing itself.',
    category: PhilosophyCategory.existential,
  ),

  PhilosophyMeta(
    id: 'kierkegaard',
    name: "Kierkegaard's Leap",
    icon: '🌅',
    thinker: 'Soren Kierkegaard',
    era: 'Denmark · 1813–1855 CE',
    tagline: 'The most common form of despair is not being who you are.',
    description:
        'Kierkegaard described three stages of existence: the aesthetic, the ethical, and the authentic. '
        'Most people never make the leap to authentic existence — they drift, '
        'performing for audiences, consuming experience. '
        'Authentic existence requires a radical, unjustifiable commitment to who you actually are.',
    challenge:
        'Write two versions of yourself: the one you perform for others, '
        'and the one you are when alone. Where do they diverge? '
        'Make one choice today that honors the second version.',
    weeklyChallenge:
        'Identify one thing you do purely for external approval. '
        'This week, either stop doing it or do it purely for your own reasons.',
    category: PhilosophyCategory.existential,
  ),

  PhilosophyMeta(
    id: 'beauvoir',
    name: "De Beauvoir's Freedom",
    icon: '🗽',
    thinker: 'Simone de Beauvoir',
    era: 'France · 1908–1986 CE',
    tagline: 'One is not born a woman — one becomes one.',
    description:
        'De Beauvoir insight extended far beyond gender. She argued that human identity is not given — '
        'it is constructed, continuously, through choices and actions in a world '
        'that constantly tries to assign you a fixed role. '
        'The refusal to be defined by others, to choose yourself repeatedly and actively, '
        'is the core existentialist act.',
    challenge:
        'Identify one role or label others have assigned to you that you have accepted without examination. '
        'Is it true? Did you choose it?',
    weeklyChallenge:
        'Make five choices this week that are entirely yours — '
        'not what is expected, not what is approved. Notice the discomfort. Stay with it.',
    category: PhilosophyCategory.existential,
  ),

  PhilosophyMeta(
    id: 'pascal',
    name: "Pascal's Pensees",
    icon: '💭',
    thinker: 'Blaise Pascal',
    era: 'France · 1623–1662 CE',
    tagline: "All of humanity's problems stem from man's inability to sit quietly in a room alone.",
    description:
        'Pascal was a mathematical genius who had a mystical experience and spent the rest of his life '
        'writing fragments — the Pensees — exploring reason, faith, grandeur and wretchedness. '
        'His observation about sitting quietly was not a complaint — it was a diagnosis. '
        'We distract ourselves to death because facing our own existence is genuinely terrifying. '
        'The cure is the facing.',
    challenge:
        'Sit alone in a room for 15 minutes with no phone, no book, no task. '
        'Notice what arises when you stop running from yourself.',
    weeklyChallenge:
        'Each evening this week, spend 10 minutes in silence before sleep. '
        'No screens. No input. Just your own mind.',
    category: PhilosophyCategory.existential,
  ),

  PhilosophyMeta(
    id: 'alexander',
    name: "Alexander's Grand Vision",
    icon: '👑',
    thinker: 'Alexander the Great',
    era: 'Macedon · 356–323 BCE',
    tagline: 'There is nothing impossible to him who will try.',
    description:
        'Alexander was tutored by Aristotle and commanded the known world by 25. '
        'He wept at 32 because there were no more worlds to conquer. '
        'His lesson is not about war — it is about scale of vision. '
        'Most people ambitions are constrained by what they have seen others attempt. '
        'Alexander had no such constraints.',
    challenge:
        'Take your biggest current goal and multiply it by 10 on paper. '
        'Then ask: what would actually need to be true for that to be possible?',
    weeklyChallenge:
        'Design a version of your life 10 years from now with no practical constraints. '
        'Write it in full detail. Then identify the first real step toward it.',
    category: PhilosophyCategory.existential,
  ),

  // RELATIONS ───────────────────────────────────────────────────────────────────

  PhilosophyMeta(
    id: 'confucius',
    name: "Confucius' Way of Virtue",
    icon: '🏯',
    thinker: 'Confucius',
    era: 'Ancient China · 551–479 BCE',
    tagline: 'The man who moves a mountain begins by carrying away small stones.',
    description:
        'Confucius taught that social harmony begins with self-cultivation, then extends outward — '
        'to family, community, state. His concept of ren (benevolence) and li (ritual propriety) '
        'were not abstract ideals but daily practices: how you greet someone, '
        'fulfill your role, honor your relationships. '
        'Character is built in ordinary moments, not extraordinary ones.',
    challenge:
        'Identify one relationship where you have been taking more than giving. '
        'Make one concrete act of generosity toward that person today.',
    weeklyChallenge:
        'Perform one act of genuine service this week — not for recognition, not to be repaid. '
        'Simply because someone needs it.',
    category: PhilosophyCategory.relations,
  ),

  PhilosophyMeta(
    id: 'simone_weil',
    name: "Simone Weil's Attention",
    icon: '🌻',
    thinker: 'Simone Weil',
    era: 'France · 1909–1943 CE',
    tagline: 'Attention is the rarest and purest form of generosity.',
    description:
        'Weil chose to work in factories and fields to understand the lives of those who labored there. '
        'Her central insight: truly attending to another person — '
        'not waiting for your turn to speak, not projecting, not advising — '
        'is the most difficult and most important thing a human can do. '
        'Most of what passes for care is really waiting for our own voice.',
    challenge:
        'Have one conversation today where you give your complete, undivided attention. '
        'No phone, no agenda, no interjections. Just listening.',
    weeklyChallenge:
        'This week, notice every moment when your mind is away during a conversation. '
        'Practice returning. The return is the practice.',
    category: PhilosophyCategory.relations,
  ),

  PhilosophyMeta(
    id: 'thoreau',
    name: "Thoreau's Deliberate Life",
    icon: '🌲',
    thinker: 'Henry David Thoreau',
    era: 'United States · 1817–1862 CE',
    tagline: 'I went to the woods because I wished to live deliberately.',
    description:
        'Thoreau spent two years, two months, and two days at Walden Pond to answer one question: '
        'what is actually necessary? He found that most of what civilization calls essential is noise, '
        'and most of what it ignores — a morning, a pond, an hour of silence — '
        'is where life actually happens. He was not anti-civilization. He was anti-unconsciousness.',
    challenge:
        'Go outside today without your phone for 30 minutes. '
        'Walk slowly. Notice what you see when you stop moving at device speed.',
    weeklyChallenge:
        'Audit one area of your life this week that you have been living on autopilot. '
        'Make three deliberate choices in it instead of default ones.',
    category: PhilosophyCategory.relations,
  ),

  PhilosophyMeta(
    id: 'ethics_of_care',
    name: 'The Ethics of Care',
    icon: '🤝',
    thinker: 'Carol Gilligan',
    era: 'United States · 1936–present',
    tagline: 'The self is constituted through relationships, not despite them.',
    description:
        'Gilligan challenged the dominant philosophical tradition of abstract moral principles. '
        'She argued that morality is not primarily about rules — '
        'it is about relationships, context, and responsiveness to specific people in specific situations. '
        'Who you are is not separable from who you are in relation to others. '
        'Connection is not weakness. It is the architecture of a human life.',
    challenge:
        'Think of the relationship that most defines who you are. '
        'Have you been showing up fully? Make one specific investment in it today.',
    weeklyChallenge:
        'Reach out to three people who matter to you — not to ask anything, '
        'but simply to say so. Explicitly. In writing.',
    category: PhilosophyCategory.relations,
  ),

  PhilosophyMeta(
    id: 'wittgenstein',
    name: "Wittgenstein's Language Games",
    icon: '🗣️',
    thinker: 'Ludwig Wittgenstein',
    era: 'Vienna / Cambridge · 1889–1951 CE',
    tagline: 'The limits of my language are the limits of my world.',
    description:
        'Wittgenstein argued that most philosophical problems are not problems to be solved '
        'but confusions to be dissolved — they arise from misuse of language. '
        'The words we use shape what we can think and what we can see. '
        'Expanding your vocabulary is not pedantry. '
        'It is expanding the territory of the possible.',
    challenge:
        'Find a feeling or situation you struggle to articulate. '
        'Spend 10 minutes finding the right words for it. '
        'Notice how naming it changes your relationship to it.',
    weeklyChallenge:
        'Learn five words this week that name things you experience but have never been able to say precisely. '
        'Use each one in conversation.',
    category: PhilosophyCategory.relations,
  ),
];