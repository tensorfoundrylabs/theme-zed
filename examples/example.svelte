<script lang="ts">
  import { onMount } from 'svelte';

  type Method = 'GET' | 'POST';

  interface RouteInfo {
    path: string;
    description: string;
    method: Method;
    active?: boolean;
  }

  export let title = 'Proxy routes';
  export let routes: RouteInfo[] = [];

  let query = '';
  let mounted = false;

  $: filteredRoutes = routes.filter((route) =>
    route.path.toLowerCase().includes(query.toLowerCase())
  );

  onMount(() => {
    mounted = true;
    return () => (mounted = false);
  });

  function selectRoute(route: RouteInfo): void {
    routes = routes.map((candidate) => ({
      ...candidate,
      active: candidate.path === route.path
    }));
  }
</script>

<svelte:head>
  <title>{title}</title>
</svelte:head>

<section class:mounted aria-labelledby="route-heading">
  <header>
    <h1 id="route-heading">{title}</h1>
    <input bind:value={query} placeholder="Filter routes…" />
  </header>

  {#if filteredRoutes.length > 0}
    <ul>
      {#each filteredRoutes as route (route.path)}
        <li class:active={route.active}>
          <button type="button" on:click={() => selectRoute(route)}>
            <strong>{route.method}</strong>
            <code>{route.path}</code>
            <span>{route.description}</span>
          </button>
        </li>
      {/each}
    </ul>
  {:else}
    <p class="empty">No matching routes.</p>
  {/if}
</section>

<style>
  section {
    --accent: #ff7a00;
    padding: 1rem;
  }

  li.active {
    border-inline-start: 0.2rem solid var(--accent);
  }

  .empty {
    opacity: 0.7;
    font-style: italic;
  }
</style>
