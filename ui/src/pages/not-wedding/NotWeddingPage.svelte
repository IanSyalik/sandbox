<script lang="ts">
  import withLovePhoto from './with love.JPG?url'
  import dressCodeSwatch1 from './colors/IMG_6229.JPG?url'
  import dressCodeSwatch2 from './colors/IMG_6230.JPG?url'
  import dressCodeSwatch3 from './colors/IMG_6231.JPG?url'
  import dressCodeSwatch4 from './colors/IMG_6232.JPG?url'
  import dressCodeSwatch5 from './colors/IMG_6233.JPG?url'
  import dressCodeSwatch6 from './colors/IMG_6234.JPG?url'
  import heroPanelPhoto1 from './1.JPG?url'
  import heroPanelPhoto2 from './2.JPG?url'
  import heroPanelPhoto3 from './3.jpg?url'
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
    googleStartUtc: '20260808T110000Z'
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

  let isMobileNavOpen = false

  function toggleMobileNav() {
    isMobileNavOpen = !isMobileNavOpen
  }

  function closeMobileNav() {
    isMobileNavOpen = false
  }
</script>

<svelte:head>
  <title>Jaan & Jana</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
  <link href="https://fonts.googleapis.com/css2?family=Bodoni+Moda:wght@400;500;600;700;800&family=Inter:wght@400;500;600;700;800&family=Rouge+Script&display=swap" rel="stylesheet">
</svelte:head>

