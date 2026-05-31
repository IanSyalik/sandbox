<script lang="ts">
  import {navigate, t} from 'src/i18n'
  import Button from 'src/components/Button.svelte'
</script>

<svelte:head>
  <title>{t.title}</title>
</svelte:head>

<div class="min-h-screen flex items-center justify-center bg-gray-50">
  <div class="flex flex-col sm:flex-row gap-4">
    <Button color="primary" size="lg" onclick={() => navigate('not-wedding')}>
      Not Wedding
    </Button>
    <Button color="primary" size="lg" onclick={() => navigate('rabbit')}>
      Rabbit
    </Button>
  </div>
</div>
