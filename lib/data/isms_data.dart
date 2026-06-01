import 'package:flutter/material.dart';

// ── Visual style mapping for generative art ───────────────────────────────
enum ArtStyle {
  discipline,
  creativity,
  mindfulness,
  reason,
  existential,
  relations
}

class NotableFigure {
  final String name;
  final String contribution;
  const NotableFigure({required this.name, required this.contribution});
}

class IsmMeta {
  final String id;
  final String name;
  final String icon;
  final String tagline;
  final String description;
  final String challenge;
  final String weeklyChallenge;
  final String category;
  final ArtStyle visualStyle;

  final String overview;
  final String historicalContext;
  final List<String> coreTenets;
  final List<NotableFigure> notableFigures;
  final String modernApplication;
  final List<String> quotes;
  final List<String> keyWorks;
  final List<Color> gradientColors;

  const IsmMeta({
    required this.id,
    required this.name,
    required this.icon,
    required this.tagline,
    required this.description,
    required this.challenge,
    required this.weeklyChallenge,
    required this.category,
    required this.visualStyle,
    required this.overview,
    required this.historicalContext,
    required this.coreTenets,
    required this.notableFigures,
    required this.modernApplication,
    required this.quotes,
    required this.keyWorks,
    required this.gradientColors,
  });
}

