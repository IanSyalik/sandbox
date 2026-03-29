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
  const innerClass = 'mx-auto w-full max-w-[1000px] px-6 sm:px-6'
  const sectionClass = 'scroll-mt-24 border-t border-[rgba(96,78,66,0.16)] bg-[#fffdf9] py-[clamp(3rem,7vw,5rem)]'
  const navLinkClass = 'text-[0.92rem] font-medium tracking-[0.02em] text-[#4d4038] transition-colors duration-150 hover:text-[#261f1b] focus-visible:text-[#261f1b]'
  const displayH2Class = "mb-6 font-['Rouge_Script'] text-[clamp(3.1rem,7vw,4.8rem)] leading-[0.92] text-[#4d4038]"
  const bodyTextClass = 'text-[1rem] leading-[1.8] text-[#3f342e]'
  const buttonBaseClass = 'inline-flex min-h-[2.9rem] items-center justify-center rounded-full border px-5 py-3 text-[0.95rem] font-semibold leading-none transition-all duration-150'
  const primaryButtonClass = `${buttonBaseClass} border-[#261f1b] bg-[#261f1b] text-[#fffdf9] hover:-translate-y-px hover:border-[#3b302a] hover:bg-[#3b302a] focus-visible:-translate-y-px focus-visible:border-[#3b302a] focus-visible:bg-[#3b302a]`
  const secondaryButtonClass = `${buttonBaseClass} border-[#261f1b] bg-transparent text-[#261f1b] hover:-translate-y-px hover:bg-[rgba(38,31,27,0.06)] focus-visible:-translate-y-px focus-visible:bg-[rgba(38,31,27,0.06)]`

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

