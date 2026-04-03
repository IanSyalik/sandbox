<script lang="ts">
  import locationPhoto from './wedd graphics.webp'
</script>

<section
  id="location"
  class="nw-section relative overflow-hidden sm:py-20 p-0"
  style={`background-image:
    linear-gradient(
      180deg,
      color-mix(in srgb, var(--color-nw-50) 22%, transparent) 0%,
      color-mix(in srgb, var(--color-nw-50) 10%, transparent) 25%,
      color-mix(in srgb, var(--color-nw-900) 26%, transparent) 100%
    ),
    url(${locationPhoto});
    background-position: 50% 50%;
    background-size: cover;`}
>
  <div class="sm:nw-page-inner relative flex min-h-[50rem] items-end justify-center sm:items-center">

    <div
      class="nw-glass-card w-full max-w-none px-5 py-6 text-center sm:max-w-[36rem] sm:rounded-[1.75rem] sm:px-8 sm:py-8 md:px-10"
    >
      <h2 class="nw-section-title sm:mb-5 sm:text-[4.8rem]">
        Location</h2>
      <p class="nw-body-text mb-4 sm:mb-6">
        Мы выбрали уютное и атмосферное место, где сможем провести этот день в тёплой и близкой компании.
      </p>
      <p class="m-0">
        <a
          href="https://maps.google.com/?q=Yayaki+House,+Narva+mnt+7,+Tallinn"
          target="_blank"
          rel="noreferrer"
          class="nw-font-link group inline-flex items-center gap-3 border-b border-[color-mix(in_srgb,var(--color-nw-900)_28%,transparent)] pb-1 text-nw-900 transition-all duration-200 hover:border-nw-700 hover:text-nw-700 focus-visible:border-nw-700 focus-visible:text-nw-700"
        >
          <span>Yayaki House, Narva mnt 7, 2 этаж</span>
          <span aria-hidden="true" class="text-[1.05rem] leading-none transition-transform duration-200 group-hover:translate-x-0.5 group-focus-visible:translate-x-0.5">
            ↗
          </span>
        </a>
      </p>
    </div>
  </div>
</section>
