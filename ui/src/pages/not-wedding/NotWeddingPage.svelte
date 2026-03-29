<script lang="ts">
  import {onMount} from 'svelte'

  const event = {
    title: 'Jaan & Jana Wedding',
    location: 'Yayaki House, Narva mnt 7, 2 этаж',
    description: 'Свадебный день Jaan & Jana.',
    localStart: '20260808T140000',
    localEnd: '20260808T235900',
    googleStartUtc: '20260808T110000Z',
    googleEndUtc: '20260808T205900Z',
    timeZone: 'Europe/Tallinn'
  }

  function escapeIcs(value: string) {
    return value
      .replace(/\\/g, '\\\\')
      .replace(/\n/g, '\\n')
      .replace(/,/g, '\\,')
      .replace(/;/g, '\\;')
  }

  function downloadCalendarEvent() {
    const ics = [
      'BEGIN:VCALENDAR',
      'VERSION:2.0',
      'PRODID:-//Sandbox//Wedding Page//EN',
      'BEGIN:VEVENT',
      'UID:jaan-jana-wedding@sandbox',
      `DTSTAMP:${event.googleStartUtc}`,
      `DTSTART:${event.localStart}`,
      `DTEND:${event.localEnd}`,
      `SUMMARY:${escapeIcs(event.title)}`,
      `LOCATION:${escapeIcs(event.location)}`,
      `DESCRIPTION:${escapeIcs(event.description)}`,
      'END:VEVENT',
      'END:VCALENDAR'
    ].join('\r\n')

    const blob = new Blob([ics], {type: 'text/calendar;charset=utf-8'})
    const url = URL.createObjectURL(blob)
    const link = document.createElement('a')

    link.href = url
    link.download = 'jaan-jana-wedding.ics'
    link.click()

    setTimeout(() => URL.revokeObjectURL(url), 1000)
  }

  const googleCalendarUrl = `https://calendar.google.com/calendar/render?action=TEMPLATE&text=${encodeURIComponent(event.title)}&dates=${event.googleStartUtc}/${event.googleEndUtc}&details=${encodeURIComponent(event.description)}&location=${encodeURIComponent(event.location)}&ctz=${encodeURIComponent(event.timeZone)}`

  let heroVisual: HTMLElement | undefined
  let heroVisualOffset = 0
  let reduceMotion = false

  function updateHeroParallax() {
    if (!heroVisual || reduceMotion) {
      heroVisualOffset = 0
      return
    }

    const rect = heroVisual.getBoundingClientRect()
    const viewport = Math.max(window.innerHeight, 1)
    const progress = (viewport - rect.top) / (viewport + rect.height)
    const clamped = Math.min(Math.max(progress, 0), 1)

    heroVisualOffset = (clamped - 0.5) * 28
  }

  onMount(() => {
    const media = window.matchMedia('(prefers-reduced-motion: reduce)')
    let ticking = false

    const syncMotionPreference = () => {
      reduceMotion = media.matches
      updateHeroParallax()
    }

    const scheduleUpdate = () => {
      if (ticking) return
      ticking = true
      requestAnimationFrame(() => {
        updateHeroParallax()
        ticking = false
      })
    }

    syncMotionPreference()
    scheduleUpdate()

    window.addEventListener('scroll', scheduleUpdate, {passive: true})
    window.addEventListener('resize', scheduleUpdate)
    media.addEventListener?.('change', syncMotionPreference)

    return () => {
      window.removeEventListener('scroll', scheduleUpdate)
      window.removeEventListener('resize', scheduleUpdate)
      media.removeEventListener?.('change', syncMotionPreference)
    }
  })
</script>

<svelte:head>
  <title>Jaan & Jana</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Rouge+Script&display=swap" rel="stylesheet">
</svelte:head>

