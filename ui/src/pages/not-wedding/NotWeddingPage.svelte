<script lang="ts">
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
</script>

<svelte:head>
  <title>Wedding One Pager</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Rouge+Script&display=swap" rel="stylesheet">
</svelte:head>

<main id="main" tabindex="-1">
  <nav class="page-nav">
    <div class="section-inner nav-inner">
      <a href="#location">Локация</a>
      <a href="#dress-code">Дресс-код</a>
      <a href="#day">Свадебный день</a>
      <a href="#love">Пожелания</a>
    </div>
  </nav>

  <section class="page-section hero-section">
    <div class="section-inner">
      <div class="text-center mb-6">
      <h1>Jaan & Jana</h1>
      <h3 class="eyebrow">Save the Date 08.08.2026</h3>
      </div>
      <div class="flex gap-4">
      <div class="flex-1">
        <p>Мы будем счастливы разделить с вами этот день.</p>
        <p>
          Дорогие гости, совсем скоро наступит день, который станет началом нашей новой главы — нашей семьи.
          Мы будем счастливы видеть вас рядом, разделить эмоции, смех и любовь этого особенного дня.
        </p>
        <p class="text-links">
          <button type="button" class="button-link" on:click={downloadCalendarEvent}>Добавить в календарь</button>
          <a href="#day" class="button-link button-link-secondary">Смотреть тайминг</a>
        </p>
      </div>
      <div class="flex items-center justify-center p-4 border rounded-lg">
        <p class="placeholder-note">Календарь с фото и отмеченной датой 8.08</p>
      </div>
      </div>
    </div>
  </section>

  <section id="location" class="page-section scroll-mt-28">
      <div class="section-inner">
      <h2>Location</h2>
      <p class="section-label">Yayaki House</p>
      <p class="section-label">Narva mnt 7, 2 этаж</p>
      <p>
        Мы выбрали уютное и атмосферное место, где сможем провести этот день в тёплой и близкой компании.
      </p>
      <p class="quote">Where there is love, there is home.</p>
    </div>
  </section>

  <section id="dress-code" class="page-section scroll-mt-28">
      <div class="section-inner">
      <h2>Dress Code</h2>
      <p>
        Мы будем рады видеть девушек в нарядах в нежных пастельных оттенках, а мужчин в классике.
      </p>
      <p class="placeholder-note">Здесь будет палитра цветов</p>
      <p class="quote">Elegance is when love meets style.</p>
    </div>
  </section>

  <section id="day" class="page-section scroll-mt-28">
      <div class="section-inner">
      <h2>Wedding Day</h2>
      <p class="section-label">14:30 — Церемония в ЗАГСе Таллинна</p>
      <p>Тот самый момент, когда мы скажем друг другу «да»</p>

      <p class="section-label">15:00 — Фотографии</p>
      <p>Сохраним первые мгновения этого дня — искренние улыбки, объятия и эмоции</p>

      <p class="section-label">16:00 — Начало праздника</p>
      <p>Соберёмся вместе, чтобы поздравить, обнять и разделить радость этого дня</p>

      <p class="section-label">18:00 — Вечер и танцы</p>
      <p>Время наслаждаться атмосферой, музыкой и друг другом</p>

      <p class="section-label">21:00 — Торт-сюрприз</p>
      <p>Сладкое завершение этого особенного дня.</p>

      <p class="quote">Forever starts here.</p>
    </div>
  </section>

  <section id="love" class="page-section scroll-mt-28">
      <div class="section-inner">
      <h2>With Love</h2>
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
  </section>

  <section id="calendar" class="page-section scroll-mt-28">
      <div class="section-inner">
      <h2>Calendar</h2>
      <p>Добавьте этот день в календарь, чтобы сохранить дату нашего праздника.</p>
      <p class="text-links">
        <button type="button" class="button-link" on:click={downloadCalendarEvent}>Добавить в календарь</button>
        <a href={googleCalendarUrl} target="_blank" rel="noreferrer" class="button-link">Открыть Google Календарь</a>
      </p>
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
    background: #fffdf8;
  }

  .section-inner {
    width: min(100%, 1000px);
    margin: 0 auto;
    padding: 0 1.5rem;
  }

  .nav-inner {
    display: flex;
    flex-wrap: wrap;
    gap: 1rem;
  }

  .hero-section {
    padding-top: 2.5rem;
  }

  .page-nav {
    padding: 1rem 0;
    font-size: 0.95rem;
    position: sticky;
    top: 0;
    z-index: 10;
    background: #fffdf8;
    border-bottom: 1px solid #d6d3d1;
  }

  .page-nav a {
    color: inherit;
    text-decoration: underline;
    text-underline-offset: 0.18em;
  }

  .text-links a,
  .text-links button {
    color: inherit;
    background: none;
    border: 0;
    padding: 0;
    font: inherit;
    cursor: pointer;
    text-decoration: none;
  }

  h1,
  h2, h3 {
    font-family: 'Rouge Script', cursive;
    font-weight: 400;
    line-height: 0.95;
    margin: 0 0 1rem;
    color: #44403c;
  }

  h1 {
    font-size: clamp(4.5rem, 11vw, 7rem);
  }

  h2 {
    font-size: clamp(3rem, 7vw, 4.8rem);
  }

  h3 {
    font-size: clamp(2rem, 4.5vw, 3rem);
  }

  .page-section {
    background: #ffffff;
    border: 1px solid #d6d3d1;
    padding: 1.5rem 0;
  }

  .page-section + .page-section {
    margin-top: -1px;
  }

  p {
    margin: 0 0 1rem;
    font-size: 1rem;
    line-height: 1.75;
  }

  .section-label {
    margin-bottom: 0.35rem;
    font-weight: 700;
  }

  .quote {
    font-style: italic;
  }

  .placeholder-note {
    color: #78716c;
  }

  .text-links {
    display: flex;
    flex-wrap: wrap;
    gap: 1rem;
  }

  button.button-link,
  a.button-link {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    min-height: 2.75rem;
    padding: 0.7rem 1.25rem;
    border: 1px solid black;
    border-radius: 9999px;
    background: transparent;
    color: #1c1917 !important;
    font-size: 0.95rem;
    font-weight: 600;
    line-height: 1;
    transition: background-color 120ms ease, color 120ms ease, border-color 120ms ease;
  }

  .button-link:hover {
    background: rgba(28, 25, 23, 0.06);
    border-color: #44403c;
  }

</style>
