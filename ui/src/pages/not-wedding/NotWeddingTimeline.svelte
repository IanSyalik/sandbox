<script lang="ts">
  import timelineIcon1 from './1day.svg?raw'
  import timelineIcon2 from './2day.svg?raw'
  import timelineIcon3 from './3day.svg?raw'
  import timelineIcon4 from './4day.svg?raw'
  import timelineIcon5 from './5day.svg?raw'

  type TimelineItem = {
    icon: string,
    time: string,
    title: string,
    description: string,
  }

  const timelineItems: TimelineItem[] = [
    {
      icon: timelineIcon1,
      time: '14:30',
      title: 'Церемония в ЗАГСе Таллинна',
      description: 'Тот самый момент, когда мы скажем друг другу «да».'
    },
    {
      icon: timelineIcon2,
      time: '15:00',
      title: 'Фотографии',
      description: 'Сохраним первые мгновения этого дня — искренние улыбки, объятия и эмоции.'
    },
    {
      icon: timelineIcon3,
      time: '16:00',
      title: 'Начало праздника',
      description: 'Соберёмся вместе, чтобы поздравить, обнять и разделить радость этого дня.'
    },
    {
      icon: timelineIcon4,
      time: '18:00',
      title: 'Вечер и танцы',
      description: 'Время наслаждаться атмосферой, музыкой и друг другом.'
    },
    {
      icon: timelineIcon5,
      time: '21:00',
      title: 'Торт',
      description: 'Сладкий момент нашего вечера.'
    }
  ]
</script>

<section id="day" class="nw-section">
  <div class="nw-page-inner flex flex-col justify-center gap-6 lg:gap-10 lg:flex-row">
    <h2 class="nw-section-title mb-0 text-center text-nowrap">
      Wedding Day
    </h2>

    <div class="flex flex-col timeline">
      {#each timelineItems as item, index}
        <div class="flex gap-4">

          <div class="pt-2">
            <div class="flex h-16 w-16 text-nw-600 icon-wrapper">
              {@html item.icon}
            </div>
          </div>

          <div class="flex flex-1 w-full gap-4">

            <div class="pt-2.5 relative">
              <div class="relative z-[1] block h-3 w-3 shrink-0 rounded-full bg-nw-700"></div>
              <div class="w-px absolute left-1/2 bg-nw-500 h-full time-line-border" class:hidden={index === timelineItems.length - 1}></div>
            </div>

            <div class="pt-0.5 pb-5">
              <div class="nw-font-timeline-time text-nw-700">{item.time}</div>
              <div class="nw-font-timeline-title mb-0.5">{item.title}</div>
              <div>{item.description}</div>
            </div>

          </div>

        </div>
      {/each}
    </div>
  </div>
</section>

<style lang="postcss">
  @reference "./../../global.css";

  .icon-wrapper :global(svg) {
    @apply h-full w-full;
    display: block;
  }
</style>