<main id="main" tabindex="-1" class="page-main">
  <nav class="site-nav">
    <div class="nw-page-inner site-nav-inner">
      <div class="site-nav-start">
        <button
          type="button"
          class="site-nav-toggle"
          aria-expanded={isMobileNavOpen}
          aria-controls="mobile-nav-menu"
          aria-label={isMobileNavOpen ? 'Закрыть меню' : 'Открыть меню'}
          on:click={toggleMobileNav}
        >
          <span class={`site-nav-toggle-line ${isMobileNavOpen ? 'site-nav-toggle-line--top-open' : ''}`}></span>
          <span class={`site-nav-toggle-line ${isMobileNavOpen ? 'site-nav-toggle-line--middle-open' : ''}`}></span>
          <span class={`site-nav-toggle-line ${isMobileNavOpen ? 'site-nav-toggle-line--bottom-open' : ''}`}></span>
        </button>

        <div class="site-nav-links">
        {#each navItems as item}
          <a href={item.href} class="nav-link">{item.label}</a>
        {/each}
        </div>
      </div>

      <button type="button" class="nw-button nw-button-small nw-button-primary site-nav-button" on:click={() => {
        closeMobileNav()
        downloadCalendarEvent()
      }}>
        Добавить в календарь
      </button>
    </div>

    {#if isMobileNavOpen}
      <div id="mobile-nav-menu" class="nw-page-inner site-nav-mobile-menu">
        {#each navItems as item}
          <a href={item.href} class="site-nav-mobile-link" on:click={closeMobileNav}>{item.label}</a>
        {/each}
      </div>
    {/if}
  </nav>

  <section class="hero-section">
    <div class="hero-glow"></div>
    <div class="hero-names-shell">
      <NotWeddingHeroNamesDate containerClass="pb-1.5"/>
    </div>
    <div class="hero-shell">
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
    <div class="hero-copy">
      <h3 class="hero-copy-title">Мы будем счастливы разделить с вами
        этот день.</h3>
      <p class="hero-copy-text">
        Дорогие гости, совсем скоро наступит день, который станет началом нашей новой главы — нашей семьи.
        Мы будем счастливы видеть вас рядом, разделить эмоции, смех и любовь этого особенного дня.
      </p>
      <div class="hero-copy-actions">
        <button type="button" class="nw-button nw-button-primary" on:click={downloadCalendarEvent}>Добавить в календарь
        </button>
        <a href="#day" class="nw-button nw-button-secondary">Программа</a>
      </div>
    </div>
  </section>

  <NotWeddingLocation/>

  <section id="dress-code" class="nw-section">
    <div class="nw-page-inner dress-code-shell">
      <div class="dress-code-copy">
        <h2 class="nw-section-title">Dress Code</h2>
        <p class="nw-body-text">
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

  <NotWeddingTimeline/>

  <section
    id="love"
    class="nw-section love-section relative overflow-hidden lg:py-20 p-0"
    style={`--love-photo: url(${withLovePhoto});`}
  >
    <div class="lg:nw-page-inner relative flex min-h-[50rem] items-end justify-center lg:items-center">
      <div class="nw-glass-card w-full max-w-none text-center lg:max-w-[36rem] lg:rounded-[1.75rem] flex flex-col gap-3">
        <h2 class="nw-section-title mb-0">With Love</h2>
        <p class="text-xl font-['Bodoni_Moda']">Мы очень ценим ваше внимание и заботу.</p>
        <p>
          И будем очень благодарны, если вы обойдетесь без подарков в виде картин и предметов декора.
          Если вы хотите порадовать нас, приятным и удобным вариантом станет конверт.
        </p>
        <p>
          Ваши тёплые слова и поздравления мы с радостью примем, когда соберёмся вместе после ЗАГСа.
        </p>
        <p>
          Если захотите присоединиться к нам в ЗАГСе, пожалуйста, приходите не менее чем за 15 минут до начала
          церемонии.
        </p>
        <p>Самое главное для нас — это ваше присутствие и разделённая с нами радость
          этого дня.</p>
      </div>
    </div>
  </section>

  <footer class="nw-section nw-footer">
    <div class="nw-page-inner">
      <p class="nw-footer-label">Tallinn 2026</p>
    </div>
  </footer>

</main>

<style lang="postcss">
  @reference "./../../global.css";

  @media (prefers-reduced-motion: no-preference) {
    :global(html) {
      scroll-behavior: smooth;
    }
  }

  .page-main {
    @apply bg-nw-200 text-nw-900 font-['Inter'];
  }

  .site-nav {
    @apply sticky top-0 z-20 backdrop-blur-[14px];
    background: color-mix(in srgb, var(--color-nw-200) 88%, transparent);
  }

  .site-nav-inner {
    @apply flex items-center justify-between gap-4 py-4;
  }

  .site-nav-start {
    @apply flex min-w-0 flex-1 items-center gap-4;
  }

  .site-nav-links {
    @apply hidden min-w-0 flex-1 flex-wrap items-center gap-x-5 gap-y-2 lg:flex;
  }

  .site-nav-button {
    @apply shrink-0;
  }

  .site-nav-toggle {
    @apply relative flex h-11 w-11 shrink-0 items-center justify-center rounded-full border border-nw-700/20 bg-nw-50/70 text-nw-900 backdrop-blur-sm transition-colors duration-200 lg:hidden;
  }

  .site-nav-toggle-line {
    @apply absolute h-px w-5 bg-current transition-all duration-200;
  }

  .site-nav-toggle-line:nth-child(1) {
    transform: translateY(-0.35rem);
  }

  .site-nav-toggle-line:nth-child(3) {
    transform: translateY(0.35rem);
  }

  .site-nav-toggle-line--top-open {
    transform: rotate(45deg) !important;
  }

  .site-nav-toggle-line--middle-open {
    opacity: 0;
  }

  .site-nav-toggle-line--bottom-open {
    transform: rotate(-45deg) !important;
  }

  .site-nav-mobile-menu {
    @apply flex flex-col gap-2 pb-4 lg:hidden;
  }

  .site-nav-mobile-link {
    @apply nw-font-nav rounded-[1.1rem] border border-nw-700/12 bg-nw-50/72 px-4 py-3 text-nw-900 backdrop-blur-sm transition-colors duration-150;
  }

  .nav-link {
    @apply nw-font-nav text-nw-800 transition-colors duration-150;
  }

  .nav-link:hover,
  .nav-link:focus-visible {
    @apply text-nw-900;
  }

  .hero-section {
    @apply relative flex min-h-[calc(100svh-4.5rem)] flex-col gap-8 overflow-hidden px-4 py-5 justify-center lg:gap-6;
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

  .hero-gallery {
    @apply grid w-full grid-cols-3 items-stretch gap-2 lg:flex lg:flex-row lg:gap-10;
  }

  .hero-title {
    @apply nw-font-hero-title col-span-3 pb-6 text-center text-transparent lg:py-4 lg:pr-6 lg:text-left;
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
    @apply relative h-[20rem] min-w-0 flex-none lg:flex lg:h-auto lg:min-h-[29rem] lg:flex-1;
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
    @apply nw-font-hero-panel-label absolute bottom-0 right-0 -mb-0.5 -mr-0.5 text-right lg:-mb-1 lg:-mr-1;
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
    @apply text-nw-50;
    text-shadow: 0 10px 28px color-mix(in srgb, var(--color-nw-900) 22%, transparent);
  }

  .hero-copy {
    @apply mx-auto flex min-w-0 max-w-[38rem] flex-col items-center justify-center gap-2 px-2 text-center lg:max-w-[60rem] lg:gap-3;
  }

  .hero-copy-title {
    @apply nw-font-hero-copy-title text-nw-900;
  }

  .hero-copy-text {
    @apply max-w-[32rem] pb-1 text-center text-nw-800 lg:pb-4;
  }

  .hero-copy-actions {
    @apply flex w-full flex-col items-stretch gap-2 lg:w-auto lg:flex-row lg:items-center lg:gap-4;
  }

  .hero-copy-actions :global(.nw-button) {
    @apply w-full lg:w-auto;
  }

  .dress-code-shell {
    @apply flex flex-col items-center gap-6 text-center lg:gap-8;
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

  .love-section {
    background-image: linear-gradient(
      180deg,
      color-mix(in srgb, var(--color-nw-50) 18%, transparent) 0%,
      color-mix(in srgb, var(--color-nw-50) 10%, transparent) 30%,
      color-mix(in srgb, var(--color-nw-900) 28%, transparent) 100%
    ),
    var(--love-photo);
    background-position: 50% 50%;
    background-size: cover;
  }

  .nw-footer {
    @apply bg-nw-900 py-3 lg:py-4;
  }

  .nw-footer-label {
    @apply m-0 text-center font-['Bodoni_Moda'] text-[1rem] uppercase tracking-[0.18em] text-nw-300;
  }

  :global(body) {
    margin: 0;
  }
</style>