<main id="main" tabindex="-1" class="bg-[#faf7f2] font-['Inter'] text-[#261f1b]">
  <nav class="sticky top-0 z-20 border-b border-[rgba(96,78,66,0.16)] bg-[rgba(250,247,242,0.88)] backdrop-blur-[14px]">
    <div class={`${innerClass} flex flex-wrap gap-5 py-4`}>
      <a href="#location" class={navLinkClass}>Локация</a>
      <a href="#dress-code" class={navLinkClass}>Дресс-код</a>
      <a href="#day" class={navLinkClass}>Свадебный день</a>
      <a href="#love" class={navLinkClass}>Пожелания</a>
    </div>
  </nav>

  <section class="min-h-[calc(100svh-4.5rem)] bg-[linear-gradient(180deg,#fcfaf6_0%,#f4ece1_100%)] pt-[clamp(2rem,4vw,3rem)] pb-[clamp(3rem,7vw,5rem)]">
    <div class={`${innerClass} grid min-h-[calc(100svh-9rem)] gap-[clamp(2rem,5vw,4rem)]`}>
      <div class="text-center">
        <h1 class="m-0 mb-4 font-['Rouge_Script'] text-[clamp(4.8rem,11vw,8rem)] leading-[0.92] text-[#4d4038]">Jaan & Jana</h1>
        <p class="m-0 text-[0.98rem] font-semibold uppercase tracking-[0.08em] text-[#5f5149]">Saturday / 08.08.2026</p>
      </div>

      <div class="grid items-center gap-[clamp(2rem,5vw,4.5rem)] md:grid-cols-[minmax(0,0.86fr)_minmax(0,1.14fr)]">
        <div class="max-w-[31rem]">
          <p class="mb-4 max-w-[25rem] text-[1.12rem] leading-[1.8] text-[#261f1b]">Мы будем счастливы разделить с вами этот день.</p>
          <p class="mb-6 max-w-[31rem] text-[1rem] leading-[1.8] text-[#3f342e]">
            Дорогие гости, совсем скоро наступит день, который станет началом нашей новой главы — нашей семьи.
            Мы будем счастливы видеть вас рядом, разделить эмоции, смех и любовь этого особенного дня.
          </p>

          <div class="flex flex-wrap items-center gap-4">
            <button type="button" class={primaryButtonClass} on:click={downloadCalendarEvent}>Добавить в календарь</button>
            <a href="#day" class={secondaryButtonClass}>Смотреть тайминг</a>
          </div>
        </div>

        <div class="relative min-h-[20rem] md:min-h-[26rem]" bind:this={heroVisual}>
          <div
            class="relative flex h-full min-h-[22rem] items-end justify-between overflow-hidden rounded-[2rem] border border-[rgba(96,78,66,0.18)] bg-[radial-gradient(circle_at_top_right,rgba(255,255,255,0.7),transparent_34%),linear-gradient(135deg,#ede2d6_0%,#d8c6b6_45%,#b79e8e_100%)] p-6 transition-transform duration-150 will-change-transform md:min-h-[28rem]"
            style={`transform: translate3d(0, ${heroVisualOffset}px, 0);`}
          >
            <div class="pointer-events-none absolute inset-4 rounded-[1.4rem] border border-[rgba(255,255,255,0.38)]"></div>
            <span class="relative z-[1] text-[0.82rem] font-semibold uppercase tracking-[0.12em] text-[rgba(38,31,27,0.78)]">Фото пары</span>
            <div class="relative z-[1] grid min-w-[6.5rem] gap-[0.15rem] rounded-[1.3rem] border border-[rgba(255,255,255,0.45)] bg-[rgba(255,253,249,0.62)] px-4 pt-[0.9rem] pb-4 text-center backdrop-blur-[6px]">
              <span class="text-[0.75rem] font-bold uppercase tracking-[0.18em] text-[#7c6558]">AUG</span>
              <strong class="text-[2rem] font-bold leading-none text-[#4d4038]">08</strong>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section id="location" class={sectionClass}>
    <div class={`${innerClass} grid gap-8 md:grid-cols-[minmax(0,1fr)_minmax(17rem,0.68fr)] md:gap-[clamp(2rem,6vw,5rem)]`}>
      <div class="max-w-[37rem]">
        <h2 class={displayH2Class}>Location</h2>
        <p class={`${bodyTextClass} mb-4`}>
          Мы выбрали уютное и атмосферное место, где сможем провести этот день в тёплой и близкой компании.
        </p>
        <p>
          <a
            href="https://maps.google.com/?q=Yayaki+House,+Narva+mnt+7,+Tallinn"
            target="_blank"
            rel="noreferrer"
            class="border-b border-[rgba(38,31,27,0.24)] text-[1.02rem] font-semibold text-[#261f1b] transition-colors duration-150 hover:border-[#8a6f62] hover:text-[#8a6f62] focus-visible:border-[#8a6f62] focus-visible:text-[#8a6f62]"
          >
            Yayaki House, Narva mnt 7, 2 этаж
          </a>
        </p>
      </div>
    </div>
  </section>

  <section id="dress-code" class={sectionClass}>
    <div class={`${innerClass} grid gap-8 md:grid-cols-[minmax(0,1fr)_minmax(17rem,0.68fr)] md:gap-[clamp(2rem,6vw,5rem)]`}>
      <div class="max-w-[37rem]">
        <h2 class={displayH2Class}>Dress Code</h2>
        <p class={bodyTextClass}>
          Мы будем рады видеть девушек в нарядах в нежных пастельных оттенках, а мужчин в классике.
        </p>
      </div>

      <div class="flex flex-wrap items-center gap-[0.9rem] self-center" aria-label="Палитра дресс-кода">
        <span class="inline-block h-14 w-14 rounded-full border border-[rgba(96,78,66,0.14)] bg-[#f1e4de]"></span>
        <span class="inline-block h-14 w-14 rounded-full border border-[rgba(96,78,66,0.14)] bg-[#e7d8cb]"></span>
        <span class="inline-block h-14 w-14 rounded-full border border-[rgba(96,78,66,0.14)] bg-[#ddd8e2]"></span>
        <span class="inline-block h-14 w-14 rounded-full border border-[rgba(96,78,66,0.14)] bg-[#d7e2d8]"></span>
        <span class="inline-block h-14 w-14 rounded-full border border-[rgba(96,78,66,0.14)] bg-[#f2e9d9]"></span>
      </div>
    </div>
  </section>

  <section id="day" class={sectionClass}>
    <div class={`${innerClass} grid gap-8`}>
      <div class="max-w-[37rem]">
        <h2 class={displayH2Class}>Wedding Day</h2>
      </div>

      <ol class="m-0 list-none p-0">
        <li class="grid gap-2 border-t border-[rgba(96,78,66,0.16)] py-5 md:grid-cols-[minmax(5rem,6rem)_minmax(0,1fr)] md:gap-6">
          <p class="m-0 text-[0.9rem] font-bold uppercase tracking-[0.12em] text-[#8a6f62]">14:30</p>
          <div>
            <h3 class="mb-1 text-[1.05rem] font-bold leading-[1.45] text-[#261f1b]">Церемония в ЗАГСе Таллинна</h3>
            <p class="m-0 text-[1rem] leading-[1.8] text-[#3f342e]">Тот самый момент, когда мы скажем друг другу «да».</p>
          </div>
        </li>
        <li class="grid gap-2 border-t border-[rgba(96,78,66,0.16)] py-5 md:grid-cols-[minmax(5rem,6rem)_minmax(0,1fr)] md:gap-6">
          <p class="m-0 text-[0.9rem] font-bold uppercase tracking-[0.12em] text-[#8a6f62]">15:00</p>
          <div>
            <h3 class="mb-1 text-[1.05rem] font-bold leading-[1.45] text-[#261f1b]">Фотографии</h3>
            <p class="m-0 text-[1rem] leading-[1.8] text-[#3f342e]">Сохраним первые мгновения этого дня — искренние улыбки, объятия и эмоции.</p>
          </div>
        </li>
        <li class="grid gap-2 border-t border-[rgba(96,78,66,0.16)] py-5 md:grid-cols-[minmax(5rem,6rem)_minmax(0,1fr)] md:gap-6">
          <p class="m-0 text-[0.9rem] font-bold uppercase tracking-[0.12em] text-[#8a6f62]">16:00</p>
          <div>
            <h3 class="mb-1 text-[1.05rem] font-bold leading-[1.45] text-[#261f1b]">Начало праздника</h3>
            <p class="m-0 text-[1rem] leading-[1.8] text-[#3f342e]">Соберёмся вместе, чтобы поздравить, обнять и разделить радость этого дня.</p>
          </div>
        </li>
        <li class="grid gap-2 border-t border-[rgba(96,78,66,0.16)] py-5 md:grid-cols-[minmax(5rem,6rem)_minmax(0,1fr)] md:gap-6">
          <p class="m-0 text-[0.9rem] font-bold uppercase tracking-[0.12em] text-[#8a6f62]">18:00</p>
          <div>
            <h3 class="mb-1 text-[1.05rem] font-bold leading-[1.45] text-[#261f1b]">Вечер и танцы</h3>
            <p class="m-0 text-[1rem] leading-[1.8] text-[#3f342e]">Время наслаждаться атмосферой, музыкой и друг другом.</p>
          </div>
        </li>
        <li class="grid gap-2 border-y border-[rgba(96,78,66,0.16)] py-5 md:grid-cols-[minmax(5rem,6rem)_minmax(0,1fr)] md:gap-6">
          <p class="m-0 text-[0.9rem] font-bold uppercase tracking-[0.12em] text-[#8a6f62]">21:00</p>
          <div>
            <h3 class="mb-1 text-[1.05rem] font-bold leading-[1.45] text-[#261f1b]">Торт-сюрприз</h3>
            <p class="m-0 text-[1rem] leading-[1.8] text-[#3f342e]">Сладкое завершение этого особенного дня.</p>
          </div>
        </li>
      </ol>
    </div>
  </section>

  <section id="love" class={sectionClass}>
    <div class={`${innerClass} grid gap-8 md:grid-cols-[minmax(15rem,0.7fr)_minmax(0,1.3fr)]`}>
      <div class="max-w-[37rem]">
        <h2 class={displayH2Class}>With Love</h2>
      </div>

      <div class="max-w-[38rem]">
        <p class={`${bodyTextClass} mb-4`}>Мы очень ценим ваше внимание и заботу.</p>
        <p class={`${bodyTextClass} mb-4`}>
          И будем очень благодарны, если вы обойдетесь без подарков в виде картин и предметов декора.
          Если вы хотите порадовать нас, приятным и удобным вариантом станет конверт.
        </p>
        <p class={`${bodyTextClass} mb-4`}>
          Ваши тёплые слова и поздравления мы с радостью примем, когда соберёмся вместе после ЗАГСа.
        </p>
        <p class={`${bodyTextClass} mb-4`}>
          Пожалуйста, приходите в ЗАГС не менее чем за 15 минут до начала церемонии.
        </p>
        <p class={`${bodyTextClass} m-0`}>Самое главное для нас — это ваше присутствие и разделённая с нами радость этого дня.</p>
      </div>
    </div>
  </section>

  <section id="calendar" class={`${sectionClass} bg-[#f8f3ec]`}>
    <div class={`${innerClass} flex flex-wrap items-end justify-between gap-x-8 gap-y-6`}>
      <div class="max-w-[37rem]">
        <h2 class={displayH2Class}>Calendar</h2>
        <p class={`${bodyTextClass} m-0`}>Добавьте этот день в календарь, чтобы сохранить дату нашего праздника.</p>
      </div>

      <div class="flex flex-wrap items-center gap-4">
        <button type="button" class={primaryButtonClass} on:click={downloadCalendarEvent}>Добавить в календарь</button>
        <a href={googleCalendarUrl} target="_blank" rel="noreferrer" class={secondaryButtonClass}>Открыть Google Календарь</a>
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
  }
</style>