<main id="main" tabindex="-1" class="page">
  <nav class="page-nav">
    <div class="section-inner nav-inner">
      <a href="#location">Локация</a>
      <a href="#dress-code">Дресс-код</a>
      <a href="#day">Свадебный день</a>
      <a href="#love">Пожелания</a>
      <a href="#calendar">Календарь</a>
    </div>
  </nav>

  <section class="hero-section">
    <div class="section-inner hero-inner">
      <div class="hero-head">
        <h1>Jaan & Jana</h1>
        <p class="hero-date">Saturday / 08.08.2026</p>
      </div>

      <div class="hero-layout">
        <div class="hero-copy">
          <p class="hero-lead">Мы будем счастливы разделить с вами этот день.</p>
          <p class="hero-body">
            Дорогие гости, совсем скоро наступит день, который станет началом нашей новой главы — нашей семьи.
            Мы будем счастливы видеть вас рядом, разделить эмоции, смех и любовь этого особенного дня.
          </p>

          <div class="text-links">
            <button type="button" class="button-link" on:click={downloadCalendarEvent}>Добавить в календарь</button>
            <a href="#day" class="button-link button-link-secondary">Смотреть тайминг</a>
          </div>
        </div>

        <div class="hero-visual" bind:this={heroVisual}>
          <div class="hero-photo-slot" style={`transform: translate3d(0, ${heroVisualOffset}px, 0);`}>
            <span class="hero-photo-label">Фото пары</span>
            <div class="hero-date-badge">
              <span>AUG</span>
              <strong>08</strong>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section id="location" class="page-section">
    <div class="section-inner section-grid">
      <div class="section-copy">
        <h2>Location</h2>
        <p>
          Мы выбрали уютное и атмосферное место, где сможем провести этот день в тёплой и близкой компании.
        </p>
        <p class="section-address">
          <a href="https://maps.google.com/?q=Yayaki+House,+Narva+mnt+7,+Tallinn" target="_blank" rel="noreferrer">
            Yayaki House, Narva mnt 7, 2 этаж
          </a>
        </p>
      </div>

    </div>
  </section>

  <section id="dress-code" class="page-section">
    <div class="section-inner section-grid">
      <div class="section-copy">
        <h2>Dress Code</h2>
        <p>
          Мы будем рады видеть девушек в нарядах в нежных пастельных оттенках, а мужчин в классике.
        </p>
      </div>

      <div class="palette-block" aria-label="Палитра дресс-кода">
        <span class="palette-swatch swatch-1"></span>
        <span class="palette-swatch swatch-2"></span>
        <span class="palette-swatch swatch-3"></span>
        <span class="palette-swatch swatch-4"></span>
        <span class="palette-swatch swatch-5"></span>
      </div>
    </div>
  </section>

  <section id="day" class="page-section">
    <div class="section-inner timeline-section">
      <div class="section-copy">
        <h2>Wedding Day</h2>
      </div>

      <ol class="timeline">
        <li>
          <p class="timeline-time">14:30</p>
          <div class="timeline-copy">
            <h3>Церемония в ЗАГСе Таллинна</h3>
            <p>Тот самый момент, когда мы скажем друг другу «да».</p>
          </div>
        </li>
        <li>
          <p class="timeline-time">15:00</p>
          <div class="timeline-copy">
            <h3>Фотографии</h3>
            <p>Сохраним первые мгновения этого дня — искренние улыбки, объятия и эмоции.</p>
          </div>
        </li>
        <li>
          <p class="timeline-time">16:00</p>
          <div class="timeline-copy">
            <h3>Начало праздника</h3>
            <p>Соберёмся вместе, чтобы поздравить, обнять и разделить радость этого дня.</p>
          </div>
        </li>
        <li>
          <p class="timeline-time">18:00</p>
          <div class="timeline-copy">
            <h3>Вечер и танцы</h3>
            <p>Время наслаждаться атмосферой, музыкой и друг другом.</p>
          </div>
        </li>
        <li>
          <p class="timeline-time">21:00</p>
          <div class="timeline-copy">
            <h3>Торт-сюрприз</h3>
            <p>Сладкое завершение этого особенного дня.</p>
          </div>
        </li>
      </ol>

    </div>
  </section>

  <section id="love" class="page-section">
    <div class="section-inner section-grid section-grid-wide">
      <div class="section-copy">
        <h2>With Love</h2>
      </div>

      <div class="long-copy">
        <p>Мы очень ценим ваше внимание и заботу.</p>
        <p>
          И будем очень благодарны, если вы обойдетесь без подарков в виде картин и предметов декора.
          Если вы хотите порадовать нас, приятным и удобным вариантом станет конверт.
        </p>
        <p>
          Ваши тёплые слова и поздравления мы с радостью примем, когда соберёмся вместе после ЗАГСа.
        </p>
        <p>
          Пожалуйста, приходите в ЗАГС не менее чем за 15 минут до начала церемонии.
        </p>
        <p>Самое главное для нас — это ваше присутствие и разделённая с нами радость этого дня.</p>
      </div>
    </div>
  </section>

  <section id="calendar" class="page-section calendar-section">
    <div class="section-inner calendar-inner">
      <div class="section-copy">
        <h2>Calendar</h2>
        <p>Добавьте этот день в календарь, чтобы сохранить дату нашего праздника.</p>
      </div>

      <div class="text-links">
        <button type="button" class="button-link" on:click={downloadCalendarEvent}>Добавить в календарь</button>
        <a href={googleCalendarUrl} target="_blank" rel="noreferrer" class="button-link button-link-secondary">Открыть Google Календарь</a>
      </div>
    </div>
  </section>
