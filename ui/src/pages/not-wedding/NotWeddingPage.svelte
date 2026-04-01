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
  import NotWeddingAugustCalendar from './NotWeddingAugustCalendar.svelte'
  import NotWeddingHeroNamesDate from './NotWeddingHeroNamesDate.svelte'

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
  const innerClass = 'mx-auto w-full max-w-[1000px] px-6'
  const sectionClass = 'scroll-mt-24 border-t border-[rgba(96,78,66,0.16)] bg-[#fffdf9] py-[clamp(3rem,7vw,5rem)]'
  const navLinkClass = 'text-[0.92rem] font-medium tracking-[0.02em] text-[#4d4038] transition-colors duration-150 hover:text-[#261f1b] focus-visible:text-[#261f1b]'
  const displayH2Class = 'mb-6 font-[\'Rouge_Script\'] text-[clamp(3.1rem,7vw,4.8rem)] leading-[0.92] text-[#4d4038]'
  const bodyTextClass = ' leading-[1.8] text-[#3f342e]'
  const buttonBaseClass = 'inline-flex min-h-[2.9rem] items-center justify-center rounded-full border px-5 py-3 text-[0.95rem] font-semibold leading-none transition-all duration-150'
  const primaryButtonClass = `${buttonBaseClass} border-[#261f1b] bg-[#261f1b] text-[#fffdf9] hover:-translate-y-px hover:border-[#3b302a] hover:bg-[#3b302a] focus-visible:-translate-y-px focus-visible:border-[#3b302a] focus-visible:bg-[#3b302a]`
  const secondaryButtonClass = `${buttonBaseClass} border-[#261f1b] bg-transparent text-[#261f1b] hover:-translate-y-px hover:bg-[rgba(38,31,27,0.06)] focus-visible:-translate-y-px focus-visible:bg-[rgba(38,31,27,0.06)]`
  const locationLinkClass = 'inline-flex items-center gap-3 border-b border-[rgba(38,31,27,0.24)] pb-1 text-[1.02rem] font-semibold text-[#261f1b] transition-all duration-200 hover:border-[#8a6f62] hover:text-[#8a6f62] focus-visible:border-[#8a6f62] focus-visible:text-[#8a6f62]'
  const locationSlides = [
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
  const heroPanelImages = [heroPanelPhoto1, heroPanelPhoto2, heroPanelPhoto3]
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

  <section class="relative min-h-[calc(100svh-4.5rem)] overflow-hidden bg-[linear-gradient(180deg,#fcfaf6_0%,#f4ece1_100%)]">
    <div class="pointer-events-none absolute inset-x-0 top-[-18%] mx-auto h-[36rem] w-[min(92vw,68rem)] rounded-full bg-[radial-gradient(circle,rgba(214,196,180,0.42)_0%,rgba(214,196,180,0.14)_42%,transparent_72%)] blur-3xl"></div>
    <NotWeddingHeroNamesDate/>
    <div class="mx-auto w-full max-w-[1200px] px-6 relative flex min-h-[calc(100svh-9rem)] flex-col justify-center">
      <div class="grid gap-6 grid-cols-5 w-full">
        <div class="col-span-2">
          <h1 class="text-[8rem] leading-[1.1] font-extrabold whitespace-pre-line uppercase">
            Save
            the
            Date
          </h1>
        </div>
        <div class="col-span-3 relative flex gap-6 flex-1 w-full">
          {#each heroPanelImages as heroPanelImage}
            <div
              class="border border-[rgba(96,78,66,0.16)] flex flex-1 w-full overflow-hidden rounded-t-full rounded-b-full bg-cover bg-center bg-no-repeat shadow-[0_18px_45px_rgba(68,49,37,0.08)]"
              style={`background-image: linear-gradient(180deg, rgba(255,253,249,0.08) 0%, rgba(255,253,249,0.02) 40%, rgba(38,31,27,0.08) 100%), url(${heroPanelImage});`}
            ></div>
          {/each}
        </div>

      </div>

      <div class="flex items-center justify-between flex-1">
        <div class="min-w-0 max-w-[40rem] flex-1">
          <h3 class="mb-4 text-[#261f1b]">Мы будем счастливы разделить с вами
            этот день.</h3>
          <p class="mb-6  text-[1rem] leading-[1.8] text-[#3f342e]">
            Дорогие гости, совсем скоро наступит день, который станет началом нашей новой главы — нашей семьи.
            Мы будем счастливы видеть вас рядом, разделить эмоции, смех и любовь этого особенного дня.
          </p>
          <div class="flex flex-wrap items-center gap-4">
            <button type="button" class={primaryButtonClass} on:click={downloadCalendarEvent}>Добавить в календарь
            </button>
            <a href="#day" class={secondaryButtonClass}>Примерная программа</a>
          </div>
        </div>
        <NotWeddingAugustCalendar/>
      </div>
    </div>
  </section>

  <section id="location" class={sectionClass}>
    <div class={`${innerClass} grid gap-10 md:grid-cols-[minmax(0,0.92fr)_minmax(0,1.18fr)] md:items-center md:gap-[clamp(2.5rem,6vw,5.5rem)]`}>
      <div class="max-w-[29rem]">
        <h2 class={`${displayH2Class} mb-5`}>Location</h2>
        <p class={`${bodyTextClass} mb-6 max-w-[24rem]`}>
          Мы выбрали уютное и атмосферное место, где сможем провести этот день в тёплой и близкой компании.
        </p>
        <p class="m-0">
          <a
            href="https://maps.google.com/?q=Yayaki+House,+Narva+mnt+7,+Tallinn"
            target="_blank"
            rel="noreferrer"
            class={`${locationLinkClass} group`}
          >
            <span>Yayaki House, Narva mnt 7, 2 этаж</span>
            <span aria-hidden="true" class="text-[1.05rem] leading-none transition-transform duration-200 group-hover:translate-x-0.5">
              ↗
            </span>
          </a>
        </p>
      </div>

      <figure class="location-media-shell group/location-media m-0">
        <div
          class="relative h-[20rem] overflow-hidden rounded-[1.85rem] border border-[rgba(96,78,66,0.14)] bg-[#f4ece1] shadow-[0_24px_70px_rgba(68,49,37,0.12)] sm:h-[24rem] lg:h-[28rem]"
        >
          <div class="pointer-events-none absolute inset-[0.85rem] z-[1] rounded-[1.2rem] border border-[rgba(255,255,255,0.46)]"></div>
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
          <div class="pointer-events-none absolute inset-0 bg-[linear-gradient(180deg,rgba(255,253,249,0.04)_0%,rgba(255,253,249,0)_34%,rgba(38,31,27,0.04)_100%)]"></div>
        </div>
        <figcaption class="sr-only">Фотографии площадки Yayaki House, где пройдет свадебный вечер.</figcaption>
      </figure>
    </div>
  </section>

  <section id="dress-code" class={sectionClass}>
    <div class={`${innerClass} flex flex-col items-center gap-8 text-center`}>
      <div class="w-full max-w-[42rem]">
        <h2 class={displayH2Class}>Dress Code</h2>
        <p class={bodyTextClass}>
          Мы будем рады видеть девушек в нарядах в нежных пастельных оттенках, а мужчин в классике.
        </p>
      </div>

      <div class="flex w-full flex-wrap items-center justify-center gap-[0.9rem]" aria-label="Палитра дресс-кода">
        {#each dressCodeSwatches as swatch}
          <span
            aria-hidden="true"
            class="inline-block h-[5.25rem] w-[5.25rem] rounded-full border border-[rgba(96,78,66,0.14)] bg-cover bg-center bg-no-repeat shadow-[inset_0_0_0_1px_rgba(255,255,255,0.25)]"
            style={`background-image: url(${swatch});`}
          ></span>
        {/each}
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
            <p class="m-0 text-[1rem] leading-[1.8] text-[#3f342e]">Тот самый момент, когда мы скажем друг другу
              «да».</p>
          </div>
        </li>
        <li class="grid gap-2 border-t border-[rgba(96,78,66,0.16)] py-5 md:grid-cols-[minmax(5rem,6rem)_minmax(0,1fr)] md:gap-6">
          <p class="m-0 text-[0.9rem] font-bold uppercase tracking-[0.12em] text-[#8a6f62]">15:00</p>
          <div>
            <h3 class="mb-1 text-[1.05rem] font-bold leading-[1.45] text-[#261f1b]">Фотографии</h3>
            <p class="m-0 text-[1rem] leading-[1.8] text-[#3f342e]">Сохраним первые мгновения этого дня — искренние
              улыбки, объятия и эмоции.</p>
          </div>
        </li>
        <li class="grid gap-2 border-t border-[rgba(96,78,66,0.16)] py-5 md:grid-cols-[minmax(5rem,6rem)_minmax(0,1fr)] md:gap-6">
          <p class="m-0 text-[0.9rem] font-bold uppercase tracking-[0.12em] text-[#8a6f62]">16:00</p>
          <div>
            <h3 class="mb-1 text-[1.05rem] font-bold leading-[1.45] text-[#261f1b]">Начало праздника</h3>
            <p class="m-0 text-[1rem] leading-[1.8] text-[#3f342e]">Соберёмся вместе, чтобы поздравить, обнять и
              разделить радость этого дня.</p>
          </div>
        </li>
        <li class="grid gap-2 border-t border-[rgba(96,78,66,0.16)] py-5 md:grid-cols-[minmax(5rem,6rem)_minmax(0,1fr)] md:gap-6">
          <p class="m-0 text-[0.9rem] font-bold uppercase tracking-[0.12em] text-[#8a6f62]">18:00</p>
          <div>
            <h3 class="mb-1 text-[1.05rem] font-bold leading-[1.45] text-[#261f1b]">Вечер и танцы</h3>
            <p class="m-0 text-[1rem] leading-[1.8] text-[#3f342e]">Время наслаждаться атмосферой, музыкой и друг
              другом.</p>
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
        <p class={`${bodyTextClass} m-0`}>Самое главное для нас — это ваше присутствие и разделённая с нами радость
          этого дня.</p>
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
        <a href={googleCalendarUrl} target="_blank" rel="noreferrer" class={secondaryButtonClass}>Открыть Google
          Календарь
        </a>
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
