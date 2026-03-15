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
</script>

<svelte:head>
  <title>Wedding One Pager</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
  <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">
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
        <a href="#rsvp">RSVP</a>
      </div>
    </nav>

    <section class="relative overflow-hidden rounded-[2rem] border border-white/70 bg-white/80 px-6 py-8 shadow-[0_40px_120px_rgba(91,63,44,0.12)] backdrop-blur sm:px-10 sm:py-12 lg:px-14 lg:py-16">
      <div class="absolute inset-x-0 top-0 h-40 bg-[radial-gradient(circle_at_top,_rgba(250,204,21,0.22),_transparent_55%)]"></div>
      <div class="grid gap-10 lg:grid-cols-[1.15fr_0.85fr] lg:items-end">
        <div class="relative z-10">
          <p class="ui-font text-sm font-semibold uppercase tracking-[0.35em] text-rose-500">Saturday, 21 September 2026</p>
          <h1 class="display-font mt-5 text-6xl leading-none sm:text-7xl lg:text-[6.5rem]">Anna<br>& Leo</h1>
          <p class="ui-font mt-6 max-w-xl text-lg leading-8 text-stone-600">
            A warm, modern one-pager for your wedding site. Use it for the story, the timeline, the venue notes, and one clear RSVP action.
          </p>

          <div class="ui-font mt-8 flex flex-wrap gap-4">
            <a href="#rsvp" class="rounded-full bg-stone-900 px-6 py-3 font-semibold text-white transition hover:bg-stone-700">RSVP Now</a>
            <a href="#day" class="rounded-full border border-stone-300 px-6 py-3 font-semibold text-stone-700 transition hover:border-stone-900 hover:text-stone-900">View Schedule</a>
          </div>
        </div>

        <div class="relative z-10">
          <div class="grid gap-4 sm:grid-cols-3 lg:grid-cols-1">
            <article class="rounded-[1.75rem] bg-stone-900 p-6 text-white">
              <p class="ui-font text-xs uppercase tracking-[0.28em] text-stone-300">Where</p>
              <h2 class="display-font mt-3 text-3xl">Metsalu Manor</h2>
              <p class="ui-font mt-3 text-sm leading-7 text-stone-300">A garden ceremony, candlelit dinner, and a long-table celebration in the countryside.</p>
            </article>
            <article class="rounded-[1.75rem] bg-amber-100 p-6">
              <p class="ui-font text-xs uppercase tracking-[0.28em] text-amber-700">Weekend Mood</p>
              <p class="display-font mt-3 text-3xl">Slow morning, golden evening, loud dance floor.</p>
            </article>
            <article class="rounded-[1.75rem] bg-rose-100 p-6">
              <p class="ui-font text-xs uppercase tracking-[0.28em] text-rose-700">Dress Code</p>
              <p class="display-font mt-3 text-3xl">Garden formal with room to move.</p>
            </article>
          </div>
        </div>
      </div>
    </section>

    <section id="story" class="grid gap-8 py-14 lg:grid-cols-[0.85fr_1.15fr]">
      <div class="rounded-[2rem] bg-[#f5eee6] p-8">
        <p class="ui-font text-xs font-semibold uppercase tracking-[0.3em] text-stone-500">Our Story</p>
        <h2 class="display-font mt-4 text-5xl leading-tight">Built for a couple who wants one elegant page instead of five tiny ones.</h2>
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

    <section id="day" class="rounded-[2rem] bg-stone-900 px-6 py-10 text-white sm:px-10">
      <div class="flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <p class="ui-font text-xs font-semibold uppercase tracking-[0.3em] text-stone-400">Day Plan</p>
          <h2 class="display-font mt-3 text-5xl">A simple rhythm for the whole celebration.</h2>
        </div>
        <p class="ui-font max-w-md text-sm leading-7 text-stone-300">
          Keep the structure clean. Guests should understand the flow in ten seconds.
        </p>
      </div>

      <div class="mt-10 grid gap-4 lg:grid-cols-2">
        {#each schedule as item}
          <article class="rounded-[1.5rem] border border-white/10 bg-white/5 p-6">
            <p class="ui-font text-xs font-semibold uppercase tracking-[0.3em] text-amber-300">{item.time}</p>
            <h3 class="display-font mt-3 text-3xl">{item.title}</h3>
            <p class="ui-font mt-3 text-sm leading-7 text-stone-300">{item.details}</p>
          </article>
        {/each}
      </div>
    </section>

    <section id="details" class="py-14">
      <div class="mb-8 flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <p class="ui-font text-xs font-semibold uppercase tracking-[0.3em] text-stone-500">Need To Know</p>
          <h2 class="display-font mt-3 text-5xl text-stone-900">Everything important in one scroll.</h2>
        </div>
        <p class="ui-font max-w-lg text-sm leading-7 text-stone-600">
          This section works well for venue notes, accommodation, transport, or anything guests would normally miss in a long email.
        </p>
      </div>

      <div class="grid gap-5 lg:grid-cols-3">
        {#each details as item}
          <article class="rounded-[1.75rem] border border-stone-200 bg-white/80 p-7 shadow-sm">
            <p class="ui-font text-xs font-semibold uppercase tracking-[0.28em] text-rose-500">{item.eyebrow}</p>
            <h3 class="display-font mt-3 text-3xl text-stone-900">{item.title}</h3>
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

    <section id="rsvp" class="overflow-hidden rounded-[2rem] bg-[linear-gradient(135deg,#3b2f2f_0%,#6e4d3f_45%,#d18b73_100%)] px-6 py-10 text-white shadow-[0_32px_80px_rgba(92,56,38,0.28)] sm:px-10">
      <div class="grid gap-8 lg:grid-cols-[1.05fr_0.95fr] lg:items-center">
        <div>
          <p class="ui-font text-xs font-semibold uppercase tracking-[0.3em] text-amber-100/80">Final Section</p>
          <h2 class="display-font mt-3 text-5xl">Make the RSVP impossible to miss.</h2>
          <p class="ui-font mt-5 max-w-xl text-base leading-8 text-amber-50/85">
            End the page with one strong action. Add your RSVP link, meal form, or a contact email and you are done.
          </p>
        </div>

        <div class="rounded-[1.75rem] bg-white/12 p-6 backdrop-blur">
          <p class="ui-font text-sm uppercase tracking-[0.28em] text-amber-100/75">Suggested CTA</p>
          <a href="mailto:rsvp@example.com" class="ui-font mt-5 inline-flex rounded-full bg-white px-6 py-3 font-semibold text-stone-900 transition hover:bg-amber-50">
            RSVP by 15 July
          </a>
          <p class="ui-font mt-5 text-sm leading-7 text-amber-50/85">
            Replace this with a real RSVP form, a Google Form, or your wedding planner’s response link.
          </p>
        </div>
      </div>
    </section>
  </section>
</main>

<style lang="postcss">
  :global(body) {
    background:
      radial-gradient(circle at top left, rgba(244, 114, 182, 0.14), transparent 28%),
      radial-gradient(circle at top right, rgba(245, 158, 11, 0.16), transparent 30%),
      linear-gradient(180deg, #f8f4ef 0%, #fffaf5 45%, #f7efe7 100%);
  }

  .page-shell {
    position: relative;
    overflow: hidden;
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

  .display-font {
    font-family: 'Cormorant Garamond', serif;
  }

  .ui-font {
    font-family: 'Manrope', sans-serif;
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

  .gallery-tall {
    min-height: 20rem;
  }

  .gallery-wide {
    min-height: 10rem;
  }
</style>
