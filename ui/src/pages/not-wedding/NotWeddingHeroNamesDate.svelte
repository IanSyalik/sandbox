<script lang="ts">
  export let containerClass = ''
  export let contentClass = ''
</script>

<div class={`text-center ${containerClass}`.trim()}>
  <div class={`relative m-0 flex items-center justify-center text-nw-900 ${contentClass}`.trim()}>
    <h1 class="nw-wordmark-text nw-font-hero-name">Jaan Jana</h1>
    <h1 class="nw-wordmark-text nw-font-hero-name nw-font-hero-ampersand absolute left-1/2 top-1/2 ml-3 -translate-x-1/2 -translate-y-1/2 opacity-40 lg:ml-4 !text-[5rem] lg:!text-[8rem]">&</h1>
  </div>
</div>
