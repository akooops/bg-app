Nova.booting((Vue, router, store) => {
  router.addRoutes([
    {
      name: 'indicator-updater',
      path: '/indicator-updater',
      component: require('./components/Tool'),
    },
  ])
})
