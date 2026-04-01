<script lang="ts">
  const displayYear = 2026
  const displayMonthIndex = 7
  const weddingDay = 8

  const firstDayOfMonth = new Date(displayYear, displayMonthIndex, 1)
  const firstWeekdayIndex = (firstDayOfMonth.getDay() + 6) % 7
  const daysInMonth = new Date(displayYear, displayMonthIndex + 1, 0).getDate()
  const dayCells = Array.from({length: 42}, (_, index) => {
    const dayNumber = index - firstWeekdayIndex + 1

    if (dayNumber <= 0 || dayNumber > daysInMonth) {
      return null
    }

    return {
      day: dayNumber,
      isWeddingDay: dayNumber === weddingDay
    }
  })
</script>

<div class="max-w-[25rem] shrink-0">
  <p class="mb-4 text-center text-[0.82rem] font-semibold uppercase tracking-[0.18em] text-[#8a6f62]">August 2026</p>
  <div class="grid grid-cols-7" role="grid" aria-label="August 2026 calendar">
    {#each dayCells as cell}
      <div
        class="relative flex aspect-square items-center justify-center p-3 text-[0.8rem] font-medium leading-none"
        role="gridcell"
        aria-label={cell ? cell.isWeddingDay ? `August ${cell.day}, wedding day` : `August ${cell.day}` : undefined}
      >
        {#if cell?.isWeddingDay}
          <svg
            aria-hidden="true"
            xmlns="http://www.w3.org/2000/svg"
            width="32"
            height="32"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            stroke-width="1.5"
            stroke-linecap="round"
            stroke-linejoin="round"
            class="pointer-events-none absolute left-1/2 top-1/2 h-[2rem] w-[2rem] pt-0.5 -translate-x-1/2 -translate-y-1/2 text-[#cc3344] drop-shadow-[0_8px_16px_rgba(204,51,68,0.18)]"
          >
            <path d="M19.5 12.572l-7.5 7.428l-7.5 -7.428a5 5 0 1 1 7.5 -6.566a5 5 0 1 1 7.5 6.572" />
          </svg>
        {/if}

        <span class={`relative z-[1] ${cell?.isWeddingDay ? 'font-semibold text-[#cc3344]' : 'text-[#3f342e]'}`}>
          {cell?.day ?? ''}
        </span>
      </div>
    {/each}
  </div>
</div>
