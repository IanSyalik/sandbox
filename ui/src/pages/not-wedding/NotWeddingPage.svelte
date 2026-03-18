<script lang="ts">
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

<main id="main" tabindex="-1" class="page-shell">
  <section class="page-section">
    <nav class="page-nav">
      <a href="#story">Story</a>
      <a href="#day">Day Plan</a>
      <a href="#details">Details</a>
      <a href="#calendar">Calendar</a>
    </nav>

    <p class="eyebrow">Saturday, 21 September 2026</p>
    <h1>Jaan & Jana</h1>
    <p class="lead">
      A warm, modern one-pager for your wedding site. Use it for the story, the timeline, the venue notes, and one clear calendar action.
    </p>
    <p class="text-links">
      <a href="#calendar" class="button-link">Add To Calendar</a>
      <a href="#day" class="button-link button-link-secondary">View Schedule</a>
    </p>
    <p>Where: Metsalu Manor</p>
    <p>Weekend Mood: Slow morning, golden evening, loud dance floor.</p>
    <p>Dress Code: Garden formal with room to move.</p>
  </section>

  <section id="story" class="page-section scroll-mt-28">
    <p class="eyebrow">Our Story</p>
    <h2>Built for a couple who wants one elegant page instead of five tiny ones.</h2>
    <p>
      Replace the names, date, and venue first. Then swap in your own story, add your meal and travel details, and connect the calendar section to the final event information.
    </p>
    <p>
      This template now leans entirely on typography: the layout is quiet, direct, and easy to adapt.
    </p>
  </section>

  <section id="day" class="page-section scroll-mt-28">
    <p class="eyebrow">Day Plan</p>
    <h2>A simple rhythm for the whole celebration.</h2>
    <p>Keep the structure clean. Guests should understand the flow in ten seconds.</p>

    {#each schedule as item}
      <h3>{item.time} - {item.title}</h3>
      <p>{item.details}</p>
    {/each}
  </section>

  <section id="details" class="page-section scroll-mt-28">
    <p class="eyebrow">Need To Know</p>
    <h2>Everything important in one scroll.</h2>
    <p>
      This section works well for venue notes, accommodation, transport, or anything guests would normally miss in a long email.
    </p>

    {#each details as item}
      <h3>{item.eyebrow}: {item.title}</h3>
      <p>{item.text}</p>
    {/each}
  </section>

  <section id="calendar" class="page-section scroll-mt-28">
    <p class="eyebrow">Save The Date</p>
    <h2>Add the wedding to your calendar in one click.</h2>
    <p>Replace the event details if needed, then let guests save the full day straight from the page.</p>
    <p class="text-links">
      <button type="button" class="button-link" on:click={downloadCalendarEvent}>Download .ics</button>
      <a href={googleCalendarUrl} target="_blank" rel="noreferrer" class="button-link">Google Calendar</a>
    </p>
    <p>The event is prefilled for 21 September 2026 at Metsalu Manor, starting at 14:00 Tallinn time.</p>
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

  .page-shell {
    max-width: 52rem;
    margin: 0 auto;
    padding: 2rem 1.5rem 4rem;
    color: #1c1917;
    font-family: 'Inter', sans-serif;
  }

  .page-section + .page-section {
    margin-top: 4rem;
  }

  .page-nav {
    display: flex;
    flex-wrap: wrap;
    gap: 1rem;
    margin-bottom: 3rem;
    font-size: 0.95rem;
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

  .eyebrow {
    margin-bottom: 0.75rem;
    font-size: 0.8rem;
    font-weight: 600;
    letter-spacing: 0.18em;
    text-transform: uppercase;
  }

  h1,
  h2 {
    font-family: 'Rouge Script', cursive;
    font-weight: 400;
    line-height: 0.95;
    margin: 0 0 1rem;
    color: #44403c;
  }

  h1 {
    font-size: clamp(4rem, 10vw, 7rem);
  }

  h2 {
    font-size: clamp(2.8rem, 8vw, 4.5rem);
  }

  h3 {
    margin: 2rem 0 0.35rem;
    font-size: 1rem;
    font-weight: 700;
    line-height: 1.5;
  }

  p {
    margin: 0 0 1rem;
    font-size: 1rem;
    line-height: 1.75;
  }

  .lead {
    font-size: 1.125rem;
    max-width: 40rem;
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
