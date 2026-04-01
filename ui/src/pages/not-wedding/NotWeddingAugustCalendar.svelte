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
  const daysInPreviousMonth = new Date(displayYear, displayMonthIndex, 0).getDate()
  const dayCells = Array.from({length: 42}, (_, index) => {
    const dayNumber = index - firstWeekdayIndex + 1

    if (dayNumber <= 0) {
      return {
        day: daysInPreviousMonth + dayNumber,
        monthName: monthNames[(displayMonthIndex + 11) % 12],
        isCurrentMonth: false,
        isWeddingDay: false
      }
    }

    if (dayNumber > daysInMonth) {
      return {
        day: dayNumber - daysInMonth,
        monthName: monthNames[(displayMonthIndex + 1) % 12],
        isCurrentMonth: false,
        isWeddingDay: false
      }
    }

    return {
      day: dayNumber,
      monthName: monthNames[displayMonthIndex],
      isCurrentMonth: true,
      isWeddingDay: dayNumber === weddingDay
    }
  })
</script>

<div class="w-full max-w-[25rem] shrink-0 rounded-[2rem] border border-[rgba(96,78,66,0.16)] bg-[rgba(255,253,249,0.72)] p-5 shadow-[0_18px_45px_rgba(68,49,37,0.08)] backdrop-blur-[8px]">
  <p class="mb-4 text-center text-[0.82rem] font-semibold uppercase tracking-[0.18em] text-[#8a6f62]">{monthName}</p>

  <div class="grid grid-cols-7 gap-1" role="grid" aria-label="August 2026 calendar">
    {#each dayCells as cell}
      <div
        class={`flex aspect-square items-center justify-center rounded-[1rem] border text-[0.8rem] font-medium leading-none ${
          cell.isWeddingDay
            ? 'border-[#261f1b] bg-[#261f1b] text-[#fffdf9] shadow-[0_10px_24px_rgba(38,31,27,0.18)] text-[1rem]'
            : cell.isCurrentMonth
              ? 'border-[rgba(96,78,66,0.1)] bg-[rgba(255,255,255,0.68)] text-[#3f342e]'
              : 'border-[rgba(96,78,66,0.06)] bg-[rgba(96,78,66,0.035)] text-[rgba(63,52,46,0.42)]'
        }`}
        role="gridcell"
        aria-label={cell.isWeddingDay ? `${cell.monthName} ${cell.day}, wedding day` : `${cell.monthName} ${cell.day}`}
      >
        {cell.day}
      </div>
    {/each}
  </div>
</div>
