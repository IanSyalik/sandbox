<script lang="ts">
  import {onMount} from 'svelte'

  import locationPhoto from './wedd graphics.webp'
  import locationPhoto2 from './wedd graphics2.webp'
  import locationPhoto3 from './wedd graphics3.webp'
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

  type LocationSlide = {
    src: string,
    objectPosition: string,
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
  const locationSlides: LocationSlide[] = [
    {src: locationPhoto, objectPosition: '50% 50%'},
    {src: locationPhoto2, objectPosition: '50% 50%'},
    {src: locationPhoto3, objectPosition: '50% 34%'}
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
  const locationSlideIntervalMs = 4200

  let currentLocationSlide = 0

  onMount(() => {
    if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
      return
    }

    const intervalId = window.setInterval(() => {
      currentLocationSlide = (currentLocationSlide + 1) % locationSlides.length
    }, locationSlideIntervalMs)

    return () => window.clearInterval(intervalId)
  })
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
              style={`background-image: linear-gradient(180deg, rgba(255,253,249,0.08) 0%, rgba(255,253,249,0.02) 40%, rgba(38,31,27,0.08) 100%), url(${heroPanelImage.src});`}
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

  <section id="location" class="section-shell">
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

      <figure class="location-media-shell group/location-media m-0">
        <div
          class="location-media-frame"
        >
          <div class="location-media-inner-border"></div>
          {#each locationSlides as photo, index (photo.src)}
            <img
              src={photo.src}
              alt=""
              aria-hidden="true"
              class={`absolute inset-0 block h-full w-full object-cover transition-[opacity,transform] duration-[1400ms] ease-out motion-safe:group-hover/location-media:scale-[1.02] ${
                currentLocationSlide === index ? 'opacity-100 scale-100' : 'opacity-0 scale-[1.015]'
              }`}
              style={`object-position: ${photo.objectPosition};`}
              loading="eager"
              decoding="async"
            >
          {/each}
          <div class="location-media-overlay"></div>
        </div>
        <figcaption class="sr-only">Фотографии площадки Yayaki House, где пройдет свадебный вечер.</figcaption>
      </figure>
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
    @apply font-['Inter'];
    background: #faf7f2;
    color: #261f1b;
  }

  .page-inner {
    @apply mx-auto w-full max-w-[1000px] px-6;
  }

  .site-nav {
    @apply sticky top-0 z-20 border-b backdrop-blur-[14px];
    border-color: rgba(96, 78, 66, 0.16);
    background: rgba(250, 247, 242, 0.88);
  }

  .site-nav-inner {
    @apply flex flex-wrap gap-5 py-4;
  }

  .nav-link {
    @apply text-[0.92rem] font-medium tracking-[0.02em] transition-colors duration-150;
    color: #4d4038;
  }

  .nav-link:hover,
  .nav-link:focus-visible {
    color: #261f1b;
  }

  .hero-section {
    @apply relative flex min-h-[calc(100svh-4.5rem)] flex-col justify-center gap-14 overflow-hidden px-4 py-8;
    background: linear-gradient(180deg, #fcfaf6 0%, #f4ece1 100%);
  }

  .hero-glow {
    @apply pointer-events-none absolute inset-x-0 top-[-18%] mx-auto h-[36rem] w-[min(92vw,68rem)] rounded-full blur-3xl;
    background: radial-gradient(circle, rgba(214, 196, 180, 0.42) 0%, rgba(214, 196, 180, 0.14) 42%, transparent 72%);
  }

  .hero-shell {
    @apply relative mx-auto flex w-full max-w-[1200px] flex-col justify-center;
  }

  .hero-gallery-row {
    @apply flex w-full gap-10;
  }

  .hero-title {
    @apply py-4 pr-6 font-['Bodoni_Moda'] text-[8rem] leading-[1.1] whitespace-pre-line uppercase tracking-[-0.04em];
    opacity: 0.6;
  }

  .hero-panel-frame {
    @apply relative flex flex-1;
  }

  .hero-panel {
    @apply flex w-full flex-1 overflow-hidden rounded-t-full rounded-b-full bg-cover bg-center bg-no-repeat;
  }

  .hero-panel-label {
    @apply absolute bottom-0 right-0 -mb-1 -mr-1 text-right font-['Bodoni_Moda'] text-[6rem] leading-[1];
  }

  .hero-copy {
    @apply mx-auto flex min-w-0 max-w-[60rem] flex-col items-center justify-center gap-2;
  }

  .hero-copy-title {
    @apply font-['Bodoni_Moda'];
    color: #261f1b;
  }

  .hero-copy-text {
    @apply pb-4 text-center;
    color: #3f342e;
  }

  .hero-copy-actions {
    @apply flex items-center gap-4;
  }

  .section-shell {
    @apply scroll-mt-24 py-[clamp(3rem,7vw,5rem)];
    border-top: 1px solid rgba(96, 78, 66, 0.16);
    background: #fffdf9;
  }

  .section-shell--muted {
    background: #f8f3ec;
  }

  .section-title {
    @apply mb-6 font-['Rouge_Script'] text-[clamp(3.1rem,7vw,4.8rem)] leading-[0.92];
    color: #4d4038;
  }

  .body-text {
    @apply leading-[1.8];
    color: #3f342e;
  }

  .button {
    @apply inline-flex min-h-[2.9rem] items-center justify-center rounded-full border px-5 py-3 text-[0.95rem] font-semibold leading-none transition-all duration-150;
  }

  .button--primary {
    border-color: #261f1b;
    background: #261f1b;
    color: #fffdf9;
  }

  .button--primary:hover,
  .button--primary:focus-visible {
    @apply -translate-y-px;
    border-color: #3b302a;
    background: #3b302a;
  }

  .button--secondary {
    border-color: #261f1b;
    background: transparent;
    color: #261f1b;
  }

  .button--secondary:hover,
  .button--secondary:focus-visible {
    @apply -translate-y-px;
    background: rgba(38, 31, 27, 0.06);
  }

  .location-grid {
    @apply grid gap-10 md:grid-cols-[minmax(0,0.92fr)_minmax(0,1.18fr)] md:items-center md:gap-[clamp(2.5rem,6vw,5.5rem)];
  }

  .location-copy {
    @apply max-w-[29rem];
  }

  .location-title {
    @apply mb-5;
  }

  .location-description {
    @apply mb-6 max-w-[24rem];
  }

  .location-link {
    @apply inline-flex items-center gap-3 border-b pb-1 text-[1.02rem] font-semibold transition-all duration-200;
    border-color: rgba(38, 31, 27, 0.24);
    color: #261f1b;
  }

  .location-link:hover,
  .location-link:focus-visible {
    border-color: #8a6f62;
    color: #8a6f62;
  }

  .location-link:hover .location-link-arrow,
  .location-link:focus-visible .location-link-arrow {
    transform: translateX(0.125rem);
  }

  .location-link-arrow {
    @apply text-[1.05rem] leading-none transition-transform duration-200;
  }

  .location-media-frame {
    @apply relative h-[20rem] overflow-hidden rounded-[1.85rem] bg-[#f4ece1] sm:h-[24rem] lg:h-[28rem];
    border: 1px solid rgba(96, 78, 66, 0.14);
    box-shadow: 0 24px 70px rgba(68, 49, 37, 0.12);
  }

  .location-media-inner-border {
    @apply pointer-events-none absolute inset-[0.85rem] z-[1] rounded-[1.2rem];
    border: 1px solid rgba(255, 255, 255, 0.46);
  }

  .location-media-overlay {
    @apply pointer-events-none absolute inset-0;
    background: linear-gradient(180deg, rgba(255, 253, 249, 0.04) 0%, rgba(255, 253, 249, 0) 34%, rgba(38, 31, 27, 0.04) 100%);
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
    border: 1px solid rgba(96, 78, 66, 0.14);
    box-shadow: inset 0 0 0 1px rgba(255, 255, 255, 0.25);
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
    border-top: 1px solid rgba(96, 78, 66, 0.16);
  }

  .timeline-item--last {
    border-bottom: 1px solid rgba(96, 78, 66, 0.16);
  }

  .timeline-time {
    @apply m-0 text-[0.9rem] font-bold uppercase tracking-[0.12em];
    color: #8a6f62;
  }

  .timeline-title {
    @apply mb-1 text-[1.05rem] font-bold leading-[1.45];
    color: #261f1b;
  }

  .timeline-description {
    @apply m-0 text-[1rem] leading-[1.8];
    color: #3f342e;
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

  @media (prefers-reduced-motion: no-preference) {
    .location-media-shell {
      animation: location-media-enter 700ms cubic-bezier(0.2, 0.8, 0.2, 1) both;
    }
  }

  @keyframes location-media-enter {
    from {
      opacity: 0;
      transform: translateY(18px) scale(0.985);
    }

    to {
      opacity: 1;
      transform: translateY(0) scale(1);
    }
  }

  :global(body) {
    margin: 0;
  }
</style>
