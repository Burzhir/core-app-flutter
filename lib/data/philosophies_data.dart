// ═══════════════════════════════════════════════════════════════════════════════
// Philosophy catalogue — full deep-dive content for every entry.
// Each philosophy has: description, overview (3-4 paragraphs),
// historicalContext (2-3 paragraphs), keyTeachings (4-6 with full body),
// modernApplication (2 paragraphs), quotes (4-6), keyWorks.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';

enum PhilosophyCategory {
  discipline,
  creativity,
  mindfulness,
  reason,
  existential,
  relations,
}

class CoreTeaching {
  final String title;
  final String body;
  const CoreTeaching({required this.title, required this.body});
}

class PhilosophyQuote {
  final String text;
  final String source;
  const PhilosophyQuote({required this.text, required this.source});
}

class PhilosophyMeta {
  final String id;
  final String name;
  final String icon;
  final String thinker;
  final String era;
  final String tagline;

  // Card / diagnose result (short)
  final String description;
  final String challenge;
  final String weeklyChallenge;
  final PhilosophyCategory category;

  // Deep-dive content
  final String overview;
  final String historicalContext;
  final List<CoreTeaching> keyTeachings;
  final String modernApplication;
  final List<PhilosophyQuote> quotes;
  final List<String> keyWorks;

  // UI gradient – two‑color list used for cards and detail sheets
  final List<Color> gradientColors;

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
    required this.overview,
    required this.historicalContext,
    required this.keyTeachings,
    required this.modernApplication,
    required this.quotes,
    required this.keyWorks,
    required this.gradientColors,
  });

  // Convenience getter to combine overview + historical context for older widgets
  String get deepDive => '$overview\n\n$historicalContext';
}

// ─────────────────────────────────────────────────────────────────────────────