const List<IsmMeta> kIsms = [
  // ── Meaning & Existence ──────────────────────────────────────────────────

  IsmMeta(
    id: 'stoicism',
    name: 'Stoicism',
    icon: '🏛️',
    tagline: 'Control what you can. Accept what you can\'t.',
    description:
        'Ancient philosophy teaching resilience and focusing only on what\'s in your power.',
    challenge:
        'When upset, ask "Is this in my control?" and let go of what isn\'t.',
    weeklyChallenge:
        'Daily journal: one thing you can control, one you can\'t.',
    category: 'meaning_existence',
    visualStyle: ArtStyle.discipline,
    overview:
        'Born in Athens c.300 BCE, Stoicism teaches that virtue (wisdom, courage, justice, temperance) is the only true good. The dichotomy of control is central: some things are up to us, others not. By training ourselves to care only about the first, we achieve tranquillity. Marcus Aurelius\'s Meditations, Epictetus\'s Enchiridion, and Seneca\'s letters form a practical manual still used today.',
    historicalContext:
        'Stoicism flourished in the Roman Empire, influencing emperors and slaves alike. It declined after Christianity rose but was revived during the Renaissance. It directly inspired modern CBT.',
    coreTenets: [
      'Dichotomy of control',
      'Virtue is the only good',
      'Amor fati',
      'Memento mori',
      'Premeditatio malorum'
    ],
    notableFigures: [
      NotableFigure(
          name: 'Marcus Aurelius',
          contribution: 'Roman emperor, author of Meditations.'),
      NotableFigure(
          name: 'Epictetus',
          contribution: 'Former slave, taught the Enchiridion.'),
      NotableFigure(
          name: 'Seneca', contribution: 'Statesman, wrote on time and anger.'),
    ],
    modernApplication:
        'Used in resilience training, leadership, and therapy. The daily journal of Marcus Aurelius is a proven self-coaching tool.',
    quotes: [
      '"You have power over your mind – not outside events. Realize this, and you will find strength." – Marcus Aurelius',
      '"It\'s not that we have a short time to live, but that we waste a great deal of it." – Seneca',
    ],
    keyWorks: ['Meditations', 'Enchiridion', 'Letters from a Stoic'],
    gradientColors: [Color(0xFFD4AF37), Color(0xFF8B7500)],
  ),

  IsmMeta(
    id: 'existentialism',
    name: 'Existentialism',
    icon: '🎭',
    tagline: 'Existence precedes essence — create your own meaning.',
    description:
        '20th-century movement declaring we are radically free and responsible for giving our lives meaning.',
    challenge:
        'Make one decision today purely because you choose it, not because it\'s expected.',
    weeklyChallenge:
        'List 5 things you do from obligation, then write what you\'d do if you were the only person on earth.',
    category: 'meaning_existence',
    visualStyle: ArtStyle.existential,
    overview:
        'Existentialism begins with the idea that humans have no fixed nature; we define ourselves through our actions. This freedom brings anxiety, but also the possibility of authenticity. Key thinkers: Kierkegaard, Nietzsche, Sartre, Camus, de Beauvoir. Camus\'s "absurd" is the tension between our search for meaning and the universe\'s silence — his answer: revolt and embrace life anyway.',
    historicalContext:
        'It emerged after WWII, reflecting the collapse of traditional values and the horrors of totalitarianism. Parisian cafés became its intellectual centres.',
    coreTenets: [
      'Radical freedom',
      'Authenticity',
      'Responsibility',
      'Anguish of choice',
      'The Absurd'
    ],
    notableFigures: [
      NotableFigure(
          name: 'Jean-Paul Sartre',
          contribution: 'Philosopher of freedom; Being and Nothingness.'),
      NotableFigure(
          name: 'Simone de Beauvoir',
          contribution: 'Existentialist philosopher; The Second Sex.'),
      NotableFigure(
          name: 'Albert Camus',
          contribution: 'Absurdist; The Myth of Sisyphus.'),
      NotableFigure(
          name: 'Søren Kierkegaard',
          contribution: 'Father of existentialism; anxiety and faith.'),
      NotableFigure(
          name: 'Friedrich Nietzsche',
          contribution: 'Will to power and self-overcoming.'),
    ],
    modernApplication:
        'Existential therapy helps people confront freedom and create personal meaning. In daily life, it\'s a call to stop living on autopilot.',
    quotes: [
      '"Man is condemned to be free." – Sartre',
      '"One must imagine Sisyphus happy." – Camus',
    ],
    keyWorks: ['Being and Nothingness', 'The Myth of Sisyphus', 'Either/Or'],
    gradientColors: [Color(0xFF7F8C8D), Color(0xFF2C3E50)],
  ),

  IsmMeta(
    id: 'nihilism',
    name: 'Nihilism',
    icon: '🕳️',
    tagline: 'Nothing has inherent meaning — and that\'s freeing.',
    description:
        'The belief that life lacks objective purpose, truth, or value. It can lead to despair or liberation.',
    challenge:
        'Question one "truth" you\'ve always accepted. Does it really hold up?',
    weeklyChallenge:
        'Pick a societal rule you follow blindly. Examine why — and whether it still makes sense.',
    category: 'meaning_existence',
    visualStyle: ArtStyle.existential,
    overview:
        'Nihilism argues that traditional values and beliefs are unfounded. Nietzsche used the concept of "God is dead" to describe the collapse of absolute morality. While often seen as pessimistic, nihilism can also clear the ground for creating personal values. Existentialists used it as a starting point to build meaning.',
    historicalContext:
        'Grew from the crisis of Enlightenment reason and the decline of religion in the 19th century. Russian nihilists of the 1860s influenced revolutionary movements.',
    coreTenets: [
      'No objective meaning',
      'Morality is constructed',
      'Truth is perspectival',
      'Freedom from metaphysical illusions'
    ],
    notableFigures: [
      NotableFigure(
          name: 'Friedrich Nietzsche',
          contribution: 'Explored the death of God and the will to power.'),
      NotableFigure(
          name: 'Ivan Turgenev',
          contribution: 'Popularised the term in Fathers and Sons.'),
    ],
    modernApplication:
        'Used in existential therapy to help people dismantle limiting beliefs. It encourages radical honesty about what we value.',
    quotes: [
      '"God is dead. God remains dead. And we have killed him." – Nietzsche',
      '"If nothing we do matters, then all that matters is what we do." – Joss Whedon',
    ],
    keyWorks: ['The Will to Power', 'Fathers and Sons'],
    gradientColors: [Color(0xFF2C3E50), Color(0xFF1A1A1A)],
  ),

  IsmMeta(
    id: 'absurdism',
    name: 'Absurdism',
    icon: '🎪',
    tagline: 'Seek meaning in a meaningless universe — and laugh.',
    description:
        'The philosophy that humans crave meaning, but the universe offers none — and the best response is to embrace the absurd with joy and revolt.',
    challenge:
        'Do something today that has no practical purpose, purely for the experience.',
    weeklyChallenge:
        'Every evening this week, write one moment that felt absurd and how you could laugh at it.',
    category: 'meaning_existence',
    visualStyle: ArtStyle.existential,
    overview:
        'Albert Camus defined the Absurd as the clash between our need for meaning and the universe\'s silence. He rejected suicide (both physical and philosophical) and argued for revolt — living fully in the face of absurdity, like Sisyphus pushing his rock. His novels The Stranger and The Plague illustrate this lucid acceptance.',
    historicalContext:
        'Camus developed absurdism in the 1940s, influenced by WWII and the collapse of European humanism. He broke with Sartre over political violence.',
    coreTenets: [
      'The Absurd',
      'Revolt',
      'Freedom',
      'Passion',
      'Don\'t hope, act'
    ],
    notableFigures: [
      NotableFigure(
          name: 'Albert Camus',
          contribution: 'French Algerian writer, Nobel laureate.'),
    ],
    modernApplication:
        'Absurdism helps people accept uncertainty and find lightness in dark times. It\'s an antidote to perfectionism and existential dread.',
    quotes: [
      '"One must imagine Sisyphus happy." – Camus',
      '"In the depths of winter, I finally learned that within me there lay an invincible summer." – Camus',
    ],
    keyWorks: ['The Myth of Sisyphus', 'The Stranger', 'The Plague'],
    gradientColors: [Color(0xFFBF5AF2), Color(0xFF5E5CE6)],
  ),

  IsmMeta(
    id: 'humanism',
    name: 'Humanism',
    icon: '🤝',
    tagline: 'Reason, compassion, and human potential come first.',
    description:
        'A worldview centred on human values and agency. It emphasises ethics, science, and the inherent worth of every person.',
    challenge:
        'Perform an act of kindness today with no expectation of reward.',
    weeklyChallenge:
        'Read one article about a scientific or ethical breakthrough and reflect on how it improves human life.',
    category: 'meaning_existence',
    visualStyle: ArtStyle.relations,
    overview:
        'Humanism has roots in Renaissance thinkers like Petrarch and Erasmus, but modern secular humanism arose in the 19th-20th centuries. It asserts that humans can live ethical, fulfilling lives based on reason and empathy. It champions human rights, democracy, and education.',
    historicalContext:
        'The Enlightenment (18th century) laid the groundwork with ideals of liberty and progress. Organised humanism grew in the 20th century as an alternative to dogmatic ideologies.',
    coreTenets: [
      'Human dignity',
      'Reason and science',
      'Compassion',
      'Secular ethics',
      'Personal fulfilment'
    ],
    notableFigures: [
      NotableFigure(
          name: 'Erasmus',
          contribution:
              'Renaissance scholar, promoted education and tolerance.'),
      NotableFigure(
          name: 'Carl Sagan',
          contribution:
              'Astronomer, advocated for scientific wonder and humanism.'),
      NotableFigure(
          name: 'Martha Nussbaum',
          contribution:
              'Philosopher, capabilities approach to human development.'),
    ],
    modernApplication:
        'Humanism underpins universal human rights, secular democracy, and modern education. It encourages critical thinking and empathy in daily life.',
    quotes: [
      '"The good life is one inspired by love and guided by knowledge." – Bertrand Russell',
      '"For small creatures such as we the vastness is bearable only through love." – Carl Sagan',
    ],
    keyWorks: [
      'The Demon-Haunted World (Sagan)',
      'Frontiers of Justice (Nussbaum)'
    ],
    gradientColors: [Color(0xFF4A90D9), Color(0xFF2ECC71)],
  ),

  IsmMeta(
    id: 'fatalism',
    name: 'Fatalism',
    icon: '🕸️',
    tagline: 'What will be, will be — accept the inevitable.',
    description:
        'The belief that all events are predetermined and unavoidable. Freedom lies in accepting fate, not fighting it.',
    challenge:
        'Let go of one outcome you\'re desperately trying to control. Trust the process.',
    weeklyChallenge:
        'Notice how often you say "should" — replace it with "could" and observe the shift.',
    category: 'meaning_existence',
    visualStyle: ArtStyle.reason,
    overview:
        'Fatalism appears in many cultures, from ancient Greek tragedies to Islamic theology. It teaches that human will cannot change what is fated. While often seen as passive, it can bring profound peace — if the outcome is fixed, anxiety about it is pointless. Stoicism shares some of this perspective but adds personal responsibility for one\'s judgments.',
    historicalContext:
        'Fatalistic ideas appear in the Norse concept of "wyrd", in Calvinist predestination, and in the Muslim concept of "maktub" (it is written).',
    coreTenets: [
      'Events are determined',
      'Resistance is futile',
      'Acceptance brings peace',
      'Focus on the present moment'
    ],
    notableFigures: [
      NotableFigure(
          name: 'Sophocles',
          contribution:
              'Greek tragedian; Oedipus Rex illustrates inescapable fate.'),
      NotableFigure(
          name: 'Omar Khayyám',
          contribution:
              'Persian poet; his Rubaiyat reflects fatalistic themes.'),
    ],
    modernApplication:
        'Acceptance and Commitment Therapy (ACT) incorporates fatalistic elements — accepting what you cannot change and committing to valued action.',
    quotes: [
      '"The moving finger writes; and, having writ, moves on." – Omar Khayyám',
      '"It is what it is." – modern proverb',
    ],
    keyWorks: ['Oedipus Rex', 'Rubaiyat of Omar Khayyám'],
    gradientColors: [Color(0xFF8E44AD), Color(0xFF2C3E50)],
  ),

  // ── Self & Society ───────────────────────────────────────────────────────

  IsmMeta(
    id: 'individualism',
    name: 'Individualism',
    icon: '🧍',
    tagline: 'Your own path above all else.',
    description:
        'Prioritising personal freedom, self-reliance, and independence over collective or state control.',
    challenge:
        'Make a choice today based solely on your own values, ignoring others\' opinions.',
    weeklyChallenge:
        'For one week, start each day by asking: "What do I truly want?" and act on it once.',
    category: 'self_society',
    visualStyle: ArtStyle.creativity,
    overview:
        'Individualism champions the moral worth of the individual. It emerged strongly during the Enlightenment and was central to liberal democracy. Thinkers like John Locke argued that individuals have inalienable rights and that society should serve the individual, not the other way around.',
    historicalContext:
        'The Renaissance celebrated individual genius; the Enlightenment proclaimed natural rights; the American Revolution was built on individual liberty.',
    coreTenets: [
      'Personal autonomy',
      'Self-reliance',
      'Freedom of thought',
      'Individual rights',
      'Non-conformity'
    ],
    notableFigures: [
      NotableFigure(
          name: 'John Locke',
          contribution:
              'Philosopher of natural rights and government by consent.'),
      NotableFigure(
          name: 'Ralph Waldo Emerson',
          contribution: 'American transcendentalist; urged self-reliance.'),
      NotableFigure(
          name: 'John Stuart Mill',
          contribution: 'On Liberty; the harm principle.'),
    ],
    modernApplication:
        'Individualism supports entrepreneurship, creative expression, and personal growth. It warns against groupthink and conformity.',
    quotes: [
      '"To be yourself in a world that is constantly trying to make you something else is the greatest accomplishment." – Emerson',
      '"The only freedom which deserves the name is that of pursuing our own good in our own way." – Mill',
    ],
    keyWorks: ['Self-Reliance (Emerson)', 'On Liberty (Mill)'],
    gradientColors: [Color(0xFFE91E63), Color(0xFF9C27B0)],
  ),

  IsmMeta(
    id: 'collectivism',
    name: 'Collectivism',
    icon: '🤲',
    tagline: 'We rise together.',
    description:
        'The belief that the needs and goals of the community take precedence over individual desires.',
    challenge:
        'Do something today that benefits your group without seeking personal credit.',
    weeklyChallenge:
        'Identify one way your community could be improved and take one step towards it.',
    category: 'self_society',
    visualStyle: ArtStyle.relations,
    overview:
        'Collectivism emphasises social harmony, cooperation, and shared responsibility. It is foundational to many indigenous cultures and Eastern philosophies. It ranges from democratic community organising to traditional familial duty.',
    historicalContext:
        'Tribal societies operated collectively for survival. Confucianism stressed familial and social duties. Modern welfare states blend individual rights with collective responsibility.',
    coreTenets: [
      'Common good',
      'Social solidarity',
      'Cooperation',
      'Shared responsibility',
      'Duty to the community'
    ],
    notableFigures: [
      NotableFigure(
          name: 'Confucius',
          contribution:
              'Chinese sage; emphasised filial piety and social harmony.'),
      NotableFigure(
          name: 'Martin Luther King Jr.',
          contribution: 'Civil rights leader; beloved community.'),
    ],
    modernApplication:
        'Collectivist values drive public healthcare, community organising, and mutual aid. They remind us that no one thrives alone.',
    quotes: [
      '"Do not do to others what you do not want done to yourself." – Confucius',
      '"We must learn to live together as brothers or perish together as fools." – Martin Luther King Jr.',
    ],
    keyWorks: ['Analects of Confucius'],
    gradientColors: [Color(0xFF2ECC71), Color(0xFF1ABC9C)],
  ),

  IsmMeta(
    id: 'minimalism',
    name: 'Minimalism',
    icon: '🪴',
    tagline: 'Less is more.',
    description:
        'A lifestyle and philosophy that advocates owning fewer possessions, reducing distractions, and focusing on what truly matters.',
    challenge:
        'Remove one physical item from your space that you haven\'t used in a month.',
    weeklyChallenge:
        'Do a digital detox for one evening — no screens, just presence.',
    category: 'self_society',
    visualStyle: ArtStyle.mindfulness,
    overview:
        'Minimalism as a philosophy draws from Stoic simplicity, Zen aesthetics, and modern anti-consumerism. It\'s not about deprivation but about intentionality — keeping only what adds value. The tiny-house movement, Marie Kondo\'s tidying, and digital minimalism are all expressions of this ism.',
    historicalContext:
        'Ancient Cynics like Diogenes lived with almost nothing. Thoreau\'s Walden celebrated simple living. In the 20th century, the minimal art movement stripped away excess.',
    coreTenets: [
      'Intentional ownership',
      'Value experience over things',
      'Freedom from clutter',
      'Mindful consumption',
      'Quality over quantity'
    ],
    notableFigures: [
      NotableFigure(
          name: 'Diogenes',
          contribution:
              'Greek Cynic who lived with nothing and questioned everything.'),
      NotableFigure(
          name: 'Henry David Thoreau',
          contribution: 'American writer; lived simply at Walden Pond.'),
      NotableFigure(
          name: 'Marie Kondo',
          contribution: 'Japanese organising consultant; spark joy method.'),
    ],
    modernApplication:
        'Minimalism reduces stress, saves money, and helps focus on relationships and passions. It\'s a counter-balance to consumer culture.',
    quotes: [
      '"Simplify, simplify." – Thoreau',
      '"The secret of happiness is not found in seeking more, but in developing the capacity to enjoy less." – Socrates',
    ],
    keyWorks: ['Walden', 'The Life-Changing Magic of Tidying Up'],
    gradientColors: [Color(0xFFA5D6A7), Color(0xFF81C784)],
  ),

  IsmMeta(
    id: 'hedonism',
    name: 'Hedonism',
    icon: '🍇',
    tagline: 'Pleasure is the highest good.',
    description:
        'The ethical theory that pleasure (broadly defined) is the ultimate goal of life. Can range from refined Epicurean enjoyment to wild indulgence.',
    challenge: 'Do something today purely for pleasure, without guilt.',
    weeklyChallenge:
        'Each evening, write down one moment of genuine pleasure and savour it.',
    category: 'self_society',
    visualStyle: ArtStyle.creativity,
    overview:
        'Hedonism originates with the ancient Greek Cyrenaics, who advocated immediate physical pleasure. Epicurus later refined it to mean the absence of pain (ataraxia) and simple pleasures. Positive psychology now studies happiness and well-being scientifically.',
    historicalContext:
        'Cyrenaics in 4th century BCE were the earliest hedonists. Epicurus built a community (The Garden) devoted to tranquil pleasure. In the 19th century, utilitarianism gave hedonism a social dimension.',
    coreTenets: [
      'Pleasure as intrinsic good',
      'Avoid pain',
      'Pursue happiness',
      'Moderation (Epicureanism)',
      'Joy is legitimate'
    ],
    notableFigures: [
      NotableFigure(
          name: 'Epicurus',
          contribution:
              'Greek philosopher of simple pleasures and friendship.'),
      NotableFigure(
          name: 'John Stuart Mill',
          contribution:
              'Refined the calculus, distinguishing higher and lower pleasures.'),
      NotableFigure(
          name: 'Martin Seligman',
          contribution: 'Positive psychology; the science of flourishing.'),
    ],
    modernApplication:
        'Positive psychology studies happiness and well-being. Hedonism reminds us that joy is a legitimate pursuit, not a distraction from productivity.',
    quotes: [
      '"Pleasure is the beginning and the end of living happily." – Epicurus',
      '"It is better to be a human being dissatisfied than a pig satisfied." – John Stuart Mill',
    ],
    keyWorks: [
      'Principia Ethica',
      'Utilitarianism',
      'Authentic Happiness (Seligman)'
    ],
    gradientColors: [Color(0xFFFFC107), Color(0xFFFF5722)],
  ),

  IsmMeta(
    id: 'asceticism',
    name: 'Asceticism',
    icon: '🧘',
    tagline: 'Renounce comfort to gain strength.',
    description:
        'A lifestyle characterised by abstinence from sensual pleasures, often for spiritual or self-mastery goals.',
    challenge:
        'Skip one comfort today (your favourite snack, warm shower) and observe your mind\'s reaction.',
    weeklyChallenge:
        'Fast from something you use daily (social media, sugar) for 24 hours.',
    category: 'self_society',
    visualStyle: ArtStyle.discipline,
    overview:
        'Ascetic practices are found in almost every tradition: Christian monasticism, Buddhist monkhood, Hindu sadhus, and Stoic self-denial. The aim is to transcend bodily desires and achieve a higher state of consciousness or moral purity. It\'s also used in modern physical training to forge mental toughness.',
    historicalContext:
        'Early Christian hermits in the Egyptian desert (3rd-4th century) are the classic ascetics. The Buddha practised extreme asceticism before advocating the Middle Way. Jain monks follow strict non-possessiveness.',
    coreTenets: [
      'Self-discipline',
      'Detachment from material things',
      'Simplicity',
      'Spiritual focus',
      'Overcoming desire'
    ],
    notableFigures: [
      NotableFigure(
          name: 'Siddhartha Gautama (Buddha)',
          contribution: 'Practised asceticism before finding the Middle Way.'),
      NotableFigure(
          name: 'Saint Anthony the Great',
          contribution: 'Father of Christian monasticism.'),
      NotableFigure(
          name: 'Mahatma Gandhi',
          contribution:
              'Used fasting and simplicity as political and spiritual tools.'),
    ],
    modernApplication:
        'Intermittent fasting, digital detoxes, and cold showers are secular forms of asceticism. They build willpower and clarity.',
    quotes: [
      '"Fasting of the body is food for the soul." – Saint John Chrysostom',
      '"The body must be disciplined if the mind is to be free." – Plato',
    ],
    keyWorks: ['The Sayings of the Desert Fathers', 'The Dhammapada'],
    gradientColors: [Color(0xFF8D6E63), Color(0xFF5D4037)],
  ),

  IsmMeta(
    id: 'pragmatism',
    name: 'Pragmatism',
    icon: '🔧',
    tagline: 'What works is true.',
    description:
        'A philosophical tradition that evaluates theories and beliefs by their practical consequences — truth is what proves useful.',
    challenge:
        'Take one problem and try the simplest solution. Judge it only by the result.',
    weeklyChallenge:
        'Track one area where you overcomplicate things; replace with a practical, testable step.',
    category: 'self_society',
    visualStyle: ArtStyle.reason,
    overview:
        'Pragmatism emerged in the late 19th-century United States with Charles Sanders Peirce, William James, and John Dewey. They rejected abstract metaphysical debates and focused on the practical effects of ideas. A belief is true if it works, if it helps us navigate the world effectively.',
    historicalContext:
        'A reaction against European rationalism and idealism, pragmatism was uniquely American — democratic, experimental, and forward-looking.',
    coreTenets: [
      'Truth is what works',
      'Ideas are tools',
      'Anti-absolutism',
      'Experimental method',
      'Fallibilism'
    ],
    notableFigures: [
      NotableFigure(
          name: 'William James',
          contribution: 'Psychologist, philosopher; wrote Pragmatism.'),
      NotableFigure(
          name: 'John Dewey',
          contribution: 'Educational reformer; learning by doing.'),
      NotableFigure(
          name: 'Richard Rorty',
          contribution: 'Neopragmatist; anti-foundationalism.'),
    ],
    modernApplication:
        'Pragmatism underlies agile project management, design thinking, and the scientific method. It encourages flexibility and learning from failure.',
    quotes: [
      '"The true is only the expedient in our way of thinking." – William James',
      '"Believe that life is worth living and your belief will help create the fact." – William James',
    ],
    keyWorks: ['Pragmatism (James)', 'Democracy and Education (Dewey)'],
    gradientColors: [Color(0xFF607D8B), Color(0xFF455A64)],
  ),

  // ── Mental & Emotional Approaches ────────────────────────────────────────

  IsmMeta(
    id: 'optimism',
    name: 'Optimism',
    icon: '🌞',
    tagline: 'Expect good things.',
    description:
        'The disposition to expect the best possible outcome, and to see the glass as half full.',
    challenge:
        'Reframe one negative event today by finding a genuine silver lining.',
    weeklyChallenge:
        'Start a gratitude journal — write three good things each night.',
    category: 'mental_emotional',
    visualStyle: ArtStyle.mindfulness,
    overview:
        'Optimism is both a psychological trait and a philosophical stance. Positive psychology (Martin Seligman) studies learned optimism, showing it improves health and resilience. However, unchecked optimism can become denial — the goal is realistic, grounded hope.',
    historicalContext:
        'The Enlightenment promoted progress and human perfectibility. The 20th century\'s horrors challenged naïve optimism, but research now supports "realistic optimism".',
    coreTenets: [
      'Positive expectation',
      'Gratitude',
      'Resilience',
      'Hope',
      'Focus on solutions'
    ],
    notableFigures: [
      NotableFigure(
          name: 'Martin Seligman',
          contribution: 'Founder of positive psychology; learned optimism.'),
      NotableFigure(
          name: 'Viktor Frankl',
          contribution: 'Found hope even in the worst conditions.'),
      NotableFigure(
          name: 'Norman Vincent Peale',
          contribution: 'Author of The Power of Positive Thinking.'),
    ],
    modernApplication:
        'Optimism training is used in therapy, sports, and business to boost performance and well-being.',
    quotes: [
      '"Keep your face always toward the sunshine – and shadows will fall behind you." – Walt Whitman',
      '"Optimism is the faith that leads to achievement." – Helen Keller',
    ],
    keyWorks: ['Learned Optimism', 'The Power of Positive Thinking'],
    gradientColors: [Color(0xFFFFEB3B), Color(0xFFFF9800)],
  ),

  IsmMeta(
    id: 'pessimism',
    name: 'Pessimism',
    icon: '🌧️',
    tagline: 'Expect the worst, you\'ll never be disappointed.',
    description:
        'A worldview that emphasises the negative aspects of existence, often seeing suffering as fundamental.',
    challenge:
        'Identify one area where your pessimism is actually protecting you. Thank it, then take a small risk.',
    weeklyChallenge:
        'Practise "defensive pessimism": mentally rehearse worst-case scenarios, then plan how to handle them.',
    category: 'mental_emotional',
    visualStyle: ArtStyle.existential,
    overview:
        'Philosophical pessimism is articulated by Schopenhauer, who saw life as endless striving and suffering. However, pessimism can serve as a coping mechanism — by expecting the worst, you are rarely surprised and can prepare more effectively. Defensive pessimism is a legitimate psychological strategy.',
    historicalContext:
        'Schopenhauer\'s The World as Will and Representation (1818) is a cornerstone. Pessimism influenced existentialism and later writers like Samuel Beckett.',
    coreTenets: [
      'Suffering is inevitable',
      'Low expectations reduce disappointment',
      'Acceptance of darkness',
      'Cautious preparation'
    ],
    notableFigures: [
      NotableFigure(
          name: 'Arthur Schopenhauer',
          contribution: 'German philosopher of the will and suffering.'),
      NotableFigure(
          name: 'Emil Cioran',
          contribution: 'Romanian aphorist; explored despair and nihilism.'),
    ],
    modernApplication:
        'Defensive pessimism is a strategy used by anxious individuals to reduce anxiety and improve performance by planning for the worst.',
    quotes: [
      '"Life swings like a pendulum backward and forward between pain and boredom." – Schopenhauer',
      '"The fact that life has no meaning is a reason to live." – Cioran',
    ],
    keyWorks: [
      'The World as Will and Representation',
      'The Trouble with Being Born'
    ],
    gradientColors: [Color(0xFF37474F), Color(0xFF263238)],
  ),

  IsmMeta(
    id: 'cynicism',
    name: 'Cynicism',
    icon: '🐕',
    tagline: 'Question everything — especially authority.',
    description:
        'A school of thought that rejects social conventions and materialism, advocating a simple, virtuous life in accordance with nature.',
    challenge:
        'Challenge one social norm today (politely) that you find hypocritical.',
    weeklyChallenge:
        'For one week, question the motives behind every advertisement, news headline, or corporate statement you encounter.',
    category: 'mental_emotional',
    visualStyle: ArtStyle.creativity,
    overview:
        'Ancient Cynicism (Diogenes, Crates) was a radical philosophy of simplicity and shamelessness. They lived on the streets to expose the artificiality of Greek society. Modern cynicism has evolved into a general distrust of others\' sincerity. While too much cynicism can be corrosive, a healthy dose is a defence against manipulation.',
    historicalContext:
        'Diogenes the Cynic (4th century BCE) famously told Alexander the Great to step out of his light. The movement influenced Stoicism and later satirists.',
    coreTenets: [
      'Reject social conventions',
      'Live simply',
      'Shameless honesty',
      'Critique of power',
      'Self-sufficiency'
    ],
    notableFigures: [
      NotableFigure(
          name: 'Diogenes of Sinope',
          contribution: 'Founder of Cynicism; lived radically simply.'),
      NotableFigure(
          name: 'Oscar Wilde',
          contribution:
              'Writer; embodied cynical wit against Victorian hypocrisy.'),
    ],
    modernApplication:
        'Cynicism fuels investigative journalism, satire, and critical thinking. It helps keep power in check.',
    quotes: [
      '"I am a citizen of the world." – Diogenes',
      '"The cynic knows the price of everything and the value of nothing." – Oscar Wilde',
    ],
    keyWorks: [
      'Lives of Eminent Philosophers (Diogenes Laertius)',
      'The Picture of Dorian Gray'
    ],
    gradientColors: [Color(0xFF66BB6A), Color(0xFF388E3C)],
  ),

  IsmMeta(
    id: 'romanticism',
    name: 'Romanticism',
    icon: '🌹',
    tagline: 'Follow your heart, not your head.',
    description:
        'An artistic and philosophical movement that elevates emotion, imagination, and individual experience over cold reason.',
    challenge:
        'Express a feeling today through art, music, or writing — without judging the result.',
    weeklyChallenge:
        'Spend an hour in nature with no phone, just observing and feeling.',
    category: 'mental_emotional',
    visualStyle: ArtStyle.creativity,
    overview:
        'Romanticism began in the late 18th century as a reaction against the Industrial Revolution and Enlightenment rationalism. Poets like Wordsworth, Keats, and Goethe celebrated nature, passion, and the sublime. It influenced the Gothic novel and a deep reverence for inner life.',
    historicalContext:
        'Originating in Germany (Sturm und Drang) and Britain, Romanticism spread across Europe. Figures like Beethoven and Delacroix embodied its spirit in music and painting.',
    coreTenets: [
      'Emotion over reason',
      'Worship of nature',
      'Individual genius',
      'The sublime',
      'Imagination as creative force'
    ],
    notableFigures: [
      NotableFigure(
          name: 'William Wordsworth',
          contribution:
              'English poet; defined poetry as "emotion recollected in tranquillity".'),
      NotableFigure(
          name: 'Lord Byron',
          contribution: 'Romantic hero; lived passionately and rebelliously.'),
      NotableFigure(
          name: 'Caspar David Friedrich',
          contribution: 'Painter of sublime landscapes.'),
    ],
    modernApplication:
        'Romantic ideals fuel self-expression, authenticity, and the appreciation of beauty. They remind us that not everything valuable can be measured.',
    quotes: [
      '"The heart has its reasons which reason knows nothing of." – Pascal',
      '"Nature never did betray the heart that loved her." – Wordsworth',
    ],
    keyWorks: ['Lyrical Ballads', 'Faust (Goethe)'],
    gradientColors: [Color(0xFFE91E63), Color(0xFF9C27B0)],
  ),

  IsmMeta(
    id: 'realism',
    name: 'Realism',
    icon: '👁️',
    tagline: 'See things as they are, not as you wish.',
    description:
        'A commitment to representing reality truthfully, without idealisation. In philosophy, it\'s the belief that the external world exists independently of perception.',
    challenge:
        'Describe a situation today using only observable facts, no interpretations.',
    weeklyChallenge:
        'At the end of each day, write a "just the facts" summary of what happened, stripping out all emotional language.',
    category: 'mental_emotional',
    visualStyle: ArtStyle.reason,
    overview:
        'Philosophical realism asserts that objects exist mind-independently. In art and literature, realism (Flaubert, Ibsen) depicted everyday life without romantic gloss. In politics, realism focuses on power and human nature as it is, not as it should be.',
    historicalContext:
        'Realism in literature emerged in 19th-century France as a response to Romanticism. Political realism was crystallised by Thucydides and later by Hans Morgenthau.',
    coreTenets: [
      'Objective reality exists',
      'Honest observation',
      'Reject idealisation',
      'Focus on evidence',
      'Truth before comfort'
    ],
    notableFigures: [
      NotableFigure(
          name: 'Gustave Flaubert',
          contribution:
              'French novelist; wrote Madame Bovary, a realist masterpiece.'),
      NotableFigure(
          name: 'Niccolò Machiavelli',
          contribution: 'Political realist; author of The Prince.'),
      NotableFigure(
          name: 'Thucydides',
          contribution: 'Ancient Greek historian; analysed power politics.'),
    ],
    modernApplication:
        'Realism helps in decision-making by confronting uncomfortable truths. It\'s the basis of evidence-based medicine and policy.',
    quotes: [
      '"Facts are stubborn things." – John Adams',
      '"See things as they are, not as you fear or hope they might be." – Marcus Aurelius (paraphrase)',
    ],
    keyWorks: ['The Prince', 'Madame Bovary'],
    gradientColors: [Color(0xFF607D8B), Color(0xFF37474F)],
  ),

  // ── Spiritual / Eastern Approaches ───────────────────────────────────────

  IsmMeta(
    id: 'buddhism',
    name: 'Buddhism',
    icon: '☸️',
    tagline: 'Suffering ends through mindfulness and detachment.',
    description:
        'A spiritual tradition founded by Siddhartha Gautama, teaching that suffering arises from attachment and can be overcome through the Eightfold Path.',
    challenge:
        'Practise mindfulness for five minutes: simply observe your breath without trying to change it.',
    weeklyChallenge:
        'Each morning, set an intention for the day rooted in compassion.',
    category: 'spiritual_eastern',
    visualStyle: ArtStyle.mindfulness,
    overview:
        'Buddhism\'s core insight is the Four Noble Truths: life involves suffering (dukkha); suffering comes from craving; suffering can end (nirvana); the Eightfold Path leads to liberation. It emphasises meditation, ethical conduct, and wisdom. It\'s less a religion of worship and more a practical psychology.',
    historicalContext:
        'Founded in 5th-6th century BCE in India. It spread across Asia, adapting to local cultures. Today, mindfulness practices derived from Buddhism are mainstream in the West.',
    coreTenets: [
      'Four Noble Truths',
      'Eightfold Path',
      'Impermanence (anicca)',
      'Non-self (anatta)',
      'Compassion (karuna)'
    ],
    notableFigures: [
      NotableFigure(
          name: 'Siddhartha Gautama', contribution: 'The historical Buddha.'),
      NotableFigure(
          name: 'Thich Nhat Hanh',
          contribution: 'Vietnamese Zen master; popularised mindfulness.'),
      NotableFigure(
          name: 'Dalai Lama',
          contribution: 'Tibetan Buddhist leader; advocate of compassion.'),
    ],
    modernApplication:
        'Mindfulness-Based Stress Reduction (MBSR) is used in hospitals and corporations. Meditation improves focus and emotional regulation.',
    quotes: [
      '"Peace comes from within. Do not seek it without." – Buddha',
      '"The present moment is the only time over which we have dominion." – Thich Nhat Hanh',
    ],
    keyWorks: ['The Dhammapada', 'The Heart of the Buddha\'s Teaching'],
    gradientColors: [Color(0xFFFFA726), Color(0xFFF57C00)],
  ),

  IsmMeta(
    id: 'taoism',
    name: 'Taoism',
    icon: '☯️',
    tagline: 'Flow with the Tao — the way of nature.',
    description:
        'An ancient Chinese philosophy teaching harmony with the Tao (the Way), simplicity, and effortless action (wu wei).',
    challenge:
        'Today, do one thing without forcing it — allow it to unfold naturally.',
    weeklyChallenge:
        'Spend time in nature each day, observing the effortless flow of water, wind, or plants.',
    category: 'spiritual_eastern',
    visualStyle: ArtStyle.mindfulness,
    overview:
        'Taoism originates with Laozi and Zhuangzi. The Tao Te Ching emphasises humility, flexibility, and the power of softness. Wu wei (non-action) means acting in alignment with the natural order, not straining against it.',
    historicalContext:
        'Developed during the Warring States period (6th-4th century BCE) as a counter to Confucian rigidity. It later merged with Buddhism and folk religion.',
    coreTenets: [
      'The Tao is ineffable',
      'Wu wei (effortless action)',
      'Simplicity',
      'Harmony with nature',
      'Relativity of opposites'
    ],
    notableFigures: [
      NotableFigure(
          name: 'Laozi', contribution: 'Legendary author of the Tao Te Ching.'),
      NotableFigure(
          name: 'Zhuangzi',
          contribution: 'Philosopher of relativity and spontaneity.'),
      NotableFigure(
          name: 'Alan Watts',
          contribution:
              '20th-century populariser of Eastern philosophy in the West.'),
    ],
    modernApplication:
        'Taoist principles are used in stress reduction and leadership. It encourages going with the flow.',
    quotes: [
      '"The journey of a thousand miles begins with a single step." – Laozi',
      '"When nothing is done, nothing is left undone." – Laozi',
    ],
    keyWorks: ['Tao Te Ching', 'Zhuangzi'],
    gradientColors: [Color(0xFF66BB6A), Color(0xFF2E7D32)],
  ),

  IsmMeta(
    id: 'confucianism',
    name: 'Confucianism',
    icon: '📜',
    tagline: 'Order through virtue and respect.',
    description:
        'A Chinese ethical and philosophical system emphasising morality, family loyalty, social harmony, and the cultivation of character.',
    challenge:
        'Show extra respect to an elder or mentor today — listen deeply.',
    weeklyChallenge:
        'Practise one of the "Five Constants" each day: benevolence, righteousness, propriety, wisdom, faithfulness.',
    category: 'spiritual_eastern',
    visualStyle: ArtStyle.reason,
    overview:
        'Confucius (Kongzi) taught that a well-ordered society starts with self-cultivation. The "superior person" (junzi) acts with integrity, filial piety, and ritual propriety. Confucianism shaped East Asian governance, education, and family structures for over two millennia.',
    historicalContext:
        'Confucius lived during the chaotic Spring and Autumn period (6th-5th century BCE). His ideas were compiled in the Analects. Later, Mencius and Xunzi expanded the philosophy.',
    coreTenets: [
      'Ren (benevolence)',
      'Li (ritual propriety)',
      'Yi (righteousness)',
      'Zhi (wisdom)',
      'Xin (integrity)'
    ],
    notableFigures: [
      NotableFigure(
          name: 'Confucius',
          contribution: 'Founder; teachings collected in the Analects.'),
      NotableFigure(
          name: 'Mencius',
          contribution:
              'Believed human nature is good; emphasised benevolent governance.'),
      NotableFigure(
          name: 'Xunzi',
          contribution:
              'Argued human nature must be shaped; education is crucial.'),
    ],
    modernApplication:
        'Confucian values offer a model of ethical leadership based on virtue, not fear. They underpin a deep respect for learning and character development.',
    quotes: [
      '"Do not do to others what you do not want done to yourself." – Confucius',
      '"The man who moves a mountain begins by carrying away small stones." – Confucius',
    ],
    keyWorks: ['The Analects', 'Mencius'],
    gradientColors: [Color(0xFFD32F2F), Color(0xFFB71C1C)],
  ),

  // ── New Isms: Personal Growth & Inner Philosophy ──────────────────────────

  IsmMeta(
    id: 'virtue_ethics',
    name: 'Virtue Ethics',
    icon: '⚡',
    tagline: 'You are not what you feel — you are what you repeatedly do.',
    description:
        'An ancient Greek approach to living well: develop strong character, and the good life follows.',
    challenge:
        'Identify one virtue you want to strengthen today — courage, patience, honesty. Act on it once, intentionally.',
    weeklyChallenge:
        'Choose one virtue to practise deliberately every day this week. At the end, journal what shifted.',
    category: 'ethics_morality',
    visualStyle: ArtStyle.discipline,
    overview:
        'Aristotle argued that happiness (eudaimonia) isn\'t a feeling — it\'s a way of living. Virtues like courage, honesty, and compassion are habits built through repetition. You aren\'t born brave; you become brave by doing brave things. Virtue Ethics asks not "what should I do?" but "what kind of person should I become?"',
    historicalContext:
        'Rooted in Aristotle\'s Nicomachean Ethics (350 BCE). Revived in the 20th century by Alasdair MacIntyre and Philippa Foot as an alternative to rule-based ethics.',
    coreTenets: [
      'Character over rules',
      'Eudaimonia (flourishing)',
      'Virtue is a habit',
      'The golden mean',
      'Community shapes character'
    ],
    notableFigures: [
      NotableFigure(
          name: 'Aristotle',
          contribution:
              'Nicomachean Ethics; the virtuous life as human flourishing.'),
      NotableFigure(
          name: 'Thomas Aquinas',
          contribution:
              'Integrated Aristotelian virtue into Christian ethics.'),
      NotableFigure(
          name: 'Alasdair MacIntyre',
          contribution:
              'After Virtue; revived the tradition for modern ethics.'),
    ],
    modernApplication:
        'When you are struggling, Virtue Ethics shifts the question from "why is this happening to me?" to "who do I want to be through this?"',
    quotes: [
      '"We are what we repeatedly do. Excellence, then, is not an act, but a habit." – Aristotle',
      '"Happiness depends upon ourselves." – Aristotle',
    ],
    keyWorks: ['Nicomachean Ethics', 'After Virtue'],
    gradientColors: [Color(0xFFFFB74D), Color(0xFFE65100)],
  ),

  IsmMeta(
    id: 'logotherapy',
    name: 'Logotherapy',
    icon: '🕯️',
    tagline: 'He who has a why can bear almost any how.',
    description:
        'A meaning-centred psychology developed by Viktor Frankl in the Nazi death camps. If you can find meaning, you can survive anything.',
    challenge:
        'Write one sentence answering: "What is the specific meaning that only I can give to this moment?"',
    weeklyChallenge:
        'Each morning this week, write one reason why today matters — not in general, but for you, specifically.',
    category: 'mental_emotional',
    visualStyle: ArtStyle.existential,
    overview:
        'Viktor Frankl survived Auschwitz by observing that prisoners who held onto meaning lived longer than those who gave up. He built Logotherapy on this: the primary human drive is not pleasure (Freud) or power (Adler) — it is meaning. Even in the worst circumstances, you can choose your attitude. The last human freedom is the freedom of response.',
    historicalContext:
        'Developed through Frankl\'s experience in concentration camps, 1941-1945. Frankl wrote Man\'s Search for Meaning from memory after liberation. It has sold over 16 million copies.',
    coreTenets: [
      'Will to meaning',
      'Freedom of response',
      'Meaning in suffering',
      'Responsibility',
      'Transcendence'
    ],
    notableFigures: [
      NotableFigure(
          name: 'Viktor Frankl',
          contribution:
              'Holocaust survivor; founded Logotherapy; Man\'s Search for Meaning.'),
      NotableFigure(
          name: 'Irvin Yalom',
          contribution:
              'Existential psychotherapist; extended Frankl\'s work.'),
    ],
    modernApplication:
        'When life feels pointless or crushing, Logotherapy doesn\'t tell you to feel better — it asks you to find a reason. That reason becomes the anchor everything else holds onto.',
    quotes: [
      '"He who has a why to live can bear almost any how." – Nietzsche (quoted by Frankl)',
      '"Everything can be taken from a man but one thing: the last of the human freedoms — to choose one\'s attitude." – Viktor Frankl',
    ],
    keyWorks: ['Man\'s Search for Meaning', 'The Will to Meaning'],
    gradientColors: [Color(0xFFCE93D8), Color(0xFF6A1B9A)],
  ),

  IsmMeta(
    id: 'epicureanism',
    name: 'Epicureanism',
    icon: '🍃',
    tagline: 'Simple pleasures. Deep friendship. Quiet contentment.',
    description:
        'An ancient Greek philosophy teaching that true happiness comes from friendship, tranquillity, and freedom from fear — not luxury or status.',
    challenge:
        'Identify one simple pleasure you\'ve been ignoring. Savour it fully today.',
    weeklyChallenge:
        'Have one slow, undistracted meal with someone you care about. No phones. Just conversation.',
    category: 'mental_emotional',
    visualStyle: ArtStyle.mindfulness,
    overview:
        'Often misread as pure hedonism, Epicurus actually taught ataraxia (tranquillity) and aponia (absence of pain) as the highest goods. He believed that the more you chase luxury and status, the more anxious you become. True pleasure is simple: good food, close friends, and a mind free from dread.',
    historicalContext:
        'Founded in Athens around 307 BCE. Epicurus and friends lived communally in "The Garden." Lucretius later spread Epicurean ideas through Rome in De Rerum Natura.',
    coreTenets: [
      'Ataraxia (tranquillity)',
      'Aponia (absence of pain)',
      'Friendship above all',
      'Freedom from fear',
      'Simple pleasures'
    ],
    notableFigures: [
      NotableFigure(
          name: 'Epicurus',
          contribution:
              'Founder; taught happiness through simple living and close friendship.'),
      NotableFigure(
          name: 'Lucretius',
          contribution: 'Roman poet; De Rerum Natura spread Epicurean ideas.'),
      NotableFigure(
          name: 'Thomas Jefferson',
          contribution:
              'Called himself an Epicurean; valued its practical ethics.'),
    ],
    modernApplication:
        'Epicureanism is a direct corrective to modern anxiety. When everything feels overwhelming, it asks: what do you actually need to feel okay? Usually less than you think.',
    quotes: [
      '"Do not spoil what you have by desiring what you have not." – Epicurus',
      '"Of all the means to insure happiness, the acquisition of friends is the most important." – Epicurus',
    ],
    keyWorks: ['Letter to Menoeceus', 'De Rerum Natura (Lucretius)'],
    gradientColors: [Color(0xFFA5D6A7), Color(0xFF1B5E20)],
  ),

  IsmMeta(
    id: 'wabi_sabi',
    name: 'Wabi-sabi',
    icon: '🪨',
    tagline: 'Beauty lives in the broken, the worn, and the impermanent.',
    description:
        'A Japanese aesthetic philosophy that finds beauty in imperfection, impermanence, and incompleteness — the very things we usually want to fix or hide.',
    challenge:
        'Find one "flaw" in yourself or your surroundings today. Look at it without judgment. Just notice it.',
    weeklyChallenge:
        'Each day this week, find beauty in something imperfect — a cracked mug, an unfinished thought, a moment that didn\'t go to plan.',
    category: 'mental_emotional',
    visualStyle: ArtStyle.mindfulness,
    overview:
        'Wabi-sabi is the Japanese art of finding beauty in the incomplete and impermanent. Wabi means "rustic simplicity." Sabi means "the beauty of age and wear." Together they describe an acceptance of the natural cycle: things are born, age, break, and return to nothing. Rather than something to resist, this is the texture of a real, lived life.',
    historicalContext:
        'Rooted in Japanese Zen Buddhism and tea ceremony culture, developed from the 15th century onwards. The tea master Sen no Rikyū made wabi-sabi central to the Japanese tea ceremony — imperfect, hand-made bowls were prized over perfect ones.',
    coreTenets: [
      'Impermanence',
      'Incompleteness',
      'Imperfection',
      'Simplicity',
      'Acceptance of transience'
    ],
    notableFigures: [
      NotableFigure(
          name: 'Sen no Rikyū',
          contribution:
              'Tea master who made wabi-sabi the heart of Japanese aesthetics.'),
      NotableFigure(
          name: 'Leonard Koren',
          contribution:
              'Wrote Wabi-Sabi for Artists, Designers, Poets & Philosophers.'),
    ],
    modernApplication:
        'Wabi-sabi is an antidote to perfectionism and social media pressure. You don\'t need to be healed, finished, or perfect. You just need to be real.',
    quotes: [
      '"In the beginner\'s mind there are many possibilities, but in the expert\'s mind there are few." – Shunryu Suzuki',
      '"Nothing lasts, nothing is finished, and nothing is perfect." – Wabi-sabi principle',
    ],
    keyWorks: ['Wabi-Sabi for Artists, Designers, Poets & Philosophers'],
    gradientColors: [Color(0xFFBCAAA4), Color(0xFF4E342E)],
  ),

  IsmMeta(
    id: 'ikigai',
    name: 'Ikigai',
    icon: '🌸',
    tagline: 'Your reason for getting up in the morning.',
    description:
        'A Japanese concept meaning "reason for being" — found at the intersection of what you love, what you\'re good at, what the world needs, and what sustains you.',
    challenge:
        'Write down one thing you did this week that gave you genuine energy. That\'s a thread toward your ikigai.',
    weeklyChallenge:
        'Complete the ikigai map: list what you love, what you\'re good at, what the world needs, and what you could earn from. Where do they overlap?',
    category: 'personal_growth',
    visualStyle: ArtStyle.mindfulness,
    overview:
        'Ikigai literally means "that which makes life worth living." Okinawa, Japan — home to more centenarians per capita than anywhere on Earth — has no word for retirement. People keep living with purpose. Research shows that having an ikigai is strongly correlated with longevity, mental health, and resilience.',
    historicalContext:
        'Okinawan cultural concept studied by Japanese geriatric psychiatrist Michiko Kamiya in the 1960s. Gained global attention through Héctor García and Francesc Miralles\'s 2016 book.',
    coreTenets: [
      'Purpose over happiness',
      'Small joys accumulate',
      'Flow states matter',
      'Long-term orientation',
      'Contribution to others'
    ],
    notableFigures: [
      NotableFigure(
          name: 'Michiko Kamiya',
          contribution:
              'First to study ikigai as a medical-psychological concept.'),
      NotableFigure(
          name: 'Héctor García',
          contribution:
              'Popularised ikigai globally through Ikigai: The Japanese Secret.'),
    ],
    modernApplication:
        'When you\'ve lost direction, ikigai offers a map. You don\'t need to find it all at once — just follow what energises you until the circles start to overlap.',
    quotes: [
      '"Only staying active will make you want to live a hundred years." – Japanese proverb',
      '"The purpose of life is a life of purpose." – Robert Byrne',
    ],
    keyWorks: ['Ikigai: The Japanese Secret to a Long and Happy Life'],
    gradientColors: [Color(0xFFF48FB1), Color(0xFFAD1457)],
  ),

  IsmMeta(
    id: 'rationalism',
    name: 'Rationalism',
    icon: '🧩',
    tagline: 'Your most powerful tool is already between your ears.',
    description:
        'A philosophical approach holding that reason and logical analysis are the path to truth — and to overcoming distorted thinking that holds us back.',
    challenge:
        'Take one fear making you anxious right now. Write it out. Test it: is this logical? What\'s the actual evidence?',
    weeklyChallenge:
        'Each morning, identify one assumption you\'re carrying. Ask: did I choose this belief, or did it just happen to me?',
    category: 'mental_emotional',
    visualStyle: ArtStyle.reason,
    overview:
        'Rationalism begins with Descartes\' realisation: the only thing you can\'t doubt is that you\'re thinking. From this single certainty, you can rebuild a more reliable worldview. In practice, it trains you to separate emotion from analysis — not to suppress feelings, but to stop letting distorted thinking run unchecked. This is the foundation of cognitive behavioural therapy.',
    historicalContext:
        'René Descartes launched the rationalist tradition with Meditations on First Philosophy (1641). Spinoza and Leibniz developed it further. The scientific method is its greatest practical legacy.',
    coreTenets: [
      'Reason over distortion',
      'Deductive reasoning',
      'Questioning assumptions',
      'Internal consistency',
      'A priori knowledge'
    ],
    notableFigures: [
      NotableFigure(
          name: 'René Descartes',
          contribution:
              'Father of modern philosophy; "I think therefore I am."'),
      NotableFigure(
          name: 'Baruch Spinoza',
          contribution: 'Built ethics as a geometric proof system.'),
      NotableFigure(
          name: 'Immanuel Kant',
          contribution: 'Synthesised rationalism and empiricism.'),
    ],
    modernApplication:
        'Many struggles are sustained by illogical but deeply felt beliefs. Rationalism gives you the tools to identify and challenge them — turning rumination into clear analysis.',
    quotes: [
      '"I think, therefore I am." – Descartes',
      '"The greatest deception men suffer is from their own opinions." – Leonardo da Vinci',
    ],
    keyWorks: ['Meditations on First Philosophy', 'Ethics (Spinoza)'],
    gradientColors: [Color(0xFF7E57C2), Color(0xFF311B92)],
  ),

  IsmMeta(
    id: 'phenomenology',
    name: 'Phenomenology',
    icon: '🌀',
    tagline: 'Your experience of the world is the world — for you.',
    description:
        'The philosophical study of conscious experience from the first-person perspective. It validates your inner life as a legitimate subject of serious inquiry.',
    challenge:
        'Sit quietly for five minutes. Describe your experience exactly as it is — not what caused it, not what it means, just what it is right now.',
    weeklyChallenge:
        'Once a day, pause and ask: "What am I actually experiencing right now?" Write three honest sentences.',
    category: 'mental_emotional',
    visualStyle: ArtStyle.existential,
    overview:
        'Phenomenology says your subjective experience is not a problem to be corrected — it\'s the primary reality. Edmund Husserl founded it as a rigorous method for examining consciousness. Heidegger extended it to "being-in-the-world." For mental health, phenomenology is radical validation: what you feel is real, and it deserves to be examined carefully.',
    historicalContext:
        'Founded by Edmund Husserl in the early 20th century. Developed by Martin Heidegger (Being and Time, 1927) and Maurice Merleau-Ponty (Phenomenology of Perception, 1945). Deeply influenced modern psychotherapy.',
    coreTenets: [
      'First-person primacy',
      'Consciousness as intentional',
      'Being-in-the-world',
      'Embodied experience',
      'Bracketing assumptions'
    ],
    notableFigures: [
      NotableFigure(
          name: 'Edmund Husserl',
          contribution:
              'Founded phenomenology; rigorous study of consciousness.'),
      NotableFigure(
          name: 'Martin Heidegger',
          contribution: 'Being and Time; being-in-the-world.'),
      NotableFigure(
          name: 'Maurice Merleau-Ponty',
          contribution: 'Phenomenology of Perception; the body as primary.'),
    ],
    modernApplication:
        'When you\'re told your feelings are "irrational," phenomenology disagrees. It says: describe your experience first. Understand it before you try to change it.',
    quotes: [
      '"Consciousness is always consciousness of something." – Husserl',
      '"We are condemned to meaning." – Merleau-Ponty',
    ],
    keyWorks: ['Being and Time', 'Phenomenology of Perception'],
    gradientColors: [Color(0xFF4FC3F7), Color(0xFF01579B)],
  ),

  IsmMeta(
    id: 'idealism',
    name: 'Idealism',
    icon: '🔮',
    tagline: 'The world you see is a shadow of a greater reality.',
    description:
        'Plato\'s philosophical tradition: true reality lies beyond the senses, in the realm of perfect forms and ideas. The life of the mind is the highest life.',
    challenge:
        'Identify one "ideal" version of yourself you\'ve glimpsed but never fully pursued. Write one step toward it.',
    weeklyChallenge:
        'Each day this week, ask: "What would the best version of me do here?" Then do that thing.',
    category: 'personal_growth',
    visualStyle: ArtStyle.reason,
    overview:
        'Plato\'s Allegory of the Cave says most people live chained in a cave, mistaking shadows for reality. The philosopher\'s task is to turn and see the light. His Theory of Forms holds that every beautiful thing points toward a perfect "Form" of Beauty. For modern life: you sense something greater is possible. That instinct is worth trusting.',
    historicalContext:
        'Founded by Plato in Athens (428-348 BCE). The Academy he founded lasted nearly 1000 years. His influence spread through Augustine, Neoplatonism, and the entire Western philosophical tradition.',
    coreTenets: [
      'Theory of Forms',
      'The examined life',
      'Knowledge as recollection',
      'Justice as inner harmony',
      'The soul\'s journey'
    ],
    notableFigures: [
      NotableFigure(
          name: 'Plato',
          contribution:
              'Founded the Western philosophical tradition; the Academy.'),
      NotableFigure(
          name: 'Plotinus',
          contribution: 'Neoplatonism; the soul\'s return to the One.'),
      NotableFigure(
          name: 'Socrates',
          contribution: 'Plato\'s teacher; the examined life.'),
    ],
    modernApplication:
        'Platonic idealism counters the flat materialism of modern life. There is something you\'re meant to pursue — a vision of what you could be. Pursue it.',
    quotes: [
      '"The unexamined life is not worth living." – Socrates',
      '"We are twice armed if we fight with faith." – Plato',
    ],
    keyWorks: ['The Republic', 'The Symposium', 'Phaedo'],
    gradientColors: [Color(0xFF80DEEA), Color(0xFF00838F)],
  ),

  IsmMeta(
    id: 'stoic_zen',
    name: 'Stoic Zen',
    icon: '🌊',
    tagline: 'Control the mind. Flow with what remains.',
    description:
        'A modern synthesis of Stoic discipline and Zen mindfulness — act decisively on what you can change, surrender peacefully to what you cannot.',
    challenge:
        'When you feel resistance today, pause. Ask: "Can I control this?" If yes — act. If no — breathe, and let it pass.',
    weeklyChallenge:
        'Each morning: five minutes of breath awareness (Zen), then write one thing in your control and one thing outside it (Stoic). Do this every day this week.',
    category: 'lifestyle_fusion',
    visualStyle: ArtStyle.mindfulness,
    overview:
        'Stoic Zen is a practical daily system emerging from the surprising overlap between two traditions separated by 6,000 miles. Stoicism provides the ethical framework: the dichotomy of control, virtue through action. Zen provides the meditative engine: present-moment awareness, non-attachment. Together they form something neither has alone — discipline AND peace.',
    historicalContext:
        'While historically separate, these traditions share deep parallels. Both emphasise acceptance of what cannot be changed and the emptiness of external goods. Ryan Holiday and Sam Harris have drawn these threads together in modern writing.',
    coreTenets: [
      'Dichotomy of control (Stoic)',
      'Present awareness (Zen)',
      'Non-attachment',
      'Virtue through action',
      'Equanimity in all things'
    ],
    notableFigures: [
      NotableFigure(
          name: 'Marcus Aurelius',
          contribution:
              'Roman emperor; Meditations as a daily practice journal.'),
      NotableFigure(
          name: 'Thich Nhat Hanh',
          contribution: 'Vietnamese Zen master; mindfulness as a way of life.'),
      NotableFigure(
          name: 'Epictetus',
          contribution:
              'Stoic philosopher; taught freedom through acceptance.'),
    ],
    modernApplication:
        'Stoicism gives you agency — focus only where you can act. Zen gives you peace — release everything else without clinging. Together they are one of the most effective daily systems for modern anxiety.',
    quotes: [
      '"You have power over your mind, not outside events. Realise this, and you will find strength." – Marcus Aurelius',
      '"The present moment is the only moment available to us." – Thich Nhat Hanh',
    ],
    keyWorks: [
      'Meditations',
      'The Miracle of Mindfulness',
      'The Obstacle Is the Way'
    ],
    gradientColors: [Color(0xFF80DEEA), Color(0xFF26C6DA)],
  ),
];
