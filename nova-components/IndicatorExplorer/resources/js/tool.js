Nova.booting((Vue, router, store) => {
  router.addRoutes([
    {
      name: 'indicator-explorer',
      path: '/indicator-explorer',
      component: require('./components/Tool'),
    },
  ])
})
