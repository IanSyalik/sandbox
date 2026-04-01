<script lang="ts">
  const monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ]
  const displayYear = 2026
  const displayMonthIndex = 7
  const monthName = `${monthNames[displayMonthIndex]} ${displayYear}`
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
  <p class="mb-4 text-center text-[0.82rem] font-semibold uppercase tracking-[0.18em] text-[#8a6f62]">{monthName}</p>
  <div class="grid grid-cols-7" role="grid" aria-label="August 2026 calendar">
    {#each dayCells as cell}
      <div
        class="relative flex aspect-square items-center justify-center p-3 text-[0.8rem] font-medium leading-none"
        role="gridcell"
        aria-label={cell ? cell.isWeddingDay ? `August ${cell.day}, wedding day` : `August ${cell.day}` : undefined}
      >
        {#if cell?.isWeddingDay}
          <span aria-hidden="true" class="heart-selection"></span>
        {/if}

        <span class={`relative z-[1] ${cell?.isWeddingDay ? 'font-semibold text-[#fffdf9]' : 'text-[#3f342e]'}`}>
          {cell?.day ?? ''}
        </span>
      </div>
    {/each}
  </div>
</div>

<style lang="postcss">
  .heart-selection {
    position: absolute;
    left: 50%;
    top: 54%;
    width: 1.65rem;
    height: 1.65rem;
    transform: translate(-50%, -50%) rotate(45deg);
    border-radius: 0.28rem;
    background: #cc3344;
    box-shadow: 0 10px 20px rgba(204, 51, 68, 0.2);
  }

  .heart-selection::before,
  .heart-selection::after {
    content: '';
    position: absolute;
    width: 1.65rem;
    height: 1.65rem;
    border-radius: 9999px;
    background: #cc3344;
  }

  .heart-selection::before {
    left: -0.82rem;
    top: 0;
  }

  .heart-selection::after {
    left: 0;
    top: -0.82rem;
  }
</style>
