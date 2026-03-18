<script lang="ts">
  import {onMount} from 'svelte'

  const schedule = [
    {time: '14:00', title: 'Ceremony', details: 'Glasshouse Garden. Please arrive 20 minutes early for welcome drinks.'},
    {time: '16:00', title: 'Dinner', details: 'Seasonal dinner under the orangery lights, followed by speeches and music.'},
    {time: '19:30', title: 'Golden Hour', details: 'Courtyard portraits, dessert table, and the first dance as the sun drops.'},
    {time: '21:00', title: 'Party', details: 'Cocktail bar, midnight snacks, and a dance floor that should stay busy.'}
  ]

  const details = [
    {eyebrow: 'Venue', title: 'Metsalu Manor', text: 'A restored country estate with a ceremony garden, indoor dining hall, and overnight cottages for close family.'},
    {eyebrow: 'Dress Code', title: 'Garden Formal', text: 'Think tailored, romantic, and comfortable enough for lawn games, dinner, and a late dance set.'},
    {eyebrow: 'Stay Nearby', title: 'Weekend Plan', text: 'We suggest arriving on Friday, enjoying a slow breakfast on Sunday, and making the whole thing a weekend escape.'}
  ]

  const event = {
    title: 'Jaan & Jana Wedding',
    location: 'Metsalu Manor',
    description: 'Join us for our wedding celebration at Metsalu Manor.',
    localStart: '20260921T140000',
    localEnd: '20260921T235900',
    googleStartUtc: '20260921T110000Z',
    googleEndUtc: '20260921T205900Z',
    timeZone: 'Europe/Tallinn'
  }

  let heroSection: HTMLElement | undefined
  let heroTextOffset = 0
  let heroCardsOffset = 0
  let heroGlowOffset = 0
  let reduceMotion = false

  function resetParallax() {
    heroTextOffset = 0
    heroCardsOffset = 0
    heroGlowOffset = 0
  }

  function updateHeroParallax() {
    if (!heroSection || reduceMotion) {
      resetParallax()
      return
    }

    const {top, height} = heroSection.getBoundingClientRect()
    const progress = Math.min(Math.max(-top / Math.max(height, 1), 0), 1.2)

    heroTextOffset = progress * 42
    heroCardsOffset = progress * 84
    heroGlowOffset = progress * 30
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
      `UID:jaan-jana-wedding@sandbox`,
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
  <title>Wedding One Pager</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Rouge+Script&display=swap" rel="stylesheet">
</svelte:head>

<main id="main" tabindex="-1" class="page-shell text-stone-900">
  <div class="page-glow page-glow-left"></div>
  <div class="page-glow page-glow-right"></div>

  <section class="mx-auto flex min-h-screen max-w-6xl flex-col px-5 pb-10 pt-6 sm:px-8 lg:px-10">
    <nav class="ui-font sticky top-4 z-10 mb-10 flex flex-wrap items-center justify-between gap-4 rounded-full border border-white/60 bg-white/70 px-5 py-3 text-sm backdrop-blur">
      <div class="flex items-center gap-3">
        <span class="inline-block h-2 w-2 rounded-full bg-rose-400"></span>
        <span class="font-semibold uppercase tracking-[0.25em] text-stone-500">Wedding Day</span>
      </div>
      <div class="flex flex-wrap gap-4 text-stone-600">
        <a href="#story">Story</a>
        <a href="#day">Day Plan</a>
        <a href="#details">Details</a>
        <a href="#calendar">Calendar</a>
      </div>
    </nav>

    <section bind:this={heroSection} class="relative overflow-hidden rounded-[2rem] border border-white/70 bg-white/80 px-6 py-8 shadow-[0_40px_120px_rgba(91,63,44,0.12)] backdrop-blur sm:px-10 sm:py-12 lg:px-14 lg:py-16">
      <div class="hero-parallax-layer absolute inset-x-0 top-0 h-40 bg-[radial-gradient(circle_at_top,_rgba(250,204,21,0.22),_transparent_55%)]" style={`transform: translate3d(0, ${heroGlowOffset}px, 0);`}></div>
      <div class="grid gap-10 lg:grid-cols-[1.15fr_0.85fr] lg:items-end">
        <div class="hero-parallax-layer relative z-10" style={`transform: translate3d(0, ${heroTextOffset}px, 0);`}>
          <p class="ui-font text-sm font-semibold uppercase tracking-[0.35em] text-rose-500">Saturday, 21 September 2026</p>
          <h1 class="script-heading mt-5 text-6xl leading-none sm:text-7xl lg:text-[6.5rem]">Jaan<br>& Jana</h1>
          <p class="ui-font mt-6 max-w-xl text-lg leading-8 text-stone-600">
            A warm, modern one-pager for your wedding site. Use it for the story, the timeline, the venue notes, and one clear RSVP action.
          </p>

          <div class="ui-font mt-8 flex flex-wrap gap-4">
            <a href="#calendar" class="rounded-full bg-stone-900 px-6 py-3 font-semibold text-white transition hover:bg-stone-700">Add To Calendar</a>
            <a href="#day" class="rounded-full border border-stone-300 px-6 py-3 font-semibold text-stone-700 transition hover:border-stone-900 hover:text-stone-900">View Schedule</a>
          </div>
        </div>

        <div class="hero-parallax-layer relative z-10" style={`transform: translate3d(0, ${heroCardsOffset}px, 0);`}>
          <div class="grid gap-4 sm:grid-cols-3 lg:grid-cols-1">
            <article class="rounded-[1.75rem] bg-stone-900 p-6 text-white">
              <p class="ui-font text-xs uppercase tracking-[0.28em] text-stone-300">Where</p>
              <h3 class="mt-3 text-3xl font-semibold">Metsalu Manor</h3>
              <p class="ui-font mt-3 text-sm leading-7 text-stone-300">A garden ceremony, candlelit dinner, and a long-table celebration in the countryside.</p>
            </article>
            <article class="rounded-[1.75rem] bg-amber-100 p-6">
              <p class="ui-font text-xs uppercase tracking-[0.28em] text-amber-700">Weekend Mood</p>
              <p class="mt-3 text-3xl font-semibold">Slow morning, golden evening, loud dance floor.</p>
            </article>
            <article class="rounded-[1.75rem] bg-rose-100 p-6">
              <p class="ui-font text-xs uppercase tracking-[0.28em] text-rose-700">Dress Code</p>
              <p class="mt-3 text-3xl font-semibold">Garden formal with room to move.</p>
            </article>
          </div>
        </div>
      </div>
    </section>

    <section id="story" class="scroll-mt-28 grid gap-8 py-14 lg:grid-cols-[0.85fr_1.15fr]">
      <div class="rounded-[2rem] bg-[#f5eee6] p-8">
        <p class="ui-font text-xs font-semibold uppercase tracking-[0.3em] text-stone-500">Our Story</p>
        <h2 class="script-heading mt-4 text-5xl leading-tight">Built for a couple who wants one elegant page instead of five tiny ones.</h2>
      </div>

      <div class="grid gap-6">
        <article class="rounded-[2rem] border border-white/70 bg-white/75 p-8 shadow-sm">
          <p class="ui-font text-sm uppercase tracking-[0.28em] text-stone-400">How To Use It</p>
          <p class="ui-font mt-4 text-base leading-8 text-stone-600">
            Replace the names, date, and venue first. Then swap in your own story, add your meal and travel details, and connect the RSVP button to a form or external link.
          </p>
        </article>
        <article class="rounded-[2rem] border border-white/70 bg-white/75 p-8 shadow-sm">
          <p class="ui-font text-sm uppercase tracking-[0.28em] text-stone-400">Visual Direction</p>
          <p class="ui-font mt-4 text-base leading-8 text-stone-600">
            This template leans editorial rather than rustic: warm neutrals, serif headlines, soft gradients, and enough structure to feel premium without being stiff.
          </p>
        </article>
      </div>
    </section>

    <section id="day" class="scroll-mt-28 rounded-[2rem] bg-stone-900 px-6 py-10 text-white sm:px-10">
      <div class="flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <p class="ui-font text-xs font-semibold uppercase tracking-[0.3em] text-stone-400">Day Plan</p>
          <h2 class="script-heading mt-3 text-5xl">A simple rhythm for the whole celebration.</h2>
        </div>
        <p class="ui-font max-w-md text-sm leading-7 text-stone-300">
          Keep the structure clean. Guests should understand the flow in ten seconds.
        </p>
      </div>

      <div class="mt-10 grid gap-4 lg:grid-cols-2">
        {#each schedule as item}
          <article class="rounded-[1.5rem] border border-white/10 bg-white/5 p-6">
            <p class="ui-font text-xs font-semibold uppercase tracking-[0.3em] text-amber-300">{item.time}</p>
            <h3 class="mt-3 text-3xl font-semibold">{item.title}</h3>
            <p class="ui-font mt-3 text-sm leading-7 text-stone-300">{item.details}</p>
          </article>
        {/each}
      </div>
    </section>

    <section id="details" class="scroll-mt-28 py-14">
      <div class="mb-8 flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <p class="ui-font text-xs font-semibold uppercase tracking-[0.3em] text-stone-500">Need To Know</p>
          <h2 class="script-heading mt-3 text-5xl text-stone-900">Everything important in one scroll.</h2>
        </div>
        <p class="ui-font max-w-lg text-sm leading-7 text-stone-600">
          This section works well for venue notes, accommodation, transport, or anything guests would normally miss in a long email.
        </p>
      </div>

      <div class="grid gap-5 lg:grid-cols-3">
        {#each details as item}
          <article class="rounded-[1.75rem] border border-stone-200 bg-white/80 p-7 shadow-sm">
            <p class="ui-font text-xs font-semibold uppercase tracking-[0.28em] text-rose-500">{item.eyebrow}</p>
            <h3 class="mt-3 text-3xl font-semibold text-stone-900">{item.title}</h3>
            <p class="ui-font mt-4 text-sm leading-7 text-stone-600">{item.text}</p>
          </article>
        {/each}
      </div>
    </section>

    <section class="pb-14">
      <div class="grid gap-5 sm:grid-cols-2">
        <div class="gallery-card gallery-tall">
          <span>Hero photo</span>
        </div>
        <div class="gallery-card">
          <span>Ceremony corner</span>
        </div>
        <div class="gallery-card">
          <span>Tablescape</span>
        </div>
        <div class="gallery-card gallery-wide sm:col-span-2">
          <span>Replace these placeholders with your own images, illustrations, or venue shots.</span>
        </div>
      </div>
    </section>

    <section id="calendar" class="scroll-mt-28 overflow-hidden rounded-[2rem] bg-[linear-gradient(135deg,#3b2f2f_0%,#6e4d3f_45%,#d18b73_100%)] px-6 py-10 text-white shadow-[0_32px_80px_rgba(92,56,38,0.28)] sm:px-10">
      <div class="grid gap-8 lg:grid-cols-[1.05fr_0.95fr] lg:items-center">
        <div>
          <p class="ui-font text-xs font-semibold uppercase tracking-[0.3em] text-amber-100/80">Save The Date</p>
          <h2 class="script-heading mt-3 text-5xl">Add the wedding to your calendar in one click.</h2>
          <p class="ui-font mt-5 max-w-xl text-base leading-8 text-amber-50/85">
            Replace the event details if needed, then let guests save the full day straight from the page.
          </p>
        </div>

        <div class="rounded-[1.75rem] bg-white/12 p-6 backdrop-blur">
          <p class="ui-font text-sm uppercase tracking-[0.28em] text-amber-100/75">Calendar Actions</p>
          <div class="ui-font mt-5 flex flex-wrap gap-3">
            <button type="button" class="inline-flex rounded-full bg-white px-6 py-3 font-semibold text-stone-900 transition hover:bg-amber-50" on:click={downloadCalendarEvent}>
              Download .ics
            </button>
            <a href={googleCalendarUrl} target="_blank" rel="noreferrer" class="inline-flex rounded-full border border-white/35 px-6 py-3 font-semibold text-white transition hover:bg-white/10">
              Google Calendar
            </a>
          </div>
          <p class="ui-font mt-5 text-sm leading-7 text-amber-50/85">
            The event is prefilled for 21 September 2026 at Metsalu Manor, starting at 14:00 Tallinn time.
          </p>
        </div>
      </div>
    </section>
  </section>
</main>

<style lang="postcss">
  @media (prefers-reduced-motion: no-preference) {
    :global(html) {
      scroll-behavior: smooth;
    }
  }

  :global(body) {
    background:
      radial-gradient(circle at top left, rgba(244, 114, 182, 0.14), transparent 28%),
      radial-gradient(circle at top right, rgba(245, 158, 11, 0.16), transparent 30%),
      linear-gradient(180deg, #f8f4ef 0%, #fffaf5 45%, #f7efe7 100%);
  }

  .page-shell {
    position: relative;
    overflow: hidden;
    font-family: 'Inter', sans-serif;
  }

  .page-glow {
    position: fixed;
    top: -8rem;
    z-index: 0;
    height: 24rem;
    width: 24rem;
    border-radius: 9999px;
    filter: blur(80px);
    opacity: 0.45;
    pointer-events: none;
  }

  .page-glow-left {
    left: -6rem;
    background: rgba(251, 191, 36, 0.35);
  }

  .page-glow-right {
    right: -8rem;
    background: rgba(244, 114, 182, 0.24);
  }

  .page-shell :global(h1),
  .page-shell :global(h2),
  .script-heading {
    font-family: 'Rouge Script', cursive;
    font-weight: 400;
    line-height: 0.95;
  }

  .ui-font {
    font-family: 'Inter', sans-serif;
  }

  .gallery-card {
    display: flex;
    min-height: 14rem;
    align-items: end;
    border-radius: 1.75rem;
    padding: 1.5rem;
    font-family: 'Manrope', sans-serif;
    font-size: 0.95rem;
    font-weight: 600;
    color: #fff8f1;
    background:
      linear-gradient(180deg, rgba(255, 255, 255, 0) 15%, rgba(59, 47, 47, 0.82) 100%),
      linear-gradient(135deg, #ddb892 0%, #b08968 48%, #7f5539 100%);
    box-shadow: 0 18px 42px rgba(93, 63, 46, 0.16);
  }

  .hero-parallax-layer {
    will-change: transform;
  }

  .gallery-tall {
    min-height: 20rem;
  }

  .gallery-wide {
    min-height: 10rem;
  }
</style>
