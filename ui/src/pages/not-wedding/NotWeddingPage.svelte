<script lang="ts">
  import locationPhoto from './wedd graphics.webp'
  import dressCodeSwatch1 from './colors/IMG_6229.JPG?url'
  import dressCodeSwatch2 from './colors/IMG_6230.JPG?url'
  import dressCodeSwatch3 from './colors/IMG_6231.JPG?url'
  import dressCodeSwatch4 from './colors/IMG_6232.JPG?url'
  import dressCodeSwatch5 from './colors/IMG_6233.JPG?url'
  import dressCodeSwatch6 from './colors/IMG_6234.JPG?url'
  import heroPanelPhoto1 from './1.JPG?url'
  import heroPanelPhoto2 from './2.JPG?url'
  import heroPanelPhoto3 from './3.JPG?url'
  import NotWeddingHeroNamesDate from './NotWeddingHeroNamesDate.svelte'

  type NavItem = {
    href: string,
    label: string,
  }

  type HeroPanelImage = {
    src: string,
    label: string,
  }

  type TimelineItem = {
    time: string,
    title: string,
    description: string,
  }

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
  const navItems: NavItem[] = [
    {href: '#location', label: 'Локация'},
    {href: '#dress-code', label: 'Дресс-код'},
    {href: '#day', label: 'Свадебный день'},
    {href: '#love', label: 'Пожелания'}
  ]
  const dressCodeSwatches = [
    dressCodeSwatch1,
    dressCodeSwatch2,
    dressCodeSwatch3,
    dressCodeSwatch4,
    dressCodeSwatch5,
    dressCodeSwatch6
  ]
  const heroPanelImages: HeroPanelImage[] = [
    {src: heroPanelPhoto1, label: '08'},
    {src: heroPanelPhoto2, label: '08'},
    {src: heroPanelPhoto3, label: '26'}
  ]
  const timelineItems: TimelineItem[] = [
    {
      time: '14:30',
      title: 'Церемония в ЗАГСе Таллинна',
      description: 'Тот самый момент, когда мы скажем друг другу «да».'
    },
    {
      time: '15:00',
      title: 'Фотографии',
      description: 'Сохраним первые мгновения этого дня — искренние улыбки, объятия и эмоции.'
    },
    {
      time: '16:00',
      title: 'Начало праздника',
      description: 'Соберёмся вместе, чтобы поздравить, обнять и разделить радость этого дня.'
    },
    {
      time: '18:00',
      title: 'Вечер и танцы',
      description: 'Время наслаждаться атмосферой, музыкой и друг другом.'
    },
    {
      time: '21:00',
      title: 'Торт-сюрприз',
      description: 'Сладкое завершение этого особенного дня.'
    }
  ]
</script>

<svelte:head>
  <title>Jaan & Jana</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
  <link href="https://fonts.googleapis.com/css2?family=Bodoni+Moda:wght@400;500;600;700;800&family=Inter:wght@400;500;600;700;800&family=Rouge+Script&display=swap" rel="stylesheet">
</svelte:head>

