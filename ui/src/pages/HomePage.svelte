<script lang="ts">
  import {navigate, t} from 'src/i18n'
  import Button from 'src/components/Button.svelte'
</script>

<svelte:head>
  <title>{t.title}</title>
</svelte:head>

<div class="min-h-screen flex items-center justify-center bg-gray-50">
  <Button color="primary" size="lg" onclick={() => navigate('not-wedding')}>
    Not Wedding
  </Button>
</div>
