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

<div class="calendar-card">
  <p class="calendar-label">August 2026</p>
  <div class="calendar-grid" role="grid" aria-label="August 2026 calendar">
    {#each dayCells as cell}
      <div
        class="calendar-cell"
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
            class="calendar-heart"
          >
            <path d="M19.5 12.572l-7.5 7.428l-7.5 -7.428a5 5 0 1 1 7.5 -6.566a5 5 0 1 1 7.5 6.572" />
          </svg>
        {/if}

        <span class={`calendar-day ${cell?.isWeddingDay ? 'calendar-day--selected' : ''}`.trim()}>
          {cell?.day ?? ''}
        </span>
      </div>
    {/each}
  </div>
</div>

<style lang="postcss">
  @reference "./../../global.css";

  .calendar-card {
    @apply max-w-[25rem] shrink-0;
  }

  .calendar-label {
    @apply mb-4 text-center text-[0.82rem] font-semibold uppercase tracking-[0.18em] text-nw-700;
  }

  .calendar-grid {
    @apply grid grid-cols-7;
  }

  .calendar-cell {
    @apply relative flex aspect-square items-center justify-center p-3 text-[0.8rem] font-medium leading-none;
  }

  .calendar-heart {
    @apply pointer-events-none absolute left-1/2 top-1/2 h-[2rem] w-[2rem] -translate-x-1/2 -translate-y-1/2 pt-0.5 text-red-500;
    filter: drop-shadow(0 8px 16px color-mix(in srgb, var(--color-red-500) 18%, transparent));
  }

  .calendar-day {
    @apply relative z-[1] text-nw-800;
  }

  .calendar-day--selected {
    @apply font-semibold text-red-500;
  }
</style>
