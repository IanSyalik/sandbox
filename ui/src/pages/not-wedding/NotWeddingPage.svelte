<script lang="ts">
  import {onMount} from 'svelte'

  import withLovePhoto from './with love.JPG?url'
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
  import NotWeddingLocation from './NotWeddingLocation.svelte'
  import NotWeddingTimeline from './NotWeddingTimeline.svelte'

  type NavItem = {
    href: string,
    label: string,
  }

  type HeroPanelImage = {
    src: string,
    label: string,
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

  let heroSectionElement: HTMLElement | null = null
  let heroGlowOffset = 0
  let heroNamesOffset = 0
  let heroGalleryOffset = 0
  let heroCopyOffset = 0

  onMount(() => {
    if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
      return
    }

    let frameId = 0

    const updateHeroParallax = () => {
      frameId = 0

      if (!heroSectionElement) {
        return
      }

      const {top, height} = heroSectionElement.getBoundingClientRect()
      const travel = Math.min(Math.max(-top, 0), height)

      heroGlowOffset = travel * 0.18
      heroNamesOffset = travel * 0.08
      heroGalleryOffset = travel * 0.14
      heroCopyOffset = travel * 0.05
    }

    const onScroll = () => {
      if (frameId) {
        return
      }

      frameId = window.requestAnimationFrame(updateHeroParallax)
    }

    updateHeroParallax()
    window.addEventListener('scroll', onScroll, {passive: true})
    window.addEventListener('resize', onScroll)

    return () => {
      if (frameId) {
        window.cancelAnimationFrame(frameId)
      }

      window.removeEventListener('scroll', onScroll)
      window.removeEventListener('resize', onScroll)
    }
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

  <section class="hero-section" bind:this={heroSectionElement}>
    <div class="hero-glow" style={`transform: translate3d(0, ${heroGlowOffset}px, 0);`}></div>
    <div class="hero-names-shell" style={`transform: translate3d(0, ${heroNamesOffset}px, 0);`}>
      <NotWeddingHeroNamesDate containerClass="pb-1.5"/>
    </div>
    <div class="hero-shell" style={`transform: translate3d(0, ${heroGalleryOffset}px, 0);`}>
      <div class="hero-gallery">
        <h1 class="hero-title">
          Save
          the
          Date
        </h1>
        {#each heroPanelImages as heroPanelImage}
          <div class="hero-panel-frame">
            <div class="hero-panel-label hero-panel-label--color">{heroPanelImage.label}</div>
            <div
              class="hero-panel relative"
              style={`--hero-panel-image: url(${heroPanelImage.src});`}
            >
              <div class="hero-panel-label hero-panel-label--white">{heroPanelImage.label}</div>
            </div>
          </div>
        {/each}
      </div>
    </div>
    <div class="hero-copy" style={`transform: translate3d(0, ${heroCopyOffset}px, 0);`}>
      <h3 class="hero-copy-title">Мы будем счастливы разделить с вами
        этот день.</h3>
      <p class="hero-copy-text">
        Дорогие гости, совсем скоро наступит день, который станет началом нашей новой главы — нашей семьи.
        Мы будем счастливы видеть вас рядом, разделить эмоции, смех и любовь этого особенного дня.
      </p>
      <div class="hero-copy-actions">
        <button type="button" class="button button--primary" on:click={downloadCalendarEvent}>Добавить в календарь
        </button>
        <a href="#day" class="button button--secondary">Программа</a>
      </div>
    </div>

  </section>

  <NotWeddingLocation />

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

  <NotWeddingTimeline />

  <section
    id="love"
    class="section-shell love-section"
    style={`--love-photo: url(${withLovePhoto});`}
  >
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
          Если захотите присоединиться к нам в ЗАГСе, пожалуйста, приходите не менее чем за 15 минут до начала церемонии.
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
    @apply relative flex min-h-[calc(100svh-4.5rem)] flex-col lg:justify-center gap-8 overflow-hidden px-4 py-5 sm:gap-8 sm:py-8 lg:gap-14;
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

  .hero-names-shell,
  .hero-shell,
  .hero-copy,
  .hero-glow {
    will-change: transform;
  }

  .hero-shell {
    @apply relative mx-auto flex w-full max-w-[1200px] flex-col justify-center;
  }

  .hero-gallery {
    @apply grid w-full grid-cols-3 items-stretch gap-2 sm:gap-4 lg:flex lg:flex-row lg:gap-10;
  }

  .hero-title {
    @apply col-span-3 pb-6 lg:py-1 text-center font-['Bodoni_Moda'] text-[2.85rem] leading-[0.92] whitespace-normal uppercase tracking-[-0.05em] text-transparent sm:py-2 sm:text-[4.4rem] lg:py-4 lg:pr-6 lg:text-left lg:text-[8rem] lg:leading-[1.1] lg:whitespace-pre-line lg:tracking-[-0.04em];
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
    @apply relative h-[16rem] min-w-0 flex-none lg:flex lg:h-auto lg:min-h-[29rem] lg:flex-1;
  }

  .hero-panel {
    @apply flex h-full w-full flex-1 overflow-hidden rounded-t-full rounded-b-full bg-cover bg-center bg-no-repeat;
    background-image: linear-gradient(
        180deg,
        color-mix(in srgb, var(--color-nw-50) 8%, transparent) 0%,
        color-mix(in srgb, var(--color-nw-50) 2%, transparent) 40%,
        color-mix(in srgb, var(--color-nw-900) 8%, transparent) 100%
      ),
      var(--hero-panel-image);
  }

  .hero-panel-label {
    @apply absolute bottom-0 right-0 -mb-0.5 -mr-0.5 text-right font-['Bodoni_Moda'] text-[3.5rem] leading-[0.9] sm:-mb-1 sm:-mr-1 sm:text-[4.75rem] lg:text-[6rem] lg:leading-[1];
  }

  .hero-panel-label--color {
    @apply text-transparent;
    background-image: linear-gradient(
      180deg,
      color-mix(in srgb, var(--color-nw-600) 88%, transparent) 0%,
      var(--color-nw-700) 35%,
      var(--color-nw-900) 100%
    );
    -webkit-background-clip: text;
    background-clip: text;
  }

  .hero-panel-label--white {
    @apply text-white;
    text-shadow: 0 10px 28px color-mix(in srgb, var(--color-nw-900) 22%, transparent);
  }

  .hero-copy {
    @apply mx-auto flex min-w-0 max-w-[38rem] flex-col items-center justify-center gap-2 px-2 text-center sm:max-w-[42rem] sm:gap-3 lg:max-w-[60rem];
  }

  .hero-copy-title {
    @apply font-['Bodoni_Moda'] text-[1.5rem] leading-[1.12] text-nw-900 sm:text-[1.8rem] lg:text-[2.2rem];
  }

  .hero-copy-text {
    @apply max-w-[32rem] pb-1 text-center text-[0.95rem] leading-[1.65] text-nw-800 sm:pb-4 sm:text-[1rem] sm:leading-[1.75];
  }

  .hero-copy-actions {
    @apply flex w-full flex-col items-stretch gap-2 sm:w-auto sm:flex-row sm:items-center sm:gap-4;
  }

  .hero-copy-actions :global(.button) {
    @apply w-full sm:w-auto;
  }

  .section-shell {
    @apply scroll-mt-24 py-8 sm:py-16 lg:py-20;
    border-top: 1px solid color-mix(in srgb, var(--color-nw-800) 16%, transparent);
    background: var(--color-nw-50);
  }

  .section-shell--muted {
    @apply bg-nw-300;
  }

  .section-title {
    @apply mb-4 font-['Rouge_Script'] text-[3.1rem] leading-[0.92] text-nw-800 sm:mb-6 sm:text-[4rem] lg:text-[4.8rem];
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

  .dress-code-shell {
    @apply flex flex-col items-center gap-6 text-center sm:gap-8;
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

  .love-grid {
    @apply relative z-[1] grid gap-5 md:grid-cols-[minmax(15rem,0.7fr)_minmax(0,1.3fr)] md:gap-8;
  }

  .love-heading {
    @apply max-w-[37rem];
  }

  .love-copy {
    @apply max-w-[40rem] rounded-[1.75rem] px-5 py-6 sm:px-8 sm:py-8;
    background: color-mix(in srgb, var(--color-nw-50) 74%, transparent);
    border: 1px solid color-mix(in srgb, var(--color-nw-50) 38%, transparent);
    box-shadow: 0 24px 70px color-mix(in srgb, var(--color-nw-900) 14%, transparent);
    backdrop-filter: blur(10px);
  }

  .love-copy .body-text {
    @apply text-[0.98rem] leading-[1.9] text-nw-800 sm:text-[1.03rem];
  }

  .love-copy .love-paragraph:first-child {
    @apply font-['Bodoni_Moda'] text-[1.22rem] leading-[1.35] tracking-[0.01em] text-nw-900 sm:text-[1.35rem];
  }

  .love-paragraph {
    @apply mb-3 sm:mb-4;
  }

  .love-copy .m-0 {
    @apply font-['Bodoni_Moda'] text-[1.08rem] leading-[1.55] tracking-[0.01em] text-nw-900 sm:text-[1.18rem];
  }

  .love-section {
    @apply relative overflow-hidden;
    background-image:
      linear-gradient(
        180deg,
        color-mix(in srgb, var(--color-nw-50) 18%, transparent) 0%,
        color-mix(in srgb, var(--color-nw-50) 10%, transparent) 30%,
        color-mix(in srgb, var(--color-nw-900) 28%, transparent) 100%
      ),
      var(--love-photo);
    background-position: 50% 50%;
    background-size: cover;
  }

  .calendar-shell {
    @apply flex flex-wrap items-end justify-between gap-x-8 gap-y-4 sm:gap-y-6;
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