<main id="main" tabindex="-1" class="page-main">
  <nav class="site-nav">
    <div class="page-inner site-nav-inner">
      {#each navItems as item}
        <a href={item.href} class="nav-link">{item.label}</a>
      {/each}
    </div>
  </nav>

  <section class="hero-section">
    <div class="hero-glow"></div>
    <NotWeddingHeroNamesDate containerClass="pb-1.5"/>
    <div class="hero-shell">
      <div class="hero-gallery-row">
        <h1 class="hero-title">
          Save
          the
          Date
        </h1>
        {#each heroPanelImages as heroPanelImage}
          <div class="hero-panel-frame">
            <div
              class="hero-panel"
              style={`--hero-panel-image: url(${heroPanelImage.src});`}
            >
            </div>
            <div class="hero-panel-label">{heroPanelImage.label}</div>
          </div>
        {/each}
      </div>
    </div>
    <div class="hero-copy">
      <h3 class="hero-copy-title">Мы будем счастливы разделить с вами
        этот день.</h3>
      <p class="hero-copy-text">
        Дорогие гости, совсем скоро наступит день, который станет началом нашей новой главы — нашей семьи.
        Мы будем счастливы видеть вас рядом, разделить эмоции, смех и любовь этого особенного дня.
      </p>
      <div class="hero-copy-actions">
        <button type="button" class="button button--primary" on:click={downloadCalendarEvent}>Добавить в календарь
        </button>
        <a href="#day" class="button button--secondary">Примерная программа</a>
      </div>
    </div>

  </section>

  <section
    id="location"
    class="section-shell location-section"
    style={`--location-photo: url(${locationPhoto});`}
  >
    <div class="page-inner location-grid">
      <div class="location-copy">
        <h2 class="section-title location-title">Location</h2>
        <p class="body-text location-description">
          Мы выбрали уютное и атмосферное место, где сможем провести этот день в тёплой и близкой компании.
        </p>
        <p class="m-0">
          <a
            href="https://maps.google.com/?q=Yayaki+House,+Narva+mnt+7,+Tallinn"
            target="_blank"
            rel="noreferrer"
            class="location-link"
          >
            <span>Yayaki House, Narva mnt 7, 2 этаж</span>
            <span aria-hidden="true" class="location-link-arrow">
              ↗
            </span>
          </a>
        </p>
      </div>
    </div>
  </section>

  <section id="dress-code" class="section-shell">
    <div class="page-inner dress-code-shell">
      <div class="dress-code-copy">
        <h2 class="section-title">Dress Code</h2>
        <p class="body-text">
          Мы будем рады видеть девушек в нарядах в нежных пастельных оттенках, а мужчин в классике.
        </p>
      </div>

      <div class="dress-code-swatches" aria-label="Палитра дресс-кода">
        {#each dressCodeSwatches as swatch}
          <span
            aria-hidden="true"
            class="dress-code-swatch"
            style={`background-image: url(${swatch});`}
          ></span>
        {/each}
      </div>
    </div>
  </section>

  <section id="day" class="section-shell">
    <div class="page-inner timeline-shell">
      <div class="timeline-heading">
        <h2 class="section-title">Wedding Day</h2>
      </div>

      <ol class="timeline-list">
        {#each timelineItems as item, index}
          <li class="timeline-item" class:timeline-item--last={index === timelineItems.length - 1}>
            <p class="timeline-time">{item.time}</p>
            <div>
              <h3 class="timeline-title">{item.title}</h3>
              <p class="timeline-description">{item.description}</p>
            </div>
          </li>
        {/each}
      </ol>
    </div>
  </section>

  <section id="love" class="section-shell">
    <div class="page-inner love-grid">
      <div class="love-heading">
        <h2 class="section-title">With Love</h2>
      </div>

      <div class="love-copy">
        <p class="body-text love-paragraph">Мы очень ценим ваше внимание и заботу.</p>
        <p class="body-text love-paragraph">
          И будем очень благодарны, если вы обойдетесь без подарков в виде картин и предметов декора.
          Если вы хотите порадовать нас, приятным и удобным вариантом станет конверт.
        </p>
        <p class="body-text love-paragraph">
          Ваши тёплые слова и поздравления мы с радостью примем, когда соберёмся вместе после ЗАГСа.
        </p>
        <p class="body-text love-paragraph">
          Пожалуйста, приходите в ЗАГС не менее чем за 15 минут до начала церемонии.
        </p>
        <p class="body-text m-0">Самое главное для нас — это ваше присутствие и разделённая с нами радость
          этого дня.</p>
      </div>
    </div>
  </section>

  <section id="calendar" class="section-shell section-shell--muted">
    <div class="page-inner calendar-shell">
      <div class="calendar-copy">
        <h2 class="section-title">Calendar</h2>
        <p class="body-text m-0">Добавьте этот день в календарь, чтобы сохранить дату нашего праздника.</p>
      </div>

      <div class="calendar-actions">
        <button type="button" class="button button--primary" on:click={downloadCalendarEvent}>Добавить в календарь</button>
        <a href={googleCalendarUrl} target="_blank" rel="noreferrer" class="button button--secondary">Открыть Google
          Календарь
        </a>
      </div>
    </div>
  </section>
</main>

<style lang="postcss">
  @reference "./../../global.css";

  @media (prefers-reduced-motion: no-preference) {
    :global(html) {
      scroll-behavior: smooth;
    }
  }

  .page-main {
    @apply bg-nw-200 font-['Inter'] text-nw-900;
  }

  .page-inner {
    @apply mx-auto w-full max-w-[1000px] px-6;
  }

  .site-nav {
    @apply sticky top-0 z-20 border-b backdrop-blur-[14px];
    border-color: color-mix(in srgb, var(--color-nw-800) 16%, transparent);
    background: color-mix(in srgb, var(--color-nw-200) 88%, transparent);
  }

  .site-nav-inner {
    @apply flex flex-wrap gap-5 py-4;
  }

  .nav-link {
    @apply text-[0.92rem] font-medium tracking-[0.02em] text-nw-800 transition-colors duration-150;
  }

  .nav-link:hover,
  .nav-link:focus-visible {
    @apply text-nw-900;
  }

  .hero-section {
    @apply relative flex min-h-[calc(100svh-4.5rem)] flex-col justify-center gap-14 overflow-hidden px-4 py-8;
    background: linear-gradient(180deg, var(--color-nw-100) 0%, var(--color-nw-400) 100%);
  }

  .hero-glow {
    @apply pointer-events-none absolute inset-x-0 top-[-18%] mx-auto h-[36rem] w-[min(92vw,68rem)] rounded-full blur-3xl;
    background: radial-gradient(
      circle,
      color-mix(in srgb, var(--color-nw-600) 42%, transparent) 0%,
      color-mix(in srgb, var(--color-nw-600) 14%, transparent) 42%,
      transparent 72%
    );
  }

  .hero-shell {
    @apply relative mx-auto flex w-full max-w-[1200px] flex-col justify-center;
  }

  .hero-gallery-row {
    @apply flex w-full gap-10;
  }

  .hero-title {
    @apply py-4 pr-6 font-['Bodoni_Moda'] text-[8rem] leading-[1.1] whitespace-pre-line uppercase tracking-[-0.04em] text-transparent;
    background-image: linear-gradient(
      180deg,
      color-mix(in srgb, var(--color-nw-800) 92%, transparent) 0%,
      var(--color-nw-600) 26%,
      var(--color-nw-700) 62%,
      var(--color-nw-900) 100%
    );
    -webkit-background-clip: text;
    background-clip: text;
    opacity: 0.82;
  }

  .hero-panel-frame {
    @apply relative flex flex-1;
  }

  .hero-panel {
    @apply flex w-full flex-1 overflow-hidden rounded-t-full rounded-b-full bg-cover bg-center bg-no-repeat;
    background-image: linear-gradient(
        180deg,
        color-mix(in srgb, var(--color-nw-50) 8%, transparent) 0%,
        color-mix(in srgb, var(--color-nw-50) 2%, transparent) 40%,
        color-mix(in srgb, var(--color-nw-900) 8%, transparent) 100%
      ),
      var(--hero-panel-image);
  }

  .hero-panel-label {
    @apply absolute bottom-0 right-0 -mb-1 -mr-1 text-right font-['Bodoni_Moda'] text-[6rem] leading-[1] text-transparent;
    background-image: linear-gradient(
      180deg,
      color-mix(in srgb, var(--color-nw-400) 88%, transparent) 0%,
      var(--color-nw-500) 35%,
      var(--color-nw-800) 70%,
      var(--color-nw-900) 100%
    );
    -webkit-background-clip: text;
    background-clip: text;
  }

  .hero-copy {
    @apply mx-auto flex min-w-0 max-w-[60rem] flex-col items-center justify-center gap-2;
  }

  .hero-copy-title {
    @apply font-['Bodoni_Moda'] text-nw-900;
  }

  .hero-copy-text {
    @apply pb-4 text-center text-nw-800;
  }

  .hero-copy-actions {
    @apply flex items-center gap-4;
  }

  .section-shell {
    @apply scroll-mt-24 py-[clamp(3rem,7vw,5rem)];
    border-top: 1px solid color-mix(in srgb, var(--color-nw-800) 16%, transparent);
    background: var(--color-nw-50);
  }

  .section-shell--muted {
    @apply bg-nw-300;
  }

  .section-title {
    @apply mb-6 font-['Rouge_Script'] text-[clamp(3.1rem,7vw,4.8rem)] leading-[0.92] text-nw-800;
  }

  .body-text {
    @apply leading-[1.8] text-nw-800;
  }

  .button {
    @apply inline-flex min-h-[2.9rem] items-center justify-center rounded-full border px-5 py-3 text-[0.95rem] font-semibold leading-none transition-all duration-150;
  }

  .button--primary {
    @apply border-nw-900 bg-nw-900 text-nw-50;
  }

  .button--primary:hover,
  .button--primary:focus-visible {
    @apply -translate-y-px border-nw-800 bg-nw-800;
  }

  .button--secondary {
    @apply border-nw-900 bg-transparent text-nw-900;
  }

  .button--secondary:hover,
  .button--secondary:focus-visible {
    @apply -translate-y-px;
    background: color-mix(in srgb, var(--color-nw-900) 6%, transparent);
  }

  .location-grid {
    @apply relative z-[1] flex min-h-[26rem] items-center justify-center py-[clamp(4rem,8vw,6rem)];
  }

  .location-copy {
    @apply w-full max-w-[36rem] rounded-[1.75rem] px-6 py-8 text-center sm:px-8 md:px-10;
    background: color-mix(in srgb, var(--color-nw-50) 74%, transparent);
    border: 1px solid color-mix(in srgb, var(--color-nw-50) 38%, transparent);
    box-shadow: 0 24px 70px color-mix(in srgb, var(--color-nw-900) 14%, transparent);
    backdrop-filter: blur(10px);
  }

  .location-title {
    @apply mb-5;
  }

  .location-description {
    @apply mb-6;
  }

  .location-link {
    @apply inline-flex items-center gap-3 border-b pb-1 text-[1.02rem] font-semibold transition-all duration-200;
    border-color: color-mix(in srgb, var(--color-nw-900) 28%, transparent);
    color: var(--color-nw-900);
  }

  .location-link:hover,
  .location-link:focus-visible {
    @apply border-nw-700 text-nw-700;
  }

  .location-link:hover .location-link-arrow,
  .location-link:focus-visible .location-link-arrow {
    transform: translateX(0.125rem);
  }

  .location-link-arrow {
    @apply text-[1.05rem] leading-none transition-transform duration-200;
  }

  .location-section {
    @apply relative overflow-hidden;
    background-image:
      linear-gradient(
        180deg,
        color-mix(in srgb, var(--color-nw-50) 22%, transparent) 0%,
        color-mix(in srgb, var(--color-nw-50) 10%, transparent) 25%,
        color-mix(in srgb, var(--color-nw-900) 26%, transparent) 100%
      ),
      var(--location-photo);
    background-position: 50% 50%;
    background-size: cover;
  }

  .dress-code-shell {
    @apply flex flex-col items-center gap-8 text-center;
  }

  .dress-code-copy {
    @apply w-full max-w-[42rem];
  }

  .dress-code-swatches {
    @apply flex w-full flex-wrap items-center justify-center gap-[0.9rem];
  }

  .dress-code-swatch {
    @apply inline-block h-[5.25rem] w-[5.25rem] rounded-full bg-cover bg-center bg-no-repeat;
    border: 1px solid color-mix(in srgb, var(--color-nw-800) 14%, transparent);
    box-shadow: inset 0 0 0 1px color-mix(in srgb, var(--color-nw-50) 25%, transparent);
  }

  .timeline-shell {
    @apply grid gap-8;
  }

  .timeline-heading {
    @apply max-w-[37rem];
  }

  .timeline-list {
    @apply m-0 list-none p-0;
  }

  .timeline-item {
    @apply grid gap-2 py-5 md:grid-cols-[minmax(5rem,6rem)_minmax(0,1fr)] md:gap-6;
    border-top: 1px solid color-mix(in srgb, var(--color-nw-800) 16%, transparent);
  }

  .timeline-item--last {
    border-bottom: 1px solid color-mix(in srgb, var(--color-nw-800) 16%, transparent);
  }

  .timeline-time {
    @apply m-0 text-[0.9rem] font-bold uppercase tracking-[0.12em] text-nw-700;
  }

  .timeline-title {
    @apply mb-1 text-[1.05rem] font-bold leading-[1.45] text-nw-900;
  }

  .timeline-description {
    @apply m-0 text-[1rem] leading-[1.8] text-nw-800;
  }

  .love-grid {
    @apply grid gap-8 md:grid-cols-[minmax(15rem,0.7fr)_minmax(0,1.3fr)];
  }

  .love-heading {
    @apply max-w-[37rem];
  }

  .love-copy {
    @apply max-w-[38rem];
  }

  .love-paragraph {
    @apply mb-4;
  }

  .calendar-shell {
    @apply flex flex-wrap items-end justify-between gap-x-8 gap-y-6;
  }

  .calendar-copy {
    @apply max-w-[37rem];
  }

  .calendar-actions {
    @apply flex flex-wrap items-center gap-4;
  }

  :global(body) {
    margin: 0;
  }
</style>