</main>

<style lang="postcss">
  @media (prefers-reduced-motion: no-preference) {
    :global(html) {
      scroll-behavior: smooth;
    }
  }

  :global(body) {
    margin: 0;
    background: #faf7f2;
    color: #261f1b;
    font-family: 'Inter', sans-serif;
  }

  .page {
    --line: rgba(96, 78, 66, 0.16);
    --line-strong: rgba(96, 78, 66, 0.26);
    --accent: #8a6f62;
    --surface: #fffdf9;
  }

  .section-inner {
    width: min(100%, 1000px);
    margin: 0 auto;
    padding: 0 1.5rem;
  }

  .page-nav {
    position: sticky;
    top: 0;
    z-index: 20;
    border-bottom: 1px solid var(--line);
    background: rgba(250, 247, 242, 0.88);
    backdrop-filter: blur(14px);
  }

  .nav-inner {
    display: flex;
    flex-wrap: wrap;
    gap: 1.25rem;
    padding-top: 1rem;
    padding-bottom: 1rem;
  }

  .page-nav a {
    color: #4d4038;
    font-size: 0.92rem;
    font-weight: 500;
    letter-spacing: 0.02em;
    text-decoration: none;
    transition: color 120ms ease, opacity 120ms ease;
  }

  .page-nav a:hover,
  .page-nav a:focus-visible {
    color: #261f1b;
  }

  .hero-section {
    min-height: calc(100svh - 4.5rem);
    padding-top: clamp(2rem, 4vw, 3rem);
    padding-bottom: clamp(3rem, 7vw, 5rem);
    background:
      linear-gradient(180deg, #fcfaf6 0%, #f4ece1 100%);
  }

  .hero-inner {
    display: grid;
    gap: clamp(2rem, 5vw, 4rem);
    min-height: calc(100svh - 9rem);
  }

  .hero-head {
    text-align: center;
  }

  .hero-layout {
    display: grid;
    grid-template-columns: minmax(0, 0.86fr) minmax(0, 1.14fr);
    gap: clamp(2rem, 5vw, 4.5rem);
    align-items: center;
  }

  .hero-copy {
    max-width: 31rem;
  }

  h1,
  h2 {
    margin: 0;
    color: #4d4038;
    font-family: 'Rouge Script', cursive;
    font-weight: 400;
    line-height: 0.92;
  }

  h1 {
    font-size: clamp(4.8rem, 11vw, 8rem);
    margin-bottom: 1rem;
  }

  h2 {
    font-size: clamp(3.1rem, 7vw, 4.8rem);
    margin-bottom: 1.5rem;
  }

  h3 {
    margin: 0 0 0.4rem;
    color: #261f1b;
    font-size: 1.05rem;
    font-weight: 700;
    line-height: 1.45;
  }

  .hero-date {
    margin: 0;
    color: #5f5149;
    font-size: 0.98rem;
    font-weight: 600;
    letter-spacing: 0.08em;
    text-transform: uppercase;
  }

  p {
    margin: 0 0 1rem;
    color: #3f342e;
    font-size: 1rem;
    line-height: 1.8;
  }

  .hero-lead {
    max-width: 25rem;
    color: #261f1b;
    font-size: 1.12rem;
  }

  .hero-body {
    max-width: 31rem;
  }

  .hero-visual {
    position: relative;
    min-height: 26rem;
  }

  .hero-photo-slot {
    position: relative;
    display: flex;
    height: 100%;
    min-height: 28rem;
    align-items: flex-end;
    justify-content: space-between;
    overflow: hidden;
    border: 1px solid rgba(96, 78, 66, 0.18);
    border-radius: 2rem;
    padding: 1.5rem;
    background:
      radial-gradient(circle at top right, rgba(255, 255, 255, 0.7), transparent 34%),
      linear-gradient(135deg, #ede2d6 0%, #d8c6b6 45%, #b79e8e 100%);
    transition: transform 180ms ease-out;
    will-change: transform;
  }

  .hero-photo-slot::before {
    content: '';
    position: absolute;
    inset: 1rem;
    border: 1px solid rgba(255, 255, 255, 0.38);
    border-radius: 1.4rem;
  }

  .hero-photo-label {
    position: relative;
    z-index: 1;
    color: rgba(38, 31, 27, 0.78);
    font-size: 0.82rem;
    font-weight: 600;
    letter-spacing: 0.12em;
    text-transform: uppercase;
  }

  .hero-date-badge {
    position: relative;
    z-index: 1;
    display: grid;
    gap: 0.15rem;
    min-width: 6.5rem;
    padding: 0.9rem 1rem 1rem;
    border: 1px solid rgba(255, 255, 255, 0.45);
    border-radius: 1.3rem;
    background: rgba(255, 253, 249, 0.62);
    text-align: center;
    backdrop-filter: blur(6px);
  }

  .hero-date-badge span {
    color: #7c6558;
    font-size: 0.75rem;
    font-weight: 700;
    letter-spacing: 0.18em;
    text-transform: uppercase;
  }

  .hero-date-badge strong {
    color: #4d4038;
    font-size: 2rem;
    font-weight: 700;
    line-height: 1;
  }

  .page-section {
    position: relative;
    scroll-margin-top: 6rem;
    border-top: 1px solid var(--line);
    background: var(--surface);
    padding-top: clamp(3rem, 7vw, 5rem);
    padding-bottom: clamp(3rem, 7vw, 5rem);
  }

  .section-grid {
    display: grid;
    grid-template-columns: minmax(0, 1fr) minmax(17rem, 0.68fr);
    gap: clamp(2rem, 6vw, 5rem);
    align-items: start;
  }

  .section-grid-wide {
    grid-template-columns: minmax(15rem, 0.7fr) minmax(0, 1.3fr);
  }

  .section-copy {
    max-width: 37rem;
  }

  .section-address a {
    color: #261f1b;
    font-size: 1.02rem;
    font-weight: 600;
    text-decoration: none;
    border-bottom: 1px solid rgba(38, 31, 27, 0.24);
    transition: color 120ms ease, border-color 120ms ease;
  }

  .section-address a:hover,
  .section-address a:focus-visible {
    color: var(--accent);
    border-color: var(--accent);
  }

  .palette-block {
    display: flex;
    align-items: center;
    gap: 0.9rem;
    align-self: center;
    justify-content: flex-start;
    flex-wrap: wrap;
  }

  .palette-swatch {
    display: inline-block;
    width: 3.5rem;
    height: 3.5rem;
    border: 1px solid rgba(96, 78, 66, 0.14);
    border-radius: 9999px;
  }

  .swatch-1 { background: #f1e4de; }
  .swatch-2 { background: #e7d8cb; }
  .swatch-3 { background: #ddd8e2; }
  .swatch-4 { background: #d7e2d8; }
  .swatch-5 { background: #f2e9d9; }

  .timeline-section {
    display: grid;
    gap: 2rem;
  }

  .timeline {
    margin: 0;
    padding: 0;
    list-style: none;
  }

  .timeline li {
    display: grid;
    grid-template-columns: minmax(5rem, 6rem) minmax(0, 1fr);
    gap: 1.5rem;
    padding-top: 1.2rem;
    padding-bottom: 1.2rem;
    border-top: 1px solid var(--line);
  }

  .timeline li:last-child {
    border-bottom: 1px solid var(--line);
  }

  .timeline-time {
    margin: 0;
    color: var(--accent);
    font-size: 0.9rem;
    font-weight: 700;
    letter-spacing: 0.12em;
    text-transform: uppercase;
  }

  .timeline-copy p {
    margin-bottom: 0;
  }

  .long-copy {
    max-width: 38rem;
  }

  .calendar-section {
    background: #f8f3ec;
  }

  .calendar-inner {
    display: flex;
    flex-wrap: wrap;
    align-items: end;
    justify-content: space-between;
    gap: 1.5rem 2rem;
  }

  .text-links {
    display: flex;
    flex-wrap: wrap;
    gap: 1rem;
    align-items: center;
  }

  .text-links a,
  .text-links button {
    font: inherit;
    text-decoration: none;
    cursor: pointer;
  }

  button.button-link,
  a.button-link {
    display: inline-flex;
    min-height: 2.9rem;
    align-items: center;
    justify-content: center;
    border: 1px solid #261f1b;
    border-radius: 9999px;
    padding: 0.7rem 1.25rem;
    background: #261f1b;
    color: #fffdf9 !important;
    font-size: 0.95rem;
    font-weight: 600;
    line-height: 1;
    transition: transform 120ms ease, background-color 120ms ease, border-color 120ms ease, color 120ms ease;
  }

  .button-link:hover,
  .button-link:focus-visible {
    transform: translateY(-1px);
    background: #3b302a;
    border-color: #3b302a;
  }

  .button-link-secondary {
    background: transparent;
    color: #261f1b !important;
  }

  .button-link-secondary:hover,
  .button-link-secondary:focus-visible {
    background: rgba(38, 31, 27, 0.06);
    border-color: #261f1b;
  }

  @media (prefers-reduced-motion: no-preference) {
    .hero-copy > * {
      opacity: 0;
      transform: translateY(18px);
      animation: hero-reveal 700ms cubic-bezier(0.22, 1, 0.36, 1) forwards;
    }

    .hero-copy > :global(*) {
      animation-delay: 0ms;
    }

    .hero-copy > :nth-child(1) { animation-delay: 40ms; }
    .hero-copy > :nth-child(2) { animation-delay: 120ms; }
    .hero-copy > :nth-child(3) { animation-delay: 180ms; }
    .hero-copy > :nth-child(4) { animation-delay: 240ms; }
    .hero-copy > :nth-child(5) { animation-delay: 300ms; }
    .hero-copy > :nth-child(6) { animation-delay: 360ms; }
  }

  @keyframes hero-reveal {
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }

  @media (max-width: 900px) {
    .hero-inner,
    .hero-layout,
    .section-grid,
    .section-grid-wide,
    .calendar-inner {
      grid-template-columns: 1fr;
    }

    .hero-inner {
      min-height: auto;
    }

    .hero-visual {
      min-height: 20rem;
    }

    .hero-photo-slot {
      min-height: 22rem;
    }

  }

  @media (max-width: 640px) {
    .section-inner {
      padding: 0 1rem;
    }

    .page-nav {
      font-size: 0.88rem;
    }

    .nav-inner {
      gap: 0.85rem 1rem;
    }

    .timeline li {
      grid-template-columns: 1fr;
      gap: 0.5rem;
    }
  }
</style>
