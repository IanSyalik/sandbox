<script lang="ts">
  import locationPhoto from './wedd graphics.webp'
</script>

<section
  id="location"
  class="relative overflow-hidden scroll-mt-24 border-t border-[color-mix(in_srgb,var(--color-nw-800)_16%,transparent)] sm:py-20"
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
  <div class="relative mx-auto flex min-h-[50rem] w-full max-w-[1000px] items-end sm:items-center justify-center">

    <div
      class="w-full max-w-none sm:rounded-[1.75rem] border px-5 py-6 sm:px-8 sm:py-8 md:px-10 text-center backdrop-blur-[10px] sm:max-w-[36rem]"
      style="background: color-mix(in srgb, var(--color-nw-50) 74%, transparent);"
    >
      <h2 class="mb-4 font-['Rouge_Script'] text-[3.1rem] leading-[0.92] text-nw-800 sm:mb-5 sm:text-[4.8rem]">
        Location</h2>
      <p class="mb-4 text-[1rem] leading-[1.8] text-nw-800 sm:mb-6">
        Мы выбрали уютное и атмосферное место, где сможем провести этот день в тёплой и близкой компании.
      </p>
      <p class="m-0">
        <a
          href="https://maps.google.com/?q=Yayaki+House,+Narva+mnt+7,+Tallinn"
          target="_blank"
          rel="noreferrer"
          class="group inline-flex items-center gap-3 border-b border-[color-mix(in_srgb,var(--color-nw-900)_28%,transparent)] pb-1 text-[1.02rem] font-semibold text-nw-900 transition-all duration-200 hover:border-nw-700 hover:text-nw-700 focus-visible:border-nw-700 focus-visible:text-nw-700"
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