const List<PhilosophyMeta> kPhilosophies = [

  // ══════════════════════════════════════════════════════════════════════════
  // DISCIPLINE
  // ══════════════════════════════════════════════════════════════════════════

  PhilosophyMeta(
    id: 'marcus_aurelius',
    name: 'The Meditations',
    icon: '🏛️',
    thinker: 'Marcus Aurelius',
    era: 'Roman Empire · 161–180 CE',
    tagline: 'You have power over your mind, not events.',
    description:
        'A private journal written by the most powerful man on earth, reminding himself daily '
        'of what he could and could not control. Philosophy not performed — philosophy as survival.',
    challenge:
        'Write three sentences: what happened, what you cannot control about it, '
        'and the one action available to you right now. Apply this to your biggest current problem.',
    weeklyChallenge:
        'Each morning this week write one gratitude and one anticipated obstacle. '
        'Each night, record what actually happened. Compare on day 7.',
    category: PhilosophyCategory.discipline,
    overview:
        'Marcus Aurelius was not supposed to be a philosopher. He was the Emperor of Rome — '
        'commanding armies, adjudicating disputes, governing sixty million people across three continents. '
        'And yet every morning, before the Senate, before the supplicants, before the bureaucracy of '
        'the ancient world\'s most complex administration, he sat alone and wrote to himself.\n\n'
        'The Meditations were never meant to be published. They are a private journal — urgent, '
        'sometimes desperate, always honest — of a man using philosophy as a daily tool for staying '
        'human under pressure that would have crushed anyone without a practice. He wrote the same '
        'lessons to himself repeatedly, not because he forgot them, but because wisdom requires '
        'constant re-application. You do not learn Stoicism once. You practice it every morning '
        'before the world reasserts its chaos.\n\n'
        'What makes the Meditations extraordinary is their vulnerability. This is not a treatise '
        'written for posterity. It is a man telling himself, again and again: control what you can. '
        'Accept what you cannot. Do the work in front of you. He failed at this repeatedly — '
        'his reign was marked by wars he did not want, a plague he could not stop, and a son, '
        'Commodus, who would prove to be one of Rome\'s worst emperors. He wrote it down anyway. '
        'That is the entire lesson.\n\n'
        'More than 1,800 years after his death, the Meditations remain perhaps the most practically '
        'useful philosophical text ever written — not because Marcus solved anything, but because '
        'he showed, in real time, what it looks like to try to live well under impossible conditions. '
        'Every generation that has faced upheaval — soldiers, statesmen, athletes, prisoners — '
        'has reached for this book. It has never stopped being relevant because human nature '
        'has never stopped being human.',
    historicalContext:
        'Marcus Aurelius ruled the Roman Empire from 161 to 180 CE, a period historians call '
        'the Pax Romana\'s final chapter. He inherited an empire at its geographic and cultural '
        'peak and spent his entire reign defending it — against Germanic tribes in the north, '
        'the Parthian Empire in the east, and a devastating plague (the Antonine Plague, '
        'likely smallpox) that killed an estimated five million people across the empire. '
        'He campaigned for years on the Danube frontier, writing the Meditations in military '
        'tents between battles, in the brief hours between command and sleep.\n\n'
        'He had been trained in Stoic philosophy since adolescence, studying under the rhetorician '
        'Fronto and the philosopher Rusticus, who introduced him to Epictetus. Stoicism gave him '
        'something no wealth or power could: a framework for deciding what actually mattered. '
        'Edward Gibbon, writing in the 18th century, called the period of Marcus Aurelius\'s reign '
        'the time in which "the condition of the human race was most happy and prosperous." '
        'He was the last of the "Five Good Emperors." After him, Rome began its long decline — '
        'a decline his own philosophical work had quietly predicted, since Marcus had '
        'no illusions about the permanence of power.',
    keyTeachings: [
      CoreTeaching(
        title: 'The Dichotomy of Control',
        body:
            'The foundational Stoic insight that Marcus returned to daily: there are things in '
            'your power — your judgments, your responses, your effort, your character — and things '
            'not in your power — everything external. Weather, other people\'s opinions, illness, '
            'the economy, death itself. The entire Stoic project is learning to invest everything '
            'in the former and nothing in the latter. Not less — nothing. Marcus noticed that almost '
            'all human suffering came from treating uncontrollable things as if they were controllable, '
            'and controllable things as if they were fixed. The practice is simply to notice '
            'which side of the line you are operating on, and redirect accordingly.',
      ),
      CoreTeaching(
        title: 'The Obstacle Is the Way',
        body:
            '"The impediment to action advances action. What stands in the way becomes the way." '
            'This single line from the Meditations became the operating philosophy of a generation '
            'of athletes, executives, and artists. Marcus\'s insight cuts deeper than motivational '
            'reframing: every obstacle contains within it the very response needed to overcome it. '
            'A blocked road forces creativity. A failed project reveals what success concealed. '
            'An illness clarifies what health obscured. This is not optimism — it is a different '
            'model of reality, one in which resistance and growth are the same phenomenon '
            'viewed from different angles.',
      ),
      CoreTeaching(
        title: 'The View from Above',
        body:
            'Marcus frequently asked himself to mentally zoom out — to see the full sweep of human '
            'history, the insignificance of individual suffering against geological time, the sameness '
            'of every generation\'s anxieties. He imagined looking down at the whole of the Roman Empire '
            'from above, watching the tiny drama of ambition and jealousy from a distance that revealed '
            'its actual scale. Not to diminish what he felt — but to dissolve the urgency that clouded '
            'his judgment. The philosopher-emperor who could see his own palace as a small structure '
            'in a vast landscape could also see his own problems in accurate proportion.',
      ),
      CoreTeaching(
        title: 'Memento Mori — Remember You Will Die',
        body:
            'Marcus returned to mortality constantly — not as morbidity but as clarification. '
            '"Alexander the Great and his stable boy are both dead." '
            '"Augustus, Hadrian, Antoninus are gone. So will I be." '
            'Remembering that everything ends — including you, your achievements, your reputation, '
            'your civilization — strips away the trivial and leaves only the essential. '
            'It was not a counsel of despair. It was the ultimate prioritization tool. '
            'The person who lives with the awareness of death cannot easily be distracted '
            'by what does not matter. They know, viscerally, that the time available is finite '
            'and that wasting it on pretense is a particularly painful form of self-betrayal.',
      ),
      CoreTeaching(
        title: 'Service as the Purpose of Power',
        body:
            'Marcus believed the rational soul was designed for service — that a human being '
            'acting purely for themselves was as absurd as a hand that refused to function '
            'as part of a body. Every privilege carried an obligation in precise proportion. '
            'He governed an empire of sixty million people from this belief, writing privately: '
            '"What injures the hive, injures the bee." He was not performing virtue for an audience. '
            'The journal was never meant to be read. His service ethic was entirely internal — '
            'which is the only kind that actually produces service.',
      ),
    ],
    modernApplication:
        'The Stoic practice Marcus demonstrated is directly applicable to any high-stakes environment '
        'in a way that ancient philosophy rarely is. A surgeon cannot control whether a patient '
        'develops complications. A founder cannot control whether the market receives their product. '
        'A parent cannot control the choices their adult child makes. What all three can control is '
        'their preparation, their response, the quality of their attention, and the discipline of '
        'their judgment under pressure. Marcus would have recognized the cognitive trap of spending '
        'energy on the former while neglecting the latter — it was the same trap he wrote about '
        'every morning for nineteen years.\n\n'
        'The journaling practice is his most exportable tool and the one most backed by modern '
        'research. Writing "what happened, what was in my control, and what I did with it" creates '
        'a feedback loop between action and reflection that most people never build. It is not '
        'therapy — it is calibration. You are adjusting your judgment against reality, '
        'every day, until the gap between what you think will help and what actually does closes '
        'to something workable. Marcus did this for nineteen years. '
        'That discipline is not separate from his effectiveness as a ruler. It is the explanation for it.',
    quotes: [
      PhilosophyQuote(
        text: 'You have power over your mind, not outside events. Realize this, and you will find strength.',
        source: 'Meditations',
      ),
      PhilosophyQuote(
        text: 'The impediment to action advances action. What stands in the way becomes the way.',
        source: 'Meditations, Book V',
      ),
      PhilosophyQuote(
        text: 'Waste no more time arguing what a good man should be. Be one.',
        source: 'Meditations, Book X',
      ),
      PhilosophyQuote(
        text: 'The best revenge is not to be like your enemy.',
        source: 'Meditations, Book VI',
      ),
      PhilosophyQuote(
        text: 'Accept the things to which fate binds you, and love the people with whom fate brings you together.',
        source: 'Meditations, Book VI',
      ),
      PhilosophyQuote(
        text: 'Very little is needed to make a happy life; it is all within yourself, in your way of thinking.',
        source: 'Meditations',
      ),
    ],
    keyWorks: [
      'Meditations — Marcus Aurelius (c. 170–180 CE)',
      'The Enchiridion — Epictetus (c. 125 CE)',
      'Letters from a Stoic — Seneca (c. 65 CE)',
      'The Obstacle Is the Way — Ryan Holiday (2014)',
      'How to Think Like a Roman Emperor — Donald Robertson (2019)',
    ],
    gradientColors: [Color(0xFFD4AF37), Color(0xFF8B7500)],
  ),

  // ──────────────────────────────────────────────────────────────────────────

  PhilosophyMeta(
    id: 'epictetus',
    name: 'The Enchiridion',
    icon: '🔒',
    thinker: 'Epictetus',
    era: 'Roman Empire · 50–135 CE',
    tagline: 'No one can harm you without your permission.',
    description:
        'A former slave who became the most quoted philosopher of his age, Epictetus built '
        'an entire philosophy from one indestructible insight: the only thing that can never '
        'be taken from you is your response to what happens.',
    challenge:
        'Write your three biggest current worries. Mark each: "in my control" or "not in my control." '
        'For anything in the second column — release it completely today.',
    weeklyChallenge:
        'For 7 days, whenever you feel upset or anxious, stop and ask: "Is this within my control?" '
        'Direct all energy exclusively toward what is.',
    category: PhilosophyCategory.discipline,
    overview:
        'Epictetus was born into slavery in Hierapolis, a city in what is now western Turkey. '
        'His name literally means "acquired" — it is not a name but a designation of property. '
        'His master, Epaphroditus, was a freedman of Emperor Nero. At some point, Epictetus was '
        'freed. He studied under the Stoic philosopher Musonius Rufus and went on to establish '
        'a school in Nicopolis, Greece, that attracted students from across the Roman Empire — '
        'including, through his written lectures, the man who would become its emperor.\n\n'
        'Epictetus never wrote anything himself. What we have are lecture notes taken by '
        'his student Arrian, compiled into the Discourses and the Enchiridion (Handbook). '
        'The Enchiridion is extraordinary in its compression: 53 short chapters that between them '
        'contain the complete apparatus needed to live without unnecessary suffering. '
        'It has been carried by soldiers, prisoners, CEOs, and athletes for two thousand years '
        'because its central insight is indestructible — it works in every context because '
        'it is about the one constant in every context: the responding self.\n\n'
        'What makes Epictetus different from most philosophers is that his philosophy was forged '
        'under actual constraint. He did not theorize about suffering from an armchair. '
        'He built his framework in conditions where it was the only available protection. '
        'This gives his work an urgency and a physicality that academic philosophy rarely achieves. '
        'When Epictetus writes about the limits of what others can take from you, he is not making '
        'an abstract argument. He is reporting from lived experience.\n\n'
        'The story told about him — that his master once broke his leg by twisting it, '
        'and Epictetus calmly said "you will break it" before it happened, and then, when it broke, '
        'said "did I not tell you?" — may be apocryphal. But it captures something true about '
        'the man\'s philosophy: equanimity was not a performance for him. It was an earned position.',
    historicalContext:
        'Epictetus lived through one of the most volatile periods of Roman history — the reigns '
        'of Nero, Vespasian, Titus, Domitian, Nerva, and Trajan. He witnessed the Great Fire of Rome, '
        'the Year of the Four Emperors, the destruction of the Second Temple in Jerusalem, '
        'and Domitian\'s expulsion of philosophers from Rome in 89 CE, which sent Epictetus '
        'from the capital to Nicopolis on the western coast of Greece.\n\n'
        'He was part of the third generation of Stoic philosophy — inheriting a tradition '
        'begun by Zeno of Citium in Athens around 300 BCE. But where Zeno was a merchant '
        'writing for the educated elite, and Chrysippus was an academic constructing a philosophical '
        'system, Epictetus was a slave teaching from the margins of Roman society. '
        'His version of Stoicism has a rawness and a practical urgency that the earlier thinkers — '
        'writing from positions of relative safety — never quite achieve. '
        'He was philosophy\'s only major thinker who had literally nothing to lose.',
    keyTeachings: [
      CoreTeaching(
        title: 'The Dichotomy of Control',
        body:
            'The Enchiridion opens with what Epictetus considered the master key: "Some things are '
            'in our control and others not. Things in our control are opinion, pursuit, desire, '
            'aversion, and whatever are our own actions. Things not in our control are body, '
            'reputation, command, and whatever are not our own actions." Everything that follows '
            'in Stoic practice is an application of this distinction. It sounds simple in theory. '
            'It takes sustained effort to live, because the mind constantly wants to invest in '
            'outcomes it cannot control — approval, results, health, safety — '
            'as if wanting them hard enough will secure them.',
      ),
      CoreTeaching(
        title: 'The Inner Citadel',
        body:
            'Epictetus argued that the self has an inviolable inner fortress — a space of '
            'judgment and response that nothing external can enter without permission. '
            'A master can shackle the leg but not the will. Illness can weaken the body but not '
            'the decision about how to respond to it. Humiliation can damage the reputation '
            'but not the self-respect of the person who understands what self-respect actually is. '
            'This is not passive resignation — it is radical sovereignty. '
            'It locates freedom not in external circumstances, which are always contingent, '
            'but in the one domain where freedom is, in principle, always available: '
            'the choosing mind.',
      ),
      CoreTeaching(
        title: 'Impressions and Assent',
        body:
            'Every experience arrives first as an impression — a raw sense input combined with '
            'an automatic interpretation. Between the impression and the emotional response is '
            'a gap: the moment of assent, where you either endorse the impression or withhold '
            'your endorsement. This is where Stoic practice lives. The goal is not to suppress '
            'feelings — it is to train the gap to widen, so that the space for conscious choice '
            'expands. "It is not things that disturb us, but our judgments about things." '
            'This single line is the foundation of what we now call cognitive behavioral therapy.',
      ),
      CoreTeaching(
        title: 'Role Ethics — Play Every Part Well',
        body:
            'Epictetus taught that every person occupies multiple roles simultaneously: '
            'citizen, parent, friend, professional, neighbor. The question is never whether '
            'you like your role or chose it freely — it is whether you play it with excellence. '
            'A soldier does not choose every battle. An employee does not control every decision. '
            'A child does not choose their family. But the quality of their engagement with '
            'whatever they are given — the commitment and the craft they bring to it — '
            'that is always their choice. Play every role as if it were the only one that mattered, '
            'because in the moment you are playing it, it is.',
      ),
      CoreTeaching(
        title: 'Preferred Indifferents',
        body:
            'Epictetus acknowledged that some external things are genuinely preferable to others — '
            'health over illness, wealth over poverty, freedom over constraint. '
            'He called these "preferred indifferents": things worth pursuing, but not at the '
            'cost of virtue or peace of mind, because their absence should not constitute suffering. '
            'The subtle distinction is between wanting something and needing it. '
            'The Stoic pursues preferred indifferents actively while holding them lightly — '
            'willing to let go when circumstances require it, without resentment.',
      ),
    ],
    modernApplication:
        'The most direct modern application of Epictetus is in what psychologists now call '
        'cognitive restructuring — the practice of examining automatic thoughts and separating '
        'the event from the interpretation. Cognitive Behavioral Therapy is, in significant part, '
        'applied Epictetus. Albert Ellis, who founded Rational Emotive Behavior Therapy, '
        'explicitly credited the Stoics as his primary source. Viktor Frankl, who survived '
        'Auschwitz and founded Logotherapy, arrived at the same insight through different '
        'circumstances: between stimulus and response, there is always a space, '
        'and in that space lives all the freedom a human being will ever have.\n\n'
        'In practical terms: every time you feel distressed, Epictetus offers a three-step '
        'process. First, identify the impression — what you think happened and what it means. '
        'Second, test it against the dichotomy — is this within my control or not? '
        'Third, act on what is. This is not a cure for genuine grief or systemic injustice. '
        'Epictetus never claimed that. It is a method for not adding the suffering of '
        'futile resistance on top of the suffering that is already real and unavoidable.',
    quotes: [
      PhilosophyQuote(
        text: 'It is not things that disturb us, but our judgments about things.',
        source: 'Enchiridion, Chapter 5',
      ),
      PhilosophyQuote(
        text: 'Seek not that the things which happen should happen as you wish; wish the things which happen to be as they are.',
        source: 'Enchiridion, Chapter 8',
      ),
      PhilosophyQuote(
        text: 'No man is free who is not master of himself.',
        source: 'Discourses, Book II',
      ),
      PhilosophyQuote(
        text: 'Make the best use of what is in your power, and take the rest as it happens.',
        source: 'Enchiridion, Chapter 1',
      ),
      PhilosophyQuote(
        text: 'First say to yourself what you would be; then do what you have to do.',
        source: 'Discourses, Book III',
      ),
    ],
    keyWorks: [
      'Enchiridion — Epictetus (compiled by Arrian, c. 125 CE)',
      'Discourses — Epictetus (compiled by Arrian, c. 108 CE)',
      'A Guide to the Good Life — William Irvine (2008)',
      'The Daily Stoic — Ryan Holiday (2016)',
    ],
    gradientColors: [Color(0xFF4B6587), Color(0xFF1A2530)],
  ),

  // ──────────────────────────────────────────────────────────────────────────

  PhilosophyMeta(
    id: 'seneca',
    name: 'Letters on Time',
    icon: '⏳',
    thinker: 'Lucius Annaeus Seneca',
    era: 'Roman Empire · 4 BCE – 65 CE',
    tagline: 'It is not that we have little time — we waste much.',
    description:
        'Rome\'s greatest essayist wrote his most urgent letters knowing he was dying, '
        'watching powerful men squander entire lives on trivialities. '
        'His verdict has never been more relevant: time is the only non-renewable resource.',
    challenge:
        'Name the one project you\'ve been saying "soon" to. '
        'Do the first concrete step before anything else today. No warmup. No conditions.',
    weeklyChallenge:
        'Audit one hour of your average day. Track every minute explicitly. '
        'Identify the time being lost without a conscious decision and reclaim it.',
    category: PhilosophyCategory.discipline,
    overview:
        'Lucius Annaeus Seneca lived one of the most contradictory lives in philosophical history — '
        'and he knew it with painful clarity. He preached the simple life while accumulating '
        'extraordinary wealth. He wrote essays on anger while navigating the court of the most '
        'volatile emperor in Roman history. He counseled detachment from power while being one '
        'of the most politically connected men in the empire. His critics — ancient and modern — '
        'have never let him forget the gap between his teaching and his biography.\n\n'
        'But Seneca\'s genius was his self-awareness of that very gap. He was not writing from '
        'the position of the sage who had arrived — he was writing letters to Lucilius about '
        'the person he was still trying to become. "I am not yet wise," he wrote, "but I am '
        'making progress." This honesty gives his work a texture that the more systematic '
        'Stoics lack. You feel the space between the ideal and the lived reality, '
        'and you recognize it as your own. His philosophy is not aspirational in the '
        'sense of being distant — it is aspirational in the sense of being in motion.\n\n'
        'His 124 letters to Lucilius, written in the final years of his life — '
        'years when he knew Nero would eventually demand his death — are among the greatest '
        'sustained investigations of how to live that Western literature has produced. '
        'They cover everything from the proper use of time to the nature of friendship, '
        'from the fear of death to the experience of a crowd, from retirement to ambition. '
        'They are also, unusually for ancient philosophy, ferociously readable — '
        'Seneca is one of the few ancient thinkers who can make you laugh one paragraph '
        'and stop cold the next.\n\n'
        'In 65 CE, Nero accused him of involvement in the Pisonian conspiracy against the emperor. '
        'Whether he was actually involved remains debated. What is not debated is his response: '
        'he opened his veins, dictated final letters to his friends, and died with the '
        'equanimity he had spent forty years writing about. '
        'Tacitus, who chronicled the death, noted that he showed more composure than his guards.',
    historicalContext:
        'Seneca was born in Córdoba, Spain, into a wealthy equestrian family of literary distinction. '
        'His father, Seneca the Elder, was a famous rhetorician whose work survives. '
        'He was educated in Rome, trained under the Stoic Attalus and the Pythagorean Sotion, '
        'and attracted the dangerous attention of both Caligula, who wanted him dead '
        '(reportedly because his oratory was too impressive in the Senate), '
        'and the Emperor Claudius, under whom he was exiled to Corsica for eight years '
        'on a charge almost certainly fabricated for political convenience.\n\n'
        'He returned to become the tutor and then the chief advisor of the young Nero, '
        'and for the first five years of Nero\'s reign, Seneca and the general Burrus '
        'effectively governed the Roman Empire — and governed it well, by most accounts. '
        'As Nero\'s character darkened into paranoia and cruelty, Seneca withdrew, '
        'asking to be released from his position and to return his accumulated wealth. '
        'Nero refused the wealth but allowed the withdrawal. Seneca spent his final years '
        'writing with an urgency that makes complete sense when you know he was racing '
        'against an emperor\'s patience.',
    keyTeachings: [
      CoreTeaching(
        title: 'Vita Brevis — Life Is Not Short, We Make It Short',
        body:
            'Seneca\'s most famous work opens with a claim that sounds like a complaint about '
            'mortality and reveals itself as an indictment of how we spend time. '
            'Life is not short, he argues — we are given enormous quantities of it. '
            'We simply squander it: on anxieties about futures that never arrive, '
            'on grief for pasts that cannot be changed, on performing for audiences '
            'whose approval we don\'t actually need, on chasing what others want '
            'rather than what we actually value. A person who lives deliberately and fully '
            'can accomplish more in forty years than a distracted person manages in ninety.',
      ),
      CoreTeaching(
        title: 'Dum Differtur Vita Transcurrit',
        body:
            '"While we are postponing, life speeds by." This is Seneca\'s most urgent observation, '
            'and he makes it at the very opening of his first letter to Lucilius: '
            '"Ita fac, mi Lucili: vindica te tibi." "Do this, my Lucilius: claim yourself for yourself." '
            'Not for your career. Not for your family\'s expectations. Not for your reputation. '
            'For yourself. The distinction between what we spend time on and what we would choose '
            'to spend time on if we were fully honest is, for most people, very large. '
            'Seneca\'s entire project is to close that gap before it is too late.',
      ),
      CoreTeaching(
        title: 'Praemeditatio Malorum',
        body:
            'Before a long journey, Seneca would deliberately imagine everything that could go wrong — '
            'storm, shipwreck, delay, loss of cargo — not to generate fear but to remove the shock '
            'of difficulty when it arrived. He called this praemeditatio malorum: '
            'the premeditation of evils. "Nothing happens to the wise man against his expectation." '
            'The goal is not pessimism. It is resilience: you cannot be broken by what '
            'you have already prepared for. Modern psychology calls this "negative visualization" '
            'and has confirmed its effectiveness in building emotional resilience.',
      ),
      CoreTeaching(
        title: 'True Friendship Requires the Whole Self',
        body:
            'Seneca wrote that the person who befriends you only for what you can provide '
            'is not a friend — they are a transaction conducted in friendship\'s clothing. '
            'Real friendship requires showing up with your whole self, including the parts '
            'that invite judgment. "Withdraw into yourself as much as you can with those '
            'who will make you better, and let in those who you yourself can make better." '
            'The quality of your inner circle determines, more than almost anything else, '
            'the quality of the thinking you do and the decisions you make.',
      ),
      CoreTeaching(
        title: 'Recede in te ipse — Retreat Into Yourself',
        body:
            'In a letter remarkable for its modernity, Seneca describes how crowds, noise, '
            'and sustained social performance drain the inner reserve. He had spent the day '
            'at the games and returned home feeling diminished — not from anything specific, '
            'but from the aggregate effect of a thousand small inputs from other people\'s '
            'anxiety, appetite, and noise. His prescription: regular, deliberate withdrawal '
            'into the self. Not hermitage — engagement with the world is necessary and right. '
            'But the self needs replenishment from its own resources, in silence, '
            'or it gradually stops being a self at all.',
      ),
    ],
    modernApplication:
        'Seneca\'s work is possibly the most directly applicable of all the ancient Stoics '
        'to contemporary life, because his primary targets — distraction, the performance '
        'of busyness, procrastination disguised as preparation, the substitution of '
        'other people\'s priorities for your own — are precisely the diseases of the digital age. '
        'He was writing about the Roman equivalent of the notification economy: '
        'the constant pull of other people\'s demands on a finite resource of time and attention. '
        'His diagnosis and his prescription are both as accurate now as they were in 65 CE.\n\n'
        'The praemeditatio practice — deliberately imagining what could go wrong before it does — '
        'has been independently validated by behavioral psychology as "implementation intentions" '
        'and by business practice as "pre-mortem analysis." '
        'Researchers have found that people who specifically plan for obstacles are '
        'significantly more likely to achieve their goals than those who simply intend to. '
        'Seneca\'s insight was the same: surprise is the enemy of equanimity, '
        'and the person who has already imagined losing something is not only less '
        'destroyed by the loss but, paradoxically, more able to appreciate it while it remains.',
    quotes: [
      PhilosophyQuote(
        text: 'It is not that we have a short time to live, but that we waste a great deal of it.',
        source: 'On the Shortness of Life',
      ),
      PhilosophyQuote(
        text: 'Begin at once to live, and count each separate day as a separate life.',
        source: 'Letters to Lucilius, Letter 1',
      ),
      PhilosophyQuote(
        text: 'Dum differtur vita transcurrit. While we are postponing, life speeds by.',
        source: 'Letters to Lucilius, Letter 1',
      ),
      PhilosophyQuote(
        text: 'Nusquam est qui ubique est. He who is everywhere is nowhere.',
        source: 'Letters to Lucilius, Letter 2',
      ),
      PhilosophyQuote(
        text: 'Omnia aliena sunt, tempus tantum nostrum est. Everything is alien, only time is truly ours.',
        source: 'Letters to Lucilius, Letter 1',
      ),
      PhilosophyQuote(
        text: 'He who does not know how to live well, should learn to die well.',
        source: 'Letters to Lucilius, Letter 77',
      ),
    ],
    keyWorks: [
      'Letters to Lucilius (Epistulae Morales) — Seneca (c. 65 CE)',
      'On the Shortness of Life — Seneca (c. 49 CE)',
      'On the Tranquility of Mind — Seneca',
      'On the Happy Life — Seneca',
    ],
    gradientColors: [Color(0xFFE67E22), Color(0xFF8B4513)],
  ),

  // ──────────────────────────────────────────────────────────────────────────

  PhilosophyMeta(
    id: 'nietzsche',
    name: 'Self-Overcoming',
    icon: '⚡',
    thinker: 'Friedrich Nietzsche',
    era: 'Prussia · 1844–1900 CE',
    tagline: 'Become who you are.',
    description:
        'Nietzsche demanded not that you outperform others but that you destroy the version '
        'of yourself that accepts less than your full potential — relentlessly, without comfort, '
        'without the approval of the crowd.',
    challenge:
        'Identify one belief about your limits that is actually a habit masquerading as a fact. '
        'Take one action against it today before you talk yourself out of it.',
    weeklyChallenge:
        'Write a personal manifesto — your own values, not inherited ones. '
        'What do you actually believe? What are you willing to live for? '
        'What would you do if you stopped caring what anyone thought?',
    category: PhilosophyCategory.discipline,
    overview:
        'Friedrich Nietzsche was nineteen when he found Schopenhauer\'s "The World as Will and '
        'Representation" in a Leipzig bookshop and read it for two weeks straight, sleeping four '
        'hours a night. The book told him the world was fundamentally irrational and that suffering '
        'was its primary content. His entire subsequent philosophical career was a sustained response '
        'to that discovery — sometimes an argument against it, sometimes a radical agreement, '
        'always an attempt to find a way to live that neither denied the darkness nor surrendered to it.\n\n'
        'By twenty-four he was a full professor of classical philology at Basel — the youngest '
        'ever appointed. He was friends with Wagner, which dazzled him; then he fell out with Wagner '
        'over the composer\'s anti-Semitism and grandiosity, which cost him his primary social world. '
        'By the time he produced his greatest works — Thus Spoke Zarathustra, Beyond Good and Evil, '
        'The Genealogy of Morality — he had been writing in isolation for years, in increasingly poor '
        'health, with recurring migraines that could incapacitate him for days.\n\n'
        'In January 1889, in Turin, he had a complete breakdown. The legend says he ran to a horse '
        'being beaten in the street, threw his arms around the animal to protect it, and collapsed. '
        'He never recovered. He spent the last eleven years of his life in a catatonic state, '
        'cared for first by his mother and then by his sister Elisabeth — who proceeded to '
        'systematically misrepresent his work, editing his unpublished notes to align with '
        'German nationalism and anti-Semitism. It took decades of serious scholarship to '
        'recover his actual philosophy from the ideological distortion she imposed on it.\n\n'
        'What they found was something very different from the myth. Nietzsche was not a '
        'philosopher of domination. He was a philosopher of becoming — of the relentless, '
        'painful, necessary work of growing beyond the self you were handed by accident of birth, '
        'culture, and convention.',
    historicalContext:
        'Nietzsche\'s philosophical development occurred against the backdrop of German unification '
        'under Bismarck, the Franco-Prussian War of 1870-71 (in which Nietzsche served briefly '
        'as a medical orderly and contracted serious illness), and the explosive growth of '
        'industrial capitalism across Europe. He watched his civilization move toward what he '
        'saw as a dangerous combination: material progress without philosophical foundation, '
        'democratic leveling without genuine equality, and the collapse of traditional religion '
        'without any new framework to replace the meaning it had provided.\n\n'
        '"God is dead" — his most famous and most consistently misread line — '
        'was not a celebration. It was a diagnosis of cultural crisis. '
        'The metaphysical framework that had given European life its coherence and its meaning '
        'for fifteen hundred years had collapsed under the pressure of science, criticism, '
        'and historical scholarship. Nietzsche\'s worry was not that people would stop '
        'believing in God — his worry was that they would stop believing in anything, '
        'and that the resulting nihilism would be the defining catastrophe of the coming century. '
        'His life\'s work was an attempt to sketch what a life of authentic, self-created meaning '
        'might look like in the aftermath of that collapse.',
    keyTeachings: [
      CoreTeaching(
        title: 'Will to Power — Self-Mastery, Not Domination',
        body:
            'The will to power is Nietzsche\'s most misappropriated concept and almost certainly '
            'the most misunderstood idea in the history of philosophy. It is not about dominating '
            'others. It is about self-overcoming — the drive to grow, to express one\'s capacities '
            'fully, to master oneself rather than being mastered by habit, fear, or convention. '
            'A tree\'s will to power is the drive toward light — not the desire to shade other trees. '
            'Properly understood, the will to power is the will to become '
            'what you are capable of becoming, regardless of how uncomfortable that process is.',
      ),
      CoreTeaching(
        title: 'Eternal Recurrence — The Ultimate Test',
        body:
            'Nietzsche\'s most demanding thought experiment: what if you had to live your life '
            'exactly as it has been — every joy, every humiliation, every mistake, every moment '
            'of grace — repeated identically and infinitely? Could you affirm that? '
            'Would you want to? The eternal recurrence is not a cosmological claim about how '
            'time works. It is a test of whether you are living a life you would genuinely choose. '
            'If the honest answer is no — if you would not choose this life to be repeated — '
            'that is the most urgent information available. What needs to change?',
      ),
      CoreTeaching(
        title: 'Amor Fati — Love of Fate',
        body:
            '"My formula for human greatness is amor fati: that one wants nothing to be different, '
            'not forward, not backward, not in all eternity. Not merely bear what is necessary, '
            'still less conceal it — but love it." This is Nietzsche at his most demanding. '
            'Not acceptance of fate as a consolation prize — the grudging making-peace '
            'with what cannot be changed. But the active, genuine affirmation of everything '
            'that has shaped you: the suffering, the failures, the accidents, '
            'the losses that made you exactly who you are. Including those.',
      ),
      CoreTeaching(
        title: 'Master and Slave Morality',
        body:
            'In the Genealogy of Morality, Nietzsche traced two fundamentally different ethical '
            'frameworks that had been in conflict since antiquity. Master morality — '
            'the ethics of the noble, the strong, the self-affirming — defines good and bad '
            'from a position of power and pride. Slave morality — the ethics of the resentful, '
            'the oppressed, the reactive — defines good and evil from a position of weakness, '
            'recasting the virtues of the powerful as vices and the limitations of the powerless '
            'as virtues. His point was not that one group was inherently better — it was that '
            'modern culture had unconsciously adopted slave morality while pretending to hold master values, '
            'and that the resulting dishonesty was corroding the possibility of genuine excellence.',
      ),
      CoreTeaching(
        title: 'The Übermensch as Aspiration',
        body:
            'The Übermensch (Over-man, Superman) is not a racial category — it is a philosophical '
            'direction. It is what Zarathustra teaches: the person who has moved beyond inherited '
            'values, who creates their own standards, who affirms life even in the face of '
            'its suffering and transience. Nietzsche offered examples in his work — Goethe, '
            'Napoleon, Caesar — not as perfect specimens but as people defined by the intensity '
            'and authenticity of their self-expression rather than by power over others. '
            'The Übermensch is a direction, not a destination.',
      ),
    ],
    modernApplication:
        'Nietzsche\'s most practical gift to modern life is the question he forces on every value '
        'you hold: "Did you choose this, or was it chosen for you?" Most people inherit their '
        'ethical frameworks, their definitions of success, their ideas of what constitutes '
        'a good life — from family, culture, religion, education, and now social media — '
        'without ever subjecting any of it to honest examination. Nietzsche\'s demand is radical '
        'but executable: examine everything. Keep only what survives your honest scrutiny. '
        'Build your life on that foundation. Not on convention. Not on approval. '
        'On what you have actually chosen.\n\n'
        'The eternal recurrence thought experiment translates directly into a decision-making tool. '
        'Before any major life choice, ask: if I lived this consequence forever — '
        'this career, this relationship, this version of who I am — could I say yes to it? '
        'Not comfortably. Genuinely. The discomfort in the honest answer to that question '
        'is the most useful navigational signal available. '
        'Nietzsche did not offer a map. He offered a compass.',
    quotes: [
      PhilosophyQuote(
        text: 'Become who you are.',
        source: 'Thus Spoke Zarathustra',
      ),
      PhilosophyQuote(
        text: 'That which does not kill us, makes us stronger.',
        source: 'Twilight of the Idols',
      ),
      PhilosophyQuote(
        text: 'He who has a why to live for can bear almost any how.',
        source: 'Twilight of the Idols',
      ),
      PhilosophyQuote(
        text: 'You must have chaos within you to give birth to a dancing star.',
        source: 'Thus Spoke Zarathustra, Prologue',
      ),
      PhilosophyQuote(
        text: 'The higher we soar, the smaller we appear to those who cannot fly.',
        source: 'Thus Spoke Zarathustra',
      ),
      PhilosophyQuote(
        text: 'In individuals, insanity is rare; but in groups, parties, nations, and epochs, it is the rule.',
        source: 'Beyond Good and Evil',
      ),
    ],
    keyWorks: [
      'Thus Spoke Zarathustra — Nietzsche (1883–1885)',
      'Beyond Good and Evil — Nietzsche (1886)',
      'On the Genealogy of Morality — Nietzsche (1887)',
      'Twilight of the Idols — Nietzsche (1888)',
      'Nietzsche: Philosopher, Psychologist, Antichrist — Walter Kaufmann (1950)',
    ],
    gradientColors: [Color(0xFF8B0000), Color(0xFF4B0082)],
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // CREATIVITY
  // ══════════════════════════════════════════════════════════════════════════

  PhilosophyMeta(
    id: 'davinci',
    name: "Da Vinci's Curiosity",
    icon: '🎨',
    thinker: 'Leonardo da Vinci',
    era: 'Florence · 1452–1519 CE',
    tagline: 'Study the science of art. Study the art of science.',
    description:
        'Leonardo left 7,200 pages of notes spanning painting, anatomy, geology, music, '
        'and engineering — never once treating them as separate subjects. '
        'His method was insatiable curiosity without premature judgment.',
    challenge:
        'Ask one question today with no immediate practical use. '
        'Follow your curiosity wherever it leads for 20 minutes, without guilt or justification.',
    weeklyChallenge:
        'Start a curiosity journal. Each day this week, write one thing you noticed '
        'and one question it raised. Ask without needing to answer.',
    category: PhilosophyCategory.creativity,
    overview:
        'Leonardo da Vinci was born illegitimate — the son of a Florentine notary and a peasant '
        'woman — in a farmhouse in Anchiano on April 15, 1452. Illegitimacy barred him from '
        'the family professions and from university. He became an apprentice in the workshop '
        'of the sculptor and painter Andrea del Verrocchio at fourteen. '
        'Within a few years, his work was so superior to his master\'s that Verrocchio, '
        'according to legend, put down his brushes and never painted again.\n\n'
        'What distinguished Leonardo from every other genius of the Renaissance was not talent — '
        'Florence was overflowing with talent. It was method. He approached every subject with '
        'a scientist\'s rigor and an artist\'s sensitivity, refusing the division between disciplines '
        'that we now take for granted. He dissected more than thirty human corpses to understand '
        'anatomy well enough to paint muscle. He studied fluid dynamics to understand '
        'how to render water convincingly. He designed flying machines because understanding '
        'flight required understanding the mechanics of air, which informed his understanding '
        'of clouds, which informed his painting of landscapes. Everything connected to everything.\n\n'
        'He left most of his major projects unfinished — the notebooks are full of designs '
        'and investigations that were never executed. Historians once read this as a character flaw. '
        'Walter Isaacson\'s biography makes the opposite argument: the notebooks were the work. '
        'The paintings were the byproduct. Leonardo was not primarily a painter who also happened '
        'to think about engineering. He was a man in a sustained, passionate love affair '
        'with the nature of things, and everything he produced — finished or not — '
        'was a record of that relationship.\n\n'
        'He died at sixty-seven in the Château du Clos Lucé in France, as the guest of King Francis I, '
        'who reportedly held him as he died. The king later said there had never been another '
        'man who knew as much as Leonardo — not just of painting, but of philosophy and science. '
        'He is still right.',
    historicalContext:
        'Leonardo\'s life coincided with the Italian Renaissance at its absolute peak. '
        'He was born the year Gutenberg completed his printing press, grew up in Florence '
        'during the golden age of Medici patronage, painted in Milan under Ludovico Sforza, '
        'briefly served the terrifying Cesare Borgia as a military engineer, '
        'worked in Venice and Rome, and died in France. His life arc traced the '
        'entire geography of Renaissance power.\n\n'
        'Florence in the fifteenth century was one of the most intellectually stimulating '
        'environments in human history — a city-state where banking wealth funded artistic '
        'patronage on an unprecedented scale, where Neoplatonism was merging with classical '
        'scholarship, and where the conviction that human genius could master any domain '
        'was being tested in real time by Brunelleschi, Michelangelo, Botticelli, '
        'and Leonardo himself. It was an ecosystem that rewarded exactly the kind of '
        'cross-disciplinary, curiosity-driven thinking that Leonardo epitomized.',
    keyTeachings: [
      CoreTeaching(
        title: 'Curiosità — Insatiable, Undirected Curiosity',
        body:
            'Leonardo filled pages on questions with no practical application whatsoever: '
            'Why is the sky blue? How does a woodpecker use its tongue? What is the nature '
            'of a candle flame? Why do we yawn? His curiosity was not selective or strategic — '
            'it was indiscriminate. He followed it wherever it led, without requiring it '
            'to justify itself in advance. This is the discipline his method requires: '
            'protecting curiosity from the demand that it be immediately useful, '
            'because the connections between apparently unrelated questions '
            'are precisely where original ideas live.',
      ),
      CoreTeaching(
        title: 'Dimostrazione — Knowledge Through Direct Experience',
        body:
            'Leonardo trusted direct observation over received authority. Medieval scholarship '
            'cited Galen on anatomy without dissecting a body. Leonardo dissected dozens '
            'and found Galen wrong in multiple significant ways. He trusted what he saw '
            'over what he was told by experts, authorities, and tradition. '
            'This was not arrogance — it was a methodological commitment '
            'to the primacy of experience as the ultimate test of any claim. '
            '"Experience is the mother of all knowledge. Wisdom is the daughter of experience."',
      ),
      CoreTeaching(
        title: 'Sfumato — Comfort with Uncertainty',
        body:
            'Sfumato is a painting technique of soft, smoky edges that gives the Mona Lisa '
            'its haunting ambiguity — her expression shifts depending on where you look. '
            'As a philosophical practice, sfumato meant Leonardo\'s ability to hold '
            'multiple contradictory possibilities simultaneously without forcing premature resolution. '
            'He could work on a problem for years without needing to conclude it. '
            'He could sit with paradox. Premature certainty was, for him, '
            'the enemy of genuine discovery — it closed doors before all the rooms had been explored.',
      ),
      CoreTeaching(
        title: 'Arte e Scienza — The Unity of All Knowing',
        body:
            'The division between science and art is a modern invention that Leonardo would not '
            'have recognized. For him, anatomy served painting. Painting required fluid dynamics. '
            'Fluid dynamics illuminated geology. Geology raised questions about cosmology. '
            'Cartography required mathematics. Mathematics connected to music. '
            'The notebook entries jump between subjects because in Leonardo\'s mental architecture '
            'there were no subjects — only the continuous investigation of a single nature, '
            'which could be approached from any angle.',
      ),
      CoreTeaching(
        title: 'The Value of the Incomplete',
        body:
            'Leonardo never finished the Adoration of the Magi, the Battle of Anghiari, '
            'or the Sforza Horse. He returned obsessively to the Mona Lisa for fifteen years. '
            'What looks like failure or perfectionism was actually something different: '
            'a relationship with completion in which the object was less important '
            'than the investigation it enabled. The work continued as long as there was '
            'something to learn from it. When it could no longer teach, it was set aside — '
            'not abandoned, but graduated from.',
      ),
    ],
    modernApplication:
        'The practical lesson of Leonardo\'s method is counterintuitive in an era of '
        'extreme specialization: the deepest expertise in any field may require deliberate '
        'excursions outside it. The best UX designers study cognitive psychology. '
        'The best surgeons study anatomy through drawing. The best writers study history. '
        'The best founders study biology. Cross-domain curiosity is not distraction — '
        'it is the mechanism by which genuinely original ideas are generated, '
        'because original ideas almost always involve applying the logic of one domain '
        'to the problems of another. This is precisely what Leonardo did every day of his life.\n\n'
        'His notebook practice — writing down everything you notice, every question that occurs '
        'to you, without judging its utility or coherence — is the closest thing to a '
        'universal creative practice that exists. It is not journaling about feelings. '
        'It is journaling about the world. It creates the habit of observation, '
        'which is the prerequisite of all good work in any field. '
        'The person who notices things is the person who has things to say. '
        'Leonardo noticed more things than anyone in recorded history. '
        'The notebook was both the method and the proof.',
    quotes: [
      PhilosophyQuote(
        text: 'Learning never exhausts the mind.',
        source: 'Notebooks',
      ),
      PhilosophyQuote(
        text: 'The noblest pleasure is the joy of understanding.',
        source: 'Notebooks',
      ),
      PhilosophyQuote(
        text: 'Simplicity is the ultimate sophistication.',
        source: 'Notebooks',
      ),
      PhilosophyQuote(
        text: 'Study without desire spoils the memory, and it retains nothing that it takes in.',
        source: 'Notebooks',
      ),
      PhilosophyQuote(
        text: 'It had long since come to my attention that people of accomplishment rarely sat back and let things happen to them. They went out and happened to things.',
        source: 'Attributed',
      ),
    ],
    keyWorks: [
      'Leonardo da Vinci — Walter Isaacson (2017)',
      'The Notebooks of Leonardo da Vinci — edited by Irma Richter',
      'How to Think Like Leonardo da Vinci — Michael Gelb (1998)',
      'Leonardo\'s Mountain of Clams and the Diet of Worms — Stephen Jay Gould',
    ],
    gradientColors: [Color(0xFF6C5CE7), Color(0xFF1B1464)],
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // MINDFULNESS
  // ══════════════════════════════════════════════════════════════════════════

  PhilosophyMeta(
    id: 'frankl',
    name: "Man's Search for Meaning",
    icon: '🕯️',
    thinker: 'Viktor Frankl',
    era: 'Vienna · 1905–1997 CE',
    tagline: 'Between stimulus and response there is a space. In that space is our power.',
    description:
        'Frankl survived four Nazi concentration camps and emerged to write the most significant '
        'work of existential psychology in the 20th century. His finding: people can endure '
        'almost anything if they have a reason.',
    challenge:
        'Write one sentence: what makes your current difficulty worth enduring? '
        'If you cannot find an answer, that is your actual problem to solve.',
    weeklyChallenge:
        'Write a meaning statement — not goals, not values, but one full paragraph '
        'about why your specific life matters in a way only you can fill.',
    category: PhilosophyCategory.mindfulness,
    overview:
        'Viktor Frankl entered Auschwitz in September 1942. He carried with him the manuscript '
        'of his first major work, hidden in his coat lining. It was confiscated at the gate '
        'and destroyed. What he retained — and what he spent the next three years in the camps '
        'systematically testing against the most extreme conditions imaginable — '
        'was the theoretical framework it contained.\n\n'
        'His central hypothesis, developed before the war, was that the primary human drive '
        'was not the will to pleasure (Freud) or the will to power (Adler) but the will to meaning. '
        'The camps gave him the most brutal possible test of this hypothesis. '
        'His observation: the prisoners who survived longest were not necessarily '
        'the physically strongest or the politically connected. '
        'They were the ones who retained a sense of purpose — something to live toward, '
        'someone to return to, something that only they could still accomplish. '
        'Those who lost their "why" deteriorated rapidly, regardless of physical condition.\n\n'
        '"Man\'s Search for Meaning" was written in nine days after his liberation in 1945, '
        'reconstructed from notes and memory. Frankl had intended it as an anonymous case study '
        'for Logotherapy — his therapeutic system. His publisher suggested removing his name '
        'from the cover entirely, predicting it would sell better as an anonymous account. '
        'Frankl refused. The book has since sold sixteen million copies in twenty-four languages '
        'and has been cited by the Library of Congress as one of the ten most influential '
        'books in American history.\n\n'
        'Frankl himself lived to ninety-two, practicing psychotherapy, teaching, and lecturing '
        'on six continents. He obtained his pilot\'s license at the age of sixty-seven. '
        'He was, by any measure, a man who had found a reason.',
    historicalContext:
        'Frankl\'s Vienna was the Vienna of Freud, Adler, and a flourishing secular Jewish '
        'intellectual culture that was producing some of the most consequential ideas of '
        'the twentieth century. He had corresponded with Freud as a student — Freud published '
        'one of his early papers — and had developed his own divergent theory of human motivation '
        'before the war consumed everything.\n\n'
        'The Holocaust destroyed his world entirely. His wife Tilly, his mother, and his brother '
        'all died in the camps. His father had died earlier in Theresienstadt. '
        'He was the sole survivor of his immediate family. '
        'He returned to Vienna in 1945 and within a year had rebuilt his clinical practice, '
        'completed "Man\'s Search for Meaning," and resumed his academic career. '
        'The speed and completeness of that reconstruction was not, he later wrote, '
        'separate from his philosophy. It was its most direct demonstration.',
    keyTeachings: [
      CoreTeaching(
        title: 'The Will to Meaning',
        body:
            'Frankl argued that the fundamental human drive — the primary motivational force '
            'in human beings — is not pleasure, not power, but meaning. When human beings '
            'lose access to meaningful experience, meaningful work, or meaningful suffering, '
            'they fall into what Frankl called an "existential vacuum" — a pervasive '
            'sense of emptiness that manifests as depression, aggression, compulsive consumption, '
            'or the desperate search for sensation. The treatment for this vacuum is not '
            'more comfort or more achievement. It is the discovery or creation of meaning.',
      ),
      CoreTeaching(
        title: 'The Last Human Freedom',
        body:
            '"Everything can be taken from a man but one thing: the last of human freedoms — '
            'to choose one\'s attitude in any given set of circumstances, to choose one\'s own way." '
            'This was not theory for Frankl. It was empirical observation made in conditions '
            'designed to eliminate every other form of freedom. '
            'Guards could control his body, his food, his shelter, his labor, his movements. '
            'They could not control his response to what was done to him. '
            'That space — between what happens and how you respond — '
            'is the location of all genuine human freedom.',
      ),
      CoreTeaching(
        title: 'Meaning Through Suffering',
        body:
            'Frankl did not argue that suffering was good or that it should be sought. '
            'He argued that unavoidable suffering — suffering that genuinely cannot be escaped '
            'or reduced — can be given meaning, and that meaning transforms the experience of it. '
            '"If there is meaning in life at all, then there must be meaning in suffering." '
            'The prisoner who could understand their suffering as part of something larger — '
            'a witness to history, a test of human endurance, the price of love for those left behind — '
            'was not suffering less. They were suffering differently. '
            'The difference was survivable.',
      ),
      CoreTeaching(
        title: 'The Provisional Existence',
        body:
            'Frankl observed that prisoners who could not imagine a future — who had lost '
            'the sense of something specific to live toward — gave up most rapidly. '
            'He developed the practice of constructing what he called a provisional existence: '
            'imagining in concrete, specific detail what one would return to, accomplish, '
            'or become. A lecture to give. A manuscript to complete. A child to see again. '
            'The provisional existence — living "toward" something specific — '
            'was itself a source of the meaning that sustained the capacity for action.',
      ),
      CoreTeaching(
        title: 'Tragic Optimism',
        body:
            'Frankl\'s late work introduces the concept of tragic optimism: the ability to say '
            'yes to life despite its irreducible pain, guilt, and transience — '
            'what he called the tragic triad. '
            'Not naive optimism, which requires denying or ignoring these realities. '
            'Not pessimism, which surrenders to them. But tragic optimism: '
            'the acknowledgment of suffering combined with the deliberate choice '
            'to find or create meaning in spite of it, and sometimes through it.',
      ),
    ],
    modernApplication:
        'The concept that has traveled furthest from Frankl\'s work is the space between '
        'stimulus and response — which is now cited in everything from leadership literature '
        'to sports psychology to addiction recovery. Training that space to widen — '
        'building the capacity to pause between what happens and how you react — '
        'is the core project of both Logotherapy and modern mindfulness practice. '
        'It is the difference between being driven by circumstances and '
        'choosing your relationship to them.\n\n'
        'Research on resilience in extreme conditions — long-term prisoners, POWs, '
        'cancer patients, survivors of disasters — consistently shows that individuals '
        'with a clear sense of purpose outperform those without one by every available measure: '
        'psychological health, physical recovery, social functioning, and survival itself. '
        'This is not a soft finding. It is one of the most robustly replicated results '
        'in all of psychology. Frankl arrived at it in Auschwitz. '
        'The labs have confirmed it since.',
    quotes: [
      PhilosophyQuote(
        text: 'Between stimulus and response there is a space. In that space is our power to choose our response. In our response lies our growth and our freedom.',
        source: "Man's Search for Meaning",
      ),
      PhilosophyQuote(
        text: 'He who has a why to live for can bear almost any how.',
        source: "Man's Search for Meaning (quoting Nietzsche)",
      ),
      PhilosophyQuote(
        text: 'When we are no longer able to change a situation, we are challenged to change ourselves.',
        source: "Man's Search for Meaning",
      ),
      PhilosophyQuote(
        text: 'Everything can be taken from a man but one thing: the last of the human freedoms — to choose one\'s attitude in any given set of circumstances.',
        source: "Man's Search for Meaning",
      ),
      PhilosophyQuote(
        text: 'Life is never made unbearable by circumstances, but only by lack of meaning and purpose.',
        source: "Man's Search for Meaning",
      ),
    ],
    keyWorks: [
      "Man's Search for Meaning — Viktor Frankl (1946)",
      'The Will to Meaning — Viktor Frankl (1969)',
      "Man's Search for Ultimate Meaning — Viktor Frankl (1997)",
      'The Pursuit of Meaning — Alexander Batthyány (2016)',
    ],
    gradientColors: [Color(0xFFFFC048), Color(0xFFB8860B)],
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // REASON
  // ══════════════════════════════════════════════════════════════════════════

  PhilosophyMeta(
    id: 'socratic',
    name: 'The Socratic Method',
    icon: '❓',
    thinker: 'Socrates',
    era: 'Ancient Athens · 470–399 BCE',
    tagline: 'I know that I know nothing.',
    description:
        'Socrates was executed for asking too many questions. His method was not to teach '
        'but to expose the difference between actually knowing something '
        'and merely believing it with confidence.',
    challenge:
        'Take your most confident current belief and ask "why?" five times in sequence. '
        'Write down what you find at the bottom. If the foundation is hollow, that is important.',
    weeklyChallenge:
        'Have one conversation this week where you only ask questions — '
        'no opinions, no advice, no agreement or disagreement. Pure inquiry.',
    category: PhilosophyCategory.reason,
    overview:
        'We know Socrates entirely through other people\'s accounts. He wrote nothing himself. '
        'What survives is primarily Plato\'s dialogues, Xenophon\'s memoirs, '
        'and Aristophanes\' comedy "The Clouds" (which made him a figure of ridicule, '
        'and which Socrates mentioned at his trial as one of the sources of prejudice against him). '
        'The man who invented Western philosophy left no documents signed with his own hand. '
        'This is appropriate: his philosophy was not a body of doctrine to be transmitted '
        'but a practice — the practice of dialogue, of relentless questioning, '
        'of not letting comfortable assumptions remain unchallenged.\n\n'
        'He was an Athenian citizen — the son of a stonemason and a midwife — '
        'who served with distinction as a soldier at Potidaea, Delium, and Amphipolis. '
        'He was physically ugly by Greek standards — flat-nosed, bulging-eyed, '
        'with a peculiar gait — and he spent his adult life in the agora and gymnasia of Athens, '
        'engaging anyone willing to talk about the great questions: '
        'What is justice? What is courage? What is knowledge? What is the good life? '
        'He accepted no payment. He claimed no wisdom for himself.\n\n'
        'In 399 BCE, at seventy years old, he was tried for impiety and corrupting the youth. '
        'Found guilty by 280 votes to 220. He was offered exile and refused — '
        'leaving Athens, he said, would require him to stop philosophizing, '
        'which was the equivalent of asking him to stop living. '
        'He was offered the chance to propose a lesser penalty than death '
        'and proposed instead that he be honored with free meals at public expense — '
        'an answer so deliberately provocative that the jury voted for death by a larger majority '
        'than had voted for guilt.\n\n'
        'He drank the hemlock calmly, surrounded by friends, '
        'while continuing to discuss the immortality of the soul. '
        'It was the most philosophically consistent death in recorded history, '
        'and it created a martyr whose influence has not diminished '
        'in twenty-four centuries.',
    historicalContext:
        'Socrates lived through Athens\'s golden age and its catastrophic collapse — '
        'the construction of the Parthenon, the tragedies of Sophocles and Euripides, '
        'the Peloponnesian War with Sparta that lasted twenty-seven years, '
        'the plague of 430 BCE that killed perhaps a third of the Athenian population, '
        'and the final defeat of Athens in 404 BCE. '
        'The democracy that tried him was a traumatized democracy, '
        'recently restored after the brutal oligarchy of the Thirty Tyrants '
        '(one of whom, Critias, had been associated with Socrates), '
        'deeply suspicious of the intellectual class it held partly responsible '
        'for the city\'s military failures and moral degradation.\n\n'
        'His student Plato, who witnessed the trial and execution, '
        'responded by founding the Academy — the first institution of higher learning '
        'in the Western world — and spent his subsequent decades constructing '
        'a philosophical system that was simultaneously a tribute to his teacher '
        'and an attempt to answer the political and epistemological failures '
        'that had led to his execution. Almost every major philosophical tradition '
        'in Western history traces back, directly or in opposition, to that response.',
    keyTeachings: [
      CoreTeaching(
        title: 'Epistemic Humility — I Know That I Know Nothing',
        body:
            '"I know that I know nothing" is the starting point, not the endpoint. '
            'Socrates claimed no wisdom for himself — only the strange negative distinction '
            'of being aware that he lacked it, while others lacked it without being aware. '
            'The Oracle at Delphi had called him the wisest man in Athens. '
            'His investigation of that claim — talking to politicians, poets, and craftsmen '
            'who were all certain of their wisdom — convinced him that the Oracle was right '
            'for the wrong reason: he was wisest only because he alone knew he was ignorant. '
            'That knowledge is not trivial. It is the prerequisite of all genuine inquiry.',
      ),
      CoreTeaching(
        title: 'The Examined Life',
        body:
            '"The unexamined life is not worth living." This is the most quoted line from '
            'Plato\'s Apology — Socrates\'s defense speech at his trial. He meant it with '
            'complete seriousness and zero rhetorical exaggeration. A life lived on autopilot, '
            'accepting inherited values and conventional beliefs without ever questioning them, '
            'was not — in his view — properly a human life at all. '
            'Philosophy was not a hobby or a luxury for the educated. '
            'It was the central activity of a fully human existence. '
            'Everything else was preparation for it or distraction from it.',
      ),
      CoreTeaching(
        title: 'Elenchus — Refutation as Care',
        body:
            'The Socratic method is not adversarial in its intent. It is a form of care. '
            'Socrates called himself a midwife — his role was not to deliver ideas to his '
            'interlocutors but to help them give birth to their own. Elenchus (refutation) '
            'serves this goal: not winning arguments but clearing away false beliefs '
            'that block access to genuine understanding. You can only know what you actually know '
            'when you have cleared away what you merely believe. '
            'The discomfort of having a confident assumption exposed as unfounded '
            'is, in Socrates\'s framework, not an embarrassment but an education.',
      ),
      CoreTeaching(
        title: 'Virtue as Knowledge',
        body:
            'Socrates held a distinctive and controversial position: that virtue (arete) '
            'was a form of knowledge, and that no one does wrong willingly. '
            'People do wrong because they are mistaken about what is genuinely good. '
            'If this is true — and it is internally consistent with his other views — '
            'then the remedy for vice is not punishment but enlightenment, '
            'and moral education is the most important form of education available. '
            'It is not a comfortable position in a world of deliberate cruelty. '
            'But it is a position that takes human rationality seriously enough '
            'to hold it responsible.',
      ),
    ],
    modernApplication:
        'The Socratic method is the basis of legal cross-examination, the Socratic seminar, '
        'the "five whys" of lean manufacturing, and most critical thinking curricula. '
        'In practical terms: the most useful thing Socrates teaches is the practice of '
        'asking "why?" five times in sequence about any belief, decision, or problem. '
        'The first "why" gives a surface answer — the one you have rehearsed. '
        'The fifth "why" reaches something either genuinely foundational '
        'or reveals that the belief has no foundation at all. '
        'Both outcomes are valuable.\n\n'
        'In management and leadership, the Socratic method is the difference between '
        'telling people what to think and asking questions until they discover it themselves. '
        'The insight arrived at through genuine inquiry is owned by the person who arrived at it. '
        'The conclusion delivered from authority is complied with until it isn\'t. '
        'The difference in commitment, creativity, and resilience under pressure '
        'is large and consistent. Socrates has been dead for 2,400 years. '
        'Every good teacher, every great leader, every effective therapist '
        'is still using his method.',
    quotes: [
      PhilosophyQuote(
        text: 'The unexamined life is not worth living.',
        source: 'Apology (Plato), 38a',
      ),
      PhilosophyQuote(
        text: 'I know that I know nothing.',
        source: 'Apology (Plato)',
      ),
      PhilosophyQuote(
        text: 'Wonder is the beginning of wisdom.',
        source: 'Theaetetus (Plato)',
      ),
      PhilosophyQuote(
        text: 'Education is the kindling of a flame, not the filling of a vessel.',
        source: 'Attributed',
      ),
      PhilosophyQuote(
        text: 'He who is not contented with what he has, would not be contented with what he would like to have.',
        source: 'Attributed',
      ),
    ],
    keyWorks: [
      'Apology — Plato (c. 399 BCE)',
      'Meno — Plato',
      'The Republic — Plato',
      'Phaedo — Plato',
      'Trial of Socrates — I.F. Stone (1989)',
    ],
    gradientColors: [Color(0xFF2ECC71), Color(0xFF0B5345)],
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // EXISTENTIAL
  // ══════════════════════════════════════════════════════════════════════════

  PhilosophyMeta(
    id: 'camus',
    name: "Camus' Revolt",
    icon: '🎭',
    thinker: 'Albert Camus',
    era: 'France / Algeria · 1913–1960 CE',
    tagline: 'One must imagine Sisyphus happy.',
    description:
        'The gods condemned Sisyphus to roll a boulder uphill forever. '
        'Camus said that is the human condition — and that Sisyphus must be imagined happy. '
        'Revolt against absurdity is the only authentic victory available.',
    challenge:
        'Name one area where you have been waiting for meaning to arrive. '
        'Stop waiting. Act in it today as if it matters, because you have decided it does.',
    weeklyChallenge:
        'Do one thing this week purely for the joy of doing it — no outcome, no audience, '
        'no purpose beyond the act itself. Notice how it feels.',
    category: PhilosophyCategory.existential,
    overview:
        'Albert Camus was born in Mondovi, Algeria, in 1913, the second son of a French '
        'agricultural worker and a Spanish-Algerian cleaning woman who was partially deaf '
        'and could neither read nor write. His father died at the Battle of the Marne in 1914, '
        'when Camus was less than a year old. He grew up in poverty in Algiers, '
        'in a two-room apartment without running water or electricity, sharing a bed with his brother.\n\n'
        'He was rescued from that poverty by a primary school teacher — Louis Germain — '
        'who recognized his extraordinary intelligence and advocated for him to enter '
        'a competitive lycée. When Camus accepted the Nobel Prize for Literature in 1957, '
        'his first act was to write a private letter to Germain. '
        '"Without you, without the affectionate hand you extended to the small poor child '
        'that I was, without your teaching and example, none of all this would have happened." '
        'He kept that teacher in view his entire life.\n\n'
        'The philosophy he built — Absurdism — emerged from a confrontation with what '
        'he saw as the central fact of human existence: we are creatures who demand meaning '
        'in a universe that provides none. The gap between the demand and the silence — '
        'this is the Absurd. It is not a conclusion, not a feeling, not a mood. '
        'It is a structural feature of the human condition that every honest person '
        'eventually confronts. His answer was revolt: the deliberate, lucid refusal '
        'to let the universe\'s silence be the final word.\n\n'
        'He was killed in a car accident on January 4, 1960, at forty-six. '
        'An unused train ticket was found in his pocket — he had originally planned '
        'to travel by train but accepted a last-minute lift. '
        'In his briefcase was the unfinished manuscript of "The First Man," '
        'an autobiographical novel about his childhood in Algeria. '
        'Published posthumously in 1994, it is perhaps his finest work.',
    historicalContext:
        'Camus\'s Algeria was a colonial society of profound inequality — '
        'European French settlers enjoying full citizenship and legal protection, '
        'Algerian Arabs and Berbers occupying a permanently subordinate status. '
        'This context shaped his political thinking in ways that put him at odds '
        'with almost every intellectual faction of his era. '
        'He could not support French colonialism. He could not — after witnessing '
        'the terror of the Nazi occupation of France — support revolutionary violence '
        'as a political method, even for just ends.\n\n'
        'He was a member of the French Resistance during the Nazi occupation, '
        'editing the underground newspaper Combat. After the war, his public break '
        'with Sartre in 1952 over "The Rebel" — his critique of revolutionary ideology — '
        'remains one of the most significant intellectual ruptures of the twentieth century. '
        'Sartre called him a bourgeois moralist. Camus replied that he refused to call '
        'any ideology that justified murdering civilians a philosophy of liberation. '
        'History has not been entirely unkind to his position.',
    keyTeachings: [
      CoreTeaching(
        title: 'The Absurd',
        body:
            'The Absurd is not meaninglessness itself — it is the confrontation between '
            'the human need for meaning and the universe\'s complete silence in response. '
            '"I said the world is absurd, but I was too hasty. This world in itself is not reasonable. '
            'What is absurd is the confrontation of the irrational and the wild longing for clarity '
            'whose call echoes in the human heart." '
            'The Absurd is the gap. It does not go away. '
            'It cannot be solved by religion (which lies about the silence) '
            'or by suicide (which runs from it) '
            'or by nihilism (which misidentifies it as meaninglessness). '
            'The only authentic response is to live inside the gap, in full awareness.',
      ),
      CoreTeaching(
        title: 'Three Responses to Absurdity',
        body:
            'Camus identified three possible responses to the confrontation with Absurdity. '
            'Physical suicide — ending life to escape the gap. This he rejected as evasion. '
            'Philosophical suicide — adopting a belief system (religious or ideological) '
            'that papers over the gap with false certainty. This he rejected as dishonesty. '
            'And revolt — continuing to live, fully conscious of the Absurd, '
            'refusing both escape and self-deception, creating meaning through the quality '
            'of one\'s engagement with life. This is the only authentic option.',
      ),
      CoreTeaching(
        title: 'Revolt, Freedom, Passion',
        body:
            'Camus\'s response to the Absurd is structured around three simultaneous attitudes. '
            'Revolt: the refusal to accept the universe\'s silence as the final word. '
            'Freedom: the recognition that without cosmic meaning, you are free to choose '
            'your own. Passion: the commitment to live with maximum intensity given that '
            'nothing is guaranteed and nothing transcendent is available. '
            'This is not nihilism. It is nihilism\'s exact opposite. '
            'Nihilism says nothing matters. Absurdism says nothing transcendently matters, '
            'and therefore what we choose to care about, we must care about with everything.',
      ),
      CoreTeaching(
        title: 'One Must Imagine Sisyphus Happy',
        body:
            'The Myth of Sisyphus concludes with Sisyphus watching his boulder roll back '
            'to the bottom of the hill — for the ten thousandth time — before turning '
            'to descend and begin pushing again. Camus insists we must imagine him happy. '
            'Not content, not resigned, not distracted. Happy. '
            'The happiness of complete presence to his situation, of revolt against '
            'the pointlessness, of choosing the next push in the full knowledge '
            'that it will not hold. That choice — freely made, fully conscious — '
            'is the only authentic response to an absurd universe.',
      ),
      CoreTeaching(
        title: 'The Ethics of Limits',
        body:
            '"The Rebel" argues that political violence — even revolutionary violence '
            'in service of just ends — contains within it the seed of the totalitarianism '
            'it claims to fight. Camus\'s political ethics were built around limits: '
            'what you are not willing to do, even for a cause you believe in absolutely. '
            'This position cost him his friendship with Sartre and much of the '
            'French intellectual left. It remains one of the most important ethical '
            'frameworks produced by the twentieth century.',
      ),
    ],
    modernApplication:
        'The most useful Camusian concept for modern life is the distinction between '
        'revolt and escape. Most people facing an Absurd situation — a gap between '
        'the life they expected and the life they have — choose escape: '
        'substances, screens, distractions, ideology, overwork. '
        'Camus\'s revolt is the harder, more expensive choice: to look at the gap directly, '
        'refuse to paper it over, and then act anyway, for your own chosen reasons, '
        'with full presence to what is actually happening.\n\n'
        'In creative work, this is the difference between the artist who creates '
        'for validation or immortality (escape) and the artist who creates because '
        'the act of creation is what they have chosen as their response to existence (revolt). '
        'The second artist makes better work — not because they are more talented '
        'but because their relationship to their work is uncorrupted by anxiety '
        'about what it earns them. Camus wrote under the constant pressure of war, '
        'poverty, illness, and political controversy. The work he produced '
        'has outlasted every adversity. That is not coincidence.',
    quotes: [
      PhilosophyQuote(
        text: 'One must imagine Sisyphus happy.',
        source: 'The Myth of Sisyphus',
      ),
      PhilosophyQuote(
        text: 'In the depths of winter, I finally learned that within me there lay an invincible summer.',
        source: 'Return to Tipasa',
      ),
      PhilosophyQuote(
        text: 'The struggle itself toward the heights is enough to fill a man\'s heart.',
        source: 'The Myth of Sisyphus',
      ),
      PhilosophyQuote(
        text: 'Don\'t walk in front of me — I may not follow. Don\'t walk behind me — I may not lead. Walk beside me and be my friend.',
        source: 'Attributed',
      ),
      PhilosophyQuote(
        text: 'You will never be happy if you continue to search for what happiness consists of. You will never live if you are looking for the meaning of life.',
        source: 'Attributed',
      ),
      PhilosophyQuote(
        text: 'To be happy, we must not be too concerned with others.',
        source: 'The Fall',
      ),
    ],
    keyWorks: [
      'The Myth of Sisyphus — Camus (1942)',
      'The Stranger (L\'Étranger) — Camus (1942)',
      'The Plague — Camus (1947)',
      'The Rebel — Camus (1951)',
      'Camus: A Life — Olivier Todd (1996)',
    ],
    gradientColors: [Color(0xFF7F8C8D), Color(0xFF2C3E50)],
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // RELATIONS
  // ══════════════════════════════════════════════════════════════════════════

  PhilosophyMeta(
    id: 'simone_weil',
    name: "Simone Weil's Attention",
    icon: '🌻',
    thinker: 'Simone Weil',
    era: 'France · 1909–1943 CE',
    tagline: 'Attention is the rarest and purest form of generosity.',
    description:
        'Weil chose to work in factories and on farms to understand the lives of those who labored. '
        'Her central insight: truly attending to another person — without agenda, without '
        'advice, without your own voice waiting — is the most demanding thing a human can do.',
    challenge:
        'Have one conversation today where you give your complete, undivided attention. '
        'No phone, no agenda, no interjections. Just full, present listening.',
    weeklyChallenge:
        'Notice every moment this week when your mind goes elsewhere during a conversation. '
        'Practice returning to the present. The return is the entire practice.',
    category: PhilosophyCategory.relations,
    overview:
        'Simone Weil was born in Paris in 1909, into a secular Jewish family of exceptional '
        'intellectual distinction. Her brother André would become one of the greatest '
        'mathematicians of the twentieth century. She entered the École Normale Supérieure '
        'at sixteen — the institution that produced Sartre, de Beauvoir, and Merleau-Ponty — '
        'and graduated first in her class. Sartre graduated second. '
        'She never mentioned this publicly. He mentioned it frequently.\n\n'
        'What made Weil extraordinary was not her intelligence — Paris was full of brilliant '
        'people — but her absolute refusal to allow philosophy to remain theoretical. '
        'She resigned a teaching post to work in factories and on farms, '
        'not as a social experiment or a political statement but because she needed '
        'to understand what factory work did to a person\'s soul before she could write '
        'honestly about justice. Her factory journals — written at night after eleven-hour shifts '
        'on an assembly line — are among the most morally serious documents of the twentieth century. '
        'They are also completely unlike anything else written by a major philosopher.\n\n'
        'She was chronically ill, suffered from debilitating migraines, '
        'and had a complicated, ultimately fatal relationship with food. '
        'She died in 1943 at thirty-four, in a sanatorium in Ashford, England, '
        'from tuberculosis compounded by self-imposed starvation in solidarity '
        'with the people of occupied France. She refused to eat more than was available '
        'to those under German occupation. The coroner\'s verdict was suicide. '
        'Her biographer Simone Pétrement contested this vigorously.\n\n'
        'Her theological writings — produced in the last three years of her life — '
        'describe a mystical Christianity that she practiced without baptism, '
        'insisting she belonged at the threshold of the Church, not inside it, '
        'in solidarity with those excluded from any institution. '
        'Her philosophy of attention emerged directly from this theology: '
        'the same quality of presence that constitutes genuine prayer '
        'is what constitutes genuine human love.',
    historicalContext:
        'Weil\'s adult life coincided with the Spanish Civil War (in which she fought briefly '
        'on the anarchist side, injuring herself accidentally and requiring evacuation), '
        'the rise of Nazi Germany, the Popular Front government in France, '
        'the fall of France in 1940, and the Free French resistance. '
        'She left France after the German occupation and spent time in New York '
        'and London, where she worked for de Gaulle\'s government in exile '
        'and wrote at extraordinary intensity in what she knew were probably her final months.\n\n'
        '"The Need for Roots," written in 1943 as a blueprint for post-war reconstruction, '
        'was commissioned by the Free French government and largely ignored by them. '
        'T.S. Eliot, who wrote the preface to its English translation, '
        'called it "a work of genius." '
        'Its central argument — that uprooting from community, tradition, and meaningful work '
        'was the deepest affliction of modern civilization — '
        'was more prescient than its immediate readers recognized.',
    keyTeachings: [
      CoreTeaching(
        title: 'Attention as the Highest Act',
        body:
            '"Attention is the rarest and purest form of generosity." '
            'Weil\'s concept of attention is precise and technically demanding: '
            'it is not concentration — concentration implies effort, which implies the ego. '
            'True attention is the suspension of the self: emptying yourself of your own '
            'agenda, interpretations, prepared responses, and desire to fix or advise, '
            'long enough to actually receive what is being communicated. '
            'Most of what passes for listening is preparation for speaking. '
            'Most of what passes for care is waiting for your own voice. '
            'True attention is rarer than we think and more valuable than we know.',
      ),
      CoreTeaching(
        title: 'Decreation',
        body:
            'Weil\'s most unusual concept is decreation: the idea that spiritual and ethical '
            'growth requires a kind of deliberate self-diminishment — '
            'making room for others by reducing the space occupied by the self. '
            'This is not self-erasure or self-hatred. It is a shift in the center of gravity '
            'from the self as the primary reference point toward the other. '
            'She saw this movement — away from self-preoccupation toward genuine other-attention — '
            'in great art, in genuine prayer, and in authentic love. '
            'In all three, the practitioner gets the ego out of the way. '
            'That is the entire technique.',
      ),
      CoreTeaching(
        title: 'Affliction — malheur',
        body:
            'Weil distinguished between ordinary suffering and malheur — affliction: '
            'the kind of suffering that marks and deforms a person\'s soul over time. '
            'The afflicted, she observed, are the most difficult to truly attend to — '
            'because affliction tends to make people invisible. '
            'The truly poor, the truly enslaved, the truly isolated '
            'are those from whom society most consistently withholds its attention, '
            'because attending to them would require confronting one\'s own complicity '
            'in their condition. Her factory experience was designed to make that confrontation impossible to avoid.',
      ),
      CoreTeaching(
        title: 'Rootedness as a Human Need',
        body:
            '"The Need for Roots" identifies what Weil called the most fundamental '
            'and least recognized need of the human soul: the need to be rooted — '
            'to have genuine connection to a community, a tradition, a place, a practice '
            'that exists over time and carries meaning beyond the individual. '
            'Uprootedness — the severing of these connections — was, she argued, '
            'the deepest affliction of modern civilization, produced by '
            'industrial capitalism, colonialism, and the systematic destruction '
            'of every culture that gave human beings their sense of place.',
      ),
      CoreTeaching(
        title: 'Justice as Attention to the Specific',
        body:
            'Weil\'s political philosophy was built on attention. '
            'Justice, she argued, was not the application of abstract principles '
            'to generic cases — it was the sustained, specific attention '
            'to the particular person in front of you, in their particular situation, '
            'with their particular needs. The failure of justice was always, at its root, '
            'a failure of attention: the refusal or inability to actually see '
            'the specific suffering of a specific person.',
      ),
    ],
    modernApplication:
        'Weil\'s concept of attention is the philosophical foundation of everything '
        'we now call "presence" — the quality that distinguishes a great therapist from '
        'a mediocre one, a genuine leader from a transactional manager, '
        'a sustaining friendship from a superficial one. Research on therapeutic outcomes '
        'consistently shows that the quality of the therapist\'s attention — '
        'their capacity for genuine presence — is a stronger predictor of patient improvement '
        'than any specific technique or theoretical framework. '
        'The same finding appears in education, in leadership, and in negotiation.\n\n'
        'The practical implication is uncomfortable: genuine attention is rare '
        'because it is genuinely expensive. It requires giving up your own agenda, '
        'your prepared responses, your desire to be perceived as helpful, '
        'your waiting-for-your-turn, your analysis. '
        'It requires occupying the other person\'s experience rather than your own. '
        'This is why Weil called it the purest form of generosity — '
        'it costs more than money. It costs self-preoccupation, '
        'which is most people\'s default mode of being in the world.',
    quotes: [
      PhilosophyQuote(
        text: 'Attention is the rarest and purest form of generosity.',
        source: 'Waiting for God',
      ),
      PhilosophyQuote(
        text: 'To be rooted is perhaps the most important and least recognized need of the human soul.',
        source: 'The Need for Roots',
      ),
      PhilosophyQuote(
        text: 'Imagination and fiction make up more than three quarters of our real life.',
        source: 'Gravity and Grace',
      ),
      PhilosophyQuote(
        text: 'A test of what is real is that it is hard and rough. Joys are found in it, not pleasure.',
        source: 'Gravity and Grace',
      ),
      PhilosophyQuote(
        text: 'The most important obligation on human beings is to think correctly.',
        source: 'Notebooks',
      ),
    ],
    keyWorks: [
      'Waiting for God — Simone Weil (1951, posthumous)',
      'Gravity and Grace — Simone Weil (1947, posthumous)',
      'The Need for Roots — Simone Weil (1949)',
      'Simone Weil: A Life — Simone Pétrement (1976)',
    ],
    gradientColors: [Color(0xFFE91E63), Color(0xFF880E4F)],
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // SPARTAN DISCIPLINE (for onboarding)
  // ══════════════════════════════════════════════════════════════════════════

  PhilosophyMeta(
    id: 'spartan_discipline',
    name: 'Spartan Discipline',
    icon: '⚔️',
    thinker: 'Ancient Sparta',
    era: 'Ancient Greece · 8th–2nd century BCE',
    tagline: 'Sweat more in training, bleed less in war.',
    description:
        'The Spartans built an entire civilization on the belief that hardship is the forge of greatness. '
        'Their lives were exercises in deliberate discomfort — not for punishment, but for freedom.',
    challenge:
        'Do one hard thing today before you do anything easy. Physical, mental, emotional — '
        'you choose the arena. Complete it before your first reward.',
    weeklyChallenge:
        'Choose one comfort to eliminate for seven days. No snooze button. No sugar. '
        'No complaining. Track your internal resistance and what lies beyond it.',
    category: PhilosophyCategory.discipline,
    overview:
        'Sparta was not a philosophy in the conventional sense — there were no great treatises, '
        'no schools of thought, no philosophers who wrote about the Spartan way. '
        'It was a lived philosophy, a total system of life organized around one central insight: '
        'that human beings become strong through voluntary hardship, and that comfort, '
        'when sought as an end, produces weakness. Every institution in Spartan society — '
        'the agoge (education system), the syssitia (common mess), the prohibition on coined '
        'money, the expectation of lifelong physical training — was designed to eliminate '
        'the possibility of softness.\n\n'
        'Spartan boys entered the agoge at age seven, leaving their families to live in '
        'communal barracks where they were deliberately underfed (to teach resourcefulness '
        'in foraging), given one cloak for the entire year (to teach endurance of cold), '
        'and subjected to physical punishments designed to teach resilience. '
        'They were taught to read and write, but the primary curriculum was survival, '
        'discipline, and the subordination of individual desire to collective purpose. '
        'At twenty, they became soldiers. At thirty, they could marry and live at home, '
        'but they continued to train and eat in common messes until sixty.\n\n'
        'The result was a warrior society that produced, for several centuries, the most '
        'feared infantry in the ancient world. The Spartan stand at Thermopylae — 300 Spartans '
        'and their allies holding a narrow pass against a Persian army of perhaps 100,000 — '
        'was not a military victory (they all died) but a demonstration of what human beings '
        'can endure when they have been trained to see death as lighter than dishonor. '
        'It has echoed through military history ever since.\n\n'
        'But Sparta was also a society of profound contradictions. It was a slave state — '
        'the Spartans ruled over a much larger population of helots (enslaved Greeks) who '
        'performed all agricultural labor, freeing the Spartans for full-time military training. '
        'Its rigid social structure left no room for individual deviation. '
        'It was not kind. It was not democratic. It was not liberal. '
        'It was a machine for producing disciplined warriors, and it succeeded at that '
        'with an effectiveness that has rarely been equaled.',
    historicalContext:
        'Sparta emerged as a distinct political entity during the Greek Dark Ages, developing '
        'its unique social system sometime around the 8th century BCE, traditionally attributed '
        'to the lawgiver Lycurgus — though whether he was a historical figure remains debated. '
        'The Spartan constitution, the Great Rhetra, established a dual kingship, a council of '
        'elders, and an assembly of citizens, creating a mixed government that later political '
        'philosophers (including Plato and Aristotle) studied as a model of stability.\n\n'
        'Sparta led the Greek resistance to the Persian invasions of 490 and 480 BCE, '
        'earning immense prestige throughout the Greek world. It then fought a twenty-seven-year '
        'war against Athens (the Peloponnesian War, 431–404 BCE), emerging victorious but '
        'exhausted. Its dominance lasted barely a generation before it was defeated by Thebes '
        'at the Battle of Leuctra in 371 BCE — a defeat from which it never fully recovered. '
        'The Spartan system, for all its military effectiveness, proved incapable of adapting '
        'to a world that increasingly valued flexibility over rigid discipline.',
    keyTeachings: [
      CoreTeaching(
        title: 'Hardship as Training',
        body:
            'The Spartans understood something that modern psychology has confirmed: that voluntary '
            'exposure to controlled stress builds resilience. They did not wait for hardship to arrive — '
            'they sought it out, systematically, across every domain of life. Cold. Hunger. Pain. '
            'Exhaustion. Fear. Every Spartan was trained to experience these things, repeatedly, '
            'until they ceased to be disabling and became instead information — signals to be '
            'interpreted and managed, not emergencies to be fled. This is not machismo. '
            'It is a deliberate, evidence-based approach to building psychological capacity.',
      ),
      CoreTeaching(
        title: 'The Common Good Above the Individual',
        body:
            'Spartan society was built on a radical proposition: that the individual exists '
            'for the community, not the community for the individual. Every aspect of life — '
            'diet, exercise, reproduction, education, labor, leisure — was regulated to serve '
            'the collective purpose of maintaining Sparta\'s military readiness and social cohesion. '
            'This produced extraordinary solidarity and extraordinary conformity. '
            'The lesson for modern application is not to replicate Spartan collectivism literally, '
            'but to consider: what are you serving with your daily discipline? '
            'Discipline without purpose is just asceticism. Discipline in service of something '
            'larger than yourself becomes meaning.',
      ),
      CoreTeaching(
        title: 'Laconic Speech — Precision in Few Words',
        body:
            'Spartans were famous for their terse, pointed speech — the word "laconic" '
            'derives from Laconia, the region around Sparta. When Philip II of Macedon '
            'sent a message to Sparta threatening "If I invade Laconia, I will level your city," '
            'the Spartans replied with one word: "If." This was not rudeness. It was a cultivated '
            'habit of saying exactly what needed to be said and nothing else — '
            'a discipline of communication that reduces the noise-to-signal ratio '
            'to its absolute minimum.',
      ),
      CoreTeaching(
        title: 'Physical Excellence as Moral Foundation',
        body:
            'The Spartans did not separate physical training from moral training. '
            'A weak body, they believed, could not house a strong character. '
            'The discipline required to push through physical limits was, for them, '
            'the same discipline required to hold a battle line, to resist temptation, '
            'to honor an oath. Modern neuroscience confirms this link: the same prefrontal '
            'cortex that restrains physical impulse also governs moral decision-making. '
            'Train one, and you are training the other.',
      ),
      CoreTeaching(
        title: 'No Outcome Without Preparation',
        body:
            '"Sweat more in training, bleed less in war" is a modern paraphrase of a Spartan '
            'principle: that the outcome of any contest is largely determined before it begins, '
            'in the preparation. Spartans did not win battles through tactical brilliance — '
            'other Greek city-states had more innovative generals. They won through superior '
            'conditioning, superior cohesion, and the absolute certainty that they had endured '
            'things in training that no opponent could match on the battlefield. '
            'The same principle applies to any arena: the person who has prepared more thoroughly '
            'has already won a significant portion of the contest.',
      ),
    ],
    modernApplication:
        'The practical application of Spartan philosophy does not require a barracks '
        'or a slave economy — both of which are morally repugnant to modern sensibilities. '
        'What survives is the core insight: that the systematic, voluntary embrace of '
        'difficulty builds a kind of strength that comfort cannot produce. '
        'The modern practitioner takes cold showers. They fast occasionally. '
        'They train physically when they don\'t want to. They practice difficult conversations '
        'rather than avoiding them. They cultivate the ability to be uncomfortable without '
        'complaint, because they understand that this ability transfers to every domain of life.\n\n'
        'Research on resilience, post-traumatic growth, and stress inoculation training '
        '(used by military special forces and emergency responders) consistently validates '
        'the Spartan insight: controlled, voluntary exposure to stress expands the capacity '
        'to handle uncontrolled, involuntary stress. This is not a metaphor. It is a measurable '
        'physiological and psychological reality. The Spartans discovered it intuitively. '
        'Modern science has confirmed it.',
    quotes: [
      PhilosophyQuote(
        text: 'Come back with your shield — or on it.',
        source: 'Traditional Spartan saying to departing warriors',
      ),
      PhilosophyQuote(
        text: 'If.',
        source: 'Spartan reply to Philip II of Macedon',
      ),
      PhilosophyQuote(
        text: 'He who sweats more in training bleeds less in war.',
        source: 'Traditional Spartan maxim',
      ),
      PhilosophyQuote(
        text: 'We are what we repeatedly do. Excellence, then, is not an act, but a habit.',
        source: 'Attributed to a Spartan principle, later formalized by Aristotle',
      ),
    ],
    keyWorks: [
      'The Spartan Regime — Paul A. Rahe (2016)',
      'Gates of Fire — Steven Pressfield (1998)',
      'The Warrior Ethos — Steven Pressfield (2011)',
      'Spartan Up! — Joe De Sena (2014)',
    ],
    gradientColors: [Color(0xFFB22222), Color(0xFF8B4513)],
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // DIOGENES (for onboarding)
  // ══════════════════════════════════════════════════════════════════════════

  PhilosophyMeta(
    id: 'diogenes',
    name: 'Cynic Freedom',
    icon: '🪔',
    thinker: 'Diogenes of Sinope',
    era: 'Ancient Greece · 412–323 BCE',
    tagline: 'I am a citizen of the world.',
    description:
        'Diogenes lived in a barrel, begged for food, and told Alexander the Great to step out '
        'of his sunlight. He was the first philosopher to prove that happiness requires almost nothing.',
    challenge:
        'Identify one possession or status symbol you fear losing. '
        'Imagine giving it up. What of you remains? Act from that place today.',
    weeklyChallenge:
        'Remove one non-essential from your daily life for a week — a luxury, a convenience, '
        'a social media platform. Notice the gap between what you thought you needed '
        'and what you actually need.',
    category: PhilosophyCategory.creativity,
    overview:
        'Diogenes was banished from Sinope for defacing currency — literally or metaphorically, '
        'the historical record is ambiguous. He arrived in Athens, the philosophical capital '
        'of the Greek world, owning nothing but a cloak and a staff. When he saw a mouse '
        'scurrying about without anxiety — no home, no possessions, no fear of the dark — '
        'he took it as a sign. The mouse needed nothing to be what it was. '
        'Neither, he decided, did he.\n\n'
        'He became the most famous philosopher of the Cynic school — a movement whose name '
        'derives from the Greek word for "dog-like" (kyon), because Diogenes and his followers '
        'lived with the shameless simplicity of dogs. He famously lived in a large ceramic jar '
        '(not a barrel — the Greek pithos was a storage jar) in the marketplace of Athens. '
        'He begged for food. He urinated, defecated, and masturbated in public, scandalizing '
        'his contemporaries by demonstrating that natural functions were not shameful unless '
        'convention made them so. He was Socrates gone mad, Plato called him. '
        'Diogenes would have taken that as a compliment.\n\n'
        'The most famous story about him is his encounter with Alexander the Great. '
        'The conqueror of the known world, impressed by Diogenes\'s reputation, visited him '
        'and offered to grant any wish. Diogenes, sunning himself outside his jar, replied: '
        '"Stand a little out of my sun." Alexander, amused and perhaps genuinely impressed, '
        'is said to have told his companions: "If I were not Alexander, I would wish to be Diogenes." '
        'The conqueror who owned everything was, in that moment, acknowledging the freedom '
        'of the man who owned nothing.\n\n'
        'Whether the story is literally true matters less than what it means. '
        'Diogenes had something Alexander could not buy, threaten, or conquer: '
        'complete independence from what anyone thought of him. '
        'That independence was not a gift. It was a practice.',
    historicalContext:
        'Diogenes lived during the period of Macedonian ascendancy — he was supposedly '
        'born the year Socrates died, and he died the same year as Alexander the Great. '
        'He witnessed the end of the Athenian polis as an independent power and its absorption '
        'into the empires of Philip and Alexander. In this context, his rejection of citizenship '
        'in any particular city — "I am a citizen of the world (kosmopolitēs)" — '
        'was a radical political statement. When the old institutions no longer served, '
        'new forms of belonging had to be invented.\n\n'
        'Cynicism was never an organized school with a doctrine; it was a way of life '
        'transmitted by example. Diogenes wrote some dialogues and tragedies (now lost), '
        'but his primary medium was his body — the way he dressed, ate, slept, spoke, '
        'and refused the conventions that his contemporaries accepted without question. '
        'His influence spread through his students (most notably Crates of Thebes) '
        'and from them into Stoicism — Zeno of Citium, the founder of Stoicism, '
        'began as a Cynic. The Stoic emphasis on simplicity, resilience, and the '
        'independence of virtue from external circumstances can be traced directly back '
        'to the man in the jar.',
    keyTeachings: [
      CoreTeaching(
        title: 'Parrhesia — Radical Honesty',
        body:
            'Diogenes exercised parrhesia: fearless, unfiltered speech, regardless of consequences. '
            'He said publicly what others only thought privately. He insulted the powerful '
            'to their faces. He mocked social conventions that existed only to protect the comfort '
            'of the comfortable. This was not cruelty — it was a philosophical method. '
            'The goal was to expose the gap between what people claimed to value '
            'and what they actually lived. A society that cannot tolerate parrhesia '
            'is a society that cannot tolerate the truth.',
      ),
      CoreTeaching(
        title: 'Autarkeia — Self-Sufficiency',
        body:
            'Autarkeia is the condition of needing nothing external to be complete. '
            'Diogenes practiced it by systematically reducing his dependencies: '
            'on possessions, on social status, on the approval of others, on comfort itself. '
            'Every attachment to something outside the self is, he argued, a vulnerability — '
            'a point of leverage through which the world can pressure you. '
            'The person who needs nothing from anyone cannot be coerced. '
            'That is not isolation. That is freedom.',
      ),
      CoreTeaching(
        title: 'Cosmopolitanism — Citizenship of the World',
        body:
            'When asked where he came from, Diogenes replied: "I am a citizen of the world." '
            'This was a rejection of the tribal, the national, the local as the primary frame '
            'of identity. If your first loyalty is to humanity rather than to Athens, Sparta, '
            'or Macedon, then the wars that consume these polities become visibly pointless. '
            'This was an astonishingly radical position in a world built on the city-state. '
            'It is still radical.',
      ),
      CoreTeaching(
        title: 'Askesis — Training Through Practice',
        body:
            'Diogenes did not merely believe in simplicity — he trained for it, deliberately, '
            'every day. He embraced poverty not because he had to but because he chose to, '
            'as an athlete embraces their training regimen. He rolled in hot sand in summer '
            'and embraced frozen statues in winter to acclimatize to discomfort. '
            'The goal was not asceticism for its own sake. The goal was freedom: '
            'to be the kind of person who could lose everything and not be diminished.',
      ),
      CoreTeaching(
        title: 'Defacing the Currency',
        body:
            'The oracle at Delphi, asked what Diogenes should do to become famous, '
            'told him to "deface the currency." Diogenes took this literally at first '
            '(he was exiled for coin‑clipping) but later interpreted it metaphorically: '
            'his task was to deface the intellectual and social currency of his age — '
            'to challenge the assumptions, conventions, and values that his society '
            'treated as given. The Cynic\'s job is to make people question what they have '
            'accepted without question.',
      ),
    ],
    modernApplication:
        'The minimalist movement, the tiny‑house movement, and the growing rejection of '
        'consumer culture are all, in their ways, applications of Diogenes\'s insight '
        'that happiness requires far less than the market insists it does. '
        'The research is clear: beyond a fairly modest threshold, additional wealth '
        'does not produce additional happiness. Additional possessions produce additional '
        'maintenance, not additional meaning. Diogenes knew this without a single study.\n\n'
        'His most practical gift is the regular practice of voluntary simplicity: '
        'periodically removing something you believe you need and discovering that you do not, '
        'in fact, need it. Each such discovery reduces your vulnerability. '
        'Each such discovery increases your freedom. The practice is not about renunciation. '
        'It is about calibration — finding the minimum necessary for a good life '
        'and recognizing that everything beyond that is optional.',
    quotes: [
      PhilosophyQuote(
        text: 'I am a citizen of the world.',
        source: 'Diogenes Laertius, Lives of Eminent Philosophers',
      ),
      PhilosophyQuote(
        text: 'Stand a little out of my sun.',
        source: 'To Alexander the Great',
      ),
      PhilosophyQuote(
        text: 'He has the most who is content with the least.',
        source: 'Attributed',
      ),
      PhilosophyQuote(
        text: 'The foundation of every state is the education of its youth.',
        source: 'Attributed',
      ),
      PhilosophyQuote(
        text: 'It is not that I am mad, it is only that my head is different from yours.',
        source: 'Attributed',
      ),
    ],
    keyWorks: [
      'Lives of Eminent Philosophers, Book VI — Diogenes Laertius (3rd century CE)',
      'Cynics — William Desmond (2008)',
      'The Cynic Philosophers: From Diogenes to Julian — Robert F. Dobbin (2012)',
    ],
    gradientColors: [Color(0xFF6B8E23), Color(0xFF556B2F)],
  ),
];